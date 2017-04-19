Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, =?UTF-8?q?Matias=20Bj=C3=B8rling?=
	<m@bjorling.me>
Subject: [PATCH v2 4/5] block: Inline blk_rq_set_prio()
Date: Wed, 19 Apr 2017 14:01:27 -0700
Message-ID: <20170419210128.28374-5-bart.vanassche@sandisk.com>
In-Reply-To: <20170419210128.28374-1-bart.vanassche@sandisk.com>
References: <20170419210128.28374-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since only a single caller remains, inline blk_rq_set_prio(). Initialize
req->ioprio even if no I/O priority has been set in the bio nor in the
I/O context.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Adam Manzanares <adam.manzanares@wdc.com>
Tested-by: Adam Manzanares <adam.manzanares@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Matias Bjørling <m@bjorling.me>
---
 block/blk-core.c       |  7 ++++++-
 include/linux/blkdev.h | 14 --------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ec2330113bea..4f0fd8f3328d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1630,14 +1630,19 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 
 void blk_init_request_from_bio(struct request *req, struct bio *bio)
 {
+	struct io_context *ioc = rq_ioc(bio);
+
 	if (bio->bi_opf & REQ_RAHEAD)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
 	req->errors = 0;
 	req->__sector = bio->bi_iter.bi_sector;
-	blk_rq_set_prio(req, rq_ioc(bio));
 	if (ioprio_valid(bio_prio(bio)))
 		req->ioprio = bio_prio(bio);
+	else if (ioc)
+		req->ioprio = ioc->ioprio;
+	else
+		req->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 	blk_rq_bio_prep(req->q, req, bio);
 }
 EXPORT_SYMBOL_GPL(blk_init_request_from_bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index be3abaee935e..92894995f4b7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1088,20 +1088,6 @@ static inline unsigned int blk_rq_count_bios(struct request *rq)
 }
 
 /*
- * blk_rq_set_prio - associate a request with prio from ioc
- * @rq: request of interest
- * @ioc: target iocontext
- *
- * Assocate request prio with ioc prio so request based drivers
- * can leverage priority information.
- */
-static inline void blk_rq_set_prio(struct request *rq, struct io_context *ioc)
-{
-	if (ioc)
-		rq->ioprio = ioc->ioprio;
-}
-
-/*
  * Request issue related functions.
  */
 extern struct request *blk_peek_request(struct request_queue *q);
-- 
2.12.2
