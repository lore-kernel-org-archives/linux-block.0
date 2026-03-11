Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE237CD3F
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258726; cv=none; b=YS2CAUGmP/IMGOHW2VpinbqERfqj+R3Loy+4X1SFK2p64ShjpYLHRHDTDuaOJDTi0bCtEC2Q30ep9NcWawf1sxiVU7KEVBRZXVUcpyBBUXP+I8hzY38gKmqFVVY5ep5cEM+MkhZACwYa9/8pYfjGrbbgZ7+mEkB/OJtc0+QOaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258726; c=relaxed/simple;
	bh=o47mybQcyMuEdhSSbqd2I6tPg73t5Jjugzv2/OoCmDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osvmuHgIHGzGHYrMk+qTKNH3XiEL1J0mJ9vwgmVreIWx1EqpjHC1QHo1rKcssPrEnpWLhpZsr3Rz9lby90J4AgI99xsqlNjiuQzqfF2Ha2a21QwRA4L8JHKRP8jUeUXluNacFv/Ula8+D4j9AHmiI71vj5DdE06CspANC+bdNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1KshGNW; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1KshGNW"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-46702742c99so176293b6e.3
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258722; x=1773863522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVMnNhXg4JHLBLwKWI7WYc2GrcGR/wasu1xpRjHo+OU=;
        b=l1KshGNWocIlDALDa9RXMfEeRVJb6vgJuAR38o9Sp4d5XHy49RLqPOIoiau9DIWi76
         evU1A1JFkDAVjpWHA4CSblkAA81EDDeJ4Sr0bJCuNfxBfhCS165X8RZjyFtGhJlmZQue
         Gyko7KA0PWxoNMR9RKje4qnNrKZjUsZD8TT/v6DODKp29jpeF2SmOTItJughQ1t/xII3
         71tmd2TrMI00rKgGAhQowcL9PR38yuEdzJMBbstmMeM5pvRj1ONVxQmnGAhYxXKsqeN8
         dBWofphbdO4a29PxQbmmZ/Mnp/ArQLLp3DyyUEwOpjm1hWgu6zVrXg7sKyDXjzjjq+B4
         jYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258722; x=1773863522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVMnNhXg4JHLBLwKWI7WYc2GrcGR/wasu1xpRjHo+OU=;
        b=f3LNh1Gec2JuRIRKfrzPFehUeJ9qHgawqODQwJNe469TUg+WX7rC3JXG7Oq+7KDbj3
         J85L48ZKHYrHBWYpRA9QqMNsGnQpawTITPgJW6qtmyZ29zoOxOxWNfbaaFtvJfr1oyl+
         HHkL8vLSy2+ksPn9Sib9znUHuekIXrSf6XEMo9ufUbvH54Cj8ATaguN/PzCcgAtIGPUt
         YU96A4zb/qUiMGYEKCuTg8Xw4vJpbTiU7TAri8xHuiXVA8hC04HH1QOBsdYyLlf/ZNE6
         a65FGT+IihCMNRnehguqfqDmrvLrfM4lY+UHMgAZZonAkZkdQLtK+8kbjjOsXG2ilrwU
         +TwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhSUz037YDW8ST9ZwsYPY2lVqoN8PlZAX+Hy7tNYKMNe9ijPoduzpjy5uIiGbqUAh56sUDLfWFQ54Jqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTuL/MTJQDR7R8hUIuo2M9FT0rmu1nbqERiysIMpZVG1aw1KH
	qJA8eslAnXp84/vopPd/k9+RmV6X3iuK/1Vuo0GfCBvk9s+gb0ENB81E
X-Gm-Gg: ATEYQzzZlWFwzakZ/zL9EZK6BTNJaHLSP/uRIIdFXRx+1mFcJowF5hxPm3F62zgJt+/
	pLC05Ko8uwAaacU5396x0mwESW2y9d7/nKHQPdUkfGqiBl4sj3HzQoF/ckIOxnjQTg6T0rAnnVt
	8mfOhCfUJqDPWQ5e8wKFkdoDzrpHlbmtm3E4Su+ZYYQqEhVyYVa/0AiiNNtVS6vZkfmeGn+ZSur
	ZHe9u7hvooSPPrUP2x1O+7ThH3JEMhFmNJ1bawRaMr15l7wGP5/q8670o1cuTudR4HZbuIw8x98
	j4PzMd4Ws6tfi+gVlx8mIxyJng8pseIqE7wWwCb+vj+2nr4DKElOMr6dZ4M/T9wKt23BFbYIvf0
	bY2FepTwjQXhYx5AyNrY7TsXd/ZZEVLOT0XKWKcR6QGG33AJHTtHJOHP+VHs5TVrSIGCr1/H+VA
	KOD8wW8um9lQ1+MP2QP/lWzsdmcfZG
X-Received: by 2002:a05:6808:1b1e:b0:467:baa:ed5c with SMTP id 5614622812f47-467333f24demr2109453b6e.12.1773258721631;
        Wed, 11 Mar 2026 12:52:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46733f23116sm1835915b6e.0.2026.03.11.12.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:52:00 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 05/11] mm/zsmalloc: Store obj_cgroup pointer in zspage
Date: Wed, 11 Mar 2026 12:51:42 -0700
Message-ID: <20260311195153.4013476-6-joshua.hahnjy@gmail.com>
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

With each zspage now having an array of obj_cgroup pointers, plumb the
obj_cgroup pointer from the zswap / zram layer down to zsmalloc.

zram still sees no visible change from its end. For the zswap path,
store the obj_cgroup pointer after compression when writing the object,
and erase the pointer when the object gets freed.

The lifetime and charging of the obj_cgroup is still handled in the
zswap layer.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 drivers/block/zram/zram_drv.c |  7 ++++---
 include/linux/zsmalloc.h      |  3 ++-
 mm/zsmalloc.c                 | 25 ++++++++++++++++++++++++-
 mm/zswap.c                    |  6 +++---
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d1eae5c20df7..e68e408992e7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2232,7 +2232,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	}
 
 	src = kmap_local_page(page);
-	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
+	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE, NULL);
 	kunmap_local(src);
 
 	slot_lock(zram, index);
@@ -2297,7 +2297,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return -ENOMEM;
 	}
 
-	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
+	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len, NULL);
 	zcomp_stream_put(zstrm);
 
 	slot_lock(zram, index);
@@ -2521,7 +2521,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		return PTR_ERR((void *)handle_new);
 	}
 
-	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
+	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer,
+		     comp_len_new, NULL);
 	zcomp_stream_put(zstrm);
 
 	slot_free(zram, index);
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 24fb2e0fdf67..645957a156c4 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -23,6 +23,7 @@ struct zs_pool_stats {
 
 struct zs_pool;
 struct scatterlist;
+struct obj_cgroup;
 enum memcg_stat_item;
 
 struct zs_pool *zs_create_pool(const char *name, bool memcg_aware,
@@ -51,7 +52,7 @@ void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
 			  struct scatterlist *sg, size_t mem_len);
 void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
 void zs_obj_write(struct zs_pool *pool, unsigned long handle,
-		  void *handle_mem, size_t mem_len);
+		  void *handle_mem, size_t mem_len, struct obj_cgroup *objcg);
 
 extern const struct movable_operations zsmalloc_mops;
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index dcf99516227c..d4735451c273 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1195,7 +1195,7 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle)
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_end);
 
 void zs_obj_write(struct zs_pool *pool, unsigned long handle,
-		  void *handle_mem, size_t mem_len)
+		  void *handle_mem, size_t mem_len, struct obj_cgroup *objcg)
 {
 	struct zspage *zspage;
 	struct zpdesc *zpdesc;
@@ -1216,6 +1216,11 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
+	if (objcg) {
+		WARN_ON_ONCE(!pool->memcg_aware);
+		zspage->objcgs[obj_idx] = objcg;
+	}
+
 	if (!ZsHugePage(zspage))
 		off += ZS_HANDLE_SIZE;
 
@@ -1388,6 +1393,9 @@ static void obj_free(int class_size, unsigned long obj)
 	f_offset = offset_in_page(class_size * f_objidx);
 	zspage = get_zspage(f_zpdesc);
 
+	if (zspage->pool->memcg_aware)
+		zspage->objcgs[f_objidx] = NULL;
+
 	vaddr = kmap_local_zpdesc(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
 
@@ -1538,6 +1546,16 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	return handle;
 }
 
+static void zs_migrate_objcg(struct zspage *s_zspage, struct zspage *d_zspage,
+			     unsigned long used_obj, unsigned long free_obj)
+{
+	unsigned int s_idx = used_obj & OBJ_INDEX_MASK;
+	unsigned int d_idx = free_obj & OBJ_INDEX_MASK;
+
+	d_zspage->objcgs[d_idx] = s_zspage->objcgs[s_idx];
+	s_zspage->objcgs[s_idx] = NULL;
+}
+
 static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 			   struct zspage *dst_zspage)
 {
@@ -1560,6 +1578,11 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 		used_obj = handle_to_obj(handle);
 		free_obj = obj_malloc(pool, dst_zspage, handle);
 		zs_obj_copy(class, free_obj, used_obj);
+
+		if (pool->memcg_aware)
+			zs_migrate_objcg(src_zspage, dst_zspage,
+					 used_obj, free_obj);
+
 		obj_idx++;
 		obj_free(class->size, used_obj);
 
diff --git a/mm/zswap.c b/mm/zswap.c
index ff9abaa8aa38..68b87c3cc326 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -852,7 +852,7 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
 }
 
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
-			   struct zswap_pool *pool)
+			   struct zswap_pool *pool, struct obj_cgroup *objcg)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
@@ -912,7 +912,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 		goto unlock;
 	}
 
-	zs_obj_write(pool->zs_pool, handle, dst, dlen);
+	zs_obj_write(pool->zs_pool, handle, dst, dlen, objcg);
 	entry->handle = handle;
 	entry->length = dlen;
 
@@ -1414,7 +1414,7 @@ static bool zswap_store_page(struct page *page,
 		return false;
 	}
 
-	if (!zswap_compress(page, entry, pool))
+	if (!zswap_compress(page, entry, pool, objcg))
 		goto compress_failed;
 
 	old = xa_store(swap_zswap_tree(page_swpentry),
-- 
2.52.0

