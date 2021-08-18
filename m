Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399C3C432BE
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E20610D2
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhHROqW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239487AbhHROpj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629297904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3vlRZsRrq1/tVs2WPqlQ/C5crgeVlL8Mn9TRLLqcMU=;
        b=OsW71qeV4No88NA++riODCTETrNdVIiEEuKVXPaNggL+0zlbcfkY63B3s3KewEUR/kONBS
        g6dGIkPo2Se9Vn0KklMSuZdCBVcd03qh2nHLRtbh5xreoojuogdWygUFQBzRnmRn7jlyK3
        lyAtMLdq686UTjrTYb1NSWkDQD+W1l4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-DLWx9JG9MvyEaS15TTeOpQ-1; Wed, 18 Aug 2021 10:45:03 -0400
X-MC-Unique: DLWx9JG9MvyEaS15TTeOpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27E0C8799EC;
        Wed, 18 Aug 2021 14:45:01 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94E845D9C6;
        Wed, 18 Aug 2021 14:44:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 3/3] blk-mq: don't deactivate hctx if managed irq isn't used
Date:   Wed, 18 Aug 2021 22:44:28 +0800
Message-Id: <20210818144428.896216-4-ming.lei@redhat.com>
In-Reply-To: <20210818144428.896216-1-ming.lei@redhat.com>
References: <20210818144428.896216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq deactivates one hctx when the last CPU in hctx->cpumask become
offline by draining all requests originated from this hctx and moving new
allocation to other active hctx. This way is for avoiding inflight IO in
case of managed irq because managed irq is shutdown when the last CPU in
the irq's affinity becomes offline.

However, lots of drivers(nvme fc, rdma, tcp, loop, ...) don't use managed
irq, so they needn't to deactivate hctx when the last CPU becomes offline.
Also, some of them are the only user of blk_mq_alloc_request_hctx() which
is used for connecting io queue. And their requirement is that the connect
request needs to be submitted successfully via one specified hctx even
though all CPUs in this hctx->cpumask have become offline.

Addressing the requirement for nvme fc/rdma/loop by allowing to
allocate request from one hctx when all CPUs in this hctx are offline,
since these drivers don't use managed irq.

Finally don't deactivate one hctx when it doesn't use managed irq.

Tested-by: Wen Xiong <wenxiong@us.ibm.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ab4540320ca..9abfad3d5b48 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -427,6 +427,23 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
+static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
+{
+	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_first(hctx->cpumask);
+	return cpu;
+}
+
+static bool blk_mq_hctx_use_managed_irq(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->type == HCTX_TYPE_POLL)
+		return false;
+
+	return hctx->queue->tag_set->map[hctx->type].use_managed_irq;
+}
+
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
 {
@@ -468,7 +485,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+
+	WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
+
+	cpu = blk_mq_first_mapped_cpu(data.hctx);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
@@ -1501,15 +1521,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	hctx_unlock(hctx, srcu_idx);
 }
 
-static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
-{
-	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
-
-	if (cpu >= nr_cpu_ids)
-		cpu = cpumask_first(hctx->cpumask);
-	return cpu;
-}
-
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -2556,6 +2567,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
+	/* hctx needn't to be deactivated in case managed irq isn't used */
+	if (!blk_mq_hctx_use_managed_irq(hctx))
+		return 0;
+
 	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
 	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
 		return 0;
-- 
2.31.1

