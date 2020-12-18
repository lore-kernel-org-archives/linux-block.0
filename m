Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB8C4361B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F178E23B7B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 21:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLRVpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:45:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:52724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgLRVpB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 16:45:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28CCBAD12;
        Fri, 18 Dec 2020 21:44:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B76D81E1332; Fri, 18 Dec 2020 22:44:19 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, hare@suse.de,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] blk-mq: Improve performance of non-mq IO schedulers with multiple HW queues
Date:   Fri, 18 Dec 2020 22:44:12 +0100
Message-Id: <20201218214412.1543-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201218214412.1543-1-jack@suse.cz>
References: <20201218214412.1543-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently when non-mq aware IO scheduler (BFQ, mq-deadline) is used for
a queue with multiple HW queues, the performance it rather bad. The
problem is that these IO schedulers use queue-wide locking and their
dispatch function does not respect the hctx it is passed in and returns
any request it finds appropriate. Thus locality of request access is
broken and dispatch from multiple CPUs just contends on IO scheduler
locks. For these IO schedulers there's little point in dispatching from
multiple CPUs. Instead dispatch always only from a single CPU to limit
contention.

Below is a comparison of dbench runs on XFS filesystem where the storage
is a raid card with 64 HW queues and to it attached a single rotating
disk. BFQ is used as IO scheduler:

      clients           MQ                     SQ             MQ-Patched
Amean 1      39.12 (0.00%)       43.29 * -10.67%*       36.09 *   7.74%*
Amean 2     128.58 (0.00%)      101.30 *  21.22%*       96.14 *  25.23%*
Amean 4     577.42 (0.00%)      494.47 *  14.37%*      508.49 *  11.94%*
Amean 8     610.95 (0.00%)      363.86 *  40.44%*      362.12 *  40.73%*
Amean 16    391.78 (0.00%)      261.49 *  33.25%*      282.94 *  27.78%*
Amean 32    324.64 (0.00%)      267.71 *  17.54%*      233.00 *  28.23%*
Amean 64    295.04 (0.00%)      253.02 *  14.24%*      242.37 *  17.85%*
Amean 512 10281.61 (0.00%)    10211.16 *   0.69%*    10447.53 *  -1.61%*

Numbers are times so lower is better. MQ is stock 5.10-rc6 kernel. SQ is
the same kernel with megaraid_sas.host_tagset_enable=0 so that the card
advertises just a single HW queue. MQ-Patched is a kernel with this
patch applied.

You can see multiple hardware queues heavily hurt performance in
combination with BFQ. The patch restores the performance.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq.c           | 37 +++++++++++++++++++++++++++++++++++++
 block/kyber-iosched.c    |  1 +
 include/linux/elevator.h |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 57d0461f2be5..6d80054c231b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1663,6 +1663,31 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
+static struct blk_mq_hw_ctx *blk_mq_sq_iosched_hctx(struct request_queue *q)
+{
+	struct elevator_queue *e = q->elevator;
+	struct blk_mq_hw_ctx *hctx;
+
+	/*
+	 * The queue has multiple hardware queues but uses IO scheduler that
+	 * does not respect hardware queues when dispatching? This is not a
+	 * great setup but it can be sensible when we have a single rotational
+	 * disk behind a raid card. Just don't bother with multiple HW queues
+	 * and dispatch from hctx for the current CPU since running multiple
+	 * queues just causes lock contention inside the scheduler and
+	 * pointless cache bouncing because the hctx is not respected by the IO
+	 * scheduler's dispatch function anyway.
+	 */
+	if (q->nr_hw_queues > 1 && e && e->type->ops.dispatch_request &&
+	    !(e->type->elevator_features & ELEVATOR_F_MQ_AWARE)) {
+		hctx = blk_mq_map_queue_type(q, HCTX_TYPE_DEFAULT,
+					     raw_smp_processor_id());
+		if (!blk_mq_hctx_stopped(hctx))
+			return hctx;
+	}
+	return NULL;
+}
+
 /**
  * blk_mq_run_hw_queues - Run all hardware queues in a request queue.
  * @q: Pointer to the request queue to run.
@@ -1673,6 +1698,12 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	hctx = blk_mq_sq_iosched_hctx(q);
+	if (hctx) {
+		blk_mq_run_hw_queue(hctx, async);
+		return;
+	}
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
 			continue;
@@ -1692,6 +1723,12 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	hctx = blk_mq_sq_iosched_hctx(q);
+	if (hctx) {
+		blk_mq_delay_run_hw_queue(hctx, msecs);
+		return;
+	}
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
 			continue;
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index dc89199bc8c6..c25c41d0d061 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -1029,6 +1029,7 @@ static struct elevator_type kyber_sched = {
 #endif
 	.elevator_attrs = kyber_sched_attrs,
 	.elevator_name = "kyber",
+	.elevator_features = ELEVATOR_F_MQ_AWARE,
 	.elevator_owner = THIS_MODULE,
 };
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index bacc40a0bdf3..1fe8e105b83b 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -172,6 +172,8 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 
 /* Supports zoned block devices sequential write constraint */
 #define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
+/* Supports scheduling on multiple hardware queues */
+#define ELEVATOR_F_MQ_AWARE		(1U << 1)
 
 #endif /* CONFIG_BLOCK */
 #endif
-- 
2.16.4

