Received: from mail-vk1-f232.google.com (mail-vk1-f232.google.com [209.85.221.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D937646A
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782541181; cv=none; b=GHJmwSlsigSRT8VwrdEDglMYHNk9r4Gz+djaJgORoOV7Ub3WxTJ36BDfPY2mm8tBwaCZ0wnIGUhC/p1/QVcRgD0iYXnvh/HqQ10hnm7+kZfO827LI9U0pcfElNJQ9Ge311TxgjQ7FY6ZOQ8c3+RDsJEy/yOp5Jr6puqXL7ZXxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782541181; c=relaxed/simple;
	bh=WH2EmK113vtygaAYNvnSohGHKmLaHR8HBcvB+g+o0J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltOBoyl8cV/urjK2wxIHas4HzwVPOE7i4e0Yti3hm3n4RTIp/w0kNaqZzPEKLETj8BRelfFKKPdWMDsoGnifGE5UITSUZRuYV2z0uW3XSAZqO988zROET//NV/PM11FweLEJGkzuqcDa3Xa4vJDDR2eb+mOZtD02Kw5hMah13Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Hed5foT8; arc=none smtp.client-ip=209.85.221.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Hed5foT8"
Received: by mail-vk1-f232.google.com with SMTP id 71dfb90a1353d-5bd6cf9ee13so48531e0c.2
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782541179; x=1783145979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXbtz+s99vB1QCMmnC1aR8CIIYeKhTXyxwg1XNiOcIg=;
        b=Hed5foT87L19rRG2htqCF1gmK7cBbnMfVKNHUCuEvAzGVGTwNIANpBNc13fqFKocGi
         tIZZRalBcBXFfW2BecRjMryRyV22nCoALHlaqeiTFjWg2dwtt075vS7TtYJXt0Q7v8JF
         8BPdkRft8nVWQsU67AOzDNCOpK9YdlHpwz8L8HJVNoAbJQMqcxDTVjundq1/kNKTy5g/
         W4P4DkjrXCYkTsh+B/Rk88cby8jwIqpiFMriAwAdN9R6b1z0ARTdoV04sLFtNItI1anL
         NaTFGIeadOza2+SlyjRQHW+LJ+2i9YkzN8hsL8hwhBQaEt7ENSk5Od5c6x4HRCcgmpOk
         ZAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782541179; x=1783145979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXbtz+s99vB1QCMmnC1aR8CIIYeKhTXyxwg1XNiOcIg=;
        b=kov4u1/3YuCnyYMsWAdhftJ8LZlE++iKjS3hX4EB2dUusfrqL1A6qvBPsp0x7hmrpT
         LINHmxNvONkyW92HeDKCRfwLNNm1dkGY41v6h3BArt9AJyipTojuczTI64AcLJj1Mq6q
         RICcS4fn/+y5qh8GFFDZ5PdMRNJ+xVVwBB4MbXrbs03tmJKQ14EYKB3+yxhbm/8t+uSU
         dndWzNwzE5n5aUu8WPxh1r/kzk1n2ImIYRPmPjNHUuTWZbamaJnRCsBjZHsG4bZUjYiL
         vvuxM+QYiOk6l8hekxkv/MgmlUq/50YDFQno1/CLkDN05BzcQPj2MQVf7RgtPjYSiiwN
         E47g==
X-Gm-Message-State: AOJu0YydMmDvWnjjoiPpEeZUyZer403EnBdBsX56bhcvf78U445+bMhZ
	XWELWR7YY6m7zuNBh6jIBus4YH1vUrwcDDWtpn+aGoF319VQOr7zS0azgH+bnpTmZ0719tWopkt
	B0gB43Hx9wzVqRopgQb67YSTM3rbAKgIuMgtBHLPgPezP3PSPz4HX
X-Gm-Gg: AfdE7cmcJs8zEIyUzXVLgAZ0wET5YqJpAT/DLDIvbtywoVKKHcoV8rSBMw444dEvTQX
	6I/vIMnIlT2OWxPhKVNEPMC/+O8mIgDfUF7jrxjB0c81odBRtNl2UsaZCHpPevlesii0cy41mXe
	UaccLMV0J3QUvkrCgBbnSNWYb8rndRgiOxtkV7zzOR4k+3OmCiG2OR7U7ZG+xIdHncdZlfaE9vB
	scu68Q5/cnPe4doM0K+It+5LugX1zmsZ9FglUn5plst4c5icJSkg3OACjyIzSHSWAC8Rph8wvHg
	XnkH2gs/fquGRtr8Y1R35sc8ZvAcLydk+0lnkdsNwtJWi5glEEABxeVt/leCz67JQmwPCRcycBb
	yU93ZnosyUDEs4GegVyP3my+vNuto
X-Received: by 2002:a05:6122:1079:b0:5aa:82ce:d15a with SMTP id 71dfb90a1353d-5bd69dc9a16mr1359420e0c.3.1782541178906;
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5bd78e656cdsm515052e0c.1.2026.06.26.23.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 056FF402B1;
	Sat, 27 Jun 2026 00:19:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 032BEE40789; Sat, 27 Jun 2026 00:19:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [RFC PATCH 2/2] nvme/core: advertise BLK_EXPECTED_REF_TAG_CAPABLE
Date: Sat, 27 Jun 2026 00:19:33 -0600
Message-ID: <20260627061933.2187447-3-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627061933.2187447-1-csander@purestorage.com>
References: <20260627061933.2187447-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NVMe Read, Write, and Write Zeroes commands include an (E)ILBRT field to
specify the expected initial reference tag for the controller to check
against the ref tags in the protection information buffer. However, the
NVMe driver currently always sets (E)ILBRT to the lower bits of the LBA.
The block integrity layer generates/verifies the PI ref tags according
to the bio's ref tag seed, so it must "remap" the ref tags, adjusting
for the difference between the ref tag seed and the absolute integrity
interval number (= LBA).

If a request has an integrity payload, set (E)ILBRT to its ref tag seed
so no ref tag remapping is required. Set BLK_EXPECTED_REF_TAG_CAPABLE in
NVMe devices' enum blk_integrity_flags to skip the block integrity layer
ref tag remapping.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++----------
 include/linux/t10-pi.h   |  5 -----
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..8202ca706c97 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -914,34 +914,34 @@ static void nvme_set_app_tag(struct request *req, struct nvme_command *cmnd)
 }
 
 static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 			      struct request *req)
 {
-	u32 upper, lower;
-	u64 ref48;
+	u64 ref_tag;
 
 	/* only type1 and type 2 PI formats have a reftag */
 	switch (ns->head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
 		break;
 	default:
 		return;
 	}
 
+	ref_tag = full_pi_ref_tag(req);
+	if (blk_integrity_rq(req))
+		ref_tag = bio_integrity(req->bio)->bip_iter.bi_sector;
+
 	/* both rw and write zeroes share the same reftag format */
 	switch (ns->head->guard_type) {
 	case NVME_NVM_NS_16B_GUARD:
-		cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
+		cmnd->rw.reftag = cpu_to_le32(lower_32_bits(ref_tag));
 		break;
 	case NVME_NVM_NS_64B_GUARD:
-		ref48 = ext_pi_ref_tag(req);
-		lower = lower_32_bits(ref48);
-		upper = upper_32_bits(ref48);
-
-		cmnd->rw.reftag = cpu_to_le32(lower);
-		cmnd->rw.cdw3 = cpu_to_le32(upper);
+		ref_tag = lower_48_bits(ref_tag);
+		cmnd->rw.reftag = cpu_to_le32(lower_32_bits(ref_tag));
+		cmnd->rw.cdw3 = cpu_to_le32(upper_32_bits(ref_tag));
 		break;
 	default:
 		break;
 	}
 }
@@ -1889,11 +1889,11 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 		break;
 	default:
 		break;
 	}
 
-	bi->flags |= BLK_SPLIT_INTERVAL_CAPABLE;
+	bi->flags |= BLK_SPLIT_INTERVAL_CAPABLE | BLK_EXPECTED_REF_TAG_CAPABLE;
 	bi->metadata_size = head->ms;
 	if (bi->csum_type) {
 		bi->pi_tuple_size = head->pi_size;
 		bi->pi_offset = info->pi_offset;
 	}
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index b6c2496866ea..5cf4859877f5 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -66,11 +66,6 @@ struct crc64_pi_tuple {
 static inline u64 lower_48_bits(u64 n)
 {
 	return n & ((1ull << 48) - 1);
 }
 
-static inline u64 ext_pi_ref_tag(struct request *rq)
-{
-	return lower_48_bits(full_pi_ref_tag(rq));
-}
-
 #endif
-- 
2.54.0

