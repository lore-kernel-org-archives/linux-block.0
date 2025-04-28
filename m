Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB326B2B2
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849428; cv=none; b=XyjaAt3j/EUhfYCXQ38tjH7X5MFrRE0P9UlEDrEwCW7Z4r4qXtbgqQZmY4lGHd1Xft6saEomQCANG+epa6T1aUG7Ixvk3Tk5c8shvZyopqd8KjncBzsBi8LxZKn49M45eBKlJmyta7t/ZjNkiHYdkm4obw6STQ4NXHdgyVdRV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849428; c=relaxed/simple;
	bh=GNCGpTeAEQJuHM0NbOdFLXkms/ywkJi4H8peNMITSds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9YYEF9D4ZPJFMY5WcBunvjRiJObbuO/URn3aj3gEvcYhG0CGav9FK7Yyul6fsO9VqKSkUcF9YIl2cnmIOjZ+e8iDtI/SS1aJHAC/t6xmf/AWo1hKqOUrnw1Gat+3k+QVt47ZHgJglT3l63aK/Y50sOvFi1nLAuOvGSIwRKOueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UQTQ/GPU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQTQ/GPU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RrsIzbZ4FZfEaUXr2Nz0NAQvm74CjO/Tq0RMYjRKU98=; b=UQTQ/GPU9EwsaJkdN2DzX5pATo
	pFcAzxcm8sj05DtfjulP1OBTKzf383z7s9n+IQChl/UN1oOoU/6hmdXgz/0MKwaFz4kKUdkhBasIM
	EzZ1+j3VeHPo6J3AQnhF/xlOVEEF3gZ98DMXpTby4EQ6ptmGeZeeq+rDJ3J7f52/3O5TtvuMi1dJY
	e7zvDmrwDICxfTtyfXr6bJ4Pc6jxNQkvomAyqdXrMFnMvqFLD19PxfxVJScKAKA7kclonod7N37Av
	ag/EchQXJg0L7tdfbDq2TEPROV23PM9DqtJtPg7hZJtKYolf2wMH8rzL2wDLwtKn1cwtaGZnoU82L
	+EyvAHpQ==;
Received: from [206.0.71.28] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9PBi-00000006aWC-0Kms;
	Mon, 28 Apr 2025 14:10:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 4/5] brd: split I/O at page boundaries
Date: Mon, 28 Apr 2025 07:09:50 -0700
Message-ID: <20250428141014.2360063-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428141014.2360063-1-hch@lst.de>
References: <20250428141014.2360063-1-hch@lst.de>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
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

