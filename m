Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35692 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755337AbcIQI2l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Sep 2016 04:28:41 -0400
Received: by mail-pf0-f171.google.com with SMTP id z123so34579881pfz.2
        for <linux-block@vger.kernel.org>; Sat, 17 Sep 2016 01:28:40 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v4 3/6] sbitmap: push per-cpu last_tag into sbitmap_queue
Date: Sat, 17 Sep 2016 01:28:23 -0700
Message-Id: <7197b61e031928444eebe4de9bc48b49b9bfa8a8.1474100040.git.osandov@fb.com>
In-Reply-To: <cover.1474100040.git.osandov@fb.com>
References: <cover.1474100040.git.osandov@fb.com>
In-Reply-To: <cover.1474100040.git.osandov@fb.com>
References: <cover.1474100040.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Allocating your own per-cpu allocation hint separately makes for an
awkward API. Instead, allocate the per-cpu hint as part of the struct
sbitmap_queue. There's no point for a struct sbitmap_queue without the
cache, but you can still use a bare struct sbitmap.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-tag.c      | 53 ++++++++++++++++---------------------------------
 block/blk-mq-tag.h      |  3 ++-
 block/blk-mq.c          |  2 +-
 block/blk-mq.h          |  2 --
 include/linux/sbitmap.h | 45 ++++++++++++++++++++++++++++++++++++++++-
 lib/sbitmap.c           | 35 +++++++++++++++++++++++++++++++-
 6 files changed, 98 insertions(+), 42 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2cbdecd..c9a22db 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -94,39 +94,21 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 #define BT_ALLOC_RR(tags) (tags->alloc_policy == BLK_TAG_ALLOC_RR)
 
 static int __bt_get(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-		    unsigned int *tag_cache, struct blk_mq_tags *tags)
+		    struct blk_mq_tags *tags)
 {
-	unsigned int last_tag;
-	int tag;
-
 	if (!hctx_may_queue(hctx, bt))
 		return -1;
-
-	last_tag = *tag_cache;
-	tag = sbitmap_get(&bt->sb, last_tag, BT_ALLOC_RR(tags));
-
-	if (tag == -1) {
-		*tag_cache = 0;
-	} else if (tag == last_tag || unlikely(BT_ALLOC_RR(tags))) {
-		last_tag = tag + 1;
-		if (last_tag >= bt->sb.depth - 1)
-			last_tag = 0;
-		*tag_cache = last_tag;
-	}
-
-	return tag;
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
 
@@ -137,7 +119,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 	do {
 		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __bt_get(hctx, bt, last_tag, tags);
+		tag = __bt_get(hctx, bt, tags);
 		if (tag != -1)
 			break;
 
@@ -154,7 +136,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 		 * Retry tag allocation after running the hardware queue,
 		 * as running the queue may also have found completions.
 		 */
-		tag = __bt_get(hctx, bt, last_tag, tags);
+		tag = __bt_get(hctx, bt, tags);
 		if (tag != -1)
 			break;
 
@@ -168,7 +150,6 @@ static int bt_get(struct blk_mq_alloc_data *data,
 		if (data->flags & BLK_MQ_REQ_RESERVED) {
 			bt = &data->hctx->tags->breserved_tags;
 		} else {
-			last_tag = &data->ctx->last_tag;
 			hctx = data->hctx;
 			bt = &hctx->tags->bitmap_tags;
 		}
@@ -185,7 +166,7 @@ static unsigned int __blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	int tag;
 
 	tag = bt_get(data, &data->hctx->tags->bitmap_tags, data->hctx,
-			&data->ctx->last_tag, data->hctx->tags);
+		     data->hctx->tags);
 	if (tag >= 0)
 		return tag + data->hctx->tags->nr_reserved_tags;
 
@@ -194,15 +175,15 @@ static unsigned int __blk_mq_get_tag(struct blk_mq_alloc_data *data)
 
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
 
@@ -216,8 +197,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return __blk_mq_get_tag(data);
 }
 
-void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag,
-		    unsigned int *last_tag)
+void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+		    unsigned int tag)
 {
 	struct blk_mq_tags *tags = hctx->tags;
 
@@ -225,12 +206,12 @@ void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag,
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
index 1a3b836..6745545 100644
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
@@ -267,6 +275,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
 {
 	kfree(sbq->ws);
+	free_percpu(sbq->alloc_hint);
 	sbitmap_free(&sbq->sb);
 }
 
@@ -282,12 +291,46 @@ static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
 void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth);
 
 /**
+ * __sbitmap_queue_get() - Try to allocate a free bit from a &struct
+ * sbitmap_queue with preemption already disabled.
+ * @sbq: Bitmap queue to allocate from.
+ * @round_robin: See sbitmap_get().
+ *
+ * Return: Non-negative allocated bit number if successful, -1 otherwise.
+ */
+int __sbitmap_queue_get(struct sbitmap_queue *sbq, bool round_robin);
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
index 4d8e97e..1651ad9d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -205,11 +205,18 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	if (ret)
 		return ret;
 
+	sbq->alloc_hint = alloc_percpu_gfp(unsigned int, flags);
+	if (!sbq->alloc_hint) {
+		sbitmap_free(&sbq->sb);
+		return -ENOMEM;
+	}
+
 	sbq->wake_batch = sbq_calc_wake_batch(depth);
 	atomic_set(&sbq->wake_index, 0);
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
+		free_percpu(sbq->alloc_hint);
 		sbitmap_free(&sbq->sb);
 		return -ENOMEM;
 	}
@@ -229,6 +236,29 @@ void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_resize);
 
+int __sbitmap_queue_get(struct sbitmap_queue *sbq, bool round_robin)
+{
+	unsigned int hint;
+	int nr;
+
+	hint = this_cpu_read(*sbq->alloc_hint);
+	nr = sbitmap_get(&sbq->sb, hint, round_robin);
+
+	if (nr == -1) {
+		/* If the map is full, a hint won't do us much good. */
+		this_cpu_write(*sbq->alloc_hint, 0);
+	} else if (nr == hint || unlikely(round_robin)) {
+		/* Only update the hint if we used it. */
+		hint = nr + 1;
+		if (hint >= sbq->sb.depth - 1)
+			hint = 0;
+		this_cpu_write(*sbq->alloc_hint, hint);
+	}
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(__sbitmap_queue_get);
+
 static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
 	int i, wake_index;
@@ -273,10 +303,13 @@ static void sbq_wake_up(struct sbitmap_queue *sbq)
 	}
 }
 
-void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr)
+void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
+			 bool round_robin, unsigned int cpu)
 {
 	sbitmap_clear_bit(&sbq->sb, nr);
 	sbq_wake_up(sbq);
+	if (likely(!round_robin))
+		*per_cpu_ptr(sbq->alloc_hint, cpu) = nr;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
 
-- 
2.9.3

