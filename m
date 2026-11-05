Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854090;
	b=3vIUTZpRZ4kXQesF3vrKQgS38DD3moIw2SPBaOMZnEYUYBvB3/v1bh/Th+IZuPk7Q4bf
	 rqd2FmLusY/WkSMxB79ABC1H5mpW8qw7HVFdMJH/wBSDzDorNwLAG6XmBdsX0zgbolX/a
	 TQ2/5lerQh0TNFiwk/in7Vj2kSc7Jdw0UemtKuNTAHIJPhLRd9ID5+7AyynwX4jxa4Npg
	 7rDdvRpAcO9sfKPz3ytNSycFklW0LWcJIZFfFDnG1qjyautqH8ttr5W6VRRwl+4uS/rU5
	 uIYfdYAIbJQVERhjAlB7LJOkFRk73DUwjQ5G8HLso9KcH60v1Vvo00SjDRGuvdCgiyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3ty0pxF0Y4y567rYue/e29XaeUplt8CeYzKMMjvhBvo=;
	b=c4F9ieW4K7tDZ0tKk4xYoUrsaZrbDj7W/T4rOJrcigKIh2SS9oZRaBnCG18LMYJ6Klqk
	 PVvNfLoycSgCI0DNwP+eCHpeSE43Ezeq3kCNgyVNz6FRvPRSfPe6+155P1GQRQ+8oDl/K
	 0axBbtgBqOdhHJEk0KiSYwZIQGux9SmZz2VTLveyt3ad9X1nVOpgygafRdYV6vRcbAZcF
	 luFUWk/D5SYWB1/kAGApf1P+GjTC9gDZpG03SKQy6Wh/PVZG5v6Wicdv3kwsR839iWoCW
	 oXaU6+P+e0X7zdx6DRN0HYOJGov5wrwjDTjjI03yFRV1S/aQhLoYDX6FyzbXTHi8yXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U5UBq+kq;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C216606A329
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 04:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C216606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U5UBq+kq
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1466743c88.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 20:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793854088; x=1794458888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ty0pxF0Y4y567rYue/e29XaeUplt8CeYzKMMjvhBvo=;
        b=U5UBq+kqrIhn1dL11t1zmApLI8352uktQXMUGyNhpIuiSViyA4IVuUfMgX4qB0qqAq
         wWs7OuQ/fg4DLEQg6sn9z8WVR2Peu42dw/27hTeDV6w/yYwsuEOm6zy7tXdqP42AgITZ
         y16rVaVJJwGHacNr0fxTMqLwn3PXfiSHexnVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854088; x=1794458888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ty0pxF0Y4y567rYue/e29XaeUplt8CeYzKMMjvhBvo=;
        b=J4UF6zOjZ3AV8r3klo5cjPSzFaIxnRR6hl3psEz2nnnfevztiib6uVr2f76vR1Km04
         xLfC9ov1gkT/+HCxqvsCWuKUPDB5hxXQ8VLT7EiAtey28Tq4Kx/UdvewTFB6Ozt6ZzBM
         vxJmsSkprkqn9jwYSrURh1APStGyrEywG1k29JcbLxtQXGKw31s4eSj5yPY99ac1xt5m
         XFQ0MlU3n/07zUhjt1OvmanKJNHaLZ6/NzRdTZhUFO8t0cZqmtnahjF0huI0nULSaceM
         q3eGMXZITH8/fTwVuwIYuwgjuI/mbqZzgFHO2lHP8NGmHyhQ61kWmHrHkeYvYY3Y3Kud
         EzNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVKDng3e7LS7eRjAIeTN5KWZL9WDHn/sgCmW8Rt6TjE/snRdxTJ9S1vvMz6qKxXNT0nC6wlvk+BAz84A==@vger.kernel.org
X-Gm-Message-State: APuU4Z87uWv7RunuvZhNX+fZfaSFtA5k3DfZdwZhrQMgC7NlWKghNFYW
	pQn+QMimnBE5RD0bXqkonyBzLe4oPRXGtV0O0SXO6nO8egMAMJKwrJnc6qHSCyljKQ==
X-Gm-Gg: AYBFou2xWZAIe0GiO4dXlZDTFe3bmkpplhc3DGGB2p7ddwk7bvTq2z2xRIEg0DDeX+L
	0DoDhLBwJMV2LMlSCpQVOPVyb1c34jnjiYiUs6CTZ48agReopjoAK9yGi4GMlkMkc01r9LF8XLD
	li7KDGNFZQNkxJrXmdwhUPm8h0d1ijZIAiP4NfEoWg33W8VBqf25sd0PpYXyLtr0wGAIrPSgXJk
	6skZa8ICdERyx0Oa5L0JkbayyZumBjNNtSBEz3sLwTKabmZGY+3ywOlC1LDt/DL+lu8lCkVjx25
	SfnhsnDOMoYapFQi4QkDDYdQlU0Anjjrqi0GTDegRoG0vkKwqAUdGPAZ9PNF4vaPxSrAKUS4Kve
	VrEtDmcjIoPEG2kjx0wA+3GSbG9epfWUf2+aNZRTrRtvNw6W0g/eVMzyD249xsSy4oZdnwD6fVA
	CxVDHcyqU5wqlM1JUEbXrwbAOpuUvcQrWmHEF1RN6eDL1I2qi0M9ItaG+aW7+k9XeojK4oeBRrg
	6rpBU7rNUH+Yae2+lyZWRMCry92Gsq3CtQyrlQ3eS+mb2DMpbe4BAuwwPFditNC18Y+rrcKelUW
	AuyhV4T1O5I0w5Z0Wi5De9KnGysXxc7PytjRjuKm5B9hP832zrQKlQr9hZ9G3qFbYhqPh+4C79h
	UlX0BMv4BSPqP6UdBZvc=
X-Received: by 2002:a05:7022:f115:b0:183:7d42:cfb5 with SMTP id a92af1059eb24-1ac5d88c1famr24632184c88.19.1793854088224;
        Wed, 04 Nov 2026 20:48:08 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:37bc:b763:7ec7:65b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm17142927c88.21.2026.11.04.20.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:48:07 -0800 (PST)
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
Subject: [PATCH 3/7] zsmalloc: switch handle type to struct zs_handle
Date: Thu,  5 Nov 2026 13:47:33 +0900
Message-ID: <20261105044752.1997895-4-senozhatsky@chromium.org>
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

zsmalloc handle is an unsigned long that holds an address of a
handle_cachep object, so zsmalloc and its users have to cast it
back and forth.  Introduce struct zs_handle and switch zsmalloc,
zram and zswap to struct zs_handle pointers.

This is a preparation for the next patches, which embed struct
zs_handle into zram and zswap entries.  No functional change.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 28 ++++++------
 drivers/block/zram/zram_drv.h |  2 +-
 include/linux/zsmalloc.h      | 13 +++---
 mm/zsmalloc.c                 | 83 +++++++++++++++++++----------------
 mm/zswap.c                    |  8 ++--
 5 files changed, 72 insertions(+), 62 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5c13addd22f6..2c2e11b2b663 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2030,7 +2030,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 
 static void slot_free(struct zram *zram, unsigned long index)
 {
-	unsigned long handle;
+	struct zs_handle *handle;
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].attr.ac_time = 0;
@@ -2096,7 +2096,7 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
 				    unsigned long index)
 {
 	struct scatterlist sg[2];
-	unsigned long handle;
+	struct zs_handle *handle;
 	void *src, *dst;
 
 	handle = zram->table[index].handle;
@@ -2118,7 +2118,7 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	enum zcomp_dstrm_mode mode = ZCOMP_DSTRM_EXCLUSIVE;
 	struct zcomp_dstrm *zstrm;
 	struct scatterlist sg[2];
-	unsigned long handle;
+	struct zs_handle *handle;
 	unsigned int size;
 	void *dst;
 	int ret, prio;
@@ -2146,7 +2146,7 @@ static int read_from_zspool_raw(struct zram *zram, struct page *page,
 				unsigned long index)
 {
 	struct scatterlist sg[2];
-	unsigned long handle;
+	struct zs_handle *handle;
 	unsigned int size;
 	void *dst;
 
@@ -2257,14 +2257,14 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 static int write_incompressible_page(struct zram *zram, struct page *page,
 				     unsigned long index)
 {
-	unsigned long handle;
+	struct zs_handle *handle;
 	void *src;
 
 	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
-	if (IS_ERR_VALUE(handle))
-		return PTR_ERR((void *)handle);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
 	if (!zram_can_store_page(zram)) {
 		zs_free(zram->mem_pool, handle);
@@ -2295,7 +2295,7 @@ static int zram_write_page(struct zram *zram, struct page *page,
 			   unsigned long index)
 {
 	int ret = 0;
-	unsigned long handle;
+	struct zs_handle *handle;
 	unsigned int comp_len;
 	void *mem;
 	struct zcomp_cstrm *zstrm;
@@ -2328,9 +2328,9 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	handle = zs_malloc(zram->mem_pool, comp_len,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
-	if (IS_ERR_VALUE(handle)) {
+	if (IS_ERR(handle)) {
 		zcomp_cstrm_put(zstrm);
-		return PTR_ERR((void *)handle);
+		return PTR_ERR(handle);
 	}
 
 	if (!zram_can_store_page(zram)) {
@@ -2451,8 +2451,8 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 			   u32 threshold, u32 prio)
 {
 	struct zcomp_cstrm *zstrm = NULL;
-	unsigned long handle_old;
-	unsigned long handle_new;
+	struct zs_handle *handle_old;
+	struct zs_handle *handle_new;
 	unsigned int comp_len_old;
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
@@ -2534,9 +2534,9 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 			       GFP_NOIO | __GFP_NOWARN |
 			       __GFP_HIGHMEM | __GFP_MOVABLE,
 			       page_to_nid(page));
-	if (IS_ERR_VALUE(handle_new)) {
+	if (IS_ERR(handle_new)) {
 		zcomp_cstrm_put(zstrm);
-		return PTR_ERR((void *)handle_new);
+		return PTR_ERR(handle_new);
 	}
 
 	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 5416e25e64e8..5b211a9f314c 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -79,7 +79,7 @@ enum zram_pageflags {
  */
 struct zram_table_entry {
 	union {
-		unsigned long handle;
+		struct zs_handle *handle;
 		unsigned long element;
 		unsigned long blk_idx;
 	};
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 5b7298a5026b..693c9484b638 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -22,14 +22,15 @@ struct zs_pool_stats {
 };
 
 struct zs_pool;
+struct zs_handle;
 struct scatterlist;
 
 struct zs_pool *zs_create_pool(const char *name);
 void zs_destroy_pool(struct zs_pool *pool);
 
-unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
-			const int nid);
-void zs_free(struct zs_pool *pool, unsigned long obj);
+struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
+			    const int nid);
+void zs_free(struct zs_pool *pool, struct zs_handle *handle);
 
 size_t zs_huge_class_size(struct zs_pool *pool);
 
@@ -40,10 +41,10 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size);
 
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
 
-void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
+void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
 			  struct scatterlist *sg, size_t mem_len);
-void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
-void zs_obj_write(struct zs_pool *pool, unsigned long handle,
+void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle);
+void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
 		  void *handle_mem, size_t mem_len);
 
 extern const struct movable_operations zsmalloc_mops;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7ef80e0da626..7d8aab56f5cd 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -264,6 +264,10 @@ struct link_free {
 	};
 };
 
+struct zs_handle {
+	unsigned long __private obj;
+};
+
 static struct kmem_cache *handle_cachep;
 static struct kmem_cache *zspage_cachep;
 
@@ -438,16 +442,16 @@ static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 #endif
 
-static unsigned long cache_alloc_handle(gfp_t gfp)
+static struct zs_handle *cache_alloc_handle(gfp_t gfp)
 {
 	gfp = gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE);
 
-	return (unsigned long)kmem_cache_alloc(handle_cachep, gfp);
+	return kmem_cache_alloc(handle_cachep, gfp);
 }
 
-static void cache_free_handle(unsigned long handle)
+static void cache_free_handle(struct zs_handle *handle)
 {
-	kmem_cache_free(handle_cachep, (void *)handle);
+	kmem_cache_free(handle_cachep, handle);
 }
 
 static struct zspage *cache_alloc_zspage(gfp_t gfp)
@@ -466,9 +470,9 @@ static void cache_free_zspage(struct zspage *zspage)
  * Pairs with READ_ONCE() in handle_to_obj(): zs_free() may read the
  * handle locklessly, so prevent store tearing here.
  */
-static void record_obj(unsigned long handle, unsigned long obj)
+static void record_obj(struct zs_handle *handle, unsigned long obj)
 {
-	WRITE_ONCE(*(unsigned long *)handle, obj);
+	WRITE_ONCE(ACCESS_PRIVATE(handle, obj), obj);
 }
 
 /* Protected by class->lock */
@@ -817,13 +821,13 @@ static unsigned long location_to_obj(struct zpdesc *zpdesc, unsigned int obj_idx
 	return obj;
 }
 
-static unsigned long handle_to_obj(unsigned long handle)
+static unsigned long handle_to_obj(struct zs_handle *handle)
 {
-	return READ_ONCE(*(unsigned long *)handle);
+	return READ_ONCE(ACCESS_PRIVATE(handle, obj));
 }
 
 static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
-				 unsigned long *phandle)
+				 struct zs_handle **phandle)
 {
 	unsigned long handle;
 	struct zspage *zspage = get_zspage(zpdesc);
@@ -839,7 +843,7 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 		return false;
 
 	/* Clear all tags before returning the handle */
-	*phandle = handle & ~OBJ_TAG_MASK;
+	*phandle = (struct zs_handle *)(handle & ~OBJ_TAG_MASK);
 	return true;
 }
 
@@ -1122,7 +1126,7 @@ unsigned long zs_get_total_pages(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_get_total_pages);
 
-void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
+void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
 			  struct scatterlist *sg, size_t mem_len)
 {
 	struct zspage *zspage;
@@ -1169,7 +1173,7 @@ void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
 }
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_begin);
 
-void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle)
+void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle)
 {
 	struct zspage *zspage;
 	struct zpdesc *zpdesc;
@@ -1184,7 +1188,7 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle)
 }
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_end);
 
-void zs_obj_write(struct zs_pool *pool, unsigned long handle,
+void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
 		  void *handle_mem, size_t mem_len)
 {
 	struct zspage *zspage;
@@ -1253,7 +1257,7 @@ size_t zs_huge_class_size(struct zs_pool *pool)
 EXPORT_SYMBOL_GPL(zs_huge_class_size);
 
 static unsigned long obj_malloc(struct zs_pool *pool,
-				struct zspage *zspage, unsigned long handle)
+				struct zspage *zspage, struct zs_handle *handle)
 {
 	int i, nr_zpdesc, offset;
 	unsigned long obj;
@@ -1280,9 +1284,10 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	set_freeobj(zspage, link->next >> OBJ_TAG_BITS);
 	if (likely(!ZsHugePage(zspage)))
 		/* record handle in the header of allocated chunk */
-		link->handle = handle | OBJ_ALLOCATED_TAG;
+		link->handle = (unsigned long)handle | OBJ_ALLOCATED_TAG;
 	else
-		zspage->first_zpdesc->handle = handle | OBJ_ALLOCATED_TAG;
+		zspage->first_zpdesc->handle =
+			(unsigned long)handle | OBJ_ALLOCATED_TAG;
 
 	kunmap_local(vaddr);
 	mod_zspage_inuse(zspage, 1);
@@ -1305,23 +1310,23 @@ static unsigned long obj_malloc(struct zs_pool *pool,
  * otherwise an ERR_PTR().
  * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
  */
-unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
-			const int nid)
+struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
+			    const int nid)
 {
-	unsigned long handle;
+	struct zs_handle *handle;
 	struct size_class *class;
 	int newfg;
 	struct zspage *zspage;
 
 	if (unlikely(!size))
-		return (unsigned long)ERR_PTR(-EINVAL);
+		return ERR_PTR(-EINVAL);
 
 	if (unlikely(size > ZS_MAX_ALLOC_SIZE))
-		return (unsigned long)ERR_PTR(-ENOSPC);
+		return ERR_PTR(-ENOSPC);
 
 	handle = cache_alloc_handle(gfp);
 	if (!handle)
-		return (unsigned long)ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
 	class = lookup_size_class(pool, size);
 
@@ -1342,7 +1347,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
 	zspage = alloc_zspage(pool, class, gfp, nid);
 	if (!zspage) {
 		cache_free_handle(handle);
-		return (unsigned long)ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	spin_lock(&class->lock);
@@ -1410,9 +1415,11 @@ static unsigned int obj_to_class_idx(unsigned long obj)
  * encoding is disabled), fall back to pool->lock for the lookup.
  */
 #if ZS_OBJ_CLASS_BITS > 0
-static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long handle,
-					 unsigned long *objp, struct zspage **zspagep,
-					 struct size_class **classp)
+static inline void obj_class_get_and_lock(struct zs_pool *pool,
+					  struct zs_handle *handle,
+					  unsigned long *objp,
+					  struct zspage **zspagep,
+					  struct size_class **classp)
 	__acquires(&(*classp)->lock)
 {
 	struct zpdesc *f_zpdesc;
@@ -1428,9 +1435,11 @@ static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long ha
 	*objp = obj;
 }
 #else
-static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long handle,
-					 unsigned long *objp, struct zspage **zspagep,
-					 struct size_class **classp)
+static inline void obj_class_get_and_lock(struct zs_pool *pool,
+					  struct zs_handle *handle,
+					  unsigned long *objp,
+					  struct zspage **zspagep,
+					  struct size_class **classp)
 	__acquires(&(*classp)->lock)
 {
 	struct zpdesc *f_zpdesc;
@@ -1447,7 +1456,7 @@ static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long ha
 }
 #endif
 
-void zs_free(struct zs_pool *pool, unsigned long handle)
+void zs_free(struct zs_pool *pool, struct zs_handle *handle)
 {
 	struct zspage *zspage;
 	unsigned long obj;
@@ -1455,7 +1464,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	int fullness;
 	struct zspage *zspage_to_free = NULL;
 
-	if (IS_ERR_OR_NULL((void *)handle))
+	if (IS_ERR_OR_NULL(handle))
 		return;
 
 	obj_class_get_and_lock(pool, handle, &obj, &zspage, &class);
@@ -1559,12 +1568,12 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
  * Find alloced object in zspage from index object and
  * return handle.
  */
-static unsigned long find_alloced_obj(struct size_class *class,
-				      struct zpdesc *zpdesc, int *obj_idx)
+static struct zs_handle *find_alloced_obj(struct size_class *class,
+					  struct zpdesc *zpdesc, int *obj_idx)
 {
 	unsigned int offset;
 	int index = *obj_idx;
-	unsigned long handle = 0;
+	struct zs_handle *handle = NULL;
 	void *addr = kmap_local_zpdesc(zpdesc);
 
 	offset = get_first_obj_offset(zpdesc);
@@ -1589,7 +1598,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 			   struct zspage *dst_zspage)
 {
 	unsigned long used_obj, free_obj;
-	unsigned long handle;
+	struct zs_handle *handle;
 	int obj_idx = 0;
 	struct zpdesc *s_zpdesc = get_first_zpdesc(src_zspage);
 	struct size_class *class = pool->size_class[src_zspage->class];
@@ -1760,7 +1769,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	struct zpdesc *zpdesc = page_zpdesc(page);
 	void *s_addr, *d_addr, *addr;
 	unsigned int offset;
-	unsigned long handle;
+	struct zs_handle *handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
@@ -2291,7 +2300,7 @@ static void zs_destroy_caches(void)
 
 static int __init zs_init_caches(void)
 {
-	handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
+	handle_cachep = kmem_cache_create("zs_handle", sizeof(struct zs_handle),
 					  0, 0, NULL);
 	zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
 					  0, 0, NULL);
diff --git a/mm/zswap.c b/mm/zswap.c
index ad01c691a263..397b06c9f33b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -215,7 +215,7 @@ struct zswap_entry {
 	unsigned int length;
 	bool referenced;
 	u8 pool_idx;
-	unsigned long handle;
+	struct zs_handle *handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
 };
@@ -888,7 +888,7 @@ static bool zswap_compress(struct folio *folio, long index,
 	struct scatterlist input, output;
 	int comp_ret = 0, alloc_ret = 0;
 	unsigned int dlen = PAGE_SIZE;
-	unsigned long handle;
+	struct zs_handle *handle;
 	gfp_t gfp;
 	u8 *dst;
 	bool mapped = false;
@@ -949,8 +949,8 @@ static bool zswap_compress(struct folio *folio, long index,
 
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
 	handle = zs_malloc(pool->zs_pool, dlen, gfp, folio_nid(folio));
-	if (IS_ERR_VALUE(handle)) {
-		alloc_ret = PTR_ERR((void *)handle);
+	if (IS_ERR(handle)) {
+		alloc_ret = PTR_ERR(handle);
 		goto unlock;
 	}
 
-- 
2.56.0.398.g882cbad275-goog

