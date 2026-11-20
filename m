Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157295;
	b=OF62m06Fspf9YexZqtcv0iXH0YJ8LMlPMGUDv5gr8ObNpwdyq/GWqc5vuuHgxc2x5iR9
	 18FVZ6mZTpUADIzGRByv1SsdyDIL9778l2oaq/bd0h+quo6TejsBU6hx7Nc36oOg6SSEb
	 dRm5MqA0TZhRGA3ThxUM5etetN8Ef6YepLzYwYoqpVJBSvbKCjoChCUHoMmbiUzXS/M2v
	 ror6UB5JrmNvE0w+UcgH8LhChXbT/6djQGqfpdQZY3zOFr3sUgqd5oXW4u/HvBocSEugH
	 hOTgTb1Mnnl2T/CbahIa3zp+QOzhLCyhJgMMe/5IYqO5YXN71yleGslTHkk8o3LKgQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=m9mm5+7Hc6lezEU2Ja7irFZ2zPpiy3QWaS35ycsd9PY=;
	b=UkfyeWKbxOt0PuTTLMjwddN/avH+WV53Yt3/QtThZoSxAM//B/cgcYB0kyCj2H5+xrjI
	 EOayh82j9BFV079n/aVSGxn8WFmNQGIroza+upCVR7ysyWa7AZuH74A6XBVyo3P7p+xaG
	 nyZzLdm/P1xzmHe4jyRdoCQzskkxJrCsFV50Ey2sVpg+Fs5nXVpw1IwUH3nkY53lfmLPp
	 D5v1TrF0vHTSvc1os350dWzSZ8a8H8RB+iWbzY6uT1egz6Ax56rTx2dkb75buF6/H/ODi
	 qqZTNO0H+Jp8Rs270EfKG9E/RuQHafHbb8AiNaFopDU9k5s5gyIfEMbsZxJF8VkOr/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=CwicoD2q;
	arc=none smtp.remote-ip=209.85.217.97
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92D606A320
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 06:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B92D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=CwicoD2q
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-7d2f53aa93eso11243137.0
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 22:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795157294; x=1795762094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m9mm5+7Hc6lezEU2Ja7irFZ2zPpiy3QWaS35ycsd9PY=;
        b=CwicoD2qhPQ3J1ltkzaTDequZJ++sHGYEmjODDt0RX4VFHDmH0ZhYFWaBFngTrcfpU
         fq87pmGO8XZf1+F1nh2qgRhMM2U3v7hiZY+t+W0PfQCuGxy1KAQj5socvnvmC1NvPcbm
         xGnKgzirtpOCbgaytXvyhuzuTBcVnJYnoQkMpw6O2m7SLgw8fS2daNg4B0z9wftebOZ1
         ARgPxV4MDEn2711AsJJYAh/J/Y4k5EWo9xG7ZLES7B1O6CiTn4nC7w8vlwMTiPokgv+X
         ufWYfzT78PGe0QDTvcO7aONQdCOl0/tGYEE7OIPq9mQzTJT/aTl+qlFJzAla1GwOcxzQ
         fUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157294; x=1795762094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m9mm5+7Hc6lezEU2Ja7irFZ2zPpiy3QWaS35ycsd9PY=;
        b=S/YPSuysq+qeccwNiIDHCgpEjG9zvj3D9v1pMXpZtMcUTNHj45KFbJ3rzqyGaDV9/X
         tvsUvw0CebDZ4QKyyaf5XnZfj+fbZ1qCCUOIWIC9YXv/X4U6ghGihKppuXgh6Y7AqX9R
         aAMg2zs4qlg3nCyy1nkhK+5CTVfqRlxoFH+NuPZReawd4NTwgr2aypSqGxAdYB4359NK
         IX9nQFHX6t242WRIy4Igd1WHDxC41grlHj8tiNpy/V9pFz7KB7pvbs2UvsxnN/XA/Tte
         YaQylgJbRU5RgRek8U9zpbJ6Gij/46DQsJJtCa2xnj4FSmnqxyvhgvDIyksxMz8ePNPF
         fY2Q==
X-Forwarded-Encrypted: i=1; AL+hErFGd0HYcgPtRe5CgG1tZZwRhU3QCBobHWG3skXObpA4E3d24/Xi0Z5V45sCnAMPTXBmxleYLRmfafZBMA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZU5IRX1OZ6encjIrQ84hC3NkNGvOI67Q/6NalQoGYAztfw/N7
	hWwU7gqxA2PhqAruMQ+55Ptnpwj1I1tqZHQSJKiGe3jPdraecmzHoUWrRE/nhWvY5X6VCCuv8gk
	LNGELBQWPYnNycosok2dBr+1z62FsHDeHgPmF
X-Gm-Gg: AZFdTZcDtqIjABQimITydBX/TV+EcRavF+FlJoX1cRxMRzUc8p2xmMrfsUWcA8xpaeD
	rFGdA06MwdrSaJoNCNrHRlLch9F2hyF5BOazDM36ZZWby3E9NPfVpLrvQfas9kttK/2wPQMKzac
	NGmdr1x5HcBboonl58Vk8cKCnzjw7wuVUZRIlMA4/XoLahqYlbLq3WaX/y2rOUc6xPHysCV+29P
	bedd79g8wFWdpOgde/PXwGhQbv6lSnM8a6V/cp6qTNPAR8RvXYEhMZ8jR6r9WbpQuXZ5LED4SRj
	XZDK9vhEAoy5a/g4V3wE06x26dC0+BAn2dD28wDTpE3TRqQCcnEIUUfAO1gh7t8N/lDZEBy3Eb7
	POQuaQ8Z9zhrZyBkx6ojTeFVd2xIE+YDz
X-Received: by 2002:a05:6102:8604:20b0:7d2:7784:23b5 with SMTP id ada2fe7eead31-7d72b3479fbmr956508137.1.1795157293844;
        Thu, 19 Nov 2026 22:48:13 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99e6e02e099sm222308241.1.2026.11.19.22.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:48:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.17.2.4])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 00E32400D3;
	Thu, 19 Nov 2026 23:48:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EC9D1E40211; Thu, 19 Nov 2026 23:48:12 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block/t10-pi: deduplicate blk_reftag_remap_{prepare,complete}()
Date: Thu, 19 Nov 2026 23:48:05 -0700
Message-ID: <20261120064806.752251-1-csander@purestorage.com>
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
blk_set_{t10,ext}_remap_ref() taking arguments "from" and "to". Also
combine blk_reftag_remap_prepare() and blk_reftag_remap_complete() into
a new function blk_reftag_remap(). In __blk_reftag_remap(), use the
value of prep to select which value to pass as "from" and "to" to
blk_reftag_remap().

blk_set_ext_unmap_ref()'s check to skip setting already correct ref tags
also had an extra lower_48_bits() that blk_set_ext_map_ref() lacked.
Either approach is correct since the check is purely an optimization.
blk_set_ext_unmap_ref()'s tighter condition would skip more redundant
put_unaligned_be48() calls on a theoretical block device with more than
2 ** 48 integrity intervals. So keep that tighter check in the combined
blk_set_ext_remap_ref().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/t10-pi.c | 66 ++++++++++----------------------------------------
 1 file changed, 13 insertions(+), 53 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index a19b4e102a83..5aebe582d09b 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -434,73 +434,36 @@ static void blk_tuple_remap_end(union pi_tuple *tuple, void *ptuple,
 	}
 
 	bvec_iter_advance(bip->bip_vec, iter, len);
 }
 
-static void blk_set_ext_unmap_ref(struct crc64_pi_tuple *pi, u64 virt,
-				  u64 ref_tag)
+static void blk_set_ext_remap_ref(struct crc64_pi_tuple *pi, u64 from, u64 to)
 {
 	u64 ref = get_unaligned_be48(&pi->ref_tag);
 
-	if (ref == lower_48_bits(ref_tag) && ref != lower_48_bits(virt))
-		put_unaligned_be48(virt, pi->ref_tag);
+	if (ref == lower_48_bits(from) && ref != lower_48_bits(to))
+		put_unaligned_be48(to, pi->ref_tag);
 }
 
-static void blk_set_t10_unmap_ref(struct t10_pi_tuple *pi, u32 virt,
-				  u32 ref_tag)
+static void blk_set_t10_remap_ref(struct t10_pi_tuple *pi, u32 from, u32 to)
 {
 	u32 ref = get_unaligned_be32(&pi->ref_tag);
 
-	if (ref == ref_tag && ref != virt)
-		put_unaligned_be32(virt, &pi->ref_tag);
+	if (ref == from && ref != to)
+		put_unaligned_be32(to, &pi->ref_tag);
 }
 
-static void blk_reftag_remap_complete(struct blk_integrity *bi,
-				      union pi_tuple *tuple, u64 virt, u64 ref)
+static void blk_reftag_remap(struct blk_integrity *bi, union pi_tuple *tuple,
+			     u64 from, u64 to)
 {
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		blk_set_ext_unmap_ref(&tuple->crc64_pi, virt, ref);
+		blk_set_ext_remap_ref(&tuple->crc64_pi, from, to);
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
+		blk_set_t10_remap_ref(&tuple->t10_pi, from, to);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -519,17 +482,14 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
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
+		u64 from = prep ? virt : *ref, to = prep ? *ref : virt;
 
+		ptuple = blk_tuple_remap_begin(&tuple, bi, bip, &iter);
+		blk_reftag_remap(bi, ptuple, from, to);
 		blk_tuple_remap_end(&tuple, ptuple, bi, bip, &iter);
 		(*intervals)--;
 		(*ref)++;
 		virt++;
 	}

base-commit: 6e6d4b23e92742a9f56008beb35c20ed4902611b
-- 
2.56.1

