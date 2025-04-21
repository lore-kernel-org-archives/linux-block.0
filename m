Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B71B21BF
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220439; cv=none; b=ISWRlOO0z0j42Ns2kb3e/65FdWHmv+ViBTS8f9VRKKNVrH004mbITI+9IyhuQzzJ1YTP4WTTEJmE9Ix68O8HqL0tjIkhiSkhhci0E7EDha2ZAnvWWhof3D/TttwtnazOtokj64irWns1JLUkTP+rRqWfQ/+RukvEbIAl+aYGUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220439; c=relaxed/simple;
	bh=/uiS1far/JlBYz4avglnZjgL6T1pW+4M29l6EWZzEug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq4eYxIkBRXcrmoEnXd3o30y1OBKqgEkYGlyQ8rLDnW8YrPo6DCp0DFcluXEk4uYBEXHVgYv5OoqjV+plxqF5LLPNbVyujIj1VjnRZ2/+8xB37MNQ1NxlfjcjyG36BAzkCtom9GtAq4QwzbJlTEwIaN8uhGBWNAmEYFpFNKmgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XK7kKSas; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XK7kKSas"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b8S6O16FZwOzow767bmfyPDaHZKiuKSpdg+87NbQ+Ak=; b=XK7kKSasIisO1oVozhvLJT3ars
	VChc3TG18BGTzInRZ4HNjdB7b3aGM+i5ONYB1gzsdC/zHSGCjolfvHQV//5Ay1FZXK6IwyTTRYJKj
	bP9yBvCZQ0134VaAkz/FAjZVqtyNgdjhH3D3xLPEMQFz3Z90FfMxNCpUlvkEQcPSFZl8TUebl8ubV
	tB3VO1xEFQi9agfpsnPx9qc96aXnBP1j+F675uoPmziJJhEFa4fUuYs1mMmaTieG5b6FrOSoA0gHD
	TU7RBZs8LxBrK7rLA6ovS70Tkd2/F7Op3vGUBc/23tnNxKmbwdg2h+3vaO1LNFxUtJ/z+xAkQJe99
	MOEMN25A==;
Received: from [213.208.157.109] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lYg-00000003n5E-2O3Y;
	Mon, 21 Apr 2025 07:27:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/5] brd: use memcpy_{to,from]_page in brd_rw_bvec
Date: Mon, 21 Apr 2025 09:26:09 +0200
Message-ID: <20250421072641.1311040-6-hch@lst.de>
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

Use the proper helpers to copy to/from potential highmem pages, which
do a local instead of atomic kmap underneath, and perform
flush_dcache_page where needed.  This also simplifies the code so much
that the separate read write helpers are not required any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/brd.c | 57 ++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 45 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 580b2d8ce99c..79e96221f887 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -99,43 +99,6 @@ static void brd_free_pages(struct brd_device *brd)
 	xa_destroy(&brd->brd_pages);
 }
 
-/*
- * Copy n bytes from src to the brd starting at sector. Does not sleep.
- */
-static void copy_to_brd(struct brd_device *brd, const void *src,
-			sector_t sector, size_t n)
-{
-	struct page *page;
-	void *dst;
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
-
-	page = brd_lookup_page(brd, sector);
-	BUG_ON(!page);
-
-	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, n);
-	kunmap_atomic(dst);
-}
-
-/*
- * Copy n bytes to dst from the brd starting at sector. Does not sleep.
- */
-static void copy_from_brd(void *dst, struct brd_device *brd,
-			sector_t sector, size_t n)
-{
-	struct page *page;
-	void *src;
-	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
-
-	page = brd_lookup_page(brd, sector);
-	if (page) {
-		src = kmap_atomic(page);
-		memcpy(dst, src + offset, n);
-		kunmap_atomic(src);
-	} else
-		memset(dst, 0, n);
-}
-
 /*
  * Process a single segment.  The segment is capped to not cross page boundaries
  * in both the bio and the brd backing memory.
@@ -146,7 +109,8 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 	sector_t sector = bio->bi_iter.bi_sector;
 	u32 offset = (sector & (PAGE_SECTORS - 1)) << SECTOR_SHIFT;
 	blk_opf_t opf = bio->bi_opf;
-	void *mem;
+	struct page *page;
+	void *kaddr;
 
 	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
@@ -168,15 +132,18 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 		}
 	}
 
-	mem = bvec_kmap_local(&bv);
-	if (!op_is_write(opf)) {
-		copy_from_brd(mem, brd, sector, bv.bv_len);
-		flush_dcache_page(bv.bv_page);
+	page = brd_lookup_page(brd, sector);
+
+	kaddr = bvec_kmap_local(&bv);
+	if (op_is_write(opf)) {
+		BUG_ON(!page);
+		memcpy_to_page(page, offset, kaddr, bv.bv_len);
+	} else if (page) {
+		memcpy_from_page(kaddr, page, offset, bv.bv_len);
 	} else {
-		flush_dcache_page(bv.bv_page);
-		copy_to_brd(brd, mem, sector, bv.bv_len);
+		memset(kaddr, 0, bv.bv_len);
 	}
-	kunmap_local(mem);
+	kunmap_local(kaddr);
 
 	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
 	return true;
-- 
2.47.2

