Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18F352C4F
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220533; cv=none; b=PPz83UPWU64GIPMf1P6VNCDkMDOtPlOVgOsXGG/VyCRmXBI70hj5x82MjEHvZ1UDniwI8BXyOs97eZULk2rsGyVLLHNgV3gYFgmGspGJAH37byZEstei0SXGC30U5A6t0hQdEmVyMbiqgBYB3UyrcBoclR6NhZk961MQhOD3Zx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220533; c=relaxed/simple;
	bh=QFVoHteQkcIT+51G9kCmVEfuqfNqbnC+Yohfl+w3FDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQbkgQYzYZhg7B2zd+wqq+Z7cSCUYWQBpTbfxA3qipESzayt3Us1rI03P5H8yEdhCG9wQ7+gfXG60X4Jh+w2f8G0C+Rnp63oqCtsrY2odxYPVePTm1efTrOyJUYHXQS8KyKayrJbyn83WoBEEu4yIrxMtBPZuGZpdOUQm1skwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSuHa/Sn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSuHa/Sn"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365d712bbd2so974862a91.2
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 23:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778220524; x=1778825324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yZbCZTgQWjeOZMMSiccr5Z+zvHQMRYXTy9f6X1ybwU=;
        b=iSuHa/Sn5HvUlCHS4qwIZhc5EaB7lLK+3AMg+jnT25+mGURBpPsjDhqF0C72wXJdeW
         KDzwpTpYQkDwsgvxaOAsQebSzvUG1TZKehIvqNXMBodRp58J1ALIO4DwVF8ADIv4jNOI
         P0VFj5FyjmwLNRWL0BP4mcglV9wpYQtBYhJCp/7QPIt/hd/+EJvXqijy4UZoQnzL8lk1
         kqU1Zg1lFEpLwfix2lnay2+XjKeD1cfEqUVSuHXdZmWb76EC6afsKYv2Px1bZokSUBeD
         SJ+h32F1WSotPh6vZ8Z1tml3jxTbL15Hsece+hVS2i2vPsxgJH6UveP2AngELq1/YYAj
         mnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220524; x=1778825324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yZbCZTgQWjeOZMMSiccr5Z+zvHQMRYXTy9f6X1ybwU=;
        b=kB73tik0bRFCGXwrqpkgdH9zMIR3yQ+FMDhiosIxZ3hLygW6yfyWKmzfzTfsCYeuiV
         BfbkE+xmpHC0C6eQrbpDJs3tS64RPY7dIalTyWXhRPgatIzO7e2FJ8zmGtUQ+U9IZRYP
         PHcJPLLzoYb3YUNHmVOAYXoPde+uEAfubnY4YtgxzsGo1nz6SqpODAoSatiivDvkNrcA
         RTAOa5oWTAVYfxmmtcQLEsRvW6kp5LE4u4I4Lsk9tA44/lgaPVXDzQIzSvz+5Ls7iML6
         J4TTdHd3+JR2KZTq3LHlUxd38uDLc7VtLkkJSJa9hnO+EPpFo95P5/bUL1s6EWH4hc0T
         fmiA==
X-Forwarded-Encrypted: i=1; AFNElJ92kwkh9PD03WD5nh6k1/wPC/Uck4ksvUx0jadXaaDDJK0HAX3o0z7IF3oO0GsWZe6fPoXD3kBTtEnQlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWonVRnpiatA7Lu76C5KmtNfdYMJ7ydpzIqbFW0KqlMJKWJZq2
	KppmOV96ZQUyuucoG4qOxvxFSG01RFXLZVq1azK2tPxsJ+ysc3fWP1o0
X-Gm-Gg: Acq92OHDyz7sGppmyR2iXLYHqHXXfHby3YH8mDuBsf/fLUN+jCTUpwQZwR8/AVKe0ce
	coGS20ytPyEM+Q8f5e1e917IajXsSvSemFiKsoNH44zEAAyPPmu/Nr2bRokIsiI8MlJ9bVR1mhS
	uZOlPhVfLkUb6uyOL25jrUkkMMovNWtB+ogDrV47lEdrYkWb+tKU8twgXzY2FSOv9bKkSXdXx83
	03KsuN+/ui+bsFYxfFgnzRLDWnLGAmZmxeJLYRAf9cVcSIToi9gSkUdrbJMGN/M1UOHjTLz3NG/
	5ThPZ6+HuHRKLN0eoE4Z6EZiWdhDmKlTdx5gux72jiqb1UBLCgnEerFuvue8OaqGoiPInlM4ZpE
	uyUJBECQ+kGQkXm6WdZckJigkK931PLj3dI8JujI5lK3uSCVzrppp5313tDhw3OLUjFajEVv+H2
	ImQuqZKeVy5V2BIOL+zIgv4sfstwJNu7ygD+Vt7vLac8L2EL+h
X-Received: by 2002:a17:90b:3d0b:b0:35b:952c:43b9 with SMTP id 98e67ed59e1d1-365abcf0698mr11808706a91.10.1778220524197;
        Thu, 07 May 2026 23:08:44 -0700 (PDT)
Received: from ubuntu22.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36645bb9c02sm673651a91.1.2026.05.07.23.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:08:43 -0700 (PDT)
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
	Barry Song <baohua@kernel.org>,
	Wenchao Hao <haowenchao@xiaomi.com>
Subject: [RFC PATCH v3 3/4] zram: use zsmalloc deferred free callback for async slot free
Date: Fri,  8 May 2026 14:07:23 +0800
Message-Id: <20260508060724.3810904-4-haowenchao@xiaomi.com>
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

From: Barry Song <baohua@kernel.org>

Register zram_deferred_ops with zs_pool_enable_deferred_free() to
defer slot freeing to a WQ_UNBOUND worker. The notify hot path only
stores a u32 slot index into the per-cpu buffer (1024 entries/page).

The drain callback does slot_lock + slot_free + slot_unlock for each
index. On deferred failure (no free page), fallback to synchronous
slot_lock + slot_free + slot_unlock.

Signed-off-by: Barry Song <baohua@kernel.org>
Signed-off-by: Wenchao Hao <haowenchao@xiaomi.com>
---
 drivers/block/zram/zram_drv.c | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..0d07f0901e55 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -56,6 +56,7 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 
 static void slot_free(struct zram *zram, u32 index);
+static const struct zs_deferred_ops zram_deferred_ops;
 #define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
 
 static void slot_lock_init(struct zram *zram, u32 index)
@@ -1994,6 +1995,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	if (!huge_class_size)
 		huge_class_size = zs_huge_class_size(zram->mem_pool);
 
+	zs_pool_enable_deferred_free(zram->mem_pool, &zram_deferred_ops, zram);
+
 	for (index = 0; index < num_pages; index++)
 		slot_lock_init(zram, index);
 
@@ -2784,6 +2787,39 @@ static void zram_submit_bio(struct bio *bio)
 	}
 }
 
+static enum zs_push_ret zram_deferred_push(void *buf,
+		unsigned int count, unsigned long value)
+{
+	u32 *indices = buf;
+
+	if (count >= PAGE_SIZE / sizeof(u32))
+		return ZS_PUSH_FULL;
+	indices[count] = (u32)value;
+	if (count + 1 >= PAGE_SIZE / sizeof(u32))
+		return ZS_PUSH_FULL_QUEUED;
+	return ZS_PUSH_OK;
+}
+
+static void zram_deferred_drain(void *private, void *buf, unsigned int count)
+{
+	struct zram *zram = private;
+	u32 *indices = buf;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		u32 index = indices[i];
+
+		slot_lock(zram, index);
+		slot_free(zram, index);
+		slot_unlock(zram, index);
+	}
+}
+
+static const struct zs_deferred_ops zram_deferred_ops = {
+	.push = zram_deferred_push,
+	.drain = zram_deferred_drain,
+};
+
 static void zram_slot_free_notify(struct block_device *bdev,
 				unsigned long index)
 {
@@ -2792,6 +2828,9 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram = bdev->bd_disk->private_data;
 
 	atomic64_inc(&zram->stats.notify_free);
+	if (zs_free_deferred(zram->mem_pool, (unsigned long)index))
+		return;
+
 	if (!slot_trylock(zram, index)) {
 		atomic64_inc(&zram->stats.miss_free);
 		return;
-- 
2.34.1

