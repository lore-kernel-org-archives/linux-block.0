Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854099;
	b=hu5qB5vvsme3C495X4JrVRMWUs268pHdnn5RAfnLk+Rb1QpG4PS8mM6EyyliDHoYu479
	 xRyAV3hO8oLWsrvpxAZDCx7MuQmH8yrf6Zax6WuOAsRQ6DUXo4a4RI0VW8DmEOdvU6aTb
	 8FDj7PqmbYSHGeOkd/+R+UeDtXphH+f22NZm/wbZtGygyBgaYuDs32B5AW9HSW/SpI5ze
	 6brbQ8T8RC6NjTrgOk8uIGvzW+cny1uxI00uNE0XLA/ug57lONCRrV/fJ2s8mwLnZA2DG
	 nmAblSYihfNj1z9DoBbpXSJ3R7ghu8hM33PnDfq+1l43Wvwg74OW/sK4j6fYEbFHzWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8nPV4Na2r4fuMLpiAdFjk8iBGsrOdFxnXJMgNy6oG6E=;
	b=fm4W8IXmI+AQYQdDZHzxtmpZl/XeDpUDvjlYCSdQrJkKNJ6stPcpnLUgVT9b28yl+OoP
	 QZAFN0p7PSqtW6tPwfFRM+WpfT5yyPurXGQk/Cv0kAAcEIDknw+Dmjw+zD8Vs32ZaOKGS
	 sVeZ7Kwhd4GgwKXXE+odEpkK8V2nGaJtAbY30JbB9vM3b3DGRIdyhJSmW1jGCD0/EQcdG
	 i/wtiE6RWlDSEVAkIhLvFLQl9/WchT3a8qOHeVpG+f7QpoPSG99OcTdAa+81PJZgZ7iPt
	 u1wqiAIR2HZlC2oxJDvfV7T9XSSEuyTyHUNxvSS9VlRMxWKBZsIZnFxba/9IGGL3EBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RQ2CryYS;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB9606D812
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 04:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EB9606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RQ2CryYS
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35829219da8so267452eec.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 20:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793854097; x=1794458897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nPV4Na2r4fuMLpiAdFjk8iBGsrOdFxnXJMgNy6oG6E=;
        b=RQ2CryYSkvwBt/IVqtMjPfhhaxeTqyee/gsGpMLcoAuqbdTMk2+ZJN0LLwKJ+n7d5Z
         pLL+aL/UO4mUm2UQBczdq7uFnyQLqyexVqY+KYWJjXrrNTk415hgrBsjn3JHOKnBff9Z
         7jTkcVdl5otwHWeQK0WvqrJI0lb98wljZ/HZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854097; x=1794458897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8nPV4Na2r4fuMLpiAdFjk8iBGsrOdFxnXJMgNy6oG6E=;
        b=kwM2U9yNsj4OpyHRjoe7jiyRvQKDHga/9hFdBvVk3k+xS1KkGBpirktsGNS5bqb4Qj
         U0hxm8T4u2sysF8BT68VgdPLA0lz5dxc0quWqaq5CFvKX/hU/Vx/WWlZ8V05dQQFzQ4c
         yxVzvmlB7encFcRp+KX6y/BdKzzvx6E5NBP1/use40CYNe+zAz7EqHlyXb+4jcn8FPza
         Sqxpvkws2i/STgGqRdSXFx7BicGYTKKQQnC6Re1AVAKXnl5Tlgqfi7sktXw/Qn2i3OCX
         gd7aCJ73RuZK1vxj1H9L3tn2M+CiyxDbMxnEV+YooKeQ7wQrDMraOgI2lWniTyatR71b
         2NlA==
X-Forwarded-Encrypted: i=1; AKwUvBxaGk0YfJQ9KjbLkXjhlt8Jj5hCIbi/lMKoG4jj8DKsb0Ox73F80v3h+fZ/3HBMvYBnGuwtSo3Af4WHCg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8USl0X5ZZ/oAg0NfH/q5ic/M4/OYQtSKPqNuKZ1alb8pp+smPn
	3sFocxi9dQDddmT+b4w1TAkM3q8Jui7NW9A6rIFWBl+yZ3M+nqBOg8qNcjjd1/FFpA==
X-Gm-Gg: AYBFou2ZE6/6ZXNkqMJAtJoReCaWB7e1tb6VR3ET0+Tvey1xF+1BlKyOVkHEUdW3dCt
	ezgXMJg8FRRheOxgIXblc07XGIYFCIC/XViD3AeevLMvptMgPcxutestZsY7nJULXhzg9LGYA0+
	DOuzTuBLmocaHYRkaxvZ1u4K/eMgHEBG3oUVQAE8Ond/jQ48qzcav4Wql/PCa/xzmAAWxrpP6sA
	cXgG4mIMizRJq0xuHmtu1avm7WTaTKUKPh+IeO4pMu+BViTXR/h3uzsCuN9Crju6g8HnS8GkQjr
	evj2J0Q8jETHvsKYpdNT69F50WXno4kLNqg3MhPjZf6C1HHH4K/VX5KguPVGKIcU6tuLp4nLl89
	XqSUO5/8IhAVupsE+Z6U4sfsZk8HDmDjWosG5xLarI+mUpwrkNjmMnAAS3Yvvf0dplfNhXPhIo+
	dggAPSGWoIJKcGjVV6SFNZwvLiS+W9uFTAEw7hsRfxIelv10ToeNEiWdoEjtGZ6+JKg8MzU+/NZ
	9SQ35q5PjZoeF/HBLIPFikiK6waYox/vN8tnakcRTqWvfyYgqd8qyZ495jmqh8gj5c2CJvIx+h1
	Q0n+ZraNTqETmaqpPrwHO199m8iCEmHRWKOSjYahptJ976tsb5f+dJQFXdgqvvLOsMaofFA9Hlq
	l0oU3dc7ZW2JHIRl1AA==
X-Received: by 2002:a05:701b:4591:20b0:1a7:77ae:11f6 with SMTP id a92af1059eb24-1b24f45f23dmr2037579c88.17.1793854097305;
        Wed, 04 Nov 2026 20:48:17 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:37bc:b763:7ec7:65b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm17142927c88.21.2026.11.04.20.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:48:16 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 6/7] zsmalloc: fold zs_obj_write() into zs_store()
Date: Thu,  5 Nov 2026 13:47:36 +0900
Message-ID: <20261105044752.1997895-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105044752.1997895-1-senozhatsky@chromium.org>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
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

zram and zswap always call zs_obj_write() right after zs_malloc(), and
zs_obj_write() has to take pool->lock and look up object location
again, which zs_malloc() just did.

Replace zs_malloc() and zs_obj_write() with one single zs_store()
call.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/core-api/memory-allocation.rst |  2 +-
 Documentation/mm/zsmalloc.rst                |  4 +-
 drivers/block/zram/zram_drv.c                | 43 ++++++-----------
 include/linux/zsmalloc.h                     |  6 +--
 mm/zsmalloc.c                                | 51 +++++++++-----------
 mm/zswap.c                                   |  5 +-
 6 files changed, 46 insertions(+), 65 deletions(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 648222b6c857..5069ac72b857 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -9,7 +9,7 @@ allocate small chunks using `kmalloc` or `kmem_cache_alloc` families,
 large virtually contiguous areas using `vmalloc` and its derivatives,
 or you can directly request pages from the page allocator with
 `alloc_pages`. It is also possible to use more specialized allocators,
-for instance `cma_alloc` or `zs_malloc`.
+for instance `cma_alloc` or `zs_store`.
 
 Most of the memory allocation APIs use GFP flags to express how that
 memory should be allocated. The GFP acronym stands for "get free
diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index dbb5c1a8dcc3..52eaba8f97e9 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -20,9 +20,9 @@ For simplicity, zsmalloc can only allocate objects of size up to PAGE_SIZE
 since this satisfies the requirements of all its current users (in the
 worst case, page is incompressible and is thus stored "as-is" i.e. in
 uncompressed form). For allocation requests larger than this size, failure
-is returned (see zs_malloc).
+is returned (see zs_store).
 
-Additionally, zs_malloc() does not return a dereferenceable pointer.
+Additionally, zs_store() does not return a dereferenceable pointer.
 Instead, it stores the encoded location of the allocated object in the
 provided ``struct zs_handle``. The reason for this indirection is that
 zsmalloc does not keep zspages permanently mapped since that would cause
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7c80db51b29a..223e4151fc9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2262,9 +2262,11 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 
 	slot_lock(zram, index);
 	slot_free(zram, index);
-	ret = zs_malloc(zram->mem_pool, &zram->table[index].handle, PAGE_SIZE,
-			GFP_NOIO | __GFP_NOWARN |
-			__GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+	src = kmap_local_page(page);
+	ret = zs_store(zram->mem_pool, &zram->table[index].handle, src,
+		       PAGE_SIZE, GFP_NOIO | __GFP_NOWARN |
+		       __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+	kunmap_local(src);
 	if (ret) {
 		slot_unlock(zram, index);
 		return ret;
@@ -2276,11 +2278,6 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 		return -ENOMEM;
 	}
 
-	src = kmap_local_page(page);
-	zs_obj_write(zram->mem_pool, &zram->table[index].handle, src,
-		     PAGE_SIZE);
-	kunmap_local(src);
-
 	set_slot_flag(zram, index, ZRAM_HUGE);
 	set_slot_size(zram, index, PAGE_SIZE);
 	mark_slot_accessed(zram, index);
@@ -2329,26 +2326,22 @@ static int zram_write_page(struct zram *zram, struct page *page,
 
 	slot_lock(zram, index);
 	slot_free(zram, index);
-	ret = zs_malloc(zram->mem_pool, &zram->table[index].handle, comp_len,
-			GFP_NOIO | __GFP_NOWARN |
-			__GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+	ret = zs_store(zram->mem_pool, &zram->table[index].handle,
+		       zstrm->buffer, comp_len,
+		       GFP_NOIO | __GFP_NOWARN |
+		       __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+	zcomp_cstrm_put(zstrm);
 	if (ret) {
-		zcomp_cstrm_put(zstrm);
 		slot_unlock(zram, index);
 		return ret;
 	}
 
 	if (!zram_can_store_page(zram)) {
-		zcomp_cstrm_put(zstrm);
 		zs_free(zram->mem_pool, &zram->table[index].handle);
 		slot_unlock(zram, index);
 		return -ENOMEM;
 	}
 
-	zs_obj_write(zram->mem_pool, &zram->table[index].handle, zstrm->buffer,
-		     comp_len);
-	zcomp_cstrm_put(zstrm);
-
 	set_slot_size(zram, index, comp_len);
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
@@ -2533,18 +2526,12 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	 * modify zsmalloc API to return this information. For now, we will
 	 * make do with the node of the page allocated for recompression.
 	 */
-	ret = zs_malloc(zram->mem_pool, &zram->recomp_handle, comp_len_new,
-			GFP_NOIO | __GFP_NOWARN |
-			__GFP_HIGHMEM | __GFP_MOVABLE,
-			page_to_nid(page));
-	if (ret) {
-		zcomp_cstrm_put(zstrm);
-		return ret;
-	}
-
-	zs_obj_write(zram->mem_pool, &zram->recomp_handle, zstrm->buffer,
-		     comp_len_new);
+	ret = zs_store(zram->mem_pool, &zram->recomp_handle, zstrm->buffer,
+		       comp_len_new, GFP_NOIO | __GFP_NOWARN |
+		       __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
 	zcomp_cstrm_put(zstrm);
+	if (ret)
+		return ret;
 
 	slot_free(zram, index);
 	zs_rebind_handle(zram->mem_pool, &zram->table[index].handle,
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 6c76fd10344e..674358f39191 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -48,8 +48,8 @@ struct scatterlist;
 struct zs_pool *zs_create_pool(const char *name);
 void zs_destroy_pool(struct zs_pool *pool);
 
-int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
-	      gfp_t flags, const int nid);
+int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
+	     size_t size, gfp_t flags, const int nid);
 void zs_free(struct zs_pool *pool, struct zs_handle *handle);
 #ifdef CONFIG_ZSMALLOC_REBIND_HANDLE
 void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
@@ -68,8 +68,6 @@ void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
 void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
 			  struct scatterlist *sg, size_t mem_len);
 void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle);
-void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
-		  void *handle_mem, size_t mem_len);
 
 extern const struct movable_operations zsmalloc_mops;
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 71e6dcb1fb3f..ff1cde4c5dc2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1172,26 +1172,15 @@ void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle)
 }
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_end);
 
-void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
-		  void *handle_mem, size_t mem_len)
+static void obj_write(struct size_class *class, struct zspage *zspage,
+		      unsigned long obj, const void *handle_mem,
+		      size_t mem_len)
 {
-	struct zspage *zspage;
 	struct zpdesc *zpdesc;
-	unsigned long obj, off;
+	unsigned long off;
 	unsigned int obj_idx;
-	struct size_class *class;
 
-	/* Guarantee we can get zspage from handle safely */
-	read_lock(&pool->lock);
-	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	zspage = get_zspage(zpdesc);
-
-	/* Make sure migration doesn't move any pages in this zspage */
-	zspage_read_lock(zspage);
-	read_unlock(&pool->lock);
-
-	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
 	if (!ZsHugePage(zspage))
@@ -1216,10 +1205,7 @@ void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
 		memcpy_to_page(zpdesc_page(zpdesc), 0,
 			       handle_mem + sizes[0], sizes[1]);
 	}
-
-	zspage_read_unlock(zspage);
 }
-EXPORT_SYMBOL_GPL(zs_obj_write);
 
 /**
  * zs_huge_class_size() - Returns the size (in bytes) of the first huge
@@ -1284,9 +1270,10 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 
 
 /**
- * zs_malloc - Allocate block of given size from pool.
+ * zs_store() - Allocate block of given size from pool and copy data into it.
  * @pool: pool to allocate from
  * @handle: handle to store allocated object in (must not be on the stack)
+ * @src: data to copy into the allocated object
  * @size: size of block to allocate
  * @gfp: gfp flags when allocating object
  * @nid: The preferred node id to allocate new zspage (if needed)
@@ -1295,10 +1282,11 @@ static unsigned long obj_malloc(struct zs_pool *pool,
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
-	      gfp_t gfp, const int nid)
+int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
+	     size_t size, gfp_t gfp, const int nid)
 {
 	struct size_class *class;
+	unsigned long obj;
 	int newfg;
 	struct zspage *zspage;
 
@@ -1318,12 +1306,16 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
 	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
-		obj_malloc(pool, zspage, handle);
+		obj = obj_malloc(pool, zspage, handle);
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		class_stat_add(class, ZS_OBJS_INUSE, 1);
+		zspage_read_lock(zspage);
+		spin_unlock(&class->lock);
 
-		goto out;
+		obj_write(class, zspage, obj, src, size);
+		zspage_read_unlock(zspage);
+		return 0;
 	}
 
 	spin_unlock(&class->lock);
@@ -1332,8 +1324,14 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
 	if (!zspage)
 		return -ENOMEM;
 
+	/*
+	 * New zspage is not in class->fullness_list or movable yet, so we
+	 * can allocate the object and copy data before taking class->lock.
+	 */
+	obj = obj_malloc(pool, zspage, handle);
+	obj_write(class, zspage, obj, src, size);
+
 	spin_lock(&class->lock);
-	obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
@@ -1342,12 +1340,11 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
-out:
 	spin_unlock(&class->lock);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(zs_malloc);
+EXPORT_SYMBOL_GPL(zs_store);
 
 static void obj_free(int class_size, unsigned long obj)
 {
@@ -2224,7 +2221,7 @@ struct zs_pool *zs_create_pool(const char *name)
 			huge_class_size = size;
 			/*
 			 * The object uses ZS_HANDLE_SIZE bytes to store the
-			 * handle. We need to subtract it, because zs_malloc()
+			 * handle. We need to subtract it, because zs_store()
 			 * unconditionally adds handle size before it performs
 			 * size class search - so object may be smaller than
 			 * huge class size, yet it still can end up in the huge
diff --git a/mm/zswap.c b/mm/zswap.c
index f28a46cae1e1..f4cfc552a6fc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -948,12 +948,11 @@ static bool zswap_compress(struct folio *folio, long index,
 	}
 
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
-	alloc_ret = zs_malloc(pool->zs_pool, &entry->handle, dlen, gfp,
-			      folio_nid(folio));
+	alloc_ret = zs_store(pool->zs_pool, &entry->handle, dst, dlen, gfp,
+			     folio_nid(folio));
 	if (alloc_ret)
 		goto unlock;
 
-	zs_obj_write(pool->zs_pool, &entry->handle, dst, dlen);
 	entry->length = dlen;
 
 unlock:
-- 
2.56.0.398.g882cbad275-goog

