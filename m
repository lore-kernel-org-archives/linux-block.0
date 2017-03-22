Return-Path: <BATV+90a41d470eb0ea9eda9a+4959+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@sandisk.com,
	linux-block@vger.kernel.org
Subject: [PATCH 4/5] blk-mq: split the plug and sync cases in blk_mq_make_request
Date: Wed, 22 Mar 2017 15:01:52 -0400
Message-Id: <20170322190153.12217-5-hch@lst.de>
In-Reply-To: <20170322190153.12217-1-hch@lst.de>
References: <20170322190153.12217-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now that we have a nice direct issue heper this helps simplifying
the code a bit, and also gets rid of the old_rq variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e82e1a9c7d5e..a9d2e02a8e02 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1569,32 +1569,32 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 		goto done;
-	} else if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
-		struct request *old_rq = NULL;
-
+	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
 		 * Otherwise the existing request in the plug list will be
 		 * issued. So the plug list will have one request at most
+		 * The plug list might get flushed before this. If that happens,
+		 * the plug list is empty, and same_queue_rq is invalid.
 		 */
-		if (plug) {
-			/*
-			 * The plug list might get flushed before this. If that
-			 * happens, same_queue_rq is invalid and plug list is
-			 * empty
-			 */
-			if (same_queue_rq && !list_empty(&plug->mq_list)) {
-				old_rq = same_queue_rq;
-				list_del_init(&old_rq->queuelist);
-			}
-			list_add_tail(&rq->queuelist, &plug->mq_list);
-		} else /* is_sync */
-			old_rq = rq;
+		if (list_empty(&plug->mq_list))
+			same_queue_rq = NULL;
+		if (same_queue_rq)
+			list_del_init(&same_queue_rq->queuelist);
+		list_add_tail(&rq->queuelist, &plug->mq_list);
+
+		blk_mq_put_ctx(data.ctx);
+		if (same_queue_rq)
+			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
+					&cookie);
+		goto done;
+	} else if (is_sync) {
+		blk_mq_bio_to_request(rq, bio);
+
 		blk_mq_put_ctx(data.ctx);
-		if (old_rq)
-			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
+		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 		goto done;
 	}
 
-- 
2.11.0
