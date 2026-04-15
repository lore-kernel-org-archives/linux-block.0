Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B34373C04
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287347; cv=none; b=k1ujOrjyWBinsu/DGiT+/5dcIINq/ohaoOdMia8g1X+iKselXlXz27XnGOudKHtcLz8csRYdZIC7nKTqci6Ja97i2v3vFu0aY990DkUTikFLYNCLyVdjJUEzOGs2tcinsrA3F++nK3CH7jZxqaldBZxXaNp5+zqpw2muXd3wTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287347; c=relaxed/simple;
	bh=l7fTE9VlEFfSmy2pkBm+F7/Ddm+IndMlmmOpoX2i7Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ikHDwqWQ2bqFdYJnTYSleMyYDwDVlERBPmrlRAOqoaHZzLD12PJoi7YbmzOca8n7IbUyOowOlE6LmrYcsMEUAxQEQZybtiy6EG6FdwxZ7byR/zdPtV8gC/+kTxafzZFkRwL+SdV6zy53KQ8qGH1aSqq2QmHlQbsyswva3REgeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZEfZBtoi; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZEfZBtoi"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8cfbd15ce4aso100626085a.1
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776287345; x=1776892145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=clfooq9Q24UaZz/+kvIBa0YK7z/4tl+VbHOgN6J1VGk=;
        b=ZEfZBtoijdDo4e4egBrTPZihkg6LaDGXyoiPw8v2UCGMkaTLCXwYdFg4GgsCn+7A04
         FfZ7xdOp3Cj5mrWyhBgxeKSU7tsikrCBilykb3xLVuSe1kO2xkURBFA6Slek3hogtlw/
         /DRlWuaJ3CgTh5LfdHvFe6lSBM73wxkvSZCmS1zvG+Zjb5wtNB5hxScHAPlP9Vy4+oSN
         xyMB+NeQUgGmhgmE7PO+JU5BN/HUr40Nnxadxfj74FRNICEmYuQp1ztobTao2fiOsyIA
         Kpd9STeUbR2G/xB/gWnK0vzUI7LUu2vqIhzyvV4rAQjXyEkjE6uPtn1XSTxVMLv03MsK
         vqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776287345; x=1776892145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clfooq9Q24UaZz/+kvIBa0YK7z/4tl+VbHOgN6J1VGk=;
        b=mRTZgZXGIXVXohWow3s1VUtXsS/yJaDXau6wz8i5hkGxzSWjEHfYXjzk2TXg+jpTIY
         2w4HvKj70aj+t4t1UJybH0GGDryscYyAC+3dMTxN8pVBK3ReqD+D1NjuaaK4d5KyOdEM
         t5lzHNPTU9gXcrdavDOAjqN1+jFoduDKQZ0uzCl766U0CCU7ZmVk4yKXTAmVNX+jdiz1
         gtt4oz8T6hVY+aHRJoTgAxQmpC8NozkOoEq/AiCL2pJByhwU3ceImq4CI3Q4exdLdV7t
         X4MfGhBnyzIeuFZ4bo3cJ619bpwm24nEWSsQ4vBWjxE+PL38AJr7vlMEHGFCANhwktPU
         bcxQ==
X-Gm-Message-State: AOJu0Yxoe8PrBv4vP+4+f20wzpDBXsZQO1uKzyVOpm5GHJqPNS137YTs
	jSgeauY9kfLoJKJHYnGlO68lTHWvqfapDv5wlmP1RMUWL1XsXxGwUaWuVla3Pfd1M2aPdmXjo8T
	+T97moUTTNNxiJxI/+1jUVGQ8rBj2KcaCPWWn
X-Gm-Gg: AeBDietvOM/jPMRrq/ABg0wffM0JfxMu/zcbflHLuEhZztPAapNf3wxNpsGX4hdyvfL
	Da9hz0wwg1RzQkHc3a4psUANQrBJus108HwI/FyDOl2ToSo4tCNm2W3+BcaNeC4IGNhCsg+MfMj
	D8NJBgXd6b8AJHVyNXouizlAd3BrxH8pQ7nVeZYaaiV4bkVJ0u7qH2szkI3AX7AdqajDRteCgnp
	mpZXJfsLG2HNXoHFVl66jD2b/E3BeTpug4oLg32fPEn9hZMsPDdbJNzykESEzlNm71DopQqSSEI
	O6Uq/RvBjrFYjBw3V0f5EZyiNe3WZsR+f6jqdjoCv+Vvm8+BAg04q62H0otJ8SwzvcP9HfrX22i
	4LGijsct34BnEvuXwry9+8EosCz2pRGERUw6QRxM0Q8tNCOtKmZYeOBq1R0EYl3h7
X-Received: by 2002:ad4:5bc7:0:b0:89a:46fd:3001 with SMTP id 6a1803df08f44-8ae6a7661a6mr54472946d6.0.1776287344509;
        Wed, 15 Apr 2026 14:09:04 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ae6cbb3922sm2142356d6.23.2026.04.15.14.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:09:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DD78F34078F;
	Wed, 15 Apr 2026 15:09:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D1C18E496F7; Wed, 15 Apr 2026 15:09:01 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v2] t10-pi: reduce ref tag code duplication
Date: Wed, 15 Apr 2026 15:08:47 -0600
Message-ID: <20260415210847.1730016-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t10_pi_ref_tag() and ext_pi_ref_tag() are identical except for the final
truncation of the ref tag to 32 or 48 bits. Factor out a helper
full_pi_ref_tag() to return the untruncated ref tag and use it in
t10_pi_ref_tag() and ext_pi_ref_tag().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
v2:
- Move full_pi_ref_tag() earlier (Christoph)
- Use lower_32_bits() (Christoph)

 include/linux/t10-pi.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 2c59fe3efcd4..b6c2496866ea 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -2,10 +2,11 @@
 #ifndef _LINUX_T10_PI_H
 #define _LINUX_T10_PI_H
 
 #include <linux/types.h>
 #include <linux/blk-mq.h>
+#include <linux/wordpart.h>
 
 /*
  * A T10 PI-capable target device can be formatted with different
  * protection schemes.	Currently 0 through 3 are defined:
  *
@@ -23,10 +24,20 @@ enum t10_dif_type {
 	T10_PI_TYPE1_PROTECTION = 0x1,
 	T10_PI_TYPE2_PROTECTION = 0x2,
 	T10_PI_TYPE3_PROTECTION = 0x3,
 };
 
+static inline u64 full_pi_ref_tag(const struct request *rq)
+{
+	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
+	    rq->q->limits.integrity.interval_exp)
+		shift = rq->q->limits.integrity.interval_exp;
+	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT);
+}
+
 /*
  * T10 Protection Information tuple.
  */
 struct t10_pi_tuple {
 	__be16 guard_tag;	/* Checksum */
@@ -37,16 +48,11 @@ struct t10_pi_tuple {
 #define T10_PI_APP_ESCAPE cpu_to_be16(0xffff)
 #define T10_PI_REF_ESCAPE cpu_to_be32(0xffffffff)
 
 static inline u32 t10_pi_ref_tag(struct request *rq)
 {
-	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
-
-	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
-	    rq->q->limits.integrity.interval_exp)
-		shift = rq->q->limits.integrity.interval_exp;
-	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffff;
+	return lower_32_bits(full_pi_ref_tag(rq));
 }
 
 struct crc64_pi_tuple {
 	__be64 guard_tag;
 	__be16 app_tag;
@@ -62,14 +68,9 @@ static inline u64 lower_48_bits(u64 n)
 	return n & ((1ull << 48) - 1);
 }
 
 static inline u64 ext_pi_ref_tag(struct request *rq)
 {
-	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
-
-	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
-	    rq->q->limits.integrity.interval_exp)
-		shift = rq->q->limits.integrity.interval_exp;
-	return lower_48_bits(blk_rq_pos(rq) >> (shift - SECTOR_SHIFT));
+	return lower_48_bits(full_pi_ref_tag(rq));
 }
 
 #endif
-- 
2.45.2

