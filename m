Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
From: Joseph Qi <jiangqi903@gmail.com>
Subject: [PATCH 3/3] blk-throttle: do downgrade/upgrade check when issuing io
 to lower layer
To: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@kernel.org>
Cc: jinli.zjl@alibaba-inc.com, qijiang.qj@alibaba-inc.com,
 linux-block <linux-block@vger.kernel.org>
Message-ID: <21feac46-091c-8a41-a69c-ebb44646f5be@gmail.com>
Date: Thu, 4 Jan 2018 19:08:32 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Joseph Qi <qijiang.qj@alibaba-inc.com>

Currently downgrade/upgrade check is done when io firstly comes to block
throttle layer. In case of writeback, a large number of ios will firstly
be throttled in throttle queue and then dispatched when timer kicked,
which won't be checked because REQ_THROTTLED is set. This will lead to
low limit not guaranteed most of time.
Fix this case by moving check logic down, in which we are ready to issue
io to lower layer.

Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
---
 block/blk-throttle.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9c0b5ff..6207554 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1065,8 +1065,6 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	/* Charge the bio to the group */
 	tg->bytes_disp[rw] += bio_size;
 	tg->io_disp[rw]++;
-	tg->last_bytes_disp[rw] += bio_size;
-	tg->last_io_disp[rw]++;
 
 	/*
 	 * BIO_THROTTLED is used to prevent the same bio to be throttled
@@ -2166,7 +2164,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
 	struct throtl_qnode *qn = NULL;
-	struct throtl_grp *tg = blkg_to_tg(blkg ?: q->root_blkg);
+	struct throtl_grp *orig_tg = blkg_to_tg(blkg ?: q->root_blkg);
+	struct throtl_grp *tg = orig_tg;
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
@@ -2174,11 +2173,11 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
+	spin_lock_irq(q->queue_lock);
+
 	/* see throtl_charge_bio() */
 	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
-		goto out;
-
-	spin_lock_irq(q->queue_lock);
+		goto out_unlock;
 
 	throtl_update_latency_buckets(td);
 
@@ -2194,15 +2193,12 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	while (true) {
 		if (tg->last_low_overflow_time[rw] == 0)
 			tg->last_low_overflow_time[rw] = jiffies;
-		throtl_downgrade_check(tg);
-		throtl_upgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
 		if (sq->nr_queued[rw])
 			break;
 
 		/* if above limits, break to queue */
 		if (!tg_may_dispatch(tg, bio, NULL)) {
-			tg->last_low_overflow_time[rw] = jiffies;
 			if (throtl_can_upgrade(td, tg)) {
 				throtl_upgrade_state(td);
 				goto again;
@@ -2246,8 +2242,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		   tg->io_disp[rw], tg_iops_limit(tg, rw),
 		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
 
-	tg->last_low_overflow_time[rw] = jiffies;
-
 	td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
 	throttled = true;
@@ -2264,8 +2258,13 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	}
 
 out_unlock:
+	throtl_downgrade_check(orig_tg);
+	throtl_upgrade_check(orig_tg);
+	if (!throttled) {
+		orig_tg->last_bytes_disp[rw] += throtl_bio_data_size(bio);
+		orig_tg->last_io_disp[rw]++;
+	}
 	spin_unlock_irq(q->queue_lock);
-out:
 	bio_set_flag(bio, BIO_THROTTLED);
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-- 
1.9.4
