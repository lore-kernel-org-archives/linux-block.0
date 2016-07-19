Return-Path: <BATV+a6fbff1bfc78a84bb09b+4713+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: simplify and cleanup bvec pool handling
Date: Tue, 19 Jul 2016 11:28:42 +0200
Message-Id: <1468920523-3189-3-git-send-email-hch@lst.de>
In-Reply-To: <1468920523-3189-1-git-send-email-hch@lst.de>
References: <1468920523-3189-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Instead of a flag and an index just make sure an index of 0 means
no need to free the bvec array.  Also move the constants related
to the bvec pools together and use a consistent naming scheme for
them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Mike Christie <mchristi@redhat.com>
---
 block/bio-integrity.c     |  9 ++++-----
 block/bio.c               | 32 ++++++++++++++++++--------------
 drivers/md/bcache/io.c    |  1 -
 include/linux/bio.h       |  2 --
 include/linux/blk_types.h | 22 ++++++++++++++--------
 5 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 15d37b1..f70cc3b 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -54,7 +54,6 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 {
 	struct bio_integrity_payload *bip;
 	struct bio_set *bs = bio->bi_pool;
-	unsigned long idx = BIO_POOL_NONE;
 	unsigned inline_vecs;
 
 	if (!bs || !bs->bio_integrity_pool) {
@@ -72,17 +71,19 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 	memset(bip, 0, sizeof(*bip));
 
 	if (nr_vecs > inline_vecs) {
+		unsigned long idx = 0;
+
 		bip->bip_vec = bvec_alloc(gfp_mask, nr_vecs, &idx,
 					  bs->bvec_integrity_pool);
 		if (!bip->bip_vec)
 			goto err;
 		bip->bip_max_vcnt = bvec_nr_vecs(idx);
+		bip->bip_slab = idx;
 	} else {
 		bip->bip_vec = bip->bip_inline_vecs;
 		bip->bip_max_vcnt = inline_vecs;
 	}
 
-	bip->bip_slab = idx;
 	bip->bip_bio = bio;
 	bio->bi_integrity = bip;
 	bio->bi_rw |= REQ_INTEGRITY;
@@ -111,9 +112,7 @@ void bio_integrity_free(struct bio *bio)
 		      bip->bip_vec->bv_offset);
 
 	if (bs && bs->bio_integrity_pool) {
-		if (bip->bip_slab != BIO_POOL_NONE)
-			bvec_free(bs->bvec_integrity_pool, bip->bip_vec,
-				  bip->bip_slab);
+		bvec_free(bs->bvec_integrity_pool, bip->bip_vec, bip->bip_slab);
 
 		mempool_free(bip, bs->bio_integrity_pool);
 	} else {
diff --git a/block/bio.c b/block/bio.c
index 848cd35..882b50a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -43,7 +43,7 @@
  * unsigned short
  */
 #define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
-static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] __read_mostly = {
+static struct biovec_slab bvec_slabs[BVEC_POOL_NR] __read_mostly = {
 	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
 };
 #undef BV
@@ -160,11 +160,15 @@ unsigned int bvec_nr_vecs(unsigned short idx)
 
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned int idx)
 {
-	BIO_BUG_ON(idx >= BIOVEC_NR_POOLS);
+	if (!idx)
+		return;
+	idx--;
+
+	BIO_BUG_ON(idx >= BVEC_POOL_NR);
 
-	if (idx == BIOVEC_MAX_IDX)
+	if (idx == BVEC_POOL_MAX) {
 		mempool_free(bv, pool);
-	else {
+	} else {
 		struct biovec_slab *bvs = bvec_slabs + idx;
 
 		kmem_cache_free(bvs->slab, bv);
@@ -206,7 +210,7 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsigned long *idx,
 	 * idx now points to the pool we want to allocate from. only the
 	 * 1-vec entry pool is mempool backed.
 	 */
-	if (*idx == BIOVEC_MAX_IDX) {
+	if (*idx == BVEC_POOL_MAX) {
 fallback:
 		bvl = mempool_alloc(pool, gfp_mask);
 	} else {
@@ -226,11 +230,12 @@ fallback:
 		 */
 		bvl = kmem_cache_alloc(bvs->slab, __gfp_mask);
 		if (unlikely(!bvl && (gfp_mask & __GFP_DIRECT_RECLAIM))) {
-			*idx = BIOVEC_MAX_IDX;
+			*idx = BVEC_POOL_MAX;
 			goto fallback;
 		}
 	}
 
+	(*idx)++;
 	return bvl;
 }
 
@@ -250,8 +255,7 @@ static void bio_free(struct bio *bio)
 	__bio_free(bio);
 
 	if (bs) {
-		if (bio_flagged(bio, BIO_OWNS_VEC))
-			bvec_free(bs->bvec_pool, bio->bi_io_vec, BIO_POOL_IDX(bio));
+		bvec_free(bs->bvec_pool, bio->bi_io_vec, BVEC_POOL_IDX(bio));
 
 		/*
 		 * If we have front padding, adjust the bio pointer before freeing
@@ -420,7 +424,6 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
 	gfp_t saved_gfp = gfp_mask;
 	unsigned front_pad;
 	unsigned inline_vecs;
-	unsigned long idx = BIO_POOL_NONE;
 	struct bio_vec *bvl = NULL;
 	struct bio *bio;
 	void *p;
@@ -480,6 +483,8 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
 	bio_init(bio);
 
 	if (nr_iovecs > inline_vecs) {
+		unsigned long idx = 0;
+
 		bvl = bvec_alloc(gfp_mask, nr_iovecs, &idx, bs->bvec_pool);
 		if (!bvl && gfp_mask != saved_gfp) {
 			punt_bios_to_rescuer(bs);
@@ -490,13 +495,12 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, int nr_iovecs, struct bio_set *bs)
 		if (unlikely(!bvl))
 			goto err_free;
 
-		bio_set_flag(bio, BIO_OWNS_VEC);
+		bio->bi_flags |= idx << BVEC_POOL_OFFSET;
 	} else if (nr_iovecs) {
 		bvl = bio->bi_inline_vecs;
 	}
 
 	bio->bi_pool = bs;
-	bio->bi_flags |= idx << BIO_POOL_OFFSET;
 	bio->bi_max_vecs = nr_iovecs;
 	bio->bi_io_vec = bvl;
 	return bio;
@@ -568,7 +572,7 @@ EXPORT_SYMBOL(bio_phys_segments);
  */
 void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 {
-	BUG_ON(bio->bi_pool && BIO_POOL_IDX(bio) != BIO_POOL_NONE);
+	BUG_ON(bio->bi_pool && BVEC_POOL_IDX(bio));
 
 	/*
 	 * most users will be overriding ->bi_bdev with a new target,
@@ -1832,7 +1836,7 @@ EXPORT_SYMBOL_GPL(bio_trim);
  */
 mempool_t *biovec_create_pool(int pool_entries)
 {
-	struct biovec_slab *bp = bvec_slabs + BIOVEC_MAX_IDX;
+	struct biovec_slab *bp = bvec_slabs + BVEC_POOL_MAX;
 
 	return mempool_create_slab_pool(pool_entries, bp->slab);
 }
@@ -2009,7 +2013,7 @@ static void __init biovec_init_slabs(void)
 {
 	int i;
 
-	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
+	for (i = 0; i < BVEC_POOL_NR; i++) {
 		int size;
 		struct biovec_slab *bvs = bvec_slabs + i;
 
diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index fd885cc..e97b0ac 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -25,7 +25,6 @@ struct bio *bch_bbio_alloc(struct cache_set *c)
 	struct bio *bio = &b->bio;
 
 	bio_init(bio);
-	bio->bi_flags		|= BIO_POOL_NONE << BIO_POOL_OFFSET;
 	bio->bi_max_vecs	 = bucket_pages(c);
 	bio->bi_io_vec		 = bio->bi_inline_vecs;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b7e1a008..583c108 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -663,8 +663,6 @@ static inline void bio_inc_remaining(struct bio *bio)
  * and the bvec_slabs[].
  */
 #define BIO_POOL_SIZE 2
-#define BIOVEC_NR_POOLS 6
-#define BIOVEC_MAX_IDX	(BIOVEC_NR_POOLS - 1)
 
 struct bio_set {
 	struct kmem_cache *bio_slab;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c92f7f8..4494b6c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -114,19 +114,25 @@ struct bio {
 
 /*
  * Flags starting here get preserved by bio_reset() - this includes
- * BIO_POOL_IDX()
+ * BVEC_POOL_IDX()
  */
 #define BIO_RESET_BITS	13
-#define BIO_OWNS_VEC	13	/* bio_free() should free bvec */
 
 /*
- * top 4 bits of bio flags indicate the pool this bio came from
+ * We support 6 different bvec pools, the last one is magic in that it
+ * is backed by a mempool.
  */
-#define BIO_POOL_BITS		(4)
-#define BIO_POOL_NONE		((1UL << BIO_POOL_BITS) - 1)
-#define BIO_POOL_OFFSET		(32 - BIO_POOL_BITS)
-#define BIO_POOL_MASK		(1UL << BIO_POOL_OFFSET)
-#define BIO_POOL_IDX(bio)	((bio)->bi_flags >> BIO_POOL_OFFSET)
+#define BVEC_POOL_NR		6
+#define BVEC_POOL_MAX		(BVEC_POOL_NR - 1)
+
+/*
+ * Top 4 bits of bio flags indicate the pool the bvecs came from.  We add
+ * 1 to the actual index so that 0 indicates that there are no bvecs to be
+ * freed.
+ */
+#define BVEC_POOL_BITS		(4)
+#define BVEC_POOL_OFFSET	(32 - BVEC_POOL_BITS)
+#define BVEC_POOL_IDX(bio)	((bio)->bi_flags >> BVEC_POOL_OFFSET)
 
 #endif /* CONFIG_BLOCK */
 
-- 
2.1.4
