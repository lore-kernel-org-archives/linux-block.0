Return-Path: <prvs=669a0b661=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Hannes Reinecke <hare@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v3 1/2] block: Introduce blk_exit_queue()
Date: Fri, 18 May 2018 11:40:02 -0700
Message-Id: <20180518184003.29738-2-bart.vanassche@wdc.com>
In-Reply-To: <20180518184003.29738-1-bart.vanassche@wdc.com>
References: <20180518184003.29738-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 block/blk-core.c | 54 ++++++++++++++++++++++++++++++------------------------
 block/blk.h      |  1 +
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4dadff238b02..ac28a9c7136f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -720,6 +720,35 @@ void blk_set_queue_dying(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_set_queue_dying);
 
+/* Unconfigure the I/O scheduler and dissociate from the cgroup controller. */
+void blk_exit_queue(struct request_queue *q)
+{
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
+}
+
 /**
  * blk_cleanup_queue - shutdown a request queue
  * @q: request queue to shutdown
@@ -785,30 +814,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	WARN_ON_ONCE(q->kobj.state_in_sysfs);
 
-	/*
-	 * Since the I/O scheduler exit code may access cgroup information,
-	 * perform I/O scheduler exit before disassociating from the block
-	 * cgroup controller.
-	 */
-	if (q->elevator) {
-		ioc_clear_queue(q);
-		elevator_exit(q, q->elevator);
-		q->elevator = NULL;
-	}
-
-	/*
-	 * Remove all references to @q from the block cgroup controller before
-	 * restoring @q->queue_lock to avoid that restoring this pointer causes
-	 * e.g. blkcg_print_blkgs() to crash.
-	 */
-	blkcg_exit_queue(q);
-
-	/*
-	 * Since the cgroup code may dereference the @q->backing_dev_info
-	 * pointer, only decrease its reference count after having removed the
-	 * association with the block cgroup controller.
-	 */
-	bdi_put(q->backing_dev_info);
+	blk_exit_queue(q);
 
 	if (q->mq_ops)
 		blk_mq_free_queue(q);
diff --git a/block/blk.h b/block/blk.h
index 204a0345996c..ec914ae7130c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -130,6 +130,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 int blk_init_rl(struct request_list *rl, struct request_queue *q,
 		gfp_t gfp_mask);
 void blk_exit_rl(struct request_queue *q, struct request_list *rl);
+void blk_exit_queue(struct request_queue *q);
 void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 			struct bio *bio);
 void blk_queue_bypass_start(struct request_queue *q);
-- 
2.16.3
