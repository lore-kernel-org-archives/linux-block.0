Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B21C5D5E
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220432; cv=none; b=DdeouRfi106o5w48oMDl0NacnQo5peEUnVM6wDEaGyJ5SotTAY+OCDrQaDQAmvMjLy6GLvq7js33VtT6SIfOONf6OsQhuHjNpraNzTpmAM1ju7+Wrx4slvbsiUsvamI0f9qDyxx7IksD7sF2sqmTLw74V9trWKfr0F+kLf9GBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220432; c=relaxed/simple;
	bh=H99KeLmeFZ4naDKD4m3faqNKgVW9/fbrcPSvlDhaPHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVUoI/7IPe0U8xArmieM5wB/OSzkgeCQjwGAmbX7X0k5s9+3JCUe8LMQL8qgaW6N2dRorTqagCxIaW+f+S3YLZ/+6rRT+mLxYTpKyo4NB21GoaHxK0WGhMFTzZgRkgfsTPHDvD6dxQLYFfvGkNKBGQaqeytsmG+GG0N9G59Yzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pUgu2IUl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pUgu2IUl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0QkrmSj5qZPom0wkujfHrSx1GAxwHLn/cOLBPN42I7U=; b=pUgu2IUlXsqIskWrTdGR/CoBnV
	vQOBAFyUHSJ17mbqmF+rY1OwiKBFGPS6ER2q9ap+64P5Ii4vsMknHv74DPuRql6hS9lX3gbKKO0Pr
	5cOeL6SqPjWXc9A8cW/YPdX/ZM8BptA+eRfYF/8z+2lALC8q149iKl3c/D2yGpQmBNVmaLIHDLvyh
	nB8Q7G7pYtcWB7TrCoXVg7PEIoj+8wDZpmcb8RR7N3p+7ndUEdDZ/JQ/UhJZJpxfcLDCpxiYE5nBX
	/KBjGLXkGzxlLnh42dYSVgigVZGWdToW4EzzKwdoQuRk9WE/ASVG3sgDwjh4OlDT2KEG0i3597z8o
	Qb/Tn1Kw==;
Received: from [213.208.157.109] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lYc-00000003n40-0M7u;
	Mon, 21 Apr 2025 07:27:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/5] brd: split I/O at page boundaries
Date: Mon, 21 Apr 2025 09:26:08 +0200
Message-ID: <20250421072641.1311040-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421072641.1311040-1-hch@lst.de>
References: <20250421072641.1311040-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

A lot of complexity in brd stems from the fact that it tries to handle
I/O spanning two backing pages.  Instead limit the size of a single
bvec iteration so that it never crosses a page boundary and remove all
the now unneeded code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/brd.c | 116 +++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 82 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 0c70d29379f1..580b2d8ce99c 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -99,27 +99,6 @@ static void brd_free_pages(struct brd_device *brd)
 	xa_destroy(&brd->brd_pages);
 }
 
-/*
- * copy_to_brd_setup must be called before copy_to_brd. It may sleep.
- */
-static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
-			     gfp_t gfp)
-{
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
-	size_t copy;
-	int ret;
-
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	ret = brd_insert_page(brd, sector, gfp);
-	if (ret)
-		return ret;
-	if (copy < n) {
-		sector += copy >> SECTOR_SHIFT;
-		ret = brd_insert_page(brd, sector, gfp);
-	}
-	return ret;
-}
-
 /*
  * Copy n bytes from src to the brd starting at sector. Does not sleep.
  */
@@ -129,27 +108,13 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 	struct page *page;
 	void *dst;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
-	size_t copy;
 
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
 	page = brd_lookup_page(brd, sector);
 	BUG_ON(!page);
 
 	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, copy);
+	memcpy(dst + offset, src, n);
 	kunmap_atomic(dst);
-
-	if (copy < n) {
-		src += copy;
-		sector += copy >> SECTOR_SHIFT;
-		copy = n - copy;
-		page = brd_lookup_page(brd, sector);
-		BUG_ON(!page);
-
-		dst = kmap_atomic(page);
-		memcpy(dst, src, copy);
-		kunmap_atomic(dst);
-	}
 }
 
 /*
@@ -161,62 +126,60 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 	struct page *page;
 	void *src;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
-	size_t copy;
 
-	copy = min_t(size_t, n, PAGE_SIZE - offset);
 	page = brd_lookup_page(brd, sector);
 	if (page) {
 		src = kmap_atomic(page);
-		memcpy(dst, src + offset, copy);
+		memcpy(dst, src + offset, n);
 		kunmap_atomic(src);
 	} else
-		memset(dst, 0, copy);
-
-	if (copy < n) {
-		dst += copy;
-		sector += copy >> SECTOR_SHIFT;
-		copy = n - copy;
-		page = brd_lookup_page(brd, sector);
-		if (page) {
-			src = kmap_atomic(page);
-			memcpy(dst, src, copy);
-			kunmap_atomic(src);
-		} else
-			memset(dst, 0, copy);
-	}
+		memset(dst, 0, n);
 }
 
 /*
- * Process a single bvec of a bio.
+ * Process a single segment.  The segment is capped to not cross page boundaries
+ * in both the bio and the brd backing memory.
  */
-static int brd_rw_bvec(struct brd_device *brd, struct bio_vec *bv,
-		blk_opf_t opf, sector_t sector)
+static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 {
+	struct bio_vec bv = bio_iter_iovec(bio, bio->bi_iter);
+	sector_t sector = bio->bi_iter.bi_sector;
+	u32 offset = (sector & (PAGE_SECTORS - 1)) << SECTOR_SHIFT;
+	blk_opf_t opf = bio->bi_opf;
 	void *mem;
 
+	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
+
 	if (op_is_write(opf)) {
+		int err;
+
 		/*
 		 * Must use NOIO because we don't want to recurse back into the
 		 * block or filesystem layers from page reclaim.
 		 */
-		gfp_t gfp = opf & REQ_NOWAIT ? GFP_NOWAIT : GFP_NOIO;
-		int err;
-
-		err = copy_to_brd_setup(brd, sector, bv->bv_len, gfp);
-		if (err)
-			return err;
+		err = brd_insert_page(brd, sector,
+				(opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO);
+		if (err) {
+			if (err == -ENOMEM && (opf & REQ_NOWAIT))
+				bio_wouldblock_error(bio);
+			else
+				bio_io_error(bio);
+			return false;
+		}
 	}
 
-	mem = bvec_kmap_local(bv);
+	mem = bvec_kmap_local(&bv);
 	if (!op_is_write(opf)) {
-		copy_from_brd(mem, brd, sector, bv->bv_len);
-		flush_dcache_page(bv->bv_page);
+		copy_from_brd(mem, brd, sector, bv.bv_len);
+		flush_dcache_page(bv.bv_page);
 	} else {
-		flush_dcache_page(bv->bv_page);
-		copy_to_brd(brd, mem, sector, bv->bv_len);
+		flush_dcache_page(bv.bv_page);
+		copy_to_brd(brd, mem, sector, bv.bv_len);
 	}
 	kunmap_local(mem);
-	return 0;
+
+	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
+	return true;
 }
 
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
@@ -241,8 +204,6 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
-	struct bio_vec bvec;
-	struct bvec_iter iter;
 
 	if (unlikely(op_is_discard(bio->bi_opf))) {
 		brd_do_discard(brd, bio->bi_iter.bi_sector,
@@ -251,19 +212,10 @@ static void brd_submit_bio(struct bio *bio)
 		return;
 	}
 
-	bio_for_each_segment(bvec, bio, iter) {
-		int err;
-
-		err = brd_rw_bvec(brd, &bvec, bio->bi_opf, iter.bi_sector);
-		if (err) {
-			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
-				bio_wouldblock_error(bio);
-				return;
-			}
-			bio_io_error(bio);
+	do {
+		if (!brd_rw_bvec(brd, bio))
 			return;
-		}
-	}
+	} while (bio->bi_iter.bi_size);
 
 	bio_endio(bio);
 }
-- 
2.47.2

