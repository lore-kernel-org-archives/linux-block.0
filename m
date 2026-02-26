Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290544CF4E
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134189; cv=none; b=iF1BOw8cwIuxNlRhbLGW09tOAKJbwNDDxnspdu7WZKXmyvnaJqu2atOqDssrSVeObKoGit1kqMqwyWaAsGnekzMUlVNVY6s3issMUS0zkYrMeDP8Y8YVAaWZHBnukSN0jnhHaBypw5w9jmY/QvzJE33FzYJdhlzbs6FzgJqsWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134189; c=relaxed/simple;
	bh=wfhNq3yitHAZ8XpYXoCk88fkKDKZU9yo7nZb3MeoDNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcU4tXUvYtSTcka3eXad/c6wwV0LOkwM4KG2iBoq0EmfLwUUKw84SW53NzOYFCxfmR9o52lKyQYUGhYRxQ8B8FmqR1g+24omSYzWDJGTC0jm1K++fuEiWwTtbZmLBgTkrlW8QOez2+W227QlF2gw+vCJei6FvpXhtsbSc6LlWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyU8G3QK; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyU8G3QK"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d1890f7ee4so921526a34.0
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134186; x=1772738986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTFgJFJwcADBwm8xdyLgLzJR5Ju+0hDvZcOEI0tPhVw=;
        b=lyU8G3QKqXOrqG+pgD5g2k1/qy/eledBVYavkCp4YD3z5HAkZoQ0KtqH6PTCesqi0/
         rJrjggHz2AGrIm8qig45DSzgskxQqZw5yGr5GF7mVNpxz8xJRcy7cXqfoHjXvNr7/irN
         PxpsnQYwoWsqheOTDzJ2B38B0oWKzeUT0kM/jqmZkFyai6w8PSslNjxTibWyOWf57ML4
         YlimCqA0zprTFOLRt6RBMExF9EfzxOYQT5rCAOJWpE85eKkS3EeFluc4f9zcaYq6usc4
         OLWD30HGWwKJ6Qn4YB3I49PlNQAmdSuGSkmpo7C68upaHCMNYkhcTzELRlKp1GsQq3bc
         HJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134186; x=1772738986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTFgJFJwcADBwm8xdyLgLzJR5Ju+0hDvZcOEI0tPhVw=;
        b=RfbPBjrhG9FJDk+mCIeFJoh8Zw+TMQJFJN3rygJeR6CyLR34udaaYSRtERKT7v+V8Y
         YYZHVIiZ2gK7ZXCwWsl+K2kskyKgSHg2Q2yOcMk8CwSvt/ZdmDNSlaq+bWmpsMtjtKC7
         MM+NGNf9G+jRvN3K9g/EQsH+ujJ9rSvmfHMKatIBISYpHMGR9oaP2rYVZ7oza8pfJYys
         17aJveCoRyowMlHbyweasWBtONw86cPHJY9C6WN6PJG+yWRy5LIrKYe4w/459TgWwXDm
         bS8bp7nslV1aeL16akfBnoa+lfsEHs1V74KHSIQ+KZQq90xENpY1TQA8hszdRcLlY8jO
         Wbdw==
X-Forwarded-Encrypted: i=1; AJvYcCUxboQ0j0iTXl8jCq2XFp4WYkgzCvunfAfndDJQIrGKKAmfTjswi180T+BQ2u7rcrUcz2vdkAGapHokkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75HWUakUNU0U2FBHEcBegEprqhDnVRmczPqjXiOQXm87cbbNr
	xHNlztRY9biPQv+EeMxcI0GVO2mTWj4nRGgW4Sx4Hw7NSZ5H0iHGCUXbKslqrou/
X-Gm-Gg: ATEYQzz2Dg9kESeQB86Pvt8SIINV3Whl4j9afoLHA6IMZWazqHjkJz/gXQqJJPiLKrn
	FvrnBR3LQtSEryj/vDcbM3zn1mr5bybNHfEV8YwohFsoYdCuhvAeq15kP306FK6fHzBLFwsCfJc
	e9rp/DYh5pC9NqCniYOBp+lwEhkHOOZGmOAHukd/63x9RpFMHIwzSZ65oQxUlHTPnXSEdQwzcIp
	iWj6G6ITv14V7NGopA254fAtG7Vks8aLmQ9xzcUKsNiMEDhIUyKP7mtU298IUsJ92EdpyoYjXf7
	NY9ajW276/Jbq44BdN6jnhCgaraP5hFrHe+g97lH+szUrSOhi7/Db67NfNh/mksJew38FsefjLX
	1T49pgdH7+nUxvtFEJ+HcY82ilwkZeOnbmFnUzLv5Dck5QhZuJcrfovPrglcq6JdJWeasK0YBhM
	rZE94aSmT2Xs/Xjore5mU2DA==
X-Received: by 2002:a05:6871:7402:b0:40e:9550:3242 with SMTP id 586e51a60fabf-41626de807cmr252273fac.16.1772134186118;
        Thu, 26 Feb 2026 11:29:46 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d21196csm2606670fac.12.2026.02.26.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:29:45 -0800 (PST)
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
Subject: [PATCH 4/8] mm/zsmalloc: Store obj_cgroup pointer in zpdesc
Date: Thu, 26 Feb 2026 11:29:27 -0800
Message-ID: <20260226192936.3190275-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With each zswap-backing zpdesc now having an array of obj_cgroup pointers,
plumb the obj_cgroup pointer from the zswap / zram layer down to
zsmalloc.

Introduce two helper functions zpdesc_obj_cgroup and zpdesc_set_obj_cgroup,
which abstract the conversion of an object's zspage idx to its zpdesc
idx and the retrieval of the obj_cgroup pointer from the zpdesc.

From the zswap path, store the obj_cgroup pointer after compression when
writing the object and free when the object gets freed. Also handle the
migration of an object across zpdescs.

The lifetime and charging of the obj_cgroup is still handled in the
zswap layer.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 drivers/block/zram/zram_drv.c |  7 ++--
 include/linux/zsmalloc.h      |  3 +-
 mm/zsmalloc.c                 | 71 ++++++++++++++++++++++++++++++++++-
 mm/zswap.c                    |  6 +--
 4 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 60ee85679730..209668b14428 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2231,7 +2231,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	}
 
 	src = kmap_local_page(page);
-	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
+	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE, NULL);
 	kunmap_local(src);
 
 	slot_lock(zram, index);
@@ -2296,7 +2296,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return -ENOMEM;
 	}
 
-	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
+	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len, NULL);
 	zcomp_stream_put(zstrm);
 
 	slot_lock(zram, index);
@@ -2520,7 +2520,8 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		return PTR_ERR((void *)handle_new);
 	}
 
-	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
+	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer,
+		     comp_len_new, NULL);
 	zcomp_stream_put(zstrm);
 
 	slot_free(zram, index);
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 8ef28b964bb0..22f3baa13f24 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -15,6 +15,7 @@
 #define _ZS_MALLOC_H_
 
 #include <linux/types.h>
+#include <linux/memcontrol.h>
 
 struct zs_pool_stats {
 	/* How many pages were migrated (freed) */
@@ -48,7 +49,7 @@ void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
 			  struct scatterlist *sg, size_t mem_len);
 void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
 void zs_obj_write(struct zs_pool *pool, unsigned long handle,
-		  void *handle_mem, size_t mem_len);
+		  void *handle_mem, size_t mem_len, struct obj_cgroup *objcg);
 
 extern const struct movable_operations zsmalloc_mops;
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7d56bb700e11..e5ae9a0fc78a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -899,6 +899,41 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 }
 
 #ifdef CONFIG_MEMCG
+/* idx is indexed per-zspage, not per-zpdesc. */
+static inline struct obj_cgroup *zpdesc_obj_cgroup(struct zpdesc *zpdesc,
+						   unsigned int idx,
+						   int size)
+{
+	struct obj_cgroup **objcgs = zpdesc_objcgs(zpdesc);
+	unsigned int off = offset_in_page(size * idx);
+	unsigned int zpdesc_idx = DIV_ROUND_UP(off, size);
+
+	if (!objcgs)
+		return NULL;
+
+	return objcgs[zpdesc_idx];
+}
+
+/* idx is indexed per-zspage, not per-zpdesc. */
+static inline void zpdesc_set_obj_cgroup(struct zpdesc *zpdesc,
+					 unsigned int idx, int size,
+					 struct obj_cgroup *objcg)
+{
+	struct obj_cgroup **objcgs = zpdesc_objcgs(zpdesc);
+	unsigned int off = offset_in_page(size * idx);
+	unsigned int zpdesc_idx = DIV_ROUND_UP(off, size);
+
+	if (!objcgs)
+		return;
+
+	objcgs[zpdesc_idx] = objcg;
+	if (off + size > PAGE_SIZE) {
+		/* object spans two pages */
+		objcgs = zpdesc_objcgs(get_next_zpdesc(zpdesc));
+		objcgs[0] = objcg;
+	}
+}
+
 static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
 				struct zpdesc *zpdescs[])
 {
@@ -927,12 +962,40 @@ static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
 
 	return true;
 }
+
+static void migrate_obj_objcg(unsigned long used_obj, unsigned long free_obj,
+			      int size)
+{
+	unsigned int s_obj_idx, d_obj_idx;
+	struct zpdesc *s_zpdesc, *d_zpdesc;
+	struct obj_cgroup *objcg;
+
+	obj_to_location(used_obj, &s_zpdesc, &s_obj_idx);
+	obj_to_location(free_obj, &d_zpdesc, &d_obj_idx);
+	objcg = zpdesc_obj_cgroup(s_zpdesc, s_obj_idx, size);
+
+	zpdesc_set_obj_cgroup(d_zpdesc, d_obj_idx, size, objcg);
+	zpdesc_set_obj_cgroup(s_zpdesc, s_obj_idx, size, NULL);
+}
 #else
+static inline struct obj_cgroup *zpdesc_obj_cgroup(struct zpdesc *zpdesc,
+						   unsigned int offset,
+						   int size)
+{
+	return NULL;
+}
+
+static inline void zpdesc_set_obj_cgroup(struct zpdesc *zpdesc,
+					 unsigned int offset, int size,
+					 struct obj_cgroup *objcg) {}
 static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
 				struct zpdesc *zpdescs[])
 {
 	return true;
 }
+
+static void migrate_obj_objcg(unsigned long used_obj, unsigned long free_obj,
+			      int size) {}
 #endif
 
 static void create_page_chain(struct size_class *class, struct zspage *zspage,
@@ -1221,7 +1284,7 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle)
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_end);
 
 void zs_obj_write(struct zs_pool *pool, unsigned long handle,
-		  void *handle_mem, size_t mem_len)
+		  void *handle_mem, size_t mem_len, struct obj_cgroup *objcg)
 {
 	struct zspage *zspage;
 	struct zpdesc *zpdesc;
@@ -1242,6 +1305,9 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
+	if (objcg)
+		zpdesc_set_obj_cgroup(zpdesc, obj_idx, class->size, objcg);
+
 	if (!ZsHugePage(zspage))
 		off += ZS_HANDLE_SIZE;
 
@@ -1415,6 +1481,8 @@ static void obj_free(int class_size, unsigned long obj)
 	f_offset = offset_in_page(class_size * f_objidx);
 	zspage = get_zspage(f_zpdesc);
 
+	zpdesc_set_obj_cgroup(f_zpdesc, f_objidx, class_size, NULL);
+
 	vaddr = kmap_local_zpdesc(f_zpdesc);
 	link = (struct link_free *)(vaddr + f_offset);
 
@@ -1587,6 +1655,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 		used_obj = handle_to_obj(handle);
 		free_obj = obj_malloc(pool, dst_zspage, handle);
 		zs_obj_copy(class, free_obj, used_obj);
+		migrate_obj_objcg(used_obj, free_obj, class->size);
 		obj_idx++;
 		obj_free(class->size, used_obj);
 
diff --git a/mm/zswap.c b/mm/zswap.c
index dd083110bfa0..1e2d60f47919 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -851,7 +851,7 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
 }
 
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
-			   struct zswap_pool *pool)
+			   struct zswap_pool *pool, struct obj_cgroup *objcg)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
@@ -911,7 +911,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 		goto unlock;
 	}
 
-	zs_obj_write(pool->zs_pool, handle, dst, dlen);
+	zs_obj_write(pool->zs_pool, handle, dst, dlen, objcg);
 	entry->handle = handle;
 	entry->length = dlen;
 
@@ -1413,7 +1413,7 @@ static bool zswap_store_page(struct page *page,
 		return false;
 	}
 
-	if (!zswap_compress(page, entry, pool))
+	if (!zswap_compress(page, entry, pool, objcg))
 		goto compress_failed;
 
 	old = xa_store(swap_zswap_tree(page_swpentry),
-- 
2.47.3

