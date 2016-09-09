Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33483 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754402AbcIISmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2016 14:42:32 -0400
Received: by mail-pa0-f47.google.com with SMTP id cm16so30845780pac.0
        for <linux-block@vger.kernel.org>; Fri, 09 Sep 2016 11:42:32 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v3 4/5] sbitmap: push alloc policy into sbitmap_queue
Date: Fri,  9 Sep 2016 11:42:10 -0700
Message-Id: <36b87617b24556226dce72a08d976b485b2ef5c2.1473446095.git.osandov@fb.com>
In-Reply-To: <cover.1473446095.git.osandov@fb.com>
References: <cover.1473446095.git.osandov@fb.com>
In-Reply-To: <cover.1473446095.git.osandov@fb.com>
References: <cover.1473446095.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Again, there's no point in passing this in every time. Make it part of
struct sbitmap_queue and clean up the API.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-tag.c      | 33 +++++++++++++++------------------
 block/blk-mq-tag.h      |  1 -
 include/linux/sbitmap.h | 22 ++++++++++++----------
 lib/sbitmap.c           |  8 +++++---
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c9a22db..e1c2bed 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -91,14 +91,11 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return atomic_read(&hctx->nr_active) < depth;
 }
 
-#define BT_ALLOC_RR(tags) (tags->alloc_policy == BLK_TAG_ALLOC_RR)
-
-static int __bt_get(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-		    struct blk_mq_tags *tags)
+static int __bt_get(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt)
 {
 	if (!hctx_may_queue(hctx, bt))
 		return -1;
-	return __sbitmap_queue_get(bt, BT_ALLOC_RR(tags));
+	return __sbitmap_queue_get(bt);
 }
 
 static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
@@ -108,7 +105,7 @@ static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
 	DEFINE_WAIT(wait);
 	int tag;
 
-	tag = __bt_get(hctx, bt, tags);
+	tag = __bt_get(hctx, bt);
 	if (tag != -1)
 		return tag;
 
@@ -119,7 +116,7 @@ static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
 	do {
 		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __bt_get(hctx, bt, tags);
+		tag = __bt_get(hctx, bt);
 		if (tag != -1)
 			break;
 
@@ -136,7 +133,7 @@ static int bt_get(struct blk_mq_alloc_data *data, struct sbitmap_queue *bt,
 		 * Retry tag allocation after running the hardware queue,
 		 * as running the queue may also have found completions.
 		 */
-		tag = __bt_get(hctx, bt, tags);
+		tag = __bt_get(hctx, bt);
 		if (tag != -1)
 			break;
 
@@ -206,12 +203,10 @@ void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 		const int real_tag = tag - tags->nr_reserved_tags;
 
 		BUG_ON(real_tag >= tags->nr_tags);
-		sbitmap_queue_clear(&tags->bitmap_tags, real_tag,
-				    BT_ALLOC_RR(tags), ctx->cpu);
+		sbitmap_queue_clear(&tags->bitmap_tags, real_tag, ctx->cpu);
 	} else {
 		BUG_ON(tag >= tags->nr_reserved_tags);
-		sbitmap_queue_clear(&tags->breserved_tags, tag,
-				    BT_ALLOC_RR(tags), ctx->cpu);
+		sbitmap_queue_clear(&tags->breserved_tags, tag, ctx->cpu);
 	}
 }
 
@@ -363,21 +358,23 @@ static unsigned int bt_unused_tags(const struct sbitmap_queue *bt)
 	return bt->sb.depth - sbitmap_weight(&bt->sb);
 }
 
-static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth, int node)
+static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
+		    bool round_robin, int node)
 {
-	return sbitmap_queue_init_node(bt, depth, -1, GFP_KERNEL, node);
+	return sbitmap_queue_init_node(bt, depth, -1, round_robin, GFP_KERNEL,
+				       node);
 }
 
 static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 						   int node, int alloc_policy)
 {
 	unsigned int depth = tags->nr_tags - tags->nr_reserved_tags;
+	bool round_robin = alloc_policy == BLK_TAG_ALLOC_RR;
 
-	tags->alloc_policy = alloc_policy;
-
-	if (bt_alloc(&tags->bitmap_tags, depth, node))
+	if (bt_alloc(&tags->bitmap_tags, depth, round_robin, node))
 		goto free_tags;
-	if (bt_alloc(&tags->breserved_tags, tags->nr_reserved_tags, node))
+	if (bt_alloc(&tags->breserved_tags, tags->nr_reserved_tags, round_robin,
+		     node))
 		goto free_bitmap_tags;
 
 	return tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 2b1d52e..f90b850 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -18,7 +18,6 @@ struct blk_mq_tags {
 	struct request **rqs;
 	struct list_head page_list;
 
-	int alloc_policy;
 	cpumask_var_t cpumask;
 };
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index c0f0cf6..32c5596 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -122,6 +122,11 @@ struct sbitmap_queue {
 	 * @ws: Wait queues.
 	 */
 	struct sbq_wait_state *ws;
+
+	/**
+	 * @round_robin: Allocate bits in strict round-robin order.
+	 */
+	bool round_robin;
 };
 
 /**
@@ -261,13 +266,14 @@ unsigned int sbitmap_weight(const struct sbitmap *sb);
  * @sbq: Bitmap queue to initialize.
  * @depth: See sbitmap_init_node().
  * @shift: See sbitmap_init_node().
+ * @round_robin: See sbitmap_get().
  * @flags: Allocation flags.
  * @node: Memory node to allocate on.
  *
  * Return: Zero on success or negative errno on failure.
  */
 int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
-			    int shift, gfp_t flags, int node);
+			    int shift, bool round_robin, gfp_t flags, int node);
 
 /**
  * sbitmap_queue_free() - Free memory used by a &struct sbitmap_queue.
@@ -296,34 +302,31 @@ void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth);
  * __sbitmap_queue_get() - Try to allocate a free bit from a &struct
  * sbitmap_queue with preemption already disabled.
  * @sbq: Bitmap queue to allocate from.
- * @round_robin: See sbitmap_get().
  *
  * Return: Non-negative allocated bit number if successful, -1 otherwise.
  */
-static inline int __sbitmap_queue_get(struct sbitmap_queue *sbq,
-				      bool round_robin)
+static inline int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 {
 	return sbitmap_get(&sbq->sb, this_cpu_ptr(sbq->alloc_hint),
-			   round_robin);
+			   sbq->round_robin);
 }
 
 /**
  * sbitmap_queue_get() - Try to allocate a free bit from a &struct
  * sbitmap_queue.
  * @sbq: Bitmap queue to allocate from.
- * @round_robin: See sbitmap_get().
  * @cpu: Output parameter; will contain the CPU we ran on (e.g., to be passed to
  *       sbitmap_queue_clear()).
  *
  * Return: Non-negative allocated bit number if successful, -1 otherwise.
  */
-static inline int sbitmap_queue_get(struct sbitmap_queue *sbq, bool round_robin,
+static inline int sbitmap_queue_get(struct sbitmap_queue *sbq,
 				    unsigned int *cpu)
 {
 	int nr;
 
 	*cpu = get_cpu();
-	nr = __sbitmap_queue_get(sbq, round_robin);
+	nr = __sbitmap_queue_get(sbq);
 	put_cpu();
 	return nr;
 }
@@ -333,11 +336,10 @@ static inline int sbitmap_queue_get(struct sbitmap_queue *sbq, bool round_robin,
  * &struct sbitmap_queue.
  * @sbq: Bitmap to free from.
  * @nr: Bit number to free.
- * @round_robin: See sbitmap_get().
  * @cpu: CPU the bit was allocated on.
  */
 void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
-			 bool round_robin, unsigned int cpu);
+			 unsigned int cpu);
 
 static inline int sbq_index_inc(int index)
 {
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 261543c..3a91269 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -193,7 +193,7 @@ unsigned int sbitmap_weight(const struct sbitmap *sb)
 EXPORT_SYMBOL_GPL(sbitmap_weight);
 
 int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
-			    int shift, gfp_t flags, int node)
+			    int shift, bool round_robin, gfp_t flags, int node)
 {
 	int ret;
 	int i;
@@ -225,6 +225,8 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 		init_waitqueue_head(&sbq->ws[i].wait);
 		atomic_set(&sbq->ws[i].wait_cnt, sbq->wake_batch);
 	}
+
+	sbq->round_robin = round_robin;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
@@ -262,7 +264,7 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 }
 
 void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
-			 bool round_robin, unsigned int cpu)
+			 unsigned int cpu)
 {
 	struct sbq_wait_state *ws;
 	int wait_cnt;
@@ -286,7 +288,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
 	}
 
 update_cache:
-	if (likely(!round_robin))
+	if (likely(!sbq->round_robin))
 		*per_cpu_ptr(sbq->alloc_hint, cpu) = nr;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
-- 
2.9.3

