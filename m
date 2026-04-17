Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB99299A81
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391068; cv=none; b=k9fYIc8pq0/pnnSXyz1zsQYsq0TmdfB7XOvTI2zbO+kN0PmKOmgFjayB+nKsHWCumtDJ1XR95XMM+bB5rU5+T31UGceZBEDfLRzktRlNCJ5JmJzLAXTOngsZ+NxTeoBpBcEhw0trrbsNOFWs/y9ofcRcdSAyGVfo6O1yV6W+jA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391068; c=relaxed/simple;
	bh=ohy1wVq/S70Vz7N/CvoXP+q1xaLNMz098vhZKOg7jwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZZpqQdyoIcIQyNkNN4p36dJYVk7NlzBaz0LgBH2qlTkd4tZkA3EsHP2uDLYFAt/K9ww3FLBrAINL97UW9sG7n9A40+8ckvlE1HcBfb+TxCAMvH6tseV/QA3hbcbJVwy4vQ/NPIyxDDZw+BupsWrJaOi4qnIJhuGq22f0hnQGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JiCEr8me; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JiCEr8me"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-82f08a84126so16897b3a.2
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391060; x=1776995860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9pyvtNYah5iCr5GskErP9n/SMj5zNsqkI2O6P5JyAY=;
        b=JiCEr8meVletjSYNPVhWU0BNb5lHci4nAGEo1unYXQZakhLH8zwfuRyZy1DhKj1Xpg
         TD9ZoLvoSZ3sSgBWLTw3sDFJ2OCrudYfBwo7leWFDh4T6tTjDzE+GrWFCfVc5d6uEwVq
         0F/VtbZF9PT/+KY+t84yCR8O+QdvR5umPX8GPMhOOMvYu6yYE+YL6cS9I1OutNfk53Qf
         e1qz8QmFuWjxwubDjbaZHstzUZo6vcwdG5fF/XYx+YsUiXBHwSQ9NYyN3r7D6sBvV9X+
         0O9smbqZx1mFRdQIYRMrq7eV/U7yketg9Mvlx8VQZrV+YVKZKTi0mcxt+Lqa8+xwN33V
         dpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391060; x=1776995860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9pyvtNYah5iCr5GskErP9n/SMj5zNsqkI2O6P5JyAY=;
        b=TkaYSuIAEhGlmDaPP6RXedRAwBU0C2P/IrR4WA9uivj5pUOpI9oTUTWhjBQ++YtwAI
         J3pnviDYbaYHXgHpuumOq3be0wuS7cESjo8DvBinAQWtsdRIALEmsmsXs00jynoyW2KL
         sUNteE3cp9MD75ikIK/olu7vZhQwYu91VoQEvqor4ZQI53Ip4tKAaiDzhZl+Upl5wV7Z
         BmIOBlmfvePANuWoYxT/0eP19lgvuyi8hCnqkj8uom/mPTxGQOO8I4AjQ3D9bLcew0Tb
         30PFVePQeuHnPGAKfiC8+fphaXYQJCYXYYCvw//SuxFu2obmQBUvk3pHJ79fi6kEqR0q
         q8BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/V6wTA0S1j1SvdII2qPfSdy0LdpkQ8fHWwbkOmdxCgH33rfbWAAVhAMj6in5KWgyT9YLK39srihZV0RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0cD/xWpGcL72SPPxUK0G4ArJGHV2uOcgShZmDpykruTdMYQa
	iT95nLVBIFgjEnsF6Tp0bOe0hfjxrSiYPKj7AnHdWJFjD+yba18lOqaixf0Wn1pmpDnWKs+ooOp
	VhPebG+QXvGFRbeHH8lz58pMJv98wrBUBAf/28CP1wT+7mWENQ/Fu
X-Gm-Gg: AeBDietSFUqeCeP82dpy4RTPJwlVaaxPmGHfnisM0l2Bp4narnx7vx8f36fNNq61As0
	CQsUPzkBxb9Td5w/7ClHYTTyDy6Z+ruM/FV13I5mONcLnCo/Bhz0tPx7bqouT9vfFoOxctANn/D
	2TLhQzMsggW8akQOKWUlL/EPVqCmIMvxzkbW/so/HU1xRn5vp7MIieejtY4b95s4M6qPIp3zFHo
	C8ycvQ/Pis5WjbOPXkzFuqnsM7DouICU3KjgWlD+Hrxuxy6+vcJCIe1EyM5o0es2D+oNtui7J3w
	r8AQZmO3+Jldn/IlHevnxGqw4B2i7AEg09cv+IHcsVJyGnps2dIXX7DGA4vOgJDicMLlXhacQGb
	vLxFZgI0bmKCIvb9JfACiyA0ooiqHDr8Vrb6CKNurjsEPW81iVw==
X-Received: by 2002:a17:903:3b88:b0:2b2:ac6f:104b with SMTP id d9443c01a7336-2b5f9e79f5bmr4284705ad.1.1776391060519;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b5faaf81b5sm203705ad.40.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D6079340796;
	Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D2633E406BE; Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
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
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 1/6] block: use integrity interval instead of sector as seed
Date: Thu, 16 Apr 2026 19:57:27 -0600
Message-ID: <20260417015732.2692434-2-csander@purestorage.com>
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

bio_integrity_setup_default() and blk_integrity_iterate() set the
integrity seed (initial reference tag) to the absolute address in the
block device in units of 512-byte sectors. The seed is correctly
incremented/decremented in units of integrity intervals in
bio_integrity_map_iter(), bio_integrity_advance(), and
blk_integrity_interval(). As a result, the ref tag written or read to a
particular integrity interval on a block device with integrity interval
size > 512 bytes varies with the starting offset of the read/write.

Convert the initial seed to units of integrity intervals so a consistent
ref tag is used for each integrity interval.

Fixes: 3be91c4a3d09 ("block: Deprecate the use of the term sector in the context of block integrity")
Fixes: 63573e359d05 ("bio-integrity: Restore original iterator on verify stage")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 3 ++-
 block/t10-pi.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf047794..3ad6a6799f17 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -103,12 +103,13 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 
 void bio_integrity_setup_default(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
+	u64 seed = bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
 
-	bip_set_seed(bip, bio->bi_iter.bi_sector);
+	bip_set_seed(bip, seed);
 
 	if (bi->csum_type) {
 		bip->bip_flags |= BIP_CHECK_GUARD;
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 			bip->bip_flags |= BIP_IP_CHECKSUM;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index a19b4e102a83..e58d5eb6cefb 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -308,18 +308,19 @@ static blk_status_t blk_integrity_iterate(struct bio *bio,
 					  struct bvec_iter *data_iter,
 					  bool verify)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
+	u64 seed = data_iter->bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
 	struct blk_integrity_iter iter = {
 		.bio = bio,
 		.bip = bip,
 		.bi = bi,
 		.data_iter = *data_iter,
 		.prot_iter = bip->bip_iter,
 		.interval_remaining = 1 << bi->interval_exp,
-		.seed = data_iter->bi_sector,
+		.seed = seed,
 		.csum = 0,
 	};
 	blk_status_t ret = BLK_STS_OK;
 
 	while (iter.data_iter.bi_size && ret == BLK_STS_OK) {
-- 
2.45.2

