Return-Path: <BATV+1e44ea8f521110dda36c+5407+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 6/6] bcache: use bio_add_page instead of open coded bio manipulation
Date: Wed, 13 Jun 2018 15:51:58 +0200
Message-Id: <20180613135158.29477-7-hch@lst.de>
In-Reply-To: <20180613135158.29477-1-hch@lst.de>
References: <20180613135158.29477-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Let bch_bio_alloc_pages and bch_bio_map set up the bio vec information
and bi_size.  This also means no additional bch_bio_map call with
a NULL argument is needed before bch_bio_alloc_pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/btree.c     | 16 +++-----
 drivers/md/bcache/debug.c     |  7 +---
 drivers/md/bcache/journal.c   |  8 +---
 drivers/md/bcache/movinggc.c  |  4 +-
 drivers/md/bcache/request.c   |  5 +--
 drivers/md/bcache/super.c     |  8 +---
 drivers/md/bcache/util.c      | 74 +++++++++++++++--------------------
 drivers/md/bcache/util.h      |  4 +-
 drivers/md/bcache/writeback.c |  4 +-
 9 files changed, 52 insertions(+), 78 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 2a0968c04e21..0f585fa9051f 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -298,12 +298,11 @@ static void bch_btree_node_read(struct btree *b)
 	closure_init_stack(&cl);
 
 	bio = bch_bbio_alloc(b->c);
-	bio->bi_iter.bi_size = KEY_SIZE(&b->key) << 9;
 	bio->bi_end_io	= btree_node_read_endio;
 	bio->bi_private	= &cl;
 	bio->bi_opf = REQ_OP_READ | REQ_META;
 
-	bch_bio_map(bio, b->keys.set[0].data);
+	bch_bio_map(bio, b->keys.set[0].data, KEY_SIZE(&b->key) << 9);
 
 	bch_submit_bbio(bio, b->c, &b->key, 0);
 	closure_sync(&cl);
@@ -386,19 +385,19 @@ static void do_btree_node_write(struct btree *b)
 {
 	struct closure *cl = &b->io;
 	struct bset *i = btree_bset_last(b);
+	size_t size;
 	BKEY_PADDED(key) k;
 
 	i->version	= BCACHE_BSET_VERSION;
 	i->csum		= btree_csum_set(b, i);
 
+	size = roundup(set_bytes(i), block_bytes(b->c));
+
 	BUG_ON(b->bio);
 	b->bio = bch_bbio_alloc(b->c);
-
 	b->bio->bi_end_io	= btree_node_write_endio;
 	b->bio->bi_private	= cl;
-	b->bio->bi_iter.bi_size	= roundup(set_bytes(i), block_bytes(b->c));
 	b->bio->bi_opf		= REQ_OP_WRITE | REQ_META | REQ_FUA;
-	bch_bio_map(b->bio, i);
 
 	/*
 	 * If we're appending to a leaf node, we don't technically need FUA -
@@ -419,7 +418,7 @@ static void do_btree_node_write(struct btree *b)
 	SET_PTR_OFFSET(&k.key, 0, PTR_OFFSET(&k.key, 0) +
 		       bset_sector_offset(&b->keys, i));
 
-	if (!bch_bio_alloc_pages(b->bio, __GFP_NOWARN|GFP_NOWAIT)) {
+	if (!bch_bio_alloc_pages(b->bio, size, __GFP_NOWARN | GFP_NOWAIT)) {
 		int j;
 		struct bio_vec *bv;
 		void *base = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
@@ -432,10 +431,7 @@ static void do_btree_node_write(struct btree *b)
 
 		continue_at(cl, btree_node_write_done, NULL);
 	} else {
-		/* No problem for multipage bvec since the bio is just allocated */
-		b->bio->bi_vcnt = 0;
-		bch_bio_map(b->bio, i);
-
+		bch_bio_map(b->bio, i, size);
 		bch_submit_bbio(b->bio, b->c, &k.key, 0);
 
 		closure_sync(cl);
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 04d146711950..b089597fb607 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -52,9 +52,8 @@ void bch_btree_verify(struct btree *b)
 	bio = bch_bbio_alloc(b->c);
 	bio_set_dev(bio, PTR_CACHE(b->c, &b->key, 0)->bdev);
 	bio->bi_iter.bi_sector	= PTR_OFFSET(&b->key, 0);
-	bio->bi_iter.bi_size	= KEY_SIZE(&v->key) << 9;
 	bio->bi_opf		= REQ_OP_READ | REQ_META;
-	bch_bio_map(bio, sorted);
+	bch_bio_map(bio, sorted, KEY_SIZE(&v->key) << 9);
 
 	submit_bio_wait(bio);
 	bch_bbio_free(bio, b->c);
@@ -116,10 +115,8 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 	check->bi_disk = bio->bi_disk;
 	check->bi_opf = REQ_OP_READ;
 	check->bi_iter.bi_sector = bio->bi_iter.bi_sector;
-	check->bi_iter.bi_size = bio->bi_iter.bi_size;
 
-	bch_bio_map(check, NULL);
-	if (bch_bio_alloc_pages(check, GFP_NOIO))
+	if (bch_bio_alloc_pages(check, bio->bi_iter.bi_size, GFP_NOIO))
 		goto out_put;
 
 	submit_bio_wait(check);
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 18f1b5239620..44c3fc5f3b0a 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -55,12 +55,10 @@ reread:		left = ca->sb.bucket_size - offset;
 		bio_reset(bio);
 		bio->bi_iter.bi_sector	= bucket + offset;
 		bio_set_dev(bio, ca->bdev);
-		bio->bi_iter.bi_size	= len << 9;
-
 		bio->bi_end_io	= journal_read_endio;
 		bio->bi_private = &cl;
 		bio_set_op_attrs(bio, REQ_OP_READ, 0);
-		bch_bio_map(bio, data);
+		bch_bio_map(bio, data, len << 9);
 
 		closure_bio_submit(ca->set, bio, &cl);
 		closure_sync(&cl);
@@ -652,13 +650,11 @@ static void journal_write_unlocked(struct closure *cl)
 		bio_reset(bio);
 		bio->bi_iter.bi_sector	= PTR_OFFSET(k, i);
 		bio_set_dev(bio, ca->bdev);
-		bio->bi_iter.bi_size = sectors << 9;
-
 		bio->bi_end_io	= journal_write_endio;
 		bio->bi_private = w;
 		bio_set_op_attrs(bio, REQ_OP_WRITE,
 				 REQ_SYNC|REQ_META|REQ_PREFLUSH|REQ_FUA);
-		bch_bio_map(bio, w->data);
+		bch_bio_map(bio, w->data, sectors << 9);
 
 		trace_bcache_journal_write(bio);
 		bio_list_add(&list, bio);
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 890c055eb589..c8723148a2b9 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -159,8 +159,8 @@ static void read_moving(struct cache_set *c)
 		bio->bi_private = &io->cl;
 		bio->bi_end_io = read_moving_endio;
 
-		bch_bio_map(bio, NULL);
-		if (bch_bio_alloc_pages(bio, GFP_KERNEL))
+		if (bch_bio_alloc_pages(bio, KEY_SIZE(&io->w->key) << 9,
+				GFP_KERNEL))
 			goto err;
 
 		trace_bcache_gc_copy(&w->key);
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 3e699be2e79b..09165270951c 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -897,13 +897,12 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 
 	cache_bio->bi_iter.bi_sector	= miss->bi_iter.bi_sector;
 	bio_copy_dev(cache_bio, miss);
-	cache_bio->bi_iter.bi_size	= s->insert_bio_sectors << 9;
 
 	cache_bio->bi_end_io	= backing_request_endio;
 	cache_bio->bi_private	= &s->cl;
 
-	bch_bio_map(cache_bio, NULL);
-	if (bch_bio_alloc_pages(cache_bio, __GFP_NOWARN|GFP_NOIO))
+	if (bch_bio_alloc_pages(cache_bio, s->insert_bio_sectors << 9,
+			__GFP_NOWARN | GFP_NOIO))
 		goto out_put;
 
 	if (reada)
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 56692a451aeb..9a3a431e3dcc 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -343,12 +343,10 @@ static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
 		struct bio *bio = bch_bbio_alloc(c);
 
 		bio->bi_opf = REQ_SYNC | REQ_META | op_flags;
-		bio->bi_iter.bi_size = KEY_SIZE(k) << 9;
-
 		bio->bi_end_io	= uuid_endio;
 		bio->bi_private = cl;
 		bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
-		bch_bio_map(bio, c->uuids);
+		bch_bio_map(bio, c->uuids, KEY_SIZE(k) << 9);
 
 		bch_submit_bbio(bio, c, k, i);
 
@@ -503,12 +501,10 @@ static void prio_io(struct cache *ca, uint64_t bucket, int op,
 
 	bio->bi_iter.bi_sector	= bucket * ca->sb.bucket_size;
 	bio_set_dev(bio, ca->bdev);
-	bio->bi_iter.bi_size	= bucket_bytes(ca);
-
 	bio->bi_end_io	= prio_endio;
 	bio->bi_private = ca;
 	bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
-	bch_bio_map(bio, ca->disk_buckets);
+	bch_bio_map(bio, ca->disk_buckets, bucket_bytes(ca));
 
 	closure_bio_submit(ca->set, bio, &ca->prio);
 	closure_sync(cl);
diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
index fc479b026d6d..0b2f1d2bdbd6 100644
--- a/drivers/md/bcache/util.c
+++ b/drivers/md/bcache/util.c
@@ -219,65 +219,55 @@ uint64_t bch_next_delay(struct bch_ratelimit *d, uint64_t done)
 		: 0;
 }
 
-/*
- * Generally it isn't good to access .bi_io_vec and .bi_vcnt directly,
- * the preferred way is bio_add_page, but in this case, bch_bio_map()
- * supposes that the bvec table is empty, so it is safe to access
- * .bi_vcnt & .bi_io_vec in this way even after multipage bvec is
- * supported.
- */
-void bch_bio_map(struct bio *bio, void *base)
+size_t bch_bio_map(struct bio *bio, void *base, size_t size)
 {
-	size_t size = bio->bi_iter.bi_size;
-	struct bio_vec *bv = bio->bi_io_vec;
-
-	BUG_ON(!bio->bi_iter.bi_size);
-	BUG_ON(bio->bi_vcnt);
-
-	bv->bv_offset = base ? offset_in_page(base) : 0;
-	goto start;
-
-	for (; size; bio->bi_vcnt++, bv++) {
-		bv->bv_offset	= 0;
-start:		bv->bv_len	= min_t(size_t, PAGE_SIZE - bv->bv_offset,
-					size);
-		if (base) {
-			bv->bv_page = is_vmalloc_addr(base)
-				? vmalloc_to_page(base)
-				: virt_to_page(base);
-
-			base += bv->bv_len;
-		}
+	while (size > 0) {
+		unsigned offset = offset_in_page(base);
+		unsigned len = min_t(size_t, PAGE_SIZE - offset, size);
+		struct page *page = is_vmalloc_addr(base) ?
+			vmalloc_to_page(base) : virt_to_page(base);
 
-		size -= bv->bv_len;
+		if (bio_add_page(bio, page, len, offset) != len)
+			break;
+		size -= len;
 	}
+
+	return size;
 }
 
 /**
- * bch_bio_alloc_pages - allocates a single page for each bvec in a bio
+ * bch_bio_alloc_pages - allocates pages to back a bio
  * @bio: bio to allocate pages for
+ * @size: size of the allocation
  * @gfp_mask: flags for allocation
  *
- * Allocates pages up to @bio->bi_vcnt.
- *
  * Returns 0 on success, -ENOMEM on failure. On failure, any allocated pages are
  * freed.
  */
-int bch_bio_alloc_pages(struct bio *bio, gfp_t gfp_mask)
+int bch_bio_alloc_pages(struct bio *bio, size_t size, gfp_t gfp_mask)
 {
-	int i;
-	struct bio_vec *bv;
-
-	bio_for_each_segment_all(bv, bio, i) {
-		bv->bv_page = alloc_page(gfp_mask);
-		if (!bv->bv_page) {
-			while (--bv >= bio->bi_io_vec)
-				__free_page(bv->bv_page);
-			return -ENOMEM;
+	BUG_ON(bio->bi_iter.bi_size);
+	BUG_ON(bio->bi_vcnt);
+
+	while (size > 0) {
+		struct page *page = alloc_page(gfp_mask);
+		unsigned len = min_t(size_t, size, PAGE_SIZE);
+
+		if (!page)
+			goto free_pages;
+		if (WARN_ON_ONCE(bio_add_page(bio, page, len, 0) != len)) {
+			__free_page(page);
+			goto free_pages;
 		}
 	}
 
 	return 0;
+
+free_pages:
+	bio_free_pages(bio);
+	bio->bi_iter.bi_size = 0;
+	bio->bi_vcnt = 0;
+	return -ENOMEM;
 }
 
 /*
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index cced87f8eb27..85e0706d6666 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -554,8 +554,8 @@ static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
 	return x;
 }
 
-void bch_bio_map(struct bio *bio, void *base);
-int bch_bio_alloc_pages(struct bio *bio, gfp_t gfp_mask);
+size_t bch_bio_map(struct bio *bio, void *base, size_t size);
+int bch_bio_alloc_pages(struct bio *bio, size_t size, gfp_t gfp_mask);
 
 static inline sector_t bdev_sectors(struct block_device *bdev)
 {
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 0b6d07eab87c..1f10fd1fca89 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -405,8 +405,8 @@ static void read_dirty(struct cached_dev *dc)
 			io->bio.bi_private	= w;
 			io->bio.bi_end_io	= read_dirty_endio;
 
-			bch_bio_map(&io->bio, NULL);
-			if (bch_bio_alloc_pages(&io->bio, GFP_KERNEL))
+			if (bch_bio_alloc_pages(&io->bio,
+					KEY_SIZE(&w->key) << 9, GFP_KERNEL))
 				goto err_free;
 
 			trace_bcache_writeback(&w->key);
-- 
2.17.1
