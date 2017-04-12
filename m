Return-Path: <BATV+4e9b246676c62bade7ff+4980+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: remove blk_end_request_cur
Date: Wed, 12 Apr 2017 12:13:58 +0200
Message-Id: <20170412101359.7633-3-hch@lst.de>
In-Reply-To: <20170412101359.7633-1-hch@lst.de>
References: <20170412101359.7633-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This function is not used anywhere in the kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 18 ------------------
 include/linux/blkdev.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8aee417c1e4f..a01af9ca0455 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2838,24 +2838,6 @@ void blk_end_request_all(struct request *rq, int error)
 EXPORT_SYMBOL(blk_end_request_all);
 
 /**
- * blk_end_request_cur - Helper function to finish the current request chunk.
- * @rq: the request to finish the current chunk for
- * @error: %0 for success, < %0 for error
- *
- * Description:
- *     Complete the current consecutively mapped chunk from @rq.
- *
- * Return:
- *     %false - we are done with this request
- *     %true  - still buffers pending for this request
- */
-bool blk_end_request_cur(struct request *rq, int error)
-{
-	return blk_end_request(rq, error, blk_rq_cur_bytes(rq));
-}
-EXPORT_SYMBOL(blk_end_request_cur);
-
-/**
  * __blk_end_request - Helper function for drivers to complete the request.
  * @rq:       the request being processed
  * @error:    %0 for success, < %0 for error
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3b6201b1cd0e..f770a17d2fbf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1127,7 +1127,6 @@ extern void blk_finish_request(struct request *rq, int error);
 extern bool blk_end_request(struct request *rq, int error,
 			    unsigned int nr_bytes);
 extern void blk_end_request_all(struct request *rq, int error);
-extern bool blk_end_request_cur(struct request *rq, int error);
 extern bool __blk_end_request(struct request *rq, int error,
 			      unsigned int nr_bytes);
 extern void __blk_end_request_all(struct request *rq, int error);
-- 
2.11.0
