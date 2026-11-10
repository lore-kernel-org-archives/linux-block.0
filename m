Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289756;
	b=GN+j1Sn7/1kxHhDODN2y6ahxT80zIrxKM38qYhHK681cMufz9bCi3ZDk7NuVnq/CpS6L
	 bFl5qgzfyK88y1ytGyzgA5psOdrwtE64Lq7c8/RkFDoz3pGfQiflaZ1XgU5TUFyrXlPxN
	 KmFsx2TgZUYQumOoUxY4juRpeS3206F30ORDwh9fsgGnhy725z0YyFZ5Xkp2fZ+8GcslF
	 ir+kZGlAsdbKXrUvwQxdS3FcRjz33UkBuoKn6aE+smTgz5pgaMgQn74n+kLiVxUHfYTTo
	 yl6zCRI1LlyN+5kL+9jkdbwTSPMMZ45chKxvKK/lfs6GO/ZhrUhii8sgsj6RqCeGEmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YCSQzGAMUPcdpnnuOgggDzx++ldY+CPnHPReM+DbQnM=;
	b=D74hC7rwRMHdMNjfdj/g1RlFJ7esEicrGp6jWEEYIOO4No4CiKr2z1ucvaX9zkHwSinI
	 8hTkhptkl/Ms8ZC7WubyHOOHNnDjjshJ2ecDzI3ovTd4mTBUie0uJkExxm3/EnLy1xZUQ
	 VIj8N3X94+4c2uhYjgnp/6vsibn1pxCXkqpXikbemXkuo9Oasxutpl7scEjZfoWMLdgjc
	 OqV0rn2cNi1wRd0bM3LcyTJWqjanKTW8mQHyFUxkqG3jNt2lA+flSQSxl+0JHn70tADXX
	 eBeVk3hgyzY83WIuvekGNqzhWIyKkdiOh7NrW0qytGEs1I//a9a55ZLXLww7SSyz2EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FAcwfKOD;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760860A3804
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6760860A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FAcwfKOD
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so748350b3a.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289755; x=1794894555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YCSQzGAMUPcdpnnuOgggDzx++ldY+CPnHPReM+DbQnM=;
        b=FAcwfKODC3vh0DknqkBWTL6lURiC1+OVyEumjEs/ifhy3qubrJhoq5pNuU0FIjID5Q
         4bjSLb/FBujwq3wd7mWICt/MqnqUq7COctSujadM79oyE+tnj4GLZRNJbY+PuCx09hjS
         0jel/gBMzYGjQyBpSqHZm1wsL1lVLpBobZDq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289755; x=1794894555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YCSQzGAMUPcdpnnuOgggDzx++ldY+CPnHPReM+DbQnM=;
        b=Or2J200hF/gRVuXR4BeKHhe3Jyhibx1/JxNi8ftjHfUEK7utunYnKn12tTZQIUMHN3
         oCZ9OwpsYRTl3wXBlnRUZCU3b92wXbBk/0ZHUbRzhGbakPfTySqW3y4S/PbEWwzD3MDi
         OkbCxF9guuTN/BX2wC6QrF/sDo4UfUo5gDvlG5er4nfCmR+3UeIKuO01u4UoEjUfm0r9
         1N8dWZFICpBAMTUABr9N+YiFGfGj7xAuXVbav5jYRa1esWWAI1dt9V6BuAp9F1pYXdS8
         bPjNYSFxfeLge/7dnUHsfRkasH6FK6tkyl14Dc5AzNBF8JuchgpUi87+zgqsvS8ZQ/4D
         na8A==
X-Forwarded-Encrypted: i=1; AL+hErEa7AlTKM4RWb+wt11z/V/zRspZtWux9TM0aQRSCKA66q8KDlNGQG7FpeembsfLJkZ/ManNWTm5/c3yTA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/lLJGWIfmjHv9ZU4xA8DlLEtZ9QR7GAvuwpPYyWDeOSrYCXtyO
	OfvPt4ngnn2Qmpf4SmURjD3Y6IqyFwNQhDzZL1X7IWWfLkxNMHqRyY2zLPZCO2C2Ww==
X-Gm-Gg: AYBFou2ny4bjLWPNKfbzbxVhtO5dAwCajo4fqLuCcIP6w/FB0c8fBUL4BWxESUdcq5o
	qaAZ/DLw7G6nm7d5RgT/PUo6D2mA+rvqCO3q+ZCbBgSZ9HPXfwyY1gepVNHpGtR0kK3TypceS2b
	jPLrLpjwyCb/yatECG1wjSBMsA40J1d4G/8y5A8B7DkSuCD08HDnNNKtivd4wB28XI1KeUKrYI+
	6krGUe1/E32FVSzqiV1rr4BGgkvtXpApKm6bEyy0ai/P+dEYqeXpc0gavRN6gcTGVo2ilrXkCMj
	5fT4CQVd6sTjpQ/eYpVnXqkMtDJCc2GqfdRqFZVRQoBj9ZDo8ewJ7oVtNkGBgw3kF5GiTIS/8or
	WA7G2N34n/MrKaiNuA3jCgEGoCevDX8Gn+rUv25Sy7lb5coLblz7Wv3ImTBctWyOuDagVtuv8yh
	pLzA4lxNUjPN8ujFXSg/vfT5eDrDIvc3S9mEifwXe2bkNWtrDGG74tQBGwcDY9WotqoChPur8KH
	v3htSMb7E+zopAfny3aDnmcT7SP9YaSudKcmDae5JdA2AKGuxAhk2wE5DJ+q5KJWT7CW/WLPzgc
	Ebe/P1h2dCC7+CbX1VJRiEKkuKJUqQpBbxUFtzYvs58xBaebC4UnL6G7JXqXs2xbmNjwE76Ysnt
	NCRwtYMptVFS6GuwPwQ==
X-Received: by 2002:a05:6300:49c:b0:3de:71c4:a228 with SMTP id adf61e73a8af0-3f18f4acd21mr1304920637.15.1794289754509;
        Mon, 09 Nov 2026 21:49:14 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:49:13 -0800 (PST)
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
Subject: [PATCH v2 10/11] zsmalloc: fold zs_obj_write() into zs_store()
Date: Tue, 10 Nov 2026 14:48:15 +0900
Message-ID: <20261110054836.1515030-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261110054836.1515030-1-senozhatsky@chromium.org>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
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

zs_store() takes zspage read lock under class->lock, before it drops
class->lock to copy the data, while zs_obj_write() used to take it
under pool->lock.  Compaction and page migration already take zspage
lock under class->lock, so this follows the existing pool->lock ->
class->lock -> zspage->lock order.  We don't need pool->lock there,
zs_store() doesn't look up the object via the handle, it already has
the zspage from the allocation.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/core-api/memory-allocation.rst |  2 +-
 Documentation/mm/zsmalloc.rst                |  4 +-
 drivers/block/zram/zram_drv.c                | 42 +++++---------
 include/linux/zsmalloc.h                     |  6 +-
 mm/zsmalloc.c                                | 58 +++++++++-----------
 mm/zswap.c                                   |  5 +-
 6 files changed, 47 insertions(+), 70 deletions(-)

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
index d6b21a0c0694..034daae0d37e 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -20,9 +20,9 @@ For simplicity, zsmalloc can only allocate objects of size up to PAGE_SIZE
 since this satisfies the requirements of all its current users (in the
 worst case, page is incompressible and is thus stored "as-is" i.e. in
 uncompressed form). For allocation requests larger than this size, failure
-is returned (see zs_malloc).
+is returned (see zs_store).
 
-Additionally, zs_malloc() does not return a pointer; instead, it returns 0
+Additionally, zs_store() does not return a pointer; instead, it returns 0
 (or a negative error code) and stores the encoded location of the allocated
 object in the caller-provided ``struct zs_handle``. The reason for this
 indirection is that zsmalloc does not keep zspages permanently mapped since
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7c3d04d9c5bc..42852a4116e0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2261,9 +2261,11 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 
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
@@ -2271,11 +2273,6 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 
 	update_used_max(zram);
 
-	src = kmap_local_page(page);
-	zs_obj_write(zram->mem_pool, &zram->table[index].handle, src,
-		     PAGE_SIZE);
-	kunmap_local(src);
-
 	set_slot_flag(zram, index, ZRAM_HUGE);
 	set_slot_size(zram, index, PAGE_SIZE);
 	mark_slot_accessed(zram, index);
@@ -2327,21 +2324,18 @@ static int zram_write_page(struct zram *zram, struct page *page,
 
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
 
 	update_used_max(zram);
 
-	zs_obj_write(zram->mem_pool, &zram->table[index].handle, zstrm->buffer,
-		     comp_len);
-	zcomp_cstrm_put(zstrm);
-
 	set_slot_size(zram, index, comp_len);
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
@@ -2526,18 +2520,12 @@ static int recompress_slot(struct zram *zram, unsigned long index,
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
index 8273ae924153..8971eef333ba 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -49,8 +49,8 @@ struct scatterlist;
 struct zs_pool *zs_create_pool(const char *name);
 void zs_destroy_pool(struct zs_pool *pool);
 
-int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
-	      gfp_t flags, const int nid);
+int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
+	     size_t size, gfp_t flags, const int nid);
 void zs_free(struct zs_pool *pool, struct zs_handle *handle);
 void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
 		      struct zs_handle *src);
@@ -67,8 +67,6 @@ void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
 void zs_obj_read_sg_begin(struct zs_pool *pool, const struct zs_handle *handle,
 			  struct scatterlist *sg, size_t mem_len);
 void zs_obj_read_sg_end(struct zs_pool *pool, const struct zs_handle *handle);
-void zs_obj_write(struct zs_pool *pool, const struct zs_handle *handle,
-		  void *handle_mem, size_t mem_len);
 
 extern const struct movable_operations zsmalloc_mops;
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index fd466139e158..09ce8c294c5e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1178,54 +1178,37 @@ void zs_obj_read_sg_end(struct zs_pool *pool, const struct zs_handle *handle)
 }
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_end);
 
-void zs_obj_write(struct zs_pool *pool, const struct zs_handle *handle,
-		  void *handle_mem, size_t mem_len)
+static void obj_write(struct size_class *class, struct zspage *zspage,
+		      unsigned long obj, const void *src, size_t size)
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
 		off += ZS_HANDLE_SIZE;
 
-	if (off + mem_len <= PAGE_SIZE) {
+	if (off + size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
 		void *dst = kmap_local_zpdesc(zpdesc);
 
-		memcpy(dst + off, handle_mem, mem_len);
+		memcpy(dst + off, src, size);
 		kunmap_local(dst);
 	} else {
 		/* this object spans two pages */
 		size_t sizes[2];
 
 		sizes[0] = PAGE_SIZE - off;
-		sizes[1] = mem_len - sizes[0];
+		sizes[1] = size - sizes[0];
 
-		memcpy_to_page(zpdesc_page(zpdesc), off,
-			       handle_mem, sizes[0]);
+		memcpy_to_page(zpdesc_page(zpdesc), off, src, sizes[0]);
 		zpdesc = get_next_zpdesc(zpdesc);
-		memcpy_to_page(zpdesc_page(zpdesc), 0,
-			       handle_mem + sizes[0], sizes[1]);
+		memcpy_to_page(zpdesc_page(zpdesc), 0, src + sizes[0], sizes[1]);
 	}
-
-	zspage_read_unlock(zspage);
 }
-EXPORT_SYMBOL_GPL(zs_obj_write);
 
 /**
  * zs_huge_class_size() - Returns the size (in bytes) of the first huge
@@ -1290,9 +1273,10 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 
 
 /**
- * zs_malloc - Allocate block of given size from pool.
+ * zs_store() - Allocate block of given size from pool and copy data into it.
  * @pool: pool to allocate from
  * @handle: handle to store allocated object in
+ * @src: data to copy into the allocated object
  * @size: size of block to allocate
  * @gfp: gfp flags when allocating object
  * @nid: The preferred node id to allocate new zspage (if needed)
@@ -1305,10 +1289,11 @@ static unsigned long obj_malloc(struct zs_pool *pool,
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
 
@@ -1330,7 +1315,7 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
 	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
-		obj_malloc(pool, zspage, handle);
+		obj = obj_malloc(pool, zspage, handle);
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		class_stat_add(class, ZS_OBJS_INUSE, 1);
@@ -1345,7 +1330,7 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
 		return -ENOMEM;
 
 	spin_lock(&class->lock);
-	obj_malloc(pool, zspage, handle);
+	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
@@ -1355,11 +1340,15 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
 out:
+	zspage_read_lock(zspage);
 	spin_unlock(&class->lock);
 
+	obj_write(class, zspage, obj, src, size);
+	zspage_read_unlock(zspage);
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(zs_malloc);
+EXPORT_SYMBOL_GPL(zs_store);
 
 static void obj_free(int class_size, unsigned long obj)
 {
@@ -1844,7 +1833,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * the class lock protects zpage alloc/free in the zspage.
 	 */
 	spin_lock(&class->lock);
-	/* the zspage write_lock protects zpage access via zs_obj_read/write() */
+	/*
+	 * The zspage write_lock protects zpage access via zs_obj_read_sg_*()
+	 * and zs_store().
+	 */
 	if (!zspage_write_trylock(zspage)) {
 		spin_unlock(&class->lock);
 		write_unlock(&pool->lock);
@@ -2238,7 +2230,7 @@ struct zs_pool *zs_create_pool(const char *name)
 			huge_class_size = size;
 			/*
 			 * The object uses ZS_HANDLE_SIZE bytes to store the
-			 * handle. We need to subtract it, because zs_malloc()
+			 * handle. We need to subtract it, because zs_store()
 			 * unconditionally adds handle size before it performs
 			 * size class search - so object may be smaller than
 			 * huge class size, yet it still can end up in the huge
diff --git a/mm/zswap.c b/mm/zswap.c
index 241f9fdebaad..a2e0314db1cf 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -950,12 +950,11 @@ static bool zswap_compress(struct folio *folio, long index,
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
2.56.0.506.g506a7eabc5-goog

