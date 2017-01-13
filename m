Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdAMIaw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 03:30:52 -0500
Date: Fri, 13 Jan 2017 00:30:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        osandov@osandov.com, bart.vanassche@sandisk.com
Subject: Re: [PATCH 06/10] blk-mq-tag: cleanup the normal/reserved tag
 allocation
Message-ID: <20170113083051.GD637@infradead.org>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-7-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484170803-9311-7-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 11, 2017 at 02:39:59PM -0700, Jens Axboe wrote:
> This is in preparation for having another tag set available. Cleanup
> the parameters, and allow passing in of tags fo blk_mq_put_tag().

I've been playing around with this are a bit but never submitted
anything.  Below is an untested merge of my previous bits with your
patch, let me know what you think about it:

---
>From c9ea92bfb468e9116149db95d246e48ace2b87f1 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@fb.com>
Date: Wed, 11 Jan 2017 11:04:53 -0700
Subject: blk-mq-tag: cleanup the normal/reserved tag allocation

This is in preparation for having another tag set available. Cleanup
the parameters, and allow passing in of tags for blk_mq_put_tag().

Signed-off-by: Jens Axboe <axboe@fb.com>
[hch: even more cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c | 94 +++++++++++++++++++++---------------------------------
 block/blk-mq-tag.h |  4 +--
 block/blk-mq.c     |  2 +-
 block/blk-mq.h     |  5 +++
 4 files changed, 44 insertions(+), 61 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index dcf5ce3..ced7527 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -90,32 +90,46 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return atomic_read(&hctx->nr_active) < depth;
 }
 
-static int __bt_get(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt)
+static int __blk_mq_get_tag(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt)
 {
 	if (!hctx_may_queue(hctx, bt))
 		return -1;
 	return __sbitmap_queue_get(bt);
 }
 
-static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
-		  struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags)
+unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 {
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+	struct sbitmap_queue *bt;
 	struct sbq_wait_state *ws;
 	DEFINE_WAIT(wait);
+	unsigned int tag_offset;
 	int tag;
 
-	tag = __bt_get(hctx, bt);
+	if (data->flags & BLK_MQ_REQ_RESERVED) {
+		if (unlikely(!tags->nr_reserved_tags)) {
+			WARN_ON_ONCE(1);
+			return BLK_MQ_TAG_FAIL;
+		}
+		bt = &tags->breserved_tags;
+		tag_offset = 0;
+	} else {
+		bt = &tags->bitmap_tags;
+		tag_offset = tags->nr_reserved_tags;
+	}
+
+	tag = __blk_mq_get_tag(data->hctx, bt);
 	if (tag != -1)
-		return tag;
+		goto found_tag;
 
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
-		return -1;
+		return BLK_MQ_TAG_FAIL;
 
-	ws = bt_wait_ptr(bt, hctx);
+	ws = bt_wait_ptr(bt, data->hctx);
 	do {
 		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __bt_get(hctx, bt);
+		tag = __blk_mq_get_tag(data->hctx, bt);
 		if (tag != -1)
 			break;
 
@@ -125,14 +139,14 @@ static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
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
+		tag = __blk_mq_get_tag(data->hctx, bt);
 		if (tag != -1)
 			break;
 
@@ -142,61 +156,25 @@ static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
 
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->ctx->cpu);
-		if (data->flags & BLK_MQ_REQ_RESERVED) {
-			bt = &data->hctx->tags->breserved_tags;
-		} else {
-			hctx = data->hctx;
-			bt = &hctx->tags->bitmap_tags;
-		}
+		tags = blk_mq_tags_from_data(data);
+		if (data->flags & BLK_MQ_REQ_RESERVED)
+			bt = &tags->breserved_tags;
+		else
+			bt = &tags->bitmap_tags;
+
 		finish_wait(&ws->wait, &wait);
-		ws = bt_wait_ptr(bt, hctx);
+		ws = bt_wait_ptr(bt, data->hctx);
 	} while (1);
 
 	finish_wait(&ws->wait, &wait);
-	return tag;
-}
-
-static unsigned int __blk_mq_get_tag(struct blk_mq_alloc_data *data)
-{
-	int tag;
-
-	tag = bt_get(data, &data->hctx->tags->bitmap_tags, data->hctx,
-		     data->hctx->tags);
-	if (tag >= 0)
-		return tag + data->hctx->tags->nr_reserved_tags;
-
-	return BLK_MQ_TAG_FAIL;
-}
-
-static unsigned int __blk_mq_get_reserved_tag(struct blk_mq_alloc_data *data)
-{
-	int tag;
 
-	if (unlikely(!data->hctx->tags->nr_reserved_tags)) {
-		WARN_ON_ONCE(1);
-		return BLK_MQ_TAG_FAIL;
-	}
-
-	tag = bt_get(data, &data->hctx->tags->breserved_tags, NULL,
-		     data->hctx->tags);
-	if (tag < 0)
-		return BLK_MQ_TAG_FAIL;
-
-	return tag;
+found_tag:
+	return tag + tag_offset;
 }
 
-unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
+void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
+		    struct blk_mq_ctx *ctx, unsigned int tag)
 {
-	if (data->flags & BLK_MQ_REQ_RESERVED)
-		return __blk_mq_get_reserved_tag(data);
-	return __blk_mq_get_tag(data);
-}
-
-void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-		    unsigned int tag)
-{
-	struct blk_mq_tags *tags = hctx->tags;
-
 	if (tag >= tags->nr_reserved_tags) {
 		const int real_tag = tag - tags->nr_reserved_tags;
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d166273..923602d 100644
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
index 9fc5217..6fab8e9 100644
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
index e59f5ca..48b7771 100644
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
2.1.4

