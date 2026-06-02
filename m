Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256B387574
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416055; cv=none; b=Fsq8OWMCuHShrNJuWDmK8L/oH/+FzQN4gbL+KmnL2Plabd8LP/chCdJhu1pGbyv0PYYQhwJ/HjXyq+49KJsSC/jdDmnAcUMjWwHoJOc1xJ36CYJ5BLa8kvmtyK0eYeOtH2a/MRqdlFppGBZ30835WGLAbN1H45Yu+vuXCmxctVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416055; c=relaxed/simple;
	bh=3q1u+LhUGVjb/A0xjYF86CsDVh0HAUHEaqbdDsS3brM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pb9MKHMO1ZmvM8j4AbtgetCnCKTtYeQoaGO5exES+HCFkWu9UhrnMv0zeUbP58p+IqbST7kxyl+bM4w5sWzyralf0T6ocWAxL9TIv4Cr/wnpFS52c5cNZvOeftISEz5hv4BG4wX8UoICc0G+ztcbAM34+NT2lL9D7wgjuJxgYpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H2v1eMrR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H2v1eMrR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VvElFF068Ve7ZBeg/s+GYXAA/2OootEbAfLXW7NSBv4=; b=H2v1eMrR4o3a9ugvd7BrH/6Tw0
	r3SU+To9h8oh+5o8YQTgBa/xfTMb+naqzquPhwWqqQ+yUHWCutZdKD13IoLAdVeGSGV2Br+BHSkh7
	DaeIBed7+2oackQBAGW3aPABvIZ77cQ0rXiuqxYhWI7Nvkf9IyBrjGjmJ28klJjCLHKXsXm3NjwgM
	h8D9klFrEkqboBdyvYkFn1tyZD1vfKpAMcl9V31O7oUm97BMDPfSZW5F6pSxFp5m8hZq6QF788sT5
	54eqjYCTHGrzg6f8Qf2NVq4269GhUqXjRYswDyxKRavAP9GDp3AqesMArvIXm//iJWRMfs+67TuEV
	dhB8xWOw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wURXn-0000000DO2R-1baf;
	Tue, 02 Jun 2026 16:00:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: vbabka@kernel.org,
	harry@kernel.org,
	akpm@linux-foundation.org
Cc: hao.li@linux.dev,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm: simplify the mempool_alloc_bulk API
Date: Tue,  2 Jun 2026 18:00:38 +0200
Message-ID: <20260602160038.3976341-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The mempool_alloc_bulk was modelled after the alloc_pages_bulk API,
including some misunderstanding of it.

Remove checking for NULL slots in the array, as alloc_pages_bulk and
kmem_cache_alloc_bulk always fill the array from the beginning and thus
we know the offset of the first failing allocation.  This removes support
for working well with alloc_pages_bulk used to refill page arrays that
might have an entry removed from in the middle, but that is only used by
sunrpc and hopefully on it's way out.

Also remove the allocated parameter as it is redundant because the caller
can simply specific and offset into the entries array.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c |  9 +++++----
 include/linux/mempool.h     |  2 +-
 mm/mempool.c                | 27 ++++++++++-----------------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 61f595410832..ab6924fba280 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -199,8 +199,8 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 	pages += nr_segs * (PAGE_PTRS_PER_BVEC - 1);
 
 	/*
-	 * Try a bulk allocation first.  This could leave random pages in the
-	 * array unallocated, but we'll fix that up later in mempool_alloc_bulk.
+	 * Try a bulk allocation first.  This might not fill all allocated
+	 * pages, but we'll fix that up later in mempool_alloc_bulk.
 	 *
 	 * Note: alloc_pages_bulk needs the array to be zeroed, as it assumes
 	 * any non-zero slot already contains a valid allocation.
@@ -208,8 +208,9 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 	memset(pages, 0, sizeof(struct page *) * nr_segs);
 	nr_allocated = alloc_pages_bulk(GFP_KERNEL, nr_segs, pages);
 	if (nr_allocated < nr_segs)
-		mempool_alloc_bulk(blk_crypto_bounce_page_pool, (void **)pages,
-				nr_segs, nr_allocated);
+		mempool_alloc_bulk(blk_crypto_bounce_page_pool,
+				(void **)pages + nr_allocated,
+				nr_segs - nr_allocated);
 	memalloc_noio_restore(memflags);
 	*pages_ret = pages;
 	return bio;
diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index e8e440e04a06..a0fa6d43e0dc 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -66,7 +66,7 @@ void *mempool_alloc_noprof(struct mempool *pool, gfp_t gfp_mask) __malloc;
 #define mempool_alloc(...)						\
 	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
 int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
-		unsigned int count, unsigned int allocated);
+		unsigned int count);
 #define mempool_alloc_bulk(...)						\
 	alloc_hooks(mempool_alloc_bulk_noprof(__VA_ARGS__))
 
diff --git a/mm/mempool.c b/mm/mempool.c
index db23e0eef652..473a029fa31f 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -419,12 +419,8 @@ static unsigned int mempool_alloc_from_pool(struct mempool *pool, void **elems,
 	spin_lock_irqsave(&pool->lock, flags);
 	if (unlikely(pool->curr_nr < count - allocated))
 		goto fail;
-	for (i = 0; i < count; i++) {
-		if (!elems[i]) {
-			elems[i] = remove_element(pool);
-			allocated++;
-		}
-	}
+	while (allocated < count)
+		elems[allocated++] = remove_element(pool);
 	spin_unlock_irqrestore(&pool->lock, flags);
 
 	/* Paired with rmb in mempool_free(), read comment there. */
@@ -479,22 +475,21 @@ static inline gfp_t mempool_adjust_gfp(gfp_t *gfp_mask)
  * @pool:	pointer to the memory pool
  * @elems:	partially or fully populated elements array
  * @count:	number of entries in @elem that need to be allocated
- * @allocated:	number of entries in @elem already allocated
  *
- * Allocate elements for each slot in @elem that is non-%NULL. This is done by
- * first calling into the alloc_fn supplied at pool initialization time, and
- * dipping into the reserved pool when alloc_fn fails to allocate an element.
+ * Allocate @count elements into @elems.  This is done by first calling into the
+ * alloc_fn supplied at pool initialization time, and dipping into the reserved
+ * pool when alloc_fn fails to allocate an element.
  *
  * On return all @count elements in @elems will be populated.
  *
  * Return: Always 0.  If it wasn't for %$#^$ alloc tags, it would return void.
  */
 int mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
-		unsigned int count, unsigned int allocated)
+		unsigned int count)
 {
 	gfp_t gfp_mask = GFP_KERNEL;
 	gfp_t gfp_temp = mempool_adjust_gfp(&gfp_mask);
-	unsigned int i = 0;
+	unsigned int allocated = 0;
 
 	VM_WARN_ON_ONCE(count > pool->min_nr);
 	might_alloc(gfp_mask);
@@ -514,11 +509,9 @@ int mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
 	 * Try to allocate the elements using the allocation callback first as
 	 * that might succeed even when the caller's bulk allocation did not.
 	 */
-	for (i = 0; i < count; i++) {
-		if (elems[i])
-			continue;
-		elems[i] = pool->alloc(gfp_temp, pool->pool_data);
-		if (unlikely(!elems[i]))
+	while (allocated < count) {
+		elems[allocated] = pool->alloc(gfp_temp, pool->pool_data);
+		if (unlikely(!elems[allocated]))
 			goto use_pool;
 		allocated++;
 	}
-- 
2.53.0

