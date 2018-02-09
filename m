Return-Path: <prvs=57171364e=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v3 3/3] block: Fix a race between request queue removal and the block cgroup controller
Date: Fri,  9 Feb 2018 10:44:05 -0800
Message-Id: <20180209184405.25835-4-bart.vanassche@wdc.com>
In-Reply-To: <20180209184405.25835-1-bart.vanassche@wdc.com>
References: <20180209184405.25835-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Avoid that the following race can occur:

blk_cleanup_queue()               blkcg_print_blkgs()
  spin_lock_irq(lock) (1)           spin_lock_irq(blkg->q->queue_lock) (2,5)
    q->queue_lock = &q->__queue_lock (3)
  spin_unlock_irq(lock) (4)
                                    spin_unlock_irq(blkg->q->queue_lock) (6)

(1) take driver lock;
(2) busy loop for driver lock;
(3) override driver lock with internal lock;
(4) unlock driver lock;
(5) can take driver lock now;
(6) but unlock internal lock.

This change is safe because only the SCSI core and the NVME core keep
a reference on a request queue after having called blk_cleanup_queue().
Neither driver accesses any of the removed data structures between its
blk_cleanup_queue() and blk_put_queue() calls.

Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jan Kara <jack@suse.com>
---
 block/blk-core.c  | 31 +++++++++++++++++++++++++++++++
 block/blk-sysfs.c |  7 -------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 41c74b37be85..6febc69a58aa 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -719,6 +719,37 @@ void blk_cleanup_queue(struct request_queue *q)
 	del_timer_sync(&q->backing_dev_info->laptop_mode_wb_timer);
 	blk_sync_queue(q);
 
+	/*
+	 * I/O scheduler exit is only safe after the sysfs scheduler attribute
+	 * has been removed.
+	 */
+	WARN_ON_ONCE(q->kobj.state_in_sysfs);
+
+	/*
+	 * Since the I/O scheduler exit code may access cgroup information,
+	 * perform I/O scheduler exit before disassociating from the block
+	 * cgroup controller.
+	 */
+	if (q->elevator) {
+		ioc_clear_queue(q);
+		elevator_exit(q, q->elevator);
+		q->elevator = NULL;
+	}
+
+	/*
+	 * Remove all references to @q from the block cgroup controller before
+	 * restoring @q->queue_lock to avoid that restoring this pointer causes
+	 * e.g. blkcg_print_blkgs() to crash.
+	 */
+	blkcg_exit_queue(q);
+
+	/*
+	 * Since the cgroup code may dereference the @q->backing_dev_info
+	 * pointer, only decrease its reference count after having removed the
+	 * association with the block cgroup controller.
+	 */
+	bdi_put(q->backing_dev_info);
+
 	if (q->mq_ops)
 		blk_mq_free_queue(q);
 	percpu_ref_exit(&q->q_usage_counter);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index cbea895a5547..fd71a00c9462 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -798,13 +798,6 @@ static void __blk_release_queue(struct work_struct *work)
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
-	bdi_put(q->backing_dev_info);
-	blkcg_exit_queue(q);
-
-	if (q->elevator) {
-		ioc_clear_queue(q);
-		elevator_exit(q, q->elevator);
-	}
 
 	blk_free_queue_stats(q->stats);
 
-- 
2.16.1
