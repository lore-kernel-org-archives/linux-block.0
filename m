Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbeHJJxL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 05:53:11 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, shhuiw@foxmail.com,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 03/17] bcache: add identifier names to arguments of function definitions
Date: Fri, 10 Aug 2018 15:23:43 +0800
Message-Id: <20180810072357.19823-4-colyli@suse.de>
In-Reply-To: <20180810072357.19823-1-colyli@suse.de>
References: <20180810072357.19823-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There are many function definitions do not have identifier argument names,
scripts/checkpatch.pl complains warnings like this,

 WARNING: function definition argument 'struct bcache_device *' should
  also have an identifier name
  #16735: FILE: writeback.h:120:
  +void bch_sectors_dirty_init(struct bcache_device *);

This patch adds identifier argument names to all bcache function
definitions to fix such warnings.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/bcache.h    | 112 +++++++++++++++---------------
 drivers/md/bcache/bset.h      | 126 +++++++++++++++++++---------------
 drivers/md/bcache/btree.c     |   6 +-
 drivers/md/bcache/btree.h     |  80 ++++++++++-----------
 drivers/md/bcache/debug.h     |   6 +-
 drivers/md/bcache/extents.h   |   6 +-
 drivers/md/bcache/journal.h   |  20 +++---
 drivers/md/bcache/request.c   |   2 +-
 drivers/md/bcache/request.h   |   2 +-
 drivers/md/bcache/stats.h     |  13 ++--
 drivers/md/bcache/util.h      |  12 ++--
 drivers/md/bcache/writeback.h |   9 +--
 12 files changed, 212 insertions(+), 182 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index fd74dd075951..0bd505c61943 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -273,9 +273,10 @@ struct bcache_device {
 
 	unsigned int		data_csum:1;
 
-	int (*cache_miss)(struct btree *, struct search *,
-			  struct bio *, unsigned int);
-	int (*ioctl) (struct bcache_device *, fmode_t, unsigned int, unsigned long);
+	int (*cache_miss)(struct btree *b, struct search *s,
+			  struct bio *bio, unsigned int sectors);
+	int (*ioctl) (struct bcache_device *d, fmode_t mode,
+		      unsigned int cmd, unsigned long arg);
 };
 
 struct io {
@@ -925,41 +926,43 @@ static inline void wait_for_kthread_stop(void)
 /* Forward declarations */
 
 void bch_count_backing_io_errors(struct cached_dev *dc, struct bio *bio);
-void bch_count_io_errors(struct cache *, blk_status_t, int, const char *);
-void bch_bbio_count_io_errors(struct cache_set *, struct bio *,
-			      blk_status_t, const char *);
-void bch_bbio_endio(struct cache_set *, struct bio *, blk_status_t,
-		const char *);
-void bch_bbio_free(struct bio *, struct cache_set *);
-struct bio *bch_bbio_alloc(struct cache_set *);
-
-void __bch_submit_bbio(struct bio *, struct cache_set *);
-void bch_submit_bbio(struct bio *, struct cache_set *,
-		     struct bkey *, unsigned int);
-
-uint8_t bch_inc_gen(struct cache *, struct bucket *);
-void bch_rescale_priorities(struct cache_set *, int);
-
-bool bch_can_invalidate_bucket(struct cache *, struct bucket *);
-void __bch_invalidate_one_bucket(struct cache *, struct bucket *);
-
-void __bch_bucket_free(struct cache *, struct bucket *);
-void bch_bucket_free(struct cache_set *, struct bkey *);
-
-long bch_bucket_alloc(struct cache *, unsigned int, bool);
-int __bch_bucket_alloc_set(struct cache_set *, unsigned int,
-			   struct bkey *, int, bool);
-int bch_bucket_alloc_set(struct cache_set *, unsigned int,
-			 struct bkey *, int, bool);
-bool bch_alloc_sectors(struct cache_set *, struct bkey *, unsigned int,
-		       unsigned int, unsigned int, bool);
+void bch_count_io_errors(struct cache *ca, blk_status_t error,
+			 int is_read, const char *m);
+void bch_bbio_count_io_errors(struct cache_set *c, struct bio *bio,
+			      blk_status_t error, const char *m);
+void bch_bbio_endio(struct cache_set *c, struct bio *bio,
+		    blk_status_t error, const char *m);
+void bch_bbio_free(struct bio *bio, struct cache_set *c);
+struct bio *bch_bbio_alloc(struct cache_set *c);
+
+void __bch_submit_bbio(struct bio *bio, struct cache_set *c);
+void bch_submit_bbio(struct bio *bio, struct cache_set *c,
+		     struct bkey *k, unsigned int ptr);
+
+uint8_t bch_inc_gen(struct cache *ca, struct bucket *b);
+void bch_rescale_priorities(struct cache_set *c, int sectors);
+
+bool bch_can_invalidate_bucket(struct cache *ca, struct bucket *b);
+void __bch_invalidate_one_bucket(struct cache *ca, struct bucket *b);
+
+void __bch_bucket_free(struct cache *ca, struct bucket *b);
+void bch_bucket_free(struct cache_set *c, struct bkey *k);
+
+long bch_bucket_alloc(struct cache *ca, unsigned int reserve, bool wait);
+int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
+			   struct bkey *k, int n, bool wait);
+int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
+			 struct bkey *k, int n, bool wait);
+bool bch_alloc_sectors(struct cache_set *c, struct bkey *k,
+		       unsigned int sectors, unsigned int write_point,
+		       unsigned int write_prio, bool wait);
 bool bch_cached_dev_error(struct cached_dev *dc);
 
 __printf(2, 3)
-bool bch_cache_set_error(struct cache_set *, const char *, ...);
+bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...);
 
-void bch_prio_write(struct cache *);
-void bch_write_bdev_super(struct cached_dev *, struct closure *);
+void bch_prio_write(struct cache *ca);
+void bch_write_bdev_super(struct cached_dev *dc, struct closure *parent);
 
 extern struct workqueue_struct *bcache_wq;
 extern struct mutex bch_register_lock;
@@ -971,30 +974,31 @@ extern struct kobj_type bch_cache_set_ktype;
 extern struct kobj_type bch_cache_set_internal_ktype;
 extern struct kobj_type bch_cache_ktype;
 
-void bch_cached_dev_release(struct kobject *);
-void bch_flash_dev_release(struct kobject *);
-void bch_cache_set_release(struct kobject *);
-void bch_cache_release(struct kobject *);
+void bch_cached_dev_release(struct kobject *kobj);
+void bch_flash_dev_release(struct kobject *kobj);
+void bch_cache_set_release(struct kobject *kobj);
+void bch_cache_release(struct kobject *kobj);
 
-int bch_uuid_write(struct cache_set *);
-void bcache_write_super(struct cache_set *);
+int bch_uuid_write(struct cache_set *c);
+void bcache_write_super(struct cache_set *c);
 
 int bch_flash_dev_create(struct cache_set *c, uint64_t size);
 
-int bch_cached_dev_attach(struct cached_dev *, struct cache_set *, uint8_t *);
-void bch_cached_dev_detach(struct cached_dev *);
-void bch_cached_dev_run(struct cached_dev *);
-void bcache_device_stop(struct bcache_device *);
-
-void bch_cache_set_unregister(struct cache_set *);
-void bch_cache_set_stop(struct cache_set *);
-
-struct cache_set *bch_cache_set_alloc(struct cache_sb *);
-void bch_btree_cache_free(struct cache_set *);
-int bch_btree_cache_alloc(struct cache_set *);
-void bch_moving_init_cache_set(struct cache_set *);
-int bch_open_buckets_alloc(struct cache_set *);
-void bch_open_buckets_free(struct cache_set *);
+int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
+			  uint8_t *set_uuid);
+void bch_cached_dev_detach(struct cached_dev *dc);
+void bch_cached_dev_run(struct cached_dev *dc);
+void bcache_device_stop(struct bcache_device *d);
+
+void bch_cache_set_unregister(struct cache_set *c);
+void bch_cache_set_stop(struct cache_set *c);
+
+struct cache_set *bch_cache_set_alloc(struct cache_sb *sb);
+void bch_btree_cache_free(struct cache_set *c);
+int bch_btree_cache_alloc(struct cache_set *c);
+void bch_moving_init_cache_set(struct cache_set *c);
+int bch_open_buckets_alloc(struct cache_set *c);
+void bch_open_buckets_free(struct cache_set *c);
 
 int bch_cache_allocator_start(struct cache *ca);
 
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index fdc296103113..f5bf333aa40d 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -187,18 +187,25 @@ struct bset_tree {
 };
 
 struct btree_keys_ops {
-	bool		(*sort_cmp)(struct btree_iter_set,
-				    struct btree_iter_set);
-	struct bkey	*(*sort_fixup)(struct btree_iter *, struct bkey *);
-	bool		(*insert_fixup)(struct btree_keys *, struct bkey *,
-					struct btree_iter *, struct bkey *);
-	bool		(*key_invalid)(struct btree_keys *,
-				       const struct bkey *);
-	bool		(*key_bad)(struct btree_keys *, const struct bkey *);
-	bool		(*key_merge)(struct btree_keys *,
-				     struct bkey *, struct bkey *);
-	void		(*key_to_text)(char *, size_t, const struct bkey *);
-	void		(*key_dump)(struct btree_keys *, const struct bkey *);
+	bool		(*sort_cmp)(struct btree_iter_set l,
+				    struct btree_iter_set r);
+	struct bkey	*(*sort_fixup)(struct btree_iter *iter,
+				       struct bkey *tmp);
+	bool		(*insert_fixup)(struct btree_keys *b,
+					struct bkey *insert,
+					struct btree_iter *iter,
+					struct bkey *replace_key);
+	bool		(*key_invalid)(struct btree_keys *bk,
+				       const struct bkey *k);
+	bool		(*key_bad)(struct btree_keys *bk,
+				   const struct bkey *k);
+	bool		(*key_merge)(struct btree_keys *bk,
+				     struct bkey *l, struct bkey *r);
+	void		(*key_to_text)(char *buf,
+				       size_t size,
+				       const struct bkey *k);
+	void		(*key_dump)(struct btree_keys *keys,
+				    const struct bkey *k);
 
 	/*
 	 * Only used for deciding whether to use START_KEY(k) or just the key
@@ -280,18 +287,20 @@ static inline struct bset *bset_next_set(struct btree_keys *b,
 	return ((void *) i) + roundup(set_bytes(i), block_bytes);
 }
 
-void bch_btree_keys_free(struct btree_keys *);
-int bch_btree_keys_alloc(struct btree_keys *, unsigned int, gfp_t);
-void bch_btree_keys_init(struct btree_keys *, const struct btree_keys_ops *,
-			 bool *);
-
-void bch_bset_init_next(struct btree_keys *, struct bset *, uint64_t);
-void bch_bset_build_written_tree(struct btree_keys *);
-void bch_bset_fix_invalidated_key(struct btree_keys *, struct bkey *);
-bool bch_bkey_try_merge(struct btree_keys *, struct bkey *, struct bkey *);
-void bch_bset_insert(struct btree_keys *, struct bkey *, struct bkey *);
-unsigned int bch_btree_insert_key(struct btree_keys *, struct bkey *,
-			      struct bkey *);
+void bch_btree_keys_free(struct btree_keys *b);
+int bch_btree_keys_alloc(struct btree_keys *b, unsigned int page_order,
+			 gfp_t gfp);
+void bch_btree_keys_init(struct btree_keys *b, const struct btree_keys_ops *ops,
+			 bool *expensive_debug_checks);
+
+void bch_bset_init_next(struct btree_keys *b, struct bset *i, uint64_t magic);
+void bch_bset_build_written_tree(struct btree_keys *b);
+void bch_bset_fix_invalidated_key(struct btree_keys *b, struct bkey *k);
+bool bch_bkey_try_merge(struct btree_keys *b, struct bkey *l, struct bkey *r);
+void bch_bset_insert(struct btree_keys *b, struct bkey *where,
+		     struct bkey *insert);
+unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
+			      struct bkey *replace_key);
 
 enum {
 	BTREE_INSERT_STATUS_NO_INSERT = 0,
@@ -313,18 +322,21 @@ struct btree_iter {
 	} data[MAX_BSETS];
 };
 
-typedef bool (*ptr_filter_fn)(struct btree_keys *, const struct bkey *);
+typedef bool (*ptr_filter_fn)(struct btree_keys *b, const struct bkey *k);
 
-struct bkey *bch_btree_iter_next(struct btree_iter *);
-struct bkey *bch_btree_iter_next_filter(struct btree_iter *,
-					struct btree_keys *, ptr_filter_fn);
+struct bkey *bch_btree_iter_next(struct btree_iter *iter);
+struct bkey *bch_btree_iter_next_filter(struct btree_iter *iter,
+					struct btree_keys *b,
+					ptr_filter_fn fn);
 
-void bch_btree_iter_push(struct btree_iter *, struct bkey *, struct bkey *);
-struct bkey *bch_btree_iter_init(struct btree_keys *, struct btree_iter *,
-				 struct bkey *);
+void bch_btree_iter_push(struct btree_iter *iter, struct bkey *k,
+			 struct bkey *end);
+struct bkey *bch_btree_iter_init(struct btree_keys *b,
+				 struct btree_iter *iter,
+				 struct bkey *search);
 
-struct bkey *__bch_bset_search(struct btree_keys *, struct bset_tree *,
-			       const struct bkey *);
+struct bkey *__bch_bset_search(struct btree_keys *b, struct bset_tree *t,
+			       const struct bkey *search);
 
 /*
  * Returns the first key that is strictly greater than search
@@ -355,15 +367,17 @@ struct bset_sort_state {
 	struct time_stats	time;
 };
 
-void bch_bset_sort_state_free(struct bset_sort_state *);
-int bch_bset_sort_state_init(struct bset_sort_state *, unsigned int);
-void bch_btree_sort_lazy(struct btree_keys *, struct bset_sort_state *);
-void bch_btree_sort_into(struct btree_keys *, struct btree_keys *,
-			 struct bset_sort_state *);
-void bch_btree_sort_and_fix_extents(struct btree_keys *, struct btree_iter *,
-				    struct bset_sort_state *);
-void bch_btree_sort_partial(struct btree_keys *, unsigned int,
-			    struct bset_sort_state *);
+void bch_bset_sort_state_free(struct bset_sort_state *state);
+int bch_bset_sort_state_init(struct bset_sort_state *state,
+			     unsigned int page_order);
+void bch_btree_sort_lazy(struct btree_keys *b, struct bset_sort_state *state);
+void bch_btree_sort_into(struct btree_keys *b, struct btree_keys *new,
+			 struct bset_sort_state *state);
+void bch_btree_sort_and_fix_extents(struct btree_keys *b,
+				    struct btree_iter *iter,
+				    struct bset_sort_state *state);
+void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
+			    struct bset_sort_state *state);
 
 static inline void bch_btree_sort(struct btree_keys *b,
 				  struct bset_sort_state *state)
@@ -377,7 +391,7 @@ struct bset_stats {
 	size_t floats, failed;
 };
 
-void bch_btree_keys_stats(struct btree_keys *, struct bset_stats *);
+void bch_btree_keys_stats(struct btree_keys *b, struct bset_stats *state);
 
 /* Bkey utility code */
 
@@ -401,10 +415,10 @@ static __always_inline int64_t bkey_cmp(const struct bkey *l,
 		: (int64_t) KEY_OFFSET(l) - (int64_t) KEY_OFFSET(r);
 }
 
-void bch_bkey_copy_single_ptr(struct bkey *, const struct bkey *,
-			      unsigned int);
-bool __bch_cut_front(const struct bkey *, struct bkey *);
-bool __bch_cut_back(const struct bkey *, struct bkey *);
+void bch_bkey_copy_single_ptr(struct bkey *dest, const struct bkey *src,
+			      unsigned int i);
+bool __bch_cut_front(const struct bkey *where, struct bkey *k);
+bool __bch_cut_back(const struct bkey *where, struct bkey *k);
 
 static inline bool bch_cut_front(const struct bkey *where, struct bkey *k)
 {
@@ -522,18 +536,20 @@ static inline size_t bch_keylist_bytes(struct keylist *l)
 	return bch_keylist_nkeys(l) * sizeof(uint64_t);
 }
 
-struct bkey *bch_keylist_pop(struct keylist *);
-void bch_keylist_pop_front(struct keylist *);
-int __bch_keylist_realloc(struct keylist *, unsigned int);
+struct bkey *bch_keylist_pop(struct keylist *l);
+void bch_keylist_pop_front(struct keylist *l);
+int __bch_keylist_realloc(struct keylist *l, unsigned int u64s);
 
 /* Debug stuff */
 
 #ifdef CONFIG_BCACHE_DEBUG
 
-int __bch_count_data(struct btree_keys *);
-void __printf(2, 3) __bch_check_keys(struct btree_keys *, const char *, ...);
-void bch_dump_bset(struct btree_keys *, struct bset *, unsigned int);
-void bch_dump_bucket(struct btree_keys *);
+int __bch_count_data(struct btree_keys *b);
+void __printf(2, 3) __bch_check_keys(struct btree_keys *b,
+				     const char *fmt,
+				     ...);
+void bch_dump_bset(struct btree_keys *b, struct bset *i, unsigned int set);
+void bch_dump_bucket(struct btree_keys *b);
 
 #else
 
@@ -541,7 +557,7 @@ static inline int __bch_count_data(struct btree_keys *b) { return -1; }
 static inline void __printf(2, 3)
 	__bch_check_keys(struct btree_keys *b, const char *fmt, ...) {}
 static inline void bch_dump_bucket(struct btree_keys *b) {}
-void bch_dump_bset(struct btree_keys *, struct bset *, unsigned int);
+void bch_dump_bset(struct btree_keys *b, struct bset *i, unsigned int set);
 
 #endif
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 4003f92f4d2c..a797ef359a21 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1309,8 +1309,10 @@ struct gc_merge_info {
 	unsigned int	keys;
 };
 
-static int bch_btree_insert_node(struct btree *, struct btree_op *,
-				 struct keylist *, atomic_t *, struct bkey *);
+static int bch_btree_insert_node(struct btree *b, struct btree_op *op,
+				 struct keylist *insert_keys,
+				 atomic_t *journal_ref,
+				 struct bkey *replace_key);
 
 static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 			     struct gc_stat *gc, struct gc_merge_info *r)
diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index 8cbc0fd27738..f13b71a0613a 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -238,26 +238,28 @@ static inline void rw_unlock(bool w, struct btree *b)
 	(w ? up_write : up_read)(&b->lock);
 }
 
-void bch_btree_node_read_done(struct btree *);
-void __bch_btree_node_write(struct btree *, struct closure *);
-void bch_btree_node_write(struct btree *, struct closure *);
-
-void bch_btree_set_root(struct btree *);
-struct btree *__bch_btree_node_alloc(struct cache_set *, struct btree_op *,
-				     int, bool, struct btree *);
-struct btree *bch_btree_node_get(struct cache_set *, struct btree_op *,
-				 struct bkey *, int, bool, struct btree *);
-
-int bch_btree_insert_check_key(struct btree *, struct btree_op *,
-			       struct bkey *);
-int bch_btree_insert(struct cache_set *, struct keylist *,
-		     atomic_t *, struct bkey *);
-
-int bch_gc_thread_start(struct cache_set *);
-void bch_initial_gc_finish(struct cache_set *);
-void bch_moving_gc(struct cache_set *);
-int bch_btree_check(struct cache_set *);
-void bch_initial_mark_key(struct cache_set *, int, struct bkey *);
+void bch_btree_node_read_done(struct btree *b);
+void __bch_btree_node_write(struct btree *b, struct closure *parent);
+void bch_btree_node_write(struct btree *b, struct closure *parent);
+
+void bch_btree_set_root(struct btree *b);
+struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
+				     int level, bool wait,
+				     struct btree *parent);
+struct btree *bch_btree_node_get(struct cache_set *c, struct btree_op *op,
+				 struct bkey *k, int level, bool write,
+				 struct btree *parent);
+
+int bch_btree_insert_check_key(struct btree *b, struct btree_op *op,
+			       struct bkey *check_key);
+int bch_btree_insert(struct cache_set *c, struct keylist *keys,
+		     atomic_t *journal_ref, struct bkey *replace_key);
+
+int bch_gc_thread_start(struct cache_set *c);
+void bch_initial_gc_finish(struct cache_set *c);
+void bch_moving_gc(struct cache_set *c);
+int bch_btree_check(struct cache_set *c);
+void bch_initial_mark_key(struct cache_set *c, int level, struct bkey *k);
 
 static inline void wake_up_gc(struct cache_set *c)
 {
@@ -272,9 +274,9 @@ static inline void wake_up_gc(struct cache_set *c)
 
 #define MAP_END_KEY	1
 
-typedef int (btree_map_nodes_fn)(struct btree_op *, struct btree *);
-int __bch_btree_map_nodes(struct btree_op *, struct cache_set *,
-			  struct bkey *, btree_map_nodes_fn *, int);
+typedef int (btree_map_nodes_fn)(struct btree_op *b_op, struct btree *b);
+int __bch_btree_map_nodes(struct btree_op *op, struct cache_set *c,
+			  struct bkey *from, btree_map_nodes_fn *fn, int flags);
 
 static inline int bch_btree_map_nodes(struct btree_op *op, struct cache_set *c,
 				      struct bkey *from, btree_map_nodes_fn *fn)
@@ -290,21 +292,21 @@ static inline int bch_btree_map_leaf_nodes(struct btree_op *op,
 	return __bch_btree_map_nodes(op, c, from, fn, MAP_LEAF_NODES);
 }
 
-typedef int (btree_map_keys_fn)(struct btree_op *, struct btree *,
-				struct bkey *);
-int bch_btree_map_keys(struct btree_op *, struct cache_set *,
-		       struct bkey *, btree_map_keys_fn *, int);
-
-typedef bool (keybuf_pred_fn)(struct keybuf *, struct bkey *);
-
-void bch_keybuf_init(struct keybuf *);
-void bch_refill_keybuf(struct cache_set *, struct keybuf *,
-		       struct bkey *, keybuf_pred_fn *);
-bool bch_keybuf_check_overlapping(struct keybuf *, struct bkey *,
-				  struct bkey *);
-void bch_keybuf_del(struct keybuf *, struct keybuf_key *);
-struct keybuf_key *bch_keybuf_next(struct keybuf *);
-struct keybuf_key *bch_keybuf_next_rescan(struct cache_set *, struct keybuf *,
-					  struct bkey *, keybuf_pred_fn *);
+typedef int (btree_map_keys_fn)(struct btree_op *op, struct btree *b,
+				struct bkey *k);
+int bch_btree_map_keys(struct btree_op *op, struct cache_set *c,
+		       struct bkey *from, btree_map_keys_fn *fn, int flags);
+
+typedef bool (keybuf_pred_fn)(struct keybuf *buf, struct bkey *k);
+
+void bch_keybuf_init(struct keybuf *buf);
+void bch_refill_keybuf(struct cache_set *c, struct keybuf *buf,
+		       struct bkey *end, keybuf_pred_fn *pred);
+bool bch_keybuf_check_overlapping(struct keybuf *buf, struct bkey *start,
+				  struct bkey *end);
+void bch_keybuf_del(struct keybuf *buf, struct keybuf_key *w);
+struct keybuf_key *bch_keybuf_next(struct keybuf *buf);
+struct keybuf_key *bch_keybuf_next_rescan(struct cache_set *c, struct keybuf *buf,
+					  struct bkey *end, keybuf_pred_fn *pred);
 void bch_update_bucket_in_use(struct cache_set *c, struct gc_stat *stats);
 #endif
diff --git a/drivers/md/bcache/debug.h b/drivers/md/bcache/debug.h
index acc48d3fa274..fb3d4dff4b26 100644
--- a/drivers/md/bcache/debug.h
+++ b/drivers/md/bcache/debug.h
@@ -8,8 +8,8 @@ struct cache_set;
 
 #ifdef CONFIG_BCACHE_DEBUG
 
-void bch_btree_verify(struct btree *);
-void bch_data_verify(struct cached_dev *, struct bio *);
+void bch_btree_verify(struct btree *b);
+void bch_data_verify(struct cached_dev *dc, struct bio *bio);
 
 #define expensive_debug_checks(c)	((c)->expensive_debug_checks)
 #define key_merging_disabled(c)		((c)->key_merging_disabled)
@@ -27,7 +27,7 @@ static inline void bch_data_verify(struct cached_dev *dc, struct bio *bio) {}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-void bch_debug_init_cache_set(struct cache_set *);
+void bch_debug_init_cache_set(struct cache_set *c);
 #else
 static inline void bch_debug_init_cache_set(struct cache_set *c) {}
 #endif
diff --git a/drivers/md/bcache/extents.h b/drivers/md/bcache/extents.h
index 0cd3575afa1d..4d667e05bb73 100644
--- a/drivers/md/bcache/extents.h
+++ b/drivers/md/bcache/extents.h
@@ -8,8 +8,8 @@ extern const struct btree_keys_ops bch_extent_keys_ops;
 struct bkey;
 struct cache_set;
 
-void bch_extent_to_text(char *, size_t, const struct bkey *);
-bool __bch_btree_ptr_invalid(struct cache_set *, const struct bkey *);
-bool __bch_extent_invalid(struct cache_set *, const struct bkey *);
+void bch_extent_to_text(char *buf, size_t size, const struct bkey *k);
+bool __bch_btree_ptr_invalid(struct cache_set *c, const struct bkey *k);
+bool __bch_extent_invalid(struct cache_set *c, const struct bkey *k);
 
 #endif /* _BCACHE_EXTENTS_H */
diff --git a/drivers/md/bcache/journal.h b/drivers/md/bcache/journal.h
index f0982731ae20..66f0facff84b 100644
--- a/drivers/md/bcache/journal.h
+++ b/drivers/md/bcache/journal.h
@@ -167,14 +167,16 @@ struct cache_set;
 struct btree_op;
 struct keylist;
 
-atomic_t *bch_journal(struct cache_set *, struct keylist *, struct closure *);
-void bch_journal_next(struct journal *);
-void bch_journal_mark(struct cache_set *, struct list_head *);
-void bch_journal_meta(struct cache_set *, struct closure *);
-int bch_journal_read(struct cache_set *, struct list_head *);
-int bch_journal_replay(struct cache_set *, struct list_head *);
-
-void bch_journal_free(struct cache_set *);
-int bch_journal_alloc(struct cache_set *);
+atomic_t *bch_journal(struct cache_set *c,
+		      struct keylist *keys,
+		      struct closure *parent);
+void bch_journal_next(struct journal *j);
+void bch_journal_mark(struct cache_set *c, struct list_head *list);
+void bch_journal_meta(struct cache_set *c, struct closure *cl);
+int bch_journal_read(struct cache_set *c, struct list_head *list);
+int bch_journal_replay(struct cache_set *c, struct list_head *list);
+
+void bch_journal_free(struct cache_set *c);
+int bch_journal_alloc(struct cache_set *c);
 
 #endif /* _BCACHE_JOURNAL_H */
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index d15d8c5778ed..d7e6ee3d7dd2 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -25,7 +25,7 @@
 
 struct kmem_cache *bch_search_cache;
 
-static void bch_data_insert_start(struct closure *);
+static void bch_data_insert_start(struct closure *cl);
 
 static unsigned int cache_mode(struct cached_dev *dc)
 {
diff --git a/drivers/md/bcache/request.h b/drivers/md/bcache/request.h
index 8e8c1ce00d9d..aa055cfeb099 100644
--- a/drivers/md/bcache/request.h
+++ b/drivers/md/bcache/request.h
@@ -33,7 +33,7 @@ struct data_insert_op {
 	BKEY_PADDED(replace_key);
 };
 
-unsigned int bch_get_congested(struct cache_set *);
+unsigned int bch_get_congested(struct cache_set *c);
 void bch_data_insert(struct closure *cl);
 
 void bch_cached_dev_request_init(struct cached_dev *dc);
diff --git a/drivers/md/bcache/stats.h b/drivers/md/bcache/stats.h
index 77234a89dd69..abfaabf7e7fc 100644
--- a/drivers/md/bcache/stats.h
+++ b/drivers/md/bcache/stats.h
@@ -53,10 +53,13 @@ void bch_cache_accounting_clear(struct cache_accounting *acc);
 
 void bch_cache_accounting_destroy(struct cache_accounting *acc);
 
-void bch_mark_cache_accounting(struct cache_set *, struct bcache_device *,
-			       bool, bool);
-void bch_mark_cache_readahead(struct cache_set *, struct bcache_device *);
-void bch_mark_cache_miss_collision(struct cache_set *, struct bcache_device *);
-void bch_mark_sectors_bypassed(struct cache_set *, struct cached_dev *, int);
+void bch_mark_cache_accounting(struct cache_set *c, struct bcache_device *d,
+			       bool hit, bool bypass);
+void bch_mark_cache_readahead(struct cache_set *c, struct bcache_device *d);
+void bch_mark_cache_miss_collision(struct cache_set *c,
+				   struct bcache_device *d);
+void bch_mark_sectors_bypassed(struct cache_set *c,
+			       struct cached_dev *dc,
+			       int sectors);
 
 #endif /* _BCACHE_STATS_H_ */
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index 484044231f21..707d7f0c034e 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -288,10 +288,10 @@ do {									\
 #define ANYSINT_MAX(t)							\
 	((((t) 1 << (sizeof(t) * 8 - 2)) - (t) 1) * (t) 2 + (t) 1)
 
-int bch_strtoint_h(const char *, int *);
-int bch_strtouint_h(const char *, unsigned int *);
-int bch_strtoll_h(const char *, long long *);
-int bch_strtoull_h(const char *, unsigned long long *);
+int bch_strtoint_h(const char *cp, int *res);
+int bch_strtouint_h(const char *cp, unsigned int *res);
+int bch_strtoll_h(const char *cp, long long *res);
+int bch_strtoull_h(const char *cp, unsigned long long *res);
 
 static inline int bch_strtol_h(const char *cp, long *res)
 {
@@ -563,7 +563,7 @@ static inline sector_t bdev_sectors(struct block_device *bdev)
 	return bdev->bd_inode->i_size >> 9;
 }
 
-uint64_t bch_crc64_update(uint64_t, const void *, size_t);
-uint64_t bch_crc64(const void *, size_t);
+uint64_t bch_crc64_update(uint64_t crc, const void *_data, size_t len);
+uint64_t bch_crc64(const void *data, size_t len);
 
 #endif /* _BCACHE_UTIL_H */
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index 76b691850c98..d2b9fdbc8994 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -96,10 +96,11 @@ static inline void bch_writeback_add(struct cached_dev *dc)
 	}
 }
 
-void bcache_dev_sectors_dirty_add(struct cache_set *, unsigned int, uint64_t, int);
+void bcache_dev_sectors_dirty_add(struct cache_set *c, unsigned int inode,
+				  uint64_t offset, int nr_sectors);
 
-void bch_sectors_dirty_init(struct bcache_device *);
-void bch_cached_dev_writeback_init(struct cached_dev *);
-int bch_cached_dev_writeback_start(struct cached_dev *);
+void bch_sectors_dirty_init(struct bcache_device *d);
+void bch_cached_dev_writeback_init(struct cached_dev *dc);
+int bch_cached_dev_writeback_start(struct cached_dev *dc);
 
 #endif
-- 
2.18.0
