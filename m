Received: from mail-dl1-f101.google.com (mail-dl1-f101.google.com [74.125.82.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F73A7F77
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863072; cv=none; b=VnDzdzwMZAfiK35i3ypfmrbn8XbFOwOS9WOjKjmUzD1QK7bSwK8Q60GmdtzTv2B6bpOVK3c/3D4SEP64rlTpOpY67mQ9pOP/wAAEWVqsLLVhH5mOAIn8wZ1uWayd7+H3U2PEicbilt8xH07mSTC2kbucpYKe4zDrlvZTn2MRIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863072; c=relaxed/simple;
	bh=Am/NsbIssEWB9H0i0wfR0XCMC0CBLwlmllXF/BaRvgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNQvrqJC4ErR66UWu+MnyXRmh9kcD6eLtszhRNXCMS9KeGqf+TSGmAvNTIzQf0FyIVcEptopFiApV80nzJvVGAWIQ5kgNtJIS/IW+4ZQ9okUuU7tGywgnp0marc4P9LqCOmzM0XuxZg08kvGBHMCRTTTNNM80+c2O8JN93xb7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NhVWhtaf; arc=none smtp.client-ip=74.125.82.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NhVWhtaf"
Received: by mail-dl1-f101.google.com with SMTP id a92af1059eb24-11f42e9724bso227892c88.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863059; x=1768467859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PdHkxStoLKgmVMOV/xVGdqRGUULkLJrp+peytBAVxWI=;
        b=NhVWhtafqm4lcC1tp4+WW6Y1Ex36kjN5WT9uGEUetPo9K/706r0QR+nVk6o8UaWrGG
         kcxnResBcNj9yuugcETQh5RyWYPBJltw8QjMy42A2MQeElz8KwwrXeDALIUr9WLLk9oS
         2erc+CqhF5hkr1OGBwW7h88QuYaoRbbLv+voO78/Ql00UtcFs3ge+o+5ep1uFMxZzXdj
         xl5p1BbUAcPSjKHGF5mK834ckSTbqQh08n7baGHHYkKrcsYcqTkuPf0olF1+tKXsfwEb
         Sk2miXEWXrg8jCfWsPrpiR3L139jZ6nN/moqNXUOHZiJzdBakk+Fo4ojkcAfUaCsD3Mh
         j6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863059; x=1768467859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdHkxStoLKgmVMOV/xVGdqRGUULkLJrp+peytBAVxWI=;
        b=tQnwUly6K7MSZna1yG2fclBYh5MfBGV9Psgzb04dIqHRz7xa4JnGbyECsu5fZQso1c
         FB10QkX4hRO0wwrq55NHlBa4r/I0jieH6/HSwllOctmmIgJSz/7OyUED9cxb8mICmB3G
         ccWZEz6NJ1gWy8PlVB3B1oju5EakrGAA7vnAz01MBMuAbmMpQjjJyiHiGxoJKclmXTM7
         z2CH7fqN9bRqIoZBsQhM1cchFOL9n0FRQAKrzieINl/rSSM46NR2dPIhzJQkF3kdADcd
         gI3oIIzLoNj0MFK4murMFltZvYDO6hQRYn7mY2UD89fNkT+VJmg4j+GMt3EtJlAPSH8P
         BM0A==
X-Forwarded-Encrypted: i=1; AJvYcCVvuvuxRsqBkeZZAhRKefM6HJgOBQ9vPRsJ3mHNvL3sOFHU/SJd9VpGKmK5J1ZynUBk/80Gjb+5lukAMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtcbuuIHBNAEOCN1htWUI/VA6PYQCqx9DNLXVT9R4/SJ1GQs5
	wBPRf+iEi2cyoXGtn3tVP+wpPoBjyf8JAINq9Hc/2s1kOuIYwBZz2UN2casZpmHuKERMaR8HUfN
	tzupGxKDv8vYIE9yoV2MRmvtRZPttYTsldFo1Qhwp4SWkw8jSweDH
X-Gm-Gg: AY/fxX5+wigeku6bH0BEN85L7aVFicVYg4zCA1M9cKBL6XnnnkLqESrb0+vSWgegww4
	EA+b04oKAHX5MwIdCXDUGk04ToCvM1yLphBDHJmZ5mNgG24EgJqa2TA283iea/SK3TrNzMO1H2B
	Oj31z8uCITD/BrW/s+uEeYwSQbkghFz1jJZIHVHjVPBGLHvoVy5LKIHx9AA2q+1/ZTQ9S65fK4Q
	5e8KZ83U9igj8oOeOjB0GGHZFnjtOohCYRFLiyDJdB320nTYhrVukL0zKxZ8zGfg2o7I8kyOwsN
	zZFdLNXSQScD62+gYo82iUaBQj9AaKhTF56Vuwd2xnsAsnIL05o7jEOfARqeOCWVxvEIsruxwQq
	oXTXHFop1zVKz5St12idS4PRWqDY=
X-Google-Smtp-Source: AGHT+IFJzN8MKSxRPKQU7O8d5YxBPcYnaUvp+rDbCJAGQC8z4KZIh0HiLwHq/SlHNB0bu+MAJT2L1G2QmqlI
X-Received: by 2002:a05:7022:238b:b0:119:e56b:46ba with SMTP id a92af1059eb24-121f8b45a84mr2747647c88.4.1767863057049;
        Thu, 08 Jan 2026 01:04:17 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f24a554dsm1602845c88.7.2026.01.08.01.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:04:17 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7C79834052B;
	Thu,  8 Jan 2026 02:04:16 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 674BFE42F2C; Thu,  8 Jan 2026 02:04:16 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: initialize auto integrity buffer opaque
Date: Thu,  8 Jan 2026 02:03:59 -0700
Message-ID: <20260108090401.1091352-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The auto-generated integrity buffer for writes needs to be fully
initialized before being passed to the underlying block device,
otherwise the uninitialized memory can be read back by userspace or
anyone with physical access to the storage device. If protection
information is generated, that portion of the integrity buffer will be
initialized. The integrity buffer is also zeroed if PI generation is
disabled via sysfs or the PI tuple size is 0. However, this misses the
case where the PI is generated and the PI tuple size is nonzero, but the
metadata size is larger than the PI tuple. In this case, the remainder
("opaque") of the metadata is left uninitialized.
Generalize the BLK_INTEGRITY_CSUM_NONE check to cover any case when the
metadata is larger than just the PI tuple.
Switch the gfp_t variable to bool zero_buffer since it's only used to
compute the zero_buffer argument to bio_integrity_alloc_buf().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: c546d6f43833 ("block: only zero non-PI metadata tuples in bio_integrity_prep")
---
 block/bio-integrity-auto.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 9850c338548d..605403b52c90 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -107,11 +107,11 @@ bool __bio_integrity_endio(struct bio *bio)
 bool bio_integrity_prep(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_data *bid;
 	bool set_flags = true;
-	gfp_t gfp = GFP_NOIO;
+	bool zero_buffer = false;
 
 	if (!bi)
 		return true;
 
 	if (!bio_sectors(bio))
@@ -137,13 +137,14 @@ bool bio_integrity_prep(struct bio *bio)
 		 */
 		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
 			if (bi_offload_capable(bi))
 				return true;
 			set_flags = false;
-			gfp |= __GFP_ZERO;
-		} else if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE)
-			gfp |= __GFP_ZERO;
+			zero_buffer = true;
+		} else {
+			zero_buffer = bi->metadata_size > bi->pi_tuple_size;
+		}
 		break;
 	default:
 		return true;
 	}
 
@@ -152,11 +153,11 @@ bool bio_integrity_prep(struct bio *bio)
 
 	bid = mempool_alloc(&bid_pool, GFP_NOIO);
 	bio_integrity_init(bio, &bid->bip, &bid->bvec, 1);
 	bid->bio = bio;
 	bid->bip.bip_flags |= BIP_BLOCK_INTEGRITY;
-	bio_integrity_alloc_buf(bio, gfp & __GFP_ZERO);
+	bio_integrity_alloc_buf(bio, zero_buffer);
 
 	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
 
 	if (set_flags) {
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
-- 
2.45.2

