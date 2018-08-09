Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727563AbeHIJHg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 05:07:36 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 02/17] bcache: style fix to add a blank line after declarations
Date: Thu,  9 Aug 2018 14:43:05 +0800
Message-Id: <20180809064320.10229-3-colyli@suse.de>
In-Reply-To: <20180809064320.10229-1-colyli@suse.de>
References: <20180809064320.10229-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c     |  3 +++
 drivers/md/bcache/bcache.h    |  1 +
 drivers/md/bcache/bset.c      |  5 ++++-
 drivers/md/bcache/btree.c     |  7 +++++++
 drivers/md/bcache/closure.c   |  1 +
 drivers/md/bcache/debug.c     |  4 ++--
 drivers/md/bcache/extents.c   |  5 ++++-
 drivers/md/bcache/io.c        |  4 +++-
 drivers/md/bcache/journal.c   |  2 ++
 drivers/md/bcache/movinggc.c  |  2 ++
 drivers/md/bcache/request.c   |  5 ++++-
 drivers/md/bcache/stats.c     |  3 +++
 drivers/md/bcache/super.c     | 13 ++++++++++++-
 drivers/md/bcache/sysfs.c     |  5 +++++
 drivers/md/bcache/util.c      |  1 +
 drivers/md/bcache/writeback.c |  1 +
 include/uapi/linux/bcache.h   |  2 ++
 17 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 89f663d22551..7a28232d868b 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -244,6 +244,7 @@ static void invalidate_buckets_random(struct cache *ca)
 
 	while (!fifo_full(&ca->free_inc)) {
 		size_t n;
+
 		get_random_bytes(&n, sizeof(n));
 
 		n %= (size_t) (ca->sb.nbuckets - ca->sb.first_bucket);
@@ -514,6 +515,7 @@ int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 			 struct bkey *k, int n, bool wait)
 {
 	int ret;
+
 	mutex_lock(&c->bucket_lock);
 	ret = __bch_bucket_alloc_set(c, reserve, k, n, wait);
 	mutex_unlock(&c->bucket_lock);
@@ -706,6 +708,7 @@ int bch_open_buckets_alloc(struct cache_set *c)
 
 	for (i = 0; i < MAX_OPEN_BUCKETS; i++) {
 		struct open_bucket *b = kzalloc(sizeof(*b), GFP_KERNEL);
+
 		if (!b)
 			return -ENOMEM;
 
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 1ebd2d9d90d5..fd74dd075951 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -783,6 +783,7 @@ static inline struct bucket *PTR_BUCKET(struct cache_set *c,
 static inline uint8_t gen_after(uint8_t a, uint8_t b)
 {
 	uint8_t r = a - b;
+
 	return r > 128U ? 0 : r;
 }
 
diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index dfda7e9efc3e..6fd5623b2e63 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -585,6 +585,7 @@ static inline unsigned int bfloat_mantissa(const struct bkey *k,
 				       struct bkey_float *f)
 {
 	const uint64_t *p = &k->low - (f->exponent >> 6);
+
 	return shrd128(p[-1], p[0], f->exponent & 63) & BKEY_MANTISSA_MASK;
 }
 
@@ -964,6 +965,7 @@ static struct bset_search_iter bset_search_tree(struct bset_tree *t,
 		 * but a branch instruction is avoided.
 		 */
 		unsigned int p = n << 4;
+
 		p &= ((int) (p - t->size)) >> 31;
 
 		prefetch(&t->tree[p]);
@@ -1114,6 +1116,7 @@ static struct bkey *__bch_btree_iter_init(struct btree_keys *b,
 					  struct bset_tree *start)
 {
 	struct bkey *ret = NULL;
+
 	iter->size = ARRAY_SIZE(iter->data);
 	iter->used = 0;
 
@@ -1329,8 +1332,8 @@ void bch_btree_sort_into(struct btree_keys *b, struct btree_keys *new,
 			 struct bset_sort_state *state)
 {
 	uint64_t start_time = local_clock();
-
 	struct btree_iter iter;
+
 	bch_btree_iter_init(b, &iter, NULL);
 
 	btree_mergesort(b, new->set->data, &iter, false, true);
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 96c39a8db895..4003f92f4d2c 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -287,6 +287,7 @@ void bch_btree_node_read_done(struct btree *b)
 static void btree_node_read_endio(struct bio *bio)
 {
 	struct closure *cl = bio->bi_private;
+
 	closure_put(cl);
 }
 
@@ -604,6 +605,7 @@ static struct btree *mca_bucket_alloc(struct cache_set *c,
 				      struct bkey *k, gfp_t gfp)
 {
 	struct btree *b = kzalloc(sizeof(struct btree), gfp);
+
 	if (!b)
 		return NULL;
 
@@ -746,6 +748,7 @@ void bch_btree_cache_free(struct cache_set *c)
 {
 	struct btree *b;
 	struct closure cl;
+
 	closure_init_stack(&cl);
 
 	if (c->shrink.list.next)
@@ -1124,6 +1127,7 @@ static struct btree *btree_node_alloc_replacement(struct btree *b,
 						  struct btree_op *op)
 {
 	struct btree *n = bch_btree_node_alloc(b->c, op, b->level, b->parent);
+
 	if (!IS_ERR_OR_NULL(n)) {
 		mutex_lock(&n->write_lock);
 		bch_btree_sort_into(&b->keys, &n->keys, &b->c->sort);
@@ -2488,6 +2492,7 @@ void bch_refill_keybuf(struct cache_set *c, struct keybuf *buf,
 
 	if (!RB_EMPTY_ROOT(&buf->keys)) {
 		struct keybuf_key *w;
+
 		w = RB_FIRST(&buf->keys, struct keybuf_key, node);
 		buf->start	= START_KEY(&w->key);
 
@@ -2519,6 +2524,7 @@ bool bch_keybuf_check_overlapping(struct keybuf *buf, struct bkey *start,
 {
 	bool ret = false;
 	struct keybuf_key *p, *w, s;
+
 	s.key = *start;
 
 	if (bkey_cmp(end, &buf->start) <= 0 ||
@@ -2545,6 +2551,7 @@ bool bch_keybuf_check_overlapping(struct keybuf *buf, struct bkey *start,
 struct keybuf_key *bch_keybuf_next(struct keybuf *buf)
 {
 	struct keybuf_key *w;
+
 	spin_lock(&buf->lock);
 
 	w = RB_FIRST(&buf->keys, struct keybuf_key, node);
diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 618253683d40..8570fc426e31 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -162,6 +162,7 @@ static struct dentry *closure_debug;
 static int debug_seq_show(struct seq_file *f, void *data)
 {
 	struct closure *cl;
+
 	spin_lock_irq(&closure_list_lock);
 
 	list_for_each_entry(cl, &closure_list, all) {
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 0caad145902b..f0eb37a14dab 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -177,8 +177,8 @@ static ssize_t bch_dump_read(struct file *file, char __user *buf,
 	while (size) {
 		struct keybuf_key *w;
 		unsigned int bytes = min(i->bytes, size);
-
 		int err = copy_to_user(buf, i->buf, bytes);
+
 		if (err)
 			return err;
 
@@ -237,8 +237,8 @@ void bch_debug_init_cache_set(struct cache_set *c)
 {
 	if (!IS_ERR_OR_NULL(bcache_debug)) {
 		char name[50];
-		snprintf(name, 50, "bcache-%pU", c->sb.set_uuid);
 
+		snprintf(name, 50, "bcache-%pU", c->sb.set_uuid);
 		c->debug = debugfs_create_file(name, 0400, bcache_debug, c,
 					       &cache_set_debug_ops);
 	}
diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index e96ba928eeb6..8f5de61e1a90 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -134,8 +134,8 @@ static void bch_bkey_dump(struct btree_keys *keys, const struct bkey *k)
 
 	for (j = 0; j < KEY_PTRS(k); j++) {
 		size_t n = PTR_BUCKET_NR(b->c, k, j);
-		printk(" bucket %zu", n);
 
+		printk(" bucket %zu", n);
 		if (n >= b->c->sb.first_bucket && n < b->c->sb.nbuckets)
 			printk(" prio %i",
 			       PTR_BUCKET(b->c, k, j)->prio);
@@ -166,6 +166,7 @@ bool __bch_btree_ptr_invalid(struct cache_set *c, const struct bkey *k)
 static bool bch_btree_ptr_invalid(struct btree_keys *bk, const struct bkey *k)
 {
 	struct btree *b = container_of(bk, struct btree, keys);
+
 	return __bch_btree_ptr_invalid(b->c, k);
 }
 
@@ -334,6 +335,7 @@ static bool bch_extent_insert_fixup(struct btree_keys *b,
 
 	while (1) {
 		struct bkey *k = bch_btree_iter_next(iter);
+
 		if (!k)
 			break;
 
@@ -498,6 +500,7 @@ bool __bch_extent_invalid(struct cache_set *c, const struct bkey *k)
 static bool bch_extent_invalid(struct btree_keys *bk, const struct bkey *k)
 {
 	struct btree *b = container_of(bk, struct btree, keys);
+
 	return __bch_extent_invalid(b->c, k);
 }
 
diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index c6b41a09f550..cfc56add799a 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -17,6 +17,7 @@
 void bch_bbio_free(struct bio *bio, struct cache_set *c)
 {
 	struct bbio *b = container_of(bio, struct bbio, bio);
+
 	mempool_free(b, &c->bio_meta);
 }
 
@@ -45,6 +46,7 @@ void bch_submit_bbio(struct bio *bio, struct cache_set *c,
 		     struct bkey *k, unsigned int ptr)
 {
 	struct bbio *b = container_of(bio, struct bbio, bio);
+
 	bch_bkey_copy_single_ptr(&b->key, k, ptr);
 	__bch_submit_bbio(bio, c);
 }
@@ -132,12 +134,12 @@ void bch_bbio_count_io_errors(struct cache_set *c, struct bio *bio,
 
 	if (threshold) {
 		unsigned int t = local_clock_us();
-
 		int us = t - b->submit_time_us;
 		int congested = atomic_read(&c->congested);
 
 		if (us > (int) threshold) {
 			int ms = us / 1024;
+
 			c->congested_last_us = t;
 
 			ms = min(ms, CONGESTED_MAX + congested);
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index ee61062b58fc..301cbb43a78f 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -28,6 +28,7 @@
 static void journal_read_endio(struct bio *bio)
 {
 	struct closure *cl = bio->bi_private;
+
 	closure_put(cl);
 }
 
@@ -614,6 +615,7 @@ static void journal_write_unlocked(struct closure *cl)
 
 	struct bio *bio;
 	struct bio_list list;
+
 	bio_list_init(&list);
 
 	if (!w->need_write) {
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 0790d710f911..7891fb512736 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -38,6 +38,7 @@ static bool moving_pred(struct keybuf *buf, struct bkey *k)
 static void moving_io_destructor(struct closure *cl)
 {
 	struct moving_io *io = container_of(cl, struct moving_io, cl);
+
 	kfree(io);
 }
 
@@ -189,6 +190,7 @@ static bool bucket_cmp(struct bucket *l, struct bucket *r)
 static unsigned int bucket_heap_top(struct cache *ca)
 {
 	struct bucket *b;
+
 	return (b = heap_peek(&ca->heap)) ? GC_SECTORS_USED(b) : 0;
 }
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 6e1a60dd1742..d15d8c5778ed 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -45,6 +45,7 @@ static void bio_csum(struct bio *bio, struct bkey *k)
 
 	bio_for_each_segment(bv, bio, iter) {
 		void *d = kmap(bv.bv_page) + bv.bv_offset;
+
 		csum = bch_crc64_update(csum, d, bv.bv_len);
 		kunmap(bv.bv_page);
 	}
@@ -526,8 +527,8 @@ static int cache_lookup_fn(struct btree_op *op, struct btree *b, struct bkey *k)
 			? min_t(uint64_t, INT_MAX,
 				KEY_START(k) - bio->bi_iter.bi_sector)
 			: INT_MAX;
-
 		int ret = s->d->cache_miss(b, s, bio, sectors);
+
 		if (ret != MAP_CONTINUE)
 			return ret;
 
@@ -623,6 +624,7 @@ static void request_endio(struct bio *bio)
 
 	if (bio->bi_status) {
 		struct search *s = container_of(cl, struct search, cl);
+
 		s->iop.status = bio->bi_status;
 		/* Only cache read errors are recoverable */
 		s->recoverable = false;
@@ -1212,6 +1214,7 @@ static int cached_dev_ioctl(struct bcache_device *d, fmode_t mode,
 			    unsigned int cmd, unsigned long arg)
 {
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
+
 	return __blkdev_driver_ioctl(dc->bdev, mode, cmd, arg);
 }
 
diff --git a/drivers/md/bcache/stats.c b/drivers/md/bcache/stats.c
index 2331a0d5aa28..894410f3f829 100644
--- a/drivers/md/bcache/stats.c
+++ b/drivers/md/bcache/stats.c
@@ -200,6 +200,7 @@ void bch_mark_cache_accounting(struct cache_set *c, struct bcache_device *d,
 			       bool hit, bool bypass)
 {
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
+
 	mark_cache_stats(&dc->accounting.collector, hit, bypass);
 	mark_cache_stats(&c->accounting.collector, hit, bypass);
 }
@@ -207,6 +208,7 @@ void bch_mark_cache_accounting(struct cache_set *c, struct bcache_device *d,
 void bch_mark_cache_readahead(struct cache_set *c, struct bcache_device *d)
 {
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
+
 	atomic_inc(&dc->accounting.collector.cache_readaheads);
 	atomic_inc(&c->accounting.collector.cache_readaheads);
 }
@@ -214,6 +216,7 @@ void bch_mark_cache_readahead(struct cache_set *c, struct bcache_device *d)
 void bch_mark_cache_miss_collision(struct cache_set *c, struct bcache_device *d)
 {
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
+
 	atomic_inc(&dc->accounting.collector.cache_miss_collisions);
 	atomic_inc(&c->accounting.collector.cache_miss_collisions);
 }
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index bd6c364ebdf8..83b578733b3b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -415,8 +415,8 @@ static int __uuid_write(struct cache_set *c)
 {
 	BKEY_PADDED(key) k;
 	struct closure cl;
-	closure_init_stack(&cl);
 
+	closure_init_stack(&cl);
 	lockdep_assert_held(&bch_register_lock);
 
 	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, true))
@@ -456,6 +456,7 @@ static struct uuid_entry *uuid_find(struct cache_set *c, const char *uuid)
 static struct uuid_entry *uuid_find_empty(struct cache_set *c)
 {
 	static const char zero_uuid[16] = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
+
 	return uuid_find(c, zero_uuid);
 }
 
@@ -619,6 +620,7 @@ static void prio_read(struct cache *ca, uint64_t bucket)
 static int open_dev(struct block_device *b, fmode_t mode)
 {
 	struct bcache_device *d = b->bd_disk->private_data;
+
 	if (test_bit(BCACHE_DEV_CLOSING, &d->flags))
 		return -ENXIO;
 
@@ -629,6 +631,7 @@ static int open_dev(struct block_device *b, fmode_t mode)
 static void release_dev(struct gendisk *b, fmode_t mode)
 {
 	struct bcache_device *d = b->private_data;
+
 	closure_put(&d->cl);
 }
 
@@ -919,6 +922,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
 	if (!d->c &&
 	    BDEV_STATE(&dc->sb) != BDEV_STATE_NONE) {
 		struct closure cl;
+
 		closure_init_stack(&cl);
 
 		SET_BDEV_STATE(&dc->sb, BDEV_STATE_STALE);
@@ -976,6 +980,7 @@ static void cached_dev_detach_finish(struct work_struct *w)
 {
 	struct cached_dev *dc = container_of(w, struct cached_dev, detach);
 	struct closure cl;
+
 	closure_init_stack(&cl);
 
 	BUG_ON(!test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags));
@@ -1103,6 +1108,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 
 	if (bch_is_zero(u->uuid, 16)) {
 		struct closure cl;
+
 		closure_init_stack(&cl);
 
 		memcpy(u->uuid, dc->sb.uuid, 16);
@@ -1320,6 +1326,7 @@ void bch_flash_dev_release(struct kobject *kobj)
 static void flash_dev_free(struct closure *cl)
 {
 	struct bcache_device *d = container_of(cl, struct bcache_device, cl);
+
 	mutex_lock(&bch_register_lock);
 	atomic_long_sub(bcache_dev_sectors_dirty(d),
 			&d->c->flash_dev_dirty_sectors);
@@ -1481,6 +1488,7 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
 void bch_cache_set_release(struct kobject *kobj)
 {
 	struct cache_set *c = container_of(kobj, struct cache_set, kobj);
+
 	kfree(c);
 	module_put(THIS_MODULE);
 }
@@ -1671,6 +1679,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 {
 	int iter_size;
 	struct cache_set *c = kzalloc(sizeof(struct cache_set), GFP_KERNEL);
+
 	if (!c)
 		return NULL;
 
@@ -2216,6 +2225,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	err = "failed to register device";
 	if (SB_IS_BDEV(sb)) {
 		struct cached_dev *dc = kzalloc(sizeof(*dc), GFP_KERNEL);
+
 		if (!dc)
 			goto err_close;
 
@@ -2224,6 +2234,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		mutex_unlock(&bch_register_lock);
 	} else {
 		struct cache *ca = kzalloc(sizeof(*ca), GFP_KERNEL);
+
 		if (!ca)
 			goto err_close;
 
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 0333180ba5a2..f8d7ceadb9ba 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -452,6 +452,7 @@ STORE(__bch_flash_dev)
 
 	if (attr == &sysfs_size) {
 		uint64_t v;
+
 		strtoi_h_or_return(buf, v);
 
 		u->sectors = v >> 9;
@@ -696,6 +697,7 @@ STORE(__bch_cache_set)
 	if (attr == &sysfs_flash_vol_create) {
 		int r;
 		uint64_t v;
+
 		strtoi_h_or_return(buf, v);
 
 		r = bch_flash_dev_create(c, v);
@@ -729,6 +731,7 @@ STORE(__bch_cache_set)
 
 	if (attr == &sysfs_prune_cache) {
 		struct shrink_control sc;
+
 		sc.gfp_mask = GFP_KERNEL;
 		sc.nr_to_scan = strtoul_or_return(buf);
 		c->shrink.scan_objects(&c->shrink, &sc);
@@ -782,12 +785,14 @@ STORE_LOCKED(bch_cache_set)
 SHOW(bch_cache_set_internal)
 {
 	struct cache_set *c = container_of(kobj, struct cache_set, internal);
+
 	return bch_cache_set_show(&c->kobj, attr, buf);
 }
 
 STORE(bch_cache_set_internal)
 {
 	struct cache_set *c = container_of(kobj, struct cache_set, internal);
+
 	return bch_cache_set_store(&c->kobj, attr, buf, size);
 }
 
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index b15256bcf0e7..18016e7bb32c 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -133,6 +133,7 @@ bool bch_is_zero(const char *p, size_t n)
 int bch_parse_uuid(const char *s, char *uuid)
 {
 	size_t i, j, x;
+
 	memset(uuid, 0, 16);
 
 	for (i = 0, j = 0;
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 39ee38ffb2db..44f1b0f1f4d9 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -250,6 +250,7 @@ static void dirty_init(struct keybuf_key *w)
 static void dirty_io_destructor(struct closure *cl)
 {
 	struct dirty_io *io = container_of(cl, struct dirty_io, cl);
+
 	kfree(io);
 }
 
diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 6bdcb48ee8cf..5d4f58e059fd 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -117,12 +117,14 @@ static inline void bkey_copy_key(struct bkey *dest, const struct bkey *src)
 static inline struct bkey *bkey_next(const struct bkey *k)
 {
 	__u64 *d = (void *) k;
+
 	return (struct bkey *) (d + bkey_u64s(k));
 }
 
 static inline struct bkey *bkey_idx(const struct bkey *k, unsigned int nr_keys)
 {
 	__u64 *d = (void *) k;
+
 	return (struct bkey *) (d + nr_keys);
 }
 /* Enough for a key with 6 pointers */
-- 
2.18.0
