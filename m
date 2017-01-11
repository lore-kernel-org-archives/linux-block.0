Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57359 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1761548AbdAKVkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:15 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 05/10] blk-mq: export some helpers we need to the scheduling framework
Date: Wed, 11 Jan 2017 14:39:58 -0700
Message-ID: <1484170803-9311-6-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 39 +++++++++++++++++++++------------------
 block/blk-mq.h | 25 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f49f6325b332..9fc521755e22 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -167,8 +167,8 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 }
 EXPORT_SYMBOL(blk_mq_can_queue);
 
-static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
-			       struct request *rq, unsigned int op)
+void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
+			struct request *rq, unsigned int op)
 {
 	INIT_LIST_HEAD(&rq->queuelist);
 	/* csd/requeue_work/fifo_time is initialized before use */
@@ -213,9 +213,10 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 
 	ctx->rq_dispatched[op_is_sync(op)]++;
 }
+EXPORT_SYMBOL_GPL(blk_mq_rq_ctx_init);
 
-static struct request *
-__blk_mq_alloc_request(struct blk_mq_alloc_data *data, unsigned int op)
+struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
+				       unsigned int op)
 {
 	struct request *rq;
 	unsigned int tag;
@@ -236,6 +237,7 @@ __blk_mq_alloc_request(struct blk_mq_alloc_data *data, unsigned int op)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(__blk_mq_alloc_request);
 
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		unsigned int flags)
@@ -319,8 +321,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
-				  struct blk_mq_ctx *ctx, struct request *rq)
+void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+			   struct request *rq)
 {
 	const int tag = rq->tag;
 	struct request_queue *q = rq->q;
@@ -802,7 +804,7 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
  * Process software queues that have been marked busy, splicing them
  * to the for-dispatch
  */
-static void flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
+void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 {
 	struct flush_busy_ctx_data data = {
 		.hctx = hctx,
@@ -811,6 +813,7 @@ static void flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 
 	sbitmap_for_each_set(&hctx->ctx_map, flush_busy_ctx, &data);
 }
+EXPORT_SYMBOL_GPL(blk_mq_flush_busy_ctxs);
 
 static inline unsigned int queued_to_index(unsigned int queued)
 {
@@ -921,7 +924,7 @@ static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
 	/*
 	 * Touch any software queue that has pending entries.
 	 */
-	flush_busy_ctxs(hctx, &rq_list);
+	blk_mq_flush_busy_ctxs(hctx, &rq_list);
 
 	/*
 	 * If we have previous entries on our dispatch list, grab them
@@ -1135,8 +1138,8 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 		list_add_tail(&rq->queuelist, &ctx->rq_list);
 }
 
-static void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx,
-				    struct request *rq, bool at_head)
+void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+			     bool at_head)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
@@ -1550,8 +1553,8 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	return cookie;
 }
 
-static void blk_mq_free_rq_map(struct blk_mq_tag_set *set,
-		struct blk_mq_tags *tags, unsigned int hctx_idx)
+void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+			unsigned int hctx_idx)
 {
 	struct page *page;
 
@@ -1588,8 +1591,8 @@ static size_t order_to_size(unsigned int order)
 	return (size_t)PAGE_SIZE << order;
 }
 
-static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
-		unsigned int hctx_idx)
+struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
+				       unsigned int hctx_idx)
 {
 	struct blk_mq_tags *tags;
 	unsigned int i, j, entries_per_page, max_order = 4;
@@ -2279,10 +2282,10 @@ static int blk_mq_queue_reinit_dead(unsigned int cpu)
  * Now CPU1 is just onlined and a request is inserted into ctx1->rq_list
  * and set bit0 in pending bitmap as ctx1->index_hw is still zero.
  *
- * And then while running hw queue, flush_busy_ctxs() finds bit0 is set in
- * pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
- * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list
- * is ignored.
+ * And then while running hw queue, blk_mq_flush_busy_ctxs() finds bit0 is set
+ * in pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
+ * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list is
+ * ignored.
  */
 static int blk_mq_queue_reinit_prepare(unsigned int cpu)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 63e9116cddbd..e59f5ca520a2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -32,6 +32,21 @@ void blk_mq_free_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *, struct list_head *);
+void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
+
+/*
+ * Internal helpers for allocating/freeing the request map
+ */
+void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+			unsigned int hctx_idx);
+struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
+					unsigned int hctx_idx);
+
+/*
+ * Internal helpers for request insertion into sw queues
+ */
+void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+				bool at_head);
 
 /*
  * CPU hotplug helpers
@@ -103,6 +118,16 @@ static inline void blk_mq_set_alloc_data(struct blk_mq_alloc_data *data,
 	data->hctx = hctx;
 }
 
+/*
+ * Internal helpers for request allocation/init/free
+ */
+void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
+			struct request *rq, unsigned int op);
+void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+				struct request *rq);
+struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
+					unsigned int op);
+
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
 	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
-- 
2.7.4

