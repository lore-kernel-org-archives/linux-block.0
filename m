Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797C26982E
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849430; cv=none; b=eImagwxIWf6npVXBpLcX4qLpbIBZfJGW9BoIkoPf4HHRg9eY2PQ0l6fD1I6xiq46ob8Lc+/9mXLyxfRvUSaEamMlwvAv0T268YW0oKCpBt9k2GZweDvxsRFoZFn/hkjQrQAzG/ockMdE5VAZOMnhNSb2m/Fr3TtOMdZd/0E3oBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849430; c=relaxed/simple;
	bh=CtfSV6t3L4YvfppiFpfNO7jXCwoONUfgVnzKo9WuRL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM8YH6KjkF+3TTOLOG98oLamc6DNS1VIfe4n/AyTtJAWetAINUKG557eWq6FzpGoV56wOfXipZyinMN7hFiTjZBvhW8Y9mogS0plSNQKB+tVPYeOPKSCvc1/BTzgFhFM8CcdpVdHCDLtc7pZ0T3uyteW9Bg/GS9RZvsOaYWwwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=25FjkK7A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="25FjkK7A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VuYrWrx1Ws51I5TCe49sBi+KByJbn8TyH2PPTR+R3Cc=; b=25FjkK7AwmTvAmMCdXJQtuPRnw
	/iAp2VnYp3AZXFT8Tyo+Ln8XC0wFidsuWdUrXE1mSct+OuT7giMtxYu3vqnJT1t/Ay1Hb8Vg1hEjt
	l/FAJsLyYQdu91BffQk8GO/e1UcmVB3zuAmtm+aEyCXe1l0k1sQFYRKfqp3rrtxpBZR/pBoHPBAYu
	rL0mjFj2T+f53Qwsm5gzezm0IYrN1sEoLF+Bzi05Ng5aeHoyla+Y0lIIIlgJicJxQANZNXPEksupJ
	uSQQsAF1+pEYZz9On3bUwYUnWsjFXQkL5GNLERJjf8Qzp6ikeHKzSU+KJxjJCnFBVwdLBye7C0zr2
	v1if39qQ==;
Received: from [206.0.71.28] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9PBk-00000006aWv-0ZFB;
	Mon, 28 Apr 2025 14:10:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 5/5] brd: use memcpy_{to,from]_page in brd_rw_bvec
Date: Mon, 28 Apr 2025 07:09:51 -0700
Message-ID: <20250428141014.2360063-6-hch@lst.de>
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

Use the proper helpers to copy to/from potential highmem pages, which
do a local instead of atomic kmap underneath, and perform
flush_dcache_page where needed.  This also simplifies the code so much
that the separate read write helpers are not required any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/brd.c | 58 ++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 45 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 580b2d8ce99c..fa1290992a7f 100644
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
 
@@ -168,15 +132,19 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
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
 	} else {
-		flush_dcache_page(bv.bv_page);
-		copy_to_brd(brd, mem, sector, bv.bv_len);
+		if (page)
+			memcpy_from_page(kaddr, page, offset, bv.bv_len);
+		else
+			memset(kaddr, 0, bv.bv_len);
 	}
-	kunmap_local(mem);
+	kunmap_local(kaddr);
 
 	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
 	return true;
-- 
2.47.2

