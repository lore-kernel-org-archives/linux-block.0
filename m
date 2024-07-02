Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF21BB695
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933064; cv=none; b=EMKRY+dRhe/Yhdgx+HRGbIDbgce7isq6BRyg8AF9XwkmDBXhURVdbk71/GZPJ+4cLbKny6awfRZ58iv2OR8a9XXAQ2X9t4Pw7IqdLRxcAwtcEHv0YDGlTjel1l3aRT1NdL9csmXJEWNDes2HB5ul+joBrhdzPlcivzhlDa6X3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933064; c=relaxed/simple;
	bh=bJZFcwmZb/ow39OQ1nA3teqy0nDQ5YgxWmIBix3Nc8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAwdxCr1ULrf134Zl3v5ATS+dv4YCqUpv52MRYt/Luj6onekBPv99L0ZeHce3RcjbYy2GinitEWh3lR54IqB0Sp1vo6JJgcZQdUThHQCpPmOin+LhSunNokgDspboL4g7og+PDmHqXWG7lLatN6aDctM86KFfn75t39Zd8XQtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KEbrNGIG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KEbrNGIG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PV92L0B9im4Kj3OftYV0nbZwAZGJpIrUAX90xBRCuGQ=; b=KEbrNGIG2vVzZt0LTXDuLjUBvc
	b//tIWKudYIVgR3O3/8O7AERnY2IWcEvEX8Hsffqgm8JIMMw1+rzOhkzLr+Z77aRbFnv9agMZ1edI
	WeRQuuZRuaFnGHb28V/0q2kw3CqObOwirpFeTxsEoSX7LfgvTIR9K0WURHZcdCUsHL9PMAi2lARbL
	1pB76J7KFs7dLJonhXwehPGpO+aNKLRQILwg89V4LRserdNw3eDlihn7HpZS9a1voI9WT/O2lOf8S
	u2OKJ+AnGCLfgdtDnvsjTPxtlxvbXRWelhJwmTJ95/bK2VvIT+w6jqfTSviTUkhAfa2lVm5VwBQ/W
	Vgx1dFdA==;
Received: from 2a02-8389-2341-5b80-4c69-cf21-4832-bbca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c69:cf21:4832:bbca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOf9q-000000079Ux-1Bhg;
	Tue, 02 Jul 2024 15:11:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 5/6] block: don't free submitter owned integrity payload on I/O completion
Date: Tue,  2 Jul 2024 17:10:23 +0200
Message-ID: <20240702151047.1746127-6-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702151047.1746127-1-hch@lst.de>
References: <20240702151047.1746127-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently __bio_integrity_endio frees the integrity payload unless it is
explicitly marked as user-mapped.  This means in-kernel callers that
allocate their own integrity payload never get to see it on I/O
completion.  The current two users don't need it as they just pre-mapped
PI tuples received over the network, but this limits uses of integrity
data lot.

Change bio_integrity_endio to call __bio_integrity_endio for block layer
generated integrity data only, and leave freeing of submitter
allocated integrity data to bio_uninit which also gets called from
the final bio_put.  This requires that unmapping user mapped or copied
integrity data is now always done by the caller, and the special
BIP_INTEGRITY_USER flag can go away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c         | 57 ++++++++++++++---------------------
 block/blk.h                   | 13 ++++++--
 include/linux/bio-integrity.h |  3 +-
 3 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index c8757d47e0ef62..4aa836d603fb23 100644
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
@@ -132,28 +145,6 @@ static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
 	bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt, dirty);
 }
 
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
-	if (bip->bip_flags & BIP_INTEGRITY_USER)
-		return;
-	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
-		kfree(bvec_virt(bip->bip_vec));
-
-	__bio_integrity_free(bs, bip);
-	bio->bi_integrity = NULL;
-	bio->bi_opf &= ~REQ_INTEGRITY;
-}
-
 /**
  * bio_integrity_unmap_free_user - Unmap and free bio user integrity payload
  * @bio:	bio containing bip to be unmapped and freed
@@ -165,14 +156,9 @@ void bio_integrity_free(struct bio *bio)
 void bio_integrity_unmap_free_user(struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	struct bio_set *bs = bio->bi_pool;
 
-	if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
-		return;
 	bio_integrity_unmap_user(bip);
-	__bio_integrity_free(bs, bip);
-	bio->bi_integrity = NULL;
-	bio->bi_opf &= ~REQ_INTEGRITY;
+	bio_integrity_free(bio);
 }
 
 /**
@@ -273,7 +259,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 		goto free_bip;
 	}
 
-	bip->bip_flags |= BIP_INTEGRITY_USER | BIP_COPY_USER;
+	bip->bip_flags |= BIP_COPY_USER;
 	bip->bip_iter.bi_sector = seed;
 	bip->bip_vcnt = nr_vecs;
 	return 0;
@@ -294,7 +280,6 @@ static int bio_integrity_init_user(struct bio *bio, struct bio_vec *bvec,
 		return PTR_ERR(bip);
 
 	memcpy(bip->bip_vec, bvec, nr_vecs * sizeof(*bvec));
-	bip->bip_flags |= BIP_INTEGRITY_USER;
 	bip->bip_iter.bi_sector = seed;
 	bip->bip_iter.bi_size = len;
 	bip->bip_vcnt = nr_vecs;
@@ -502,6 +487,8 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 	struct bio *bio = bip->bip_bio;
 
 	blk_integrity_verify(bio);
+
+	kfree(bvec_virt(bip->bip_vec));
 	bio_integrity_free(bio);
 	bio_endio(bio);
 }
@@ -522,13 +509,13 @@ bool __bio_integrity_endio(struct bio *bio)
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
diff --git a/block/blk.h b/block/blk.h
index 401e604f35d2cf..2233dc8d36b82a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -202,11 +202,20 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
-bool __bio_integrity_endio(struct bio *);
 void bio_integrity_free(struct bio *bio);
+
+/*
+ * Integrity payloads can either be owned by the submitter, in which case
+ * bio_uninit will free them, or owned and generated by the block layer,
+ * in which case we'll verify them here (for reads) and free them before
+ * the bio is handed back to the submitted.
+ */
+bool __bio_integrity_endio(struct bio *bio);
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
index cac24dac06fff0..3823d9be0d0790 100644
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
-- 
2.43.0

