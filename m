Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE11BE25A
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581272; cv=none; b=DwxWU10/LdGq96RnF9BVbq6+8F94UxX2k1nCdZ5K9ptdTrAX4Sfi6eLl+hX2vHjd26k3WdaZe/Yk/bvPGW7fHlBdtIoHKKJXDljqyO4uGnVZ/BlnmbpK8c7V+mcyXfTVETR1vG+2iRFkaZq2TOg/i88tE1t4sQQH4FLFx66Sstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581272; c=relaxed/simple;
	bh=PFRGOahJxB4foZOfdnuYn24o+VBK6Cx/Qp8fJhpphRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxUdi0weD8qZkPRCLOMN9ihB/YoG9lW3begXB+AES6yFqlqdPUF/f9yRk/s+Euaf3v7UzK8IOXYpMcRWrWHoTHApkHpeBUkKRnr4nH03Y5H2QZWOpSuGSLVHobIr1jYZ5CfTU7M+uDZNWj3Y4PrtAhn6Y8iu1HiKpml0vma5BGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IoW3S6RP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IoW3S6RP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2GSea+Gjv9tkKdJ4/prJAIKSyMcLdr3thr+72zaTZKc=; b=IoW3S6RP5ZCYQJr5ccfzyaS73w
	xViehBHHcT0iMr6UO1omu7hJrRSsTuVUJGUVxj2lWbthiUlTTG7v2yxXF0W2yV2C/4SD9+7Q98qJ0
	QxzTyQvo/8ElZk9KPCffYsLOpr4ONty7uhpUUtYlnwDxSbnkORsySdTrMnxBL5rHBOCxN2mCFOhPa
	VcqLZ1iVhmH6DkIBa/f/i8cRq1AdZVKe9X1INuKW/JU4ZAvXHA57iazgW3Aq84r1teIxiiArIg9V0
	5rCWV4bBsLNe4QUusKPCGZfGqQV+GcxXEZk95YWGszgcbgjiDpZNBGw7a2Iv6c9K/hreyPZYonYfd
	RsYCUaZA==;
Received: from [2001:4bb8:2af:2acb:3b26:86b1:bdec:6790] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNBdm-0000000Doj3-1Lqi;
	Fri, 28 Jun 2024 13:27:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: don't free submitter owned integrity payload on I/O completion
Date: Fri, 28 Jun 2024 15:27:19 +0200
Message-ID: <20240628132736.668184-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628132736.668184-1-hch@lst.de>
References: <20240628132736.668184-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently __bio_integrity_endio unconditionally frees the integrity
payload.  While this works really well for block-layer generated
integrity payloads, it is a bad idea for those passed in by the
submitter, as it can't access the integrity data from the I/O completion
handler.

Change bio_integrity_endio to only call __bio_integrity_endio for
block layer generated integrity data, and leave freeing of submitter
allocated integrity data to bio_uninit which also gets called from
the final bio_put.  This requires that unmapping user mapped or copied
integrity data is done by the caller now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c         | 56 ++++++++++++++++-------------------
 block/blk-map.c               |  3 ++
 block/blk.h                   |  4 ++-
 include/linux/bio-integrity.h |  8 +++--
 4 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index ad296849aa2a9a..8c6447bcddede2 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -22,9 +22,17 @@ void blk_flush_integrity(void)
 	flush_workqueue(kintegrityd_wq);
 }
 
-static void __bio_integrity_free(struct bio_set *bs,
-				 struct bio_integrity_payload *bip)
+/**
+ * bio_integrity_free - Free bio integrity payload
+ * @bio:	bio containing bip to be freed
+ *
+ * Description: Free the integrity portion of a bio.
+ */
+void bio_integrity_free(struct bio *bio)
 {
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bio_set *bs = bio->bi_pool;
+
 	if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
 		if (bip->bip_vec)
 			bvec_free(&bs->bvec_integrity_pool, bip->bip_vec,
@@ -33,6 +41,8 @@ static void __bio_integrity_free(struct bio_set *bs,
 	} else {
 		kfree(bip);
 	}
+	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
 }
 
 /**
@@ -86,7 +96,10 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 
 	return bip;
 err:
-	__bio_integrity_free(bs, bip);
+	if (bs && mempool_initialized(&bs->bio_integrity_pool))
+		mempool_free(bip, &bs->bio_integrity_pool);
+	else
+		kfree(bip);
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
@@ -118,9 +131,10 @@ static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 	bio_integrity_unpin_bvec(copy, nr_vecs, true);
 }
 
-static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
+void bio_integrity_unmap_user(struct bio *bio)
 {
-	bool dirty = bio_data_dir(bip->bip_bio) == READ;
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	bool dirty = bio_data_dir(bio) == READ;
 
 	if (bip->bip_flags & BIP_COPY_USER) {
 		if (dirty)
@@ -131,28 +145,7 @@ static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
 
 	bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt, dirty);
 }
-
-/**
- * bio_integrity_free - Free bio integrity payload
- * @bio:	bio containing bip to be freed
- *
- * Description: Used to free the integrity portion of a bio. Usually
- * called from bio_free().
- */
-void bio_integrity_free(struct bio *bio)
-{
-	struct bio_integrity_payload *bip = bio_integrity(bio);
-	struct bio_set *bs = bio->bi_pool;
-
-	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
-		kfree(bvec_virt(bip->bip_vec));
-	else if (bip->bip_flags & BIP_INTEGRITY_USER)
-		bio_integrity_unmap_user(bip);
-
-	__bio_integrity_free(bs, bip);
-	bio->bi_integrity = NULL;
-	bio->bi_opf &= ~REQ_INTEGRITY;
-}
+EXPORT_SYMBOL_GPL(bio_integrity_unmap_user);
 
 /**
  * bio_integrity_add_page - Attach integrity metadata
@@ -252,7 +245,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 		goto free_bip;
 	}
 
-	bip->bip_flags |= BIP_INTEGRITY_USER | BIP_COPY_USER;
+	bip->bip_flags |= BIP_COPY_USER;
 	bip->bip_iter.bi_sector = seed;
 	return 0;
 free_bip:
@@ -272,7 +265,6 @@ static int bio_integrity_init_user(struct bio *bio, struct bio_vec *bvec,
 		return PTR_ERR(bip);
 
 	memcpy(bip->bip_vec, bvec, nr_vecs * sizeof(*bvec));
-	bip->bip_flags |= BIP_INTEGRITY_USER;
 	bip->bip_iter.bi_sector = seed;
 	bip->bip_iter.bi_size = len;
 	return 0;
@@ -479,6 +471,8 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 	struct bio *bio = bip->bip_bio;
 
 	blk_integrity_verify(bio);
+
+	kfree(bvec_virt(bip->bip_vec));
 	bio_integrity_free(bio);
 	bio_endio(bio);
 }
@@ -499,13 +493,13 @@ bool __bio_integrity_endio(struct bio *bio)
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
-	    (bip->bip_flags & BIP_BLOCK_INTEGRITY) && bi->csum_type) {
+	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status && bi->csum_type) {
 		INIT_WORK(&bip->bip_work, bio_integrity_verify_fn);
 		queue_work(kintegrityd_wq, &bip->bip_work);
 		return false;
 	}
 
+	kfree(bvec_virt(bip->bip_vec));
 	bio_integrity_free(bio);
 	return true;
 }
diff --git a/block/blk-map.c b/block/blk-map.c
index bce144091128f6..0e1167b239342f 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -757,6 +757,9 @@ int blk_rq_unmap_user(struct bio *bio)
 			bio_release_pages(bio, bio_data_dir(bio) == READ);
 		}
 
+		if (bio_integrity(bio))
+			bio_integrity_unmap_user(bio);
+
 		next_bio = bio;
 		bio = bio->bi_next;
 		blk_mq_map_bio_put(next_bio);
diff --git a/block/blk.h b/block/blk.h
index 401e604f35d2cf..e8a6e7497c8d36 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -206,7 +206,9 @@ bool __bio_integrity_endio(struct bio *);
 void bio_integrity_free(struct bio *bio);
 static inline bool bio_integrity_endio(struct bio *bio)
 {
-	if (bio_integrity(bio))
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
 		return __bio_integrity_endio(bio);
 	return true;
 }
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 7b6e687d436de2..a5a8b44e9b118f 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -10,8 +10,7 @@ enum bip_flags {
 	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
 	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
-	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
-	BIP_COPY_USER		= 1 << 6, /* Kernel bounce buffer in use */
+	BIP_COPY_USER		= 1 << 5, /* Kernel bounce buffer in use */
 };
 
 struct bio_integrity_payload {
@@ -74,6 +73,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
 		unsigned int offset);
 int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t len, u32 seed);
+void bio_integrity_unmap_user(struct bio *bio);
 bool bio_integrity_prep(struct bio *bio);
 void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
 void bio_integrity_trim(struct bio *bio);
@@ -105,6 +105,10 @@ static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
 	return -EINVAL;
 }
 
+static inline void bio_integrity_unmap_user(struct bio *bio)
+{
+}
+
 static inline bool bio_integrity_prep(struct bio *bio)
 {
 	return true;
-- 
2.43.0

