Return-Path: <prvs=407fe0e57=damien.lemoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: [PATCH] block: Make blk_dequeue_request() static
Date: Tue, 29 Aug 2017 11:54:37 +0900
Message-Id: <20170829025437.26726-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The only caller of this function is blk_start_request() in the same
file. Fix blk_start_request() description accordingly.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c | 5 +----
 block/blk.h      | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fc1af9097dff..d709c0e3a2ac 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2615,7 +2615,7 @@ struct request *blk_peek_request(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_peek_request);
 
-void blk_dequeue_request(struct request *rq)
+static void blk_dequeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
@@ -2642,9 +2642,6 @@ void blk_dequeue_request(struct request *rq)
  * Description:
  *     Dequeue @req and start timeout timer on it.  This hands off the
  *     request to the driver.
- *
- *     Block internal functions which don't want to start timer should
- *     call blk_dequeue_request().
  */
 void blk_start_request(struct request *req)
 {
diff --git a/block/blk.h b/block/blk.h
index fde8b351c166..fcb9775b997d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -64,7 +64,6 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 			struct bio *bio);
 void blk_queue_bypass_start(struct request_queue *q);
 void blk_queue_bypass_end(struct request_queue *q);
-void blk_dequeue_request(struct request *rq);
 void __blk_queue_free_tags(struct request_queue *q);
 void blk_freeze_queue(struct request_queue *q);
 
-- 
2.13.5
