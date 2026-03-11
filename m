Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85191355F36
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258722; cv=none; b=BDivolfOvxfmtuD+NYaAcQeurDV4yi0szXQmGqI3xH8h1X31lJ4vh6p9JdmBaPgq/9VnrjhlEWIXacbJB0tcrTgsi/x1Mx+wz+3C5djj4PA2yFNAVpZjK23SU+fQXcWeVcnOF0vdGYKy01VwRMN/lcYKEXVvQBykt5zeQ4V4Zgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258722; c=relaxed/simple;
	bh=DZCEel+gASKs1YULBRoMAZRVMrRj9weWbG1mBFEBaxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfFkLAb7dePkYHujMlTW+Zsw+FPinoBUQCOZ2gMosHtaofTeaeRjAXZ41t49NtucVG/oiHWgSt65G48k1M1+XA1jB4Bg7CtWWkg0qXnWrZ4PWovZdJ11wm9jPtFSk1fQQY3y6lJ214NTzY0yCDInNF6zQ2kEVOpvCivAG9X5YaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnnNA+Dy; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnnNA+Dy"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40f387a688dso239314fac.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258718; x=1773863518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHiXRPU0oj2HIsyVL3yHXql4isoiizU2/nOjnBQn0Ag=;
        b=YnnNA+DyqHV+7WGhKKZQpaWCFo2/y8o9ZrLvOKKtAKeYx5Y70QC6p7Dho6K+SP3uGr
         jdLaja0Dkk7rA/4nKXBO4ay5zzAMM3mphLO8xAFVY9W5hfXJ0Y81CZ4f3fiGxh+0KcJp
         2lAhp/neawJfeOInaoyIQjl2cbPzGsCdRgUFDDuwwthVGI8keIC/jVHWQG6A5ikE+EWM
         bin1EuSzvpBEKnIa697x1nVWzRy5YJnnf6nVpdGhAYpdhrbgNc20mm6zvuqNx45zgxpD
         KFsXlFiKD+cEmVdQGV2GU9k/ml9Iw6qoCPXcxoI/p7/EK6T1l84qUUmdpk3dK5witaPI
         Qp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258718; x=1773863518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHiXRPU0oj2HIsyVL3yHXql4isoiizU2/nOjnBQn0Ag=;
        b=a69rKB1zjH7SGrJipXo9ZQKBsR2n1UV+IDrAPmSbcbPD+GpafHqLL9Ml7m2GlnqPLJ
         vvaxq5EaMtuFlk4Ew3fijJ9tzEKWHJOlk+9EkTT4HPsQHjraJRNDH1oaXEOa8OGRMYGl
         Nr8YYmAKlUXv5rYNlI30l4jQ7TmhkhNGVC8F/51EzuK/s4vK0klOAe7NMcveGLpO0wQ5
         GjxEeh+OkzDypOhVJ6sIp7YP4V/N+yTl/FQBLZXC3XVmSEEh4BsQ7VaB6Z+9j9nGOV9q
         QctXVNLV1q3PapidfGZq145RgDcRTRTkSQY619+4W2JYSP4puGPzjcgdIZZtW0763oaD
         Ahew==
X-Forwarded-Encrypted: i=1; AJvYcCXko9Ry2JeWFO0y1yQ3nrVTAAtiN+M37XGrtBSUXjpA84dDJbnHlByZB76l6qvhL7i0N7MmayQ/70BqkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl9GTmDo7YaTlSl2F9QjQm8nzgO7tJ9tQrE3uDasNAQRCDY1x
	8hVZHxOSx5pcvDwTnVQf+GvIOdOg5n619JpRTS74Ru3yF7XphcFhrjE2
X-Gm-Gg: ATEYQzzdz7QeoPUpb8W56kOPbL9M5mIKdSZ/vBOMUnk/kIvR4Dev/K8S5hAJid8tj8A
	fxR82us7RCFe3NG6NZfJKkeXFXGyJfae9UZ4uQe6sd7j3dYfQPOoCQJSpebymSuva02NfGLCKIH
	ZPOG+e49p77Xd7dNryEMSxeZAts02JELFRaArhtvbY7BQYm10Gg6If8c6ly6Oh8/zDh34Mphi34
	yRgamo/2pnk3rcU+HOKFYtfYifsukh/tbxWyOqrc0dLD2yfDhRoOe+ZqBfan+CCzjT0OrRean8Q
	4KJTrouCljQsCBPhhJzsQlN6t6uUpph3HtdjRMfJOvtCkt6w+35RZia9/2FPWz766B0NMpPIBpV
	wqGoPxlO91phxClymfNMcC3zQdh0B3Hfg6h6giAMSqQcqNu34M2ztlMmQcEAwKmGxw2ZYGj3Y8F
	xVsiWz/HQklJpbfFS6jBeWeNYT35ateFKa
X-Received: by 2002:a05:6870:3314:b0:3d9:2fe2:f5c8 with SMTP id 586e51a60fabf-4177c8bcaf6mr2475836fac.32.1773258718211;
        Wed, 11 Mar 2026 12:51:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e64a931sm3100578fac.14.2026.03.11.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:51:57 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 03/11] mm/zsmalloc: Introduce conditional memcg awareness to zs_pool
Date: Wed, 11 Mar 2026 12:51:40 -0700
Message-ID: <20260311195153.4013476-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce 3 new fields to struct zs_pool to allow individual zpools to
be "memcg-aware": memcg_aware, compressed_stat, and uncompressed_stat.

memcg_aware is used in later patches to determine whether memory
should be allocated to keep track of per-compresed object objgs.
compressed_stat and uncompressed_stat are enum indices that point into
memcg (node) stats that zsmalloc will account towards.

In reality, these fields help distinguish between the two users of
zsmalloc, zswap and zram. The enum indices compressed_stat and
uncompressed_stat are parametrized to minimize zswap-specific hardcoding
in zsmalloc.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 drivers/block/zram/zram_drv.c |  3 ++-
 include/linux/zsmalloc.h      |  5 ++++-
 mm/zsmalloc.c                 | 13 ++++++++++++-
 mm/zswap.c                    |  3 ++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bca33403fc8b..d1eae5c20df7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1980,7 +1980,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	if (!zram->table)
 		return false;
 
-	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
+	/* zram does not support memcg accounting */
+	zram->mem_pool = zs_create_pool(zram->disk->disk_name, false, 0, 0);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
 		zram->table = NULL;
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 478410c880b1..24fb2e0fdf67 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -23,8 +23,11 @@ struct zs_pool_stats {
 
 struct zs_pool;
 struct scatterlist;
+enum memcg_stat_item;
 
-struct zs_pool *zs_create_pool(const char *name);
+struct zs_pool *zs_create_pool(const char *name, bool memcg_aware,
+			       enum memcg_stat_item compressed_stat,
+			       enum memcg_stat_item uncompressed_stat);
 void zs_destroy_pool(struct zs_pool *pool);
 
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7758486e1d06..3f0f42b78314 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -214,6 +214,9 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
 #endif
+	bool memcg_aware;
+	enum memcg_stat_item compressed_stat;
+	enum memcg_stat_item uncompressed_stat;
 	/* protect zspage migration/compaction */
 	rwlock_t lock;
 	atomic_t compaction_in_progress;
@@ -2050,6 +2053,9 @@ static int calculate_zspage_chain_size(int class_size)
 /**
  * zs_create_pool - Creates an allocation pool to work from.
  * @name: pool name to be created
+ * @memcg_aware: whether the consumer of this pool will account memcg stats
+ * @compressed_stat: compressed memcontrol stat item to account
+ * @uncompressed_stat: uncompressed memcontrol stat item to account
  *
  * This function must be called before anything when using
  * the zsmalloc allocator.
@@ -2057,7 +2063,9 @@ static int calculate_zspage_chain_size(int class_size)
  * On success, a pointer to the newly created pool is returned,
  * otherwise NULL.
  */
-struct zs_pool *zs_create_pool(const char *name)
+struct zs_pool *zs_create_pool(const char *name, bool memcg_aware,
+			       enum memcg_stat_item compressed_stat,
+			       enum memcg_stat_item uncompressed_stat)
 {
 	int i;
 	struct zs_pool *pool;
@@ -2071,6 +2079,9 @@ struct zs_pool *zs_create_pool(const char *name)
 	rwlock_init(&pool->lock);
 	atomic_set(&pool->compaction_in_progress, 0);
 
+	pool->memcg_aware = memcg_aware;
+	pool->compressed_stat = compressed_stat;
+	pool->uncompressed_stat = uncompressed_stat;
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
 		goto err;
diff --git a/mm/zswap.c b/mm/zswap.c
index e6ec3295bdb0..ff9abaa8aa38 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -257,7 +257,8 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
 
 	/* unique name for each pool specifically required by zsmalloc */
 	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
-	pool->zs_pool = zs_create_pool(name);
+	pool->zs_pool = zs_create_pool(name, true, MEMCG_ZSWAP_B,
+				       MEMCG_ZSWAPPED);
 	if (!pool->zs_pool)
 		goto error;
 
-- 
2.52.0

