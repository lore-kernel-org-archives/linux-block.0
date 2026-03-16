Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88D2F872
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677524; cv=none; b=I6pTC63jNvvyQm/GRRFdaSULSDLQO0LqHlrwZRjITx+esEk7mEiJPLCvZeB1cuci5X5v/TBFPjZti7jPDw6m7fMjwxdaJmDsnU4qtfj082HEYDCw9CZtQr21gZ4EMfHQKZWsKN+xP6JU7BO/95Xuja3nCNQL32mWok8+Zub5q08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677524; c=relaxed/simple;
	bh=/+nnhUACpCyWybUCv8scJDoKkveC5LBKTdQJ0gGi3Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3V/YtQAgxv0T1vhLhwWsU58C759aD0IkBm7oA/Su4mpagXUt2nTqE39BSIo91MU+tT8zdL10I84E8HB6mXtCl3kubqQgE8UNKDTqCiOePMKg0iZTi8hRp0DaUcw7lla2UZi7OjZ+oE4qyZGKWFFE+Voq01qogWRZeBNgQCvnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jwfb9nhE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jwfb9nhE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K6pMbu0x1wfbosuFzZMAYfrD43HtPva7618e68oqwf4=; b=Jwfb9nhEFz677iXNlSrmZYFZZU
	bme2CHFLVvY0f+hs+PItsLsBLZtNaQ5ORRfKChhJ2yzew5QMQS7bBcnMEEj9m9pucJaMaoVbjEQaY
	AmOvXukYK5NqezT1wMvNsVeHhWnBLBeY44CvsXW7FjFJe6datl2YJK2Zh65hgHxqe+aAN7MMrKTqO
	iDND+6BVKgQSC9rOu03HwX2OdNihGj1ETF72LBaTyxuK4Tns2bg+Jb+ZUo9MVZAhBKjNossAO8+6+
	4dQ7AjRrtEvSR3LORj4gj2ebUqigR8tX1bPGb7cxIsMdEWehpaHbdI8BOo0ezta9DyZManhgIKL57
	RKiinbLQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2AXy-00000004Q65-1xKA;
	Mon, 16 Mar 2026 16:12:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: split bio_alloc_bioset more clearly into a fast and slowpath
Date: Mon, 16 Mar 2026 17:11:30 +0100
Message-ID: <20260316161144.1607877-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316161144.1607877-1-hch@lst.de>
References: <20260316161144.1607877-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bio_alloc_bioset tries non-waiting slab allocations first for the bio and
bvec array, but does so in a somewhat convoluted way.

Restructure the function so that it first open codes these slab
allocations, and then falls back to the mempools with the original
gfp mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 180 ++++++++++++++++++--------------------------
 include/linux/bio.h |   3 +-
 2 files changed, 74 insertions(+), 109 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 6131ccb7284a..5982bf069cef 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -176,43 +176,12 @@ static void bvec_free(struct mempool *pool, struct bio_vec *bv,
  * Make the first allocation restricted and don't dump info on allocation
  * failures, since we'll fall back to the mempool in case of failure.
  */
-static inline gfp_t bvec_alloc_gfp(gfp_t gfp)
+static inline gfp_t try_alloc_gfp(gfp_t gfp)
 {
 	return (gfp & ~(__GFP_DIRECT_RECLAIM | __GFP_IO)) |
 		__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 }
 
-static struct bio_vec *bvec_alloc(struct mempool *pool, unsigned short *nr_vecs,
-		gfp_t gfp_mask)
-{
-	struct biovec_slab *bvs = biovec_slab(*nr_vecs);
-
-	if (WARN_ON_ONCE(!bvs))
-		return NULL;
-
-	/*
-	 * Upgrade the nr_vecs request to take full advantage of the allocation.
-	 * We also rely on this in the bvec_free path.
-	 */
-	*nr_vecs = bvs->nr_vecs;
-
-	/*
-	 * Try a slab allocation first for all smaller allocations.  If that
-	 * fails and __GFP_DIRECT_RECLAIM is set retry with the mempool.
-	 * The mempool is sized to handle up to BIO_MAX_VECS entries.
-	 */
-	if (*nr_vecs < BIO_MAX_VECS) {
-		struct bio_vec *bvl;
-
-		bvl = kmem_cache_alloc(bvs->slab, bvec_alloc_gfp(gfp_mask));
-		if (likely(bvl) || !(gfp_mask & __GFP_DIRECT_RECLAIM))
-			return bvl;
-		*nr_vecs = BIO_MAX_VECS;
-	}
-
-	return mempool_alloc(pool, gfp_mask);
-}
-
 void bio_uninit(struct bio *bio)
 {
 #ifdef CONFIG_BLK_CGROUP
@@ -433,13 +402,31 @@ static void bio_alloc_rescue(struct work_struct *work)
 	}
 }
 
+/*
+ * submit_bio_noacct() converts recursion to iteration; this means if we're
+ * running beneath it, any bios we allocate and submit will not be submitted
+ * (and thus freed) until after we return.
+ *
+ * This exposes us to a potential deadlock if we allocate multiple bios from the
+ * same bio_set while running underneath submit_bio_noacct().  If we were to
+ * allocate multiple bios (say a stacking block driver that was splitting bios),
+ * we would deadlock if we exhausted the mempool's reserve.
+ *
+ * We solve this, and guarantee forward progress by punting the bios on
+ * current->bio_list to a per bio_set rescuer workqueue before blocking to wait
+ * for elements being returned to the mempool.
+ */
 static void punt_bios_to_rescuer(struct bio_set *bs)
 {
 	struct bio_list punt, nopunt;
 	struct bio *bio;
 
-	if (WARN_ON_ONCE(!bs->rescue_workqueue))
+	if (!current->bio_list || !bs->rescue_workqueue)
 		return;
+	if (bio_list_empty(&current->bio_list[0]) &&
+	    bio_list_empty(&current->bio_list[1]))
+		return;
+
 	/*
 	 * In order to guarantee forward progress we must punt only bios that
 	 * were allocated from this bio_set; otherwise, if there was a bio on
@@ -486,9 +473,7 @@ static void bio_alloc_irq_cache_splice(struct bio_alloc_cache *cache)
 	local_irq_restore(flags);
 }
 
-static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
-		unsigned short nr_vecs, blk_opf_t opf, gfp_t gfp,
-		struct bio_set *bs)
+static struct bio *bio_alloc_percpu_cache(struct bio_set *bs)
 {
 	struct bio_alloc_cache *cache;
 	struct bio *bio;
@@ -506,11 +491,6 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
 	cache->free_list = bio->bi_next;
 	cache->nr--;
 	put_cpu();
-
-	if (nr_vecs)
-		bio_init_inline(bio, bdev, nr_vecs, opf);
-	else
-		bio_init(bio, bdev, NULL, nr_vecs, opf);
 	bio->bi_pool = bs;
 	return bio;
 }
@@ -520,7 +500,7 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
  * @bdev:	block device to allocate the bio for (can be %NULL)
  * @nr_vecs:	number of bvecs to pre-allocate
  * @opf:	operation and flags for bio
- * @gfp_mask:   the GFP_* mask given to the slab allocator
+ * @gfp:	the GFP_* mask given to the slab allocator
  * @bs:		the bio_set to allocate from.
  *
  * Allocate a bio from the mempools in @bs.
@@ -550,91 +530,77 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
  * Returns: Pointer to new bio on success, NULL on failure.
  */
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
-			     blk_opf_t opf, gfp_t gfp_mask,
-			     struct bio_set *bs)
+			     blk_opf_t opf, gfp_t gfp, struct bio_set *bs)
 {
-	gfp_t saved_gfp = gfp_mask;
-	struct bio *bio;
+	struct bio_vec *bvecs = NULL;
+	struct bio *bio = NULL;
+	gfp_t saved_gfp = gfp;
 	void *p;
 
 	/* should not use nobvec bioset for nr_vecs > 0 */
 	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
 		return NULL;
 
+	gfp = try_alloc_gfp(gfp);
 	if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
-		opf |= REQ_ALLOC_CACHE;
-		bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
-					     gfp_mask, bs);
-		if (bio)
-			return bio;
 		/*
-		 * No cached bio available, bio returned below marked with
-		 * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
+		 * Set REQ_ALLOC_CACHE even if no cached bio is available to
+		 * return the allocated bio to the percpu cache when done.
 		 */
-	} else
+		opf |= REQ_ALLOC_CACHE;
+		bio = bio_alloc_percpu_cache(bs);
+	} else {
 		opf &= ~REQ_ALLOC_CACHE;
-
-	/*
-	 * submit_bio_noacct() converts recursion to iteration; this means if
-	 * we're running beneath it, any bios we allocate and submit will not be
-	 * submitted (and thus freed) until after we return.
-	 *
-	 * This exposes us to a potential deadlock if we allocate multiple bios
-	 * from the same bio_set() while running underneath submit_bio_noacct().
-	 * If we were to allocate multiple bios (say a stacking block driver
-	 * that was splitting bios), we would deadlock if we exhausted the
-	 * mempool's reserve.
-	 *
-	 * We solve this, and guarantee forward progress, with a rescuer
-	 * workqueue per bio_set. If we go to allocate and there are bios on
-	 * current->bio_list, we first try the allocation without
-	 * __GFP_DIRECT_RECLAIM; if that fails, we punt those bios we would be
-	 * blocking to the rescuer workqueue before we retry with the original
-	 * gfp_flags.
-	 */
-	if (current->bio_list &&
-	    (!bio_list_empty(&current->bio_list[0]) ||
-	     !bio_list_empty(&current->bio_list[1])) &&
-	    bs->rescue_workqueue)
-		gfp_mask &= ~__GFP_DIRECT_RECLAIM;
-
-	p = mempool_alloc(&bs->bio_pool, gfp_mask);
-	if (!p && gfp_mask != saved_gfp) {
-		punt_bios_to_rescuer(bs);
-		gfp_mask = saved_gfp;
-		p = mempool_alloc(&bs->bio_pool, gfp_mask);
+		p = kmem_cache_alloc(bs->bio_slab, gfp);
+		if (p)
+			bio = p + bs->front_pad;
 	}
-	if (unlikely(!p))
-		return NULL;
-	if (!mempool_is_saturated(&bs->bio_pool))
-		opf &= ~REQ_ALLOC_CACHE;
 
-	bio = p + bs->front_pad;
-	if (nr_vecs > BIO_INLINE_VECS) {
-		struct bio_vec *bvl = NULL;
+	if (bio && nr_vecs > BIO_INLINE_VECS) {
+		struct biovec_slab *bvs = biovec_slab(nr_vecs);
 
-		bvl = bvec_alloc(&bs->bvec_pool, &nr_vecs, gfp_mask);
-		if (!bvl && gfp_mask != saved_gfp) {
-			punt_bios_to_rescuer(bs);
-			gfp_mask = saved_gfp;
-			bvl = bvec_alloc(&bs->bvec_pool, &nr_vecs, gfp_mask);
+		/*
+		 * Upgrade nr_vecs to take full advantage of the allocation.
+		 * We also rely on this in bvec_free().
+		 */
+		nr_vecs = bvs->nr_vecs;
+		bvecs = kmem_cache_alloc(bvs->slab, gfp);
+		if (unlikely(!bvecs)) {
+			kmem_cache_free(bs->bio_slab, p);
+			bio = NULL;
 		}
-		if (unlikely(!bvl))
-			goto err_free;
+	}
 
-		bio_init(bio, bdev, bvl, nr_vecs, opf);
-	} else if (nr_vecs) {
-		bio_init_inline(bio, bdev, BIO_INLINE_VECS, opf);
-	} else {
-		bio_init(bio, bdev, NULL, 0, opf);
+	if (unlikely(!bio)) {
+		/*
+		 * Give up if we are not allow to sleep as non-blocking mempool
+		 * allocations just go back to the slab allocation.
+		 */
+		if (!(saved_gfp & __GFP_DIRECT_RECLAIM))
+			return NULL;
+
+		punt_bios_to_rescuer(bs);
+
+		/*
+		 * Don't rob the mempools by returning to the per-CPU cache if
+		 * we're tight on memory.
+		 */
+		opf &= ~REQ_ALLOC_CACHE;
+
+		p = mempool_alloc(&bs->bio_pool, gfp);
+		bio = p + bs->front_pad;
+		if (nr_vecs > BIO_INLINE_VECS) {
+			nr_vecs = BIO_MAX_VECS;
+			bvecs = mempool_alloc(&bs->bvec_pool, gfp);
+		}
 	}
 
+	if (nr_vecs && nr_vecs <= BIO_INLINE_VECS)
+		bio_init_inline(bio, bdev, nr_vecs, opf);
+	else
+		bio_init(bio, bdev, bvecs, nr_vecs, opf);
 	bio->bi_pool = bs;
 	return bio;
-
-err_free:
-	mempool_free(p, &bs->bio_pool);
-	return NULL;
 }
 EXPORT_SYMBOL(bio_alloc_bioset);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9693a0d6fefe..984844d2870b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -350,8 +350,7 @@ extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
 
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
-			     blk_opf_t opf, gfp_t gfp_mask,
-			     struct bio_set *bs);
+			     blk_opf_t opf, gfp_t gfp, struct bio_set *bs);
 struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask);
 extern void bio_put(struct bio *);
 
-- 
2.47.3

