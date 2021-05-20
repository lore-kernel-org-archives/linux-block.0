Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DACC43461
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 22:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A260613B6
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 22:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhETWfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 18:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhETWfY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 18:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90926AF0C;
        Thu, 20 May 2021 22:34:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 384521F2C9E; Fri, 21 May 2021 00:34:01 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] blk: Fix lock inversion between ioc lock and bfqd lock
Date:   Fri, 21 May 2021 00:33:53 +0200
Message-Id: <20210520223353.11561-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520223353.11561-1-jack@suse.cz>
References: <20210520223353.11561-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Lockdep complains about lock inversion between ioc->lock and bfqd->lock:

bfqd -> ioc:
 put_io_context+0x33/0x90 -> ioc->lock grabbed
 blk_mq_free_request+0x51/0x140
 blk_put_request+0xe/0x10
 blk_attempt_req_merge+0x1d/0x30
 elv_attempt_insert_merge+0x56/0xa0
 blk_mq_sched_try_insert_merge+0x4b/0x60
 bfq_insert_requests+0x9e/0x18c0 -> bfqd->lock grabbed
 blk_mq_sched_insert_requests+0xd6/0x2b0
 blk_mq_flush_plug_list+0x154/0x280
 blk_finish_plug+0x40/0x60
 ext4_writepages+0x696/0x1320
 do_writepages+0x1c/0x80
 __filemap_fdatawrite_range+0xd7/0x120
 sync_file_range+0xac/0xf0

ioc->bfqd:
 bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
 put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
 exit_io_context+0x48/0x50
 do_exit+0x7e9/0xdd0
 do_group_exit+0x54/0xc0

To avoid this inversion we change blk_mq_sched_try_insert_merge() to not
free the merged request but rather leave that upto the caller similarly
to blk_mq_sched_try_merge(). And in bfq_insert_requests() we make sure
to free the request after dropping bfqd->lock. As a nice consequence,
this also makes locking rules in bfq_finish_requeue_request() more
consistent.

Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 20 +++++++-------------
 block/blk-merge.c   | 19 ++++++++-----------
 block/blk.h         |  2 +-
 block/mq-deadline.c |  4 +++-
 4 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index acd1f881273e..4afdf0b93124 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2317,9 +2317,9 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 
 	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
 
+	spin_unlock_irq(&bfqd->lock);
 	if (free)
 		blk_mq_free_request(free);
-	spin_unlock_irq(&bfqd->lock);
 
 	return ret;
 }
@@ -5933,6 +5933,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	spin_lock_irq(&bfqd->lock);
 	if (blk_mq_sched_try_insert_merge(q, rq)) {
 		spin_unlock_irq(&bfqd->lock);
+		blk_put_request(rq);
 		return;
 	}
 
@@ -6376,6 +6377,7 @@ static void bfq_finish_requeue_request(struct request *rq)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd;
+	unsigned long flags;
 
 	/*
 	 * rq either is not associated with any icq, or is an already
@@ -6393,18 +6395,12 @@ static void bfq_finish_requeue_request(struct request *rq)
 					     rq->io_start_time_ns,
 					     rq->cmd_flags);
 
+	spin_lock_irqsave(&bfqd->lock, flags);
 	if (likely(rq->rq_flags & RQF_STARTED)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&bfqd->lock, flags);
-
 		if (rq == bfqd->waited_rq)
 			bfq_update_inject_limit(bfqd, bfqq);
 
 		bfq_completed_request(bfqq, bfqd);
-		bfq_finish_requeue_request_body(bfqq);
-
-		spin_unlock_irqrestore(&bfqd->lock, flags);
 	} else {
 		/*
 		 * Request rq may be still/already in the scheduler,
@@ -6414,18 +6410,16 @@ static void bfq_finish_requeue_request(struct request *rq)
 		 * inconsistencies in the time interval from the end
 		 * of this function to the start of the deferred work.
 		 * This situation seems to occur only in process
-		 * context, as a consequence of a merge. In the
-		 * current version of the code, this implies that the
-		 * lock is held.
+		 * context, as a consequence of a merge.
 		 */
-
 		if (!RB_EMPTY_NODE(&rq->rb_node)) {
 			bfq_remove_request(rq->q, rq);
 			bfqg_stats_update_io_remove(bfqq_group(bfqq),
 						    rq->cmd_flags);
 		}
-		bfq_finish_requeue_request_body(bfqq);
 	}
+	bfq_finish_requeue_request_body(bfqq);
+	spin_unlock_irqrestore(&bfqd->lock, flags);
 
 	/*
 	 * Reset private fields. In case of a requeue, this allows
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4d97fb6dd226..1398b52a24b4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -846,18 +846,15 @@ static struct request *attempt_front_merge(struct request_queue *q,
 	return NULL;
 }
 
-int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
-			  struct request *next)
+/*
+ * Try to merge 'next' into 'rq'. Return true if the merge happened, false
+ * otherwise. The caller is responsible for freeing 'next' if the merge
+ * happened.
+ */
+bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
+			   struct request *next)
 {
-	struct request *free;
-
-	free = attempt_merge(q, rq, next);
-	if (free) {
-		blk_put_request(free);
-		return 1;
-	}
-
-	return 0;
+	return attempt_merge(q, rq, next);
 }
 
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
diff --git a/block/blk.h b/block/blk.h
index 8b3591aee0a5..99ef4f7e7a70 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -225,7 +225,7 @@ ssize_t part_timeout_store(struct device *, struct device_attribute *,
 void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
-int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
+bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
 unsigned int blk_recalc_rq_segments(struct request *rq);
 void blk_rq_set_mixed_merge(struct request *rq);
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 8eea2cbf2bf4..64dd78005ae6 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -494,8 +494,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
-	if (blk_mq_sched_try_insert_merge(q, rq))
+	if (blk_mq_sched_try_insert_merge(q, rq)) {
+		blk_put_request(rq);
 		return;
+	}
 
 	trace_block_rq_insert(rq);
 
-- 
2.26.2

