Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC134EF0F;
	Tue, 14 Jul 2026 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034818; cv=none; b=RM7EeR/Noaj832DVFeXtqW03N/KuBFzeclzXDJtqsbgj8omfwXkiUeziK6MHIFR5rUcvAkIGmGVprj6W/zRmntrZszMz3tXjKyH1UPk+oucl6+ZGV6dPzWCd0UMtqeCjReFoa9EJxHUsFoUO/MquAdQKXqigfWYVu+sH3oKAYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034818; c=relaxed/simple;
	bh=VDM7Yz6M/5OwWoOyo968x3j+RmIuRohUBRzdDkVRUVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngfZqJZXmoYUJdeDJxsiYUeldS6Gg9vKprGwb141gooE0PMw4GZmwC6jZfhcFH1Auq2jj5uLJ4aUQriOdDXeEhd6gEasWT6sAEm21/p84wMcybYgh9SSzRndr980OAojNtL3e+WSRBFsOCtllaLV4/sE+gUM/wjBcI9Tba8wTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=18bQFEmW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="18bQFEmW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=E3h7sLBceeS+ZpAHSYAvoPpaXEMxqZpIeHk0Hn8+iII=; b=18bQFEmWV3+sYIVRQQ4thMKZVZ
	uP7+UhhymQ4iv8yOOk4o7rdok12YebOv3SUlbIkJIpzk4r8sEwLabkQGayg2mTLms7hHUStvDx1z1
	v7aBzZRc5upAbnuzgRVSUgqWDcvlNWoq+6EvSaolnu1gbYh0YPG+Wxbr2LZmp/iRCNG+vUGJOwoH/
	hFrvCeUG00cn9xdiQY0yELbcZfJiv9rpU2j61i0mMYiOdDIjibIqCeOvkYsYu2Kd8rfm0O7f88x/j
	E4eozOkaRP3ygCgKjxPe13F8Nd8kZD6e9MU6wrbRNwl/kBakXnB530ysv/g9U3Nf5NBebBk+SN1be
	oNOPUXHQ==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjcx4-0000000C7l2-3Dgy;
	Tue, 14 Jul 2026 13:13:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] block,iov_iter: move bio_iov_iter_align_down into iov_iter_extract_bvecs
Date: Tue, 14 Jul 2026 15:12:00 +0200
Message-ID: <20260714131318.2670042-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714131318.2670042-1-hch@lst.de>
References: <20260714131318.2670042-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a len_align_mask argument to iov_iter_extract_bvecs() and align the
extracted length in this core routine.   This ensures that the returned
bvec array is directly usable by the caller, and thus fixes two bugs in
bio_iov_iter_bounce_read() where the bounce bvec size is not updated to
the adjusted value, and the bounce folio is not freed when we can't form
a valid bio at all.

Fixes: e7b8b3c5b2a6 ("block: align down bounces bios")
Reported-by: Neptune <z1281552865@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 44 +++++---------------------------------------
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7f707ecf328e..659678cd0843 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1185,41 +1185,6 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-/*
- * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
- * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
- * for the next iteration.
- */
-static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
-			    unsigned len_align_mask)
-{
-	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
-
-	if (!nbytes)
-		return 0;
-
-	iov_iter_revert(iter, nbytes);
-	bio->bi_iter.bi_size -= nbytes;
-	do {
-		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-		if (nbytes < bv->bv_len) {
-			bv->bv_len -= nbytes;
-			break;
-		}
-
-		if (bio_flagged(bio, BIO_PAGE_PINNED))
-			unpin_user_page(bv->bv_page);
-
-		bio->bi_vcnt--;
-		nbytes -= bv->bv_len;
-	} while (nbytes);
-
-	if (!bio->bi_vcnt)
-		return -EFAULT;
-	return 0;
-}
-
 #ifdef CONFIG_DEBUG_KERNEL
 static inline bool bio_iov_bvec_aligned(const struct bio *bio,
 					unsigned mem_align_mask)
@@ -1305,7 +1270,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
 				BIO_MAX_SIZE - bio->bi_iter.bi_size,
 				&bio->bi_vcnt, bio->bi_max_vecs,
-				mem_align_mask, flags);
+				mem_align_mask, len_align_mask, flags);
 		if (ret <= 0) {
 			/*
 			 * A misaligned vector fails the whole I/O.  Release any
@@ -1326,7 +1291,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
 		bio->bi_opf |= REQ_NOMERGE;
-	return bio_iov_iter_align_down(bio, iter, len_align_mask);
+	return 0;
 }
 
 static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
@@ -1432,7 +1397,8 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
 		ssize_t ret;
 
 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec + 1, len,
-				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0, 0);
+				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0,
+				minsize - 1, 0);
 		if (ret <= 0) {
 			if (!bio->bi_vcnt) {
 				folio_put(folio);
@@ -1453,7 +1419,7 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
 	bvec_set_folio(&bio->bi_io_vec[0], folio, bio->bi_iter.bi_size, 0);
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+	return 0;
 }
 
 /**
diff --git a/include/linux/uio.h b/include/linux/uio.h
index fe2e985d74d2..fb1a161fa765 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -399,6 +399,7 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
 ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		size_t max_size, unsigned short *nr_vecs,
 		unsigned short max_vecs, unsigned mem_align_mask,
+		unsigned len_align_mask,
 		iov_iter_extraction_t extraction_flags);
 
 /**
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 34a52e9ba9e1..bb6084672971 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1897,6 +1897,36 @@ static unsigned int get_contig_folio_len(struct page **pages,
 
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
 
+static ssize_t bvec_iter_align_down(struct iov_iter *iter, struct bio_vec *bvec,
+		size_t size, unsigned short *nr_vecs, unsigned len_align_mask)
+{
+	size_t nbytes = size & len_align_mask;
+
+	if (!nbytes)
+		return size;
+
+	iov_iter_revert(iter, nbytes);
+	size -= nbytes;
+	do {
+		struct bio_vec *bv = &bvec[*nr_vecs - 1];
+
+		if (nbytes < bv->bv_len) {
+			bv->bv_len -= nbytes;
+			break;
+		}
+
+		if (iov_iter_extract_will_pin(iter))
+			unpin_user_page(bv->bv_page);
+
+		(*nr_vecs)--;
+		nbytes -= bv->bv_len;
+	} while (nbytes);
+
+	if (*nr_vecs == 0)
+		return -EFAULT;
+	return size;
+}
+
 /**
  * iov_iter_extract_bvecs - Extract bvecs from an iterator
  * @iter:	the iterator to extract from
@@ -1906,6 +1936,7 @@ static unsigned int get_contig_folio_len(struct page **pages,
  * @max_vecs:	maximum vectors in @bv, including those filled before calling
  * @mem_align_mask:	reject with -EINVAL if the source address or
  *		length is not aligned to this mask
+ * @len_align_mask: the mask to align the total size to, 0 for any length
  * @extraction_flags: flags to qualify request
  *
  * Like iov_iter_extract_pages(), but returns physically contiguous ranges
@@ -1918,7 +1949,7 @@ static unsigned int get_contig_folio_len(struct page **pages,
 ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		size_t max_size, unsigned short *nr_vecs,
 		unsigned short max_vecs, unsigned mem_align_mask,
-		iov_iter_extraction_t extraction_flags)
+		unsigned len_align_mask, iov_iter_extraction_t extraction_flags)
 {
 	unsigned long start = (unsigned long)iter_iov_addr(iter);
 	unsigned short entries_left = max_vecs - *nr_vecs;
@@ -1960,11 +1991,13 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		offset = 0;
 	}
 
+	size -= left;
 	iov_iter_revert(iter, left);
 	if (iov_iter_extract_will_pin(iter)) {
 		while (i < nr_pages)
 			unpin_user_page(pages[i++]);
 	}
-	return size - left;
+
+	return bvec_iter_align_down(iter, bv, size, nr_vecs, len_align_mask);
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_bvecs);
-- 
2.53.0

