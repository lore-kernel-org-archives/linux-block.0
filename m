Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A832CCCA473
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 01:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbiFPBof (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347119AbiFPBoU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 21:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF36927FC7
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655343859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l47d3Lo2bqjC8MYcsJ4xGjMRtTBseRxFjUqsk4K99LU=;
        b=cy7J8oZM9MGFvQUXLVvLYpCqMZYagi70dtm+fNOvBvxhbd5PZ7mYdfSk2dT3n8Ivp/8K07
        4vU1N1iOg7MA9tWbPkRG+pu3VMaufxiZxtm5Y0tHrJ4KGReoQVWCQRS6pZmCjkmkpdRsOO
        EV1pXKs7KNPnMD7Jxeu/tgnx2KU3ALw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-Ie7To967NjiP8FBSyJlXJw-1; Wed, 15 Jun 2022 21:44:15 -0400
X-MC-Unique: Ie7To967NjiP8FBSyJlXJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 926641C0F682;
        Thu, 16 Jun 2022 01:44:15 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88723400E88E;
        Thu, 16 Jun 2022 01:44:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH V3 2/3] blk-mq: avoid to touch q->elevator without any protection
Date:   Thu, 16 Jun 2022 09:44:00 +0800
Message-Id: <20220616014401.817001-3-ming.lei@redhat.com>
In-Reply-To: <20220616014401.817001-1-ming.lei@redhat.com>
References: <20220616014401.817001-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->elevator is referred in blk_mq_has_sqsched() without any protection,
no .q_usage_counter is held, no queue srcu and rcu read lock is held,
so potential use-after-free may be triggered.

Fix the issue by adding one queue flag for checking if the elevator
uses single queue style dispatch. Meantime the elevator feature flag
of ELEVATOR_F_MQ_AWARE isn't needed any more.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bfq-iosched.c    |  3 +++
 block/blk-mq-sched.c   |  1 +
 block/blk-mq.c         | 18 ++----------------
 block/kyber-iosched.c  |  3 ++-
 block/mq-deadline.c    |  3 +++
 include/linux/blkdev.h |  4 ++--
 6 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0d46cb728bbf..caa55a5624bc 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7188,6 +7188,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfq_init_root_group(bfqd->root_group, bfqd);
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
 
+	/* We dispatch from request queue wide instead of hw queue */
+	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
+
 	wbt_disable_default(q);
 	return 0;
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9e56a69422b6..eb3c65a21362 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -564,6 +564,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	int ret;
 
 	if (!e) {
+		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
 		return 0;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22a89c758f70..112dce569192 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2140,20 +2140,6 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
-/*
- * Is the request queue handled by an IO scheduler that does not respect
- * hardware queues when dispatching?
- */
-static bool blk_mq_has_sqsched(struct request_queue *q)
-{
-	struct elevator_queue *e = q->elevator;
-
-	if (e && e->type->ops.dispatch_request &&
-	    !(e->type->elevator_features & ELEVATOR_F_MQ_AWARE))
-		return true;
-	return false;
-}
-
 /*
  * Return prefered queue to dispatch from (if any) for non-mq aware IO
  * scheduler.
@@ -2186,7 +2172,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	unsigned long i;
 
 	sq_hctx = NULL;
-	if (blk_mq_has_sqsched(q))
+	if (blk_queue_sq_sched(q))
 		sq_hctx = blk_mq_get_sq_hctx(q);
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
@@ -2214,7 +2200,7 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 	unsigned long i;
 
 	sq_hctx = NULL;
-	if (blk_mq_has_sqsched(q))
+	if (blk_queue_sq_sched(q))
 		sq_hctx = blk_mq_get_sq_hctx(q);
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 70ff2a599ef6..8f7c745b4a57 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -421,6 +421,8 @@ static int kyber_init_sched(struct request_queue *q, struct elevator_type *e)
 
 	blk_stat_enable_accounting(q);
 
+	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
+
 	eq->elevator_data = kqd;
 	q->elevator = eq;
 
@@ -1033,7 +1035,6 @@ static struct elevator_type kyber_sched = {
 #endif
 	.elevator_attrs = kyber_sched_attrs,
 	.elevator_name = "kyber",
-	.elevator_features = ELEVATOR_F_MQ_AWARE,
 	.elevator_owner = THIS_MODULE,
 };
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6ed602b2f80a..1a9e835e816c 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -642,6 +642,9 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
+	/* We dispatch from request queue wide instead of hw queue */
+	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
+
 	q->elevator = eq;
 	return 0;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 608d577734c2..bb6e3c31b3b7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -575,6 +575,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -616,6 +617,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
+#define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
@@ -1006,8 +1008,6 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
  */
 /* Supports zoned block devices sequential write constraint */
 #define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
-/* Supports scheduling on multiple hardware queues */
-#define ELEVATOR_F_MQ_AWARE		(1U << 1)
 
 extern void blk_queue_required_elevator_features(struct request_queue *q,
 						 unsigned int features);
-- 
2.31.1

