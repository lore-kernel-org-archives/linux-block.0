Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1C499F07;
	Thu,  6 Aug 2026 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054279; cv=none; b=VWC5Ubg32N08w5RvCiWOQZ6rBIXkBvXGjRgpOsnBPzJwNpWWUfDCw3+9794VSm4Rj6UGOi70Im70nifcU+yRJlNWQ64g1OsJOcFh8LsVy5U+cQGASBsAQ1GXGRIQUSFp1I7K6bKPf5kGCwF+LnYRqO71uACp4PSSdXvEPf0Qy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054279; c=relaxed/simple;
	bh=vgMOaqJzIBKKoeCRVxRjp5mWXlzNJZvkPQF0pfoZq+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRu2yKCSgibkLxfZMlT92ExxYX0lY0+YWbBU3//oQhaMGHCYJ137dLp4RYWRhBeFnegH17ZncOnQKVQNwnJgN1zR+S/GFaw+aXjneEnlV6aN8Ad7+99f5zwDcjk57DvPV8pxEkdse9Ihl0yVWQEY/CH1giO6QKTODjnHVQWXGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPUsZw4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPUsZw4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6101F00A3D;
	Thu,  6 Aug 2026 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786054277;
	bh=792LT4+1Tv2pX39OSancINytl7JfR1u67Mihl21iXxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPUsZw4yuUWpxsOGrZoU88oVspSTpuVo5cBuKXt8yvd1vNfpIgd298DSVVS1X+rIq
	 NyPee7Qhmm5nAcDVco+hSzND73pUYCziKRr5/fnM2BmiwT5sw62WpITHox98h0RggS
	 jUoUxBoO8sCAXAg1qKbtsMHaLijURdBBbw3saDL1fVv75ESo/RR1G5sroWw08FMSje
	 XLDaBW4L45kAc7moY6pGxnNoCJTwGmKLWAkHAG1KYzt/vdIr/T/dFOuLqZlcUJFBuD
	 4XP/w86pPEDL4Z1Aqr4YHuNJ9KKz4PFVgYuIRmHBqHfNrERP64PEBsRYPlVZBF752+
	 GGoSGh+pkLEBQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 2/3] mm: support fallible mempool_alloc_bulk()
Date: Thu,  6 Aug 2026 15:10:30 -0700
Message-ID: <20260806221031.79050-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806221031.79050-1-ebiggers@kernel.org>
References: <20260806221031.79050-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To fix a deadlock, blk-crypto-fallback needs to be able to make fallible
mempool_alloc_bulk() allocations.  But mempool_alloc_bulk() hardcodes
GFP_KERNEL and infinite retries, which differs from mempool_alloc()
which supports fallible allocations via its gfp_mask argument.

Therefore, add a gfp_mask argument to mempool_alloc_bulk().  As with
mempool_alloc(), the presence of __GFP_DIRECT_RECLAIM in the mask
selects between the fallible and infallible modes.

For now it just provides all-or-nothing semantics and returns a bool,
similar to kmem_cache_alloc_bulk().

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-crypto-fallback.c |  6 ++----
 include/linux/mempool.h     |  4 ++--
 mm/mempool.c                | 42 +++++++++++++++++++++++++------------
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 2a5c52ab74b4..bda913c39381 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -172,7 +172,6 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 		unsigned int nr_segs, struct page ***pages_ret)
 {
-	unsigned int memflags = memalloc_noio_save();
 	unsigned int nr_allocated;
 	struct page **pages;
 	struct bio *bio;
@@ -206,12 +205,11 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 	 * any non-zero slot already contains a valid allocation.
 	 */
 	memset(pages, 0, sizeof(struct page *) * nr_segs);
-	nr_allocated = alloc_pages_bulk(GFP_KERNEL, nr_segs, pages);
+	nr_allocated = alloc_pages_bulk(GFP_NOIO, nr_segs, pages);
 	if (nr_allocated < nr_segs)
 		mempool_alloc_bulk(blk_crypto_bounce_page_pool,
 				(void **)pages + nr_allocated,
-				nr_segs - nr_allocated);
-	memalloc_noio_restore(memflags);
+				nr_segs - nr_allocated, GFP_NOIO);
 	*pages_ret = pages;
 	return bio;
 }
diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index a0fa6d43e0dc..f7898cd1512b 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -65,8 +65,8 @@ void mempool_destroy(struct mempool *pool);
 void *mempool_alloc_noprof(struct mempool *pool, gfp_t gfp_mask) __malloc;
 #define mempool_alloc(...)						\
 	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
-int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
-		unsigned int count);
+bool mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
+		unsigned int count, gfp_t gfp_mask);
 #define mempool_alloc_bulk(...)						\
 	alloc_hooks(mempool_alloc_bulk_noprof(__VA_ARGS__))
 
diff --git a/mm/mempool.c b/mm/mempool.c
index d454bc9f39e9..d741e5f62554 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -473,25 +473,28 @@ static inline gfp_t mempool_adjust_gfp(gfp_t *gfp_mask)
 /**
  * mempool_alloc_bulk - allocate multiple elements from a memory pool
  * @pool:	pointer to the memory pool
- * @elems:	partially or fully populated elements array
- * @count:	number of entries in @elem that need to be allocated
+ * @elems:	pointer to array into which the element pointers will be stored
+ * @count:	number of elements to allocate
+ * @gfp_mask:	GFP_* flags.  %__GFP_ZERO is not supported.  If this mask
+ *		includes %__GFP_DIRECT_RECLAIM, then the allocation is retried
+ *		indefinitely until it succeeds and the return value is always
+ *		%true.  If the mask doesn't include %__GFP_DIRECT_RECLAIM, then
+ *		failure is allowed and %false can be returned.
  *
  * Allocate @count elements into @elems.  This is done by first calling into the
  * alloc_fn supplied at pool initialization time, and dipping into the reserved
- * pool when alloc_fn fails to allocate an element.
- *
- * On return all @count elements in @elems will be populated.
+ * pool to atomically allocate the remaining elements if alloc_fn fails.
  *
- * Return: Always 0.  If it wasn't for %$#^$ alloc tags, it would return void.
+ * Return: %true if the allocation succeeded, or %false if it failed.
  */
-int mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
-		unsigned int count)
+bool mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
+		unsigned int count, gfp_t gfp_mask)
 {
-	gfp_t gfp_mask = GFP_KERNEL;
 	gfp_t gfp_temp = mempool_adjust_gfp(&gfp_mask);
 	unsigned int allocated = 0;
 
 	VM_WARN_ON_ONCE(count > pool->min_nr);
+	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
 	might_alloc(gfp_mask);
 
 	/*
@@ -516,13 +519,26 @@ int mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
 		allocated++;
 	}
 
-	return 0;
+	return true;
 
 use_pool:
+	/* Try to atomically allocate the remaining elements from the pool. */
 	if (mempool_alloc_from_pool(pool, elems, count, allocated, gfp_temp))
-		return 0;
-	gfp_temp = gfp_mask;
-	goto repeat_alloc;
+		return true;
+	/* Retry if this was just the opportunistic first pass. */
+	if (gfp_temp != gfp_mask) {
+		gfp_temp = gfp_mask;
+		goto repeat_alloc;
+	}
+	/* Retry indefinitely if __GFP_DIRECT_RECLAIM is set. */
+	if (gfp_mask & __GFP_DIRECT_RECLAIM)
+		goto repeat_alloc;
+	/* On failure, roll back any successful allocations from ->alloc(). */
+	while (allocated--) {
+		pool->free(elems[allocated], pool->pool_data);
+		elems[allocated] = NULL;
+	}
+	return false;
 }
 EXPORT_SYMBOL_GPL(mempool_alloc_bulk_noprof);
 
-- 
2.55.0

