Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35983 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbcIISmb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2016 14:42:31 -0400
Received: by mail-pa0-f48.google.com with SMTP id id6so30774515pad.3
        for <linux-block@vger.kernel.org>; Fri, 09 Sep 2016 11:42:31 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v3 3/5] sbitmap: push per-cpu last_tag into sbitmap_queue
Date: Fri,  9 Sep 2016 11:42:09 -0700
Message-Id: <4f44d1bcb1f102559375d174bcf1e38d7b5af235.1473446095.git.osandov@fb.com>
In-Reply-To: <cover.1473446095.git.osandov@fb.com>
References: <cover.1473446095.git.osandov@fb.com>
In-Reply-To: <cover.1473446095.git.osandov@fb.com>
References: <cover.1473446095.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Allocating your own per-cpu allocation hint separately makes for an
awkward API. Instead, allocate the per-cpu hint as part of the struct
sbitmap_queue. There's no point for a struct sbitmap_queue without the
cache, but you can still use a bare struct sbitmap.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-tag.c      | 37 +++++++++++++++++-------------------
 block/blk-mq-tag.h      |  3 ++-
 block/blk-mq.c          |  2 +-
 block/blk-mq.h          |  2 --
 include/linux/sbitmap.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++-
 lib/sbitmap.c           | 16 ++++++++++++++--
 6 files changed, 83 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 83ee740..c9a22db 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -94,23 +94,21 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 #define BT_ALLOC_RR(tags) (tags->alloc_policy == BLK_TAG_ALLOC_RR)
 
 static int __bt_get(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-		    unsigned int *tag_cache, struct blk_mq_tags *tags)
+		    struct blk_mq_tags *tags)
 {
 	if (!hctx_may_queue(hctx, bt))
 		return -1;
-	return sbitmap_get(&bt->sb, tag_cache, BT_ALLOC_RR(tags));
+	return __sbitmap_queue_get(bt, BT_ALLOC_RR(tags));
 }
 
-static int bt_get(struct blk_mq_alloc_data *data,
-		  struct sbitmap_queue *bt,
-		  struct blk_mq_hw_ctx *hctx,
-		  unsigned int *last_tag, struct blk_mq_tags *tags)
+static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
+		  struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags)
 {
 	struct sbq_wait_state *ws;
 	DEFINE_WAIT(wait);
 	int tag;
 
-	tag = __bt_get(hctx, bt, last_tag, tags);
+	tag = __bt_get(hctx, bt, tags);
 	if (tag != -1)
 		return tag;
 
@@ -121,7 +119,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 	do {
 		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __bt_get(hctx, bt, last_tag, tags);
+		tag = __bt_get(hctx, bt, tags);
 		if (tag != -1)
 			break;
 
@@ -138,7 +136,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 		 * Retry tag allocation after running the hardware queue,
 		 * as running the queue may also have found completions.
 		 */
-		tag = __bt_get(hctx, bt, last_tag, tags);
+		tag = __bt_get(hctx, bt, tags);
 		if (tag != -1)
 			break;
 
@@ -152,7 +150,6 @@ static int bt_get(struct blk_mq_alloc_data *data,
 		if (data->flags & BLK_MQ_REQ_RESERVED) {
 			bt = &data->hctx->tags->breserved_tags;
 		} else {
-			last_tag = &data->ctx->last_tag;
 			hctx = data->hctx;
 			bt = &hctx->tags->bitmap_tags;
 		}
@@ -169,7 +166,7 @@ static unsigned int __blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	int tag;
 
 	tag = bt_get(data, &data->hctx->tags->bitmap_tags, data->hctx,
-			&data->ctx->last_tag, data->hctx->tags);
+		     data->hctx->tags);
 	if (tag >= 0)
 		return tag + data->hctx->tags->nr_reserved_tags;
 
@@ -178,15 +175,15 @@ static unsigned int __blk_mq_get_tag(struct blk_mq_alloc_data *data)
 
 static unsigned int __blk_mq_get_reserved_tag(struct blk_mq_alloc_data *data)
 {
-	int tag, zero = 0;
+	int tag;
 
 	if (unlikely(!data->hctx->tags->nr_reserved_tags)) {
 		WARN_ON_ONCE(1);
 		return BLK_MQ_TAG_FAIL;
 	}
 
-	tag = bt_get(data, &data->hctx->tags->breserved_tags, NULL, &zero,
-		data->hctx->tags);
+	tag = bt_get(data, &data->hctx->tags->breserved_tags, NULL,
+		     data->hctx->tags);
 	if (tag < 0)
 		return BLK_MQ_TAG_FAIL;
 
@@ -200,8 +197,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return __blk_mq_get_tag(data);
 }
 
-void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag,
-		    unsigned int *last_tag)
+void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+		    unsigned int tag)
 {
 	struct blk_mq_tags *tags = hctx->tags;
 
@@ -209,12 +206,12 @@ void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag,
 		const int real_tag = tag - tags->nr_reserved_tags;
 
 		BUG_ON(real_tag >= tags->nr_tags);
-		sbitmap_queue_clear(&tags->bitmap_tags, real_tag);
-		if (likely(tags->alloc_policy == BLK_TAG_ALLOC_FIFO))
-			*last_tag = real_tag;
+		sbitmap_queue_clear(&tags->bitmap_tags, real_tag,
+				    BT_ALLOC_RR(tags), ctx->cpu);
 	} else {
 		BUG_ON(tag >= tags->nr_reserved_tags);
-		sbitmap_queue_clear(&tags->breserved_tags, tag);
+		sbitmap_queue_clear(&tags->breserved_tags, tag,
+				    BT_ALLOC_RR(tags), ctx->cpu);
 	}
 }
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 3215c08..2b1d52e 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -27,7 +27,8 @@ extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int r
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
-extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag, unsigned int *last_tag);
+extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+			   unsigned int tag);
 extern bool blk_mq_has_free_tags(struct blk_mq_tags *tags);
 extern ssize_t blk_mq_tag_sysfs_show(struct blk_mq_tags *tags, char *page);
 extern void blk_mq_tag_init_last_tag(struct blk_mq_tags *tags, unsigned int *last_tag);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9dbe37f..004728f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -302,7 +302,7 @@ static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
 	rq->cmd_flags = 0;
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
-	blk_mq_put_tag(hctx, tag, &ctx->last_tag);
+	blk_mq_put_tag(hctx, ctx, tag);
 	blk_queue_exit(q);
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 71831f9..9b15d2e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -12,8 +12,6 @@ struct blk_mq_ctx {
 	unsigned int		cpu;
 	unsigned int		index_hw;
 
-	unsigned int		last_tag ____cacheline_aligned_in_smp;
-
 	/* incremented at dispatch time */
 	unsigned long		rq_dispatched[2];
 	unsigned long		rq_merged;
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 14ab20a..c0f0cf6 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -99,6 +99,14 @@ struct sbitmap_queue {
 	 */
 	struct sbitmap sb;
 
+	/*
+	 * @alloc_hint: Cache of last successfully allocated or freed bit.
+	 *
+	 * This is per-cpu, which allows multiple users to stick to different
+	 * cachelines until the map is exhausted.
+	 */
+	unsigned int __percpu *alloc_hint;
+
 	/**
 	 * @wake_batch: Number of bits which must be freed before we wake up any
 	 * waiters.
@@ -269,6 +277,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
 {
 	kfree(sbq->ws);
+	free_percpu(sbq->alloc_hint);
 	sbitmap_free(&sbq->sb);
 }
 
@@ -284,12 +293,51 @@ static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
 void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth);
 
 /**
+ * __sbitmap_queue_get() - Try to allocate a free bit from a &struct
+ * sbitmap_queue with preemption already disabled.
+ * @sbq: Bitmap queue to allocate from.
+ * @round_robin: See sbitmap_get().
+ *
+ * Return: Non-negative allocated bit number if successful, -1 otherwise.
+ */
+static inline int __sbitmap_queue_get(struct sbitmap_queue *sbq,
+				      bool round_robin)
+{
+	return sbitmap_get(&sbq->sb, this_cpu_ptr(sbq->alloc_hint),
+			   round_robin);
+}
+
+/**
+ * sbitmap_queue_get() - Try to allocate a free bit from a &struct
+ * sbitmap_queue.
+ * @sbq: Bitmap queue to allocate from.
+ * @round_robin: See sbitmap_get().
+ * @cpu: Output parameter; will contain the CPU we ran on (e.g., to be passed to
+ *       sbitmap_queue_clear()).
+ *
+ * Return: Non-negative allocated bit number if successful, -1 otherwise.
+ */
+static inline int sbitmap_queue_get(struct sbitmap_queue *sbq, bool round_robin,
+				    unsigned int *cpu)
+{
+	int nr;
+
+	*cpu = get_cpu();
+	nr = __sbitmap_queue_get(sbq, round_robin);
+	put_cpu();
+	return nr;
+}
+
+/**
  * sbitmap_queue_clear() - Free an allocated bit and wake up waiters on a
  * &struct sbitmap_queue.
  * @sbq: Bitmap to free from.
  * @nr: Bit number to free.
+ * @round_robin: See sbitmap_get().
+ * @cpu: CPU the bit was allocated on.
  */
-void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr);
+void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
+			 bool round_robin, unsigned int cpu);
 
 static inline int sbq_index_inc(int index)
 {
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 213d831..261543c 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -202,6 +202,12 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	if (ret)
 		return ret;
 
+	sbq->alloc_hint = alloc_percpu_gfp(unsigned int, flags);
+	if (!sbq->alloc_hint) {
+		sbitmap_free(&sbq->sb);
+		return -ENOMEM;
+	}
+
 	sbq->wake_batch = SBQ_WAKE_BATCH;
 	if (sbq->wake_batch > depth / SBQ_WAIT_QUEUES)
 		sbq->wake_batch = max(1U, depth / SBQ_WAIT_QUEUES);
@@ -210,6 +216,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
+		free_percpu(sbq->alloc_hint);
 		sbitmap_free(&sbq->sb);
 		return -ENOMEM;
 	}
@@ -254,7 +261,8 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 	return NULL;
 }
 
-void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr)
+void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
+			 bool round_robin, unsigned int cpu)
 {
 	struct sbq_wait_state *ws;
 	int wait_cnt;
@@ -266,7 +274,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr)
 
 	ws = sbq_wake_ptr(sbq);
 	if (!ws)
-		return;
+		goto update_cache;
 
 	wait_cnt = atomic_dec_return(&ws->wait_cnt);
 	if (unlikely(wait_cnt < 0))
@@ -276,6 +284,10 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr)
 		sbq_index_atomic_inc(&sbq->wake_index);
 		wake_up(&ws->wait);
 	}
+
+update_cache:
+	if (likely(!round_robin))
+		*per_cpu_ptr(sbq->alloc_hint, cpu) = nr;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
 
-- 
2.9.3

