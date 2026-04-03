Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418293090C6
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245284; cv=none; b=ZaZFxztJusDtwPfuKSYCn1/sgamChhAME1hfaJXICUBbT+uxmRGr2hJ3fJJsG701451i3LxdAXU9HdlNtGSe7KbDJ0qbvuc7pDOuPr2Odm5HnhDQ9we8EU/Mj3wEPnvfwc9TYZktUPuaEYl7Fv20+aZXRslKzxljAxc3IDj1tN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245284; c=relaxed/simple;
	bh=g5gsp0l2vOBOchC0OWlOg46KrJqq0NoVOVwDQTLaxVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR/gYKMNhJYmyibFJ1jaPI5Cw2DJDHQRDwREGeyQwWhVCfamaTaOUaOtycAP7EHc6n/8HVdU3tQumuJYdcuw+01sFqjoMgSPUFF0VfJb+PnxnrIoGNOgmAlZzKmdJr4/gzDkYuAs/ewQZRXbeRX7KHQ3MQYHzHzuDTv+68Lc2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FZ+HHEZm; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FZ+HHEZm"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a8fba89cb5so1659375ad.2
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNpmXbw2grXDnIgg2ghLS/nTKNFvNfDaTGEvndg19+Q=;
        b=FZ+HHEZmKe39CxZXBdvhZjZZvmyhiwKr4sqy/hy2yNPxpJNrXZTtjEgbD8weSn/kQT
         +ba6GVCYxWJ0RCOtdKmm2TRnRxNJkyphLE6a2B5m1DANV/qrOV3jvIrLztgc3bN1BtS9
         KvTICym7qTWCE3RejXMYS+LhUkx+P0hjXmPq4M8NVWVKVxiNzvxyY4GdAdme6TQ8lcGb
         Xso/qNWc6/bM1sOhgCDcc8ta/QplEHO47FBQerY1gE16afCMBpRhAA5Da6b0KX34Eb1z
         HFTakOBDa2SrW9vqEQUUzbKA9BMaqKY3IOSh57jUrvVLedaT8kTi+XGZve817e1lf+UX
         IOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNpmXbw2grXDnIgg2ghLS/nTKNFvNfDaTGEvndg19+Q=;
        b=ry5SH24G0LoiZTMw0pwd4ab44mMbFB+5NCN1d8USKzmXfPyk9UbU6JMFLStwSsR1qX
         PU3f/wK4LsAcyEs0uZ6OTvNw+cAFBji/5rf2rgmtkEd7Ias1e3XnZbOItMkTx0q39fyl
         STw2zm5jpzBr2We4KJad1CnbdSg99MHvfxBIrrnCIQ1U2ZQoZ3ecgZj6KsG9RzPji5xi
         mRw0wipTHe5CHCaLh6EJwdunUIPmcx6N4gpZqHyPMiGq1tXD0w9v2I8UJH6ZAs3ZzajB
         sYIcUg0wufrkLXEcEyK3b8oEatpu6LN3YUgXZ5YVHlDL5loiEkknDd23okyVV5CfgteA
         SfbQ==
X-Gm-Message-State: AOJu0YwCB2dzFaazV7F+qk5BkkfU2Mp7EdgbUSpZLB1Qx3CoGt/PC45M
	UyFAc5kqMhyLeZQLHFaKE8DxLqAyjiwDBie0J3CP0g4PWQl83u+JzI3Ky0UxoZwIDIiS9f9GEU6
	yWkA2t+5+8NiOJrLLU2fGnkrdvi/fPotQ7F6zHOFOIwi+f72Xr1EZ
X-Gm-Gg: AeBDies7R+XfxPvHMah5UcBdTPQNx9F5EwIFZEpa4GOjZo7qX4StTyFHoVetaIGdqB8
	Yuorli7nYSlLYPOmsnznQoDKQdWn3d/3hSljd+FuuFsyanoU8Q2RoW2kw/t6xaj93q2avGH0+O6
	SoxNnlDl0oI6W12xgOo+2zYm7vH6EucmluHoa0n+n+w6sntphdM+QDsqzelX5UjiCVCFvNc+SHv
	7jThcupZeGgIiuXP//FsfPJrx2dPKf+vb1Dr8sqtu4jj0Nn+VD5hyKOQ9fu1buEMkn3FNH1HEna
	tPVcnfjH/Eful9nPnoBtxt6xBsn6dOsJjd6YG4InqWLh6H9AG3tWPbiiY+2Ov970rpFYxztUf+E
	NQJZ0MNv0jThO1lnmcytQrgXmP0NGdmkomn4E8oA=
X-Received: by 2002:a17:902:f70e:b0:2b0:ba60:7210 with SMTP id d9443c01a7336-2b28173d1f4mr25910015ad.1.1775245281579;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b27493545fsm4944455ad.54.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D7FEE34084D;
	Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CE528E41AC2; Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/6] block: use integrity interval instead of sector as seed
Date: Fri,  3 Apr 2026 13:41:05 -0600
Message-ID: <20260403194109.2255933-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
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

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 3be91c4a3d09 ("block: Deprecate the use of the term sector in the context of block integrity")
Fixes: 63573e359d05 ("bio-integrity: Restore original iterator on verify stage")
---
 block/bio-integrity.c | 2 +-
 block/t10-pi.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf047794..4be2cf649e54 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -104,11 +104,11 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 void bio_integrity_setup_default(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	bip_set_seed(bip, bio->bi_iter.bi_sector);
+	bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));
 
 	if (bi->csum_type) {
 		bip->bip_flags |= BIP_CHECK_GUARD;
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
 			bip->bip_flags |= BIP_IP_CHECKSUM;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index a19b4e102a83..36475369cd16 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -315,11 +315,11 @@ static blk_status_t blk_integrity_iterate(struct bio *bio,
 		.bip = bip,
 		.bi = bi,
 		.data_iter = *data_iter,
 		.prot_iter = bip->bip_iter,
 		.interval_remaining = 1 << bi->interval_exp,
-		.seed = data_iter->bi_sector,
+		.seed = bio_integrity_intervals(bi, data_iter->bi_sector),
 		.csum = 0,
 	};
 	blk_status_t ret = BLK_STS_OK;
 
 	while (iter.data_iter.bi_size && ret == BLK_STS_OK) {
-- 
2.45.2

