Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849561E880
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378010; cv=none; b=CbGZSZ8JalSTDz4KFobkcP7U4oyZBYEGh9+VgaJssKUgxQCDtQVoJf3Sp8dAUuZphP8QQpoiObOq7ykJzUIfNgscBEbGYgZWKi7nX+V4xbczRteCrWCDrkyp3pSqrxZQRsYYOBl+2/FEvsVSY0sKyelfvqSlzMzJC+WU41Kn9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378010; c=relaxed/simple;
	bh=YpaS1a3u7APOfowCGPg6pLP8UCQQW9es3waUalKnR1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxdGgZALuFxuwsMydGB8CJdhZ8Iylibk2uDfhWdq+OZQeX9V9qgZVBrSYYKnsYpwMUvCFelvEGCCtEymhLFzoHRILEG4Zm3QziaKoIBEc3UKszLny+ndjvN15FweFJux1WsVetUzFcDXUkioJQakccLV/b1f16147Vc/6KKwqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x5yaCGGu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x5yaCGGu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UCUhhybs5pM8wGyT8tlOjw97WIbK++tljHodc0MrKFQ=; b=x5yaCGGuqX4wdMhSBESK13j02U
	WdliwWxVlgoD38NbJALCDAWd6aP52IMp2uGuAMB8FDWI0lHgBL0R1INfJnUt4erOSUyEb0GGv6d8v
	0yZ+he6ZuPUajlHQktWmbZAcURXDzSLKNjJzHEIUp7GJaZfItdayWSRggyTB60c8zTB6OpmOqFmOI
	IKYbyf0uYyjrbtpTA0f+RUYkyygEpphOesRenNfeoit4h8dlsMhWV+K7uAiXqZTYUqOeQpl68c8B0
	FrGcDNiIfMIq8Czs8I9K1IOPJ5u7fXCmB4o9mBKYj19akEmUGP/kvzory2Oj1lOY5PSjyANjUZinX
	XO8hL0dg==;
Received: from [2001:4bb8:2cd:5bfc:fac4:f2e7:8d6c:958e] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKlL-00000005Nme-24vV;
	Wed, 26 Jun 2024 05:00:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 5/5] block: remove bio_integrity_process
Date: Wed, 26 Jun 2024 06:59:38 +0200
Message-ID: <20240626045950.189758-6-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626045950.189758-1-hch@lst.de>
References: <20240626045950.189758-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the bvec interation into the generate/verify helpers to avoid a bit
of argument passing churn.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c         | 47 +----------------
 block/blk.h                   |  7 +--
 block/t10-pi.c                | 97 +++++++++++++++++++++++++++--------
 include/linux/blk-integrity.h |  9 ----
 4 files changed, 79 insertions(+), 81 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3cd867b0544cf0..20bbfd5730dadd 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -374,44 +374,6 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes,
 }
 EXPORT_SYMBOL_GPL(bio_integrity_map_user);
 
-/**
- * bio_integrity_process - Process integrity metadata for a bio
- * @bio:	bio to generate/verify integrity metadata for
- * @proc_iter:  iterator to process
- */
-static blk_status_t bio_integrity_process(struct bio *bio,
-		struct bvec_iter *proc_iter)
-{
-	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
-	struct blk_integrity_iter iter;
-	struct bvec_iter bviter;
-	struct bio_vec bv;
-	struct bio_integrity_payload *bip = bio_integrity(bio);
-	blk_status_t ret = BLK_STS_OK;
-
-	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
-	iter.interval = 1 << bi->interval_exp;
-	iter.seed = proc_iter->bi_sector;
-	iter.prot_buf = bvec_virt(bip->bip_vec);
-
-	__bio_for_each_segment(bv, bio, bviter, *proc_iter) {
-		void *kaddr = bvec_kmap_local(&bv);
-
-		iter.data_buf = kaddr;
-		iter.data_size = bv.bv_len;
-		if (bio_data_dir(bio) == WRITE)
-			blk_integrity_generate(&iter, bi);
-		else
-			ret = blk_integrity_verify(&iter, bi);
-		kunmap_local(kaddr);
-
-		if (ret)
-			break;
-
-	}
-	return ret;
-}
-
 /**
  * bio_integrity_prep - Prepare bio for integrity I/O
  * @bio:	bio to prepare
@@ -490,7 +452,7 @@ bool bio_integrity_prep(struct bio *bio)
 
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE)
-		bio_integrity_process(bio, &bio->bi_iter);
+		blk_integrity_generate(bio);
 	else
 		bip->bio_iter = bio->bi_iter;
 	return true;
@@ -516,12 +478,7 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 		container_of(work, struct bio_integrity_payload, bip_work);
 	struct bio *bio = bip->bip_bio;
 
-	/*
-	 * At the moment verify is called bio's iterator was advanced
-	 * during split and completion, we need to rewind iterator to
-	 * it's original position.
-	 */
-	bio->bi_status = bio_integrity_process(bio, &bip->bio_iter);
+	blk_integrity_verify(bio);
 	bio_integrity_free(bio);
 	bio_endio(bio);
 }
diff --git a/block/blk.h b/block/blk.h
index d0a986d8ee507e..7917f86cca0ebd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -9,7 +9,6 @@
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
 
-struct blk_integrity_iter;
 struct elevator_type;
 
 /* Max future timer expiry for timeouts */
@@ -679,10 +678,8 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
 int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
 
-void blk_integrity_generate(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi);
-blk_status_t blk_integrity_verify(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi);
+void blk_integrity_generate(struct bio *bio);
+void blk_integrity_verify(struct bio *bio);
 void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index cd7fa60d63ff21..425e2836f3e1d8 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -13,6 +13,15 @@
 #include <asm/unaligned.h>
 #include "blk.h"
 
+struct blk_integrity_iter {
+	void			*prot_buf;
+	void			*data_buf;
+	sector_t		seed;
+	unsigned int		data_size;
+	unsigned short		interval;
+	const char		*disk_name;
+};
+
 static __be16 t10_pi_csum(__be16 csum, void *data, unsigned int len,
 		unsigned char csum_type)
 {
@@ -364,33 +373,77 @@ static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 	}
 }
 
-void blk_integrity_generate(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi)
+void blk_integrity_generate(struct bio *bio)
 {
-	switch (bi->csum_type) {
-	case BLK_INTEGRITY_CSUM_CRC64:
-		ext_pi_crc64_generate(iter, bi);
-		break;
-	case BLK_INTEGRITY_CSUM_CRC:
-	case BLK_INTEGRITY_CSUM_IP:
-		t10_pi_generate(iter, bi);
-		break;
-	default:
-		break;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct blk_integrity_iter iter;
+	struct bvec_iter bviter;
+	struct bio_vec bv;
+
+	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
+	iter.interval = 1 << bi->interval_exp;
+	iter.seed = bio->bi_iter.bi_sector;
+	iter.prot_buf = bvec_virt(bip->bip_vec);
+	bio_for_each_segment(bv, bio, bviter) {
+		void *kaddr = bvec_kmap_local(&bv);
+
+		iter.data_buf = kaddr;
+		iter.data_size = bv.bv_len;
+		switch (bi->csum_type) {
+		case BLK_INTEGRITY_CSUM_CRC64:
+			ext_pi_crc64_generate(&iter, bi);
+			break;
+		case BLK_INTEGRITY_CSUM_CRC:
+		case BLK_INTEGRITY_CSUM_IP:
+			t10_pi_generate(&iter, bi);
+			break;
+		default:
+			break;
+		}
+		kunmap_local(kaddr);
 	}
 }
 
-blk_status_t blk_integrity_verify(struct blk_integrity_iter *iter,
-		struct blk_integrity *bi)
+void blk_integrity_verify(struct bio *bio)
 {
-	switch (bi->csum_type) {
-	case BLK_INTEGRITY_CSUM_CRC64:
-		return ext_pi_crc64_verify(iter, bi);
-	case BLK_INTEGRITY_CSUM_CRC:
-	case BLK_INTEGRITY_CSUM_IP:
-		return t10_pi_verify(iter, bi);
-	default:
-		return BLK_STS_OK;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct blk_integrity_iter iter;
+	struct bvec_iter bviter;
+	struct bio_vec bv;
+
+	/*
+	 * At the moment verify is called bi_iter has been advanced during split
+	 * and completion, so use the copy created during submission here.
+	 */
+	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
+	iter.interval = 1 << bi->interval_exp;
+	iter.seed = bip->bio_iter.bi_sector;
+	iter.prot_buf = bvec_virt(bip->bip_vec);
+	__bio_for_each_segment(bv, bio, bviter, bip->bio_iter) {
+		void *kaddr = bvec_kmap_local(&bv);
+		blk_status_t ret = BLK_STS_OK;
+
+		iter.data_buf = kaddr;
+		iter.data_size = bv.bv_len;
+		switch (bi->csum_type) {
+		case BLK_INTEGRITY_CSUM_CRC64:
+			ret = ext_pi_crc64_verify(&iter, bi);
+			break;
+		case BLK_INTEGRITY_CSUM_CRC:
+		case BLK_INTEGRITY_CSUM_IP:
+			ret = t10_pi_verify(&iter, bi);
+			break;
+		default:
+			break;
+		}
+		kunmap_local(kaddr);
+
+		if (ret) {
+			bio->bi_status = ret;
+			return;
+		}
 	}
 }
 
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index d201140d77a336..2f015135f967d0 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -14,15 +14,6 @@ enum blk_integrity_flags {
 	BLK_INTEGRITY_STACKED		= 1 << 4,
 };
 
-struct blk_integrity_iter {
-	void			*prot_buf;
-	void			*data_buf;
-	sector_t		seed;
-	unsigned int		data_size;
-	unsigned short		interval;
-	const char		*disk_name;
-};
-
 const char *blk_integrity_profile_name(struct blk_integrity *bi);
 bool queue_limits_stack_integrity(struct queue_limits *t,
 		struct queue_limits *b);
-- 
2.43.0

