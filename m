Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] block: add queue_is_mq() helper
Date: Sat, 10 Nov 2018 08:13:13 -0700
Message-Id: <20181110151317.3813-3-axboe@kernel.dk>
In-Reply-To: <20181110151317.3813-1-axboe@kernel.dk>
References: <20181110151317.3813-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Various spots check for q->mq_ops being non-NULL, but provide
a helper to do this instead.

Where the ->mq_ops != NULL check is redundant, remove it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c     |  8 ++++----
 block/blk-core.c       | 10 +++++-----
 block/blk-flush.c      |  3 +--
 block/blk-mq.c         |  2 +-
 block/blk-sysfs.c      | 14 +++++++-------
 block/blk-wbt.c        |  2 +-
 block/elevator.c       |  9 ++++-----
 block/genhd.c          |  8 ++++----
 drivers/md/dm-table.c  |  2 +-
 include/linux/blkdev.h | 10 +++++++---
 10 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6c65791bc3fe..8da8d3773ecf 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1349,7 +1349,7 @@ int blkcg_activate_policy(struct request_queue *q,
 	if (blkcg_policy_enabled(q, pol))
 		return 0;
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 pd_prealloc:
 	if (!pd_prealloc) {
@@ -1388,7 +1388,7 @@ int blkcg_activate_policy(struct request_queue *q,
 
 	spin_unlock_irq(q->queue_lock);
 out_bypass_end:
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q);
 	if (pd_prealloc)
 		pol->pd_free_fn(pd_prealloc);
@@ -1412,7 +1412,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	if (!blkcg_policy_enabled(q, pol))
 		return;
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 
 	spin_lock_irq(q->queue_lock);
@@ -1430,7 +1430,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 	spin_unlock_irq(q->queue_lock);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q);
 }
 EXPORT_SYMBOL_GPL(blkcg_deactivate_policy);
diff --git a/block/blk-core.c b/block/blk-core.c
index fdc0ad2686c4..ab6675fd3568 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -268,7 +268,7 @@ void blk_sync_queue(struct request_queue *q)
 	del_timer_sync(&q->timeout);
 	cancel_work_sync(&q->timeout_work);
 
-	if (q->mq_ops) {
+	if (queue_is_mq(q)) {
 		struct blk_mq_hw_ctx *hctx;
 		int i;
 
@@ -317,7 +317,7 @@ void blk_set_queue_dying(struct request_queue *q)
 	 */
 	blk_freeze_queue_start(q);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_wake_waiters(q);
 
 	/* Make blk_queue_enter() reexamine the DYING flag. */
@@ -410,7 +410,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * blk_freeze_queue() should be enough for cases of passthrough
 	 * request.
 	 */
-	if (q->mq_ops && blk_queue_init_done(q))
+	if (queue_is_mq(q) && blk_queue_init_done(q))
 		blk_mq_quiesce_queue(q);
 
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
@@ -428,7 +428,7 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_exit_queue(q);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_free_queue(q);
 
 	percpu_ref_exit(&q->q_usage_counter);
@@ -1736,7 +1736,7 @@ EXPORT_SYMBOL_GPL(rq_flush_dcache_pages);
  */
 int blk_lld_busy(struct request_queue *q)
 {
-	if (q->mq_ops && q->mq_ops->busy)
+	if (queue_is_mq(q) && q->mq_ops->busy)
 		return q->mq_ops->busy(q);
 
 	return 0;
diff --git a/block/blk-flush.c b/block/blk-flush.c
index c53197dcdd70..3b79bea03462 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -273,8 +273,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	 * assigned to empty flushes, and we deadlock if we are expecting
 	 * other requests to make progress. Don't defer for that case.
 	 */
-	if (!list_empty(&fq->flush_data_in_flight) &&
-	    !(q->mq_ops && q->elevator) &&
+	if (!list_empty(&fq->flush_data_in_flight) && q->elevator &&
 	    time_before(jiffies,
 			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
 		return;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 411be60d0cb6..eb9b9596d3de 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -150,7 +150,7 @@ void blk_freeze_queue_start(struct request_queue *q)
 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
 	if (freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
-		if (q->mq_ops)
+		if (queue_is_mq(q))
 			blk_mq_run_hw_queues(q, false);
 	}
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d4b1b84ba8ca..93635a693314 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -68,7 +68,7 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 	unsigned long nr;
 	int ret, err;
 
-	if (!q->mq_ops)
+	if (!queue_is_mq(q))
 		return -EINVAL;
 
 	ret = queue_var_store(&nr, page, count);
@@ -839,12 +839,12 @@ static void __blk_release_queue(struct work_struct *work)
 
 	blk_queue_free_zone_bitmaps(q);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_release(q);
 
 	blk_trace_shutdown(q);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
 	bioset_exit(&q->bio_split);
@@ -918,7 +918,7 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
-	if (q->mq_ops) {
+	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
 	}
@@ -929,7 +929,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_throtl_register_queue(q);
 
-	if ((q->mq_ops && q->elevator)) {
+	if (q->elevator) {
 		ret = elv_register_queue(q);
 		if (ret) {
 			mutex_unlock(&q->sysfs_lock);
@@ -978,7 +978,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
 	 */
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 	mutex_unlock(&q->sysfs_lock);
 
@@ -987,7 +987,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
-	if (q->mq_ops && q->elevator)
+	if (q->elevator)
 		elv_unregister_queue(q);
 	mutex_unlock(&q->sysfs_lock);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0fc222d4194b..b580763e8b1e 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -709,7 +709,7 @@ void wbt_enable_default(struct request_queue *q)
 	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
 		return;
 
-	if (q->mq_ops && IS_ENABLED(CONFIG_BLK_WBT_MQ))
+	if (queue_is_mq(q) && IS_ENABLED(CONFIG_BLK_WBT_MQ))
 		wbt_init(q);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
diff --git a/block/elevator.c b/block/elevator.c
index 19351ffa56b1..9df9ae6b038e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -674,7 +674,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	/*
 	 * Special case for mq, turn off scheduling
 	 */
-	if (q->mq_ops && !strncmp(name, "none", 4))
+	if (!strncmp(name, "none", 4))
 		return elevator_switch(q, NULL);
 
 	strlcpy(elevator_name, name, sizeof(elevator_name));
@@ -692,8 +692,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 
 static inline bool elv_support_iosched(struct request_queue *q)
 {
-	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
-				BLK_MQ_F_NO_SCHED))
+	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
 		return false;
 	return true;
 }
@@ -703,7 +702,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 {
 	int ret;
 
-	if (!q->mq_ops || !elv_support_iosched(q))
+	if (!queue_is_mq(q) || !elv_support_iosched(q))
 		return count;
 
 	ret = __elevator_change(q, name);
@@ -739,7 +738,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	}
 	spin_unlock(&elv_list_lock);
 
-	if (q->mq_ops && q->elevator)
+	if (q->elevator)
 		len += sprintf(name+len, "none");
 
 	len += sprintf(len+name, "\n");
diff --git a/block/genhd.c b/block/genhd.c
index cff6bdf27226..0145bcb0cc76 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -47,7 +47,7 @@ static void disk_release_events(struct gendisk *disk);
 
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		return;
 
 	atomic_inc(&part->in_flight[rw]);
@@ -57,7 +57,7 @@ void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		return;
 
 	atomic_dec(&part->in_flight[rw]);
@@ -68,7 +68,7 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2])
 {
-	if (q->mq_ops) {
+	if (queue_is_mq(q)) {
 		blk_mq_in_flight(q, part, inflight);
 		return;
 	}
@@ -85,7 +85,7 @@ void part_in_flight(struct request_queue *q, struct hd_struct *part,
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2])
 {
-	if (q->mq_ops) {
+	if (queue_is_mq(q)) {
 		blk_mq_in_flight_rw(q, part, inflight);
 		return;
 	}
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 9038c302d5c2..e42739177107 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -919,7 +919,7 @@ static int device_is_rq_based(struct dm_target *ti, struct dm_dev *dev,
 	struct request_queue *q = bdev_get_queue(dev->bdev);
 	struct verify_rq_based_data *v = data;
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		v->mq_count++;
 	else
 		v->sq_count++;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e67ad2dd025e..3712d1fe48d4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -671,13 +671,17 @@ static inline bool blk_account_rq(struct request *rq)
 
 #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
 
+static inline bool queue_is_mq(struct request_queue *q)
+{
+	return q->mq_ops;
+}
+
 /*
- * Driver can handle struct request, if it either has an old style
- * request_fn defined, or is blk-mq based.
+ * Only blk-mq based drivers are rq based
  */
 static inline bool queue_is_rq_based(struct request_queue *q)
 {
-	return q->mq_ops;
+	return queue_is_mq(q);
 }
 
 static inline unsigned int blk_queue_cluster(struct request_queue *q)
-- 
2.17.1
