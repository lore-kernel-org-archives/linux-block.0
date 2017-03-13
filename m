Return-Path: <BATV+b8442eb9fd62b0a9e465+4950+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/4] blk-mq: remove BLK_MQ_F_DEFER_ISSUE
Date: Mon, 13 Mar 2017 09:48:30 -0600
Message-Id: <20170313154833.14165-2-hch@lst.de>
In-Reply-To: <20170313154833.14165-1-hch@lst.de>
References: <20170313154833.14165-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This flag was never used since it was introduced.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 8 +-------
 include/linux/blk-mq.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 159187a28d66..acf0ddf4af52 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1534,13 +1534,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	}
 
 	plug = current->plug;
-	/*
-	 * If the driver supports defer issued based on 'last', then
-	 * queue it up like normal since we can potentially save some
-	 * CPU this way.
-	 */
-	if (((plug && !blk_queue_nomerges(q)) || is_sync) &&
-	    !(data.hctx->flags & BLK_MQ_F_DEFER_ISSUE)) {
+	if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
 		struct request *old_rq = NULL;
 
 		blk_mq_bio_to_request(rq, bio);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b296a9006117..5b3e201c8d4f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -152,7 +152,6 @@ enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
-	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.11.0
