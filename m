Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36136 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756203AbcH2XkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2016 19:40:16 -0400
Received: by mail-pf0-f171.google.com with SMTP id h186so1008214pfg.3
        for <linux-block@vger.kernel.org>; Mon, 29 Aug 2016 16:40:15 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] blk-mq: abstract tag allocation out into scale_bitmap library
Date: Mon, 29 Aug 2016 16:40:03 -0700
Message-Id: <7c820ea68cd22960437d1ee73925bc2d216a820e.1472513340.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is a generally useful data structure, so make it available to
anyone else who might want to use it. It's also a nice cleanup
separating the allocation logic from the rest of the tag handling logic.

The code is behind a new Kconfig option, CONFIG_SCALE_BITMAP, which is
only selected by CONFIG_BLOCK for now.

There's one minor functional difference hidden in here: originally,
`bt_alloc()` was using `kzalloc()`, not `kzalloc_node()`, to allocate
the wait queues. This was probably an oversight, so
`scale_bitmap_queue_init_node()` allocates the wait queues on a specific
node.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
This is the bottom patch of my blk-mq work, and Jens mentioned that he
wants to use it for writeback throttling, so I'm sending it out now.

Naming is hard, so if anyone has any better suggestions, I'm listening.
Comments on the API are more than welcome, too. I put this through a run
of xfstests and ran it for awhile on a couple of systems, so hopefully
there are no lingering typos in the conversion.

This applies to v4.8-rc4.

Thanks!

 MAINTAINERS                  |   1 +
 block/Kconfig                |   1 +
 block/blk-mq-tag.c           | 462 ++++++++++---------------------------------
 block/blk-mq-tag.h           |  37 +---
 block/blk-mq.c               | 113 ++++-------
 block/blk-mq.h               |   9 -
 include/linux/blk-mq.h       |   9 +-
 include/linux/scale_bitmap.h | 343 ++++++++++++++++++++++++++++++++
 lib/Kconfig                  |   3 +
 lib/Makefile                 |   2 +
 lib/scale_bitmap.c           | 304 ++++++++++++++++++++++++++++
 11 files changed, 802 insertions(+), 482 deletions(-)
 create mode 100644 include/linux/scale_bitmap.h
 create mode 100644 lib/scale_bitmap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 71aa5da..56b022a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2451,6 +2451,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	block/
 F:	kernel/trace/blktrace.c
+F:	lib/scale_bitmap.c
 
 BLOCK2MTD DRIVER
 M:	Joern Engel <joern@lazybastard.org>
diff --git a/block/Kconfig b/block/Kconfig
index 161491d..9fc09e6 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -4,6 +4,7 @@
 menuconfig BLOCK
        bool "Enable the block layer" if EXPERT
        default y
+       select SCALE_BITMAP
        help
 	 Provide block layer support for the kernel.
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 729bac3..240b800 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -1,12 +1,7 @@
 /*
- * Fast and scalable bitmap tagging variant. Uses sparser bitmaps spread
- * over multiple cachelines to avoid ping-pong between multiple submitters
- * or submitter and completer. Uses rolling wakeups to avoid falling of
- * the scaling cliff when we run out of tags and have to start putting
- * submitters to sleep.
- *
- * Uses active queue tracking to support fairer distribution of tags
- * between multiple submitters when a shared tag map is used.
+ * Tag allocation using scalable bitmaps. Uses active queue tracking to support
+ * fairer distribution of tags between multiple submitters when a shared tag map
+ * is used.
  *
  * Copyright (C) 2013-2014 Jens Axboe
  */
@@ -19,40 +14,12 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
-static bool bt_has_free_tags(struct blk_mq_bitmap_tags *bt)
-{
-	int i;
-
-	for (i = 0; i < bt->map_nr; i++) {
-		struct blk_align_bitmap *bm = &bt->map[i];
-		int ret;
-
-		ret = find_first_zero_bit(&bm->word, bm->depth);
-		if (ret < bm->depth)
-			return true;
-	}
-
-	return false;
-}
-
 bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
 {
 	if (!tags)
 		return true;
 
-	return bt_has_free_tags(&tags->bitmap_tags);
-}
-
-static inline int bt_index_inc(int index)
-{
-	return (index + 1) & (BT_WAIT_QUEUES - 1);
-}
-
-static inline void bt_index_atomic_inc(atomic_t *index)
-{
-	int old = atomic_read(index);
-	int new = bt_index_inc(old);
-	atomic_cmpxchg(index, old, new);
+	return scale_bitmap_any_bit_clear(&tags->bitmap_tags.map);
 }
 
 /*
@@ -72,29 +39,9 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
  */
 void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
 {
-	struct blk_mq_bitmap_tags *bt;
-	int i, wake_index;
-
-	/*
-	 * Make sure all changes prior to this are visible from other CPUs.
-	 */
-	smp_mb();
-	bt = &tags->bitmap_tags;
-	wake_index = atomic_read(&bt->wake_index);
-	for (i = 0; i < BT_WAIT_QUEUES; i++) {
-		struct bt_wait_state *bs = &bt->bs[wake_index];
-
-		if (waitqueue_active(&bs->wait))
-			wake_up(&bs->wait);
-
-		wake_index = bt_index_inc(wake_index);
-	}
-
-	if (include_reserve) {
-		bt = &tags->breserved_tags;
-		if (waitqueue_active(&bt->bs[0].wait))
-			wake_up(&bt->bs[0].wait);
-	}
+	scale_bitmap_queue_wake_all(&tags->bitmap_tags);
+	if (include_reserve)
+		scale_bitmap_queue_wake_all(&tags->breserved_tags);
 }
 
 /*
@@ -118,7 +65,7 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
  * and attempt to provide a fair share of the tag depth for each of them.
  */
 static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
-				  struct blk_mq_bitmap_tags *bt)
+				  struct scale_bitmap_queue *bt)
 {
 	unsigned int depth, users;
 
@@ -130,7 +77,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	/*
 	 * Don't try dividing an ant
 	 */
-	if (bt->depth == 1)
+	if (bt->map.depth == 1)
 		return true;
 
 	users = atomic_read(&hctx->tags->active_queues);
@@ -140,127 +87,26 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	/*
 	 * Allow at least some tags
 	 */
-	depth = max((bt->depth + users - 1) / users, 4U);
+	depth = max((bt->map.depth + users - 1) / users, 4U);
 	return atomic_read(&hctx->nr_active) < depth;
 }
 
-static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag,
-			 bool nowrap)
-{
-	int tag, org_last_tag = last_tag;
-
-	while (1) {
-		tag = find_next_zero_bit(&bm->word, bm->depth, last_tag);
-		if (unlikely(tag >= bm->depth)) {
-			/*
-			 * We started with an offset, and we didn't reset the
-			 * offset to 0 in a failure case, so start from 0 to
-			 * exhaust the map.
-			 */
-			if (org_last_tag && last_tag && !nowrap) {
-				last_tag = org_last_tag = 0;
-				continue;
-			}
-			return -1;
-		}
-
-		if (!test_and_set_bit(tag, &bm->word))
-			break;
-
-		last_tag = tag + 1;
-		if (last_tag >= bm->depth - 1)
-			last_tag = 0;
-	}
-
-	return tag;
-}
-
 #define BT_ALLOC_RR(tags) (tags->alloc_policy == BLK_TAG_ALLOC_RR)
 
-/*
- * Straight forward bitmap tag implementation, where each bit is a tag
- * (cleared == free, and set == busy). The small twist is using per-cpu
- * last_tag caches, which blk-mq stores in the blk_mq_ctx software queue
- * contexts. This enables us to drastically limit the space searched,
- * without dirtying an extra shared cacheline like we would if we stored
- * the cache value inside the shared blk_mq_bitmap_tags structure. On top
- * of that, each word of tags is in a separate cacheline. This means that
- * multiple users will tend to stick to different cachelines, at least
- * until the map is exhausted.
- */
-static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
+static int __bt_get(struct blk_mq_hw_ctx *hctx, struct scale_bitmap_queue *bt,
 		    unsigned int *tag_cache, struct blk_mq_tags *tags)
 {
-	unsigned int last_tag, org_last_tag;
-	int index, i, tag;
-
 	if (!hctx_may_queue(hctx, bt))
 		return -1;
-
-	last_tag = org_last_tag = *tag_cache;
-	index = TAG_TO_INDEX(bt, last_tag);
-
-	for (i = 0; i < bt->map_nr; i++) {
-		tag = __bt_get_word(&bt->map[index], TAG_TO_BIT(bt, last_tag),
-				    BT_ALLOC_RR(tags));
-		if (tag != -1) {
-			tag += (index << bt->bits_per_word);
-			goto done;
-		}
-
-		/*
-		 * Jump to next index, and reset the last tag to be the
-		 * first tag of that index
-		 */
-		index++;
-		last_tag = (index << bt->bits_per_word);
-
-		if (index >= bt->map_nr) {
-			index = 0;
-			last_tag = 0;
-		}
-	}
-
-	*tag_cache = 0;
-	return -1;
-
-	/*
-	 * Only update the cache from the allocation path, if we ended
-	 * up using the specific cached tag.
-	 */
-done:
-	if (tag == org_last_tag || unlikely(BT_ALLOC_RR(tags))) {
-		last_tag = tag + 1;
-		if (last_tag >= bt->depth - 1)
-			last_tag = 0;
-
-		*tag_cache = last_tag;
-	}
-
-	return tag;
-}
-
-static struct bt_wait_state *bt_wait_ptr(struct blk_mq_bitmap_tags *bt,
-					 struct blk_mq_hw_ctx *hctx)
-{
-	struct bt_wait_state *bs;
-	int wait_index;
-
-	if (!hctx)
-		return &bt->bs[0];
-
-	wait_index = atomic_read(&hctx->wait_index);
-	bs = &bt->bs[wait_index];
-	bt_index_atomic_inc(&hctx->wait_index);
-	return bs;
+	return scale_bitmap_queue_get(bt, tag_cache, BT_ALLOC_RR(tags));
 }
 
 static int bt_get(struct blk_mq_alloc_data *data,
-		struct blk_mq_bitmap_tags *bt,
-		struct blk_mq_hw_ctx *hctx,
-		unsigned int *last_tag, struct blk_mq_tags *tags)
+		  struct scale_bitmap_queue *bt,
+		  struct blk_mq_hw_ctx *hctx,
+		  unsigned int *last_tag, struct blk_mq_tags *tags)
 {
-	struct bt_wait_state *bs;
+	struct sbq_wait_state *ws;
 	DEFINE_WAIT(wait);
 	int tag;
 
@@ -271,9 +117,9 @@ static int bt_get(struct blk_mq_alloc_data *data,
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
 		return -1;
 
-	bs = bt_wait_ptr(bt, hctx);
+	ws = bt_wait_ptr(bt, hctx);
 	do {
-		prepare_to_wait(&bs->wait, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __bt_get(hctx, bt, last_tag, tags);
 		if (tag != -1)
@@ -310,11 +156,11 @@ static int bt_get(struct blk_mq_alloc_data *data,
 			hctx = data->hctx;
 			bt = &hctx->tags->bitmap_tags;
 		}
-		finish_wait(&bs->wait, &wait);
-		bs = bt_wait_ptr(bt, hctx);
+		finish_wait(&ws->wait, &wait);
+		ws = bt_wait_ptr(bt, hctx);
 	} while (1);
 
-	finish_wait(&bs->wait, &wait);
+	finish_wait(&ws->wait, &wait);
 	return tag;
 }
 
@@ -354,53 +200,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return __blk_mq_get_tag(data);
 }
 
-static struct bt_wait_state *bt_wake_ptr(struct blk_mq_bitmap_tags *bt)
-{
-	int i, wake_index;
-
-	wake_index = atomic_read(&bt->wake_index);
-	for (i = 0; i < BT_WAIT_QUEUES; i++) {
-		struct bt_wait_state *bs = &bt->bs[wake_index];
-
-		if (waitqueue_active(&bs->wait)) {
-			int o = atomic_read(&bt->wake_index);
-			if (wake_index != o)
-				atomic_cmpxchg(&bt->wake_index, o, wake_index);
-
-			return bs;
-		}
-
-		wake_index = bt_index_inc(wake_index);
-	}
-
-	return NULL;
-}
-
-static void bt_clear_tag(struct blk_mq_bitmap_tags *bt, unsigned int tag)
-{
-	const int index = TAG_TO_INDEX(bt, tag);
-	struct bt_wait_state *bs;
-	int wait_cnt;
-
-	clear_bit(TAG_TO_BIT(bt, tag), &bt->map[index].word);
-
-	/* Ensure that the wait list checks occur after clear_bit(). */
-	smp_mb();
-
-	bs = bt_wake_ptr(bt);
-	if (!bs)
-		return;
-
-	wait_cnt = atomic_dec_return(&bs->wait_cnt);
-	if (unlikely(wait_cnt < 0))
-		wait_cnt = atomic_inc_return(&bs->wait_cnt);
-	if (wait_cnt == 0) {
-		atomic_add(bt->wake_cnt, &bs->wait_cnt);
-		bt_index_atomic_inc(&bt->wake_index);
-		wake_up(&bs->wait);
-	}
-}
-
 void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag,
 		    unsigned int *last_tag)
 {
@@ -410,67 +209,97 @@ void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag,
 		const int real_tag = tag - tags->nr_reserved_tags;
 
 		BUG_ON(real_tag >= tags->nr_tags);
-		bt_clear_tag(&tags->bitmap_tags, real_tag);
+		scale_bitmap_queue_clear(&tags->bitmap_tags, real_tag);
 		if (likely(tags->alloc_policy == BLK_TAG_ALLOC_FIFO))
 			*last_tag = real_tag;
 	} else {
 		BUG_ON(tag >= tags->nr_reserved_tags);
-		bt_clear_tag(&tags->breserved_tags, tag);
+		scale_bitmap_queue_clear(&tags->breserved_tags, tag);
 	}
 }
 
-static void bt_for_each(struct blk_mq_hw_ctx *hctx,
-		struct blk_mq_bitmap_tags *bt, unsigned int off,
-		busy_iter_fn *fn, void *data, bool reserved)
+struct bt_iter_data {
+	struct blk_mq_hw_ctx *hctx;
+	busy_iter_fn *fn;
+	void *data;
+	bool reserved;
+};
+
+static bool bt_iter(struct scale_bitmap *bitmap, unsigned int bitnr, void *data)
 {
+	struct bt_iter_data *iter_data = data;
+	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
+	struct blk_mq_tags *tags = hctx->tags;
+	bool reserved = iter_data->reserved;
 	struct request *rq;
-	int bit, i;
 
-	for (i = 0; i < bt->map_nr; i++) {
-		struct blk_align_bitmap *bm = &bt->map[i];
+	if (!reserved)
+		bitnr += tags->nr_reserved_tags;
+	rq = tags->rqs[bitnr];
 
-		for (bit = find_first_bit(&bm->word, bm->depth);
-		     bit < bm->depth;
-		     bit = find_next_bit(&bm->word, bm->depth, bit + 1)) {
-			rq = hctx->tags->rqs[off + bit];
-			if (rq->q == hctx->queue)
-				fn(hctx, rq, data, reserved);
-		}
+	if (rq->q == hctx->queue)
+		iter_data->fn(hctx, rq, iter_data->data, reserved);
+	return true;
+}
 
-		off += (1 << bt->bits_per_word);
-	}
+static void bt_for_each(struct blk_mq_hw_ctx *hctx,
+			struct scale_bitmap_queue *bt, busy_iter_fn *fn,
+			void *data, bool reserved)
+{
+	struct bt_iter_data iter_data = {
+		.hctx = hctx,
+		.fn = fn,
+		.data = data,
+		.reserved = reserved,
+	};
+
+	scale_bitmap_for_each_set(&bt->map, bt_iter, &iter_data);
 }
 
-static void bt_tags_for_each(struct blk_mq_tags *tags,
-		struct blk_mq_bitmap_tags *bt, unsigned int off,
-		busy_tag_iter_fn *fn, void *data, bool reserved)
+struct bt_tags_iter_data {
+	struct blk_mq_tags *tags;
+	busy_tag_iter_fn *fn;
+	void *data;
+	bool reserved;
+};
+
+static bool bt_tags_iter(struct scale_bitmap *bitmap, unsigned int bitnr,
+			 void *data)
 {
+	struct bt_tags_iter_data *iter_data = data;
+	struct blk_mq_tags *tags = iter_data->tags;
+	bool reserved = iter_data->reserved;
 	struct request *rq;
-	int bit, i;
 
-	if (!tags->rqs)
-		return;
-	for (i = 0; i < bt->map_nr; i++) {
-		struct blk_align_bitmap *bm = &bt->map[i];
-
-		for (bit = find_first_bit(&bm->word, bm->depth);
-		     bit < bm->depth;
-		     bit = find_next_bit(&bm->word, bm->depth, bit + 1)) {
-			rq = tags->rqs[off + bit];
-			fn(rq, data, reserved);
-		}
+	if (!reserved)
+		bitnr += tags->nr_reserved_tags;
+	rq = tags->rqs[bitnr];
 
-		off += (1 << bt->bits_per_word);
-	}
+	iter_data->fn(rq, iter_data->data, reserved);
+	return true;
+}
+
+static void bt_tags_for_each(struct blk_mq_tags *tags,
+			     struct scale_bitmap_queue *bt,
+			     busy_tag_iter_fn *fn, void *data, bool reserved)
+{
+	struct bt_tags_iter_data iter_data = {
+		.tags = tags,
+		.fn = fn,
+		.data = data,
+		.reserved = reserved,
+	};
+
+	if (tags->rqs)
+		scale_bitmap_for_each_set(&bt->map, bt_tags_iter, &iter_data);
 }
 
 static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, 0, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, tags->nr_reserved_tags, fn, priv,
-			false);
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
 }
 
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
@@ -529,107 +358,21 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 			continue;
 
 		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, &tags->breserved_tags, 0, fn, priv, true);
-		bt_for_each(hctx, &tags->bitmap_tags, tags->nr_reserved_tags, fn, priv,
-		      false);
+			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
+		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
 	}
 
 }
 
-static unsigned int bt_unused_tags(struct blk_mq_bitmap_tags *bt)
+static unsigned int bt_unused_tags(const struct scale_bitmap_queue *bt)
 {
-	unsigned int i, used;
-
-	for (i = 0, used = 0; i < bt->map_nr; i++) {
-		struct blk_align_bitmap *bm = &bt->map[i];
-
-		used += bitmap_weight(&bm->word, bm->depth);
-	}
-
-	return bt->depth - used;
-}
-
-static void bt_update_count(struct blk_mq_bitmap_tags *bt,
-			    unsigned int depth)
-{
-	unsigned int tags_per_word = 1U << bt->bits_per_word;
-	unsigned int map_depth = depth;
-
-	if (depth) {
-		int i;
-
-		for (i = 0; i < bt->map_nr; i++) {
-			bt->map[i].depth = min(map_depth, tags_per_word);
-			map_depth -= bt->map[i].depth;
-		}
-	}
-
-	bt->wake_cnt = BT_WAIT_BATCH;
-	if (bt->wake_cnt > depth / BT_WAIT_QUEUES)
-		bt->wake_cnt = max(1U, depth / BT_WAIT_QUEUES);
-
-	bt->depth = depth;
-}
-
-static int bt_alloc(struct blk_mq_bitmap_tags *bt, unsigned int depth,
-			int node, bool reserved)
-{
-	int i;
-
-	bt->bits_per_word = ilog2(BITS_PER_LONG);
-
-	/*
-	 * Depth can be zero for reserved tags, that's not a failure
-	 * condition.
-	 */
-	if (depth) {
-		unsigned int nr, tags_per_word;
-
-		tags_per_word = (1 << bt->bits_per_word);
-
-		/*
-		 * If the tag space is small, shrink the number of tags
-		 * per word so we spread over a few cachelines, at least.
-		 * If less than 4 tags, just forget about it, it's not
-		 * going to work optimally anyway.
-		 */
-		if (depth >= 4) {
-			while (tags_per_word * 4 > depth) {
-				bt->bits_per_word--;
-				tags_per_word = (1 << bt->bits_per_word);
-			}
-		}
-
-		nr = ALIGN(depth, tags_per_word) / tags_per_word;
-		bt->map = kzalloc_node(nr * sizeof(struct blk_align_bitmap),
-						GFP_KERNEL, node);
-		if (!bt->map)
-			return -ENOMEM;
-
-		bt->map_nr = nr;
-	}
-
-	bt->bs = kzalloc(BT_WAIT_QUEUES * sizeof(*bt->bs), GFP_KERNEL);
-	if (!bt->bs) {
-		kfree(bt->map);
-		bt->map = NULL;
-		return -ENOMEM;
-	}
-
-	bt_update_count(bt, depth);
-
-	for (i = 0; i < BT_WAIT_QUEUES; i++) {
-		init_waitqueue_head(&bt->bs[i].wait);
-		atomic_set(&bt->bs[i].wait_cnt, bt->wake_cnt);
-	}
-
-	return 0;
+	return bt->map.depth - scale_bitmap_weight(&bt->map);
 }
 
-static void bt_free(struct blk_mq_bitmap_tags *bt)
+static int bt_alloc(struct scale_bitmap_queue *bt, unsigned int depth,
+		    int node)
 {
-	kfree(bt->map);
-	kfree(bt->bs);
+	return scale_bitmap_queue_init_node(bt, depth, -1, GFP_KERNEL, node);
 }
 
 static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
@@ -639,14 +382,14 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 
 	tags->alloc_policy = alloc_policy;
 
-	if (bt_alloc(&tags->bitmap_tags, depth, node, false))
+	if (bt_alloc(&tags->bitmap_tags, depth, node))
 		goto enomem;
-	if (bt_alloc(&tags->breserved_tags, tags->nr_reserved_tags, node, true))
+	if (bt_alloc(&tags->breserved_tags, tags->nr_reserved_tags, node))
 		goto enomem;
 
 	return tags;
 enomem:
-	bt_free(&tags->bitmap_tags);
+	scale_bitmap_queue_free(&tags->bitmap_tags);
 	kfree(tags);
 	return NULL;
 }
@@ -679,8 +422,8 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 void blk_mq_free_tags(struct blk_mq_tags *tags)
 {
-	bt_free(&tags->bitmap_tags);
-	bt_free(&tags->breserved_tags);
+	scale_bitmap_queue_free(&tags->bitmap_tags);
+	scale_bitmap_queue_free(&tags->breserved_tags);
 	free_cpumask_var(tags->cpumask);
 	kfree(tags);
 }
@@ -702,7 +445,8 @@ int blk_mq_tag_update_depth(struct blk_mq_tags *tags, unsigned int tdepth)
 	 * Don't need (or can't) update reserved tags here, they remain
 	 * static and should never need resizing.
 	 */
-	bt_update_count(&tags->bitmap_tags, tdepth);
+	scale_bitmap_queue_resize(&tags->bitmap_tags, tdepth);
+
 	blk_mq_tag_wakeup_all(tags, false);
 	return 0;
 }
@@ -746,7 +490,7 @@ ssize_t blk_mq_tag_sysfs_show(struct blk_mq_tags *tags, char *page)
 	page += sprintf(page, "nr_tags=%u, reserved_tags=%u, "
 			"bits_per_word=%u\n",
 			tags->nr_tags, tags->nr_reserved_tags,
-			tags->bitmap_tags.bits_per_word);
+			1U << tags->bitmap_tags.map.shift);
 
 	free = bt_unused_tags(&tags->bitmap_tags);
 	res = bt_unused_tags(&tags->breserved_tags);
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d468a79..1277f24 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -3,31 +3,6 @@
 
 #include "blk-mq.h"
 
-enum {
-	BT_WAIT_QUEUES	= 8,
-	BT_WAIT_BATCH	= 8,
-};
-
-struct bt_wait_state {
-	atomic_t wait_cnt;
-	wait_queue_head_t wait;
-} ____cacheline_aligned_in_smp;
-
-#define TAG_TO_INDEX(bt, tag)	((tag) >> (bt)->bits_per_word)
-#define TAG_TO_BIT(bt, tag)	((tag) & ((1 << (bt)->bits_per_word) - 1))
-
-struct blk_mq_bitmap_tags {
-	unsigned int depth;
-	unsigned int wake_cnt;
-	unsigned int bits_per_word;
-
-	unsigned int map_nr;
-	struct blk_align_bitmap *map;
-
-	atomic_t wake_index;
-	struct bt_wait_state *bs;
-};
-
 /*
  * Tag address space map.
  */
@@ -37,8 +12,8 @@ struct blk_mq_tags {
 
 	atomic_t active_queues;
 
-	struct blk_mq_bitmap_tags bitmap_tags;
-	struct blk_mq_bitmap_tags breserved_tags;
+	struct scale_bitmap_queue bitmap_tags;
+	struct scale_bitmap_queue breserved_tags;
 
 	struct request **rqs;
 	struct list_head page_list;
@@ -61,6 +36,14 @@ extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
 
+static inline struct sbq_wait_state *bt_wait_ptr(struct scale_bitmap_queue *bt,
+						 struct blk_mq_hw_ctx *hctx)
+{
+	if (!hctx)
+		return &bt->ws[0];
+	return sbq_wait_ptr(bt, &hctx->wait_index);
+}
+
 enum {
 	BLK_MQ_TAG_CACHE_MIN	= 1,
 	BLK_MQ_TAG_CACHE_MAX	= 64,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 13f5a6c..7229300 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,42 +40,23 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx);
  */
 static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
-	unsigned int i;
-
-	for (i = 0; i < hctx->ctx_map.size; i++)
-		if (hctx->ctx_map.map[i].word)
-			return true;
-
-	return false;
-}
-
-static inline struct blk_align_bitmap *get_bm(struct blk_mq_hw_ctx *hctx,
-					      struct blk_mq_ctx *ctx)
-{
-	return &hctx->ctx_map.map[ctx->index_hw / hctx->ctx_map.bits_per_word];
+	return scale_bitmap_any_bit_set(&hctx->ctx_map);
 }
 
-#define CTX_TO_BIT(hctx, ctx)	\
-	((ctx)->index_hw & ((hctx)->ctx_map.bits_per_word - 1))
-
 /*
  * Mark this ctx as having pending work in this hardware queue
  */
 static void blk_mq_hctx_mark_pending(struct blk_mq_hw_ctx *hctx,
 				     struct blk_mq_ctx *ctx)
 {
-	struct blk_align_bitmap *bm = get_bm(hctx, ctx);
-
-	if (!test_bit(CTX_TO_BIT(hctx, ctx), &bm->word))
-		set_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
+	if (!scale_bitmap_test_bit(&hctx->ctx_map, ctx->index_hw))
+		scale_bitmap_set_bit(&hctx->ctx_map, ctx->index_hw);
 }
 
 static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 				      struct blk_mq_ctx *ctx)
 {
-	struct blk_align_bitmap *bm = get_bm(hctx, ctx);
-
-	clear_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
+	scale_bitmap_clear_bit(&hctx->ctx_map, ctx->index_hw);
 }
 
 void blk_mq_freeze_queue_start(struct request_queue *q)
@@ -744,38 +725,37 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 	return false;
 }
 
+struct flush_busy_ctx_data {
+	struct blk_mq_hw_ctx *hctx;
+	struct list_head *list;
+};
+
+static bool flush_busy_ctx(struct scale_bitmap *bitmap, unsigned int bitnr,
+			   void *data)
+{
+	struct flush_busy_ctx_data *flush_data = data;
+	struct blk_mq_hw_ctx *hctx = flush_data->hctx;
+	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
+
+	scale_bitmap_clear_bit(bitmap, bitnr);
+	spin_lock(&ctx->lock);
+	list_splice_tail_init(&ctx->rq_list, flush_data->list);
+	spin_unlock(&ctx->lock);
+	return true;
+}
+
 /*
  * Process software queues that have been marked busy, splicing them
  * to the for-dispatch
  */
 static void flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 {
-	struct blk_mq_ctx *ctx;
-	int i;
-
-	for (i = 0; i < hctx->ctx_map.size; i++) {
-		struct blk_align_bitmap *bm = &hctx->ctx_map.map[i];
-		unsigned int off, bit;
-
-		if (!bm->word)
-			continue;
-
-		bit = 0;
-		off = i * hctx->ctx_map.bits_per_word;
-		do {
-			bit = find_next_bit(&bm->word, bm->depth, bit);
-			if (bit >= bm->depth)
-				break;
-
-			ctx = hctx->ctxs[bit + off];
-			clear_bit(bit, &bm->word);
-			spin_lock(&ctx->lock);
-			list_splice_tail_init(&ctx->rq_list, list);
-			spin_unlock(&ctx->lock);
+	struct flush_busy_ctx_data data = {
+		.hctx = hctx,
+		.list = list,
+	};
 
-			bit++;
-		} while (1);
-	}
+	scale_bitmap_for_each_set(&hctx->ctx_map, flush_busy_ctx, &data);
 }
 
 /*
@@ -1594,32 +1574,6 @@ fail:
 	return NULL;
 }
 
-static void blk_mq_free_bitmap(struct blk_mq_ctxmap *bitmap)
-{
-	kfree(bitmap->map);
-}
-
-static int blk_mq_alloc_bitmap(struct blk_mq_ctxmap *bitmap, int node)
-{
-	unsigned int bpw = 8, total, num_maps, i;
-
-	bitmap->bits_per_word = bpw;
-
-	num_maps = ALIGN(nr_cpu_ids, bpw) / bpw;
-	bitmap->map = kzalloc_node(num_maps * sizeof(struct blk_align_bitmap),
-					GFP_KERNEL, node);
-	if (!bitmap->map)
-		return -ENOMEM;
-
-	total = nr_cpu_ids;
-	for (i = 0; i < num_maps; i++) {
-		bitmap->map[i].depth = min(total, bitmap->bits_per_word);
-		total -= bitmap->map[i].depth;
-	}
-
-	return 0;
-}
-
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -1685,7 +1639,7 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 
 	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
 	blk_free_flush_queue(hctx->fq);
-	blk_mq_free_bitmap(&hctx->ctx_map);
+	scale_bitmap_free(&hctx->ctx_map);
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
@@ -1745,7 +1699,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (!hctx->ctxs)
 		goto unregister_cpu_notifier;
 
-	if (blk_mq_alloc_bitmap(&hctx->ctx_map, node))
+	if (scale_bitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8),
+				   GFP_KERNEL, node))
 		goto free_ctxs;
 
 	hctx->nr_ctx = 0;
@@ -1772,7 +1727,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
  free_bitmap:
-	blk_mq_free_bitmap(&hctx->ctx_map);
+	scale_bitmap_free(&hctx->ctx_map);
  free_ctxs:
 	kfree(hctx->ctxs);
  unregister_cpu_notifier:
@@ -1848,8 +1803,6 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 	mutex_unlock(&q->sysfs_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		struct blk_mq_ctxmap *map = &hctx->ctx_map;
-
 		/*
 		 * If no software queues are mapped to this hardware queue,
 		 * disable it and free the request entries.
@@ -1875,7 +1828,7 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 		 * This is more accurate and more efficient than looping
 		 * over all possibly mapped software queues.
 		 */
-		map->size = DIV_ROUND_UP(hctx->nr_ctx, map->bits_per_word);
+		scale_bitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
 
 		/*
 		 * Initialize batch roundrobin counts
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9087b11..71831f9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -63,15 +63,6 @@ extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
 
 void blk_mq_release(struct request_queue *q);
 
-/*
- * Basic implementation of sparser bitmap, allowing the user to spread
- * the bits over more cachelines.
- */
-struct blk_align_bitmap {
-	unsigned long word;
-	unsigned long depth;
-} ____cacheline_aligned_in_smp;
-
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e43bbff..62e48dc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -2,6 +2,7 @@
 #define BLK_MQ_H
 
 #include <linux/blkdev.h>
+#include <linux/scale_bitmap.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -12,12 +13,6 @@ struct blk_mq_cpu_notifier {
 	int (*notify)(void *data, unsigned long action, unsigned int cpu);
 };
 
-struct blk_mq_ctxmap {
-	unsigned int size;
-	unsigned int bits_per_word;
-	struct blk_align_bitmap *map;
-};
-
 struct blk_mq_hw_ctx {
 	struct {
 		spinlock_t		lock;
@@ -38,7 +33,7 @@ struct blk_mq_hw_ctx {
 
 	void			*driver_data;
 
-	struct blk_mq_ctxmap	ctx_map;
+	struct scale_bitmap	ctx_map;
 
 	unsigned int		nr_ctx;
 	struct blk_mq_ctx	**ctxs;
diff --git a/include/linux/scale_bitmap.h b/include/linux/scale_bitmap.h
new file mode 100644
index 0000000..547913f
--- /dev/null
+++ b/include/linux/scale_bitmap.h
@@ -0,0 +1,343 @@
+/*
+ * Fast and scalable bitmaps.
+ *
+ * Copyright (C) 2016 Facebook
+ * Copyright (C) 2013-2014 Jens Axboe
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef __LINUX_SCALE_BITMAP_H
+#define __LINUX_SCALE_BITMAP_H
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+/**
+ * struct scale_bitmap_word - Word in a &struct scale_bitmap.
+ */
+struct scale_bitmap_word {
+	/**
+	 * @word: The bitmap word itself.
+	 */
+	unsigned long word;
+
+	/**
+	 * @depth: Number of bits being used in @word.
+	 */
+	unsigned long depth;
+} ____cacheline_aligned_in_smp;
+
+/**
+ * struct scale_bitmap - Scalable bitmap.
+ *
+ * A &struct scale_bitmap is spread over multiple cachelines to avoid ping-pong.
+ * This trades off higher memory usage for better scalability.
+ */
+struct scale_bitmap {
+	/**
+	 * @depth: Number of bits used in the whole bitmap..
+	 */
+	unsigned int depth;
+
+	/**
+	 * @shift: log2(number of bits used per word)
+	 */
+	unsigned int shift;
+
+	/**
+	 * @map_nr: Number of words (cachelines) being used for the bitmap.
+	 */
+	unsigned int map_nr;
+
+	/**
+	 * @map: Allocated bitmap.
+	 */
+	struct scale_bitmap_word *map;
+};
+
+#define SBQ_WAIT_QUEUES 8
+#define SBQ_WAKE_BATCH 8
+
+/**
+ * struct sbq_wait_state - Wait queue in a &struct scale_bitmap.
+ */
+struct sbq_wait_state {
+	/**
+	 * @wait_cnt: Number of frees remaining before we wake up.
+	 */
+	atomic_t wait_cnt;
+
+	/**
+	 * @wait: Wait queue.
+	 */
+	wait_queue_head_t wait;
+} ____cacheline_aligned_in_smp;
+
+/**
+ * struct scale_bitmap_queue - Scalable bitmap with the added ability to wait on
+ * free bits.
+ *
+ * A &struct scale_bitmap_queue uses multiple wait queues and rolling wakeups to
+ * avoid contention on the wait queue spinlock. This ensures that we don't hit a
+ * scalability wall when we run out of free bits and have to start putting tasks
+ * to sleep.
+ */
+struct scale_bitmap_queue {
+	/**
+	 * @map: Scalable bitmap.
+	 */
+	struct scale_bitmap map;
+
+	/**
+	 * @wake_batch: Number of bits which must be freed before we wake up any
+	 * waiters.
+	 */
+	unsigned int wake_batch;
+
+	/**
+	 * @wake_index: Next wait queue in @ws to wake up.
+	 */
+	atomic_t wake_index;
+
+	/**
+	 * @ws: Wait queues.
+	 */
+	struct sbq_wait_state *ws;
+};
+
+/**
+ * scale_bitmap_init_node() - initialize a &struct scale_bitmap on a specific
+ * memory node
+ * @bitmap: Bitmap to initialize.
+ * @depth: Number of bits to allocate.
+ * @shift: Use 2^@shift bits per word in the bitmap; if a negative number if
+ *         given, a good default is chosen.
+ * @flags: Allocation flags.
+ * @node: Memory node to allocate on.
+ *
+ * Return: Zero on success or negative errno on failure.
+ */
+int scale_bitmap_init_node(struct scale_bitmap *bitmap, unsigned int depth,
+			   int shift, gfp_t flags, int node);
+
+/**
+ * scale_bitmap_free() - Free memory used by a &struct scale_bitmap.
+ * @bitmap: Bitmap to free.
+ */
+static inline void scale_bitmap_free(struct scale_bitmap *bitmap)
+{
+	kfree(bitmap->map);
+	bitmap->map = NULL;
+}
+
+/**
+ * scale_bitmap_resize() - Resize a &struct scale_bitmap.
+ * @bitmap: Bitmap to resize.
+ * @depth: New number of bits to resize to.
+ *
+ * Doesn't reallocate anything. It's up to the caller to ensure that the new
+ * depth doesn't exceed the depth that the bitmap was initialized with.
+ */
+void scale_bitmap_resize(struct scale_bitmap *bitmap, unsigned int depth);
+
+/**
+ * scale_bitmap_any_bit_set() - Check for a set bit in a &struct scale_bitmap.
+ * @bitmap: Bitmap to check.
+ *
+ * Return: true if any bit in the bitmap is set, false otherwise.
+ */
+bool scale_bitmap_any_bit_set(const struct scale_bitmap *bitmap);
+
+/**
+ * scale_bitmap_any_bit_clear() - Check for an unset bit in a &struct
+ * scale_bitmap.
+ * @bitmap: Bitmap to check.
+ *
+ * Return: true if any bit in the bitmap is clear, false otherwise.
+ */
+bool scale_bitmap_any_bit_clear(const struct scale_bitmap *bitmap);
+
+typedef bool (*sb_for_each_fn)(struct scale_bitmap *, unsigned int, void *);
+
+/**
+ * scale_bitmap_for_each_set() - Iterate over each set bit in a &struct
+ * scale_bitmap.
+ *
+ * @bitmap: Bitmap to iterate over.
+ * @fn: Callback. Should return true to continue or false to break early.
+ * @data: Pointer to pass to callback.
+ *
+ * This is inline even though it's non-trivial so that the function calls to the
+ * callback will hopefully get optimized away.
+ */
+static inline void scale_bitmap_for_each_set(struct scale_bitmap *bitmap,
+					     sb_for_each_fn fn, void *data)
+{
+	unsigned int i;
+
+	for (i = 0; i < bitmap->map_nr; i++) {
+		struct scale_bitmap_word *word = &bitmap->map[i];
+		unsigned int off, nr;
+
+		if (!word->word)
+			continue;
+
+		nr = 0;
+		off = i << bitmap->shift;
+		while (1) {
+			nr = find_next_bit(&word->word, word->depth, nr);
+			if (nr >= word->depth)
+				break;
+
+			if (!fn(bitmap, off + nr, data))
+				return;
+
+			nr++;
+		}
+	}
+}
+
+#define SB_NR_TO_INDEX(bitmap, bitnr) ((bitnr) >> (bitmap)->shift)
+#define SB_NR_TO_BIT(bitmap, bitnr) ((bitnr) & ((1U << (bitmap)->shift) - 1U))
+
+static inline unsigned long *__scale_bitmap_word(struct scale_bitmap *bitmap,
+						 unsigned int bitnr)
+{
+	return &bitmap->map[SB_NR_TO_INDEX(bitmap, bitnr)].word;
+}
+
+/* Helpers equivalent to the operations in asm/bitops.h and linux/bitmap.h */
+
+static inline void scale_bitmap_set_bit(struct scale_bitmap *bitmap,
+					unsigned int bitnr)
+{
+	set_bit(SB_NR_TO_BIT(bitmap, bitnr),
+		__scale_bitmap_word(bitmap, bitnr));
+}
+
+static inline void scale_bitmap_clear_bit(struct scale_bitmap *bitmap,
+					  unsigned int bitnr)
+{
+	clear_bit(SB_NR_TO_BIT(bitmap, bitnr),
+		  __scale_bitmap_word(bitmap, bitnr));
+}
+
+static inline int scale_bitmap_test_bit(struct scale_bitmap *bitmap,
+					unsigned int bitnr)
+{
+	return test_bit(SB_NR_TO_BIT(bitmap, bitnr),
+			__scale_bitmap_word(bitmap, bitnr));
+}
+
+unsigned int scale_bitmap_weight(const struct scale_bitmap *bitmap);
+
+/**
+ * scale_bitmap_queue_init_node() - Initialize a &struct scale_bitmap_queue on a
+ * specific memory node.
+ *
+ * @sbq: Bitmap queue to initialize.
+ * @depth: See scale_bitmap_init_node().
+ * @shift: See scale_bitmap_init_node().
+ * @flags: Allocation flags.
+ * @node: Memory node to allocate on.
+ *
+ * Return: Zero on success or negative errno on failure.
+ */
+int scale_bitmap_queue_init_node(struct scale_bitmap_queue *sbq,
+				 unsigned int depth, int shift, gfp_t flags,
+				 int node);
+
+/**
+ * scale_bitmap_queue_free() - Free memory used by a &struct scale_bitmap_queue.
+ *
+ * @sbq: Bitmap queue to free.
+ */
+static inline void scale_bitmap_queue_free(struct scale_bitmap_queue *sbq)
+{
+	scale_bitmap_free(&sbq->map);
+	kfree(sbq->ws);
+}
+
+/**
+ * scale_bitmap_queue_resize() - Resize a &struct scale_bitmap_queue.
+ * @sbq: Bitmap queue to resize.
+ * @depth: New number of bits to resize to.
+ *
+ * Like scale_bitmap_resize(), this doesn't reallocate anything. It has to do
+ * some extra work on the &struct scale_bitmap_queue, so it's not safe to just
+ * resize the underlying &struct scale_bitmap.
+ */
+void scale_bitmap_queue_resize(struct scale_bitmap_queue *sbq,
+			       unsigned int depth);
+
+/**
+ * scale_bitmap_queue_get() - Try to allocate a free bit.
+ *
+ * @sbq: Bitmap to allocate from.
+ * @last_cache: Cache of last successfully allocated bit. This should be per-cpu
+ *              for best results, which allows multiple users to stick to
+ *              different cachelines until the map is exhausted.
+ * @round_robin: If true, be stricter about allocation order; always allocate
+ *               starting from the last allocated bit. This is less efficient
+ *               than the default behavior (false).
+ *
+ * Return: Non-negative allocated bit number if successful, -1 otherwise.
+ */
+int scale_bitmap_queue_get(struct scale_bitmap_queue *sbq,
+			   unsigned int *last_cache, bool round_robin);
+
+/**
+ * scale_bitmap_queue_clear() - Free an allocated bit and wake up waiters.
+ *
+ * @sbq: Bitmap to free from.
+ * @nr: Bit number to free.
+ */
+void scale_bitmap_queue_clear(struct scale_bitmap_queue *sbq, unsigned int nr);
+
+static inline int sbq_index_inc(int index)
+{
+	return (index + 1) & (SBQ_WAIT_QUEUES - 1);
+}
+
+static inline void sbq_index_atomic_inc(atomic_t *index)
+{
+	int old = atomic_read(index);
+	int new = sbq_index_inc(old);
+	atomic_cmpxchg(index, old, new);
+}
+
+/**
+ * sbq_wait_ptr() - Get the next wait queue to use for a &struct
+ * scale_bitmap_queue.
+ * @sbq: Bitmap queue to wait on.
+ * @wait_index: A counter per "user" of @sbq.
+ */
+static inline struct sbq_wait_state *sbq_wait_ptr(struct scale_bitmap_queue *sbq,
+						  atomic_t *wait_index)
+{
+	struct sbq_wait_state *ws;
+
+	ws = &sbq->ws[atomic_read(wait_index)];
+	sbq_index_atomic_inc(wait_index);
+	return ws;
+}
+
+/**
+ * scale_bitmap_queue_wake_all() - Wake up everything waiting on a &struct
+ * scale_bitmap_queue.
+ * @sbq: Bitmap queue to wake up.
+ */
+void scale_bitmap_queue_wake_all(struct scale_bitmap_queue *sbq);
+
+#endif /* __LINUX_SCALE_BITMAP_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index d79909d..5a7830c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -550,4 +550,7 @@ config STACKDEPOT
 	bool
 	select STACKTRACE
 
+config SCALE_BITMAP
+	bool
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index cfa68eb..10c546d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -228,3 +228,5 @@ obj-$(CONFIG_UCS2_STRING) += ucs2_string.o
 obj-$(CONFIG_UBSAN) += ubsan.o
 
 UBSAN_SANITIZE_ubsan.o := n
+
+obj-$(CONFIG_SCALE_BITMAP) += scale_bitmap.o
diff --git a/lib/scale_bitmap.c b/lib/scale_bitmap.c
new file mode 100644
index 0000000..af2732b
--- /dev/null
+++ b/lib/scale_bitmap.c
@@ -0,0 +1,304 @@
+/*
+ * Copyright (C) 2016 Facebook
+ * Copyright (C) 2013-2014 Jens Axboe
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#include <linux/scale_bitmap.h>
+
+int scale_bitmap_init_node(struct scale_bitmap *bitmap, unsigned int depth,
+			   int shift, gfp_t flags, int node)
+{
+	unsigned int bits_per_word;
+	unsigned int i;
+
+	if (shift < 0) {
+		shift = ilog2(BITS_PER_LONG);
+		/*
+		 * If the bitmap is small, shrink the number of bits per word so
+		 * we spread over a few cachelines, at least. If less than 4
+		 * bits, just forget about it, it's not going to work optimally
+		 * anyway.
+		 */
+		if (depth >= 4) {
+			while ((4U << shift) > depth)
+				shift--;
+		}
+	}
+	bits_per_word = 1U << shift;
+	BUG_ON(bits_per_word > BITS_PER_LONG);
+
+	bitmap->shift = shift;
+	bitmap->depth = depth;
+	bitmap->map_nr = DIV_ROUND_UP(bitmap->depth, bits_per_word);
+
+	if (depth == 0) {
+		bitmap->map = NULL;
+		return 0;
+	}
+
+	bitmap->map = kzalloc_node(bitmap->map_nr * sizeof(*bitmap->map), flags,
+				   node);
+	if (!bitmap->map)
+		return -ENOMEM;
+
+	for (i = 0; i < bitmap->map_nr; i++) {
+		bitmap->map[i].depth = min(depth, bits_per_word);
+		depth -= bitmap->map[i].depth;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_init_node);
+
+void scale_bitmap_resize(struct scale_bitmap *bitmap, unsigned int depth)
+{
+	unsigned int bits_per_word = 1U << bitmap->shift;
+	unsigned int i;
+
+	bitmap->depth = depth;
+	bitmap->map_nr = DIV_ROUND_UP(bitmap->depth, bits_per_word);
+
+	for (i = 0; i < bitmap->map_nr; i++) {
+		bitmap->map[i].depth = min(depth, bits_per_word);
+		depth -= bitmap->map[i].depth;
+	}
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_resize);
+
+bool scale_bitmap_any_bit_set(const struct scale_bitmap *bitmap)
+{
+	unsigned int i;
+
+	for (i = 0; i < bitmap->map_nr; i++) {
+		if (bitmap->map[i].word)
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_any_bit_set);
+
+bool scale_bitmap_any_bit_clear(const struct scale_bitmap *bitmap)
+{
+	unsigned int i;
+
+	for (i = 0; i < bitmap->map_nr; i++) {
+		const struct scale_bitmap_word *word = &bitmap->map[i];
+		unsigned long ret;
+
+		ret = find_first_zero_bit(&word->word, word->depth);
+		if (ret < word->depth)
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_any_bit_clear);
+
+unsigned int scale_bitmap_weight(const struct scale_bitmap *bitmap)
+{
+	unsigned int i, weight;
+
+	for (i = 0; i < bitmap->map_nr; i++) {
+		const struct scale_bitmap_word *word = &bitmap->map[i];
+
+		weight += bitmap_weight(&word->word, word->depth);
+	}
+	return weight;
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_weight);
+
+int scale_bitmap_queue_init_node(struct scale_bitmap_queue *sbq,
+				 unsigned int depth, int shift, gfp_t flags,
+				 int node)
+{
+	int ret;
+	int i;
+
+	ret = scale_bitmap_init_node(&sbq->map, depth, shift, flags, node);
+	if (ret)
+		return ret;
+
+	sbq->wake_batch = SBQ_WAKE_BATCH;
+	if (sbq->wake_batch > depth / SBQ_WAIT_QUEUES)
+		sbq->wake_batch = max(1U, depth / SBQ_WAIT_QUEUES);
+
+	atomic_set(&sbq->wake_index, 0);
+
+	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
+	if (!sbq->ws) {
+		scale_bitmap_free(&sbq->map);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
+		init_waitqueue_head(&sbq->ws[i].wait);
+		atomic_set(&sbq->ws[i].wait_cnt, sbq->wake_batch);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_queue_init_node);
+
+void scale_bitmap_queue_resize(struct scale_bitmap_queue *sbq,
+			       unsigned int depth)
+{
+	scale_bitmap_resize(&sbq->map, depth);
+
+	sbq->wake_batch = SBQ_WAKE_BATCH;
+	if (sbq->wake_batch > depth / SBQ_WAIT_QUEUES)
+		sbq->wake_batch = max(1U, depth / SBQ_WAIT_QUEUES);
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_queue_resize);
+
+static int __sbq_get_word(struct scale_bitmap_word *word,
+			  unsigned int last, bool wrap)
+{
+	unsigned int org_last = last;
+	int nr;
+
+	while (1) {
+		nr = find_next_zero_bit(&word->word, word->depth, last);
+		if (unlikely(nr >= word->depth)) {
+			/*
+			 * We started with an offset, and we didn't reset the
+			 * offset to 0 in a failure case, so start from 0 to
+			 * exhaust the map.
+			 */
+			if (org_last && last && wrap) {
+				last = org_last = 0;
+				continue;
+			}
+			return -1;
+		}
+
+		if (!test_and_set_bit(nr, &word->word))
+			break;
+
+		last = nr + 1;
+		if (last >= word->depth - 1)
+			last = 0;
+	}
+
+	return nr;
+}
+
+int scale_bitmap_queue_get(struct scale_bitmap_queue *sbq,
+			   unsigned int *last_cache, bool round_robin)
+{
+	unsigned int last, org_last;
+	unsigned int i, index;
+	int nr;
+
+	last = org_last = *last_cache;
+	index = SB_NR_TO_INDEX(&sbq->map, last);
+
+	for (i = 0; i < sbq->map.map_nr; i++) {
+		nr = __sbq_get_word(&sbq->map.map[index],
+				    SB_NR_TO_BIT(&sbq->map, last),
+				    !round_robin);
+		if (nr != -1) {
+			nr += index << sbq->map.shift;
+			goto done;
+		}
+
+		/* Jump to next index. */
+		index++;
+		last = index << sbq->map.shift;
+
+		if (index >= sbq->map.map_nr) {
+			index = 0;
+			last = 0;
+		}
+	}
+
+	*last_cache = 0;
+	return -1;
+
+done:
+	/* Only update the cache if we used the cached value. */
+	if (nr == org_last || unlikely(round_robin)) {
+		last = nr + 1;
+		if (last >= sbq->map.depth - 1)
+			last = 0;
+		*last_cache = last;
+	}
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_queue_get);
+
+static struct sbq_wait_state *sbq_wake_ptr(struct scale_bitmap_queue *sbq)
+{
+	int i, wake_index;
+
+	wake_index = atomic_read(&sbq->wake_index);
+	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
+		struct sbq_wait_state *ws = &sbq->ws[wake_index];
+
+		if (waitqueue_active(&ws->wait)) {
+			int o = atomic_read(&sbq->wake_index);
+
+			if (wake_index != o)
+				atomic_cmpxchg(&sbq->wake_index, o, wake_index);
+			return ws;
+		}
+
+		wake_index = sbq_index_inc(wake_index);
+	}
+
+	return NULL;
+}
+
+void scale_bitmap_queue_clear(struct scale_bitmap_queue *sbq, unsigned int nr)
+{
+	struct sbq_wait_state *ws;
+	int wait_cnt;
+
+	scale_bitmap_clear_bit(&sbq->map, nr);
+
+	/* Ensure that the wait list checks occur after clear_bit(). */
+	smp_mb();
+
+	ws = sbq_wake_ptr(sbq);
+	if (!ws)
+		return;
+
+	wait_cnt = atomic_dec_return(&ws->wait_cnt);
+	if (unlikely(wait_cnt < 0))
+		wait_cnt = atomic_inc_return(&ws->wait_cnt);
+	if (wait_cnt == 0) {
+		atomic_add(sbq->wake_batch, &ws->wait_cnt);
+		sbq_index_atomic_inc(&sbq->wake_index);
+		wake_up(&ws->wait);
+	}
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_queue_clear);
+
+void scale_bitmap_queue_wake_all(struct scale_bitmap_queue *sbq)
+{
+	int i, wake_index;
+
+	/*
+	 * Make sure all changes prior to this are visible from other CPUs.
+	 */
+	smp_mb();
+	wake_index = atomic_read(&sbq->wake_index);
+	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
+		struct sbq_wait_state *ws = &sbq->ws[wake_index];
+
+		if (waitqueue_active(&ws->wait))
+			wake_up(&ws->wait);
+
+		wake_index = sbq_index_inc(wake_index);
+	}
+}
+EXPORT_SYMBOL_GPL(scale_bitmap_queue_wake_all);
-- 
2.9.3

