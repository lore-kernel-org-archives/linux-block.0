Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/29] block: remove q->lld_busy_fn()
Date: Mon, 29 Oct 2018 10:34:25 -0600
Message-Id: <20181029163444.9940-11-axboe@kernel.dk>
In-Reply-To: <20181029163444.9940-1-axboe@kernel.dk>
References: <20181029163444.9940-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Nobody is using the legacy path for blk_lld_busy() anymore, remove
it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 2 --
 block/blk-settings.c   | 6 ------
 include/linux/blkdev.h | 3 ---
 3 files changed, 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c99088d0e80b..5044a1c41493 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3427,8 +3427,6 @@ EXPORT_SYMBOL_GPL(rq_flush_dcache_pages);
  */
 int blk_lld_busy(struct request_queue *q)
 {
-	if (q->lld_busy_fn)
-		return q->lld_busy_fn(q);
 	if (q->mq_ops && q->mq_ops->busy)
 		return q->mq_ops->busy(q);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index ffd459969689..82b31fb2888c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -73,12 +73,6 @@ void blk_queue_rq_timed_out(struct request_queue *q, rq_timed_out_fn *fn)
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timed_out);
 
-void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn)
-{
-	q->lld_busy_fn = fn;
-}
-EXPORT_SYMBOL_GPL(blk_queue_lld_busy);
-
 /**
  * blk_set_default_limits - reset limits to default values
  * @lim:  the queue_limits structure to reset
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4293dc1cd160..e867733b761d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -320,7 +320,6 @@ typedef void (unprep_rq_fn) (struct request_queue *, struct request *);
 struct bio_vec;
 typedef void (softirq_done_fn)(struct request *);
 typedef int (dma_drain_needed_fn)(struct request *);
-typedef int (lld_busy_fn) (struct request_queue *q);
 typedef int (bsg_job_fn) (struct bsg_job *);
 typedef int (init_rq_fn)(struct request_queue *, struct request *, gfp_t);
 typedef void (exit_rq_fn)(struct request_queue *, struct request *);
@@ -466,7 +465,6 @@ struct request_queue {
 	softirq_done_fn		*softirq_done_fn;
 	rq_timed_out_fn		*rq_timed_out_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
-	lld_busy_fn		*lld_busy_fn;
 	/* Called just after a request is allocated */
 	init_rq_fn		*init_rq_fn;
 	/* Called just before a request is freed */
@@ -1255,7 +1253,6 @@ extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
 extern int blk_queue_dma_drain(struct request_queue *q,
 			       dma_drain_needed_fn *dma_drain_needed,
 			       void *buf, unsigned int size);
-extern void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn);
 extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_prep_rq(struct request_queue *, prep_rq_fn *pfn);
-- 
2.17.1
