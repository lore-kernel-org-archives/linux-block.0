Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081D153805
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576136; cv=none; b=W03EAxyrRfDJPrVdN4U52w54N+RetOy8lUUBMcuv04fMyUbC2O8XXXwJHhBTXIU49VZqpvFBKwoQwT2Q7uWYIutjUb9qnYQ/ramSgCdolSDq0YZ9BxwwG1hChM8HkKWi9M5HsPJCHvZ6vWClCV33te3GjUw/4uSaMYoYtR6bkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576136; c=relaxed/simple;
	bh=UlhFDVKkBfA/CTyZXoLNDC49PD9edVGKtirKjlgnarE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIptHOp7sL3FeIqr4QEnzoJiZDlKoh5ZTY7i3OkY2630dD7oAYAmZW72s61/A26QxvW07KpyBHd2rwZh6xxk6Xswf2WdKx+OaAD9xxVonwq84TwjhzpnaKP99uTO9MLlwRoTCK/OryCUlSZsb3m0CcQAbtFyZuDxx6EYj8BnNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMmdbIHw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMmdbIHw"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6b22af648so1070223b3a.0
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711576133; x=1712180933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgw3rnFXz2pEtMLpuLHNqT2fkT/4CPYdnEiOymUIc+Y=;
        b=GMmdbIHwhWXTPxnz+VRV26SgCIwNnX9kQdYq0CVGsNe0/fCu41oWTQ84MWlLIp79Vb
         dwmwCqZS9oTIIzX6w4Hr2IDuAFSfUZFwqgOCD8Z9TX8PWLKtQ76Z6fjRH11MxUqCDOVz
         Z6c0As4FdI1J4IBXmdEvc0L/dSU1qjJbn9CVAGH2ILLSsH3cfpPCse2PS2xbdxlrCTuZ
         mxO7Q4ACgzV3QPDyMR1PXsU7SmWeRUOi8DZk6PkfckJOHtEX/2Ag8AHg1n40rtvCH6uV
         3lLykmRvVTQ+Y1nLzs3RNXBsGJhtdBBECXWKjsMPlYTPgHGLx5vQbw/U8Cmv0CnRji74
         IthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711576133; x=1712180933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgw3rnFXz2pEtMLpuLHNqT2fkT/4CPYdnEiOymUIc+Y=;
        b=Vq7Oe4HSjjTgTrOlqs9ylOesoShG5ACj5JMGITWotwezKFwedBRH3DeKQdRkEfErlR
         aiFM+QIfyCbatnd8xB0+wXBVeU+z/RRqY75cCzS9+70DFmD7mtOVxI8Kq7O1xEeNVEAk
         laoH4bXOF/MF6b7/5jji9pFANC6NiCUcj5jcCTqkbjdmpWWG4W4Ng3Ij4lHzJUIehu0y
         QbnDEQGQ2oKTPEqSQqWZF5UK+76YTb88Hz6coV/8MZLccjjYrvyblltVnzU55a5ZQLBg
         XEmgJppa8dgvXdGRTDQwqBoDPGwafTR+XtvsprQ7EgTEFoPQH0wulcn0BiFWRnogPwYn
         g2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCU+2kv/C7MnkdytPZgtfoRv91to1C/t5CYuIt5UY49dcbc+wMqiNiGhMaVfi4w9Pder4SOSwY3AQ1jGHUMcdCjpAHEz5GxOOznrHV0=
X-Gm-Message-State: AOJu0Yw+IgP1rrtfPC0df0mF2H8tdy0fogmdaoUrDAfFsqkDUpTiXven
	6m/w+x4gvd19aDN3lqAXlcCC3/n9bVdcdVTAAl0n7/AdVxxAqk1D
X-Google-Smtp-Source: AGHT+IEOr/zAjI68FuTawrOVeOW+aGNZ30g2vmWl8UMgPrE4hnep0yigtHauSet2wfHcoFwM8bcYaQ==
X-Received: by 2002:a05:6a20:1a81:b0:1a3:a8ff:473b with SMTP id ci1-20020a056a201a8100b001a3a8ff473bmr498742pzb.29.1711576133126;
        Wed, 27 Mar 2024 14:48:53 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006ea9a54dfabsm18633pfn.52.2024.03.27.14.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 14:48:52 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	linux-mm@kvack.org
Cc: terrelln@fb.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	yuzhao@google.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	willy@infradead.org,
	hannes@cmpxchg.org,
	ying.huang@intel.com,
	surenb@google.com,
	wajdi.k.feghali@intel.com,
	kanchana.p.sridhar@intel.com,
	corbet@lwn.net,
	zhouchengming@bytedance.com,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 1/2] mm: zsmalloc: support objects compressed based on multiple pages
Date: Thu, 28 Mar 2024 10:48:15 +1300
Message-Id: <20240327214816.31191-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327214816.31191-1-21cnbao@gmail.com>
References: <20240327214816.31191-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tangquan Zheng <zhengtangquan@oppo.com>

This patch introduces support for zsmalloc to store compressed objects based
on multi-pages. Previously, a large folio with nr_pages subpages would undergo
compression one by one, each at the granularity of PAGE_SIZE. However, by
compressing them at a larger granularity, we can conserve both memory and
CPU resources.

We define the granularity using a configuration option called
ZSMALLOC_MULTI_PAGES_ORDER, with a default value of 4. Consequently, a
large folio with 32 subpages will now be divided into 2 parts rather
than 32 parts.

The introduction of the multi-pages feature necessitates the creation
of new size classes to accommodate it.

Signed-off-by: Tangquan Zheng <zhengtangquan@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/zsmalloc.h |  10 +-
 mm/Kconfig               |  18 ++++
 mm/zsmalloc.c            | 215 +++++++++++++++++++++++++++++----------
 3 files changed, 187 insertions(+), 56 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index a48cd0ffe57d..9fa3e7669557 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -33,6 +33,14 @@ enum zs_mapmode {
 	 */
 };
 
+enum zsmalloc_type {
+	ZSMALLOC_TYPE_BASEPAGE,
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+	ZSMALLOC_TYPE_MULTI_PAGES,
+#endif
+	ZSMALLOC_TYPE_MAX,
+};
+
 struct zs_pool_stats {
 	/* How many pages were migrated (freed) */
 	atomic_long_t pages_compacted;
@@ -46,7 +54,7 @@ void zs_destroy_pool(struct zs_pool *pool);
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags);
 void zs_free(struct zs_pool *pool, unsigned long obj);
 
-size_t zs_huge_class_size(struct zs_pool *pool);
+size_t zs_huge_class_size(struct zs_pool *pool, enum zsmalloc_type type);
 
 void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 			enum zs_mapmode mm);
diff --git a/mm/Kconfig b/mm/Kconfig
index b1448aa81e15..cedb07094e8e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -224,6 +224,24 @@ config ZSMALLOC_CHAIN_SIZE
 
 	  For more information, see zsmalloc documentation.
 
+config ZSMALLOC_MULTI_PAGES
+	bool "support zsmalloc multiple pages"
+	depends on ZSMALLOC && !CONFIG_HIGHMEM
+	help
+	  This option configures zsmalloc to support allocations larger than
+	  PAGE_SIZE, enabling compression across multiple pages. The size of
+	  these multiple pages is determined by the configured
+	  ZSMALLOC_MULTI_PAGES_ORDER.
+
+config ZSMALLOC_MULTI_PAGES_ORDER
+	int "zsmalloc multiple pages order"
+	default 4
+	range 1 9
+	depends on ZSMALLOC_MULTI_PAGES
+	help
+	  This option is used to configure zsmalloc to support the compression
+	  of multiple pages.
+
 menu "Slab allocator options"
 
 config SLUB
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b42d3545ca85..8658421cee11 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -65,6 +65,12 @@
 
 #define ZSPAGE_MAGIC	0x58
 
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+#define ZSMALLOC_MULTI_PAGES_ORDER	(_AC(CONFIG_ZSMALLOC_MULTI_PAGES_ORDER, UL))
+#define ZSMALLOC_MULTI_PAGES_NR		(1 << ZSMALLOC_MULTI_PAGES_ORDER)
+#define ZSMALLOC_MULTI_PAGES_SIZE	(PAGE_SIZE * ZSMALLOC_MULTI_PAGES_NR)
+#endif
+
 /*
  * This must be power of 2 and greater than or equal to sizeof(link_free).
  * These two conditions ensure that any 'struct link_free' itself doesn't
@@ -115,7 +121,8 @@
 
 #define HUGE_BITS	1
 #define FULLNESS_BITS	4
-#define CLASS_BITS	8
+#define CLASS_BITS	9
+#define ISOLATED_BITS	5
 #define MAGIC_VAL_BITS	8
 
 #define MAX(a, b) ((a) >= (b) ? (a) : (b))
@@ -126,7 +133,11 @@
 #define ZS_MIN_ALLOC_SIZE \
 	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
 /* each chunk includes extra space to keep handle */
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+#define ZS_MAX_ALLOC_SIZE	(ZSMALLOC_MULTI_PAGES_SIZE)
+#else
 #define ZS_MAX_ALLOC_SIZE	PAGE_SIZE
+#endif
 
 /*
  * On systems with 4K page size, this gives 255 size classes! There is a
@@ -141,9 +152,22 @@
  *  ZS_MIN_ALLOC_SIZE and ZS_SIZE_CLASS_DELTA must be multiple of ZS_ALIGN
  *  (reason above)
  */
-#define ZS_SIZE_CLASS_DELTA	(PAGE_SIZE >> CLASS_BITS)
-#define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
-				      ZS_SIZE_CLASS_DELTA) + 1)
+
+#define ZS_PAGE_SIZE_CLASS_DELTA	(PAGE_SIZE >> (CLASS_BITS - 1))
+#define ZS_PAGE_SIZE_CLASSES	(DIV_ROUND_UP(PAGE_SIZE - ZS_MIN_ALLOC_SIZE, \
+				      ZS_PAGE_SIZE_CLASS_DELTA) + 1)
+
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+#define ZS_MULTI_PAGES_SIZE_CLASS_DELTA	(ZSMALLOC_MULTI_PAGES_SIZE >> (CLASS_BITS - 1))
+#define ZS_MULTI_PAGES_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - PAGE_SIZE, \
+				      ZS_MULTI_PAGES_SIZE_CLASS_DELTA) + 1)
+#endif
+
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+#define ZS_SIZE_CLASSES	(ZS_PAGE_SIZE_CLASSES + ZS_MULTI_PAGES_SIZE_CLASS_DELTA)
+#else
+#define ZS_SIZE_CLASSES	(ZS_PAGE_SIZE_CLASSES)
+#endif
 
 /*
  * Pages are distinguished by the ratio of used memory (that is the ratio
@@ -179,7 +203,8 @@ struct zs_size_stat {
 static struct dentry *zs_stat_root;
 #endif
 
-static size_t huge_class_size;
+/* huge_class_size[0] for page, huge_class_size[1] for multiple pages. */
+static size_t huge_class_size[ZSMALLOC_TYPE_MAX];
 
 struct size_class {
 	struct list_head fullness_list[NR_FULLNESS_GROUPS];
@@ -255,6 +280,29 @@ struct zspage {
 	rwlock_t lock;
 };
 
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+static inline unsigned int class_size_to_zs_order(unsigned long size)
+{
+	unsigned int order = 0;
+
+	/* used large order to alloc page for zspage when class_size > PAGE_SIZE */
+	if (size > PAGE_SIZE)
+		return ZSMALLOC_MULTI_PAGES_ORDER;
+
+	return order;
+}
+#else
+static inline unsigned int class_size_to_zs_order(unsigned long size)
+{
+	return 0;
+}
+#endif
+
+static inline unsigned long class_size_to_zs_size(unsigned long size)
+{
+	return PAGE_SIZE * (1 << class_size_to_zs_order(size));
+}
+
 struct mapping_area {
 	local_lock_t lock;
 	char *vm_buf; /* copy buffer for objects that span pages */
@@ -487,11 +535,22 @@ static int get_size_class_index(int size)
 {
 	int idx = 0;
 
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+	if (size > PAGE_SIZE) {
+		idx = ZS_PAGE_SIZE_CLASSES;
+		idx += DIV_ROUND_UP(size - PAGE_SIZE,
+				ZS_MULTI_PAGES_SIZE_CLASS_DELTA);
+
+		return min_t(int, ZS_SIZE_CLASSES - 1, idx);
+	}
+#endif
+
+	idx = 0;
 	if (likely(size > ZS_MIN_ALLOC_SIZE))
-		idx = DIV_ROUND_UP(size - ZS_MIN_ALLOC_SIZE,
-				ZS_SIZE_CLASS_DELTA);
+		idx += DIV_ROUND_UP(size - ZS_MIN_ALLOC_SIZE,
+				ZS_PAGE_SIZE_CLASS_DELTA);
 
-	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
+	return  min_t(int, ZS_PAGE_SIZE_CLASSES - 1, idx);
 }
 
 static inline void class_stat_inc(struct size_class *class,
@@ -541,22 +600,19 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 	unsigned long total_freeable = 0;
 	unsigned long inuse_totals[NR_FULLNESS_GROUPS] = {0, };
 
-	seq_printf(s, " %5s %5s %9s %9s %9s %9s %9s %9s %9s %9s %9s %9s %9s %13s %10s %10s %16s %8s\n",
-			"class", "size", "10%", "20%", "30%", "40%",
+	seq_printf(s, " %5s %5s %5s %9s %9s %9s %9s %9s %9s %9s %9s %9s %9s %9s %13s %10s %10s %16s %16s %8s\n",
+			"class", "size", "order", "10%", "20%", "30%", "40%",
 			"50%", "60%", "70%", "80%", "90%", "99%", "100%",
 			"obj_allocated", "obj_used", "pages_used",
-			"pages_per_zspage", "freeable");
+			"pages_per_zspage", "objs_per_zspage", "freeable");
 
 	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
-
 		class = pool->size_class[i];
-
 		if (class->index != i)
 			continue;
 
 		spin_lock(&pool->lock);
-
-		seq_printf(s, " %5u %5u ", i, class->size);
+		seq_printf(s, " %5u %5u %5u", i, class->size, class_size_to_zs_order(class->size));
 		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
 			inuse_totals[fg] += zs_stat_get(class, fg);
 			seq_printf(s, "%9lu ", zs_stat_get(class, fg));
@@ -571,9 +627,9 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		pages_used = obj_allocated / objs_per_zspage *
 				class->pages_per_zspage;
 
-		seq_printf(s, "%13lu %10lu %10lu %16d %8lu\n",
+		seq_printf(s, "%13lu %10lu %10lu %16d %16d %8lu\n",
 			   obj_allocated, obj_used, pages_used,
-			   class->pages_per_zspage, freeable);
+			   class->pages_per_zspage, objs_per_zspage, freeable);
 
 		total_objs += obj_allocated;
 		total_used_objs += obj_used;
@@ -840,7 +896,8 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	cache_free_zspage(pool, zspage);
 
 	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
-	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
+	atomic_long_sub(class->pages_per_zspage * (1 << class_size_to_zs_order(class->size)),
+			&pool->pages_allocated);
 }
 
 static void free_zspage(struct zs_pool *pool, struct size_class *class,
@@ -869,6 +926,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	unsigned int freeobj = 1;
 	unsigned long off = 0;
 	struct page *page = get_first_page(zspage);
+	unsigned long page_size = class_size_to_zs_size(class->size);
 
 	while (page) {
 		struct page *next_page;
@@ -880,7 +938,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		vaddr = kmap_atomic(page);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
 
-		while ((off += class->size) < PAGE_SIZE) {
+		while ((off += class->size) < page_size) {
 			link->next = freeobj++ << OBJ_TAG_BITS;
 			link += class->size / sizeof(*link);
 		}
@@ -902,7 +960,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		}
 		kunmap_atomic(vaddr);
 		page = next_page;
-		off %= PAGE_SIZE;
+		off %= page_size;
 	}
 
 	set_freeobj(zspage, 0);
@@ -952,6 +1010,8 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
 	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
 
+	unsigned int order = class_size_to_zs_order(class->size);
+
 	if (!zspage)
 		return NULL;
 
@@ -961,11 +1021,11 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct page *page;
 
-		page = alloc_page(gfp);
+		page = alloc_pages(gfp | __GFP_COMP, order);
 		if (!page) {
 			while (--i >= 0) {
 				dec_zone_page_state(pages[i], NR_ZSPAGES);
-				__free_page(pages[i]);
+				__free_pages(pages[i], order);
 			}
 			cache_free_zspage(pool, zspage);
 			return NULL;
@@ -1024,6 +1084,7 @@ static void *__zs_map_object(struct mapping_area *area,
 	int sizes[2];
 	void *addr;
 	char *buf = area->vm_buf;
+	unsigned long page_size = class_size_to_zs_size(size);
 
 	/* disable page faults to match kmap_atomic() return conditions */
 	pagefault_disable();
@@ -1032,7 +1093,7 @@ static void *__zs_map_object(struct mapping_area *area,
 	if (area->vm_mm == ZS_MM_WO)
 		goto out;
 
-	sizes[0] = PAGE_SIZE - off;
+	sizes[0] = page_size - off;
 	sizes[1] = size - sizes[0];
 
 	/* copy object to per-cpu buffer */
@@ -1052,6 +1113,7 @@ static void __zs_unmap_object(struct mapping_area *area,
 	int sizes[2];
 	void *addr;
 	char *buf;
+	unsigned long page_size = class_size_to_zs_size(size);
 
 	/* no write fastpath */
 	if (area->vm_mm == ZS_MM_RO)
@@ -1062,7 +1124,7 @@ static void __zs_unmap_object(struct mapping_area *area,
 	size -= ZS_HANDLE_SIZE;
 	off += ZS_HANDLE_SIZE;
 
-	sizes[0] = PAGE_SIZE - off;
+	sizes[0] = page_size - off;
 	sizes[1] = size - sizes[0];
 
 	/* copy per-cpu buffer to object */
@@ -1169,6 +1231,8 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	struct mapping_area *area;
 	struct page *pages[2];
 	void *ret;
+	unsigned long page_size;
+	unsigned long page_mask;
 
 	/*
 	 * Because we use per-cpu mapping areas shared among the
@@ -1193,12 +1257,14 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	spin_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
-	off = offset_in_page(class->size * obj_idx);
+	page_size = class_size_to_zs_size(class->size);
+	page_mask = ~(page_size - 1);
+	off = (class->size * obj_idx) & ~page_mask;
 
 	local_lock(&zs_map_area.lock);
 	area = this_cpu_ptr(&zs_map_area);
 	area->vm_mm = mm;
-	if (off + class->size <= PAGE_SIZE) {
+	if (off + class->size <= page_size) {
 		/* this object is contained entirely within a page */
 		area->vm_addr = kmap_atomic(page);
 		ret = area->vm_addr + off;
@@ -1228,15 +1294,20 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 	struct size_class *class;
 	struct mapping_area *area;
+	unsigned long page_size;
+	unsigned long page_mask;
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
 	class = zspage_class(pool, zspage);
-	off = offset_in_page(class->size * obj_idx);
+
+	page_size = class_size_to_zs_size(class->size);
+	page_mask = ~(page_size - 1);
+	off = (class->size * obj_idx) & ~page_mask;
 
 	area = this_cpu_ptr(&zs_map_area);
-	if (off + class->size <= PAGE_SIZE)
+	if (off + class->size <= page_size)
 		kunmap_atomic(area->vm_addr);
 	else {
 		struct page *pages[2];
@@ -1266,9 +1337,9 @@ EXPORT_SYMBOL_GPL(zs_unmap_object);
  *
  * Return: the size (in bytes) of the first huge zsmalloc &size_class.
  */
-size_t zs_huge_class_size(struct zs_pool *pool)
+size_t zs_huge_class_size(struct zs_pool *pool, enum zsmalloc_type type)
 {
-	return huge_class_size;
+	return huge_class_size[type];
 }
 EXPORT_SYMBOL_GPL(zs_huge_class_size);
 
@@ -1283,16 +1354,24 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	struct page *m_page;
 	unsigned long m_offset;
 	void *vaddr;
+	unsigned long page_size;
+	unsigned long page_mask;
+	unsigned long page_shift;
 
 	class = pool->size_class[zspage->class];
 	handle |= OBJ_ALLOCATED_TAG;
 	obj = get_freeobj(zspage);
 
 	offset = obj * class->size;
-	nr_page = offset >> PAGE_SHIFT;
-	m_offset = offset_in_page(offset);
-	m_page = get_first_page(zspage);
 
+	page_size = class_size_to_zs_size(class->size);
+	page_shift = PAGE_SHIFT + class_size_to_zs_order(class->size);
+	page_mask = ~(page_size - 1);
+
+	nr_page = offset >> page_shift;
+	m_offset = offset & ~page_mask;
+
+	m_page = get_first_page(zspage);
 	for (i = 0; i < nr_page; i++)
 		m_page = get_next_page(m_page);
 
@@ -1360,7 +1439,6 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	}
 
 	spin_unlock(&pool->lock);
-
 	zspage = alloc_zspage(pool, class, gfp);
 	if (!zspage) {
 		cache_free_handle(pool, handle);
@@ -1372,7 +1450,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	record_obj(handle, obj);
-	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
+	atomic_long_add(class->pages_per_zspage * (1 << class_size_to_zs_order(class->size)),
+			&pool->pages_allocated);
 	class_stat_inc(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	class_stat_inc(class, ZS_OBJS_INUSE, 1);
 
@@ -1393,9 +1472,14 @@ static void obj_free(int class_size, unsigned long obj)
 	unsigned long f_offset;
 	unsigned int f_objidx;
 	void *vaddr;
+	unsigned long page_size;
+	unsigned long page_mask;
 
 	obj_to_location(obj, &f_page, &f_objidx);
-	f_offset = offset_in_page(class_size * f_objidx);
+	page_size = class_size_to_zs_size(class_size);
+	page_mask = ~(page_size - 1);
+
+	f_offset = (class_size * f_objidx) & ~page_mask;
 	zspage = get_zspage(f_page);
 
 	vaddr = kmap_atomic(f_page);
@@ -1454,20 +1538,22 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	void *s_addr, *d_addr;
 	int s_size, d_size, size;
 	int written = 0;
+	unsigned long page_size = class_size_to_zs_size(class->size);
+	unsigned long page_mask =  ~(page_size - 1);
 
 	s_size = d_size = class->size;
 
 	obj_to_location(src, &s_page, &s_objidx);
 	obj_to_location(dst, &d_page, &d_objidx);
 
-	s_off = offset_in_page(class->size * s_objidx);
-	d_off = offset_in_page(class->size * d_objidx);
+	s_off = (class->size * s_objidx) & ~page_mask;
+	d_off = (class->size * d_objidx) & ~page_mask;
 
-	if (s_off + class->size > PAGE_SIZE)
-		s_size = PAGE_SIZE - s_off;
+	if (s_off + class->size > page_size)
+		s_size = page_size - s_off;
 
-	if (d_off + class->size > PAGE_SIZE)
-		d_size = PAGE_SIZE - d_off;
+	if (d_off + class->size > page_size)
+		d_size = page_size - d_off;
 
 	s_addr = kmap_atomic(s_page);
 	d_addr = kmap_atomic(d_page);
@@ -1492,7 +1578,7 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		 * kunmap_atomic(d_addr). For more details see
 		 * Documentation/mm/highmem.rst.
 		 */
-		if (s_off >= PAGE_SIZE) {
+		if (s_off >= page_size) {
 			kunmap_atomic(d_addr);
 			kunmap_atomic(s_addr);
 			s_page = get_next_page(s_page);
@@ -1502,7 +1588,7 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 			s_off = 0;
 		}
 
-		if (d_off >= PAGE_SIZE) {
+		if (d_off >= page_size) {
 			kunmap_atomic(d_addr);
 			d_page = get_next_page(d_page);
 			d_addr = kmap_atomic(d_page);
@@ -1526,11 +1612,12 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	int index = *obj_idx;
 	unsigned long handle = 0;
 	void *addr = kmap_atomic(page);
+	unsigned long page_size = class_size_to_zs_size(class->size);
 
 	offset = get_first_obj_offset(page);
 	offset += class->size * index;
 
-	while (offset < PAGE_SIZE) {
+	while (offset < page_size) {
 		if (obj_allocated(page, addr + offset, &handle))
 			break;
 
@@ -1751,6 +1838,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
+	unsigned int page_size = PAGE_SIZE;
 
 	/*
 	 * We cannot support the _NO_COPY case here, because copy needs to
@@ -1772,6 +1860,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	spin_lock(&pool->lock);
 	class = zspage_class(pool, zspage);
+	page_size = class_size_to_zs_size(class->size);
 
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
@@ -1783,10 +1872,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * Here, any user cannot access all objects in the zspage so let's move.
 	 */
 	d_addr = kmap_atomic(newpage);
-	copy_page(d_addr, s_addr);
+	memcpy(d_addr, s_addr, page_size);
 	kunmap_atomic(d_addr);
 
-	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
+	for (addr = s_addr + offset; addr < s_addr + page_size;
 					addr += class->size) {
 		if (obj_allocated(page, addr, &handle)) {
 
@@ -2066,6 +2155,7 @@ static int calculate_zspage_chain_size(int class_size)
 {
 	int i, min_waste = INT_MAX;
 	int chain_size = 1;
+	unsigned long page_size = class_size_to_zs_size(class_size);
 
 	if (is_power_of_2(class_size))
 		return chain_size;
@@ -2073,7 +2163,7 @@ static int calculate_zspage_chain_size(int class_size)
 	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
 		int waste;
 
-		waste = (i * PAGE_SIZE) % class_size;
+		waste = (i * page_size) % class_size;
 		if (waste < min_waste) {
 			min_waste = waste;
 			chain_size = i;
@@ -2098,6 +2188,8 @@ struct zs_pool *zs_create_pool(const char *name)
 	int i;
 	struct zs_pool *pool;
 	struct size_class *prev_class = NULL;
+	int idx = ZSMALLOC_TYPE_BASEPAGE;
+	int order = 0;
 
 	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 	if (!pool)
@@ -2119,18 +2211,31 @@ struct zs_pool *zs_create_pool(const char *name)
 	 * for merging should be larger or equal to current size.
 	 */
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
-		int size;
+		unsigned int size = 0;
 		int pages_per_zspage;
 		int objs_per_zspage;
 		struct size_class *class;
 		int fullness;
 
-		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
+		if (i < ZS_PAGE_SIZE_CLASSES)
+			size = ZS_MIN_ALLOC_SIZE + i * ZS_PAGE_SIZE_CLASS_DELTA;
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+		if (i >= ZS_PAGE_SIZE_CLASSES)
+			size = PAGE_SIZE + (i - ZS_PAGE_SIZE_CLASSES) *
+					   ZS_MULTI_PAGES_SIZE_CLASS_DELTA;
+#endif
+
 		if (size > ZS_MAX_ALLOC_SIZE)
 			size = ZS_MAX_ALLOC_SIZE;
-		pages_per_zspage = calculate_zspage_chain_size(size);
-		objs_per_zspage = pages_per_zspage * PAGE_SIZE / size;
 
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+		order = class_size_to_zs_order(size);
+		if (order == ZSMALLOC_MULTI_PAGES_ORDER)
+			idx = ZSMALLOC_TYPE_MULTI_PAGES;
+#endif
+
+		pages_per_zspage = calculate_zspage_chain_size(size);
+		objs_per_zspage = pages_per_zspage * PAGE_SIZE * (1 << order) / size;
 		/*
 		 * We iterate from biggest down to smallest classes,
 		 * so huge_class_size holds the size of the first huge
@@ -2138,8 +2243,8 @@ struct zs_pool *zs_create_pool(const char *name)
 		 * endup in the huge class.
 		 */
 		if (pages_per_zspage != 1 && objs_per_zspage != 1 &&
-				!huge_class_size) {
-			huge_class_size = size;
+				!huge_class_size[idx]) {
+			huge_class_size[idx] = size;
 			/*
 			 * The object uses ZS_HANDLE_SIZE bytes to store the
 			 * handle. We need to subtract it, because zs_malloc()
@@ -2149,7 +2254,7 @@ struct zs_pool *zs_create_pool(const char *name)
 			 * class because it grows by ZS_HANDLE_SIZE extra bytes
 			 * right before class lookup.
 			 */
-			huge_class_size -= (ZS_HANDLE_SIZE - 1);
+			huge_class_size[idx] -= (ZS_HANDLE_SIZE - 1);
 		}
 
 		/*
-- 
2.34.1

