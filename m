Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42389 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeEBRen (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 May 2018 13:34:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id p9-v6so8229372pgc.9
        for <linux-block@vger.kernel.org>; Wed, 02 May 2018 10:34:42 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 2/7] block: pass struct request instead of struct blk_issue_stat to wbt
Date: Wed,  2 May 2018 10:34:21 -0700
Message-Id: <42fc4271b0d124982df9fd4d1dd66f1bcb1c528e.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

issue_stat is going to go away, so first make writeback throttling take
the containing request, update the internal wbt helpers accordingly, and
change rwb->sync_cookie to be the request pointer instead of the
issue_stat pointer. No functional change.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c | 10 ++++-----
 block/blk-mq.c   | 10 ++++-----
 block/blk-wbt.c  | 53 ++++++++++++++++++++++++------------------------
 block/blk-wbt.h  | 18 ++++++++--------
 4 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 85909b431eb0..851ea3c0c0b4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1660,7 +1660,7 @@ void blk_requeue_request(struct request_queue *q, struct request *rq)
 	blk_delete_timer(rq);
 	blk_clear_rq_complete(rq);
 	trace_block_rq_requeue(q, rq);
-	wbt_requeue(q->rq_wb, &rq->issue_stat);
+	wbt_requeue(q->rq_wb, rq);
 
 	if (rq->rq_flags & RQF_QUEUED)
 		blk_queue_end_tag(q, rq);
@@ -1767,7 +1767,7 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 	/* this is a bio leak */
 	WARN_ON(req->bio != NULL);
 
-	wbt_done(q->rq_wb, &req->issue_stat);
+	wbt_done(q->rq_wb, req);
 
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
@@ -2078,7 +2078,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 		goto out_unlock;
 	}
 
-	wbt_track(&req->issue_stat, wb_acct);
+	wbt_track(req, wb_acct);
 
 	/*
 	 * After dropping the lock and possibly sleeping here, our request
@@ -2994,7 +2994,7 @@ void blk_start_request(struct request *req)
 	if (test_bit(QUEUE_FLAG_STATS, &req->q->queue_flags)) {
 		blk_stat_set_issue(&req->issue_stat, blk_rq_sectors(req));
 		req->rq_flags |= RQF_STATS;
-		wbt_issue(req->q->rq_wb, &req->issue_stat);
+		wbt_issue(req->q->rq_wb, req);
 	}
 
 	BUG_ON(blk_rq_is_complete(req));
@@ -3213,7 +3213,7 @@ void blk_finish_request(struct request *req, blk_status_t error)
 	blk_account_io_done(req);
 
 	if (req->end_io) {
-		wbt_done(req->q->rq_wb, &req->issue_stat);
+		wbt_done(req->q->rq_wb, req);
 		req->end_io(req, error);
 	} else {
 		if (blk_bidi_rq(req))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3621453ad87..5c9e3ea6cc4e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -472,7 +472,7 @@ void blk_mq_free_request(struct request *rq)
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->backing_dev_info);
 
-	wbt_done(q->rq_wb, &rq->issue_stat);
+	wbt_done(q->rq_wb, rq);
 
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
@@ -492,7 +492,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 	blk_account_io_done(rq);
 
 	if (rq->end_io) {
-		wbt_done(rq->q->rq_wb, &rq->issue_stat);
+		wbt_done(rq->q->rq_wb, rq);
 		rq->end_io(rq, error);
 	} else {
 		if (unlikely(blk_bidi_rq(rq)))
@@ -655,7 +655,7 @@ void blk_mq_start_request(struct request *rq)
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
 		blk_stat_set_issue(&rq->issue_stat, blk_rq_sectors(rq));
 		rq->rq_flags |= RQF_STATS;
-		wbt_issue(q->rq_wb, &rq->issue_stat);
+		wbt_issue(q->rq_wb, rq);
 	}
 
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
@@ -703,7 +703,7 @@ static void __blk_mq_requeue_request(struct request *rq)
 	blk_mq_put_driver_tag(rq);
 
 	trace_block_rq_requeue(q, rq);
-	wbt_requeue(q->rq_wb, &rq->issue_stat);
+	wbt_requeue(q->rq_wb, rq);
 
 	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
 		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
@@ -1866,7 +1866,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
-	wbt_track(&rq->issue_stat, wb_acct);
+	wbt_track(rq, wb_acct);
 
 	cookie = request_to_qc_t(data.hctx, rq);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 030d6bdcaa4c..10aecfadc57d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -29,24 +29,24 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
 
-static inline void wbt_clear_state(struct blk_issue_stat *stat)
+static inline void wbt_clear_state(struct request *rq)
 {
-	stat->stat &= ~BLK_STAT_RES_MASK;
+	rq->issue_stat.stat &= ~BLK_STAT_RES_MASK;
 }
 
-static inline enum wbt_flags wbt_stat_to_mask(struct blk_issue_stat *stat)
+static inline enum wbt_flags wbt_flags(struct request *rq)
 {
-	return (stat->stat & BLK_STAT_RES_MASK) >> BLK_STAT_RES_SHIFT;
+	return (rq->issue_stat.stat & BLK_STAT_RES_MASK) >> BLK_STAT_RES_SHIFT;
 }
 
-static inline bool wbt_is_tracked(struct blk_issue_stat *stat)
+static inline bool wbt_is_tracked(struct request *rq)
 {
-	return (stat->stat >> BLK_STAT_RES_SHIFT) & WBT_TRACKED;
+	return (rq->issue_stat.stat >> BLK_STAT_RES_SHIFT) & WBT_TRACKED;
 }
 
-static inline bool wbt_is_read(struct blk_issue_stat *stat)
+static inline bool wbt_is_read(struct request *rq)
 {
-	return (stat->stat >> BLK_STAT_RES_SHIFT) & WBT_READ;
+	return (rq->issue_stat.stat >> BLK_STAT_RES_SHIFT) & WBT_READ;
 }
 
 enum {
@@ -185,24 +185,24 @@ void __wbt_done(struct rq_wb *rwb, enum wbt_flags wb_acct)
  * Called on completion of a request. Note that it's also called when
  * a request is merged, when the request gets freed.
  */
-void wbt_done(struct rq_wb *rwb, struct blk_issue_stat *stat)
+void wbt_done(struct rq_wb *rwb, struct request *rq)
 {
 	if (!rwb)
 		return;
 
-	if (!wbt_is_tracked(stat)) {
-		if (rwb->sync_cookie == stat) {
+	if (!wbt_is_tracked(rq)) {
+		if (rwb->sync_cookie == rq) {
 			rwb->sync_issue = 0;
 			rwb->sync_cookie = NULL;
 		}
 
-		if (wbt_is_read(stat))
+		if (wbt_is_read(rq))
 			wb_timestamp(rwb, &rwb->last_comp);
 	} else {
-		WARN_ON_ONCE(stat == rwb->sync_cookie);
-		__wbt_done(rwb, wbt_stat_to_mask(stat));
+		WARN_ON_ONCE(rq == rwb->sync_cookie);
+		__wbt_done(rwb, wbt_flags(rq));
 	}
-	wbt_clear_state(stat);
+	wbt_clear_state(rq);
 }
 
 /*
@@ -629,30 +629,29 @@ enum wbt_flags wbt_wait(struct rq_wb *rwb, struct bio *bio, spinlock_t *lock)
 	return ret | WBT_TRACKED;
 }
 
-void wbt_issue(struct rq_wb *rwb, struct blk_issue_stat *stat)
+void wbt_issue(struct rq_wb *rwb, struct request *rq)
 {
 	if (!rwb_enabled(rwb))
 		return;
 
 	/*
-	 * Track sync issue, in case it takes a long time to complete. Allows
-	 * us to react quicker, if a sync IO takes a long time to complete.
-	 * Note that this is just a hint. 'stat' can go away when the
-	 * request completes, so it's important we never dereference it. We
-	 * only use the address to compare with, which is why we store the
-	 * sync_issue time locally.
+	 * Track sync issue, in case it takes a long time to complete. Allows us
+	 * to react quicker, if a sync IO takes a long time to complete. Note
+	 * that this is just a hint. The request can go away when it completes,
+	 * so it's important we never dereference it. We only use the address to
+	 * compare with, which is why we store the sync_issue time locally.
 	 */
-	if (wbt_is_read(stat) && !rwb->sync_issue) {
-		rwb->sync_cookie = stat;
-		rwb->sync_issue = blk_stat_time(stat);
+	if (wbt_is_read(rq) && !rwb->sync_issue) {
+		rwb->sync_cookie = rq;
+		rwb->sync_issue = blk_stat_time(&rq->issue_stat);
 	}
 }
 
-void wbt_requeue(struct rq_wb *rwb, struct blk_issue_stat *stat)
+void wbt_requeue(struct rq_wb *rwb, struct request *rq)
 {
 	if (!rwb_enabled(rwb))
 		return;
-	if (stat == rwb->sync_cookie) {
+	if (rq == rwb->sync_cookie) {
 		rwb->sync_issue = 0;
 		rwb->sync_cookie = NULL;
 	}
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index d3f47a721aec..dd9211fa853f 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -84,19 +84,19 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
-static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags flags)
+static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
-	stat->stat |= ((u64)flags) << BLK_STAT_RES_SHIFT;
+	rq->issue_stat.stat |= ((u64)flags) << BLK_STAT_RES_SHIFT;
 }
 
 void __wbt_done(struct rq_wb *, enum wbt_flags);
-void wbt_done(struct rq_wb *, struct blk_issue_stat *);
+void wbt_done(struct rq_wb *, struct request *);
 enum wbt_flags wbt_wait(struct rq_wb *, struct bio *, spinlock_t *);
 int wbt_init(struct request_queue *);
 void wbt_exit(struct request_queue *);
 void wbt_update_limits(struct rq_wb *);
-void wbt_requeue(struct rq_wb *, struct blk_issue_stat *);
-void wbt_issue(struct rq_wb *, struct blk_issue_stat *);
+void wbt_requeue(struct rq_wb *, struct request *);
+void wbt_issue(struct rq_wb *, struct request *);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
 
@@ -107,13 +107,13 @@ u64 wbt_default_latency_nsec(struct request_queue *);
 
 #else
 
-static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags flags)
+static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
 }
 static inline void __wbt_done(struct rq_wb *rwb, enum wbt_flags flags)
 {
 }
-static inline void wbt_done(struct rq_wb *rwb, struct blk_issue_stat *stat)
+static inline void wbt_done(struct rq_wb *rwb, struct request *rq)
 {
 }
 static inline enum wbt_flags wbt_wait(struct rq_wb *rwb, struct bio *bio,
@@ -131,10 +131,10 @@ static inline void wbt_exit(struct request_queue *q)
 static inline void wbt_update_limits(struct rq_wb *rwb)
 {
 }
-static inline void wbt_requeue(struct rq_wb *rwb, struct blk_issue_stat *stat)
+static inline void wbt_requeue(struct rq_wb *rwb, struct request *rq)
 {
 }
-static inline void wbt_issue(struct rq_wb *rwb, struct blk_issue_stat *stat)
+static inline void wbt_issue(struct rq_wb *rwb, struct request *rq)
 {
 }
 static inline void wbt_disable_default(struct request_queue *q)
-- 
2.17.0
