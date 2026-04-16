Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF81C8604
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298972; cv=none; b=g/slnCi6hVWz7xBlYJB/rwBnReitLgLgFOFTlWa51WvX2f//+p283kOSGKC1DoEuKD4qQYr86mDN3cDy3z5IyVyVjtHURA1aY+JAt/5AIW4ZiftsYjoUEfmmru01ao2T0l4pPiq0L3h4e/FLRdupYIBfK3C1eK2w+RZumUuVs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298972; c=relaxed/simple;
	bh=6u2eQeY0Lhyo5ekAE6LH777nKiK783xX+W0PH9Nuc34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFFHvwp6lrLSgsnOFU/BDCBattbli3rH9ktfVWV/qQ5G9/MSx702zNxF4dgE+rpIAkNwklynutHZsWrTd8yf2EhNua3rzH2DQYeg1h4gwmMIYPZ5H+iNobW6+j0AeIIjow6T4jzisBPVfe1Eeh6iJvrg4w3cXnP72r1gYvoNzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dkgDVyMy; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dkgDVyMy"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-67e28842506so183207eaf.3
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298969; x=1776903769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzSVBmed9WYVjt5dbtSGKrtqNS44dOqqrQiFxuenj2U=;
        b=dkgDVyMy0QHqAbKAxk9WtDu6FS8z1cyPyIYocHtfgY15ho+jwpjfsDKvdvBQ96jFWm
         01Zqp/LjkmxfhL/nHScpoiIX2iwaS2BZoNtTRchEHQU8eEf9yffDuIteryHFCZKYqYzS
         z1LgIHhjTrpPQIJSlSmTzyAGnjfXwabUo9uYQwPKuCMoauFsk7f0DEkWqSLksrxGZ0ZZ
         0SDlW7N8H6ifjBpaE2AAZ5JEH0/ZDUP15fv+MMT3RCY3+DtuslIsX7WiysKtsf/lcj9S
         NrjJVQ6IN5XIYryb0adVP2WLecKePL6Rid/8refVFi8nMQKo2rcozpx0AACsWs9F6h+b
         1o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298969; x=1776903769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tzSVBmed9WYVjt5dbtSGKrtqNS44dOqqrQiFxuenj2U=;
        b=slwSvnDiI5PS9RkgVOhle5IZBWTQrQGVR0wtS98cO+/zO/lGbsn4bhISfror0yIWhN
         BafB+0cuzEetuCBw0IPSQ+eGQryYQaYGSLmHFa2ms0HRqCqzJ4x5Iwl8WpFt8PsIaLLd
         QvJl809JEtI0XHSfEVXjEO+ev24vTVycuVBYp/4iNm179lYyZ+0Z7iizPkFJEAz1cR/C
         6HxONMD63/cSEwi1vXTDdtelDO5CGRrqDzP6KutZgGfeFC10dZD3Vnupf0XGn9acxeOm
         sYmUbMPmpNcCqWAAhJbciH0a33yDjmg49awEAS7KbNBXM6+7UUudKSMWr2nxKje0kQeI
         S3UQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wM3+MthDqy1WkCQHgu6//pMBHLLiP2H27RgDPoK0vOq+b7NstdB8UrWR2wolRMEJEHRThA81f8LnuSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIB/MTdT1ita+yqUvOnwdZZzY4fcrNNbBvQlbyLBlQLwkLdrFz
	ZXzBQCPdzWBFiJn6SC8waZF9h7VfU2O4NoDT/WxxBGqWPBmyfnzMPu+81sa6xitGPXPqFkxQ40d
	aWfqpTZYfJXuIHkEe/7baFoFnGbEjNNs6dF796eO+8SIgmsm+PTDA
X-Gm-Gg: AeBDiev6+n4drIlkkqmrqobjEpj7dE7ZeOV7efJNwDQCurhWAfGsJFzbO1It6f8aCMo
	MA2QxZeQ080tK01y6ZIX7shoYlSAyEMkJytPXYvvF6ecN6m2s3XrnXfUZE/m2onrsgvQWVZElUS
	2/GDVBWE099dWzLEpp1ZC+JzGSq9m2oTCW04FAJQBu7Snc/ldhLGjlku0Az4sMqy+CbeNK0Ms3Y
	9sjNvKhPDT5LjzIKRGe+Ic8R6Jmo/IYgG6WaGSKntiVcVXHZoU/W+hWHMT99CQdEKH2iPBL6uOB
	Hq/PZaPD3io3ikra5dSsEsH9e0mY6MTbW9nrIw/miDjzUjO0GapVvrKLamXE1RAXVYGnTorUoZb
	AcylKrDF6hRs5yv7cQ5oX+PfjzwdOg3w3Jhc+9dVcSbuQqby9kQ==
X-Received: by 2002:a05:6820:488c:b0:67c:3021:908a with SMTP id 006d021491bc7-69456aa5cd1mr88818eaf.3.1776298968643;
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6932ac7f504sm219057eaf.9.2026.04.15.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8BA1E3422C2;
	Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 80EF3E41B93; Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 6/6] blk-integrity: avoid sector_t in bip_{get,set}_seed()
Date: Wed, 15 Apr 2026 18:22:14 -0600
Message-ID: <20260416002214.2048150-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bip_set_seed() and big_get_seed() take/return a sector_t value that's
actually an integrity interval number. This is confusing, so pass
struct blk_integrity and struct bio instead to bip_set_seed() and
convert the bio's device address to integrity intervals.

Open-code the access to bip->bip_iter.bi_sector in the one caller of
bip_set_seed() that doesn't use the bio device address for the seed.
Open-code bip_get_seed() in its one caller.

Add a comment to struct bvec_iter's bi_sector field explaining its
alternate use for bip_iter.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 block/bio-integrity.c               |  5 ++---
 block/t10-pi.c                      |  2 +-
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 14 ++++++++++++++
 include/linux/bvec.h                |  1 +
 7 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3ad6a6799f17..e9ae5db99f64 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -103,13 +103,12 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 
 void bio_integrity_setup_default(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	u64 seed = bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
 
-	bip_set_seed(bip, seed);
+	bip_set_seed(bip, bi, bio);
 
 	if (bi->csum_type) {
 		bip->bip_flags |= BIP_CHECK_GUARD;
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 			bip->bip_flags |= BIP_IP_CHECKSUM;
@@ -472,11 +471,11 @@ int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
 
 	it.count = integrity_bytes;
 	ret = bio_integrity_map_user(bio, &it);
 	if (!ret) {
 		bio_uio_meta_to_bip(bio, meta);
-		bip_set_seed(bio_integrity(bio), meta->seed);
+		bio_integrity(bio)->bip_iter.bi_sector = meta->seed;
 		iov_iter_advance(&meta->iter, integrity_bytes);
 		meta->seed += bio_integrity_intervals(bi, bio_sectors(bio));
 	}
 	return ret;
 }
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 787950dec50a..71367fd082bd 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -510,11 +510,11 @@ static void blk_reftag_remap_prepare(struct blk_integrity *bi,
 static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 			       unsigned *intervals, u64 *ref, bool prep)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct bvec_iter iter = bip->bip_iter;
-	u64 virt = bip_get_seed(bip);
+	u64 virt = bip->bip_iter.bi_sector;
 	union pi_tuple *ptuple;
 	union pi_tuple tuple;
 
 	if (prep && bip->bip_flags & BIP_MAPPED_INTEGRITY) {
 		*ref += bio->bi_iter.bi_size >> bi->interval_exp;
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2d9e8901df4..2c4b312f2f55 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -218,12 +218,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-		     (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bip, bi, bio);
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 		len = min_t(size_t, miter->length, resid);
 		rc = bio_integrity_add_page(bio, miter->page, len,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1087d1d17c36..4e0fa91a08fd 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -706,12 +706,11 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-				  (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bip, bi, bio);
 
 	pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_size,
 		 (unsigned long long)bip->bip_iter.bi_sector);
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index af5178434ec6..edcd0855abba 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -56,21 +56,10 @@ static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
 		return bip->bip_flags & flag;
 
 	return false;
 }
 
-static inline sector_t bip_get_seed(struct bio_integrity_payload *bip)
-{
-	return bip->bip_iter.bi_sector;
-}
-
-static inline void bip_set_seed(struct bio_integrity_payload *bip,
-				sector_t seed)
-{
-	bip->bip_iter.bi_sector = seed;
-}
-
 void bio_integrity_init(struct bio *bio, struct bio_integrity_payload *bip,
 		struct bio_vec *bvecs, unsigned int nr_vecs);
 struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
 		unsigned int nr);
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 825d777c078b..3a2e55e809c5 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -85,10 +85,24 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
+/**
+ * bip_set_seed - Set bip reference tag seed from bio device address
+ * @bip:	struct bio_integrity_payload whose ref tag seed to set
+ * @bi:		struct blk_integrity profile for device
+ * @bio:	struct bio whose device address to use for the ref tag seed
+ */
+static inline void bip_set_seed(struct bio_integrity_payload *bip,
+				const struct blk_integrity *bi,
+				const struct bio *bio)
+{
+	bip->bip_iter.bi_sector =
+		bio_integrity_intervals(bi, bio->bi_iter.bi_sector);
+}
+
 static inline bool blk_integrity_rq(const struct request *rq)
 {
 	return rq->cmd_flags & REQ_INTEGRITY;
 }
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d36dd476feda..3dc88f5cd367 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -76,10 +76,11 @@ static inline void bvec_set_virt(struct bio_vec *bv, void *vaddr,
 
 struct bvec_iter {
 	/*
 	 * Current device address in 512 byte sectors. Only updated by the bio
 	 * iter wrappers and not the bvec iterator helpers themselves.
+	 * For bip_iter, this is overloaded to represent the integrity interval.
 	 */
 	sector_t		bi_sector;
 
 	/*
 	 * Remaining size in bytes.
-- 
2.45.2

