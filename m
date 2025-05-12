Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FC1411DE
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747023843; cv=none; b=qupogcLYcdE5KSJQ75dcpl+fvvNmzXrASA+6JkWs2BrfW68pnpKKE42vhUn7lfzAUR7YA7TMO/O6adK7gCO+1RjO5DAir7LfPgJbOvTrK1HUZ6Q76VI0kXRt5V/CjpB2W3Ojk7mJLW58TXZvjriVUnkiTcKG5gRmZO0awhjFalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747023843; c=relaxed/simple;
	bh=W+/6UdVOLq5chB8F3t3wQ38FJpbLf1ZalqjLhfFx0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d54MOTSW7xwWrwV2C16dbScSNfXbmdXPeLrVf8lIwI0pMuWQAdckp8oapVEj+QlO+D/Z0XOfT9qax2M6uf/FPzGV9547pZG/ggythnFB4etR6FdvUsqUBuJAJ0cKn18PLi184720Fbvx9QCCKOTIfAPPTEoqktJI6Bd4UoS6rOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cZ6jncVe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZ6jncVe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mLk7bg1b4/B/JUcC+H0z9idnXCr3EM3pXiGPR3AHPfQ=; b=cZ6jncVetUu7zY/HQAlnAl9rp8
	ZqwTgn5sRnRImzRumTeoHkbFQ7E1DcRTU+k7ZfQDctm6JOP+hsgfufbaMWUeIubNcVbXgp3/X1eyS
	mANTWjVOJTWe/rWyKY/8FVcweoy4WNR2q9j44Cxo5jC67W5oHjtVONQ1YJ28MQ65SyAiy0sDHRSRD
	6EqwxJFSDoWpyYiLUnp8QF9stODT9zw3knj2nSgdYtHpOitbSETBKjgtqdyaYqv1bsZavGdde/7L0
	i+NXUv0c+zLMAPEFvXqu8B8EaoyBrQXBAyv36dsClAVqd1wVzH7T5fmu+89lEo1+mKoPJlN9mZvSY
	7QbE1ARg==;
Received: from 2a02-8389-2341-5b80-6dec-1ead-dc3c-1d26.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6dec:1ead:dc3c:1d26] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEKhs-00000008KiU-16DU;
	Mon, 12 May 2025 04:24:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: remove the same_page output argument to bvec_try_merge_page
Date: Mon, 12 May 2025 06:23:54 +0200
Message-ID: <20250512042354.514329-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bvec_try_merge_page currently returns if the added page fragment is
within the same page as the last page in the last current bio_vec.

This information is used by __bio_iov_iter_get_pages so that we always
have a single folio pin per page even when the page is split over
multiple __bio_iov_iter_get_pages calls.

Threading this through the entire lowlevel add page to bio logic is
annoying and inefficient and leads to less code sharing than otherwise
possible.  Instead add code to __bio_iov_iter_get_pages that checks if
the bio_vecs did not change and thus a merge into the last segment must
have happened, and if there is an offset into the page for the currently
added fragment, because if yes we must have already had a previous
fragment of the same page in the last bio_vec.  While this is still a bit
ugly, it keeps the logic in the one place that needs it and allows for
more code sharing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c |  4 +---
 block/bio.c           | 55 ++++++++++++++++++-------------------------
 block/blk.h           |  3 +--
 3 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 43ef6bd06c85..cb94e9be26dc 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -127,10 +127,8 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 	if (bip->bip_vcnt > 0) {
 		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
-		bool same_page = false;
 
-		if (bvec_try_merge_hw_page(q, bv, page, len, offset,
-					   &same_page)) {
+		if (bvec_try_merge_hw_page(q, bv, page, len, offset)) {
 			bip->bip_iter.bi_size += len;
 			return len;
 		}
diff --git a/block/bio.c b/block/bio.c
index 988f5de3c02c..56ae38ce006e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -920,7 +920,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 }
 
 static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
-		unsigned int len, unsigned int off, bool *same_page)
+		unsigned int len, unsigned int off)
 {
 	size_t bv_end = bv->bv_offset + bv->bv_len;
 	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) + bv_end - 1;
@@ -933,9 +933,7 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
 	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
 		return false;
 
-	*same_page = ((vec_end_addr & PAGE_MASK) == ((page_addr + off) &
-		     PAGE_MASK));
-	if (!*same_page) {
+	if ((vec_end_addr & PAGE_MASK) != ((page_addr + off) & PAGE_MASK)) {
 		if (IS_ENABLED(CONFIG_KMSAN))
 			return false;
 		if (bv->bv_page + bv_end / PAGE_SIZE != page + off / PAGE_SIZE)
@@ -955,8 +953,7 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
  * helpers to split.  Hopefully this will go away soon.
  */
 bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
-		struct page *page, unsigned len, unsigned offset,
-		bool *same_page)
+		struct page *page, unsigned len, unsigned offset)
 {
 	unsigned long mask = queue_segment_boundary(q);
 	phys_addr_t addr1 = bvec_phys(bv);
@@ -966,7 +963,7 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		return false;
 	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
-	return bvec_try_merge_page(bv, page, len, offset, same_page);
+	return bvec_try_merge_page(bv, page, len, offset);
 }
 
 /**
@@ -1020,8 +1017,6 @@ EXPORT_SYMBOL_GPL(bio_add_virt_nofail);
 int bio_add_page(struct bio *bio, struct page *page,
 		 unsigned int len, unsigned int offset)
 {
-	bool same_page = false;
-
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 	if (bio->bi_iter.bi_size > UINT_MAX - len)
@@ -1029,7 +1024,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0 &&
 	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				page, len, offset, &same_page)) {
+				page, len, offset)) {
 		bio->bi_iter.bi_size += len;
 		return len;
 	}
@@ -1161,27 +1156,6 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_add_folio(struct bio *bio, struct folio *folio, size_t len,
-			     size_t offset)
-{
-	bool same_page = false;
-
-	if (WARN_ON_ONCE(bio->bi_iter.bi_size > UINT_MAX - len))
-		return -EIO;
-
-	if (bio->bi_vcnt > 0 &&
-	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
-				folio_page(folio, 0), len, offset,
-				&same_page)) {
-		bio->bi_iter.bi_size += len;
-		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
-			unpin_user_folio(folio, 1);
-		return 0;
-	}
-	bio_add_folio_nofail(bio, folio, len, offset);
-	return 0;
-}
-
 static unsigned int get_contig_folio_len(unsigned int *num_pages,
 					 struct page **pages, unsigned int i,
 					 struct folio *folio, size_t left,
@@ -1276,6 +1250,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
 		struct page *page = pages[i];
 		struct folio *folio = page_folio(page);
+		unsigned int old_vcnt = bio->bi_vcnt;
 
 		folio_offset = ((size_t)folio_page_idx(folio, page) <<
 			       PAGE_SHIFT) + offset;
@@ -1288,7 +1263,23 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			len = get_contig_folio_len(&num_pages, pages, i,
 						   folio, left, offset);
 
-		bio_iov_add_folio(bio, folio, len, folio_offset);
+		if (!bio_add_folio(bio, folio, len, folio_offset)) {
+			WARN_ON_ONCE(1);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (bio_flagged(bio, BIO_PAGE_PINNED)) {
+			/*
+			 * We're adding another fragment of a page that already
+			 * was part of the last segment.  Undo our pin as the
+			 * page was pinned when an earlier fragment of it was
+			 * added to the bio and __bio_release_pages expects a
+			 * single pin per page.
+			 */
+			if (offset && bio->bi_vcnt == old_vcnt)
+				unpin_user_folio(folio, 1);
+		}
 		offset = 0;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 665b3d1fb504..eb0fccbfdea6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -103,8 +103,7 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs);
 
 bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
-		struct page *page, unsigned len, unsigned offset,
-		bool *same_page);
+		struct page *page, unsigned len, unsigned offset);
 
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
-- 
2.47.2

