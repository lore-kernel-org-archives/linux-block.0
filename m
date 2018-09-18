Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v8 1/8] blk-mq: Document the functions that iterate over requests
Date: Tue, 18 Sep 2018 13:58:56 -0700
Message-Id: <20180918205903.15516-2-bvanassche@acm.org>
In-Reply-To: <20180918205903.15516-1-bvanassche@acm.org>
References: <20180918205903.15516-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Make it easier to understand the purpose of the functions that iterate
over requests by documenting their purpose. Fix two minor spelling
mistakes in comments in these functions.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq-tag.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 94e1ed667b6e..ef3acb4a80e0 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -232,13 +232,19 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
-	 * test and set the bit before assining ->rqs[].
+	 * test and set the bit before assigning ->rqs[].
 	 */
 	if (rq && rq->q == hctx->queue)
 		iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
 
+/*
+ * Call function @fn(@hctx, rq, @data, @reserved) for each request queued on
+ * @hctx that has been assigned a driver tag. @reserved indicates whether @bt
+ * is the breserved_tags member or the bitmap_tags member of struct
+ * blk_mq_tags.
+ */
 static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
 			busy_iter_fn *fn, void *data, bool reserved)
 {
@@ -280,6 +286,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	return true;
 }
 
+/*
+ * Call function @fn(rq, @data, @reserved) for each request in @tags that has
+ * been started. @reserved indicates whether @bt is the breserved_tags member
+ * or the bitmap_tags member of struct blk_mq_tags.
+ */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
 			     busy_tag_iter_fn *fn, void *data, bool reserved)
 {
@@ -294,6 +305,10 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
 		sbitmap_for_each_set(&bt->sb, bt_tags_iter, &iter_data);
 }
 
+/*
+ * Call @fn(rq, @priv, reserved) for each started request in @tags. 'reserved'
+ * indicates whether or not 'rq' is a reserved request.
+ */
 static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
@@ -302,6 +317,10 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
 }
 
+/*
+ * Call @fn(rq, @priv, reserved) for each request in @tagset. 'reserved'
+ * indicates whether or not 'rq' is a reserved request.
+ */
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
@@ -314,6 +333,11 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+/*
+ * Call @fn(rq, @priv, reserved) for each request associated with request
+ * queue @q or any queue it shares tags with and that has been assigned a
+ * driver tag. 'reserved' indicates whether or not 'rq' is a reserved request.
+ */
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv)
 {
@@ -337,7 +361,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		struct blk_mq_tags *tags = hctx->tags;
 
 		/*
-		 * If not software queues are currently mapped to this
+		 * If no software queues are currently mapped to this
 		 * hardware queue, there's nothing to check
 		 */
 		if (!blk_mq_hw_queue_mapped(hctx))
-- 
2.18.0
