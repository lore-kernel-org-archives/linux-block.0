Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795235272;
	b=k9mcIeqPww6TPxjqixW4rzyqG5X0SziOELkUYv/jt0uoBwTvfc3wY2sUJ92L/oc3t653
	 KRlx8jUK3i0F/+QE0zGFR4yrBHVzI3o2+KPbUse5RWeH9RqGmS/INgJYce54+ljM2w17u
	 Pg3H6tbKL9kXWDo2oqdkshzOyhv6wqAMBm5L0JNsqHGxvH4N2AbZB8/9N9k4QFOzr24fB
	 BVA4gRAvMLNfFN4fDfke/SqBH9DPuUmu5CScyN5xtDrBL8mnGfCHVubl76m9XUEkr31Zd
	 09TKOx+VZ8J88EIu54pegt/NcfM4AVoU25iqS6SLNE+xkzpZLN1lOJg/UuR77yOaWpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795235272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Yi/uH6QkwQZeC/8s/khHkralPXKS62YQlHIuDLKLPe8=;
	b=m5JjnHZ54D8rk0luBrX8wXR5iEVVTsEOUwz0nwjI9AS3k2+xgC9B0wms7cajx4snU3v7
	 GumbSJZFpwgtxAYUhpEhD7M88Wmp+eWi496bOqYl0+Ju7q349HX87NmayaStgw9FRYwXg
	 9i5HwjJvl0rNmnuyRyxxq2VEcA3h9yMaLic3jXP+AwSHnTlc2lU+pvsMgE9jMwmSIg4Cs
	 JUDjWSHRMyxYzGrbKSA6Sonb4XFoHaG/gb5TxaBBzgoy9ZURZWxkZUlnMjOWgalrHr5CA
	 8k1gfBCxCcDSbX+i1vWa3PvViQTtJfbBJWjF/QlkaZIbiYqPw23CQAcGGhP/yrp4JbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=a26IRCtD;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3C606A68D
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 04:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A3C606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=a26IRCtD
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so224235a91.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 20:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795235268; x=1795840068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yi/uH6QkwQZeC/8s/khHkralPXKS62YQlHIuDLKLPe8=;
        b=a26IRCtDwTODN+RaMit+yGxvRC63u+qFT+5Nk0GzWa2B7BiknyiPwzW9oR51TRVFa4
         0Q1nv/ESRhv5a4fXglln9Jar8b4NCbch4+f1LStDWQbGhPrCj0hzJNib+W3J2W4VyqrO
         6oQQmJ212EyIrDsIkjYNeJJiyDQZiBkErW1X64J4/tgI7RnuLSMs7/uiX7wUflHpTZct
         zUc8byaXuTjS9cMimNPqSbGR75IQxoGXX2SPTctlfW/QABWeD6jk2TB0Vu2G3J+os2Qo
         Fhc2hoZSajwJhipvo1er7QCQZaLq1p0vxmVnlTV49j69CgkrGLKRykZ+FDmaovU371rG
         3/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795235268; x=1795840068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yi/uH6QkwQZeC/8s/khHkralPXKS62YQlHIuDLKLPe8=;
        b=a/WgCnnIGgwmIE1lgL5ju13AX/YaPlLGC+d8IX5lEdfwDojIqI+R0D5ICXduaamRl/
         Bk7hQTVxrB+Wa5c58bA2sUZUDKr7K6F8uUZ0Of6uCKTtmoJVrpw+VWPZaS9G54P8ndAJ
         t15fO8DwPQE/n9VvumZNWkJtwFnYCAt83yKwhqE8PhOCZTnvupgN8edbFIKOk7KZfGZk
         Tq3M7fLyZhYkCPceF6uGWoKpjOBUyJeHBZoBkU4bsiOOn+gVYTUSkIBgnE0uOdn/z5fc
         mVKw6yMPbKQ7MJBGxp6qSsFI2xRZZwyCwbsHVu9eoVUfMwmp5Mhksbt285EzY8w384eS
         0Oeg==
X-Forwarded-Encrypted: i=1; AL+hErHKQEXXvNSLiCo9qui9itbF6M5tUZwg6ITmYx1/l9eT1V2ijvOiSmDQrqOYyf/t4OKaLMf9ShtgUOCjig==@vger.kernel.org
X-Gm-Message-State: APuU4Z9FacyY/ty8gYymtp5nOoi/HNt9cYv5TEHZ4Wr6W7Yxox/ljfsV
	J8NDOEsCKFWtHdlmH2ehQBoZbBSoja2RHW8PfLwauaoM0d+oS2DZ1foqBlsaenDMmujXuUOGvhI
	ty8YJESeK4/lELZscrd8fMRIwSIiZkamFWIuQIwMLTwN0xfB1ASQG
X-Gm-Gg: AZFdTZdCMFwhZL/kNS/uK0at4FOzQW/R86FoB+BIIrS1UB5sE6Poa8Mzo0luY7qbbP3
	FAv5JsMNO5lz0z7ReCib3jrxbjSVge8v3PW94u1DP0vBoZ4agpZycUJG347htij2B6u4d2gMFcg
	PhFFpF4KMInWrg9rHD0X1QC3tvQ63Fv7ZqKHbckIrXYgoA20Rt38gFSLRc2kXIDEkV3SPDHh53o
	7LUw8gYw+MisBPSrnioRpClhQWIRuW0792iIHOJsWJXGwxjXlW8YzCzPjMh+ibMULcWOIfVuJTA
	9CZlyiEnThPMmYEERBO6IouDgWoVQClZozk1SJ07YVZPQQnT5VV2X+EvRHXEspVf77p3+/JhT7t
	uyBH2HPjoD43cbVRc0g==
X-Received: by 2002:a17:90b:3d8d:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3b41c80b970mr8003532a91.2.1795235268031;
        Fri, 20 Nov 2026 20:27:48 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41add899dsm3314578a91.3.2026.11.20.20.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 20:27:48 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [IPv6:2620:125:9025:23::204])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 58451401E3;
	Fri, 20 Nov 2026 21:27:47 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 51C29E4010B; Fri, 20 Nov 2026 21:27:47 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block/t10-pi: deduplicate blk_reftag_remap_{prepare,complete}()
Date: Fri, 20 Nov 2026 21:27:42 -0700
Message-ID: <20261121042743.1139584-1-csander@purestorage.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_set_{t10,ext}_map_ref() and blk_set_{t10,ext}_unmap_ref() are
identical except that one updates the PI ref tag from virt to ref_tag
and the other does the opposite. And since blk_reftag_remap_prepare()
and blk_reftag_remap_complete() just dispatch to the corresponding
map/unmap functions based on the PI tuple format, they too are identical
except for the ref tag update direction.

Combine blk_set_{t10,ext}_{un,}map_ref() into new functions
blk_remap_{t10,ext}_ref() taking arguments "from" and "to". Also combine
blk_reftag_remap_prepare() and blk_reftag_remap_complete() into
a new function blk_tuple_remap(). In __blk_reftag_remap(), use the
value of prep to select which value to pass as "from" and "to" to
blk_tuple_remap().

blk_set_ext_unmap_ref()'s check to skip setting already correct ref tags
also had an extra lower_48_bits() that blk_set_ext_map_ref() lacked.
Either approach is correct since the check is purely an optimization.
blk_set_ext_unmap_ref()'s tighter condition would skip more redundant
put_unaligned_be48() calls on a theoretical block device with more than
2 ** 48 integrity intervals. So keep that tighter check in the combined
blk_remap_ext_ref().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
v2:
- Avoid ternaries to compute from and to (Christoph)
- Rename blk_reftag_remap() to blk_tuple_remap() (Christoph)
- Rename blk_set_{t10,ext}_remap_ref() to blk_remap_{t10,ext}_ref()

v1: https://lore.kernel.org/linux-block/20261120064806.752251-1-csander@purestorage.com/

 block/t10-pi.c | 73 ++++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index a19b4e102a83..06d4eaa6d292 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -434,73 +434,36 @@ static void blk_tuple_remap_end(union pi_tuple *tuple, void *ptuple,
 	}
 
 	bvec_iter_advance(bip->bip_vec, iter, len);
 }
 
-static void blk_set_ext_unmap_ref(struct crc64_pi_tuple *pi, u64 virt,
-				  u64 ref_tag)
+static void blk_remap_ext_ref(struct crc64_pi_tuple *pi, u64 from, u64 to)
 {
 	u64 ref = get_unaligned_be48(&pi->ref_tag);
 
-	if (ref == lower_48_bits(ref_tag) && ref != lower_48_bits(virt))
-		put_unaligned_be48(virt, pi->ref_tag);
+	if (ref == lower_48_bits(from) && ref != lower_48_bits(to))
+		put_unaligned_be48(to, pi->ref_tag);
 }
 
-static void blk_set_t10_unmap_ref(struct t10_pi_tuple *pi, u32 virt,
-				  u32 ref_tag)
+static void blk_remap_t10_ref(struct t10_pi_tuple *pi, u32 from, u32 to)
 {
 	u32 ref = get_unaligned_be32(&pi->ref_tag);
 
-	if (ref == ref_tag && ref != virt)
-		put_unaligned_be32(virt, &pi->ref_tag);
+	if (ref == from && ref != to)
+		put_unaligned_be32(to, &pi->ref_tag);
 }
 
-static void blk_reftag_remap_complete(struct blk_integrity *bi,
-				      union pi_tuple *tuple, u64 virt, u64 ref)
+static void blk_tuple_remap(struct blk_integrity *bi, union pi_tuple *tuple,
+			    u64 from, u64 to)
 {
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		blk_set_ext_unmap_ref(&tuple->crc64_pi, virt, ref);
+		blk_remap_ext_ref(&tuple->crc64_pi, from, to);
 		break;
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
-		blk_set_t10_unmap_ref(&tuple->t10_pi, virt, ref);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
-}
-
-static void blk_set_ext_map_ref(struct crc64_pi_tuple *pi, u64 virt,
-				u64 ref_tag)
-{
-	u64 ref = get_unaligned_be48(&pi->ref_tag);
-
-	if (ref == lower_48_bits(virt) && ref != ref_tag)
-		put_unaligned_be48(ref_tag, pi->ref_tag);
-}
-
-static void blk_set_t10_map_ref(struct t10_pi_tuple *pi, u32 virt, u32 ref_tag)
-{
-	u32 ref = get_unaligned_be32(&pi->ref_tag);
-
-	if (ref == virt && ref != ref_tag)
-		put_unaligned_be32(ref_tag, &pi->ref_tag);
-}
-
-static void blk_reftag_remap_prepare(struct blk_integrity *bi,
-				     union pi_tuple *tuple,
-				     u64 virt, u64 ref)
-{
-	switch (bi->csum_type) {
-	case BLK_INTEGRITY_CSUM_CRC64:
-		blk_set_ext_map_ref(&tuple->crc64_pi, virt, ref);
-		break;
-	case BLK_INTEGRITY_CSUM_CRC:
-	case BLK_INTEGRITY_CSUM_IP:
-		blk_set_t10_map_ref(&tuple->t10_pi, virt, ref);
+		blk_remap_t10_ref(&tuple->t10_pi, from, to);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -519,17 +482,21 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 		*ref += bio->bi_iter.bi_size >> bi->interval_exp;
 		return;
 	}
 
 	while (iter.bi_size && *intervals) {
-		ptuple = blk_tuple_remap_begin(&tuple, bi, bip, &iter);
-
-		if (prep)
-			blk_reftag_remap_prepare(bi, ptuple, virt, *ref);
-		else
-			blk_reftag_remap_complete(bi, ptuple, virt, *ref);
+		u64 from, to;
 
+		ptuple = blk_tuple_remap_begin(&tuple, bi, bip, &iter);
+		if (prep) {
+			from = virt;
+			to = *ref;
+		} else {
+			from = *ref;
+			to = virt;
+		}
+		blk_tuple_remap(bi, ptuple, from, to);
 		blk_tuple_remap_end(&tuple, ptuple, bi, bip, &iter);
 		(*intervals)--;
 		(*ref)++;
 		virt++;
 	}

base-commit: 6e6d4b23e92742a9f56008beb35c20ed4902611b
-- 
2.56.1

