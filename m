Return-Path: <BATV+4e9b246676c62bade7ff+4980+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: make __blk_end_bidi_request private
Date: Wed, 12 Apr 2017 12:13:59 +0200
Message-Id: <20170412101359.7633-4-hch@lst.de>
In-Reply-To: <20170412101359.7633-1-hch@lst.de>
References: <20170412101359.7633-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

blk_insert_flush should be using __blk_end_request to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c  | 2 +-
 block/blk-flush.c | 2 +-
 block/blk.h       | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a01af9ca0455..518f5d189436 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2785,7 +2785,7 @@ static bool blk_end_bidi_request(struct request *rq, int error,
  *     %false - we are done with this request
  *     %true  - still buffers pending for this request
  **/
-bool __blk_end_bidi_request(struct request *rq, int error,
+static bool __blk_end_bidi_request(struct request *rq, int error,
 				   unsigned int nr_bytes, unsigned int bidi_bytes)
 {
 	if (blk_update_bidi_request(rq, error, nr_bytes, bidi_bytes))
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4e951d3bf548..c4e0880b54bb 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -447,7 +447,7 @@ void blk_insert_flush(struct request *rq)
 		if (q->mq_ops)
 			blk_mq_end_request(rq, 0);
 		else
-			__blk_end_bidi_request(rq, 0, 0, 0);
+			__blk_end_request(rq, 0, 0);
 		return;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 07d375183f31..35b3041eec1a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -67,8 +67,6 @@ void blk_queue_bypass_start(struct request_queue *q);
 void blk_queue_bypass_end(struct request_queue *q);
 void blk_dequeue_request(struct request *rq);
 void __blk_queue_free_tags(struct request_queue *q);
-bool __blk_end_bidi_request(struct request *rq, int error,
-			    unsigned int nr_bytes, unsigned int bidi_bytes);
 void blk_freeze_queue(struct request_queue *q);
 
 static inline void blk_queue_enter_live(struct request_queue *q)
-- 
2.11.0
