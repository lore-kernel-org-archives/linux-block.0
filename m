Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1761543AbdAKVkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:15 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 06/10] blk-mq-tag: cleanup the normal/reserved tag allocation
Date: Wed, 11 Jan 2017 14:39:59 -0700
Message-ID: <1484170803-9311-7-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is in preparation for having another tag set available. Cleanup
the parameters, and allow passing in of tags fo blk_mq_put_tag().

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-tag.c | 58 ++++++++++++++++++++++++++++++------------------------
 block/blk-mq-tag.h |  4 ++--
 block/blk-mq.c     |  2 +-
 block/blk-mq.h     |  5 +++++
 4 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index dcf5ce3ba4bf..0ff8df347bfb 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -97,25 +97,35 @@ static int __bt_get(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt)
 	return __sbitmap_queue_get(bt);
 }
 
-static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
-		  struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags)
+static struct sbitmap_queue *bt_from_data(struct blk_mq_alloc_data *data)
 {
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		return &tags->breserved_tags;
+
+	return &tags->bitmap_tags;
+}
+
+static int bt_get(struct blk_mq_alloc_data *data)
+{
+	struct sbitmap_queue *bt = bt_from_data(data);
 	struct sbq_wait_state *ws;
 	DEFINE_WAIT(wait);
 	int tag;
 
-	tag = __bt_get(hctx, bt);
+	tag = __bt_get(data->hctx, bt);
 	if (tag != -1)
 		return tag;
 
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
 		return -1;
 
-	ws = bt_wait_ptr(bt, hctx);
+	ws = bt_wait_ptr(bt, data->hctx);
 	do {
 		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __bt_get(hctx, bt);
+		tag = __bt_get(data->hctx, bt);
 		if (tag != -1)
 			break;
 
@@ -125,14 +135,14 @@ static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
 		 * some to complete. Note that hctx can be NULL here for
 		 * reserved tag allocation.
 		 */
-		if (hctx)
-			blk_mq_run_hw_queue(hctx, false);
+		if (data->hctx)
+			blk_mq_run_hw_queue(data->hctx, false);
 
 		/*
 		 * Retry tag allocation after running the hardware queue,
 		 * as running the queue may also have found completions.
 		 */
-		tag = __bt_get(hctx, bt);
+		tag = __bt_get(data->hctx, bt);
 		if (tag != -1)
 			break;
 
@@ -142,14 +152,10 @@ static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
 
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->ctx->cpu);
-		if (data->flags & BLK_MQ_REQ_RESERVED) {
-			bt = &data->hctx->tags->breserved_tags;
-		} else {
-			hctx = data->hctx;
-			bt = &hctx->tags->bitmap_tags;
-		}
+		bt = bt_from_data(data);
+
 		finish_wait(&ws->wait, &wait);
-		ws = bt_wait_ptr(bt, hctx);
+		ws = bt_wait_ptr(bt, data->hctx);
 	} while (1);
 
 	finish_wait(&ws->wait, &wait);
@@ -160,25 +166,27 @@ static unsigned int __blk_mq_get_tag(struct blk_mq_alloc_data *data)
 {
 	int tag;
 
-	tag = bt_get(data, &data->hctx->tags->bitmap_tags, data->hctx,
-		     data->hctx->tags);
-	if (tag >= 0)
-		return tag + data->hctx->tags->nr_reserved_tags;
+	tag = bt_get(data);
+	if (tag >= 0) {
+		struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+
+		return tag + tags->nr_reserved_tags;
+	}
 
 	return BLK_MQ_TAG_FAIL;
 }
 
 static unsigned int __blk_mq_get_reserved_tag(struct blk_mq_alloc_data *data)
 {
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	int tag;
 
-	if (unlikely(!data->hctx->tags->nr_reserved_tags)) {
+	if (unlikely(!tags->nr_reserved_tags)) {
 		WARN_ON_ONCE(1);
 		return BLK_MQ_TAG_FAIL;
 	}
 
-	tag = bt_get(data, &data->hctx->tags->breserved_tags, NULL,
-		     data->hctx->tags);
+	tag = bt_get(data);
 	if (tag < 0)
 		return BLK_MQ_TAG_FAIL;
 
@@ -192,11 +200,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return __blk_mq_get_tag(data);
 }
 
-void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-		    unsigned int tag)
+void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
+		    struct blk_mq_ctx *ctx, unsigned int tag)
 {
-	struct blk_mq_tags *tags = hctx->tags;
-
 	if (tag >= tags->nr_reserved_tags) {
 		const int real_tag = tag - tags->nr_reserved_tags;
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d1662734dc53..923602dd3bfb 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -24,8 +24,8 @@ extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int r
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
-extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-			   unsigned int tag);
+extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
+			   struct blk_mq_ctx *ctx, unsigned int tag);
 extern bool blk_mq_has_free_tags(struct blk_mq_tags *tags);
 extern ssize_t blk_mq_tag_sysfs_show(struct blk_mq_tags *tags, char *page);
 extern int blk_mq_tag_update_depth(struct blk_mq_tags *tags, unsigned int depth);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9fc521755e22..6fab8e9c724f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -335,7 +335,7 @@ void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
 	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
-	blk_mq_put_tag(hctx, ctx, tag);
+	blk_mq_put_tag(hctx, hctx->tags, ctx, tag);
 	blk_queue_exit(q);
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e59f5ca520a2..48b7771eb192 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -118,6 +118,11 @@ static inline void blk_mq_set_alloc_data(struct blk_mq_alloc_data *data,
 	data->hctx = hctx;
 }
 
+static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
+{
+	return data->hctx->tags;
+}
+
 /*
  * Internal helpers for request allocation/init/free
  */
-- 
2.7.4

