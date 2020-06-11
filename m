Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9EFC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC57A20812
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4TamTzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgFKGpN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFKGpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E96C08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CM3+TcOEulv4iMoulUHhInFRQYaFqoYAcY/GLL8P26Y=; b=F4TamTzui1QMV+wVKGMmKZQFan
        S0eIw3bU4JJvSnJ+QP0JEA4bRgK9GSmyIRklS4ODS8OYyqdlPIfZL5gCIE8EwpRjigyrCml4lHA8l
        7MOpBnEDbCGQuEZauDTwxH4kq6r7ATHCr8piD9Weg+n1U/I/+3XC3I+RsQQe92cZVdBQv2mBPpFdt
        YSgy/DS6+2/OSsQJ2lmXCiacYFRf6jSTrM56lWdP6ccTrgMwyJGEHb+dEEN2ciduQiW6dUXgFWHCy
        VA0XbgDDB2fD+Algubba7nHzSXjnolu46dA3wI0d1fgAaLuLkhbC1D2ypCT33JgA7A+ksvKJjQQIU
        FMcUtrvw==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxc-00071c-5L; Thu, 11 Jun 2020 06:45:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 06/12] blk-mq: merge the softirq vs non-softirq IPI logic
Date:   Thu, 11 Jun 2020 08:44:46 +0200
Message-Id: <20200611064452.12353-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611064452.12353-1-hch@lst.de>
References: <20200611064452.12353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both the softirq path for single queue devices and the multi-queue
completion handler share the same logic to figure out if we need an
IPI for the completion and eventually issue it.  Merge the two
versions into a single unified code path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 85 ++++++++++++--------------------------------------
 1 file changed, 20 insertions(+), 65 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 059d30c522f2ad..11c706a9942043 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -600,8 +600,11 @@ static __latent_entropy void blk_done_softirq(struct softirq_action *h)
 
 static void blk_mq_trigger_softirq(struct request *rq)
 {
-	struct list_head *list = this_cpu_ptr(&blk_cpu_done);
+	struct list_head *list;
+	unsigned long flags;
 
+	local_irq_save(flags);
+	list = this_cpu_ptr(&blk_cpu_done);
 	list_add_tail(&rq->ipi_list, list);
 
 	/*
@@ -611,11 +614,7 @@ static void blk_mq_trigger_softirq(struct request *rq)
 	 */
 	if (list->next == &rq->ipi_list)
 		raise_softirq_irqoff(BLOCK_SOFTIRQ);
-}
-
-static void trigger_softirq(void *data)
-{
-	blk_mq_trigger_softirq(data);
+	local_irq_restore(flags);
 }
 
 static int blk_softirq_cpu_dead(unsigned int cpu)
@@ -633,56 +632,26 @@ static int blk_softirq_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
-static void __blk_complete_request(struct request *req)
+static void __blk_mq_complete_request(struct request *rq)
 {
-	struct request_queue *q = req->q;
-	int cpu, ccpu = req->mq_ctx->cpu;
-	unsigned long flags;
-	bool shared = false;
-
-	BUG_ON(!q->mq_ops->complete);
-
-	local_irq_save(flags);
-	cpu = smp_processor_id();
-
-	/*
-	 * Select completion CPU
-	 */
-	if (test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags) && ccpu != -1) {
-		if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
-			shared = cpus_share_cache(cpu, ccpu);
-	} else
-		ccpu = cpu;
-
 	/*
-	 * If current CPU and requested CPU share a cache, run the softirq on
-	 * the current CPU. One might concern this is just like
-	 * QUEUE_FLAG_SAME_FORCE, but actually not. blk_complete_request() is
-	 * running in interrupt handler, and currently I/O controller doesn't
-	 * support multiple interrupts, so current CPU is unique actually. This
-	 * avoids IPI sending from current CPU to the first CPU of a group.
+	 * For most of single queue controllers, there is only one irq vector
+	 * for handling I/O completion, and the only irq's affinity is set
+	 * to all possible CPUs.  On most of ARCHs, this affinity means the irq
+	 * is handled on one specific CPU.
+	 *
+	 * So complete I/O requests in softirq context in case of single queue
+	 * devices to avoid degrading I/O performance due to irqsoff latency.
 	 */
-	if (IS_ENABLED(CONFIG_SMP) &&
-	    ccpu != cpu && !shared && cpu_online(ccpu)) {
-		call_single_data_t *data = &req->csd;
-
-		data->func = trigger_softirq;
-		data->info = req;
-		data->flags = 0;
-		smp_call_function_single_async(cpu, data);
-	} else {
-		blk_mq_trigger_softirq(req);
-	}
-
-	local_irq_restore(flags);
+	if (rq->q->nr_hw_queues == 1)
+		blk_mq_trigger_softirq(rq);
+	else
+		rq->q->mq_ops->complete(rq);
 }
 
 static void __blk_mq_complete_request_remote(void *data)
 {
-	struct request *rq = data;
-	struct request_queue *q = rq->q;
-
-	q->mq_ops->complete(rq);
+	__blk_mq_complete_request(data);
 }
 
 /**
@@ -713,23 +682,9 @@ void blk_mq_force_complete_rq(struct request *rq)
 		return;
 	}
 
-	/*
-	 * Most of single queue controllers, there is only one irq vector
-	 * for handling IO completion, and the only irq's affinity is set
-	 * as all possible CPUs. On most of ARCHs, this affinity means the
-	 * irq is handled on one specific CPU.
-	 *
-	 * So complete IO reqeust in softirq context in case of single queue
-	 * for not degrading IO performance by irqsoff latency.
-	 */
-	if (q->nr_hw_queues == 1) {
-		__blk_complete_request(rq);
-		return;
-	}
-
 	if (!IS_ENABLED(CONFIG_SMP) ||
 	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
-		q->mq_ops->complete(rq);
+		__blk_mq_complete_request(rq);
 		return;
 	}
 
@@ -743,7 +698,7 @@ void blk_mq_force_complete_rq(struct request *rq)
 		rq->csd.flags = 0;
 		smp_call_function_single_async(ctx->cpu, &rq->csd);
 	} else {
-		q->mq_ops->complete(rq);
+		__blk_mq_complete_request(rq);
 	}
 	put_cpu();
 }
-- 
2.26.2

