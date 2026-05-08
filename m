Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599A351C06
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220528; cv=none; b=KsO6t00OuUGwTjf2UU0Ue0f6QhCqNfIDHknX7eAHA7fXpI5ADIXYGcBg23ArWTpOFZ17cw65uQuKELfEIDLsPwdZuS6eSwLKYCgB4V+ikHA1VNaeRMjLL3OSpDcJKsARAFzdlozYwPtj86+Q2likKYA9e5HJJJyiLj+/NWj5BzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220528; c=relaxed/simple;
	bh=FyN27PCxe7idHEb0M9IbW6EmU5wzpxP1oM6GSGDaxlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhUqkRv/s3oTocBnkfmKmrWlmfU8R2nOcWBm79pWjP266FPKH6vJcddCfWzVCA2tRF91nEeHEqYXt+J+d6hxKwb2Yz5i8RahBCzu6HECj0yhmXbqvdZZhYpA/6buLsusRI0ejEPhR0eNh/3kQ1zN4hfc+5w/3SUhyLsBPMpyx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq8LMJCy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq8LMJCy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3650453fb28so1007547a91.2
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 23:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778220520; x=1778825320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2lOcE/NP78qCrPw4J8Q2tX1lxKRSjJyhRJEj/5K+f4=;
        b=Uq8LMJCyhNVwF6uiTHJWYg5x3MdhlHE2y3y26N52ZLn2c83Syil7b6CpO8ueQZnDsZ
         0IKI/qZ8QRT7zm6j+KyXiw7cATrWv2qYwvaCjgYcwAdQEnDZ/OwXYObtapWFWJHGVppD
         TuXRq+hWfRUdsWLtclU3EoFiZMehvHRWDQX7HEyGpdZVRldLDMS00PjUEywXxloA/HJx
         PppzounWEzqdysqUzz/57FEtcX/n49YTVL1ODvOS+orzzrmBRLhSc4GADoVzTqtamLwe
         aOynqz4YTqqb1QaWuZ4Vn1SZiOl4sWocN/atToRNLcrEGzR7KRCORyemFc+miR0VGKS8
         bZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220520; x=1778825320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2lOcE/NP78qCrPw4J8Q2tX1lxKRSjJyhRJEj/5K+f4=;
        b=B7WoYf6q1VlH1wIr35XokIBFPztRAJ2Gxy5eY8E1sio8WN5Je59eb0Q8t2985RB4nR
         zFOn+pXjl0jWWppKvPgjnTAf36IFI6m0ARd5Nu8E2XN2yHOxBSnUXk1U9CajGiU3u/2g
         M1jsGngv4rM9PVqKaF4D1nc4cE2Z885exceOF2X4l0KK17WqbbEprqX3NZ1fpfj5XChD
         pOkFG5kf1FJGFmlhvnYf4X3T65zDOc8kdp2pzn+KzmWtUVgosfFXRyy8fKcUAA4FFwYc
         kQCUb3ZGRmH740yqBaBXuLjHVo8T3w0Dn/Dnmr1qe9aYoXO3eqEFoAKq60z2inZu/IDQ
         4G1A==
X-Forwarded-Encrypted: i=1; AFNElJ/df4+kPwSyvo40ZRTZ2uR7VCH2mWIZDljOeZocMC4EBy1j/2bRXA72wIct6+SloSOoz4N9VXAGhklaXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFk90VRtA5XqU3ZcQ1blfu2zncZiSATyQxNBlYAKv5DOHziwRf
	0Q6qZzPncQgdarPn9Vw9lxoxQApo4hiJy3cqwYKUxxn3k0VfxtdctPy+
X-Gm-Gg: Acq92OEA2JB/cbNJWE0oB9DSMnjjKfncAJVIO+262xRg3QLMRvpJqGMIT3yL1DkJ9uG
	N711CHR6gZ3Iymi9xhgSJ41GY6cHANiEEfCYq+Lg/7UAigQu2pmVqH6E5kFYP51ZvzV8xvLwbM6
	5n5wl/WU92gtw9ad8Df4Sw002ITz7F37Cw7xmuTu0LDtJaFPXSzWW3YizyHIiq/YeLgqp8c9Cav
	cJ4+FShiDSeJH8c1tTjR13kEvYri14bBnNuxarFWRaaqdsirGAbx2WPSKN4cwYvTR539Xyag2d6
	cjo/pspzrDXp+5TppDLiJ3VpG0TiAeVK3VMGStbkIB/pTwRcPCV0QHZpoLf38Hsl9g3k/eNl3mi
	hcKF+q0CnluCzLZ6KuuCko7Bp88y3vBN4DE5YpoZeToX5m/Xy3d9ubDS0QXNnfQ95X/7ZXVMDEG
	ako8lsl77bJGlfO76WKCwixWMrd2JIHgoMmZWdcA==
X-Received: by 2002:a17:90b:1c8b:b0:364:534b:a898 with SMTP id 98e67ed59e1d1-365abad59c2mr10570996a91.8.1778220519914;
        Thu, 07 May 2026 23:08:39 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36645bb9c02sm673651a91.1.2026.05.07.23.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:08:39 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
X-Google-Original-From: Wenchao Hao <haowenchao@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Cc: Wenchao Hao <haowenchao22@gmail.com>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v3 2/4] mm/zswap: use zsmalloc deferred free callback for async invalidate
Date: Fri,  8 May 2026 14:07:22 +0800
Message-Id: <20260508060724.3810904-3-haowenchao@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508060724.3810904-1-haowenchao@xiaomi.com>
References: <20260508060724.3810904-1-haowenchao@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register zswap_deferred_ops to defer the entire zswap_entry_free()
to the WQ_UNBOUND worker. The invalidate hot path only stores the
entry pointer into the per-cpu buffer (512 entries/page).

The drain callback performs the full entry teardown: lru_del, zs_free,
memcg uncharge, cache_free, and stats update. On deferred failure,
fallback to synchronous zswap_entry_free().

Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 mm/zswap.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 4b5149173b0e..3f23ddbe525c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -270,6 +270,8 @@ static void acomp_ctx_free(struct crypto_acomp_ctx *acomp_ctx)
 	acomp_ctx->buffer = NULL;
 }
 
+static const struct zs_deferred_ops zswap_deferred_ops;
+
 static struct zswap_pool *zswap_pool_create(char *compressor)
 {
 	struct zswap_pool *pool;
@@ -289,6 +291,8 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
 	if (!pool->zs_pool)
 		goto error;
 
+	zs_pool_enable_deferred_free(pool->zs_pool, &zswap_deferred_ops, pool);
+
 	strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
 
 	/* Many things rely on the zero-initialization. */
@@ -777,6 +781,36 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	atomic_long_dec(&zswap_stored_pages);
 }
 
+static enum zs_push_ret zswap_deferred_push(void *buf,
+		unsigned int count, unsigned long value)
+{
+	unsigned long *entries = buf;
+
+	if (count >= PAGE_SIZE / sizeof(unsigned long))
+		return ZS_PUSH_FULL;
+	entries[count] = value;
+	if (count + 1 >= PAGE_SIZE / sizeof(unsigned long))
+		return ZS_PUSH_FULL_QUEUED;
+	return ZS_PUSH_OK;
+}
+
+static void zswap_deferred_drain(void *private, void *buf, unsigned int count)
+{
+	unsigned long *entries = buf;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		struct zswap_entry *entry = (struct zswap_entry *)entries[i];
+
+		zswap_entry_free(entry);
+	}
+}
+
+static const struct zs_deferred_ops zswap_deferred_ops = {
+	.push = zswap_deferred_push,
+	.drain = zswap_deferred_drain,
+};
+
 /*********************************
 * compressed storage functions
 **********************************/
@@ -1647,7 +1681,9 @@ void zswap_invalidate(swp_entry_t swp)
 		return;
 
 	entry = xa_erase(tree, offset);
-	if (entry)
+	if (!entry)
+		return;
+	if (!zs_free_deferred(entry->pool->zs_pool, (unsigned long)entry))
 		zswap_entry_free(entry);
 }
 
-- 
2.34.1

