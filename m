Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE085C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjC0UOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjC0UOL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:11 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C791BF6
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:19 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id t19so9790941qta.12
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZEmP2Lma0r81Bos8w4U89OEq/V+OweIm/gue2zysiY=;
        b=zatRm5vcsBOJvKzHkYbhsp4LXTmtC97qp1dB94djR7hu2Zyq8pvmP8wWZT5f//RZhr
         hRXoPY80mMFPz8DZjlu8QhPok+2Gd9eUkw3WxSfJWgEi3AuKe9nbzLnTLFuQn01Tjxug
         jUWS1CoHapGBWEDmfJPJqVIiQg47mCg5/ANjIqLBsnPESr5KuhRTE9ivq6NFa6MPgN4P
         20WnCSN1fhTSMwvsrCJDL9gvRa6G6N6RkQ78KKduIip6+eVomTNRI+H8kB/jy9Fjuwkt
         5McdXjAo7Fi5dGHXwctBIL9LIQokfZF3mzlyBPFgxUjpHz1srjr2Q+psm+XkFRI7XN7A
         au+w==
X-Gm-Message-State: AO0yUKUBJWgwAtAkMsa6p4tDFNEsHv7tZMHr7ty1na2UsScN1CyoxdIH
        5Bu/DtRQy+TCNH+KOtDoXjBV
X-Google-Smtp-Source: AK7set/4u5wtNp1+7i337s6/269TkCLiJgXwRPcmr5VJh9wfIB7rZepSb8dvmBloMyznyDlN/1yP2Q==
X-Received: by 2002:a05:622a:1109:b0:3e3:82c4:db44 with SMTP id e9-20020a05622a110900b003e382c4db44mr23802990qty.52.1679947998246;
        Mon, 27 Mar 2023 13:13:18 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id u23-20020a37ab17000000b0071f0d0aaef7sm13735581qke.80.2023.03.27.13.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:17 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 07/20] dm bufio: improve concurrent IO performance
Date:   Mon, 27 Mar 2023 16:11:30 -0400
Message-Id: <20230327201143.51026-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

When multiple threads perform IO to a thin device, the underlying
dm_bufio object can become a bottleneck; slowing down access to btree
nodes that store the thin metadata. Prior to this commit, each bufio
instance had a single mutex that was taken for every bufio operation.

This commit concentrates on improving the common case where: a user of
dm_bufio wishes to access, but not modify, a buffer which is already
within the dm_bufio cache.

Implementation::

  The code has been refactored; pulling out an 'lru' abstraction and a
  'buffer cache' abstraction (see 2 previous commits). This commit
  updates higher level bufio code (that performs allocation of buffers,
  IO and eviction/cache sizing) to leverage both abstractions. It also
  deals with the delicate locking requirements of both abstractions to
  provide finer grained locking. The result is significantly better
  concurrent IO performance.

  Before this commit, bufio has a global lru list it used to evict the
  oldest, clean buffers from _all_ clients. With the new locking we
  don’t want different ways to access the same buffer, so instead
  do_global_cleanup() loops around the clients asking them to free
  buffers older than a certain time.

  This commit also converts many old BUG_ONs to WARN_ON_ONCE, see the
  lru_evict and cache_evict code in particular.  They will return
  ER_DONT_EVICT if a given buffer somehow meets the invariants that
  should _never_ happen. [Aside from revising this commit's header and
  fixing coding style and whitespace nits: this switching to
  WARN_ON_ONCE is Mike Snitzer's lone contribution to this commit]

Testing::

  Some of the low level functions have been unit tested using dm-unit:
    https://github.com/jthornber/dm-unit/blob/main/src/tests/bufio.rs

  Higher level concurrency and IO is tested via a test only target
  found here:
    https://github.com/jthornber/linux/blob/2023-03-24-thin-concurrency-9/drivers/md/dm-bufio-test.c

  The associated userland side of these tests is here:
    https://github.com/jthornber/dmtest-python/blob/main/src/dmtest/bufio/bufio_tests.py

  In addition the full dmtest suite of tests (dm-thin, dm-cache, etc)
  has been run (~450 tests).

Performance::

  Most bufio operations have unchanged performance. But if multiple
  threads are attempting to get buffers concurrently, and these
  buffers are already in the cache then there's a big speed up. Eg,
  one test has 16 'hotspot' threads simulating btree lookups while
  another thread dirties the whole device. In this case the hotspot
  threads acquire the buffers about 25 times faster.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 959 +++++++++++++++++++++---------------------
 1 file changed, 487 insertions(+), 472 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 9daff9b77cee..1e000ec73bd6 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -321,37 +321,42 @@ enum data_mode {
 };
 
 struct dm_buffer {
+	/* protected by the locks in dm_buffer_cache */
 	struct rb_node node;
-	struct list_head lru_list;
-	struct list_head global_list;
 
+	/* immutable, so don't need protecting */
 	sector_t block;
 	void *data;
 	unsigned char data_mode;		/* DATA_MODE_* */
 
-	unsigned int accessed;
-	unsigned int __hold_count;
+	/*
+	 * These two fields are used in isolation, so do not need
+	 * a surrounding lock.
+	 */
+	atomic_t hold_count;
 	unsigned long last_accessed;
 
+	/*
+	 * Everything else is protected by the mutex in
+	 * dm_bufio_client
+	 */
+	unsigned long state;
+	struct lru_entry lru;
 	unsigned char list_mode;		/* LIST_* */
 	blk_status_t read_error;
 	blk_status_t write_error;
-	unsigned long state;
 	unsigned int dirty_start;
 	unsigned int dirty_end;
 	unsigned int write_start;
 	unsigned int write_end;
-	struct dm_bufio_client *c;
 	struct list_head write_list;
+	struct dm_bufio_client *c;
 	void (*end_io)(struct dm_buffer *b, blk_status_t bs);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 #define MAX_STACK 10
 	unsigned int stack_len;
 	unsigned long stack_entries[MAX_STACK];
 #endif
-	/* Temp members to allow dm_buffer_cache code to compile */
-	atomic_t hold_count;
-	struct lru_entry lru;
 };
 
 /*--------------------------------------------------------------*/
@@ -814,7 +819,7 @@ static void cache_remove_range(struct dm_buffer_cache *bc,
 
 /*
  * Linking of buffers:
- *	All buffers are linked to buffer_tree with their node field.
+ *	All buffers are linked to buffer_cache with their node field.
  *
  *	Clean buffers that are not being written (B_WRITING not set)
  *	are linked to lru[LIST_CLEAN] with their lru_list field.
@@ -832,9 +837,6 @@ struct dm_bufio_client {
 	spinlock_t spinlock;
 	bool no_sleep;
 
-	struct list_head lru[LIST_SIZE];
-	unsigned long n_buffers[LIST_SIZE];
-
 	struct block_device *bdev;
 	unsigned int block_size;
 	s8 sectors_per_block_bits;
@@ -849,7 +851,7 @@ struct dm_bufio_client {
 
 	unsigned int minimum_buffers;
 
-	struct rb_root buffer_tree;
+	struct dm_buffer_cache cache;
 	wait_queue_head_t free_buffer_wait;
 
 	sector_t start;
@@ -861,6 +863,11 @@ struct dm_bufio_client {
 	struct shrinker shrinker;
 	struct work_struct shrink_work;
 	atomic_long_t need_shrink;
+
+	/*
+	 * Used by global_cleanup to sort the clients list.
+	 */
+	unsigned long oldest_buffer;
 };
 
 static DEFINE_STATIC_KEY_FALSE(no_sleep_enabled);
@@ -877,14 +884,6 @@ static void dm_bufio_lock(struct dm_bufio_client *c)
 		mutex_lock_nested(&c->lock, dm_bufio_in_request());
 }
 
-static int dm_bufio_trylock(struct dm_bufio_client *c)
-{
-	if (static_branch_unlikely(&no_sleep_enabled) && c->no_sleep)
-		return spin_trylock_bh(&c->spinlock);
-	else
-		return mutex_trylock(&c->lock);
-}
-
 static void dm_bufio_unlock(struct dm_bufio_client *c)
 {
 	if (static_branch_unlikely(&no_sleep_enabled) && c->no_sleep)
@@ -913,10 +912,6 @@ static unsigned long dm_bufio_cache_size_latch;
 
 static DEFINE_SPINLOCK(global_spinlock);
 
-static LIST_HEAD(global_queue);
-
-static unsigned long global_num;
-
 /*
  * Buffers are freed after this timeout
  */
@@ -958,78 +953,6 @@ static void buffer_record_stack(struct dm_buffer *b)
 }
 #endif
 
-/*
- *----------------------------------------------------------------
- * A red/black tree acts as an index for all the buffers.
- *----------------------------------------------------------------
- */
-static struct dm_buffer *__find(struct dm_bufio_client *c, sector_t block)
-{
-	struct rb_node *n = c->buffer_tree.rb_node;
-	struct dm_buffer *b;
-
-	while (n) {
-		b = container_of(n, struct dm_buffer, node);
-
-		if (b->block == block)
-			return b;
-
-		n = block < b->block ? n->rb_left : n->rb_right;
-	}
-
-	return NULL;
-}
-
-static struct dm_buffer *__find_next_old(struct dm_bufio_client *c, sector_t block)
-{
-	struct rb_node *n = c->buffer_tree.rb_node;
-	struct dm_buffer *b;
-	struct dm_buffer *best = NULL;
-
-	while (n) {
-		b = container_of(n, struct dm_buffer, node);
-
-		if (b->block == block)
-			return b;
-
-		if (block <= b->block) {
-			n = n->rb_left;
-			best = b;
-		} else {
-			n = n->rb_right;
-		}
-	}
-
-	return best;
-}
-
-static void __insert(struct dm_bufio_client *c, struct dm_buffer *b)
-{
-	struct rb_node **new = &c->buffer_tree.rb_node, *parent = NULL;
-	struct dm_buffer *found;
-
-	while (*new) {
-		found = container_of(*new, struct dm_buffer, node);
-
-		if (found->block == b->block) {
-			BUG_ON(found != b);
-			return;
-		}
-
-		parent = *new;
-		new = b->block < found->block ?
-			&found->node.rb_left : &found->node.rb_right;
-	}
-
-	rb_link_node(&b->node, parent, new);
-	rb_insert_color(&b->node, &c->buffer_tree);
-}
-
-static void __remove(struct dm_bufio_client *c, struct dm_buffer *b)
-{
-	rb_erase(&b->node, &c->buffer_tree);
-}
-
 /*----------------------------------------------------------------*/
 
 static void adjust_total_allocated(struct dm_buffer *b, bool unlink)
@@ -1057,16 +980,9 @@ static void adjust_total_allocated(struct dm_buffer *b, bool unlink)
 	if (dm_bufio_current_allocated > dm_bufio_peak_allocated)
 		dm_bufio_peak_allocated = dm_bufio_current_allocated;
 
-	b->accessed = 1;
-
 	if (!unlink) {
-		list_add(&b->global_list, &global_queue);
-		global_num++;
 		if (dm_bufio_current_allocated > dm_bufio_cache_size)
 			queue_work(dm_bufio_wq, &dm_bufio_replacement_work);
-	} else {
-		list_del(&b->global_list);
-		global_num--;
 	}
 
 	spin_unlock(&global_spinlock);
@@ -1196,6 +1112,7 @@ static struct dm_buffer *alloc_buffer(struct dm_bufio_client *c, gfp_t gfp_mask)
 		kmem_cache_free(c->slab_buffer, b);
 		return NULL;
 	}
+	adjust_total_allocated(b, false);
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 	b->stack_len = 0;
@@ -1210,61 +1127,11 @@ static void free_buffer(struct dm_buffer *b)
 {
 	struct dm_bufio_client *c = b->c;
 
+	adjust_total_allocated(b, true);
 	free_buffer_data(c, b->data, b->data_mode);
 	kmem_cache_free(c->slab_buffer, b);
 }
 
-/*
- * Link buffer to the buffer tree and clean or dirty queue.
- */
-static void __link_buffer(struct dm_buffer *b, sector_t block, int dirty)
-{
-	struct dm_bufio_client *c = b->c;
-
-	c->n_buffers[dirty]++;
-	b->block = block;
-	b->list_mode = dirty;
-	list_add(&b->lru_list, &c->lru[dirty]);
-	__insert(b->c, b);
-	b->last_accessed = jiffies;
-
-	adjust_total_allocated(b, false);
-}
-
-/*
- * Unlink buffer from the buffer tree and dirty or clean queue.
- */
-static void __unlink_buffer(struct dm_buffer *b)
-{
-	struct dm_bufio_client *c = b->c;
-
-	BUG_ON(!c->n_buffers[b->list_mode]);
-
-	c->n_buffers[b->list_mode]--;
-	__remove(b->c, b);
-	list_del(&b->lru_list);
-
-	adjust_total_allocated(b, true);
-}
-
-/*
- * Place the buffer to the head of dirty or clean LRU queue.
- */
-static void __relink_lru(struct dm_buffer *b, int dirty)
-{
-	struct dm_bufio_client *c = b->c;
-
-	b->accessed = 1;
-
-	BUG_ON(!c->n_buffers[b->list_mode]);
-
-	c->n_buffers[b->list_mode]--;
-	c->n_buffers[dirty]++;
-	b->list_mode = dirty;
-	list_move(&b->lru_list, &c->lru[dirty]);
-	b->last_accessed = jiffies;
-}
-
 /*
  *--------------------------------------------------------------------------
  * Submit I/O on the buffer.
@@ -1504,7 +1371,7 @@ static void __flush_write_list(struct list_head *write_list)
  */
 static void __make_buffer_clean(struct dm_buffer *b)
 {
-	BUG_ON(b->__hold_count);
+	BUG_ON(atomic_read(&b->hold_count));
 
 	/* smp_load_acquire() pairs with read_endio()'s smp_mb__before_atomic() */
 	if (!smp_load_acquire(&b->state))	/* fast case */
@@ -1515,6 +1382,36 @@ static void __make_buffer_clean(struct dm_buffer *b)
 	wait_on_bit_io(&b->state, B_WRITING, TASK_UNINTERRUPTIBLE);
 }
 
+static enum evict_result is_clean(struct dm_buffer *b, void *context)
+{
+	struct dm_bufio_client *c = context;
+
+	/* These should never happen */
+	if (WARN_ON_ONCE(test_bit(B_WRITING, &b->state)))
+		return ER_DONT_EVICT;
+	if (WARN_ON_ONCE(test_bit(B_DIRTY, &b->state)))
+		return ER_DONT_EVICT;
+	if (WARN_ON_ONCE(b->list_mode != LIST_CLEAN))
+		return ER_DONT_EVICT;
+
+	if (static_branch_unlikely(&no_sleep_enabled) && c->no_sleep &&
+	    unlikely(test_bit(B_READING, &b->state)))
+		return ER_DONT_EVICT;
+
+	return ER_EVICT;
+}
+
+static enum evict_result is_dirty(struct dm_buffer *b, void *context)
+{
+	/* These should never happen */
+	if (WARN_ON_ONCE(test_bit(B_READING, &b->state)))
+		return ER_DONT_EVICT;
+	if (WARN_ON_ONCE(b->list_mode != LIST_DIRTY))
+		return ER_DONT_EVICT;
+
+	return ER_EVICT;
+}
+
 /*
  * Find some buffer that is not held by anybody, clean it, unlink it and
  * return it.
@@ -1523,34 +1420,20 @@ static struct dm_buffer *__get_unclaimed_buffer(struct dm_bufio_client *c)
 {
 	struct dm_buffer *b;
 
-	list_for_each_entry_reverse(b, &c->lru[LIST_CLEAN], lru_list) {
-		BUG_ON(test_bit(B_WRITING, &b->state));
-		BUG_ON(test_bit(B_DIRTY, &b->state));
-
-		if (static_branch_unlikely(&no_sleep_enabled) && c->no_sleep &&
-		    unlikely(test_bit_acquire(B_READING, &b->state)))
-			continue;
-
-		if (!b->__hold_count) {
-			__make_buffer_clean(b);
-			__unlink_buffer(b);
-			return b;
-		}
-		cond_resched();
+	b = cache_evict(&c->cache, LIST_CLEAN, is_clean, c);
+	if (b) {
+		/* this also waits for pending reads */
+		__make_buffer_clean(b);
+		return b;
 	}
 
 	if (static_branch_unlikely(&no_sleep_enabled) && c->no_sleep)
 		return NULL;
 
-	list_for_each_entry_reverse(b, &c->lru[LIST_DIRTY], lru_list) {
-		BUG_ON(test_bit(B_READING, &b->state));
-
-		if (!b->__hold_count) {
-			__make_buffer_clean(b);
-			__unlink_buffer(b);
-			return b;
-		}
-		cond_resched();
+	b = cache_evict(&c->cache, LIST_DIRTY, is_dirty, NULL);
+	if (b) {
+		__make_buffer_clean(b);
+		return b;
 	}
 
 	return NULL;
@@ -1571,7 +1454,12 @@ static void __wait_for_free_buffer(struct dm_bufio_client *c)
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	dm_bufio_unlock(c);
 
-	io_schedule();
+	/*
+	 * It's possible to miss a wake up event since we don't always
+	 * hold c->lock when wake_up is called.  So we have a timeout here,
+	 * just in case.
+	 */
+	io_schedule_timeout(5 * HZ);
 
 	remove_wait_queue(&c->free_buffer_wait, &wait);
 
@@ -1629,9 +1517,8 @@ static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client
 		}
 
 		if (!list_empty(&c->reserved_buffers)) {
-			b = list_entry(c->reserved_buffers.next,
-				       struct dm_buffer, lru_list);
-			list_del(&b->lru_list);
+			b = list_to_buffer(c->reserved_buffers.next);
+			list_del(&b->lru.list);
 			c->need_reserved_buffers++;
 
 			return b;
@@ -1665,36 +1552,56 @@ static void __free_buffer_wake(struct dm_buffer *b)
 {
 	struct dm_bufio_client *c = b->c;
 
+	b->block = -1;
 	if (!c->need_reserved_buffers)
 		free_buffer(b);
 	else {
-		list_add(&b->lru_list, &c->reserved_buffers);
+		list_add(&b->lru.list, &c->reserved_buffers);
 		c->need_reserved_buffers--;
 	}
 
 	wake_up(&c->free_buffer_wait);
 }
 
+static enum evict_result cleaned(struct dm_buffer *b, void *context)
+{
+	if (WARN_ON_ONCE(test_bit(B_READING, &b->state)))
+		return ER_DONT_EVICT; /* should never happen */
+
+	if (test_bit(B_DIRTY, &b->state) || test_bit(B_WRITING, &b->state))
+		return ER_DONT_EVICT;
+	else
+		return ER_EVICT;
+}
+
+static void __move_clean_buffers(struct dm_bufio_client *c)
+{
+	cache_mark_many(&c->cache, LIST_DIRTY, LIST_CLEAN, cleaned, NULL);
+}
+
+struct write_context {
+	int no_wait;
+	struct list_head *write_list;
+};
+
+static enum it_action write_one(struct dm_buffer *b, void *context)
+{
+	struct write_context *wc = context;
+
+	if (wc->no_wait && test_bit(B_WRITING, &b->state))
+		return IT_COMPLETE;
+
+	__write_dirty_buffer(b, wc->write_list);
+	return IT_NEXT;
+}
+
 static void __write_dirty_buffers_async(struct dm_bufio_client *c, int no_wait,
 					struct list_head *write_list)
 {
-	struct dm_buffer *b, *tmp;
+	struct write_context wc = {.no_wait = no_wait, .write_list = write_list};
 
-	list_for_each_entry_safe_reverse(b, tmp, &c->lru[LIST_DIRTY], lru_list) {
-		BUG_ON(test_bit(B_READING, &b->state));
-
-		if (!test_bit(B_DIRTY, &b->state) &&
-		    !test_bit(B_WRITING, &b->state)) {
-			__relink_lru(b, LIST_CLEAN);
-			continue;
-		}
-
-		if (no_wait && test_bit(B_WRITING, &b->state))
-			return;
-
-		__write_dirty_buffer(b, write_list);
-		cond_resched();
-	}
+	__move_clean_buffers(c);
+	cache_iterate(&c->cache, LIST_DIRTY, write_one, &wc);
 }
 
 /*
@@ -1705,7 +1612,8 @@ static void __write_dirty_buffers_async(struct dm_bufio_client *c, int no_wait,
 static void __check_watermark(struct dm_bufio_client *c,
 			      struct list_head *write_list)
 {
-	if (c->n_buffers[LIST_DIRTY] > c->n_buffers[LIST_CLEAN] * DM_BUFIO_WRITEBACK_RATIO)
+	if (cache_count(&c->cache, LIST_DIRTY) >
+	    cache_count(&c->cache, LIST_CLEAN) * DM_BUFIO_WRITEBACK_RATIO)
 		__write_dirty_buffers_async(c, 1, write_list);
 }
 
@@ -1715,6 +1623,21 @@ static void __check_watermark(struct dm_bufio_client *c,
  *--------------------------------------------------------------
  */
 
+static void cache_put_and_wake(struct dm_bufio_client *c, struct dm_buffer *b)
+{
+	/*
+	 * Relying on waitqueue_active() is racey, but we sleep
+	 * with schedule_timeout anyway.
+	 */
+	if (cache_put(&c->cache, b) &&
+	    unlikely(waitqueue_active(&c->free_buffer_wait)))
+		wake_up(&c->free_buffer_wait);
+}
+
+/*
+ * This assumes you have already checked the cache to see if the buffer
+ * is already present (it will recheck after dropping the lock for allocation).
+ */
 static struct dm_buffer *__bufio_new(struct dm_bufio_client *c, sector_t block,
 				     enum new_flag nf, int *need_submit,
 				     struct list_head *write_list)
@@ -1723,11 +1646,8 @@ static struct dm_buffer *__bufio_new(struct dm_bufio_client *c, sector_t block,
 
 	*need_submit = 0;
 
-	b = __find(c, block);
-	if (b)
-		goto found_buffer;
-
-	if (nf == NF_GET)
+	/* This can't be called with NF_GET */
+	if (WARN_ON_ONCE(nf == NF_GET))
 		return NULL;
 
 	new_b = __alloc_buffer_wait(c, nf);
@@ -1738,7 +1658,7 @@ static struct dm_buffer *__bufio_new(struct dm_bufio_client *c, sector_t block,
 	 * We've had a period where the mutex was unlocked, so need to
 	 * recheck the buffer tree.
 	 */
-	b = __find(c, block);
+	b = cache_get(&c->cache, block);
 	if (b) {
 		__free_buffer_wake(new_b);
 		goto found_buffer;
@@ -1747,24 +1667,35 @@ static struct dm_buffer *__bufio_new(struct dm_bufio_client *c, sector_t block,
 	__check_watermark(c, write_list);
 
 	b = new_b;
-	b->__hold_count = 1;
+	atomic_set(&b->hold_count, 1);
+	WRITE_ONCE(b->last_accessed, jiffies);
+	b->block = block;
 	b->read_error = 0;
 	b->write_error = 0;
-	__link_buffer(b, block, LIST_CLEAN);
+	b->list_mode = LIST_CLEAN;
 
-	if (nf == NF_FRESH) {
+	if (nf == NF_FRESH)
 		b->state = 0;
-		return b;
+	else {
+		b->state = 1 << B_READING;
+		*need_submit = 1;
 	}
 
-	b->state = 1 << B_READING;
-	*need_submit = 1;
+	/*
+	 * We mustn't insert into the cache until the B_READING state
+	 * is set.  Otherwise another thread could get it and use
+	 * it before it had been read.
+	 */
+	cache_insert(&c->cache, b);
 
 	return b;
 
 found_buffer:
-	if (nf == NF_PREFETCH)
+	if (nf == NF_PREFETCH) {
+		cache_put_and_wake(c, b);
 		return NULL;
+	}
+
 	/*
 	 * Note: it is essential that we don't wait for the buffer to be
 	 * read if dm_bufio_get function is used. Both dm_bufio_get and
@@ -1772,12 +1703,11 @@ static struct dm_buffer *__bufio_new(struct dm_bufio_client *c, sector_t block,
 	 * If the user called both dm_bufio_prefetch and dm_bufio_get on
 	 * the same buffer, it would deadlock if we waited.
 	 */
-	if (nf == NF_GET && unlikely(test_bit_acquire(B_READING, &b->state)))
+	if (nf == NF_GET && unlikely(test_bit_acquire(B_READING, &b->state))) {
+		cache_put_and_wake(c, b);
 		return NULL;
+	}
 
-	b->__hold_count++;
-	__relink_lru(b, test_bit(B_DIRTY, &b->state) ||
-		     test_bit(B_WRITING, &b->state));
 	return b;
 }
 
@@ -1807,18 +1737,50 @@ static void read_endio(struct dm_buffer *b, blk_status_t status)
 static void *new_read(struct dm_bufio_client *c, sector_t block,
 		      enum new_flag nf, struct dm_buffer **bp)
 {
-	int need_submit;
+	int need_submit = 0;
 	struct dm_buffer *b;
 
 	LIST_HEAD(write_list);
 
-	dm_bufio_lock(c);
-	b = __bufio_new(c, block, nf, &need_submit, &write_list);
+	*bp = NULL;
+
+	/*
+	 * Fast path, hopefully the block is already in the cache.  No need
+	 * to get the client lock for this.
+	 */
+	b = cache_get(&c->cache, block);
+	if (b) {
+		if (nf == NF_PREFETCH) {
+			cache_put_and_wake(c, b);
+			return NULL;
+		}
+
+		/*
+		 * Note: it is essential that we don't wait for the buffer to be
+		 * read if dm_bufio_get function is used. Both dm_bufio_get and
+		 * dm_bufio_prefetch can be used in the driver request routine.
+		 * If the user called both dm_bufio_prefetch and dm_bufio_get on
+		 * the same buffer, it would deadlock if we waited.
+		 */
+		if (nf == NF_GET && unlikely(test_bit_acquire(B_READING, &b->state))) {
+			cache_put_and_wake(c, b);
+			return NULL;
+		}
+	}
+
+	if (!b) {
+		if (nf == NF_GET)
+			return NULL;
+
+		dm_bufio_lock(c);
+		b = __bufio_new(c, block, nf, &need_submit, &write_list);
+		dm_bufio_unlock(c);
+	}
+
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-	if (b && b->hold_count == 1)
+	if (b && (atomic_read(&b->hold_count) == 1))
 		buffer_record_stack(b);
 #endif
-	dm_bufio_unlock(c);
 
 	__flush_write_list(&write_list);
 
@@ -1881,12 +1843,19 @@ void dm_bufio_prefetch(struct dm_bufio_client *c,
 		return; /* should never happen */
 
 	blk_start_plug(&plug);
-	dm_bufio_lock(c);
 
 	for (; n_blocks--; block++) {
 		int need_submit;
 		struct dm_buffer *b;
 
+		b = cache_get(&c->cache, block);
+		if (b) {
+			/* already in cache */
+			cache_put_and_wake(c, b);
+			continue;
+		}
+
+		dm_bufio_lock(c);
 		b = __bufio_new(c, block, NF_PREFETCH, &need_submit,
 				&write_list);
 		if (unlikely(!list_empty(&write_list))) {
@@ -1909,10 +1878,9 @@ void dm_bufio_prefetch(struct dm_bufio_client *c,
 				goto flush_plug;
 			dm_bufio_lock(c);
 		}
+		dm_bufio_unlock(c);
 	}
 
-	dm_bufio_unlock(c);
-
 flush_plug:
 	blk_finish_plug(&plug);
 }
@@ -1922,29 +1890,28 @@ void dm_bufio_release(struct dm_buffer *b)
 {
 	struct dm_bufio_client *c = b->c;
 
-	dm_bufio_lock(c);
+	/*
+	 * If there were errors on the buffer, and the buffer is not
+	 * to be written, free the buffer. There is no point in caching
+	 * invalid buffer.
+	 */
+	if ((b->read_error || b->write_error) &&
+	    !test_bit_acquire(B_READING, &b->state) &&
+	    !test_bit(B_WRITING, &b->state) &&
+	    !test_bit(B_DIRTY, &b->state)) {
+		dm_bufio_lock(c);
 
-	BUG_ON(!b->__hold_count);
-
-	b->__hold_count--;
-	if (!b->__hold_count) {
-		wake_up(&c->free_buffer_wait);
-
-		/*
-		 * If there were errors on the buffer, and the buffer is not
-		 * to be written, free the buffer. There is no point in caching
-		 * invalid buffer.
-		 */
-		if ((b->read_error || b->write_error) &&
-		    !test_bit_acquire(B_READING, &b->state) &&
-		    !test_bit(B_WRITING, &b->state) &&
-		    !test_bit(B_DIRTY, &b->state)) {
-			__unlink_buffer(b);
+		/* cache remove can fail if there are other holders */
+		if (cache_remove(&c->cache, b)) {
 			__free_buffer_wake(b);
+			dm_bufio_unlock(c);
+			return;
 		}
+
+		dm_bufio_unlock(c);
 	}
 
-	dm_bufio_unlock(c);
+	cache_put_and_wake(c, b);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_release);
 
@@ -1963,7 +1930,7 @@ void dm_bufio_mark_partial_buffer_dirty(struct dm_buffer *b,
 	if (!test_and_set_bit(B_DIRTY, &b->state)) {
 		b->dirty_start = start;
 		b->dirty_end = end;
-		__relink_lru(b, LIST_DIRTY);
+		cache_mark(&c->cache, b, LIST_DIRTY);
 	} else {
 		if (start < b->dirty_start)
 			b->dirty_start = start;
@@ -2002,11 +1969,19 @@ EXPORT_SYMBOL_GPL(dm_bufio_write_dirty_buffers_async);
  *
  * Finally, we flush hardware disk cache.
  */
+static bool is_writing(struct lru_entry *e, void *context)
+{
+	struct dm_buffer *b = le_to_buffer(e);
+
+	return test_bit(B_WRITING, &b->state);
+}
+
 int dm_bufio_write_dirty_buffers(struct dm_bufio_client *c)
 {
 	int a, f;
-	unsigned long buffers_processed = 0;
-	struct dm_buffer *b, *tmp;
+	unsigned long nr_buffers;
+	struct lru_entry *e;
+	struct lru_iter it;
 
 	LIST_HEAD(write_list);
 
@@ -2016,52 +1991,32 @@ int dm_bufio_write_dirty_buffers(struct dm_bufio_client *c)
 	__flush_write_list(&write_list);
 	dm_bufio_lock(c);
 
-again:
-	list_for_each_entry_safe_reverse(b, tmp, &c->lru[LIST_DIRTY], lru_list) {
-		int dropped_lock = 0;
-
-		if (buffers_processed < c->n_buffers[LIST_DIRTY])
-			buffers_processed++;
+	nr_buffers = cache_count(&c->cache, LIST_DIRTY);
+	lru_iter_begin(&c->cache.lru[LIST_DIRTY], &it);
+	while ((e = lru_iter_next(&it, is_writing, c))) {
+		struct dm_buffer *b = le_to_buffer(e);
+		__cache_inc_buffer(b);
 
 		BUG_ON(test_bit(B_READING, &b->state));
 
-		if (test_bit(B_WRITING, &b->state)) {
-			if (buffers_processed < c->n_buffers[LIST_DIRTY]) {
-				dropped_lock = 1;
-				b->__hold_count++;
-				dm_bufio_unlock(c);
-				wait_on_bit_io(&b->state, B_WRITING,
-					       TASK_UNINTERRUPTIBLE);
-				dm_bufio_lock(c);
-				b->__hold_count--;
-			} else
-				wait_on_bit_io(&b->state, B_WRITING,
-					       TASK_UNINTERRUPTIBLE);
+		if (nr_buffers) {
+			nr_buffers--;
+			dm_bufio_unlock(c);
+			wait_on_bit_io(&b->state, B_WRITING, TASK_UNINTERRUPTIBLE);
+			dm_bufio_lock(c);
+		} else {
+			wait_on_bit_io(&b->state, B_WRITING, TASK_UNINTERRUPTIBLE);
 		}
 
-		if (!test_bit(B_DIRTY, &b->state) &&
-		    !test_bit(B_WRITING, &b->state))
-			__relink_lru(b, LIST_CLEAN);
+		if (!test_bit(B_DIRTY, &b->state) && !test_bit(B_WRITING, &b->state))
+			cache_mark(&c->cache, b, LIST_CLEAN);
+
+		cache_put_and_wake(c, b);
 
 		cond_resched();
-
-		/*
-		 * If we dropped the lock, the list is no longer consistent,
-		 * so we must restart the search.
-		 *
-		 * In the most common case, the buffer just processed is
-		 * relinked to the clean list, so we won't loop scanning the
-		 * same buffer again and again.
-		 *
-		 * This may livelock if there is another thread simultaneously
-		 * dirtying buffers, so we count the number of buffers walked
-		 * and if it exceeds the total number of buffers, it means that
-		 * someone is doing some writes simultaneously with us.  In
-		 * this case, stop, dropping the lock.
-		 */
-		if (dropped_lock)
-			goto again;
 	}
+	lru_iter_end(&it);
+
 	wake_up(&c->free_buffer_wait);
 	dm_bufio_unlock(c);
 
@@ -2122,12 +2077,23 @@ int dm_bufio_issue_discard(struct dm_bufio_client *c, sector_t block, sector_t c
 }
 EXPORT_SYMBOL_GPL(dm_bufio_issue_discard);
 
-static void forget_buffer_locked(struct dm_buffer *b)
+static bool forget_buffer(struct dm_bufio_client *c, sector_t block)
 {
-	if (likely(!b->__hold_count) && likely(!smp_load_acquire(&b->state))) {
-		__unlink_buffer(b);
-		__free_buffer_wake(b);
+	struct dm_buffer *b;
+
+	b = cache_get(&c->cache, block);
+	if (b) {
+		if (likely(!smp_load_acquire(&b->state))) {
+			if (cache_remove(&c->cache, b))
+				__free_buffer_wake(b);
+			else
+				cache_put_and_wake(c, b);
+		} else {
+			cache_put_and_wake(c, b);
+		}
 	}
+
+	return b ? true : false;
 }
 
 /*
@@ -2138,38 +2104,22 @@ static void forget_buffer_locked(struct dm_buffer *b)
  */
 void dm_bufio_forget(struct dm_bufio_client *c, sector_t block)
 {
-	struct dm_buffer *b;
-
 	dm_bufio_lock(c);
-
-	b = __find(c, block);
-	if (b)
-		forget_buffer_locked(b);
-
+	forget_buffer(c, block);
 	dm_bufio_unlock(c);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_forget);
 
+static enum evict_result idle(struct dm_buffer *b, void *context)
+{
+	return b->state ? ER_DONT_EVICT : ER_EVICT;
+}
+
 void dm_bufio_forget_buffers(struct dm_bufio_client *c, sector_t block, sector_t n_blocks)
 {
-	struct dm_buffer *b;
-	sector_t end_block = block + n_blocks;
-
-	while (block < end_block) {
-		dm_bufio_lock(c);
-
-		b = __find_next_old(c, block);
-		if (b) {
-			block = b->block + 1;
-			forget_buffer_locked(b);
-		}
-
-		dm_bufio_unlock(c);
-
-		if (!b)
-			break;
-	}
-
+	dm_bufio_lock(c);
+	cache_remove_range(&c->cache, block, block + n_blocks, idle, __free_buffer_wake);
+	dm_bufio_unlock(c);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_forget_buffers);
 
@@ -2231,11 +2181,26 @@ struct dm_bufio_client *dm_bufio_get_client(struct dm_buffer *b)
 }
 EXPORT_SYMBOL_GPL(dm_bufio_get_client);
 
+static enum it_action warn_leak(struct dm_buffer *b, void *context)
+{
+	bool *warned = context;
+
+	WARN_ON(!(*warned));
+	*warned = true;
+	DMERR("leaked buffer %llx, hold count %u, list %d",
+	      (unsigned long long)b->block, atomic_read(&b->hold_count), b->list_mode);
+#ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
+	stack_trace_print(b->stack_entries, b->stack_len, 1);
+	/* mark unclaimed to avoid WARN_ON at end of drop_buffers() */
+	atomic_set(&b->hold_count, 0);
+#endif
+	return IT_NEXT;
+}
+
 static void drop_buffers(struct dm_bufio_client *c)
 {
-	struct dm_buffer *b;
 	int i;
-	bool warned = false;
+	struct dm_buffer *b;
 
 	if (WARN_ON(dm_bufio_in_request()))
 		return; /* should never happen */
@@ -2250,18 +2215,11 @@ static void drop_buffers(struct dm_bufio_client *c)
 	while ((b = __get_unclaimed_buffer(c)))
 		__free_buffer_wake(b);
 
-	for (i = 0; i < LIST_SIZE; i++)
-		list_for_each_entry(b, &c->lru[i], lru_list) {
-			WARN_ON(!warned);
-			warned = true;
-			DMERR("leaked buffer %llx, hold count %u, list %d",
-			      (unsigned long long)b->block, b->__hold_count, i);
-#ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-			stack_trace_print(b->stack_entries, b->stack_len, 1);
-			/* mark unclaimed to avoid WARN_ON below */
-			b->hold_count = 0;
-#endif
-		}
+	for (i = 0; i < LIST_SIZE; i++) {
+		bool warned = false;
+
+		cache_iterate(&c->cache, i, warn_leak, &warned);
+	}
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 	while ((b = __get_unclaimed_buffer(c)))
@@ -2269,39 +2227,11 @@ static void drop_buffers(struct dm_bufio_client *c)
 #endif
 
 	for (i = 0; i < LIST_SIZE; i++)
-		WARN_ON(!list_empty(&c->lru[i]));
+		WARN_ON(cache_count(&c->cache, i));
 
 	dm_bufio_unlock(c);
 }
 
-/*
- * We may not be able to evict this buffer if IO pending or the client
- * is still using it.  Caller is expected to know buffer is too old.
- *
- * And if GFP_NOFS is used, we must not do any I/O because we hold
- * dm_bufio_clients_lock and we would risk deadlock if the I/O gets
- * rerouted to different bufio client.
- */
-static bool __try_evict_buffer(struct dm_buffer *b, gfp_t gfp)
-{
-	if (!(gfp & __GFP_FS) ||
-	    (static_branch_unlikely(&no_sleep_enabled) && b->c->no_sleep)) {
-		if (test_bit_acquire(B_READING, &b->state) ||
-		    test_bit(B_WRITING, &b->state) ||
-		    test_bit(B_DIRTY, &b->state))
-			return false;
-	}
-
-	if (b->__hold_count)
-		return false;
-
-	__make_buffer_clean(b);
-	__unlink_buffer(b);
-	__free_buffer_wake(b);
-
-	return true;
-}
-
 static unsigned long get_retain_buffers(struct dm_bufio_client *c)
 {
 	unsigned long retain_bytes = READ_ONCE(dm_bufio_retain_bytes);
@@ -2317,22 +2247,28 @@ static unsigned long get_retain_buffers(struct dm_bufio_client *c)
 static void __scan(struct dm_bufio_client *c)
 {
 	int l;
-	struct dm_buffer *b, *tmp;
+	struct dm_buffer *b;
 	unsigned long freed = 0;
-	unsigned long count = c->n_buffers[LIST_CLEAN] +
-			      c->n_buffers[LIST_DIRTY];
 	unsigned long retain_target = get_retain_buffers(c);
+	unsigned long count = cache_total(&c->cache);
 
 	for (l = 0; l < LIST_SIZE; l++) {
-		list_for_each_entry_safe_reverse(b, tmp, &c->lru[l], lru_list) {
+		while (true) {
 			if (count - freed <= retain_target)
 				atomic_long_set(&c->need_shrink, 0);
 			if (!atomic_long_read(&c->need_shrink))
-				return;
-			if (__try_evict_buffer(b, GFP_KERNEL)) {
-				atomic_long_dec(&c->need_shrink);
-				freed++;
-			}
+				break;
+
+			b = cache_evict(&c->cache, l,
+					l == LIST_CLEAN ? is_clean : is_dirty, c);
+			if (!b)
+				break;
+
+			__make_buffer_clean(b);
+			__free_buffer_wake(b);
+
+			atomic_long_dec(&c->need_shrink);
+			freed++;
 			cond_resched();
 		}
 	}
@@ -2361,8 +2297,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
 static unsigned long dm_bufio_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct dm_bufio_client *c = container_of(shrink, struct dm_bufio_client, shrinker);
-	unsigned long count = READ_ONCE(c->n_buffers[LIST_CLEAN]) +
-			      READ_ONCE(c->n_buffers[LIST_DIRTY]);
+	unsigned long count = cache_total(&c->cache);
 	unsigned long retain_target = get_retain_buffers(c);
 	unsigned long queued_for_cleanup = atomic_long_read(&c->need_shrink);
 
@@ -2390,7 +2325,6 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 {
 	int r;
 	struct dm_bufio_client *c;
-	unsigned int i;
 	char slab_name[27];
 
 	if (!block_size || block_size & ((1 << SECTOR_SHIFT) - 1)) {
@@ -2404,7 +2338,7 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 		r = -ENOMEM;
 		goto bad_client;
 	}
-	c->buffer_tree = RB_ROOT;
+	cache_init(&c->cache);
 
 	c->bdev = bdev;
 	c->block_size = block_size;
@@ -2421,11 +2355,6 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 		static_branch_inc(&no_sleep_enabled);
 	}
 
-	for (i = 0; i < LIST_SIZE; i++) {
-		INIT_LIST_HEAD(&c->lru[i]);
-		c->n_buffers[i] = 0;
-	}
-
 	mutex_init(&c->lock);
 	spin_lock_init(&c->spinlock);
 	INIT_LIST_HEAD(&c->reserved_buffers);
@@ -2497,9 +2426,9 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 
 bad:
 	while (!list_empty(&c->reserved_buffers)) {
-		struct dm_buffer *b = list_entry(c->reserved_buffers.next,
-						 struct dm_buffer, lru_list);
-		list_del(&b->lru_list);
+		struct dm_buffer *b = list_to_buffer(c->reserved_buffers.next);
+
+		list_del(&b->lru.list);
 		free_buffer(b);
 	}
 	kmem_cache_destroy(c->slab_cache);
@@ -2536,23 +2465,23 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 
 	mutex_unlock(&dm_bufio_clients_lock);
 
-	WARN_ON(!RB_EMPTY_ROOT(&c->buffer_tree));
 	WARN_ON(c->need_reserved_buffers);
 
 	while (!list_empty(&c->reserved_buffers)) {
-		struct dm_buffer *b = list_entry(c->reserved_buffers.next,
-						 struct dm_buffer, lru_list);
-		list_del(&b->lru_list);
+		struct dm_buffer *b = list_to_buffer(c->reserved_buffers.next);
+
+		list_del(&b->lru.list);
 		free_buffer(b);
 	}
 
 	for (i = 0; i < LIST_SIZE; i++)
-		if (c->n_buffers[i])
-			DMERR("leaked buffer count %d: %ld", i, c->n_buffers[i]);
+		if (cache_count(&c->cache, i))
+			DMERR("leaked buffer count %d: %lu", i, cache_count(&c->cache, i));
 
 	for (i = 0; i < LIST_SIZE; i++)
-		WARN_ON(c->n_buffers[i]);
+		WARN_ON(cache_count(&c->cache, i));
 
+	cache_destroy(&c->cache);
 	kmem_cache_destroy(c->slab_cache);
 	kmem_cache_destroy(c->slab_buffer);
 	dm_io_client_destroy(c->dm_io);
@@ -2569,6 +2498,8 @@ void dm_bufio_set_sector_offset(struct dm_bufio_client *c, sector_t start)
 }
 EXPORT_SYMBOL_GPL(dm_bufio_set_sector_offset);
 
+/*--------------------------------------------------------------*/
+
 static unsigned int get_max_age_hz(void)
 {
 	unsigned int max_age = READ_ONCE(dm_bufio_max_age);
@@ -2581,13 +2512,74 @@ static unsigned int get_max_age_hz(void)
 
 static bool older_than(struct dm_buffer *b, unsigned long age_hz)
 {
-	return time_after_eq(jiffies, b->last_accessed + age_hz);
+	return time_after_eq(jiffies, READ_ONCE(b->last_accessed) + age_hz);
 }
 
-static void __evict_old_buffers(struct dm_bufio_client *c, unsigned long age_hz)
+struct evict_params {
+	gfp_t gfp;
+	unsigned long age_hz;
+
+	/*
+	 * This gets updated with the largest last_accessed (ie. most
+	 * recently used) of the evicted buffers.  It will not be reinitialised
+	 * by __evict_many(), so you can use it across multiple invocations.
+	 */
+	unsigned long last_accessed;
+};
+
+/*
+ * We may not be able to evict this buffer if IO pending or the client
+ * is still using it.
+ *
+ * And if GFP_NOFS is used, we must not do any I/O because we hold
+ * dm_bufio_clients_lock and we would risk deadlock if the I/O gets
+ * rerouted to different bufio client.
+ */
+static enum evict_result select_for_evict(struct dm_buffer *b, void *context)
+{
+	struct evict_params *params = context;
+
+	if (!(params->gfp & __GFP_FS) ||
+	    (static_branch_unlikely(&no_sleep_enabled) && b->c->no_sleep)) {
+		if (test_bit_acquire(B_READING, &b->state) ||
+		    test_bit(B_WRITING, &b->state) ||
+		    test_bit(B_DIRTY, &b->state))
+			return ER_DONT_EVICT;
+	}
+
+	return older_than(b, params->age_hz) ? ER_EVICT : ER_STOP;
+}
+
+static unsigned long __evict_many(struct dm_bufio_client *c,
+				  struct evict_params *params,
+				  int list_mode, unsigned long max_count)
+{
+	unsigned long count;
+	unsigned long last_accessed;
+	struct dm_buffer *b;
+
+	for (count = 0; count < max_count; count++) {
+		b = cache_evict(&c->cache, list_mode, select_for_evict, params);
+		if (!b)
+			break;
+
+		last_accessed = READ_ONCE(b->last_accessed);
+		if (time_after_eq(params->last_accessed, last_accessed))
+			params->last_accessed = last_accessed;
+
+		__make_buffer_clean(b);
+		__free_buffer_wake(b);
+
+		cond_resched();
+	}
+
+	return count;
+}
+
+static void evict_old_buffers(struct dm_bufio_client *c, unsigned long age_hz)
 {
-	struct dm_buffer *b, *tmp;
-	unsigned long retain_target = get_retain_buffers(c);
+	struct evict_params params = {.gfp = 0, .age_hz = age_hz, .last_accessed = 0};
+	unsigned long retain = get_retain_buffers(c);
 	unsigned long count;
 	LIST_HEAD(write_list);
 
@@ -2600,91 +2592,13 @@ static void __evict_old_buffers(struct dm_bufio_client *c, unsigned long age_hz)
 		dm_bufio_lock(c);
 	}
 
-	count = c->n_buffers[LIST_CLEAN] + c->n_buffers[LIST_DIRTY];
-	list_for_each_entry_safe_reverse(b, tmp, &c->lru[LIST_CLEAN], lru_list) {
-		if (count <= retain_target)
-			break;
-
-		if (!older_than(b, age_hz))
-			break;
-
-		if (__try_evict_buffer(b, 0))
-			count--;
-
-		cond_resched();
-	}
+	count = cache_total(&c->cache);
+	if (count > retain)
+		__evict_many(c, &params, LIST_CLEAN, count - retain);
 
 	dm_bufio_unlock(c);
 }
 
-static void do_global_cleanup(struct work_struct *w)
-{
-	struct dm_bufio_client *locked_client = NULL;
-	struct dm_bufio_client *current_client;
-	struct dm_buffer *b;
-	unsigned int spinlock_hold_count;
-	unsigned long threshold = dm_bufio_cache_size -
-		dm_bufio_cache_size / DM_BUFIO_LOW_WATERMARK_RATIO;
-	unsigned long loops = global_num * 2;
-
-	mutex_lock(&dm_bufio_clients_lock);
-
-	while (1) {
-		cond_resched();
-
-		spin_lock(&global_spinlock);
-		if (unlikely(dm_bufio_current_allocated <= threshold))
-			break;
-
-		spinlock_hold_count = 0;
-get_next:
-		if (!loops--)
-			break;
-		if (unlikely(list_empty(&global_queue)))
-			break;
-		b = list_entry(global_queue.prev, struct dm_buffer, global_list);
-
-		if (b->accessed) {
-			b->accessed = 0;
-			list_move(&b->global_list, &global_queue);
-			if (likely(++spinlock_hold_count < 16))
-				goto get_next;
-			spin_unlock(&global_spinlock);
-			continue;
-		}
-
-		current_client = b->c;
-		if (unlikely(current_client != locked_client)) {
-			if (locked_client)
-				dm_bufio_unlock(locked_client);
-
-			if (!dm_bufio_trylock(current_client)) {
-				spin_unlock(&global_spinlock);
-				dm_bufio_lock(current_client);
-				locked_client = current_client;
-				continue;
-			}
-
-			locked_client = current_client;
-		}
-
-		spin_unlock(&global_spinlock);
-
-		if (unlikely(!__try_evict_buffer(b, GFP_KERNEL))) {
-			spin_lock(&global_spinlock);
-			list_move(&b->global_list, &global_queue);
-			spin_unlock(&global_spinlock);
-		}
-	}
-
-	spin_unlock(&global_spinlock);
-
-	if (locked_client)
-		dm_bufio_unlock(locked_client);
-
-	mutex_unlock(&dm_bufio_clients_lock);
-}
-
 static void cleanup_old_buffers(void)
 {
 	unsigned long max_age_hz = get_max_age_hz();
@@ -2695,7 +2609,7 @@ static void cleanup_old_buffers(void)
 	__cache_size_refresh();
 
 	list_for_each_entry(c, &dm_bufio_all_clients, client_list)
-		__evict_old_buffers(c, max_age_hz);
+		evict_old_buffers(c, max_age_hz);
 
 	mutex_unlock(&dm_bufio_clients_lock);
 }
@@ -2708,6 +2622,107 @@ static void work_fn(struct work_struct *w)
 			   DM_BUFIO_WORK_TIMER_SECS * HZ);
 }
 
+/*--------------------------------------------------------------*/
+
+/*
+ * Global cleanup tries to evict the oldest buffers from across _all_
+ * the clients.  It does this by repeatedly evicting a few buffers from
+ * the client that holds the oldest buffer.  It's approximate, but hopefully
+ * good enough.
+ */
+static struct dm_bufio_client *__pop_client(void)
+{
+	struct list_head *h;
+
+	if (list_empty(&dm_bufio_all_clients))
+		return NULL;
+
+	h = dm_bufio_all_clients.next;
+	list_del(h);
+	return container_of(h, struct dm_bufio_client, client_list);
+}
+
+/*
+ * Inserts the client in the global client list based on its
+ * 'oldest_buffer' field.
+ */
+static void __insert_client(struct dm_bufio_client *new_client)
+{
+	struct dm_bufio_client *c;
+	struct list_head *h = dm_bufio_all_clients.next;
+
+	while (h != &dm_bufio_all_clients) {
+		c = container_of(h, struct dm_bufio_client, client_list);
+		if (time_after_eq(c->oldest_buffer, new_client->oldest_buffer))
+			break;
+		h = h->next;
+	}
+
+	list_add_tail(&new_client->client_list, h);
+}
+
+static unsigned long __evict_a_few(unsigned long nr_buffers)
+{
+	unsigned long count;
+	struct dm_bufio_client *c;
+	struct evict_params params = {
+		.gfp = GFP_KERNEL,
+		.age_hz = 0,
+		/* set to jiffies in case there are no buffers in this client */
+		.last_accessed = jiffies
+	};
+
+	c = __pop_client();
+	if (!c)
+		return 0;
+
+	dm_bufio_lock(c);
+	count = __evict_many(c, &params, LIST_CLEAN, nr_buffers);
+	dm_bufio_unlock(c);
+
+	if (count)
+		c->oldest_buffer = params.last_accessed;
+	__insert_client(c);
+
+	return count;
+}
+
+static void check_watermarks(void)
+{
+	LIST_HEAD(write_list);
+	struct dm_bufio_client *c;
+
+	mutex_lock(&dm_bufio_clients_lock);
+	list_for_each_entry(c, &dm_bufio_all_clients, client_list) {
+		dm_bufio_lock(c);
+		__check_watermark(c, &write_list);
+		dm_bufio_unlock(c);
+	}
+	mutex_unlock(&dm_bufio_clients_lock);
+
+	__flush_write_list(&write_list);
+}
+
+static void evict_old(void)
+{
+	unsigned long threshold = dm_bufio_cache_size -
+		dm_bufio_cache_size / DM_BUFIO_LOW_WATERMARK_RATIO;
+
+	mutex_lock(&dm_bufio_clients_lock);
+	while (dm_bufio_current_allocated > threshold) {
+		if (!__evict_a_few(64))
+			break;
+		cond_resched();
+	}
+	mutex_unlock(&dm_bufio_clients_lock);
+}
+
+static void do_global_cleanup(struct work_struct *w)
+{
+	check_watermarks();
+	evict_old();
+}
+
 /*
  *--------------------------------------------------------------
  * Module setup
-- 
2.40.0

