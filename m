Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717633D81
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220418; cv=none; b=m5JMC2DG9b4KxlKjXnsD5mQ2PSTN8P9G+4Dyew2QhWyoWFZdC6mFRRuGVR0yvlc3WOBAv1sCFSOAZrYw8pNeGf3aNdxeC2EcxgEY8tT48vbGwii0hJAMR5TlrjyfmVTHxAcxZsxIF+s/lYkOcv8pRLibidFu1ZytirA9mxrh/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220418; c=relaxed/simple;
	bh=oEY6ejC+6kZq+/MMGGT4TpRXBfmeZVDR56JbDQ3+muU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpQOaT6/O28SLyX/xtL1Th+9SrywmkI1mTrhQyF3OZrwWYiqf1GVo58t6yeIO3AawUpekWMowep+erDxzV4lcXmNruHn26QbGbpHOyTaNAOFHhbDp2YlOjWHkbbBILZHzl3Cj4gyZ7Mhv2NZP4vSmIsVgYKpC9JXzwSFN/1z9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yP7rFJX4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yP7rFJX4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RlUlT/+FmH7Y7xQh64U6PkOzUFlzlyHiMzLaYbmUS4w=; b=yP7rFJX4iH0GnBIgQjp8swNgOG
	W8B4WmrTMv53g7AiHR/gJD2mFJfFC6RWPlzEcltdigwnW5TJyFlBcABmwbarKt0RRw25VE3sRwoZn
	xd5s2qIx0/ZyYHV1dkENIKXgx4Ihh4x3okKzIa2Pn5lT8TTBgE6OaD/hfK2pirPLTeiDq5keJBTAy
	dtWnChVsJZrRLOxu9PW5oTRR2hhin9rMK1XkWsvQms/oQcuMKx+Noaphu6F5spiedx5yRIOA6yB7d
	OxTTmzw6Te0LNwp96zox0dHeasJwft0+tVaSqAxMdsOA3Ep6u1JOUTjqCQYvWPfXSmNFoMu9r5UEo
	S5wEA35A==;
Received: from [213.208.157.109] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lYM-00000003n1a-2cUK;
	Mon, 21 Apr 2025 07:26:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/5] brd; pass a bvec pointer to brd_do_bvec
Date: Mon, 21 Apr 2025 09:26:05 +0200
Message-ID: <20250421072641.1311040-2-hch@lst.de>
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

Pass the bvec to brd_do_bvec instead of marshalling the information into
individual arguments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/brd.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 292f127cae0a..c8974bc545fb 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -189,12 +189,10 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 /*
  * Process a single bvec of a bio.
  */
-static int brd_do_bvec(struct brd_device *brd, struct page *page,
-			unsigned int len, unsigned int off, blk_opf_t opf,
-			sector_t sector)
+static int brd_rw_bvec(struct brd_device *brd, struct bio_vec *bv,
+		blk_opf_t opf, sector_t sector)
 {
 	void *mem;
-	int err = 0;
 
 	if (op_is_write(opf)) {
 		/*
@@ -202,24 +200,23 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 		 * block or filesystem layers from page reclaim.
 		 */
 		gfp_t gfp = opf & REQ_NOWAIT ? GFP_NOWAIT : GFP_NOIO;
+		int err;
 
-		err = copy_to_brd_setup(brd, sector, len, gfp);
+		err = copy_to_brd_setup(brd, sector, bv->bv_len, gfp);
 		if (err)
-			goto out;
+			return err;
 	}
 
-	mem = kmap_atomic(page);
+	mem = kmap_atomic(bv->bv_page);
 	if (!op_is_write(opf)) {
-		copy_from_brd(mem + off, brd, sector, len);
-		flush_dcache_page(page);
+		copy_from_brd(mem + bv->bv_offset, brd, sector, bv->bv_len);
+		flush_dcache_page(bv->bv_page);
 	} else {
-		flush_dcache_page(page);
-		copy_to_brd(brd, mem + off, sector, len);
+		flush_dcache_page(bv->bv_page);
+		copy_to_brd(brd, mem + bv->bv_offset, sector, bv->bv_len);
 	}
 	kunmap_atomic(mem);
-
-out:
-	return err;
+	return 0;
 }
 
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
@@ -255,15 +252,9 @@ static void brd_submit_bio(struct bio *bio)
 	}
 
 	bio_for_each_segment(bvec, bio, iter) {
-		unsigned int len = bvec.bv_len;
 		int err;
 
-		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
-
-		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
-				  bio->bi_opf, sector);
+		err = brd_rw_bvec(brd, &bvec, bio->bi_opf, sector);
 		if (err) {
 			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
 				bio_wouldblock_error(bio);
@@ -272,7 +263,7 @@ static void brd_submit_bio(struct bio *bio)
 			bio_io_error(bio);
 			return;
 		}
-		sector += len >> SECTOR_SHIFT;
+		sector += bvec.bv_len >> SECTOR_SHIFT;
 	}
 
 	bio_endio(bio);
-- 
2.47.2

