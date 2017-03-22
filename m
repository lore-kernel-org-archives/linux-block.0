Return-Path: <BATV+90a41d470eb0ea9eda9a+4959+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@sandisk.com,
	linux-block@vger.kernel.org
Subject: [PATCH 1/5] blk-mq: remove BLK_MQ_F_DEFER_ISSUE
Date: Wed, 22 Mar 2017 15:01:49 -0400
Message-Id: <20170322190153.12217-2-hch@lst.de>
In-Reply-To: <20170322190153.12217-1-hch@lst.de>
References: <20170322190153.12217-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This flag was never used since it was introduced.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c         | 8 +-------
 include/linux/blk-mq.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ff66f203cd0..998c041358f2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1531,13 +1531,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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
