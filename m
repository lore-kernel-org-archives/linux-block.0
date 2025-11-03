Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F62F692D
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165020; cv=none; b=C1Ct3Du6fwihU028SCBLbV/b/SR85rLqny8cwgzDlT6ZsKME1ibjXNAIfxYUgNFZeBZLsgodDKa1DzMhpA1ptFKjlDfdvzIdib6CFTFLnqLsNqj2DgyWhoS6g65/39vVOWM9+Mrzm0wdrlcKQ89/jrAOzFhcTTjCKvwIboJTcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165020; c=relaxed/simple;
	bh=kgiuaZ3yyjjzq6tQ9ZkteBDCeV1Mc2RU1eJ68LNkOlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9LCtnB9WlIIXAr8tES2la1DsyJpevDwevPIhaka8ynh1CJyAKAPZCsrNS2mhFLuBNL1Y4NGqAT0fdNO43UvKQBkZwUpMyw2nLS5cNWvK4F+sszbnQ3S2RiSKT3uTB9Tjedj8OZ4jDu5f26rf26gC2kAlnLk4exAtC+QjeEj/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sLVMZ+tg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sLVMZ+tg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TbdpLvWNVnBq/cZZlvs6WBfzaI6MLyQ0ciog9RXbScg=; b=sLVMZ+tg4HwRtnHp8+1NvbKeNL
	ot6/QZnCtSdvkiQLkQxiuRw7PX/GGwkUn6q9ooi6giaQjCCnH2SvKfGY2vXHzw9drlmaiYFTjd353
	wLbgZAnzBReaemIhQjYgtXDNCcK4KYj+JKvJyV5UOJWn1CFsNOpBu2YDK+L99cql3D0AQW0lRcZ39
	pbcHpgEPfvtW8FS610WYN8UVTWDrjXFRWrddINdsF6X46VVwhNPkSEBhwptbNqEMLnrQOgidfIJYK
	sTCr5esFPhcxNHbGPGJrLCcuwnHB6dFdJPRBpEn1TmqmJZ6McOOhS8PNIDeAGavTznVy+Xuus+eNc
	XaQ+c7SQ==;
Received: from [207.253.13.66] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFrcP-00000009blv-3p5z;
	Mon, 03 Nov 2025 10:16:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: make bio auto-integrity deadlock safe
Date: Mon,  3 Nov 2025 05:16:45 -0500
Message-ID: <20251103101653.2083310-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103101653.2083310-1-hch@lst.de>
References: <20251103101653.2083310-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The current block layer automatic integrity protection allocates the
actual integrity buffer, which has three problems:

 - because it happens at the bottom of the I/O stack and doesn't use a
   mempool it can deadlock under load
 - because the data size in a bio is almost unbounded when using lage
   folios it can relatively easily exceed the maximum kmalloc size
 - even when it does not exceed the maximum kmalloc size, it could
   exceed the maximum segment size of the device

Fix this by limiting the I/O size so that we can allocate at least a
2MiB integrity buffer, i.e. 128MiB for 8 byte PI and 512 byte integrity
intervals, and create a mempool as a last resort for this maximum size,
mirroring the scheme used for bvecs.  As a nice upside none of this
can fail now, so we remove the error handling and open code the
trivial addition of the bip vec.

The new allocation helpers sit outside of bio-integrity-auto.c because
I plan to reuse them for file system based PI in the near future.

Fixes: 7ba1ba12eeef ("block: Block layer data integrity support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/bio-integrity-auto.c    | 22 +++-------------
 block/bio-integrity.c         | 48 +++++++++++++++++++++++++++++++++++
 block/blk-settings.c          | 21 +++++++++++++++
 include/linux/bio-integrity.h |  6 +++++
 include/linux/blk-integrity.h |  5 ++++
 5 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 2f4a244749ac..9850c338548d 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -29,7 +29,7 @@ static void bio_integrity_finish(struct bio_integrity_data *bid)
 {
 	bid->bio->bi_integrity = NULL;
 	bid->bio->bi_opf &= ~REQ_INTEGRITY;
-	kfree(bvec_virt(bid->bip.bip_vec));
+	bio_integrity_free_buf(&bid->bip);
 	mempool_free(bid, &bid_pool);
 }
 
@@ -110,8 +110,6 @@ bool bio_integrity_prep(struct bio *bio)
 	struct bio_integrity_data *bid;
 	bool set_flags = true;
 	gfp_t gfp = GFP_NOIO;
-	unsigned int len;
-	void *buf;
 
 	if (!bi)
 		return true;
@@ -152,17 +150,12 @@ bool bio_integrity_prep(struct bio *bio)
 	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
 		return true;
 
-	/* Allocate kernel buffer for protection data */
-	len = bio_integrity_bytes(bi, bio_sectors(bio));
-	buf = kmalloc(len, gfp);
-	if (!buf)
-		goto err_end_io;
 	bid = mempool_alloc(&bid_pool, GFP_NOIO);
 	bio_integrity_init(bio, &bid->bip, &bid->bvec, 1);
-
 	bid->bio = bio;
-
 	bid->bip.bip_flags |= BIP_BLOCK_INTEGRITY;
+	bio_integrity_alloc_buf(bio, gfp & __GFP_ZERO);
+
 	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
 
 	if (set_flags) {
@@ -174,21 +167,12 @@ bool bio_integrity_prep(struct bio *bio)
 			bid->bip.bip_flags |= BIP_CHECK_REFTAG;
 	}
 
-	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
-			offset_in_page(buf)) < len)
-		goto err_end_io;
-
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE && bip_should_check(&bid->bip))
 		blk_integrity_generate(bio);
 	else
 		bid->saved_bio_iter = bio->bi_iter;
 	return true;
-
-err_end_io:
-	bio->bi_status = BLK_STS_RESOURCE;
-	bio_endio(bio);
-	return false;
 }
 EXPORT_SYMBOL(bio_integrity_prep);
 
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bed26f1ec869..09eeaf6e74b8 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -14,6 +14,45 @@ struct bio_integrity_alloc {
 	struct bio_vec			bvecs[];
 };
 
+static mempool_t integrity_buf_pool;
+
+void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	unsigned int len = bio_integrity_bytes(bi, bio_sectors(bio));
+	gfp_t gfp = GFP_NOIO | (zero_buffer ? __GFP_ZERO : 0);
+	void *buf;
+
+	buf = kmalloc(len, (gfp & ~__GFP_DIRECT_RECLAIM) |
+			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN);
+	if (unlikely(!buf)) {
+		struct page *page;
+
+		page = mempool_alloc(&integrity_buf_pool, GFP_NOFS);
+		if (zero_buffer)
+			memset(page_address(page), 0, len);
+		bvec_set_page(&bip->bip_vec[0], page, len, 0);
+		bip->bip_flags |= BIP_MEMPOOL;
+	} else {
+		bvec_set_page(&bip->bip_vec[0], virt_to_page(buf), len,
+				offset_in_page(buf));
+	}
+
+	bip->bip_vcnt = 1;
+	bip->bip_iter.bi_size = len;
+}
+
+void bio_integrity_free_buf(struct bio_integrity_payload *bip)
+{
+	struct bio_vec *bv = &bip->bip_vec[0];
+
+	if (bip->bip_flags & BIP_MEMPOOL)
+		mempool_free(bv->bv_page, &integrity_buf_pool);
+	else
+		kfree(bvec_virt(bv));
+}
+
 /**
  * bio_integrity_free - Free bio integrity payload
  * @bio:	bio containing bip to be freed
@@ -438,3 +477,12 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	return 0;
 }
+
+static int __init bio_integrity_initfn(void)
+{
+	if (mempool_init_page_pool(&integrity_buf_pool, BIO_POOL_SIZE,
+			get_order(BLK_INTEGRITY_MAX_SIZE)))
+		panic("bio: can't create integrity buf pool\n");
+	return 0;
+}
+subsys_initcall(bio_integrity_initfn);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index d74b13ec8e54..547b679c5dc1 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -123,6 +123,19 @@ static int blk_validate_zoned_limits(struct queue_limits *lim)
 	return 0;
 }
 
+/*
+ * Maximum size of I/O that needs a block layer integrity buffer.  Limited
+ * by the number of intervals for which we can fit the integrity buffer into
+ * the buffer size.  Because the buffer is a single segment it is also limited
+ * by the maximum segment size.
+ */
+static inline unsigned int max_integrity_io_size(struct queue_limits *lim)
+{
+	return min_t(unsigned int, lim->max_segment_size,
+		(BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size) <<
+			lim->integrity.interval_exp);
+}
+
 static int blk_validate_integrity_limits(struct queue_limits *lim)
 {
 	struct blk_integrity *bi = &lim->integrity;
@@ -194,6 +207,14 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 					(1U << bi->interval_exp) - 1);
 	}
 
+	/*
+	 * The block layer automatically adds integrity data for bios that don't
+	 * already have it.  Limit the I/O size so that a single maximum size
+	 * metadata segment can cover the integrity data for the entire I/O.
+	 */
+	lim->max_sectors = min(lim->max_sectors,
+		max_integrity_io_size(lim) >> SECTOR_SHIFT);
+
 	return 0;
 }
 
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 851254f36eb3..3d05296a5afe 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -14,6 +14,8 @@ enum bip_flags {
 	BIP_CHECK_REFTAG	= 1 << 6, /* reftag check */
 	BIP_CHECK_APPTAG	= 1 << 7, /* apptag check */
 	BIP_P2P_DMA		= 1 << 8, /* using P2P address */
+
+	BIP_MEMPOOL		= 1 << 15, /* buffer backed by mempool */
 };
 
 struct bio_integrity_payload {
@@ -140,4 +142,8 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 	return 0;
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
+
+void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer);
+void bio_integrity_free_buf(struct bio_integrity_payload *bip);
+
 #endif /* _LINUX_BIO_INTEGRITY_H */
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b659373788f6..c2030fd8ba0a 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -8,6 +8,11 @@
 
 struct request;
 
+/*
+ * Maximum contiguous integrity buffer allocation.
+ */
+#define BLK_INTEGRITY_MAX_SIZE		SZ_2M
+
 enum blk_integrity_flags {
 	BLK_INTEGRITY_NOVERIFY		= 1 << 0,
 	BLK_INTEGRITY_NOGENERATE	= 1 << 1,
-- 
2.47.3

