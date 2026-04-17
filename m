Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C002DD5F6
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391071; cv=none; b=H3zWJ8KAv9dAzeRpLg5mXdxzO5K+M6ilphPh3PveC24fZZXdi/eAMpYqbQkO7iSeN4ZU7mqYFKg7tBl5crigwg9aKiyGm3I8EFrKUUQ1Q/q33cR1ZXTgCOtuqm3fpTFgigCR5ysaumG+x/qh8DjyWqDPit/Mlyr9KlGamE4b7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391071; c=relaxed/simple;
	bh=sIarZi4SDoM15BRFouM9vXGrkYDtf3itMS6IncqGb8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW+FT0rfxVIGlwldCNmM/lw/l1QatvwaYYBfV0ENo5ACrGzfa4rAOX9Vk+Cl2Jv0YOVb2v3c6PiKewtdwO24vg/87GowTWOWjxRZ7IBjVuxt0hSTmjY7+KnXz8Po2u9O2a3SVvnGs42q1WSXiwkSFyCGtftz+I54gbOgUfVpjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bfV/zaSw; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bfV/zaSw"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35e4617924eso36880a91.1
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391061; x=1776995861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g++H+r0qfX5K115kzK83mAIHId7HSerOrnUwj7zT4F8=;
        b=bfV/zaSwAaXnUNU7ZVjv+RV/R9vs9wzZxlahN0K+Nr/220ay8aZQ39BIAmF1Y8aKBH
         eMnX6pX79xeq4D2lyYA/imU8K0QhR9nbkdkH5vQeGMRj5/EIYlErTvJSlT0InLtNjuZQ
         /PudpGk7rEwNMaja1jZsY1ts1ijH7t1OvCNXGWIQo7dye5fip1lFQbt34Dlsbl+/5RkB
         g4qO1VbVAMIhxO/vltIb1F51py+NFfvD43kmIXtwEjvcdwt3ANG6uAabDXEECDB9v+eS
         b8TVSNdzJ3IlUbqKS6lSH+qPt1SFS17INfmsMwDCB1PcUOgZj5z+R1sxRrW/YKCJ6m8i
         Kk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391061; x=1776995861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g++H+r0qfX5K115kzK83mAIHId7HSerOrnUwj7zT4F8=;
        b=jDJEsgaVPTaSAjNpWmWn0+ik+HSqR67n5Xs6d9NKFWpOh3ZTzXUbRNNQZZZH/AjjW5
         7T4QhkULh9YTkqBGZsWPpQ8Tb1unsvgw/3GwvZ61eab0NOeGc6n7rTYq2x/b+A4atj/8
         9K6Ug0A4BaM9m7E0Dz9bgsop/3FgL4qK81rP0Yu8o/rpSTW9p9Bx1ZaoWCaCHflNzlya
         vGQqOJRKPOvARLv52V0Vq24hVrlQqbbqkRBFc13GNqdpJITyGOMhQBeBC+pz9RaFKPuY
         SQsDzA2V10BMXIy0Mc1VD8/9zhKjvTLFwaBDidL9/1mtkHyxAPKidW+niLK9ksGrl1rX
         svww==
X-Forwarded-Encrypted: i=1; AFNElJ9HkzpRHNjnl24t8BxHtSiGAApdEhSxbJcKLWHdJETgbtpI+ohRWHHZ25z95UTPR5n/pp2zMNv9wFyz/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDa//CHtaCUoP+6y3Uaygb9pifuj9V+XP54mLyEacA5S047zQU
	K9sZWCQwpDS6uH0Q2HWp6LVMoXqzDNk35YKPkSbly65OsDhT0Vllky0dZKfrh93TcwvSRDIJhi6
	herTHyAV38MpV9YxfHXELJLG7AxXMvzip0cHi01TN7okiw7BqtStF
X-Gm-Gg: AeBDievwOszbDON6CeT3d4hRpT7/ayFGVhARSpTT80IWR1eRbV0lDE2GGJzuq9U9k1e
	NiMaxop1ZYHP0eLn2OXMxFXFMHAkH1vIUYIvrVGiCmtSVNK1Y/N/fc1QTE+Hv/4NqjuGOz9Qp5J
	H01+z8aF18fb3y5ipEMcJtkwGjFQ8cWLtm1Gg85cwBo7Gb92Tl+hofo7jVresCIPVXv/6m07Ooz
	1FNDpCLcgIF/+6T8R7W90pKFTEKZIk4Ety0+d34fPzjFAPXm3Xgdcs2FIMI+mIOJbRjuyh61BZF
	xUZ0axNqUeffpuI5jwWLdsBXwKPT/rFvyOcuRBhQvjPGdAMz80kl/aBbIBJdloEgvq+Z1zLwdGC
	pjnCrVuvkfa+Kbz1ATo53wccmFE3aSZkp8f3JiWbpo0Dm7kFq9g==
X-Received: by 2002:a17:90b:268b:b0:35f:b47e:7225 with SMTP id 98e67ed59e1d1-361404991ecmr456269a91.6.1776391061376;
        Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-361410a19d3sm38091a91.7.2026.04.16.18.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8FFA0341D23;
	Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8601FE499D2; Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
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
Subject: [PATCH v3 6/6] blk-integrity: avoid sector_t in bip_{get,set}_seed()
Date: Thu, 16 Apr 2026 19:57:32 -0600
Message-ID: <20260417015732.2692434-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bip_set_seed() and big_get_seed() take/return a sector_t value that's
actually an integrity interval number. This is confusing, so pass
struct bio instead to bip_set_seed() and convert the bio's device
address to integrity intervals.

Open-code the access to bip->bip_iter.bi_sector in the one caller of
bip_set_seed() that doesn't use the bio device address for the seed.
Open-code bip_get_seed() in its one caller.

Add a comment to struct bvec_iter's bi_sector field explaining its
alternate use for bip_iter.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity.c               |  5 ++---
 block/t10-pi.c                      |  2 +-
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 13 +++++++++++++
 include/linux/bvec.h                |  1 +
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3ad6a6799f17..8549d9148b0b 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -103,13 +103,12 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 
 void bio_integrity_setup_default(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	u64 seed = bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
 
-	bip_set_seed(bip, seed);
+	bip_set_seed(bio);
 
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
index f2d9e8901df4..65fce51b024a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -218,12 +218,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-		     (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bio);
 
 	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 		len = min_t(size_t, miter->length, resid);
 		rc = bio_integrity_add_page(bio, miter->page, len,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1087d1d17c36..1aeb5be529a8 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -706,12 +706,11 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
 	}
 
 	/* virtual start sector must be in integrity interval units */
-	bip_set_seed(bip, bio->bi_iter.bi_sector >>
-				  (bi->interval_exp - SECTOR_SHIFT));
+	bip_set_seed(bio);
 
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
index 825d777c078b..c82b2f6fe194 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -85,10 +85,23 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
+/**
+ * bip_set_seed - Set bip reference tag seed from bio device address
+ * @bio:	struct bio whose integrity payload's ref tag seed to initialize
+ */
+static inline void bip_set_seed(struct bio *bio)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
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

