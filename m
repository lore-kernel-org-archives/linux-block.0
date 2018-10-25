Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/28] block: remove blk_complete_request()
Date: Thu, 25 Oct 2018 15:10:25 -0600
Message-Id: <20181025211039.11559-15-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

It's now unused.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-softirq.c    | 20 --------------------
 include/linux/blkdev.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index e47a2f751884..8ca0f6caf174 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -145,26 +145,6 @@ void __blk_complete_request(struct request *req)
 }
 EXPORT_SYMBOL(__blk_complete_request);
 
-/**
- * blk_complete_request - end I/O on a request
- * @req:      the request being processed
- *
- * Description:
- *     Ends all I/O on a request. It does not handle partial completions,
- *     unless the driver actually implements this in its completion callback
- *     through requeueing. The actual completion happens out-of-order,
- *     through a softirq handler. The user must have registered a completion
- *     callback through blk_queue_softirq_done().
- **/
-void blk_complete_request(struct request *req)
-{
-	if (unlikely(blk_should_fake_timeout(req->q)))
-		return;
-	if (!blk_mark_rq_complete(req))
-		__blk_complete_request(req);
-}
-EXPORT_SYMBOL(blk_complete_request);
-
 static __init int blk_softirq_init(void)
 {
 	int i;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4293dc1cd160..9ff9ab6fc1fe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1205,7 +1205,6 @@ extern bool __blk_end_request(struct request *rq, blk_status_t error,
 extern void __blk_end_request_all(struct request *rq, blk_status_t error);
 extern bool __blk_end_request_cur(struct request *rq, blk_status_t error);
 
-extern void blk_complete_request(struct request *);
 extern void __blk_complete_request(struct request *);
 extern void blk_abort_request(struct request *);
 extern void blk_unprep_request(struct request *);
-- 
2.17.1
