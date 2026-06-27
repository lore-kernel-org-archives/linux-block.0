Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4838D014
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538973; cv=none; b=sUMH3f88PyMiRhLSVBFREkpDmJwfgFMhUpTSVpIpm9r5dxTbdG4KUbScA4ZJ8nphxgA2heVG1Y12EoF6tFw6HAWdM+/vf8l5LxPicBMHehoP0xkxmixZvZaCr9aIvFeTwlaITYvMrcF35We/vmw00PYRlL4F+NGUIR+gVYhA47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538973; c=relaxed/simple;
	bh=DpRzB5nNneV2e7fuNOjzFT7N1hOW9bUMAuLBZOKGdKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUSCTboiAeIWvW4KY041R4ixypQb1ARm8n9zSykneIjBhhWAI60sopBH0LL4EFy+T8Ksj5Rl5a5eEaKYqK9oaDWlceEYqzgl2L/xNuLpWAeLrRJx5Q4wF7JUGDvsWUPCxBY6VRuIYuzRSa+gM8KR67QvIUwVeccsJzwDfgAiPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vp10ZeVx; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vp10ZeVx"
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-5aea9ee2611so33854e87.2
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 22:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538969; x=1783143769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hKeiCzbPRbTnzm/AI4vnqpxf3f5IT13bPWCisZ89M54=;
        b=Vp10ZeVx7XVjmbAa4vox2w1K6GM4lUTjADwmeyN+4UqJx+MZPzugyreZPc8U2Ctgio
         v5tpw7rg6Zx/CDa6Iv38SOVaCZF/OJlmr4I/TGiJ9YsSXvs5y6GM0NNxav49kVhFF6Bn
         uhpdI0oTu5vsSUey8FxUnpZE3CqiVDNop/ld1Oh6kh3tVO4FDD/fE1rXr5xHlIxzCsMD
         YXKwRRE5uBgk2CEzP2hCmg1R12sFaJiOs7pOzUZN3nCQ3t+1UwZSJeqdMttqSpyYfnPJ
         ceEUjhPFGaECYeyKPKIB4iA+v/+TwzmT+/Gg8J16fbQfnRlyTPs5XI5I4jO0BG54T40o
         yO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538969; x=1783143769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hKeiCzbPRbTnzm/AI4vnqpxf3f5IT13bPWCisZ89M54=;
        b=jxv0/k0JAz58bb0t+SMl44cQLu6abJV3wkeG+ALt4sKvr01LXhrbYeWl3HN9s4ZvUV
         vEym5H2K/GPgXsHIxrrkkpKnN7Pb2XeT2Hz/JT9o5BkFNn3QJxhpw6uMrVnGH6fjnj1Q
         7MCGAc8MURUoeq8PjrTjCCr6+KN/S4WKJFJQ6Wn1BUrrxgsRWmDalwpP+Xbo2I/wlG/O
         JgSlZHkI4YFsyVSoHsyhJ2bzT00+u9ncXOpsAPXCbu7G8u2R+7Bhx93qoEQ2K3orj/nY
         vX3tblO8xNbkcIsGrPy3lfq12sljMxE36zG7u42LfCdOrxGytKnKOX9M3vTj5YJbY2Ee
         6jIA==
X-Forwarded-Encrypted: i=1; AHgh+RqZCFHMJycmjL6KgaamqAf0PlXau/3bdMF70ft3SH83BorUTUztPNkPh7DBjHtrM0Nce4JsqyqVTPAyRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzcc0uJxmQzmnjnI94W57B6vGMSP8jIHkxdD28fTigUS2XAnt
	GUokV3gaZNzB7xGmGSSK9S8JJyVl/4SpD17s3Cbt91c7PnOzLD8XsPk8Nzd/BPSBzQTbL7XqhpJ
	oo3RUrru3K2ww8eFe03mru0xZw06c0DEgTdZS
X-Gm-Gg: AfdE7cld0ddQbKTAt9E8b19pbbLblIRgrlCoiVqwf6SpucWSamdz7+mTAMz+gLRA+kE
	FEIZgiX+Gi+px3ysJiaCjyCRrOhDAQ9xaEsgw45KQ3BC2JWPVRiw1fKb5MDNReQY9kjy/lNkI+Y
	mF9rRYS6/FBSXb2+PeFWQUgtwR6LSXLtpnrTNGMop/W2+ZRinZFUlml5LalbU43Yc/FNZOmAeAQ
	jbpz4PVAeu9BLKs8ERuzP8RFRNuDG1fq4/fqzuWnTIt9EcW+u9Rwi5qqW4k1jqcbabrFbiTRvu+
	uq1GZNnEwhf0kEpFTXd1szzZWV4fdEl7R0jlr9CFXGWsksNx49wvTun4OztYEjKOkMeekNPm2Zv
	+2HwTTCMRxAjzcyQZeY0xU7ax3jRsRtabwG12PiwB2VI=
X-Received: by 2002:a05:651c:2224:b0:396:8491:3135 with SMTP id 38308e7fff4ca-39acb54fe16mr10822271fa.1.1782538969173;
        Fri, 26 Jun 2026 22:42:49 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-3999b1cf17bsm15732331fa.13.2026.06.26.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:49 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 73DC4402B3;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7161FE40712; Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
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
Subject: [PATCH v4 2/5] blk-integrity: take u64 in bio_integrity_intervals()
Date: Fri, 26 Jun 2026 23:42:17 -0600
Message-ID: <20260627054220.2174166-3-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627054220.2174166-1-csander@purestorage.com>
References: <20260627054220.2174166-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow bio_integrity_intervals() to convert an absolute sector to an
absolute integrity interval, use u64 for its argument and return types.
Also use SECTOR_SHIFT instead of the magic constant 9.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-integrity.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b1b530613c34..825d777c078b 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -64,23 +64,23 @@ queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
 
 /**
- * bio_integrity_intervals - Return number of integrity intervals for a bio
+ * bio_integrity_intervals - Convert sectors to integrity intervals
  * @bi:		blk_integrity profile for device
- * @sectors:	Size of the bio in 512-byte sectors
+ * @sectors:	Number of 512-byte sectors
  *
  * Description: The block layer calculates everything in 512 byte
  * sectors but integrity metadata is done in terms of the data integrity
  * interval size of the storage device.  Convert the block layer sectors
  * to the appropriate number of integrity intervals.
  */
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
-	return sectors >> (bi->interval_exp - 9);
+	return sectors >> (bi->interval_exp - SECTOR_SHIFT);
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
@@ -151,12 +151,12 @@ static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
 
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
 	return 0;
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-- 
2.54.0

