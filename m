Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289739;
	b=snqKHIFyd14ese5ITwKoQ7VoM/dQAzXX8NYhV9dO+oWDwhrg5W3RtgfXsQcljU8yvLkR
	 TZmFmpkA0Uxy2ZmJ7ouC4fv2P4Bgx/Awhjs6/4FIR3R9SKLr0Pu2L9xUoZkZMG5nPFmzN
	 2MDQVFB8n1VoJoa6DZxFnToJ0hl+kSTzJEI4+PjB5mZfYcuWqDFe2KVnvZll83EWvX4Rw
	 iwHzTgTDgNokiNIL1/vWpAujzsYEZd1ihpqXJFCAOHWBtEKAsdsUty/l2g+4SjWEVQitU
	 jW9x2x+z+Szbt65EEdp0TFrO5I5IgSIa5bzO1Ehsz09PEnmkhKg6kg8qqBJEooaO9GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1kCFvXE1I6TMTzcovLh/jNTD4puJnNsyYl7iqOayhW0=;
	b=Y0j0Cf8tt0vqyCtoXFIXX8a6NI5PzVKJMtwqy3VIUP3OUr49vWv7kYN0naUwMXVB3F33
	 c22hr9RpHY3BYppKCwIhiXBXxaV4RfbLpxXGDXLdlxQf0dnhZI/3wAsbf5/lozB1SvpPV
	 0gi+9P/X8EFhh+nxz65KS/XWFF1IC3ayNqmnGH6omFVB1OfBSAMEdC/a53+UHwlk9Pg2C
	 7EUDPcFq4QZCH9XRZh7RdP7FeitxU18Qh/o61gt1h8mwzBG3VGukGmOIae3KwfAi1Fv2h
	 URrucWw9zwX3zLeNIDqOiXy9P8t8oMLH2pS5fGWddpl6QXTHTgb9ME0eyGp4yS5xSzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gumsngSd;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739660A260B
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4739660A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gumsngSd
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so681472b3a.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289738; x=1794894538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kCFvXE1I6TMTzcovLh/jNTD4puJnNsyYl7iqOayhW0=;
        b=gumsngSdt9EBu5/W9LBj6lJMSbR+OS41FetLEnfdVfcuNsFI9SvlaowHylIPOzN684
         S5CCjsjLCCN1y40oTgXGOM7C97tg5/BtHAj3cuJwVA21Oo4+2vD7/2BLHzYPh/6D0jGo
         Z2+5jKW/4K2GNfPDluIdSJsU1X8HoR3vZoJRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289738; x=1794894538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kCFvXE1I6TMTzcovLh/jNTD4puJnNsyYl7iqOayhW0=;
        b=pmv+waceYABFsT35Tp7NGEtHxx7S6A1i3AzG+fTMYyhvrRu9tByKLD1OeBOMS5o+T1
         qYpiGOqJH7334sv4kYLO+la29Ib+SyqNk7QVvNRAlVC+PHL9egpCNa1OutcpVcOV8xnm
         sFLQ6zRpW/PAtBAIhB5iC9EqMgpn7SOW8iDvVGxXk1AZ0cD0XU3IC2UeCfNzWetrF8RM
         mlAYh1JowJ+IpmVd5cf8aEH15FiwBCQiGNTy+uQRfhKJ19MUn0YhR0FP74mLHns7gSXZ
         XHdRIrg0+UAWEEYgVjoRDxe+yA54iHl8dkGG9yu7zCfFiOQEbYJoP4jINHAVfy85MwGV
         DQMA==
X-Forwarded-Encrypted: i=1; AL+hErH8DiTJ/IeK1tPrdW+lrtc4vKgcVADuN8251r8TOx91XR6gkQTq6TC6S9lrlp89dJ+iF8Kl1OCRBkI2Gw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/zFroUS40ZMsMpzNFxiaYjMH5wUbeYR4vUzsOVgCwc1PiD5s7K
	EcrMPf9NlXgQHfUf3CyUWW1jR/hGsljMDUbP6dddUlsWxwVKwfVariaWhvyG72P6nA==
X-Gm-Gg: AYBFou02IihUkMoRJWDz0ryw+vZa5kMsFZtPAKDxqseTAJ1gI3T8kAPJ3GF2tWLVlkb
	odtgF4XtT6EGz288hOcWKtCvtSdjMkQY2ro+2SJiSWszRS9zLQ43PM9RM+6RMUi//cJ8VU3THEn
	QvoqiLAy3uHg3b9XXAxyf6KXH6txQ/VueSc2+QGeCE1vKf7UmmDBwqr6CWVMBBavrxxkxGbbAbW
	qxbOipZgdBGCr8Pd+JDxDnVjFHKKcVmNP47nD+3XPU2vkqhGwALEYfJMAnY8UJWTWBoI+jqEgvL
	xSp5+eP7Yd5qSEQ6VIg1tNVTaF74Z6PV2OfpXkdgcZ2sMTWmhAO8/gzn5ntL+6Fsp/9plxrs+7l
	MHJie7t10JbU5o0P9L1xmUFKzGGHTkmDjyqpVJk4Lg4+qEsUlZIgOX6RRxd97c2QSrsaeMx+5ly
	aUVTieSO+qw0xdArZzmDFRSxLemYlZMFEy+tsgcnkjKBCJ+MPEeC9+ZLywTqYtNSYfwd49YOd4K
	MOP3BMR8uqBtEFXAoKPy7YFVNe0KMSbTgz3iHPdNLoZShwRnWOlBwzcWyVoJ/Bv7rIplVNYLnpo
	VlGLkXbGshrCjfH6dSRbEMoBS8pcLkJzohefHUrQMaw83oBB4t9EZW4QwwodRAQGq158o0MqXsm
	tK9QFAON6XCbHdFlpJjY=
X-Received: by 2002:a05:6a20:4394:b0:3d4:52bd:b89d with SMTP id adf61e73a8af0-3f18ebb376cmr1436126637.23.1794289737457;
        Mon, 09 Nov 2026 21:48:57 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:48:57 -0800 (PST)
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
Subject: [PATCH v2 04/11] zsmalloc: switch handle type to struct zs_handle
Date: Tue, 10 Nov 2026 14:48:09 +0900
Message-ID: <20261110054836.1515030-5-senozhatsky@chromium.org>
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

zsmalloc handle is an unsigned long that holds an address of a
handle_cachep object, so zsmalloc and its users have to cast it
back and forth.  Introduce struct zs_handle and switch zsmalloc,
zram and zswap to struct zs_handle pointers.  Functions that only
read the handle take a const pointer.

This is a preparation for embedding struct zs_handle into zram and
zswap entries.  No functional change.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 28 ++++++------
 drivers/block/zram/zram_drv.h |  2 +-
 include/linux/zsmalloc.h      | 13 +++---
 mm/zsmalloc.c                 | 85 +++++++++++++++++++----------------
 mm/zswap.c                    |  8 ++--
 5 files changed, 73 insertions(+), 63 deletions(-)

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
index 5b7298a5026b..7fa500ae2653 100644
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
+void zs_obj_read_sg_begin(struct zs_pool *pool, const struct zs_handle *handle,
 			  struct scatterlist *sg, size_t mem_len);
-void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
-void zs_obj_write(struct zs_pool *pool, unsigned long handle,
+void zs_obj_read_sg_end(struct zs_pool *pool, const struct zs_handle *handle);
+void zs_obj_write(struct zs_pool *pool, const struct zs_handle *handle,
 		  void *handle_mem, size_t mem_len);
 
 extern const struct movable_operations zsmalloc_mops;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index dab71f582103..3a6a7253fd01 100644
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
@@ -817,12 +821,12 @@ static unsigned long location_to_obj(struct zpdesc *zpdesc, unsigned int obj_idx
 	return obj;
 }
 
-static unsigned long handle_to_obj(unsigned long handle)
+static unsigned long handle_to_obj(const struct zs_handle *handle)
 {
-	return READ_ONCE(*(unsigned long *)handle);
+	return READ_ONCE(ACCESS_PRIVATE(handle, obj));
 }
 
-static inline unsigned long obj_allocated(struct zpdesc *zpdesc, void *obj)
+static inline struct zs_handle *obj_allocated(struct zpdesc *zpdesc, void *obj)
 {
 	unsigned long handle;
 	struct zspage *zspage = get_zspage(zpdesc);
@@ -835,10 +839,10 @@ static inline unsigned long obj_allocated(struct zpdesc *zpdesc, void *obj)
 		handle = *(unsigned long *)obj;
 
 	if (!(handle & OBJ_ALLOCATED_TAG))
-		return 0;
+		return NULL;
 
 	/* Clear all tags before returning the handle */
-	return handle & ~OBJ_TAG_MASK;
+	return (struct zs_handle *)(handle & ~OBJ_TAG_MASK);
 }
 
 static void reset_zpdesc(struct zpdesc *zpdesc)
@@ -1120,7 +1124,7 @@ unsigned long zs_get_total_pages(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_get_total_pages);
 
-void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
+void zs_obj_read_sg_begin(struct zs_pool *pool, const struct zs_handle *handle,
 			  struct scatterlist *sg, size_t mem_len)
 {
 	struct zspage *zspage;
@@ -1167,7 +1171,7 @@ void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
 }
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_begin);
 
-void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle)
+void zs_obj_read_sg_end(struct zs_pool *pool, const struct zs_handle *handle)
 {
 	struct zspage *zspage;
 	struct zpdesc *zpdesc;
@@ -1182,7 +1186,7 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle)
 }
 EXPORT_SYMBOL_GPL(zs_obj_read_sg_end);
 
-void zs_obj_write(struct zs_pool *pool, unsigned long handle,
+void zs_obj_write(struct zs_pool *pool, const struct zs_handle *handle,
 		  void *handle_mem, size_t mem_len)
 {
 	struct zspage *zspage;
@@ -1251,7 +1255,7 @@ size_t zs_huge_class_size(struct zs_pool *pool)
 EXPORT_SYMBOL_GPL(zs_huge_class_size);
 
 static unsigned long obj_malloc(struct zs_pool *pool,
-				struct zspage *zspage, unsigned long handle)
+				struct zspage *zspage, struct zs_handle *handle)
 {
 	int i, nr_zpdesc, offset;
 	unsigned long obj;
@@ -1278,9 +1282,10 @@ static unsigned long obj_malloc(struct zs_pool *pool,
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
@@ -1303,23 +1308,23 @@ static unsigned long obj_malloc(struct zs_pool *pool,
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
 
@@ -1340,7 +1345,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
 	zspage = alloc_zspage(pool, class, gfp, nid);
 	if (!zspage) {
 		cache_free_handle(handle);
-		return (unsigned long)ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	spin_lock(&class->lock);
@@ -1408,9 +1413,11 @@ static unsigned int obj_to_class_idx(unsigned long obj)
  * encoding is disabled), fall back to pool->lock for the lookup.
  */
 #if ZS_OBJ_CLASS_BITS > 0
-static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long handle,
-					 unsigned long *objp, struct zspage **zspagep,
-					 struct size_class **classp)
+static inline void obj_class_get_and_lock(struct zs_pool *pool,
+					  const struct zs_handle *handle,
+					  unsigned long *objp,
+					  struct zspage **zspagep,
+					  struct size_class **classp)
 	__acquires(&(*classp)->lock)
 {
 	struct zpdesc *f_zpdesc;
@@ -1426,9 +1433,11 @@ static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long ha
 	*objp = obj;
 }
 #else
-static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long handle,
-					 unsigned long *objp, struct zspage **zspagep,
-					 struct size_class **classp)
+static inline void obj_class_get_and_lock(struct zs_pool *pool,
+					  const struct zs_handle *handle,
+					  unsigned long *objp,
+					  struct zspage **zspagep,
+					  struct size_class **classp)
 	__acquires(&(*classp)->lock)
 {
 	struct zpdesc *f_zpdesc;
@@ -1445,7 +1454,7 @@ static inline void obj_class_get_and_lock(struct zs_pool *pool, unsigned long ha
 }
 #endif
 
-void zs_free(struct zs_pool *pool, unsigned long handle)
+void zs_free(struct zs_pool *pool, struct zs_handle *handle)
 {
 	struct zspage *zspage;
 	unsigned long obj;
@@ -1453,7 +1462,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	int fullness;
 	struct zspage *zspage_to_free = NULL;
 
-	if (IS_ERR_OR_NULL((void *)handle))
+	if (IS_ERR_OR_NULL(handle))
 		return;
 
 	obj_class_get_and_lock(pool, handle, &obj, &zspage, &class);
@@ -1557,12 +1566,12 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
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
@@ -1588,7 +1597,7 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 			   struct zspage *dst_zspage)
 {
 	unsigned long used_obj, free_obj;
-	unsigned long handle;
+	struct zs_handle *handle;
 	int obj_idx = 0;
 	struct zpdesc *s_zpdesc = get_first_zpdesc(src_zspage);
 	struct size_class *class = pool->size_class[src_zspage->class];
@@ -1759,7 +1768,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	struct zpdesc *zpdesc = page_zpdesc(page);
 	void *s_addr, *d_addr, *addr;
 	unsigned int offset;
-	unsigned long handle;
+	struct zs_handle *handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
@@ -2290,7 +2299,7 @@ static void zs_destroy_caches(void)
 
 static int __init zs_init_caches(void)
 {
-	handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
+	handle_cachep = kmem_cache_create("zs_handle", sizeof(struct zs_handle),
 					  0, 0, NULL);
 	zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
 					  0, 0, NULL);
diff --git a/mm/zswap.c b/mm/zswap.c
index 37d217860a6b..1160bd34e289 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -216,7 +216,7 @@ struct zswap_entry {
 	unsigned int length;
 	bool referenced;
 	u8 pool_idx;
-	unsigned long handle;
+	struct zs_handle *handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
 };
@@ -889,7 +889,7 @@ static bool zswap_compress(struct folio *folio, long index,
 	struct scatterlist input, output;
 	int comp_ret = 0, alloc_ret = 0;
 	unsigned int dlen = PAGE_SIZE;
-	unsigned long handle;
+	struct zs_handle *handle;
 	gfp_t gfp;
 	u8 *dst;
 	bool mapped = false;
@@ -950,8 +950,8 @@ static bool zswap_compress(struct folio *folio, long index,
 
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
 	handle = zs_malloc(pool->zs_pool, dlen, gfp, folio_nid(folio));
-	if (IS_ERR_VALUE(handle)) {
-		alloc_ret = PTR_ERR((void *)handle);
+	if (IS_ERR(handle)) {
+		alloc_ret = PTR_ERR(handle);
 		goto unlock;
 	}
 
-- 
2.56.0.506.g506a7eabc5-goog

