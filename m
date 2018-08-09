Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727237AbeHIJHr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 05:07:47 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 04/17] bcache: style fixes for lines over 80 characters
Date: Thu,  9 Aug 2018 14:43:07 +0800
Message-Id: <20180809064320.10229-5-colyli@suse.de>
In-Reply-To: <20180809064320.10229-1-colyli@suse.de>
References: <20180809064320.10229-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch fixes the lines over 80 characters into more lines, to minimize
warnings by checkpatch.pl. There are still some lines exceed 80 characters,
but it is better to be a single line and I don't change them.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/bcache.h    |  4 ++--
 drivers/md/bcache/bset.c      | 10 +++++++---
 drivers/md/bcache/bset.h      |  6 ++++--
 drivers/md/bcache/btree.c     |  5 ++++-
 drivers/md/bcache/btree.h     |  6 ++++--
 drivers/md/bcache/debug.c     |  3 ++-
 drivers/md/bcache/extents.c   |  4 +++-
 drivers/md/bcache/journal.c   |  3 ++-
 drivers/md/bcache/request.c   |  7 +++++--
 drivers/md/bcache/super.c     | 18 ++++++++++++------
 drivers/md/bcache/sysfs.c     | 11 +++++++----
 drivers/md/bcache/util.h      |  3 ++-
 drivers/md/bcache/writeback.c |  7 +++++--
 13 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 0bd505c61943..031a75a25d3e 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -614,8 +614,8 @@ struct cache_set {
 	uint16_t		min_prio;
 
 	/*
-	 * max(gen - last_gc) for all buckets. When it gets too big we have to gc
-	 * to keep gens from wrapping around.
+	 * max(gen - last_gc) for all buckets. When it gets too big we have to
+	 * gc to keep gens from wrapping around.
 	 */
 	uint8_t			need_gc;
 	struct gc_stat		gc_stats;
diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 6fd5623b2e63..19b4febe5b45 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -311,7 +311,9 @@ void bch_btree_keys_free(struct btree_keys *b)
 }
 EXPORT_SYMBOL(bch_btree_keys_free);
 
-int bch_btree_keys_alloc(struct btree_keys *b, unsigned int page_order, gfp_t gfp)
+int bch_btree_keys_alloc(struct btree_keys *b,
+			 unsigned int page_order,
+			 gfp_t gfp)
 {
 	struct bset_tree *t = b->set;
 
@@ -475,7 +477,8 @@ void inorder_test(void)
 	for (unsigned int size = 2;
 	     size < 65536000;
 	     size++) {
-		unsigned int extra = (size - rounddown_pow_of_two(size - 1)) << 1;
+		unsigned int extra =
+			(size - rounddown_pow_of_two(size - 1)) << 1;
 		unsigned int i = 1, j = rounddown_pow_of_two(size - 1);
 
 		if (!(size % 4096))
@@ -825,7 +828,8 @@ static void bch_bset_fix_lookup_table(struct btree_keys *b,
 	     k != bset_bkey_last(t->data);
 	     k = bkey_next(k))
 		if (t->size == bkey_to_cacheline(t, k)) {
-			t->prev[t->size] = bkey_to_cacheline_offset(t, t->size, k);
+			t->prev[t->size] =
+				bkey_to_cacheline_offset(t, t->size, k);
 			t->size++;
 		}
 }
diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index f5bf333aa40d..bac76aabca6d 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -246,12 +246,14 @@ static inline bool bkey_written(struct btree_keys *b, struct bkey *k)
 	return !b->last_set_unwritten || k < b->set[b->nsets].data->start;
 }
 
-static inline unsigned int bset_byte_offset(struct btree_keys *b, struct bset *i)
+static inline unsigned int bset_byte_offset(struct btree_keys *b,
+					    struct bset *i)
 {
 	return ((size_t) i) - ((size_t) b->set->data);
 }
 
-static inline unsigned int bset_sector_offset(struct btree_keys *b, struct bset *i)
+static inline unsigned int bset_sector_offset(struct btree_keys *b,
+					      struct bset *i)
 {
 	return bset_byte_offset(b, i) >> 9;
 }
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 4003f92f4d2c..afd691b4cb6e 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -436,7 +436,10 @@ static void do_btree_node_write(struct btree *b)
 
 		continue_at(cl, btree_node_write_done, NULL);
 	} else {
-		/* No problem for multipage bvec since the bio is just allocated */
+		/*
+		 * No problem for multipage bvec since the bio is
+		 * just allocated
+		 */
 		b->bio->bi_vcnt = 0;
 		bch_bio_map(b->bio, i);
 
diff --git a/drivers/md/bcache/btree.h b/drivers/md/bcache/btree.h
index c0fc06a89e49..52e7f4e2af2a 100644
--- a/drivers/md/bcache/btree.h
+++ b/drivers/md/bcache/btree.h
@@ -306,7 +306,9 @@ bool bch_keybuf_check_overlapping(struct keybuf *buf, struct bkey *start,
 				  struct bkey *end);
 void bch_keybuf_del(struct keybuf *buf, struct keybuf_key *w);
 struct keybuf_key *bch_keybuf_next(struct keybuf *buf);
-struct keybuf_key *bch_keybuf_next_rescan(struct cache_set *c, struct keybuf *buf,
-					  struct bkey *end, keybuf_pred_fn *pred);
+struct keybuf_key *bch_keybuf_next_rescan(struct cache_set *c,
+					  struct keybuf *buf,
+					  struct bkey *end,
+					  keybuf_pred_fn *pred);
 void bch_update_bucket_in_use(struct cache_set *c, struct gc_stat *stats);
 #endif
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index f0eb37a14dab..a8f70c916fdb 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -67,7 +67,8 @@ void bch_btree_verify(struct btree *b)
 	if (inmemory->keys != sorted->keys ||
 	    memcmp(inmemory->start,
 		   sorted->start,
-		   (void *) bset_bkey_last(inmemory) - (void *) inmemory->start)) {
+		   (void *) bset_bkey_last(inmemory) -
+		   (void *) inmemory->start)) {
 		struct bset *i;
 		unsigned int j;
 
diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index 8f5de61e1a90..cb3b2c613ed6 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -577,7 +577,9 @@ static uint64_t merge_chksums(struct bkey *l, struct bkey *r)
 		~((uint64_t)1 << 63);
 }
 
-static bool bch_extent_merge(struct btree_keys *bk, struct bkey *l, struct bkey *r)
+static bool bch_extent_merge(struct btree_keys *bk,
+			     struct bkey *l,
+			     struct bkey *r)
 {
 	struct btree *b = container_of(bk, struct btree, keys);
 	unsigned int i;
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 301cbb43a78f..c0cb8ff187c2 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -193,7 +193,8 @@ int bch_journal_read(struct cache_set *c, struct list_head *list)
 
 		for (l = find_first_zero_bit(bitmap, ca->sb.njournal_buckets);
 		     l < ca->sb.njournal_buckets;
-		     l = find_next_zero_bit(bitmap, ca->sb.njournal_buckets, l + 1))
+		     l = find_next_zero_bit(bitmap, ca->sb.njournal_buckets,
+					    l + 1))
 			if (read_bucket(l))
 				goto bsearch;
 
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index d15d8c5778ed..50c0de5f95b4 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -136,7 +136,9 @@ static void bch_data_invalidate(struct closure *cl)
 		bio->bi_iter.bi_size	-= sectors << 9;
 
 		bch_keylist_add(&op->insert_keys,
-				&KEY(op->inode, bio->bi_iter.bi_sector, sectors));
+				&KEY(op->inode,
+				     bio->bi_iter.bi_sector,
+				     sectors));
 	}
 
 	op->insert_data_done = true;
@@ -815,7 +817,8 @@ static void cached_dev_read_done(struct closure *cl)
 
 	if (s->iop.bio) {
 		bio_reset(s->iop.bio);
-		s->iop.bio->bi_iter.bi_sector = s->cache_miss->bi_iter.bi_sector;
+		s->iop.bio->bi_iter.bi_sector =
+			s->cache_miss->bi_iter.bi_sector;
 		bio_copy_dev(s->iop.bio, s->cache_miss);
 		s->iop.bio->bi_iter.bi_size = s->insert_bio_sectors << 9;
 		bch_bio_map(s->iop.bio, NULL);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 83b578733b3b..8cba2378734a 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -149,7 +149,8 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 			goto err;
 
 		err = "Invalid superblock: device too small";
-		if (get_capacity(bdev->bd_disk) < sb->bucket_size * sb->nbuckets)
+		if (get_capacity(bdev->bd_disk) <
+		    sb->bucket_size * sb->nbuckets)
 			goto err;
 
 		err = "Bad UUID";
@@ -600,7 +601,8 @@ static void prio_read(struct cache *ca, uint64_t bucket)
 
 			prio_io(ca, bucket, REQ_OP_READ, 0);
 
-			if (p->csum != bch_crc64(&p->magic, bucket_bytes(ca) - 8))
+			if (p->csum !=
+			    bch_crc64(&p->magic, bucket_bytes(ca) - 8))
 				pr_warn("bad csum reading priorities");
 
 			if (p->magic != pset_magic(&ca->sb))
@@ -1740,8 +1742,8 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 	if (!(c->devices = kcalloc(c->nr_uuids, sizeof(void *), GFP_KERNEL)) ||
 	    mempool_init_slab_pool(&c->search, 32, bch_search_cache) ||
 	    mempool_init_kmalloc_pool(&c->bio_meta, 2,
-				      sizeof(struct bbio) + sizeof(struct bio_vec) *
-				      bucket_pages(c)) ||
+				sizeof(struct bbio) + sizeof(struct bio_vec) *
+				bucket_pages(c)) ||
 	    mempool_init_kmalloc_pool(&c->fill_iter, 1, iter_size) ||
 	    bioset_init(&c->bio_split, 4, offsetof(struct bbio, bio),
 			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER) ||
@@ -1813,7 +1815,9 @@ static void run_cache_set(struct cache_set *c)
 			goto err;
 
 		err = "error reading btree root";
-		c->root = bch_btree_node_get(c, NULL, k, j->btree_level, true, NULL);
+		c->root = bch_btree_node_get(c, NULL, k,
+					     j->btree_level,
+					     true, NULL);
 		if (IS_ERR_OR_NULL(c->root))
 			goto err;
 
@@ -2107,7 +2111,9 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
 		goto err;
 	}
 
-	if (kobject_add(&ca->kobj, &part_to_dev(bdev->bd_part)->kobj, "bcache")) {
+	if (kobject_add(&ca->kobj,
+			&part_to_dev(bdev->bd_part)->kobj,
+			"bcache")) {
 		err = "error calling kobject_add";
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index f8d7ceadb9ba..2ed503ab9e5c 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -130,8 +130,10 @@ rw_attribute(btree_shrinker_disabled);
 rw_attribute(copy_gc_enabled);
 rw_attribute(size);
 
-static ssize_t bch_snprint_string_list(char *buf, size_t size, const char * const list[],
-			    size_t selected)
+static ssize_t bch_snprint_string_list(char *buf,
+				       size_t size,
+				       const char * const list[],
+				       size_t selected)
 {
 	char *out = buf;
 	size_t i;
@@ -334,8 +336,9 @@ STORE(__cached_dev)
 		add_uevent_var(env, "DRIVER=bcache");
 		add_uevent_var(env, "CACHED_UUID=%pU", dc->sb.uuid),
 		add_uevent_var(env, "CACHED_LABEL=%s", buf);
-		kobject_uevent_env(
-			&disk_to_dev(dc->disk.disk)->kobj, KOBJ_CHANGE, env->envp);
+		kobject_uevent_env(&disk_to_dev(dc->disk.disk)->kobj,
+				   KOBJ_CHANGE,
+				   env->envp);
 		kfree(env);
 	}
 
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index 707d7f0c034e..4e0ed19e32d3 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -402,7 +402,8 @@ do {									\
 	__print_time_stat(stats, name,					\
 			  average_duration,	duration_units);	\
 	sysfs_print(name ## _ ##max_duration ## _ ## duration_units,	\
-			div_u64((stats)->max_duration, NSEC_PER_ ## duration_units));\
+			div_u64((stats)->max_duration,			\
+				NSEC_PER_ ## duration_units));		\
 									\
 	sysfs_print(name ## _last_ ## frequency_units, (stats)->last	\
 		    ? div_s64(local_clock() - (stats)->last,		\
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 44f1b0f1f4d9..e40bf0e403e7 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -444,7 +444,8 @@ static void read_dirty(struct cached_dev *dc)
 
 			io = kzalloc(sizeof(struct dirty_io) +
 				     sizeof(struct bio_vec) *
-				     DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
+				     DIV_ROUND_UP(KEY_SIZE(&w->key),
+						  PAGE_SECTORS),
 				     GFP_KERNEL);
 			if (!io)
 				goto err;
@@ -540,7 +541,9 @@ void bcache_dev_sectors_dirty_add(struct cache_set *c, unsigned int inode,
 
 static bool dirty_pred(struct keybuf *buf, struct bkey *k)
 {
-	struct cached_dev *dc = container_of(buf, struct cached_dev, writeback_keys);
+	struct cached_dev *dc = container_of(buf,
+					     struct cached_dev,
+					     writeback_keys);
 
 	BUG_ON(KEY_INODE(k) != dc->disk.id);
 
-- 
2.18.0
