Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF58C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89D121104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cNfRc6RK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89D121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeK3GUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:20:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeK3GUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7wWcjVk4t3l/WAQnz6Ow/YsvmwGsVmR+BwuEX52Cjyw=; b=cNfRc6RK/Xq6gTyrOMkeGbOftN
        it6Z9Fnm4xGcUaNkO89mxir7XKETt1o3I5LcZkqBUg1KDnKHz7iHhsAJA3OLhK8UkGG6AzvnYuKwj
        SDPBQYCpe8U3xsWJIMAQZT1wtRd+VojKhgGSCDoCTLqjDWhLbBzojhObwoxZo4MSJpcBn0PLVK41m
        A6syZERZ9kb52fn/VfaTb1RS/mRdJDhhvgSAeFNLMLNQ0ygdjgFawayrOlh/Bu1aqgj4IxqihDt+1
        buo2Ev8SA2dWnU7lcivmZ6Ki315pV9LEPHV5OHyk7D6yKpXC3AA0u75a3QBPT8IVmEyiSbasGYu0E
        SL1dPOvA==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSRkj-0003g6-73; Thu, 29 Nov 2018 19:13:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 05/13] nvme-pci: consolidate code for polling non-dedicated queues
Date:   Thu, 29 Nov 2018 20:13:02 +0100
Message-Id: <20181129191310.9795-6-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have three places that can poll for I/O completions on a normal
interrupt-enabled queue.  All of them are in slow path code, so
consolidate them to a single helper that uses spin_lock_irqsave and
removes the fast path cqe_pending check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d42bb76e5e78..10c26a2e355a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1072,17 +1072,19 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
+/*
+ * Poll for completions any queue, including those not dedicated to polling.
+ * Can be called from any context.
+ */
+static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
 {
+	unsigned long flags;
 	u16 start, end;
 	int found;
 
-	if (!nvme_cqe_pending(nvmeq))
-		return 0;
-
-	spin_lock_irq(&nvmeq->cq_lock);
+	spin_lock_irqsave(&nvmeq->cq_lock, flags);
 	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	spin_unlock_irq(&nvmeq->cq_lock);
+	spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
@@ -1279,7 +1281,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Did we miss an interrupt?
 	 */
-	if (__nvme_poll(nvmeq, req->tag)) {
+	if (nvme_poll_irqdisable(nvmeq, req->tag)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
@@ -1406,18 +1408,13 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
-	u16 start, end;
 
 	if (shutdown)
 		nvme_shutdown_ctrl(&dev->ctrl);
 	else
 		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 
-	spin_lock_irq(&nvmeq->cq_lock);
-	nvme_process_cq(nvmeq, &start, &end, -1);
-	spin_unlock_irq(&nvmeq->cq_lock);
-
-	nvme_complete_cqes(nvmeq, start, end);
+	nvme_poll_irqdisable(nvmeq, -1);
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
@@ -2217,17 +2214,9 @@ static void nvme_del_queue_end(struct request *req, blk_status_t error)
 static void nvme_del_cq_end(struct request *req, blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
-	u16 start, end;
 
-	if (!error) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&nvmeq->cq_lock, flags);
-		nvme_process_cq(nvmeq, &start, &end, -1);
-		spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
-
-		nvme_complete_cqes(nvmeq, start, end);
-	}
+	if (!error)
+		nvme_poll_irqdisable(nvmeq, -1);
 
 	nvme_del_queue_end(req, error);
 }
-- 
2.19.1

