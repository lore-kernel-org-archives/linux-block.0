Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379664;
	b=2KXrV+KSDJc8nH8G7EINGioBSjtQOGAHlUHu0C7U0hZwhZM7BzMHxvJ5amcQhv9eQikU
	 vPtX9Ivs3yrnykyesfLJROJca8MiPAXKkYBPuWog9BYDRdrl5UxMPGtQPhcXMqs8gYjst
	 FDNSAann+s8j+L5DVL/Ky5i3UVhcmI9kc2C3WnCRe4lJSZB5MBsn/NYz5pUFXI9nT60G9
	 pMEIagBwirlpd4i9rHoAouEP0ZuEzGKyEL702/seqxG2qzadT0FW+1mVLz97SkHMyvVV7
	 xLGqcnuiUnmemtyCZBHZ9KT25Z+umuIeP2Sau/TE9aQnqLL3EsBU6AxbHSr2iZzgfMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g28+tavLB0lAEvj5/W5N95PkXK37OPKvpEh4+PqsI6M=;
	b=WLEFDVs87SiufBaqmkSpcw71+zkFp++9p22nsyXs0IQTQbjOQhT+hgUp2UhvHvOlY+CS
	 2VkTvw8SrZpSUAqA7uFdZV/2eb1Yj+W9D6stKAxf30bHiMB4J2ns8DVFP7JP9D8sjbzzD
	 zrKvF/Tc7P5/FsRzuqetXFDW+785xmLkvitkJmz02GJRvB9daMm1l2eRkRRCqs+Fhn6dj
	 0EH7HvU6e31uQOrJ6XstdBNY2tQGGh8u8VPM3gO9s7ptmX0SnKFsMFfNMO+P0hYQb+gnT
	 NnGF2XkFs8sl3V0wPKA5iQEtTtLE6uCc4XFIPnzLn8YgYeG2JAiVytwHLToxR2E936w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SiFq1C22;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308E606B465
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4308E606B465
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SiFq1C22
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso1802387a91.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379663; x=1794984463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g28+tavLB0lAEvj5/W5N95PkXK37OPKvpEh4+PqsI6M=;
        b=SiFq1C22NKRrPPOsjjm04CCTAWMWqFcL5a5J1o5tJyySmVXCk5QXMuiXKNMgtiVuAF
         SzTf9SJVrJFr1yimMUPp9uA//oK9/Yc9DzFssxSpk9YalhgP2mKvDKUUWTKAzjd+822u
         /44anJBqlmeFwpDTsWb/Mh1Tj4tnTCa7zPJeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379663; x=1794984463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g28+tavLB0lAEvj5/W5N95PkXK37OPKvpEh4+PqsI6M=;
        b=xsa5Gh+9ODYTXS/B2zI+QgwZqAfKlQ4j48+ivA5UxKYL9dLUMaghc1AZerkv/P85O5
         x+GAkETc+nF/Dzl3YvI6vzk0enrCMXbJC4KCnoZ4M0JpKLINLUX6XOjDWMart35Aje35
         wP16mAPGEgCgaVSFjXsTDEMwYSG9xgxBvNBkfB+xJ/CZ2Elr57IDMO3nmeNDGYXJ9CNL
         ojdIHXmi3Sv+QJCJQwNjxWtDKRwkE2qAzXPG8rTi+gpHkXakEOU6EXLmiNQfCh49yMLG
         FmdC8wg9UvWV91xR8s4Sss25wwn1wNSHzoxtYoCAOk4YTAxlG/f9A7CbcGaIug6LZSwY
         iJSQ==
X-Forwarded-Encrypted: i=1; AL+hErG89PTFd8tZ+l6CaKK+NSxDJG9SlvoaRXB7Thuw3HdxmBo7QRGKY7idAOXH7uJ9dPo6LaNm/UlUABkZVg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+jGQzoCrMhdY11sA3xFupmBec+x4D5i0ueAWgM5v+uvavXqHIu
	Q0bRYLcbWihwgp5HnLhS9fwKhNP/1YxW5Q0p1vwqQmEr20SWqaE8hj8DrhN0UPE8Cw==
X-Gm-Gg: AYBFou1NWhJDjoENjjbsNCYF7hOC1xf4CIlV6vm21kqP5hrpsyDjN5xGUYFKPq1wWE/
	NQVqbh5W40lDi4Wv3/YaPqG/Zir8HqhKuR/Kq6Y5Y3SQjU/sTswCYXriiuRvpoomtRSYe/tHs8b
	MZtZtTKGjn47l+q5B9OWfBJWnZ4mdKKytOOnRE+G2ZSSgSDRtPdA6KQABeenwruD53Ce9yX4HE2
	5twcmzwXqvItet3bnuqAYjYvTQkwYuf/MJhdsbSj9Mf2EDITvTYzEwluWQZtz/6dIgFZBCB7hJt
	1QEfCHnnEOhRj6rjTnezpTkOdhqYPJZRV1+zUWs6g2lORP5wKbOd4xTDt121QMrRS3kcbD1HYjU
	D1KOTitEnSz/6adQA3DxnHv0SompuGe0Osk6ZHqdlQsNzAaOSt0T8YjThn1qFXLnaVsDgUheXRW
	rmjNEKh1z6YO9YdmEyZQkazyELtC32smd5YUcFJlnnOE6XlUWW4VOxaFwWWk3wrqxEcno6RMKn3
	UR5tGYrfAHbZnG4X61IBaZ/FZFODsY9b86Gt63XW6vEkMDEaqxdWqtuQUisvyjSmeZW5Cdzf/km
	jHMwPbSLYleWbxlvbk+DYqgxTpz67nRcfZ5qvTDxYVunh0F0AA0zlv5lEkWldOXIX9uUBpLqJiq
	HoVfdjXlZbR1IodWsk8OTp5+LGWM0Rlze4h366Ws=
X-Received: by 2002:a17:90b:4b8c:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3b182f25969mr1169183a91.24.1794379663450;
        Tue, 10 Nov 2026 22:47:43 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:42 -0800 (PST)
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
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 10/11] zsmalloc: fold zs_obj_write() into zs_store()
Date: Wed, 11 Nov 2026 15:46:33 +0900
Message-ID: <20261111064707.2568433-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
In-Reply-To: <20261111064707.2568433-1-senozhatsky@chromium.org>
References: <20261111064707.2568433-1-senozhatsky@chromium.org>
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

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
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
index 878582cb1e33..946b625761f8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2263,9 +2263,11 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 
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
@@ -2273,11 +2275,6 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 
 	update_used_max(zram);
 
-	src = kmap_local_page(page);
-	zs_obj_write(zram->mem_pool, &zram->table[index].handle, src,
-		     PAGE_SIZE);
-	kunmap_local(src);
-
 	set_slot_flag(zram, index, ZRAM_HUGE);
 	set_slot_size(zram, index, PAGE_SIZE);
 	mark_slot_accessed(zram, index);
@@ -2329,21 +2326,18 @@ static int zram_write_page(struct zram *zram, struct page *page,
 
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
@@ -2528,18 +2522,12 @@ static int recompress_slot(struct zram *zram, unsigned long index,
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
index 54d4fe8ada53..7f1cedd34081 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1185,54 +1185,37 @@ void zs_obj_read_sg_end(struct zs_pool *pool, const struct zs_handle *handle)
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
@@ -1297,9 +1280,10 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 
 
 /**
- * zs_malloc - Allocate block of given size from pool.
+ * zs_store() - Allocate block of given size from pool and copy data into it.
  * @pool: pool to allocate from
  * @handle: handle to store allocated object in
+ * @src: data to copy into the allocated object
  * @size: size of block to allocate
  * @gfp: gfp flags when allocating object
  * @nid: The preferred node id to allocate new zspage (if needed)
@@ -1312,10 +1296,11 @@ static unsigned long obj_malloc(struct zs_pool *pool,
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
 
@@ -1334,7 +1319,7 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
 	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
-		obj_malloc(pool, zspage, handle);
+		obj = obj_malloc(pool, zspage, handle);
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		class_stat_add(class, ZS_OBJS_INUSE, 1);
@@ -1349,7 +1334,7 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
 		return -ENOMEM;
 
 	spin_lock(&class->lock);
-	obj_malloc(pool, zspage, handle);
+	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
@@ -1359,11 +1344,15 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
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
@@ -1845,7 +1834,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -2239,7 +2231,7 @@ struct zs_pool *zs_create_pool(const char *name)
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
2.56.0.542.g3ef89b7020-goog

