Return-Path: <BATV+4e9b246676c62bade7ff+4980+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: remove blk_end_request_err and __blk_end_request_err
Date: Wed, 12 Apr 2017 12:13:57 +0200
Message-Id: <20170412101359.7633-2-hch@lst.de>
In-Reply-To: <20170412101359.7633-1-hch@lst.de>
References: <20170412101359.7633-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Both functions are entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 39 ---------------------------------------
 include/linux/blkdev.h |  2 --
 2 files changed, 41 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4f95bdaa1e16..8aee417c1e4f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2856,25 +2856,6 @@ bool blk_end_request_cur(struct request *rq, int error)
 EXPORT_SYMBOL(blk_end_request_cur);
 
 /**
- * blk_end_request_err - Finish a request till the next failure boundary.
- * @rq: the request to finish till the next failure boundary for
- * @error: must be negative errno
- *
- * Description:
- *     Complete @rq till the next failure boundary.
- *
- * Return:
- *     %false - we are done with this request
- *     %true  - still buffers pending for this request
- */
-bool blk_end_request_err(struct request *rq, int error)
-{
-	WARN_ON(error >= 0);
-	return blk_end_request(rq, error, blk_rq_err_bytes(rq));
-}
-EXPORT_SYMBOL_GPL(blk_end_request_err);
-
-/**
  * __blk_end_request - Helper function for drivers to complete the request.
  * @rq:       the request being processed
  * @error:    %0 for success, < %0 for error
@@ -2933,26 +2914,6 @@ bool __blk_end_request_cur(struct request *rq, int error)
 }
 EXPORT_SYMBOL(__blk_end_request_cur);
 
-/**
- * __blk_end_request_err - Finish a request till the next failure boundary.
- * @rq: the request to finish till the next failure boundary for
- * @error: must be negative errno
- *
- * Description:
- *     Complete @rq till the next failure boundary.  Must be called
- *     with queue lock held.
- *
- * Return:
- *     %false - we are done with this request
- *     %true  - still buffers pending for this request
- */
-bool __blk_end_request_err(struct request *rq, int error)
-{
-	WARN_ON(error >= 0);
-	return __blk_end_request(rq, error, blk_rq_err_bytes(rq));
-}
-EXPORT_SYMBOL_GPL(__blk_end_request_err);
-
 void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 		     struct bio *bio)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f912ddc39020..3b6201b1cd0e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1128,12 +1128,10 @@ extern bool blk_end_request(struct request *rq, int error,
 			    unsigned int nr_bytes);
 extern void blk_end_request_all(struct request *rq, int error);
 extern bool blk_end_request_cur(struct request *rq, int error);
-extern bool blk_end_request_err(struct request *rq, int error);
 extern bool __blk_end_request(struct request *rq, int error,
 			      unsigned int nr_bytes);
 extern void __blk_end_request_all(struct request *rq, int error);
 extern bool __blk_end_request_cur(struct request *rq, int error);
-extern bool __blk_end_request_err(struct request *rq, int error);
 
 extern void blk_complete_request(struct request *);
 extern void __blk_complete_request(struct request *);
-- 
2.11.0
