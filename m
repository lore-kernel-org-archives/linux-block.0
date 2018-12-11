Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09A4C6783C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843C92084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fdtd1pYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843C92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeLKXhC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:37:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeLKXhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UFF+Hh408CPpQAU18uYhYTpU0TmXqVymdZh/b0o4UH0=; b=Fdtd1pYOQ1+JdK78pwQLHz3RM
        DFIzozjBCI3n7NDh79wl16HB78Oi9hzAdEgEWGzlcn+AtHNfpyM+JHKHpYExM4oZnRGuffz4LdQv6
        Btpzjv1lx0ZEcilp7rFxV1zggNw8wwDF95H423vrnNTTd8oBOjS7E8Eij4v0V+7hpmwalR/6rJ0o5
        KozDqN8y9TxoGuyiCPZ5xJSmzuxDVfcRVRWbGt2q/gShYwL6R9Mx4c/tmA47/Q1g+OcOdZPUNgc1d
        j5WAB4JYKkoEGxhYuZknDcH/TbGhDG2emzR5onEv6hoMVaXuxFxoSgQ8LPNdNyAlkC83aT2ubih1C
        TMDdNkXfg==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWraD-0003uQ-HW; Tue, 11 Dec 2018 23:36:57 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH RFC 2/4] rdma: introduce ib_change_cq_ctx
Date:   Tue, 11 Dec 2018 15:36:49 -0800
Message-Id: <20181211233652.9705-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow cq consumers to modify the cq polling context online. The
consumer might want to allocate the cq with softirq/workqueue polling
context for async (setup time) I/O, and when completed, switch the
polling context to direct polling and get all the interrupts out
of the way.

One example is nvme-rdma driver that hooks into the block layer
infrastructure for a polling queue map for latency sensitive I/O.
Every nvmf queue starts with a connect message that is the slow path
at setup time, and there is no need for polling (it is actually
hurtful). Instead, allocate the polling queue cq with IB_POLL_SOFTIRQ
and switch it to IB_POLL_DIRECT where it makes sense.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/core/cq.c | 102 ++++++++++++++++++++++++-----------
 include/rdma/ib_verbs.h      |   1 +
 2 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index b1e5365ddafa..c820eb954edc 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL(ib_process_cq_direct);
 
 static void ib_cq_completion_direct(struct ib_cq *cq, void *private)
 {
-	WARN_ONCE(1, "got unsolicited completion for CQ 0x%p\n", cq);
+	pr_debug("got unsolicited completion for CQ 0x%p\n", cq);
 }
 
 static int ib_poll_handler(struct irq_poll *iop, int budget)
@@ -120,6 +120,33 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 	queue_work(cq->comp_wq, &cq->work);
 }
 
+static int __ib_cq_set_ctx(struct ib_cq *cq)
+{
+	switch (cq->poll_ctx) {
+	case IB_POLL_DIRECT:
+		cq->comp_handler = ib_cq_completion_direct;
+		break;
+	case IB_POLL_SOFTIRQ:
+		cq->comp_handler = ib_cq_completion_softirq;
+
+		irq_poll_init(&cq->iop, IB_POLL_BUDGET_IRQ, ib_poll_handler);
+		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
+		break;
+	case IB_POLL_WORKQUEUE:
+	case IB_POLL_UNBOUND_WORKQUEUE:
+		cq->comp_handler = ib_cq_completion_workqueue;
+		INIT_WORK(&cq->work, ib_cq_poll_work);
+		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
+		cq->comp_wq = (cq->poll_ctx == IB_POLL_WORKQUEUE) ?
+				ib_comp_wq : ib_comp_unbound_wq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * __ib_alloc_cq - allocate a completion queue
  * @dev:		device to allocate the CQ for
@@ -164,28 +191,9 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 	rdma_restrack_set_task(&cq->res, caller);
 	rdma_restrack_add(&cq->res);
 
-	switch (cq->poll_ctx) {
-	case IB_POLL_DIRECT:
-		cq->comp_handler = ib_cq_completion_direct;
-		break;
-	case IB_POLL_SOFTIRQ:
-		cq->comp_handler = ib_cq_completion_softirq;
-
-		irq_poll_init(&cq->iop, IB_POLL_BUDGET_IRQ, ib_poll_handler);
-		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
-		break;
-	case IB_POLL_WORKQUEUE:
-	case IB_POLL_UNBOUND_WORKQUEUE:
-		cq->comp_handler = ib_cq_completion_workqueue;
-		INIT_WORK(&cq->work, ib_cq_poll_work);
-		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
-		cq->comp_wq = (cq->poll_ctx == IB_POLL_WORKQUEUE) ?
-				ib_comp_wq : ib_comp_unbound_wq;
-		break;
-	default:
-		ret = -EINVAL;
+	ret = __ib_cq_set_ctx(cq);
+	if (ret)
 		goto out_free_wc;
-	}
 
 	return cq;
 
@@ -198,17 +206,8 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 }
 EXPORT_SYMBOL(__ib_alloc_cq);
 
-/**
- * ib_free_cq - free a completion queue
- * @cq:		completion queue to free.
- */
-void ib_free_cq(struct ib_cq *cq)
+static void __ib_cq_clear_ctx(struct ib_cq *cq)
 {
-	int ret;
-
-	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
-		return;
-
 	switch (cq->poll_ctx) {
 	case IB_POLL_DIRECT:
 		break;
@@ -222,6 +221,20 @@ void ib_free_cq(struct ib_cq *cq)
 	default:
 		WARN_ON_ONCE(1);
 	}
+}
+
+/**
+ * ib_free_cq - free a completion queue
+ * @cq:		completion queue to free.
+ */
+void ib_free_cq(struct ib_cq *cq)
+{
+	int ret;
+
+	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
+		return;
+
+	__ib_cq_clear_ctx(cq);
 
 	kfree(cq->wc);
 	rdma_restrack_del(&cq->res);
@@ -229,3 +242,28 @@ void ib_free_cq(struct ib_cq *cq)
 	WARN_ON_ONCE(ret);
 }
 EXPORT_SYMBOL(ib_free_cq);
+
+/**
+ * ib_change_cq_ctx - change completion queue polling context dynamically
+ * @cq:			the completion queue
+ * @poll_ctx:		new context to poll the CQ from
+ *
+ * The caller must make sure that there is no inflight I/O when calling
+ * this (otherwise its just asking for trouble). If the cq polling context
+ * change fails, the old polling context is restored.
+ */
+int ib_change_cq_ctx(struct ib_cq *cq, enum ib_poll_context poll_ctx)
+{
+	enum ib_poll_context old_ctx = cq->poll_ctx;
+	int ret;
+
+	__ib_cq_clear_ctx(cq);
+	cq->poll_ctx = poll_ctx;
+	ret = __ib_cq_set_ctx(cq);
+	if (ret) {
+		cq->poll_ctx = old_ctx;
+		__ib_cq_set_ctx(cq);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(ib_change_cq_ctx);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9c0c2132a2d6..c9d03d3a3cd4 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3464,6 +3464,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 
 void ib_free_cq(struct ib_cq *cq);
 int ib_process_cq_direct(struct ib_cq *cq, int budget);
+int ib_change_cq_ctx(struct ib_cq *cq, enum ib_poll_context poll_ctx);
 
 /**
  * ib_create_cq - Creates a CQ on the specified device.
-- 
2.17.1

