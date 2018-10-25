Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/28] block: kill lld busy
Date: Thu, 25 Oct 2018 15:10:34 -0600
Message-Id: <20181025211039.11559-24-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Nobody sets the helper, so we always return 0. Kill it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 28 ----------------------------
 block/blk-settings.c   |  6 ------
 drivers/md/dm-mpath.c  |  4 +---
 include/linux/blkdev.h |  4 ----
 4 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4c39c7865f9c..dd1328f4dc31 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1795,34 +1795,6 @@ void rq_flush_dcache_pages(struct request *rq)
 EXPORT_SYMBOL_GPL(rq_flush_dcache_pages);
 #endif
 
-/**
- * blk_lld_busy - Check if underlying low-level drivers of a device are busy
- * @q : the queue of the device being checked
- *
- * Description:
- *    Check if underlying low-level drivers of a device are busy.
- *    If the drivers want to export their busy state, they must set own
- *    exporting function using blk_queue_lld_busy() first.
- *
- *    Basically, this function is used only by request stacking drivers
- *    to stop dispatching requests to underlying devices when underlying
- *    devices are busy.  This behavior helps more I/O merging on the queue
- *    of the request stacking driver and prevents I/O throughput regression
- *    on burst I/O load.
- *
- * Return:
- *    0 - Not busy (The request stacking driver should dispatch request)
- *    1 - Busy (The request stacking driver should stop dispatching request)
- */
-int blk_lld_busy(struct request_queue *q)
-{
-	if (q->lld_busy_fn)
-		return q->lld_busy_fn(q);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(blk_lld_busy);
-
 /**
  * blk_rq_unprep_clone - Helper function to free all bios in a cloned request
  * @rq: the clone request to be cleaned up
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 3c5da75c2def..1895f499bbe5 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -32,12 +32,6 @@ void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
 
-void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn)
-{
-	q->lld_busy_fn = fn;
-}
-EXPORT_SYMBOL_GPL(blk_queue_lld_busy);
-
 /**
  * blk_set_default_limits - reset limits to default values
  * @lim:  the queue_limits structure to reset
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index a24ed3973e7c..4d736e0fd67f 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1936,9 +1936,7 @@ static int multipath_iterate_devices(struct dm_target *ti,
 
 static int pgpath_busy(struct pgpath *pgpath)
 {
-	struct request_queue *q = bdev_get_queue(pgpath->path.dev->bdev);
-
-	return blk_lld_busy(q);
+	return 0;
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bfe40de81c19..115199e7c581 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -312,7 +312,6 @@ typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
 struct bio_vec;
 typedef void (softirq_done_fn)(struct request *);
 typedef int (dma_drain_needed_fn)(struct request *);
-typedef int (lld_busy_fn) (struct request_queue *q);
 typedef int (bsg_job_fn) (struct bsg_job *);
 typedef int (init_rq_fn)(struct request_queue *, struct request *, gfp_t);
 typedef void (exit_rq_fn)(struct request_queue *, struct request *);
@@ -443,7 +442,6 @@ struct request_queue {
 	poll_q_fn		*poll_fn;
 	softirq_done_fn		*softirq_done_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
-	lld_busy_fn		*lld_busy_fn;
 	/* Called just after a request is allocated */
 	init_rq_fn		*init_rq_fn;
 	/* Called just before a request is freed */
@@ -909,7 +907,6 @@ extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 extern void blk_put_request(struct request *);
 extern struct request *blk_get_request(struct request_queue *, unsigned int op,
 				       blk_mq_req_flags_t flags);
-extern int blk_lld_busy(struct request_queue *q);
 extern int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 			     struct bio_set *bs, gfp_t gfp_mask,
 			     int (*bio_ctr)(struct bio *, struct bio *, void *),
@@ -1152,7 +1149,6 @@ extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
 extern int blk_queue_dma_drain(struct request_queue *q,
 			       dma_drain_needed_fn *dma_drain_needed,
 			       void *buf, unsigned int size);
-extern void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn);
 extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_dma_alignment(struct request_queue *, int);
-- 
2.17.1
