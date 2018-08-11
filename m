Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v3 01/17] bcache: style fix to replace 'unsigned' by 'unsigned int'
Date: Sat, 11 Aug 2018 13:19:44 +0800
Message-Id: <20180811052000.103680-2-colyli@suse.de>
In-Reply-To: <20180811052000.103680-1-colyli@suse.de>
References: <20180811052000.103680-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

This patch fixes warning reported by checkpatch.pl by replacing 'unsigned'
with 'unsigned int'.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/alloc.c     |  36 ++++++-----
 drivers/md/bcache/bcache.h    | 107 +++++++++++++++----------------
 drivers/md/bcache/bset.c      | 114 ++++++++++++++++++----------------
 drivers/md/bcache/bset.h      |  34 +++++-----
 drivers/md/bcache/btree.c     |  50 +++++++--------
 drivers/md/bcache/btree.h     |   4 +-
 drivers/md/bcache/closure.h   |   2 +-
 drivers/md/bcache/debug.c     |   6 +-
 drivers/md/bcache/extents.c   |  22 +++----
 drivers/md/bcache/io.c        |  18 +++---
 drivers/md/bcache/journal.c   |  20 +++---
 drivers/md/bcache/journal.h   |   8 +--
 drivers/md/bcache/movinggc.c  |  12 ++--
 drivers/md/bcache/request.c   |  42 ++++++-------
 drivers/md/bcache/request.h   |  18 +++---
 drivers/md/bcache/stats.c     |  12 ++--
 drivers/md/bcache/stats.h     |   2 +-
 drivers/md/bcache/super.c     |  34 +++++-----
 drivers/md/bcache/sysfs.c     |  18 +++---
 drivers/md/bcache/util.h      |   9 +--
 drivers/md/bcache/writeback.c |  19 +++---
 drivers/md/bcache/writeback.h |  12 ++--
 include/uapi/linux/bcache.h   |   6 +-
 23 files changed, 309 insertions(+), 296 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 7fa2631b422c..89f663d22551 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -87,8 +87,8 @@ void bch_rescale_priorities(struct cache_set *c, int sectors)
 {
 	struct cache *ca;
 	struct bucket *b;
-	unsigned next = c->nbuckets * c->sb.bucket_size / 1024;
-	unsigned i;
+	unsigned int next = c->nbuckets * c->sb.bucket_size / 1024;
+	unsigned int i;
 	int r;
 
 	atomic_sub(sectors, &c->rescale);
@@ -169,7 +169,7 @@ static void bch_invalidate_one_bucket(struct cache *ca, struct bucket *b)
 
 #define bucket_prio(b)							\
 ({									\
-	unsigned min_prio = (INITIAL_PRIO - ca->set->min_prio) / 8;	\
+	unsigned int min_prio = (INITIAL_PRIO - ca->set->min_prio) / 8;	\
 									\
 	(b->prio - ca->set->min_prio + min_prio) * GC_SECTORS_USED(b);	\
 })
@@ -301,7 +301,7 @@ do {									\
 
 static int bch_allocator_push(struct cache *ca, long bucket)
 {
-	unsigned i;
+	unsigned int i;
 
 	/* Prios/gens are actually the most important reserve */
 	if (fifo_push(&ca->free[RESERVE_PRIO], bucket))
@@ -385,7 +385,7 @@ static int bch_allocator_thread(void *arg)
 
 /* Allocation */
 
-long bch_bucket_alloc(struct cache *ca, unsigned reserve, bool wait)
+long bch_bucket_alloc(struct cache *ca, unsigned int reserve, bool wait)
 {
 	DEFINE_WAIT(w);
 	struct bucket *b;
@@ -421,7 +421,7 @@ long bch_bucket_alloc(struct cache *ca, unsigned reserve, bool wait)
 	if (expensive_debug_checks(ca->set)) {
 		size_t iter;
 		long i;
-		unsigned j;
+		unsigned int j;
 
 		for (iter = 0; iter < prio_buckets(ca) * 2; iter++)
 			BUG_ON(ca->prio_buckets[iter] == (uint64_t) r);
@@ -470,14 +470,14 @@ void __bch_bucket_free(struct cache *ca, struct bucket *b)
 
 void bch_bucket_free(struct cache_set *c, struct bkey *k)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		__bch_bucket_free(PTR_CACHE(c, k, i),
 				  PTR_BUCKET(c, k, i));
 }
 
-int __bch_bucket_alloc_set(struct cache_set *c, unsigned reserve,
+int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 			   struct bkey *k, int n, bool wait)
 {
 	int i;
@@ -510,7 +510,7 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned reserve,
 	return -1;
 }
 
-int bch_bucket_alloc_set(struct cache_set *c, unsigned reserve,
+int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 			 struct bkey *k, int n, bool wait)
 {
 	int ret;
@@ -524,8 +524,8 @@ int bch_bucket_alloc_set(struct cache_set *c, unsigned reserve,
 
 struct open_bucket {
 	struct list_head	list;
-	unsigned		last_write_point;
-	unsigned		sectors_free;
+	unsigned int		last_write_point;
+	unsigned int		sectors_free;
 	BKEY_PADDED(key);
 };
 
@@ -556,7 +556,7 @@ struct open_bucket {
  */
 static struct open_bucket *pick_data_bucket(struct cache_set *c,
 					    const struct bkey *search,
-					    unsigned write_point,
+					    unsigned int write_point,
 					    struct bkey *alloc)
 {
 	struct open_bucket *ret, *ret_task = NULL;
@@ -595,12 +595,16 @@ static struct open_bucket *pick_data_bucket(struct cache_set *c,
  *
  * If s->writeback is true, will not fail.
  */
-bool bch_alloc_sectors(struct cache_set *c, struct bkey *k, unsigned sectors,
-		       unsigned write_point, unsigned write_prio, bool wait)
+bool bch_alloc_sectors(struct cache_set *c,
+		       struct bkey *k,
+		       unsigned int sectors,
+		       unsigned int write_point,
+		       unsigned int write_prio,
+		       bool wait)
 {
 	struct open_bucket *b;
 	BKEY_PADDED(key) alloc;
-	unsigned i;
+	unsigned int i;
 
 	/*
 	 * We might have to allocate a new bucket, which we can't do with a
@@ -613,7 +617,7 @@ bool bch_alloc_sectors(struct cache_set *c, struct bkey *k, unsigned sectors,
 	spin_lock(&c->data_bucket_lock);
 
 	while (!(b = pick_data_bucket(c, k, write_point, &alloc.key))) {
-		unsigned watermark = write_prio
+		unsigned int watermark = write_prio
 			? RESERVE_MOVINGGC
 			: RESERVE_NONE;
 
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 05f82ff6f016..1ebd2d9d90d5 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -252,7 +252,7 @@ struct bcache_device {
 	struct kobject		kobj;
 
 	struct cache_set	*c;
-	unsigned		id;
+	unsigned int		id;
 #define BCACHEDEVNAME_SIZE	12
 	char			name[BCACHEDEVNAME_SIZE];
 
@@ -264,18 +264,18 @@ struct bcache_device {
 #define BCACHE_DEV_UNLINK_DONE		2
 #define BCACHE_DEV_WB_RUNNING		3
 #define BCACHE_DEV_RATE_DW_RUNNING	4
-	unsigned		nr_stripes;
-	unsigned		stripe_size;
+	unsigned int		nr_stripes;
+	unsigned int		stripe_size;
 	atomic_t		*stripe_sectors_dirty;
 	unsigned long		*full_dirty_stripes;
 
 	struct bio_set		bio_split;
 
-	unsigned		data_csum:1;
+	unsigned int		data_csum:1;
 
 	int (*cache_miss)(struct btree *, struct search *,
-			  struct bio *, unsigned);
-	int (*ioctl) (struct bcache_device *, fmode_t, unsigned, unsigned long);
+			  struct bio *, unsigned int);
+	int (*ioctl) (struct bcache_device *, fmode_t, unsigned int, unsigned long);
 };
 
 struct io {
@@ -284,7 +284,7 @@ struct io {
 	struct list_head	lru;
 
 	unsigned long		jiffies;
-	unsigned		sequential;
+	unsigned int		sequential;
 	sector_t		last;
 };
 
@@ -358,18 +358,18 @@ struct cached_dev {
 	struct cache_accounting	accounting;
 
 	/* The rest of this all shows up in sysfs */
-	unsigned		sequential_cutoff;
-	unsigned		readahead;
+	unsigned int		sequential_cutoff;
+	unsigned int		readahead;
 
-	unsigned		io_disable:1;
-	unsigned		verify:1;
-	unsigned		bypass_torture_test:1;
+	unsigned int		io_disable:1;
+	unsigned int		verify:1;
+	unsigned int		bypass_torture_test:1;
 
-	unsigned		partial_stripes_expensive:1;
-	unsigned		writeback_metadata:1;
-	unsigned		writeback_running:1;
+	unsigned int		partial_stripes_expensive:1;
+	unsigned int		writeback_metadata:1;
+	unsigned int		writeback_running:1;
 	unsigned char		writeback_percent;
-	unsigned		writeback_delay;
+	unsigned int		writeback_delay;
 
 	uint64_t		writeback_rate_target;
 	int64_t			writeback_rate_proportional;
@@ -377,16 +377,16 @@ struct cached_dev {
 	int64_t			writeback_rate_integral_scaled;
 	int32_t			writeback_rate_change;
 
-	unsigned		writeback_rate_update_seconds;
-	unsigned		writeback_rate_i_term_inverse;
-	unsigned		writeback_rate_p_term_inverse;
-	unsigned		writeback_rate_minimum;
+	unsigned int		writeback_rate_update_seconds;
+	unsigned int		writeback_rate_i_term_inverse;
+	unsigned int		writeback_rate_p_term_inverse;
+	unsigned int		writeback_rate_minimum;
 
 	enum stop_on_failure	stop_when_cache_set_failed;
 #define DEFAULT_CACHED_DEV_ERROR_LIMIT	64
 	atomic_t		io_errors;
-	unsigned		error_limit;
-	unsigned		offline_seconds;
+	unsigned int		error_limit;
+	unsigned int		offline_seconds;
 
 	char			backing_dev_name[BDEVNAME_SIZE];
 };
@@ -447,7 +447,7 @@ struct cache {
 	 * until a gc finishes - otherwise we could pointlessly burn a ton of
 	 * cpu
 	 */
-	unsigned		invalidate_needs_gc;
+	unsigned int		invalidate_needs_gc;
 
 	bool			discard; /* Get rid of? */
 
@@ -472,7 +472,7 @@ struct gc_stat {
 
 	size_t			nkeys;
 	uint64_t		data;	/* sectors */
-	unsigned		in_use; /* percent */
+	unsigned int		in_use; /* percent */
 };
 
 /*
@@ -518,7 +518,7 @@ struct cache_set {
 	int			caches_loaded;
 
 	struct bcache_device	**devices;
-	unsigned		devices_max_used;
+	unsigned int		devices_max_used;
 	atomic_t		attached_dev_nr;
 	struct list_head	cached_devs;
 	uint64_t		cached_dev_sectors;
@@ -548,7 +548,7 @@ struct cache_set {
 	 * Default number of pages for a new btree node - may be less than a
 	 * full bucket
 	 */
-	unsigned		btree_pages;
+	unsigned int		btree_pages;
 
 	/*
 	 * Lists of struct btrees; lru is the list for structs that have memory
@@ -571,7 +571,7 @@ struct cache_set {
 	struct list_head	btree_cache_freed;
 
 	/* Number of elements in btree_cache + btree_cache_freeable lists */
-	unsigned		btree_cache_used;
+	unsigned int		btree_cache_used;
 
 	/*
 	 * If we need to allocate memory for a new btree node and that
@@ -649,7 +649,7 @@ struct cache_set {
 	struct mutex		verify_lock;
 #endif
 
-	unsigned		nr_uuids;
+	unsigned int		nr_uuids;
 	struct uuid_entry	*uuids;
 	BKEY_PADDED(uuid_bucket);
 	struct closure		uuid_write;
@@ -670,12 +670,12 @@ struct cache_set {
 	struct journal		journal;
 
 #define CONGESTED_MAX		1024
-	unsigned		congested_last_us;
+	unsigned int		congested_last_us;
 	atomic_t		congested;
 
 	/* The rest of this all shows up in sysfs */
-	unsigned		congested_read_threshold_us;
-	unsigned		congested_write_threshold_us;
+	unsigned int		congested_read_threshold_us;
+	unsigned int		congested_write_threshold_us;
 
 	struct time_stats	btree_gc_time;
 	struct time_stats	btree_split_time;
@@ -694,16 +694,16 @@ struct cache_set {
 		ON_ERROR_PANIC,
 	}			on_error;
 #define DEFAULT_IO_ERROR_LIMIT 8
-	unsigned		error_limit;
-	unsigned		error_decay;
+	unsigned int		error_limit;
+	unsigned int		error_decay;
 
 	unsigned short		journal_delay_ms;
 	bool			expensive_debug_checks;
-	unsigned		verify:1;
-	unsigned		key_merging_disabled:1;
-	unsigned		gc_always_rewrite:1;
-	unsigned		shrinker_disabled:1;
-	unsigned		copy_gc_enabled:1;
+	unsigned int		verify:1;
+	unsigned int		key_merging_disabled:1;
+	unsigned int		gc_always_rewrite:1;
+	unsigned int		shrinker_disabled:1;
+	unsigned int		copy_gc_enabled:1;
 
 #define BUCKET_HASH_BITS	12
 	struct hlist_head	bucket_hash[1 << BUCKET_HASH_BITS];
@@ -712,7 +712,7 @@ struct cache_set {
 };
 
 struct bbio {
-	unsigned		submit_time_us;
+	unsigned int		submit_time_us;
 	union {
 		struct bkey	key;
 		uint64_t	_pad[3];
@@ -729,10 +729,10 @@ struct bbio {
 
 #define btree_bytes(c)		((c)->btree_pages * PAGE_SIZE)
 #define btree_blocks(b)							\
-	((unsigned) (KEY_SIZE(&b->key) >> (b)->c->block_bits))
+	((unsigned int) (KEY_SIZE(&b->key) >> (b)->c->block_bits))
 
 #define btree_default_blocks(c)						\
-	((unsigned) ((PAGE_SECTORS * (c)->btree_pages) >> (c)->block_bits))
+	((unsigned int) ((PAGE_SECTORS * (c)->btree_pages) >> (c)->block_bits))
 
 #define bucket_pages(c)		((c)->sb.bucket_size / PAGE_SECTORS)
 #define bucket_bytes(c)		((c)->sb.bucket_size << 9)
@@ -761,21 +761,21 @@ static inline sector_t bucket_remainder(struct cache_set *c, sector_t s)
 
 static inline struct cache *PTR_CACHE(struct cache_set *c,
 				      const struct bkey *k,
-				      unsigned ptr)
+				      unsigned int ptr)
 {
 	return c->cache[PTR_DEV(k, ptr)];
 }
 
 static inline size_t PTR_BUCKET_NR(struct cache_set *c,
 				   const struct bkey *k,
-				   unsigned ptr)
+				   unsigned int ptr)
 {
 	return sector_to_bucket(c, PTR_OFFSET(k, ptr));
 }
 
 static inline struct bucket *PTR_BUCKET(struct cache_set *c,
 					const struct bkey *k,
-					unsigned ptr)
+					unsigned int ptr)
 {
 	return PTR_CACHE(c, k, ptr)->buckets + PTR_BUCKET_NR(c, k, ptr);
 }
@@ -787,13 +787,13 @@ static inline uint8_t gen_after(uint8_t a, uint8_t b)
 }
 
 static inline uint8_t ptr_stale(struct cache_set *c, const struct bkey *k,
-				unsigned i)
+				unsigned int i)
 {
 	return gen_after(PTR_BUCKET(c, k, i)->gen, PTR_GEN(k, i));
 }
 
 static inline bool ptr_available(struct cache_set *c, const struct bkey *k,
-				 unsigned i)
+				 unsigned int i)
 {
 	return (PTR_DEV(k, i) < MAX_CACHES_PER_SET) && PTR_CACHE(c, k, i);
 }
@@ -888,7 +888,7 @@ static inline uint8_t bucket_gc_gen(struct bucket *b)
 static inline void wake_up_allocators(struct cache_set *c)
 {
 	struct cache *ca;
-	unsigned i;
+	unsigned int i;
 
 	for_each_cache(ca, c, i)
 		wake_up_process(ca->alloc_thread);
@@ -933,7 +933,8 @@ void bch_bbio_free(struct bio *, struct cache_set *);
 struct bio *bch_bbio_alloc(struct cache_set *);
 
 void __bch_submit_bbio(struct bio *, struct cache_set *);
-void bch_submit_bbio(struct bio *, struct cache_set *, struct bkey *, unsigned);
+void bch_submit_bbio(struct bio *, struct cache_set *,
+		     struct bkey *, unsigned int);
 
 uint8_t bch_inc_gen(struct cache *, struct bucket *);
 void bch_rescale_priorities(struct cache_set *, int);
@@ -944,13 +945,13 @@ void __bch_invalidate_one_bucket(struct cache *, struct bucket *);
 void __bch_bucket_free(struct cache *, struct bucket *);
 void bch_bucket_free(struct cache_set *, struct bkey *);
 
-long bch_bucket_alloc(struct cache *, unsigned, bool);
-int __bch_bucket_alloc_set(struct cache_set *, unsigned,
+long bch_bucket_alloc(struct cache *, unsigned int, bool);
+int __bch_bucket_alloc_set(struct cache_set *, unsigned int,
 			   struct bkey *, int, bool);
-int bch_bucket_alloc_set(struct cache_set *, unsigned,
+int bch_bucket_alloc_set(struct cache_set *, unsigned int,
 			 struct bkey *, int, bool);
-bool bch_alloc_sectors(struct cache_set *, struct bkey *, unsigned,
-		       unsigned, unsigned, bool);
+bool bch_alloc_sectors(struct cache_set *, struct bkey *, unsigned int,
+		       unsigned int, unsigned int, bool);
 bool bch_cached_dev_error(struct cached_dev *dc);
 
 __printf(2, 3)
diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 596c93b44e9b..dfda7e9efc3e 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -18,7 +18,7 @@
 
 #ifdef CONFIG_BCACHE_DEBUG
 
-void bch_dump_bset(struct btree_keys *b, struct bset *i, unsigned set)
+void bch_dump_bset(struct btree_keys *b, struct bset *i, unsigned int set)
 {
 	struct bkey *k, *next;
 
@@ -26,7 +26,7 @@ void bch_dump_bset(struct btree_keys *b, struct bset *i, unsigned set)
 		next = bkey_next(k);
 
 		printk(KERN_ERR "block %u key %u/%u: ", set,
-		       (unsigned) ((u64 *) k - i->d), i->keys);
+		       (unsigned int) ((u64 *) k - i->d), i->keys);
 
 		if (b->ops->key_dump)
 			b->ops->key_dump(b, k);
@@ -42,7 +42,7 @@ void bch_dump_bset(struct btree_keys *b, struct bset *i, unsigned set)
 
 void bch_dump_bucket(struct btree_keys *b)
 {
-	unsigned i;
+	unsigned int i;
 
 	console_lock();
 	for (i = 0; i <= b->nsets; i++)
@@ -53,7 +53,7 @@ void bch_dump_bucket(struct btree_keys *b)
 
 int __bch_count_data(struct btree_keys *b)
 {
-	unsigned ret = 0;
+	unsigned int ret = 0;
 	struct btree_iter iter;
 	struct bkey *k;
 
@@ -128,7 +128,7 @@ static inline void bch_btree_iter_next_check(struct btree_iter *iter) {}
 
 /* Keylists */
 
-int __bch_keylist_realloc(struct keylist *l, unsigned u64s)
+int __bch_keylist_realloc(struct keylist *l, unsigned int u64s)
 {
 	size_t oldsize = bch_keylist_nkeys(l);
 	size_t newsize = oldsize + u64s;
@@ -180,7 +180,7 @@ void bch_keylist_pop_front(struct keylist *l)
 /* Key/pointer manipulation */
 
 void bch_bkey_copy_single_ptr(struct bkey *dest, const struct bkey *src,
-			      unsigned i)
+			      unsigned int i)
 {
 	BUG_ON(i > KEY_PTRS(src));
 
@@ -194,7 +194,7 @@ void bch_bkey_copy_single_ptr(struct bkey *dest, const struct bkey *src,
 
 bool __bch_cut_front(const struct bkey *where, struct bkey *k)
 {
-	unsigned i, len = 0;
+	unsigned int i, len = 0;
 
 	if (bkey_cmp(where, &START_KEY(k)) <= 0)
 		return false;
@@ -214,7 +214,7 @@ bool __bch_cut_front(const struct bkey *where, struct bkey *k)
 
 bool __bch_cut_back(const struct bkey *where, struct bkey *k)
 {
-	unsigned len = 0;
+	unsigned int len = 0;
 
 	if (bkey_cmp(where, k) >= 0)
 		return false;
@@ -240,9 +240,9 @@ bool __bch_cut_back(const struct bkey *where, struct bkey *k)
 #define BKEY_MANTISSA_MASK	((1 << BKEY_MANTISSA_BITS) - 1)
 
 struct bkey_float {
-	unsigned	exponent:BKEY_EXPONENT_BITS;
-	unsigned	m:BKEY_MID_BITS;
-	unsigned	mantissa:BKEY_MANTISSA_BITS;
+	unsigned int	exponent:BKEY_EXPONENT_BITS;
+	unsigned int	m:BKEY_MID_BITS;
+	unsigned int	mantissa:BKEY_MANTISSA_BITS;
 } __packed;
 
 /*
@@ -311,7 +311,7 @@ void bch_btree_keys_free(struct btree_keys *b)
 }
 EXPORT_SYMBOL(bch_btree_keys_free);
 
-int bch_btree_keys_alloc(struct btree_keys *b, unsigned page_order, gfp_t gfp)
+int bch_btree_keys_alloc(struct btree_keys *b, unsigned int page_order, gfp_t gfp)
 {
 	struct bset_tree *t = b->set;
 
@@ -345,7 +345,7 @@ EXPORT_SYMBOL(bch_btree_keys_alloc);
 void bch_btree_keys_init(struct btree_keys *b, const struct btree_keys_ops *ops,
 			 bool *expensive_debug_checks)
 {
-	unsigned i;
+	unsigned int i;
 
 	b->ops = ops;
 	b->expensive_debug_checks = expensive_debug_checks;
@@ -370,7 +370,7 @@ EXPORT_SYMBOL(bch_btree_keys_init);
  * return array index next to j when does in-order traverse
  * of a binary tree which is stored in a linear array
  */
-static unsigned inorder_next(unsigned j, unsigned size)
+static unsigned int inorder_next(unsigned int j, unsigned int size)
 {
 	if (j * 2 + 1 < size) {
 		j = j * 2 + 1;
@@ -387,7 +387,7 @@ static unsigned inorder_next(unsigned j, unsigned size)
  * return array index previous to j when does in-order traverse
  * of a binary tree which is stored in a linear array
  */
-static unsigned inorder_prev(unsigned j, unsigned size)
+static unsigned int inorder_prev(unsigned int j, unsigned int size)
 {
 	if (j * 2 < size) {
 		j = j * 2;
@@ -413,10 +413,12 @@ static unsigned inorder_prev(unsigned j, unsigned size)
  * extra is a function of size:
  *   extra = (size - rounddown_pow_of_two(size - 1)) << 1;
  */
-static unsigned __to_inorder(unsigned j, unsigned size, unsigned extra)
+static unsigned int __to_inorder(unsigned int j,
+				  unsigned int size,
+				  unsigned int extra)
 {
-	unsigned b = fls(j);
-	unsigned shift = fls(size - 1) - b;
+	unsigned int b = fls(j);
+	unsigned int shift = fls(size - 1) - b;
 
 	j  ^= 1U << (b - 1);
 	j <<= 1;
@@ -433,14 +435,16 @@ static unsigned __to_inorder(unsigned j, unsigned size, unsigned extra)
  * Return the cacheline index in bset_tree->data, where j is index
  * from a linear array which stores the auxiliar binary tree
  */
-static unsigned to_inorder(unsigned j, struct bset_tree *t)
+static unsigned int to_inorder(unsigned int j, struct bset_tree *t)
 {
 	return __to_inorder(j, t->size, t->extra);
 }
 
-static unsigned __inorder_to_tree(unsigned j, unsigned size, unsigned extra)
+static unsigned int __inorder_to_tree(unsigned int j,
+				      unsigned int size,
+				      unsigned int extra)
 {
-	unsigned shift;
+	unsigned int shift;
 
 	if (j > extra)
 		j += j - extra;
@@ -457,7 +461,7 @@ static unsigned __inorder_to_tree(unsigned j, unsigned size, unsigned extra)
  * Return an index from a linear array which stores the auxiliar binary
  * tree, j is the cacheline index of t->data.
  */
-static unsigned inorder_to_tree(unsigned j, struct bset_tree *t)
+static unsigned int inorder_to_tree(unsigned int j, struct bset_tree *t)
 {
 	return __inorder_to_tree(j, t->size, t->extra);
 }
@@ -468,11 +472,11 @@ void inorder_test(void)
 	unsigned long done = 0;
 	ktime_t start = ktime_get();
 
-	for (unsigned size = 2;
+	for (unsigned int size = 2;
 	     size < 65536000;
 	     size++) {
-		unsigned extra = (size - rounddown_pow_of_two(size - 1)) << 1;
-		unsigned i = 1, j = rounddown_pow_of_two(size - 1);
+		unsigned int extra = (size - rounddown_pow_of_two(size - 1)) << 1;
+		unsigned int i = 1, j = rounddown_pow_of_two(size - 1);
 
 		if (!(size % 4096))
 			printk(KERN_NOTICE "loop %u, %llu per us\n", size,
@@ -518,30 +522,31 @@ void inorder_test(void)
  * of the previous key so we can walk backwards to it from t->tree[j]'s key.
  */
 
-static struct bkey *cacheline_to_bkey(struct bset_tree *t, unsigned cacheline,
-				      unsigned offset)
+static struct bkey *cacheline_to_bkey(struct bset_tree *t,
+				      unsigned int cacheline,
+				      unsigned int offset)
 {
 	return ((void *) t->data) + cacheline * BSET_CACHELINE + offset * 8;
 }
 
-static unsigned bkey_to_cacheline(struct bset_tree *t, struct bkey *k)
+static unsigned int bkey_to_cacheline(struct bset_tree *t, struct bkey *k)
 {
 	return ((void *) k - (void *) t->data) / BSET_CACHELINE;
 }
 
-static unsigned bkey_to_cacheline_offset(struct bset_tree *t,
-					 unsigned cacheline,
+static unsigned int bkey_to_cacheline_offset(struct bset_tree *t,
+					 unsigned int cacheline,
 					 struct bkey *k)
 {
 	return (u64 *) k - (u64 *) cacheline_to_bkey(t, cacheline, 0);
 }
 
-static struct bkey *tree_to_bkey(struct bset_tree *t, unsigned j)
+static struct bkey *tree_to_bkey(struct bset_tree *t, unsigned int j)
 {
 	return cacheline_to_bkey(t, to_inorder(j, t), t->tree[j].m);
 }
 
-static struct bkey *tree_to_prev_bkey(struct bset_tree *t, unsigned j)
+static struct bkey *tree_to_prev_bkey(struct bset_tree *t, unsigned int j)
 {
 	return (void *) (((uint64_t *) tree_to_bkey(t, j)) - t->prev[j]);
 }
@@ -550,7 +555,7 @@ static struct bkey *tree_to_prev_bkey(struct bset_tree *t, unsigned j)
  * For the write set - the one we're currently inserting keys into - we don't
  * maintain a full search tree, we just keep a simple lookup table in t->prev.
  */
-static struct bkey *table_to_bkey(struct bset_tree *t, unsigned cacheline)
+static struct bkey *table_to_bkey(struct bset_tree *t, unsigned int cacheline)
 {
 	return cacheline_to_bkey(t, cacheline, t->prev[cacheline]);
 }
@@ -576,14 +581,14 @@ static inline uint64_t shrd128(uint64_t high, uint64_t low, uint8_t shift)
  * See make_bfloat() to check when most significant bit of f->exponent
  * is set or not.
  */
-static inline unsigned bfloat_mantissa(const struct bkey *k,
+static inline unsigned int bfloat_mantissa(const struct bkey *k,
 				       struct bkey_float *f)
 {
 	const uint64_t *p = &k->low - (f->exponent >> 6);
 	return shrd128(p[-1], p[0], f->exponent & 63) & BKEY_MANTISSA_MASK;
 }
 
-static void make_bfloat(struct bset_tree *t, unsigned j)
+static void make_bfloat(struct bset_tree *t, unsigned int j)
 {
 	struct bkey_float *f = &t->tree[j];
 	struct bkey *m = tree_to_bkey(t, j);
@@ -631,7 +636,7 @@ static void make_bfloat(struct bset_tree *t, unsigned j)
 static void bset_alloc_tree(struct btree_keys *b, struct bset_tree *t)
 {
 	if (t != b->set) {
-		unsigned j = roundup(t[-1].size,
+		unsigned int j = roundup(t[-1].size,
 				     64 / sizeof(struct bkey_float));
 
 		t->tree = t[-1].tree + j;
@@ -686,13 +691,13 @@ void bch_bset_build_written_tree(struct btree_keys *b)
 {
 	struct bset_tree *t = bset_tree_last(b);
 	struct bkey *prev = NULL, *k = t->data->start;
-	unsigned j, cacheline = 1;
+	unsigned int j, cacheline = 1;
 
 	b->last_set_unwritten = 0;
 
 	bset_alloc_tree(b, t);
 
-	t->size = min_t(unsigned,
+	t->size = min_t(unsigned int,
 			bkey_to_cacheline(t, bset_bkey_last(t->data)),
 			b->set->tree + btree_keys_cachelines(b) - t->tree);
 
@@ -732,7 +737,7 @@ EXPORT_SYMBOL(bch_bset_build_written_tree);
 void bch_bset_fix_invalidated_key(struct btree_keys *b, struct bkey *k)
 {
 	struct bset_tree *t;
-	unsigned inorder, j = 1;
+	unsigned int inorder, j = 1;
 
 	for (t = b->set; t <= bset_tree_last(b); t++)
 		if (k < bset_bkey_last(t->data))
@@ -779,8 +784,8 @@ static void bch_bset_fix_lookup_table(struct btree_keys *b,
 				      struct bset_tree *t,
 				      struct bkey *k)
 {
-	unsigned shift = bkey_u64s(k);
-	unsigned j = bkey_to_cacheline(t, k);
+	unsigned int shift = bkey_u64s(k);
+	unsigned int j = bkey_to_cacheline(t, k);
 
 	/* We're getting called from btree_split() or btree_gc, just bail out */
 	if (!t->size)
@@ -867,10 +872,10 @@ void bch_bset_insert(struct btree_keys *b, struct bkey *where,
 }
 EXPORT_SYMBOL(bch_bset_insert);
 
-unsigned bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
+unsigned int bch_btree_insert_key(struct btree_keys *b, struct bkey *k,
 			      struct bkey *replace_key)
 {
-	unsigned status = BTREE_INSERT_STATUS_NO_INSERT;
+	unsigned int status = BTREE_INSERT_STATUS_NO_INSERT;
 	struct bset *i = bset_tree_last(b)->data;
 	struct bkey *m, *prev = NULL;
 	struct btree_iter iter;
@@ -922,10 +927,10 @@ struct bset_search_iter {
 static struct bset_search_iter bset_search_write_set(struct bset_tree *t,
 						     const struct bkey *search)
 {
-	unsigned li = 0, ri = t->size;
+	unsigned int li = 0, ri = t->size;
 
 	while (li + 1 != ri) {
-		unsigned m = (li + ri) >> 1;
+		unsigned int m = (li + ri) >> 1;
 
 		if (bkey_cmp(table_to_bkey(t, m), search) > 0)
 			ri = m;
@@ -944,7 +949,7 @@ static struct bset_search_iter bset_search_tree(struct bset_tree *t,
 {
 	struct bkey *l, *r;
 	struct bkey_float *f;
-	unsigned inorder, j, n = 1;
+	unsigned int inorder, j, n = 1;
 
 	do {
 		/*
@@ -958,7 +963,7 @@ static struct bset_search_iter bset_search_tree(struct bset_tree *t,
 		 *		p = 0;
 		 * but a branch instruction is avoided.
 		 */
-		unsigned p = n << 4;
+		unsigned int p = n << 4;
 		p &= ((int) (p - t->size)) >> 31;
 
 		prefetch(&t->tree[p]);
@@ -978,7 +983,7 @@ static struct bset_search_iter bset_search_tree(struct bset_tree *t,
 		 * to work  - that's done in make_bfloat()
 		 */
 		if (likely(f->exponent != 127))
-			n = j * 2 + (((unsigned)
+			n = j * 2 + (((unsigned int)
 				      (f->mantissa -
 				       bfloat_mantissa(search, f))) >> 31);
 		else
@@ -1184,7 +1189,8 @@ void bch_bset_sort_state_free(struct bset_sort_state *state)
 	mempool_exit(&state->pool);
 }
 
-int bch_bset_sort_state_init(struct bset_sort_state *state, unsigned page_order)
+int bch_bset_sort_state_init(struct bset_sort_state *state,
+			     unsigned int page_order)
 {
 	spin_lock_init(&state->time.lock);
 
@@ -1237,7 +1243,7 @@ static void btree_mergesort(struct btree_keys *b, struct bset *out,
 }
 
 static void __btree_sort(struct btree_keys *b, struct btree_iter *iter,
-			 unsigned start, unsigned order, bool fixup,
+			 unsigned int start, unsigned int order, bool fixup,
 			 struct bset_sort_state *state)
 {
 	uint64_t start_time;
@@ -1288,7 +1294,7 @@ static void __btree_sort(struct btree_keys *b, struct btree_iter *iter,
 		bch_time_stats_update(&state->time, start_time);
 }
 
-void bch_btree_sort_partial(struct btree_keys *b, unsigned start,
+void bch_btree_sort_partial(struct btree_keys *b, unsigned int start,
 			    struct bset_sort_state *state)
 {
 	size_t order = b->page_order, keys = 0;
@@ -1298,7 +1304,7 @@ void bch_btree_sort_partial(struct btree_keys *b, unsigned start,
 	__bch_btree_iter_init(b, &iter, NULL, &b->set[start]);
 
 	if (start) {
-		unsigned i;
+		unsigned int i;
 
 		for (i = start; i <= b->nsets; i++)
 			keys += b->set[i].data->keys;
@@ -1338,7 +1344,7 @@ void bch_btree_sort_into(struct btree_keys *b, struct btree_keys *new,
 
 void bch_btree_sort_lazy(struct btree_keys *b, struct bset_sort_state *state)
 {
-	unsigned crit = SORT_CRIT;
+	unsigned int crit = SORT_CRIT;
 	int i;
 
 	/* Don't sort if nothing to do */
@@ -1367,7 +1373,7 @@ EXPORT_SYMBOL(bch_btree_sort_lazy);
 
 void bch_btree_keys_stats(struct btree_keys *b, struct bset_stats *stats)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i <= b->nsets; i++) {
 		struct bset_tree *t = &b->set[i];
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index b867f2200495..fdc296103113 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -163,10 +163,10 @@ struct bset_tree {
 	 */
 
 	/* size of the binary tree and prev array */
-	unsigned		size;
+	unsigned int		size;
 
 	/* function of size - precalculated for to_inorder() */
-	unsigned		extra;
+	unsigned int		extra;
 
 	/* copy of the last key in the set */
 	struct bkey		end;
@@ -211,7 +211,7 @@ struct btree_keys {
 	const struct btree_keys_ops	*ops;
 	uint8_t			page_order;
 	uint8_t			nsets;
-	unsigned		last_set_unwritten:1;
+	unsigned int		last_set_unwritten:1;
 	bool			*expensive_debug_checks;
 
 	/*
@@ -239,12 +239,12 @@ static inline bool bkey_written(struct btree_keys *b, struct bkey *k)
 	return !b->last_set_unwritten || k < b->set[b->nsets].data->start;
 }
 
-static inline unsigned bset_byte_offset(struct btree_keys *b, struct bset *i)
+static inline unsigned int bset_byte_offset(struct btree_keys *b, struct bset *i)
 {
 	return ((size_t) i) - ((size_t) b->set->data);
 }
 
-static inline unsigned bset_sector_offset(struct btree_keys *b, struct bset *i)
+static inline unsigned int bset_sector_offset(struct btree_keys *b, struct bset *i)
 {
 	return bset_byte_offset(b, i) >> 9;
 }
@@ -273,7 +273,7 @@ static inline size_t bch_btree_keys_u64s_remaining(struct btree_keys *b)
 }
 
 static inline struct bset *bset_next_set(struct btree_keys *b,
-					 unsigned block_bytes)
+					 unsigned int block_bytes)
 {
 	struct bset *i = bset_tree_last(b)->data;
 
@@ -281,7 +281,7 @@ static inline struct bset *bset_next_set(struct btree_keys *b,
 }
 
 void bch_btree_keys_free(struct btree_keys *);
-int bch_btree_keys_alloc(struct btree_keys *, unsigned, gfp_t);
+int bch_btree_keys_alloc(struct btree_keys *, unsigned int, gfp_t);
 void bch_btree_keys_init(struct btree_keys *, const struct btree_keys_ops *,
 			 bool *);
 
@@ -290,7 +290,7 @@ void bch_bset_build_written_tree(struct btree_keys *);
 void bch_bset_fix_invalidated_key(struct btree_keys *, struct bkey *);
 bool bch_bkey_try_merge(struct btree_keys *, struct bkey *, struct bkey *);
 void bch_bset_insert(struct btree_keys *, struct bkey *, struct bkey *);
-unsigned bch_btree_insert_key(struct btree_keys *, struct bkey *,
+unsigned int bch_btree_insert_key(struct btree_keys *, struct bkey *,
 			      struct bkey *);
 
 enum {
@@ -349,20 +349,20 @@ static inline struct bkey *bch_bset_search(struct btree_keys *b,
 struct bset_sort_state {
 	mempool_t		pool;
 
-	unsigned		page_order;
-	unsigned		crit_factor;
+	unsigned int		page_order;
+	unsigned int		crit_factor;
 
 	struct time_stats	time;
 };
 
 void bch_bset_sort_state_free(struct bset_sort_state *);
-int bch_bset_sort_state_init(struct bset_sort_state *, unsigned);
+int bch_bset_sort_state_init(struct bset_sort_state *, unsigned int);
 void bch_btree_sort_lazy(struct btree_keys *, struct bset_sort_state *);
 void bch_btree_sort_into(struct btree_keys *, struct btree_keys *,
 			 struct bset_sort_state *);
 void bch_btree_sort_and_fix_extents(struct btree_keys *, struct btree_iter *,
 				    struct bset_sort_state *);
-void bch_btree_sort_partial(struct btree_keys *, unsigned,
+void bch_btree_sort_partial(struct btree_keys *, unsigned int,
 			    struct bset_sort_state *);
 
 static inline void bch_btree_sort(struct btree_keys *b,
@@ -383,7 +383,7 @@ void bch_btree_keys_stats(struct btree_keys *, struct bset_stats *);
 
 #define bset_bkey_last(i)	bkey_idx((struct bkey *) (i)->d, (i)->keys)
 
-static inline struct bkey *bset_bkey_idx(struct bset *i, unsigned idx)
+static inline struct bkey *bset_bkey_idx(struct bset *i, unsigned int idx)
 {
 	return bkey_idx(i->start, idx);
 }
@@ -402,7 +402,7 @@ static __always_inline int64_t bkey_cmp(const struct bkey *l,
 }
 
 void bch_bkey_copy_single_ptr(struct bkey *, const struct bkey *,
-			      unsigned);
+			      unsigned int);
 bool __bch_cut_front(const struct bkey *, struct bkey *);
 bool __bch_cut_back(const struct bkey *, struct bkey *);
 
@@ -524,7 +524,7 @@ static inline size_t bch_keylist_bytes(struct keylist *l)
 
 struct bkey *bch_keylist_pop(struct keylist *);
 void bch_keylist_pop_front(struct keylist *);
-int __bch_keylist_realloc(struct keylist *, unsigned);
+int __bch_keylist_realloc(struct keylist *, unsigned int);
 
 /* Debug stuff */
 
@@ -532,7 +532,7 @@ int __bch_keylist_realloc(struct keylist *, unsigned);
 
 int __bch_count_data(struct btree_keys *);
 void __printf(2, 3) __bch_check_keys(struct btree_keys *, const char *, ...);
-void bch_dump_bset(struct btree_keys *, struct bset *, unsigned);
+void bch_dump_bset(struct btree_keys *, struct bset *, unsigned int);
 void bch_dump_bucket(struct btree_keys *);
 
 #else
@@ -541,7 +541,7 @@ static inline int __bch_count_data(struct btree_keys *b) { return -1; }
 static inline void __printf(2, 3)
 	__bch_check_keys(struct btree_keys *b, const char *fmt, ...) {}
 static inline void bch_dump_bucket(struct btree_keys *b) {}
-void bch_dump_bset(struct btree_keys *, struct bset *, unsigned);
+void bch_dump_bset(struct btree_keys *, struct bset *, unsigned int);
 
 #endif
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index c19f7716df88..96c39a8db895 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -183,7 +183,7 @@ static void bch_btree_init_next(struct btree *b)
 
 void bkey_put(struct cache_set *c, struct bkey *k)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		if (ptr_available(c, k, i))
@@ -479,7 +479,7 @@ void __bch_btree_node_write(struct btree *b, struct closure *parent)
 
 void bch_btree_node_write(struct btree *b, struct closure *parent)
 {
-	unsigned nsets = b->keys.nsets;
+	unsigned int nsets = b->keys.nsets;
 
 	lockdep_assert_held(&b->lock);
 
@@ -581,7 +581,7 @@ static void mca_bucket_free(struct btree *b)
 	list_move(&b->list, &b->c->btree_cache_freeable);
 }
 
-static unsigned btree_order(struct bkey *k)
+static unsigned int btree_order(struct bkey *k)
 {
 	return ilog2(KEY_SIZE(k) / PAGE_SECTORS ?: 1);
 }
@@ -589,7 +589,7 @@ static unsigned btree_order(struct bkey *k)
 static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
 {
 	if (!bch_btree_keys_alloc(&b->keys,
-				  max_t(unsigned,
+				  max_t(unsigned int,
 					ilog2(b->c->btree_pages),
 					btree_order(k)),
 				  gfp)) {
@@ -620,7 +620,7 @@ static struct btree *mca_bucket_alloc(struct cache_set *c,
 	return b;
 }
 
-static int mca_reap(struct btree *b, unsigned min_order, bool flush)
+static int mca_reap(struct btree *b, unsigned int min_order, bool flush)
 {
 	struct closure cl;
 
@@ -786,7 +786,7 @@ void bch_btree_cache_free(struct cache_set *c)
 
 int bch_btree_cache_alloc(struct cache_set *c)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < mca_reserve(c); i++)
 		if (!mca_bucket_alloc(c, &ZERO_KEY, GFP_KERNEL))
@@ -1136,7 +1136,7 @@ static struct btree *btree_node_alloc_replacement(struct btree *b,
 
 static void make_btree_freeing_key(struct btree *b, struct bkey *k)
 {
-	unsigned i;
+	unsigned int i;
 
 	mutex_lock(&b->c->bucket_lock);
 
@@ -1157,7 +1157,7 @@ static int btree_check_reserve(struct btree *b, struct btree_op *op)
 {
 	struct cache_set *c = b->c;
 	struct cache *ca;
-	unsigned i, reserve = (c->root->level - b->level) * 2 + 1;
+	unsigned int i, reserve = (c->root->level - b->level) * 2 + 1;
 
 	mutex_lock(&c->bucket_lock);
 
@@ -1181,7 +1181,7 @@ static uint8_t __bch_btree_mark_key(struct cache_set *c, int level,
 				    struct bkey *k)
 {
 	uint8_t stale = 0;
-	unsigned i;
+	unsigned int i;
 	struct bucket *g;
 
 	/*
@@ -1219,7 +1219,7 @@ static uint8_t __bch_btree_mark_key(struct cache_set *c, int level,
 			SET_GC_MARK(g, GC_MARK_RECLAIMABLE);
 
 		/* guard against overflow */
-		SET_GC_SECTORS_USED(g, min_t(unsigned,
+		SET_GC_SECTORS_USED(g, min_t(unsigned int,
 					     GC_SECTORS_USED(g) + KEY_SIZE(k),
 					     MAX_GC_SECTORS_USED));
 
@@ -1233,7 +1233,7 @@ static uint8_t __bch_btree_mark_key(struct cache_set *c, int level,
 
 void bch_initial_mark_key(struct cache_set *c, int level, struct bkey *k)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		if (ptr_available(c, k, i) &&
@@ -1259,7 +1259,7 @@ void bch_update_bucket_in_use(struct cache_set *c, struct gc_stat *stats)
 static bool btree_gc_mark_node(struct btree *b, struct gc_stat *gc)
 {
 	uint8_t stale = 0;
-	unsigned keys = 0, good_keys = 0;
+	unsigned int keys = 0, good_keys = 0;
 	struct bkey *k;
 	struct btree_iter iter;
 	struct bset_tree *t;
@@ -1302,7 +1302,7 @@ static bool btree_gc_mark_node(struct btree *b, struct gc_stat *gc)
 
 struct gc_merge_info {
 	struct btree	*b;
-	unsigned	keys;
+	unsigned int	keys;
 };
 
 static int bch_btree_insert_node(struct btree *, struct btree_op *,
@@ -1311,7 +1311,7 @@ static int bch_btree_insert_node(struct btree *, struct btree_op *,
 static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 			     struct gc_stat *gc, struct gc_merge_info *r)
 {
-	unsigned i, nodes = 0, keys = 0, blocks;
+	unsigned int i, nodes = 0, keys = 0, blocks;
 	struct btree *new_nodes[GC_MERGE_NODES];
 	struct keylist keylist;
 	struct closure cl;
@@ -1511,11 +1511,11 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 	return -EINTR;
 }
 
-static unsigned btree_gc_count_keys(struct btree *b)
+static unsigned int btree_gc_count_keys(struct btree *b)
 {
 	struct bkey *k;
 	struct btree_iter iter;
-	unsigned ret = 0;
+	unsigned int ret = 0;
 
 	for_each_key_filter(&b->keys, k, &iter, bch_ptr_bad)
 		ret += bkey_u64s(k);
@@ -1678,7 +1678,7 @@ static void btree_gc_start(struct cache_set *c)
 {
 	struct cache *ca;
 	struct bucket *b;
-	unsigned i;
+	unsigned int i;
 
 	if (!c->gc_mark_valid)
 		return;
@@ -1704,7 +1704,7 @@ static void bch_btree_gc_finish(struct cache_set *c)
 {
 	struct bucket *b;
 	struct cache *ca;
-	unsigned i;
+	unsigned int i;
 
 	mutex_lock(&c->bucket_lock);
 
@@ -1722,7 +1722,7 @@ static void bch_btree_gc_finish(struct cache_set *c)
 		struct bcache_device *d = c->devices[i];
 		struct cached_dev *dc;
 		struct keybuf_key *w, *n;
-		unsigned j;
+		unsigned int j;
 
 		if (!d || UUID_FLASH_ONLY(&c->uuids[i]))
 			continue;
@@ -1814,7 +1814,7 @@ static void bch_btree_gc(struct cache_set *c)
 static bool gc_should_run(struct cache_set *c)
 {
 	struct cache *ca;
-	unsigned i;
+	unsigned int i;
 
 	for_each_cache(ca, c, i)
 		if (ca->invalidate_needs_gc)
@@ -1905,7 +1905,7 @@ void bch_initial_gc_finish(struct cache_set *c)
 {
 	struct cache *ca;
 	struct bucket *b;
-	unsigned i;
+	unsigned int i;
 
 	bch_btree_gc_finish(c);
 
@@ -1945,7 +1945,7 @@ void bch_initial_gc_finish(struct cache_set *c)
 static bool btree_insert_key(struct btree *b, struct bkey *k,
 			     struct bkey *replace_key)
 {
-	unsigned status;
+	unsigned int status;
 
 	BUG_ON(bkey_cmp(k, &b->key) > 0);
 
@@ -2044,7 +2044,7 @@ static int btree_split(struct btree *b, struct btree_op *op,
 			   block_bytes(n1->c)) > (btree_blocks(b) * 4) / 5;
 
 	if (split) {
-		unsigned keys = 0;
+		unsigned int keys = 0;
 
 		trace_bcache_btree_node_split(b, btree_bset_first(n1)->keys);
 
@@ -2300,7 +2300,7 @@ int bch_btree_insert(struct cache_set *c, struct keylist *keys,
 
 void bch_btree_set_root(struct btree *b)
 {
-	unsigned i;
+	unsigned int i;
 	struct closure cl;
 
 	closure_init_stack(&cl);
@@ -2412,7 +2412,7 @@ static inline int keybuf_nonoverlapping_cmp(struct keybuf_key *l,
 
 struct refill {
 	struct btree_op	op;
-	unsigned	nr_found;
+	unsigned int	nr_found;
 	struct keybuf	*buf;
 	struct bkey	*end;
 	keybuf_pred_fn	*pred;
diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index 68e9d926134d..8cbc0fd27738 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -184,7 +184,7 @@ static inline struct bset *btree_bset_last(struct btree *b)
 	return bset_tree_last(&b->keys)->data;
 }
 
-static inline unsigned bset_block_offset(struct btree *b, struct bset *i)
+static inline unsigned int bset_block_offset(struct btree *b, struct bset *i)
 {
 	return bset_sector_offset(&b->keys, i) >> b->c->block_bits;
 }
@@ -213,7 +213,7 @@ struct btree_op {
 	/* Btree level at which we start taking write locks */
 	short			lock;
 
-	unsigned		insert_collision:1;
+	unsigned int		insert_collision:1;
 };
 
 static inline void bch_btree_op_init(struct btree_op *op, int write_lock_level)
diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index 7c2c5bc7c88b..7f3594c0be14 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -159,7 +159,7 @@ struct closure {
 #define CLOSURE_MAGIC_DEAD	0xc054dead
 #define CLOSURE_MAGIC_ALIVE	0xc054a11e
 
-	unsigned		magic;
+	unsigned int		magic;
 	struct list_head	all;
 	unsigned long		ip;
 	unsigned long		waiting_on;
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 12034c07257b..0caad145902b 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -69,7 +69,7 @@ void bch_btree_verify(struct btree *b)
 		   sorted->start,
 		   (void *) bset_bkey_last(inmemory) - (void *) inmemory->start)) {
 		struct bset *i;
-		unsigned j;
+		unsigned int j;
 
 		console_lock();
 
@@ -80,7 +80,7 @@ void bch_btree_verify(struct btree *b)
 		bch_dump_bset(&v->keys, sorted, 0);
 
 		for_each_written_bset(b, ondisk, i) {
-			unsigned block = ((void *) i - (void *) ondisk) /
+			unsigned int block = ((void *) i - (void *) ondisk) /
 				block_bytes(b->c);
 
 			printk(KERN_ERR "*** on disk block %u:\n", block);
@@ -176,7 +176,7 @@ static ssize_t bch_dump_read(struct file *file, char __user *buf,
 
 	while (size) {
 		struct keybuf_key *w;
-		unsigned bytes = min(i->bytes, size);
+		unsigned int bytes = min(i->bytes, size);
 
 		int err = copy_to_user(buf, i->buf, bytes);
 		if (err)
diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index 1d096742eb41..e96ba928eeb6 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -46,7 +46,7 @@ static bool bch_key_sort_cmp(struct btree_iter_set l,
 
 static bool __ptr_invalid(struct cache_set *c, const struct bkey *k)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		if (ptr_available(c, k, i)) {
@@ -67,7 +67,7 @@ static bool __ptr_invalid(struct cache_set *c, const struct bkey *k)
 
 static const char *bch_ptr_status(struct cache_set *c, const struct bkey *k)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		if (ptr_available(c, k, i)) {
@@ -96,7 +96,7 @@ static const char *bch_ptr_status(struct cache_set *c, const struct bkey *k)
 
 void bch_extent_to_text(char *buf, size_t size, const struct bkey *k)
 {
-	unsigned i = 0;
+	unsigned int i = 0;
 	char *out = buf, *end = buf + size;
 
 #define p(...)	(out += scnprintf(out, end - out, __VA_ARGS__))
@@ -126,7 +126,7 @@ void bch_extent_to_text(char *buf, size_t size, const struct bkey *k)
 static void bch_bkey_dump(struct btree_keys *keys, const struct bkey *k)
 {
 	struct btree *b = container_of(keys, struct btree, keys);
-	unsigned j;
+	unsigned int j;
 	char buf[80];
 
 	bch_extent_to_text(buf, sizeof(buf), k);
@@ -171,7 +171,7 @@ static bool bch_btree_ptr_invalid(struct btree_keys *bk, const struct bkey *k)
 
 static bool btree_ptr_bad_expensive(struct btree *b, const struct bkey *k)
 {
-	unsigned i;
+	unsigned int i;
 	char buf[80];
 	struct bucket *g;
 
@@ -204,7 +204,7 @@ static bool btree_ptr_bad_expensive(struct btree *b, const struct bkey *k)
 static bool bch_btree_ptr_bad(struct btree_keys *bk, const struct bkey *k)
 {
 	struct btree *b = container_of(bk, struct btree, keys);
-	unsigned i;
+	unsigned int i;
 
 	if (!bkey_cmp(k, &ZERO_KEY) ||
 	    !KEY_PTRS(k) ||
@@ -327,7 +327,7 @@ static bool bch_extent_insert_fixup(struct btree_keys *b,
 	struct cache_set *c = container_of(b, struct btree, keys)->c;
 
 	uint64_t old_offset;
-	unsigned old_size, sectors_found = 0;
+	unsigned int old_size, sectors_found = 0;
 
 	BUG_ON(!KEY_OFFSET(insert));
 	BUG_ON(!KEY_SIZE(insert));
@@ -363,7 +363,7 @@ static bool bch_extent_insert_fixup(struct btree_keys *b,
 			 * k might have been split since we inserted/found the
 			 * key we're replacing
 			 */
-			unsigned i;
+			unsigned int i;
 			uint64_t offset = KEY_START(k) -
 				KEY_START(replace_key);
 
@@ -502,7 +502,7 @@ static bool bch_extent_invalid(struct btree_keys *bk, const struct bkey *k)
 }
 
 static bool bch_extent_bad_expensive(struct btree *b, const struct bkey *k,
-				     unsigned ptr)
+				     unsigned int ptr)
 {
 	struct bucket *g = PTR_BUCKET(b->c, k, ptr);
 	char buf[80];
@@ -534,7 +534,7 @@ static bool bch_extent_bad_expensive(struct btree *b, const struct bkey *k,
 static bool bch_extent_bad(struct btree_keys *bk, const struct bkey *k)
 {
 	struct btree *b = container_of(bk, struct btree, keys);
-	unsigned i, stale;
+	unsigned int i, stale;
 
 	if (!KEY_PTRS(k) ||
 	    bch_extent_invalid(bk, k))
@@ -577,7 +577,7 @@ static uint64_t merge_chksums(struct bkey *l, struct bkey *r)
 static bool bch_extent_merge(struct btree_keys *bk, struct bkey *l, struct bkey *r)
 {
 	struct btree *b = container_of(bk, struct btree, keys);
-	unsigned i;
+	unsigned int i;
 
 	if (key_merging_disabled(b->c))
 		return false;
diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index 9612873afee2..c6b41a09f550 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -42,7 +42,7 @@ void __bch_submit_bbio(struct bio *bio, struct cache_set *c)
 }
 
 void bch_submit_bbio(struct bio *bio, struct cache_set *c,
-		     struct bkey *k, unsigned ptr)
+		     struct bkey *k, unsigned int ptr)
 {
 	struct bbio *b = container_of(bio, struct bbio, bio);
 	bch_bkey_copy_single_ptr(&b->key, k, ptr);
@@ -52,7 +52,7 @@ void bch_submit_bbio(struct bio *bio, struct cache_set *c,
 /* IO errors */
 void bch_count_backing_io_errors(struct cached_dev *dc, struct bio *bio)
 {
-	unsigned errors;
+	unsigned int errors;
 
 	WARN_ONCE(!dc, "NULL pointer of struct cached_dev");
 
@@ -75,12 +75,12 @@ void bch_count_io_errors(struct cache *ca,
 	 */
 
 	if (ca->set->error_decay) {
-		unsigned count = atomic_inc_return(&ca->io_count);
+		unsigned int count = atomic_inc_return(&ca->io_count);
 
 		while (count > ca->set->error_decay) {
-			unsigned errors;
-			unsigned old = count;
-			unsigned new = count - ca->set->error_decay;
+			unsigned int errors;
+			unsigned int old = count;
+			unsigned int new = count - ca->set->error_decay;
 
 			/*
 			 * First we subtract refresh from count; each time we
@@ -104,7 +104,7 @@ void bch_count_io_errors(struct cache *ca,
 	}
 
 	if (error) {
-		unsigned errors = atomic_add_return(1 << IO_ERROR_SHIFT,
+		unsigned int errors = atomic_add_return(1 << IO_ERROR_SHIFT,
 						    &ca->io_errors);
 		errors >>= IO_ERROR_SHIFT;
 
@@ -126,12 +126,12 @@ void bch_bbio_count_io_errors(struct cache_set *c, struct bio *bio,
 	struct cache *ca = PTR_CACHE(c, &b->key, 0);
 	int is_read = (bio_data_dir(bio) == READ ? 1 : 0);
 
-	unsigned threshold = op_is_write(bio_op(bio))
+	unsigned int threshold = op_is_write(bio_op(bio))
 		? c->congested_write_threshold_us
 		: c->congested_read_threshold_us;
 
 	if (threshold) {
-		unsigned t = local_clock_us();
+		unsigned int t = local_clock_us();
 
 		int us = t - b->submit_time_us;
 		int congested = atomic_read(&c->congested);
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 10748c626a1d..ee61062b58fc 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -32,7 +32,7 @@ static void journal_read_endio(struct bio *bio)
 }
 
 static int journal_read_bucket(struct cache *ca, struct list_head *list,
-			       unsigned bucket_index)
+			       unsigned int bucket_index)
 {
 	struct journal_device *ja = &ca->journal;
 	struct bio *bio = &ja->bio;
@@ -40,7 +40,7 @@ static int journal_read_bucket(struct cache *ca, struct list_head *list,
 	struct journal_replay *i;
 	struct jset *j, *data = ca->set->journal.w[0].data;
 	struct closure cl;
-	unsigned len, left, offset = 0;
+	unsigned int len, left, offset = 0;
 	int ret = 0;
 	sector_t bucket = bucket_to_sector(ca->set, ca->sb.d[bucket_index]);
 
@@ -50,7 +50,7 @@ static int journal_read_bucket(struct cache *ca, struct list_head *list,
 
 	while (offset < ca->sb.bucket_size) {
 reread:		left = ca->sb.bucket_size - offset;
-		len = min_t(unsigned, left, PAGE_SECTORS << JSET_BITS);
+		len = min_t(unsigned int, left, PAGE_SECTORS << JSET_BITS);
 
 		bio_reset(bio);
 		bio->bi_iter.bi_sector	= bucket + offset;
@@ -154,12 +154,12 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
 	})
 
 	struct cache *ca;
-	unsigned iter;
+	unsigned int iter;
 
 	for_each_cache(ca, c, iter) {
 		struct journal_device *ja = &ca->journal;
 		DECLARE_BITMAP(bitmap, SB_JOURNAL_BUCKETS);
-		unsigned i, l, r, m;
+		unsigned int i, l, r, m;
 		uint64_t seq;
 
 		bitmap_zero(bitmap, SB_JOURNAL_BUCKETS);
@@ -304,7 +304,7 @@ void bch_journal_mark(struct cache_set *c, struct list_head *list)
 		     k < bset_bkey_last(&i->j);
 		     k = bkey_next(k))
 			if (!__bch_extent_invalid(c, k)) {
-				unsigned j;
+				unsigned int j;
 
 				for (j = 0; j < KEY_PTRS(k); j++)
 					if (ptr_available(c, k, j))
@@ -492,7 +492,7 @@ static void journal_reclaim(struct cache_set *c)
 	struct bkey *k = &c->journal.key;
 	struct cache *ca;
 	uint64_t last_seq;
-	unsigned iter, n = 0;
+	unsigned int iter, n = 0;
 	atomic_t p __maybe_unused;
 
 	atomic_long_inc(&c->reclaim);
@@ -526,7 +526,7 @@ static void journal_reclaim(struct cache_set *c)
 
 	for_each_cache(ca, c, iter) {
 		struct journal_device *ja = &ca->journal;
-		unsigned next = (ja->cur_idx + 1) % ca->sb.njournal_buckets;
+		unsigned int next = (ja->cur_idx + 1) % ca->sb.njournal_buckets;
 
 		/* No space available on this device */
 		if (next == ja->discard_idx)
@@ -609,7 +609,7 @@ static void journal_write_unlocked(struct closure *cl)
 	struct cache *ca;
 	struct journal_write *w = c->journal.cur;
 	struct bkey *k = &c->journal.key;
-	unsigned i, sectors = set_blocks(w->data, block_bytes(c)) *
+	unsigned int i, sectors = set_blocks(w->data, block_bytes(c)) *
 		c->sb.block_size;
 
 	struct bio *bio;
@@ -705,7 +705,7 @@ static void journal_try_write(struct cache_set *c)
 }
 
 static struct journal_write *journal_wait_for_write(struct cache_set *c,
-						    unsigned nkeys)
+						    unsigned int nkeys)
 	__acquires(&c->journal.lock)
 {
 	size_t sectors;
diff --git a/drivers/md/bcache/journal.h b/drivers/md/bcache/journal.h
index b5788199188f..f0982731ae20 100644
--- a/drivers/md/bcache/journal.h
+++ b/drivers/md/bcache/journal.h
@@ -110,7 +110,7 @@ struct journal {
 	struct delayed_work	work;
 
 	/* Number of blocks free in the bucket(s) we're currently writing to */
-	unsigned		blocks_free;
+	unsigned int		blocks_free;
 	uint64_t		seq;
 	DECLARE_FIFO(atomic_t, pin);
 
@@ -131,13 +131,13 @@ struct journal_device {
 	uint64_t		seq[SB_JOURNAL_BUCKETS];
 
 	/* Journal bucket we're currently writing to */
-	unsigned		cur_idx;
+	unsigned int		cur_idx;
 
 	/* Last journal bucket that still contains an open journal entry */
-	unsigned		last_idx;
+	unsigned int		last_idx;
 
 	/* Next journal bucket to be discarded */
-	unsigned		discard_idx;
+	unsigned int		discard_idx;
 
 #define DISCARD_READY		0
 #define DISCARD_IN_FLIGHT	1
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index a24c3a95b2c0..0790d710f911 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -23,7 +23,7 @@ static bool moving_pred(struct keybuf *buf, struct bkey *k)
 {
 	struct cache_set *c = container_of(buf, struct cache_set,
 					   moving_gc_keys);
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < KEY_PTRS(k); i++)
 		if (ptr_available(c, k, i) &&
@@ -186,7 +186,7 @@ static bool bucket_cmp(struct bucket *l, struct bucket *r)
 	return GC_SECTORS_USED(l) < GC_SECTORS_USED(r);
 }
 
-static unsigned bucket_heap_top(struct cache *ca)
+static unsigned int bucket_heap_top(struct cache *ca)
 {
 	struct bucket *b;
 	return (b = heap_peek(&ca->heap)) ? GC_SECTORS_USED(b) : 0;
@@ -196,7 +196,7 @@ void bch_moving_gc(struct cache_set *c)
 {
 	struct cache *ca;
 	struct bucket *b;
-	unsigned i;
+	unsigned int i;
 
 	if (!c->copy_gc_enabled)
 		return;
@@ -204,9 +204,9 @@ void bch_moving_gc(struct cache_set *c)
 	mutex_lock(&c->bucket_lock);
 
 	for_each_cache(ca, c, i) {
-		unsigned sectors_to_move = 0;
-		unsigned reserve_sectors = ca->sb.bucket_size *
-			fifo_used(&ca->free[RESERVE_MOVINGGC]);
+		unsigned int sectors_to_move = 0;
+		unsigned int reserve_sectors = ca->sb.bucket_size *
+			     fifo_used(&ca->free[RESERVE_MOVINGGC]);
 
 		ca->heap.used = 0;
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 7dbe8b6316a0..6e1a60dd1742 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -27,7 +27,7 @@ struct kmem_cache *bch_search_cache;
 
 static void bch_data_insert_start(struct closure *);
 
-static unsigned cache_mode(struct cached_dev *dc)
+static unsigned int cache_mode(struct cached_dev *dc)
 {
 	return BDEV_CACHE_MODE(&dc->sb);
 }
@@ -98,7 +98,7 @@ static void bch_data_insert_keys(struct closure *cl)
 	closure_return(cl);
 }
 
-static int bch_keylist_realloc(struct keylist *l, unsigned u64s,
+static int bch_keylist_realloc(struct keylist *l, unsigned int u64s,
 			       struct cache_set *c)
 {
 	size_t oldsize = bch_keylist_nkeys(l);
@@ -125,7 +125,7 @@ static void bch_data_invalidate(struct closure *cl)
 		 bio_sectors(bio), (uint64_t) bio->bi_iter.bi_sector);
 
 	while (bio_sectors(bio)) {
-		unsigned sectors = min(bio_sectors(bio),
+		unsigned int sectors = min(bio_sectors(bio),
 				       1U << (KEY_SIZE_BITS - 1));
 
 		if (bch_keylist_realloc(&op->insert_keys, 2, op->c))
@@ -211,7 +211,7 @@ static void bch_data_insert_start(struct closure *cl)
 	bio->bi_opf &= ~(REQ_PREFLUSH|REQ_FUA);
 
 	do {
-		unsigned i;
+		unsigned int i;
 		struct bkey *k;
 		struct bio_set *split = &op->c->bio_split;
 
@@ -328,7 +328,7 @@ void bch_data_insert(struct closure *cl)
 
 /* Congested? */
 
-unsigned bch_get_congested(struct cache_set *c)
+unsigned int bch_get_congested(struct cache_set *c)
 {
 	int i;
 	long rand;
@@ -372,8 +372,8 @@ static struct hlist_head *iohash(struct cached_dev *dc, uint64_t k)
 static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 {
 	struct cache_set *c = dc->disk.c;
-	unsigned mode = cache_mode(dc);
-	unsigned sectors, congested = bch_get_congested(c);
+	unsigned int mode = cache_mode(dc);
+	unsigned int sectors, congested = bch_get_congested(c);
 	struct task_struct *task = current;
 	struct io *i;
 
@@ -469,11 +469,11 @@ struct search {
 	struct bio		*cache_miss;
 	struct bcache_device	*d;
 
-	unsigned		insert_bio_sectors;
-	unsigned		recoverable:1;
-	unsigned		write:1;
-	unsigned		read_dirty_data:1;
-	unsigned		cache_missed:1;
+	unsigned int		insert_bio_sectors;
+	unsigned int		recoverable:1;
+	unsigned int		write:1;
+	unsigned int		read_dirty_data:1;
+	unsigned int		cache_missed:1;
 
 	unsigned long		start_time;
 
@@ -514,15 +514,15 @@ static int cache_lookup_fn(struct btree_op *op, struct btree *b, struct bkey *k)
 	struct search *s = container_of(op, struct search, op);
 	struct bio *n, *bio = &s->bio.bio;
 	struct bkey *bio_key;
-	unsigned ptr;
+	unsigned int ptr;
 
 	if (bkey_cmp(k, &KEY(s->iop.inode, bio->bi_iter.bi_sector, 0)) <= 0)
 		return MAP_CONTINUE;
 
 	if (KEY_INODE(k) != s->iop.inode ||
 	    KEY_START(k) > bio->bi_iter.bi_sector) {
-		unsigned bio_sectors = bio_sectors(bio);
-		unsigned sectors = KEY_INODE(k) == s->iop.inode
+		unsigned int bio_sectors = bio_sectors(bio);
+		unsigned int sectors = KEY_INODE(k) == s->iop.inode
 			? min_t(uint64_t, INT_MAX,
 				KEY_START(k) - bio->bi_iter.bi_sector)
 			: INT_MAX;
@@ -856,10 +856,10 @@ static void cached_dev_read_done_bh(struct closure *cl)
 }
 
 static int cached_dev_cache_miss(struct btree *b, struct search *s,
-				 struct bio *bio, unsigned sectors)
+				 struct bio *bio, unsigned int sectors)
 {
 	int ret = MAP_CONTINUE;
-	unsigned reada = 0;
+	unsigned int reada = 0;
 	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 	struct bio *miss, *cache_bio;
 
@@ -1226,7 +1226,7 @@ static int cached_dev_congested(void *data, int bits)
 		return 1;
 
 	if (cached_dev_get(dc)) {
-		unsigned i;
+		unsigned int i;
 		struct cache *ca;
 
 		for_each_cache(ca, d->c, i) {
@@ -1253,9 +1253,9 @@ void bch_cached_dev_request_init(struct cached_dev *dc)
 /* Flash backed devices */
 
 static int flash_dev_cache_miss(struct btree *b, struct search *s,
-				struct bio *bio, unsigned sectors)
+				struct bio *bio, unsigned int sectors)
 {
-	unsigned bytes = min(sectors, bio_sectors(bio)) << 9;
+	unsigned int bytes = min(sectors, bio_sectors(bio)) << 9;
 
 	swap(bio->bi_iter.bi_size, bytes);
 	zero_fill_bio(bio);
@@ -1338,7 +1338,7 @@ static int flash_dev_congested(void *data, int bits)
 	struct bcache_device *d = data;
 	struct request_queue *q;
 	struct cache *ca;
-	unsigned i;
+	unsigned int i;
 	int ret = 0;
 
 	for_each_cache(ca, d->c, i) {
diff --git a/drivers/md/bcache/request.h b/drivers/md/bcache/request.h
index dea0886b81c1..8e8c1ce00d9d 100644
--- a/drivers/md/bcache/request.h
+++ b/drivers/md/bcache/request.h
@@ -8,7 +8,7 @@ struct data_insert_op {
 	struct bio		*bio;
 	struct workqueue_struct *wq;
 
-	unsigned		inode;
+	unsigned int		inode;
 	uint16_t		write_point;
 	uint16_t		write_prio;
 	blk_status_t		status;
@@ -17,15 +17,15 @@ struct data_insert_op {
 		uint16_t	flags;
 
 	struct {
-		unsigned	bypass:1;
-		unsigned	writeback:1;
-		unsigned	flush_journal:1;
-		unsigned	csum:1;
+		unsigned int	bypass:1;
+		unsigned int	writeback:1;
+		unsigned int	flush_journal:1;
+		unsigned int	csum:1;
 
-		unsigned	replace:1;
-		unsigned	replace_collision:1;
+		unsigned int	replace:1;
+		unsigned int	replace_collision:1;
 
-		unsigned	insert_data_done:1;
+		unsigned int	insert_data_done:1;
 	};
 	};
 
@@ -33,7 +33,7 @@ struct data_insert_op {
 	BKEY_PADDED(replace_key);
 };
 
-unsigned bch_get_congested(struct cache_set *);
+unsigned int bch_get_congested(struct cache_set *);
 void bch_data_insert(struct closure *cl);
 
 void bch_cached_dev_request_init(struct cached_dev *dc);
diff --git a/drivers/md/bcache/stats.c b/drivers/md/bcache/stats.c
index be119326297b..2331a0d5aa28 100644
--- a/drivers/md/bcache/stats.c
+++ b/drivers/md/bcache/stats.c
@@ -33,11 +33,11 @@
  * stored left shifted by 16, and scaled back in the sysfs show() function.
  */
 
-static const unsigned DAY_RESCALE		= 288;
-static const unsigned HOUR_RESCALE		= 12;
-static const unsigned FIVE_MINUTE_RESCALE	= 1;
-static const unsigned accounting_delay		= (HZ * 300) / 22;
-static const unsigned accounting_weight		= 32;
+static const unsigned int DAY_RESCALE		= 288;
+static const unsigned int HOUR_RESCALE		= 12;
+static const unsigned int FIVE_MINUTE_RESCALE	= 1;
+static const unsigned int accounting_delay	= (HZ * 300) / 22;
+static const unsigned int accounting_weight	= 32;
 
 /* sysfs reading/writing */
 
@@ -152,7 +152,7 @@ static void scale_accounting(struct timer_list *t)
 	struct cache_accounting *acc = from_timer(acc, t, timer);
 
 #define move_stat(name) do {						\
-	unsigned t = atomic_xchg(&acc->collector.name, 0);		\
+	unsigned int t = atomic_xchg(&acc->collector.name, 0);		\
 	t <<= 16;							\
 	acc->five_minute.name += t;					\
 	acc->hour.name += t;						\
diff --git a/drivers/md/bcache/stats.h b/drivers/md/bcache/stats.h
index 0b70f9de0c03..77234a89dd69 100644
--- a/drivers/md/bcache/stats.h
+++ b/drivers/md/bcache/stats.h
@@ -23,7 +23,7 @@ struct cache_stats {
 	unsigned long cache_miss_collisions;
 	unsigned long sectors_bypassed;
 
-	unsigned		rescale;
+	unsigned int		rescale;
 };
 
 struct cache_accounting {
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 55a37641aa95..4ab1b1968d9a 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -61,7 +61,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	const char *err;
 	struct cache_sb *s;
 	struct buffer_head *bh = __bread(bdev, 1, SB_SIZE);
-	unsigned i;
+	unsigned int i;
 
 	if (!bh)
 		return "IO error";
@@ -202,7 +202,7 @@ static void write_bdev_super_endio(struct bio *bio)
 static void __write_super(struct cache_sb *sb, struct bio *bio)
 {
 	struct cache_sb *out = page_address(bio_first_page_all(bio));
-	unsigned i;
+	unsigned int i;
 
 	bio->bi_iter.bi_sector	= SB_SECTOR;
 	bio->bi_iter.bi_size	= SB_SIZE;
@@ -282,7 +282,7 @@ void bcache_write_super(struct cache_set *c)
 {
 	struct closure *cl = &c->sb_write;
 	struct cache *ca;
-	unsigned i;
+	unsigned int i;
 
 	down(&c->sb_write_mutex);
 	closure_init(cl, &c->cl);
@@ -334,7 +334,7 @@ static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
 {
 	struct closure *cl = &c->uuid_write;
 	struct uuid_entry *u;
-	unsigned i;
+	unsigned int i;
 	char buf[80];
 
 	BUG_ON(!parent);
@@ -587,7 +587,7 @@ static void prio_read(struct cache *ca, uint64_t bucket)
 	struct prio_set *p = ca->disk_buckets;
 	struct bucket_disk *d = p->data + prios_per_bucket(ca), *end = d;
 	struct bucket *b;
-	unsigned bucket_nr = 0;
+	unsigned int bucket_nr = 0;
 
 	for (b = ca->buckets;
 	     b < ca->buckets + ca->sb.nbuckets;
@@ -662,7 +662,7 @@ static void bcache_device_unlink(struct bcache_device *d)
 	lockdep_assert_held(&bch_register_lock);
 
 	if (d->c && !test_and_set_bit(BCACHE_DEV_UNLINK_DONE, &d->flags)) {
-		unsigned i;
+		unsigned int i;
 		struct cache *ca;
 
 		sysfs_remove_link(&d->c->kobj, d->name);
@@ -676,7 +676,7 @@ static void bcache_device_unlink(struct bcache_device *d)
 static void bcache_device_link(struct bcache_device *d, struct cache_set *c,
 			       const char *name)
 {
-	unsigned i;
+	unsigned int i;
 	struct cache *ca;
 
 	for_each_cache(ca, d->c, i)
@@ -715,7 +715,7 @@ static void bcache_device_detach(struct bcache_device *d)
 }
 
 static void bcache_device_attach(struct bcache_device *d, struct cache_set *c,
-				 unsigned id)
+				 unsigned int id)
 {
 	d->id = id;
 	d->c = c;
@@ -762,7 +762,7 @@ static void bcache_device_free(struct bcache_device *d)
 	closure_debug_destroy(&d->cl);
 }
 
-static int bcache_device_init(struct bcache_device *d, unsigned block_size,
+static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 			      sector_t sectors)
 {
 	struct request_queue *q;
@@ -778,7 +778,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 
 	if (!d->nr_stripes || d->nr_stripes > max_stripes) {
 		pr_err("nr_stripes too large or invalid: %u (start sector beyond end of disk?)",
-			(unsigned)d->nr_stripes);
+			(unsigned int)d->nr_stripes);
 		return -ENOMEM;
 	}
 
@@ -1212,7 +1212,7 @@ static void cached_dev_flush(struct closure *cl)
 	continue_at(cl, cached_dev_free, system_wq);
 }
 
-static int cached_dev_init(struct cached_dev *dc, unsigned block_size)
+static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 {
 	int ret;
 	struct io *io;
@@ -1489,7 +1489,7 @@ static void cache_set_free(struct closure *cl)
 {
 	struct cache_set *c = container_of(cl, struct cache_set, cl);
 	struct cache *ca;
-	unsigned i;
+	unsigned int i;
 
 	if (!IS_ERR_OR_NULL(c->debug))
 		debugfs_remove(c->debug);
@@ -1532,7 +1532,7 @@ static void cache_set_flush(struct closure *cl)
 	struct cache_set *c = container_of(cl, struct cache_set, caching);
 	struct cache *ca;
 	struct btree *b;
-	unsigned i;
+	unsigned int i;
 
 	bch_cache_accounting_destroy(&c->accounting);
 
@@ -1762,7 +1762,7 @@ static void run_cache_set(struct cache_set *c)
 	struct cached_dev *dc, *t;
 	struct cache *ca;
 	struct closure cl;
-	unsigned i;
+	unsigned int i;
 
 	closure_init_stack(&cl);
 
@@ -1853,7 +1853,7 @@ static void run_cache_set(struct cache_set *c)
 		pr_notice("invalidating existing data");
 
 		for_each_cache(ca, c, i) {
-			unsigned j;
+			unsigned int j;
 
 			ca->sb.keys = clamp_t(int, ca->sb.nbuckets >> 7,
 					      2, SB_JOURNAL_BUCKETS);
@@ -1998,7 +1998,7 @@ static const char *register_cache_set(struct cache *ca)
 void bch_cache_release(struct kobject *kobj)
 {
 	struct cache *ca = container_of(kobj, struct cache, kobj);
-	unsigned i;
+	unsigned int i;
 
 	if (ca->set) {
 		BUG_ON(ca->set->cache[ca->sb.nr_this_dev] != ca);
@@ -2150,7 +2150,7 @@ static bool bch_is_open_backing(struct block_device *bdev) {
 static bool bch_is_open_cache(struct block_device *bdev) {
 	struct cache_set *c, *tc;
 	struct cache *ca;
-	unsigned i;
+	unsigned int i;
 
 	list_for_each_entry_safe(c, tc, &bch_cache_sets, list)
 		for_each_cache(ca, c, i)
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 22f8565d2bf1..0333180ba5a2 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -300,7 +300,7 @@ STORE(__cached_dev)
 		if (v < 0)
 			return v;
 
-		if ((unsigned) v != BDEV_CACHE_MODE(&dc->sb)) {
+		if ((unsigned int) v != BDEV_CACHE_MODE(&dc->sb)) {
 			SET_BDEV_CACHE_MODE(&dc->sb, v);
 			bch_write_bdev_super(dc, NULL);
 		}
@@ -526,9 +526,9 @@ static int bch_bset_print_stats(struct cache_set *c, char *buf)
 			op.stats.floats, op.stats.failed);
 }
 
-static unsigned bch_root_usage(struct cache_set *c)
+static unsigned int bch_root_usage(struct cache_set *c)
 {
-	unsigned bytes = 0;
+	unsigned int bytes = 0;
 	struct bkey *k;
 	struct btree *b;
 	struct btree_iter iter;
@@ -563,9 +563,9 @@ static size_t bch_cache_size(struct cache_set *c)
 	return ret;
 }
 
-static unsigned bch_cache_max_chain(struct cache_set *c)
+static unsigned int bch_cache_max_chain(struct cache_set *c)
 {
-	unsigned ret = 0;
+	unsigned int ret = 0;
 	struct hlist_head *h;
 
 	mutex_lock(&c->bucket_lock);
@@ -573,7 +573,7 @@ static unsigned bch_cache_max_chain(struct cache_set *c)
 	for (h = c->bucket_hash;
 	     h < c->bucket_hash + (1 << BUCKET_HASH_BITS);
 	     h++) {
-		unsigned i = 0;
+		unsigned int i = 0;
 		struct hlist_node *p;
 
 		hlist_for_each(p, h)
@@ -586,13 +586,13 @@ static unsigned bch_cache_max_chain(struct cache_set *c)
 	return ret;
 }
 
-static unsigned bch_btree_used(struct cache_set *c)
+static unsigned int bch_btree_used(struct cache_set *c)
 {
 	return div64_u64(c->gc_stats.key_bytes * 100,
 			 (c->gc_stats.nodes ?: 1) * btree_bytes(c));
 }
 
-static unsigned bch_average_key_size(struct cache_set *c)
+static unsigned int bch_average_key_size(struct cache_set *c)
 {
 	return c->gc_stats.nkeys
 		? div64_u64(c->gc_stats.data, c->gc_stats.nkeys)
@@ -989,7 +989,7 @@ STORE(__bch_cache)
 		if (v < 0)
 			return v;
 
-		if ((unsigned) v != CACHE_REPLACEMENT(&ca->sb)) {
+		if ((unsigned int) v != CACHE_REPLACEMENT(&ca->sb)) {
 			mutex_lock(&ca->set->bucket_lock);
 			SET_CACHE_REPLACEMENT(&ca->sb, v);
 			mutex_unlock(&ca->set->bucket_lock);
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index f7b0133c9d2f..484044231f21 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -347,7 +347,7 @@ static inline int bch_strtoul_h(const char *cp, long *res)
 	snprintf(buf, size,						\
 		__builtin_types_compatible_p(typeof(var), int)		\
 		     ? "%i\n" :						\
-		__builtin_types_compatible_p(typeof(var), unsigned)	\
+		__builtin_types_compatible_p(typeof(var), unsigned int)	\
 		     ? "%u\n" :						\
 		__builtin_types_compatible_p(typeof(var), long)		\
 		     ? "%li\n" :					\
@@ -379,7 +379,7 @@ struct time_stats {
 
 void bch_time_stats_update(struct time_stats *stats, uint64_t time);
 
-static inline unsigned local_clock_us(void)
+static inline unsigned int local_clock_us(void)
 {
 	return local_clock() >> 10;
 }
@@ -543,9 +543,10 @@ dup:									\
 	container_of_or_null(rb_prev(&(ptr)->member), typeof(*ptr), member)
 
 /* Does linear interpolation between powers of two */
-static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
+static inline unsigned int fract_exp_two(unsigned int x,
+					 unsigned int fract_bits)
 {
-	unsigned fract = x & ~(~0 << fract_bits);
+	unsigned int fract = x & ~(~0 << fract_bits);
 
 	x >>= fract_bits;
 	x   = 1 << x;
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 481d4cf38ac0..39ee38ffb2db 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -215,7 +215,8 @@ static void update_writeback_rate(struct work_struct *work)
 	smp_mb();
 }
 
-static unsigned writeback_delay(struct cached_dev *dc, unsigned sectors)
+static unsigned int writeback_delay(struct cached_dev *dc,
+				    unsigned int sectors)
 {
 	if (test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags) ||
 	    !dc->writeback_percent)
@@ -263,7 +264,7 @@ static void write_dirty_finish(struct closure *cl)
 	/* This is kind of a dumb way of signalling errors. */
 	if (KEY_DIRTY(&w->key)) {
 		int ret;
-		unsigned i;
+		unsigned int i;
 		struct keylist keys;
 
 		bch_keylist_init(&keys);
@@ -377,7 +378,7 @@ static void read_dirty_submit(struct closure *cl)
 
 static void read_dirty(struct cached_dev *dc)
 {
-	unsigned delay = 0;
+	unsigned int delay = 0;
 	struct keybuf_key *next, *keys[MAX_WRITEBACKS_IN_PASS], *w;
 	size_t size;
 	int nk, i;
@@ -498,11 +499,11 @@ static void read_dirty(struct cached_dev *dc)
 
 /* Scan for dirty data */
 
-void bcache_dev_sectors_dirty_add(struct cache_set *c, unsigned inode,
+void bcache_dev_sectors_dirty_add(struct cache_set *c, unsigned int inode,
 				  uint64_t offset, int nr_sectors)
 {
 	struct bcache_device *d = c->devices[inode];
-	unsigned stripe_offset, stripe, sectors_dirty;
+	unsigned int stripe_offset, stripe, sectors_dirty;
 
 	if (!d)
 		return;
@@ -514,7 +515,7 @@ void bcache_dev_sectors_dirty_add(struct cache_set *c, unsigned inode,
 	stripe_offset = offset & (d->stripe_size - 1);
 
 	while (nr_sectors) {
-		int s = min_t(unsigned, abs(nr_sectors),
+		int s = min_t(unsigned int, abs(nr_sectors),
 			      d->stripe_size - stripe_offset);
 
 		if (nr_sectors < 0)
@@ -548,7 +549,7 @@ static bool dirty_pred(struct keybuf *buf, struct bkey *k)
 static void refill_full_stripes(struct cached_dev *dc)
 {
 	struct keybuf *buf = &dc->writeback_keys;
-	unsigned start_stripe, stripe, next_stripe;
+	unsigned int start_stripe, stripe, next_stripe;
 	bool wrapped = false;
 
 	stripe = offset_to_stripe(&dc->disk, KEY_OFFSET(&buf->last_scanned));
@@ -688,7 +689,7 @@ static int bch_writeback_thread(void *arg)
 		read_dirty(dc);
 
 		if (searched_full_index) {
-			unsigned delay = dc->writeback_delay * HZ;
+			unsigned int delay = dc->writeback_delay * HZ;
 
 			while (delay &&
 			       !kthread_should_stop() &&
@@ -712,7 +713,7 @@ static int bch_writeback_thread(void *arg)
 
 struct sectors_dirty_init {
 	struct btree_op	op;
-	unsigned	inode;
+	unsigned int	inode;
 	size_t		count;
 	struct bkey	start;
 };
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index 3745d7004c47..76b691850c98 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -28,7 +28,7 @@ static inline uint64_t bcache_dev_sectors_dirty(struct bcache_device *d)
 	return ret;
 }
 
-static inline unsigned offset_to_stripe(struct bcache_device *d,
+static inline unsigned int offset_to_stripe(struct bcache_device *d,
 					uint64_t offset)
 {
 	do_div(offset, d->stripe_size);
@@ -37,9 +37,9 @@ static inline unsigned offset_to_stripe(struct bcache_device *d,
 
 static inline bool bcache_dev_stripe_dirty(struct cached_dev *dc,
 					   uint64_t offset,
-					   unsigned nr_sectors)
+					   unsigned int nr_sectors)
 {
-	unsigned stripe = offset_to_stripe(&dc->disk, offset);
+	unsigned int stripe = offset_to_stripe(&dc->disk, offset);
 
 	while (1) {
 		if (atomic_read(dc->disk.stripe_sectors_dirty + stripe))
@@ -54,9 +54,9 @@ static inline bool bcache_dev_stripe_dirty(struct cached_dev *dc,
 }
 
 static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
-				    unsigned cache_mode, bool would_skip)
+				    unsigned int cache_mode, bool would_skip)
 {
-	unsigned in_use = dc->disk.c->gc_stats.in_use;
+	unsigned int in_use = dc->disk.c->gc_stats.in_use;
 
 	if (cache_mode != CACHE_MODE_WRITEBACK ||
 	    test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags) ||
@@ -96,7 +96,7 @@ static inline void bch_writeback_add(struct cached_dev *dc)
 	}
 }
 
-void bcache_dev_sectors_dirty_add(struct cache_set *, unsigned, uint64_t, int);
+void bcache_dev_sectors_dirty_add(struct cache_set *, unsigned int, uint64_t, int);
 
 void bch_sectors_dirty_init(struct bcache_device *);
 void bch_cached_dev_writeback_init(struct cached_dev *);
diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 8d19e02d752a..6bdcb48ee8cf 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -30,10 +30,10 @@ struct bkey {
 	BITMASK(name, struct bkey, field, offset, size)
 
 #define PTR_FIELD(name, offset, size)					\
-static inline __u64 name(const struct bkey *k, unsigned i)		\
+static inline __u64 name(const struct bkey *k, unsigned int i)		\
 { return (k->ptr[i] >> offset) & ~(~0ULL << size); }			\
 									\
-static inline void SET_##name(struct bkey *k, unsigned i, __u64 v)	\
+static inline void SET_##name(struct bkey *k, unsigned int i, __u64 v)	\
 {									\
 	k->ptr[i] &= ~(~(~0ULL << size) << offset);			\
 	k->ptr[i] |= (v & ~(~0ULL << size)) << offset;			\
@@ -120,7 +120,7 @@ static inline struct bkey *bkey_next(const struct bkey *k)
 	return (struct bkey *) (d + bkey_u64s(k));
 }
 
-static inline struct bkey *bkey_idx(const struct bkey *k, unsigned nr_keys)
+static inline struct bkey *bkey_idx(const struct bkey *k, unsigned int nr_keys)
 {
 	__u64 *d = (void *) k;
 	return (struct bkey *) (d + nr_keys);
-- 
2.18.0
