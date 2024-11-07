Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B8B1E8856
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974239; cv=none; b=JQMDg/Vx8EGL8rD0ohJ4SSj7uDVocNA1vb0tk7/zEi73NdqnFA8wRyI2Gu+WIPwViuxg9ZosctkxT9i6j/CTx7jOEp5jnqeo9OnTzgEzh3Z2uU6njFlsEDdswzjK+pecB47tcaL1Rwh8fujBc61VhfLBGimzUbuVWbgpNUOlPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974239; c=relaxed/simple;
	bh=Hf4u1UYtJknU/bcSNYfKZHRSGZc7GJpBXMSlAjcp0f4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEV1RhDlWkS48SDAdfKY8HmWqv5zNtMCqJbdx4jT4CONND+PuexTDk9sg9Y4cl0dBeRJM1OPTLTg95K3eTiceGGTDoH93YCxn0+vqW49eM7xSmHuorcpggq6hO57kMcj1UM+pcU0LdU1MSmligAI1eHEiYsmdCUFllq4JYPQ5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBAhZkxY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBAhZkxY"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso615794a91.3
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 02:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730974236; x=1731579036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxt8RT8Bygj0k5mYA26DJr1opTR3RFz4U7zBrOCycHM=;
        b=KBAhZkxYpQrKCwL8akDnS5p+TaiAzq1tWQPL8nr2y1y1+Oku80mZd7ByM9XeUj6+uQ
         BB1tbZnXh8mm/uBlwNudsqgRDOWpWVrtrBVcJZrldSMv6yKOoiDfi2sWtsHaF4iy5k5/
         FlNriEibCrRjixax+NM+71tzCX+0j+jWJLX3ttQTizveC32Qd3Lr7k4ac9bbN5AKqXRu
         G7G5yb6ZscuMUzpgjzGC1zKdfmPVzQrPMTVdFc9UNyek+jHQ7fs9j3k1ot/Ovd50dgq8
         QSCBIpF9uvvGyLEGSHXUZQErpQdrFWlY3v/5+G16Z4BxtB4yuqYVUkAc12S+M89aqfZU
         4M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974236; x=1731579036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxt8RT8Bygj0k5mYA26DJr1opTR3RFz4U7zBrOCycHM=;
        b=JJevX1SiPw3dGJMT9n+7tt4z8+gG/biE53nCYIYnKVIw0lRTfgXfY25CLBUMJ4UM8d
         i7FU9xgXsYgVfAd2qmSuzoRWR+h/F5igXlhZ+LTA2mjTvL6bnnjkJlKmG0xKl+anMRrN
         jyOoUFY54gLIpv1/xPhbsV6fGxmexrjYTGG2BPao7EFfxUxa6Fs6ft94qM1ulPnV3W5c
         KKsKiL9ejN2ZtFlsL1kDHcYte6sLghLYCbfD4mnih6ukZ6qWlvAnvVsXaXR1RtG9Vr65
         KzZOW0uDaCYdyrNJ7D/7XUtdQFaELVyrfcm42zqxEk8anThg7uO92ZrQPGIr2VnaH1dg
         4dsg==
X-Forwarded-Encrypted: i=1; AJvYcCUsEm6se3/gF2n3EQ8eRfoaS2BJTxzzccAVvvR3XHhIHScuf/W9fo6TOsF1eV3K867vWahBTjoj2gin0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9JzCh1RjhanVwcGtE+/keN0WhMHG2FQAOOxOD0y2mpN3OTs7
	/HgH6O6/22AStjaF1tDJS+gzJ/8Wmn1KyiQXx24bQpbqtIyPydLZ
X-Google-Smtp-Source: AGHT+IGkobDPHX5sAaCxvHkebL5hALrpV2Dg8LC3c+W0XbEg1N8DE06RTp/5mtnWP2SaL4Ngh8681A==
X-Received: by 2002:a17:90b:4c05:b0:2e2:ddfa:24d5 with SMTP id 98e67ed59e1d1-2e9ab01695amr547816a91.15.1730974236057;
        Thu, 07 Nov 2024 02:10:36 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:507e:2219:6f85:3a5f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5fd6b0sm3076415a91.34.2024.11.07.02.10.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Nov 2024 02:10:35 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bala.seshasayee@linux.intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kanchana.p.sridhar@intel.com,
	kasong@tencent.com,
	linux-block@vger.kernel.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	senozhatsky@chromium.org,
	surenb@google.com,
	terrelln@fb.com,
	v-songbaohua@oppo.com,
	wajdi.k.feghali@intel.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	zhengtangquan@oppo.com,
	zhouchengming@bytedance.com,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com
Subject: [PATCH RFC v2 1/2] mm: zsmalloc: support objects compressed based on multiple pages
Date: Thu,  7 Nov 2024 23:10:03 +1300
Message-Id: <20241107101005.69121-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241107101005.69121-1-21cnbao@gmail.com>
References: <20241107101005.69121-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tangquan Zheng <zhengtangquan@oppo.com>

This patch introduces support for zsmalloc to store compressed objects
based on multi-pages. Previously, a large folio with nr_pages subpages
would undergo compression one by one, each at the granularity of
PAGE_SIZE. However, by compressing them at a larger granularity, we
can conserve both memory and CPU resources.

We define the granularity with a configuration option called
ZSMALLOC_MULTI_PAGES_ORDER, set to a default value of 2, which matches
the minimum order of anonymous mTHP. As a result, a large folio with
8 subpages will now be split into 2 parts instead of 8.

The introduction of the multi-pages feature necessitates the creation
of new size classes to accommodate it.

Signed-off-by: Tangquan Zheng <zhengtangquan@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/block/zram/zram_drv.c |   3 +-
 include/linux/zsmalloc.h      |  10 +-
 mm/Kconfig                    |  18 +++
 mm/zsmalloc.c                 | 232 ++++++++++++++++++++++++++--------
 4 files changed, 205 insertions(+), 58 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cee49bb0126d..051e6efe1c3d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1461,8 +1461,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		return false;
 	}
 
-	if (!huge_class_size)
-		huge_class_size = zs_huge_class_size(zram->mem_pool);
+	huge_class_size = zs_huge_class_size(zram->mem_pool, 0);
 
 	for (index = 0; index < num_pages; index++)
 		spin_lock_init(&zram->table[index].lock);
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
index 33fa51d608dc..6b302b66fc0a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -237,6 +237,24 @@ config ZSMALLOC_CHAIN_SIZE
 
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
+	default 2
+	range 1 9
+	depends on ZSMALLOC_MULTI_PAGES
+	help
+	  This option is used to configure zsmalloc to support the compression
+	  of multiple pages.
+
 menu "Slab allocator options"
 
 config SLUB
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 64b66a4d3e6e..20b99d12fd5a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -70,6 +70,12 @@
 
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
@@ -120,7 +126,8 @@
 
 #define HUGE_BITS	1
 #define FULLNESS_BITS	4
-#define CLASS_BITS	8
+#define CLASS_BITS	9
+#define ISOLATED_BITS	5
 #define MAGIC_VAL_BITS	8
 
 #define ZS_MAX_PAGES_PER_ZSPAGE	(_AC(CONFIG_ZSMALLOC_CHAIN_SIZE, UL))
@@ -129,7 +136,11 @@
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
@@ -144,9 +155,22 @@
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
+#define ZS_SIZE_CLASSES	(ZS_PAGE_SIZE_CLASSES + ZS_MULTI_PAGES_SIZE_CLASSES)
+#else
+#define ZS_SIZE_CLASSES	(ZS_PAGE_SIZE_CLASSES)
+#endif
 
 /*
  * Pages are distinguished by the ratio of used memory (that is the ratio
@@ -182,7 +206,8 @@ struct zs_size_stat {
 static struct dentry *zs_stat_root;
 #endif
 
-static size_t huge_class_size;
+/* huge_class_size[0] for page, huge_class_size[1] for multiple pages. */
+static size_t huge_class_size[ZSMALLOC_TYPE_MAX];
 
 struct size_class {
 	spinlock_t lock;
@@ -260,6 +285,29 @@ struct zspage {
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
@@ -510,11 +558,22 @@ static int get_size_class_index(int size)
 {
 	int idx = 0;
 
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+	if (size > PAGE_SIZE + ZS_HANDLE_SIZE) {
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
 
 static inline void class_stat_add(struct size_class *class, int type,
@@ -564,11 +623,11 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
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
 
@@ -579,7 +638,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 
 		spin_lock(&class->lock);
 
-		seq_printf(s, " %5u %5u ", i, class->size);
+		seq_printf(s, " %5u %5u %5u", i, class->size, class_size_to_zs_order(class->size));
 		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
 			inuse_totals[fg] += class_stat_read(class, fg);
 			seq_printf(s, "%9lu ", class_stat_read(class, fg));
@@ -594,9 +653,9 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		pages_used = obj_allocated / objs_per_zspage *
 				class->pages_per_zspage;
 
-		seq_printf(s, "%13lu %10lu %10lu %16d %8lu\n",
+		seq_printf(s, "%13lu %10lu %10lu %16d %16d %8lu\n",
 			   obj_allocated, obj_used, pages_used,
-			   class->pages_per_zspage, freeable);
+			   class->pages_per_zspage, objs_per_zspage, freeable);
 
 		total_objs += obj_allocated;
 		total_used_objs += obj_used;
@@ -863,7 +922,8 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	cache_free_zspage(pool, zspage);
 
 	class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
-	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
+	atomic_long_sub(class->pages_per_zspage * (1 << class_size_to_zs_order(class->size)),
+			&pool->pages_allocated);
 }
 
 static void free_zspage(struct zs_pool *pool, struct size_class *class,
@@ -892,6 +952,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	unsigned int freeobj = 1;
 	unsigned long off = 0;
 	struct page *page = get_first_page(zspage);
+	unsigned long page_size = class_size_to_zs_size(class->size);
 
 	while (page) {
 		struct page *next_page;
@@ -903,7 +964,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		vaddr = kmap_local_page(page);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
 
-		while ((off += class->size) < PAGE_SIZE) {
+		while ((off += class->size) < page_size) {
 			link->next = freeobj++ << OBJ_TAG_BITS;
 			link += class->size / sizeof(*link);
 		}
@@ -925,7 +986,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		}
 		kunmap_local(vaddr);
 		page = next_page;
-		off %= PAGE_SIZE;
+		off %= page_size;
 	}
 
 	set_freeobj(zspage, 0);
@@ -975,6 +1036,8 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
 	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
 
+	unsigned int order = class_size_to_zs_order(class->size);
+
 	if (!zspage)
 		return NULL;
 
@@ -984,12 +1047,14 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct page *page;
 
-		page = alloc_page(gfp);
+		if (order > 0)
+			gfp &= ~__GFP_MOVABLE;
+		page = alloc_pages(gfp | __GFP_COMP, order);
 		if (!page) {
 			while (--i >= 0) {
 				dec_zone_page_state(pages[i], NR_ZSPAGES);
 				__ClearPageZsmalloc(pages[i]);
-				__free_page(pages[i]);
+				__free_pages(pages[i], order);
 			}
 			cache_free_zspage(pool, zspage);
 			return NULL;
@@ -1047,7 +1112,9 @@ static void *__zs_map_object(struct mapping_area *area,
 			struct page *pages[2], int off, int size)
 {
 	size_t sizes[2];
+	void *addr;
 	char *buf = area->vm_buf;
+	unsigned long page_size = class_size_to_zs_size(size);
 
 	/* disable page faults to match kmap_local_page() return conditions */
 	pagefault_disable();
@@ -1056,12 +1123,16 @@ static void *__zs_map_object(struct mapping_area *area,
 	if (area->vm_mm == ZS_MM_WO)
 		goto out;
 
-	sizes[0] = PAGE_SIZE - off;
+	sizes[0] = page_size - off;
 	sizes[1] = size - sizes[0];
 
 	/* copy object to per-cpu buffer */
-	memcpy_from_page(buf, pages[0], off, sizes[0]);
-	memcpy_from_page(buf + sizes[0], pages[1], 0, sizes[1]);
+	addr = kmap_local_page(pages[0]);
+	memcpy(buf, addr + off, sizes[0]);
+	kunmap_local(addr);
+	addr = kmap_local_page(pages[1]);
+	memcpy(buf + sizes[0], addr, sizes[1]);
+	kunmap_local(addr);
 out:
 	return area->vm_buf;
 }
@@ -1070,7 +1141,9 @@ static void __zs_unmap_object(struct mapping_area *area,
 			struct page *pages[2], int off, int size)
 {
 	size_t sizes[2];
+	void *addr;
 	char *buf;
+	unsigned long page_size = class_size_to_zs_size(size);
 
 	/* no write fastpath */
 	if (area->vm_mm == ZS_MM_RO)
@@ -1081,12 +1154,16 @@ static void __zs_unmap_object(struct mapping_area *area,
 	size -= ZS_HANDLE_SIZE;
 	off += ZS_HANDLE_SIZE;
 
-	sizes[0] = PAGE_SIZE - off;
+	sizes[0] = page_size - off;
 	sizes[1] = size - sizes[0];
 
 	/* copy per-cpu buffer to object */
-	memcpy_to_page(pages[0], off, buf, sizes[0]);
-	memcpy_to_page(pages[1], 0, buf + sizes[0], sizes[1]);
+	addr = kmap_local_page(pages[0]);
+	memcpy(addr + off, buf, sizes[0]);
+	kunmap_local(addr);
+	addr = kmap_local_page(pages[1]);
+	memcpy(addr, buf + sizes[0], sizes[1]);
+	kunmap_local(addr);
 
 out:
 	/* enable page faults to match kunmap_local() return conditions */
@@ -1184,6 +1261,8 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	struct mapping_area *area;
 	struct page *pages[2];
 	void *ret;
+	unsigned long page_size;
+	unsigned long page_mask;
 
 	/*
 	 * Because we use per-cpu mapping areas shared among the
@@ -1208,12 +1287,14 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	read_unlock(&pool->migrate_lock);
 
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
 		area->vm_addr = kmap_local_page(page);
 		ret = area->vm_addr + off;
@@ -1243,15 +1324,20 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
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
 		kunmap_local(area->vm_addr);
 	else {
 		struct page *pages[2];
@@ -1281,9 +1367,9 @@ EXPORT_SYMBOL_GPL(zs_unmap_object);
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
 
@@ -1298,13 +1384,21 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	struct page *m_page;
 	unsigned long m_offset;
 	void *vaddr;
+	unsigned long page_size;
+	unsigned long page_mask;
+	unsigned long page_shift;
 
 	class = pool->size_class[zspage->class];
 	obj = get_freeobj(zspage);
 
 	offset = obj * class->size;
-	nr_page = offset >> PAGE_SHIFT;
-	m_offset = offset_in_page(offset);
+	page_size = class_size_to_zs_size(class->size);
+	page_shift = PAGE_SHIFT + class_size_to_zs_order(class->size);
+	page_mask = ~(page_size - 1);
+
+	nr_page = offset >> page_shift;
+	m_offset = offset & ~page_mask;
+
 	m_page = get_first_page(zspage);
 
 	for (i = 0; i < nr_page; i++)
@@ -1385,12 +1479,14 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
-	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
+	atomic_long_add(class->pages_per_zspage * (1 << class_size_to_zs_order(class->size)),
+			&pool->pages_allocated);
 	class_stat_add(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	class_stat_add(class, ZS_OBJS_INUSE, 1);
 
 	/* We completely set up zspage so mark them as movable */
-	SetZsPageMovable(pool, zspage);
+	if (class_size_to_zs_order(class->size) == 0)
+		SetZsPageMovable(pool, zspage);
 out:
 	spin_unlock(&class->lock);
 
@@ -1406,9 +1502,14 @@ static void obj_free(int class_size, unsigned long obj)
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
 
 	vaddr = kmap_local_page(f_page);
@@ -1469,20 +1570,22 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
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
 
 	s_addr = kmap_local_page(s_page);
 	d_addr = kmap_local_page(d_page);
@@ -1507,7 +1610,7 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		 * kunmap_local(d_addr). For more details see
 		 * Documentation/mm/highmem.rst.
 		 */
-		if (s_off >= PAGE_SIZE) {
+		if (s_off >= page_size) {
 			kunmap_local(d_addr);
 			kunmap_local(s_addr);
 			s_page = get_next_page(s_page);
@@ -1517,7 +1620,7 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 			s_off = 0;
 		}
 
-		if (d_off >= PAGE_SIZE) {
+		if (d_off >= page_size) {
 			kunmap_local(d_addr);
 			d_page = get_next_page(d_page);
 			d_addr = kmap_local_page(d_page);
@@ -1541,11 +1644,12 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	int index = *obj_idx;
 	unsigned long handle = 0;
 	void *addr = kmap_local_page(page);
+	unsigned long page_size = class_size_to_zs_size(class->size);
 
 	offset = get_first_obj_offset(page);
 	offset += class->size * index;
 
-	while (offset < PAGE_SIZE) {
+	while (offset < page_size) {
 		if (obj_allocated(page, addr + offset, &handle))
 			break;
 
@@ -1765,6 +1869,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
+	unsigned int page_size = PAGE_SIZE;
 
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
@@ -1781,6 +1886,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	write_lock(&pool->migrate_lock);
 	class = zspage_class(pool, zspage);
+	page_size = class_size_to_zs_size(class->size);
 
 	/*
 	 * the class lock protects zpage alloc/free in the zspage.
@@ -1796,10 +1902,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * Here, any user cannot access all objects in the zspage so let's move.
 	 */
 	d_addr = kmap_local_page(newpage);
-	copy_page(d_addr, s_addr);
+	memcpy(d_addr, s_addr, page_size);
 	kunmap_local(d_addr);
 
-	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
+	for (addr = s_addr + offset; addr < s_addr + page_size;
 					addr += class->size) {
 		if (obj_allocated(page, addr, &handle)) {
 
@@ -2085,6 +2191,7 @@ static int calculate_zspage_chain_size(int class_size)
 {
 	int i, min_waste = INT_MAX;
 	int chain_size = 1;
+	unsigned long page_size = class_size_to_zs_size(class_size);
 
 	if (is_power_of_2(class_size))
 		return chain_size;
@@ -2092,7 +2199,7 @@ static int calculate_zspage_chain_size(int class_size)
 	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
 		int waste;
 
-		waste = (i * PAGE_SIZE) % class_size;
+		waste = (i * page_size) % class_size;
 		if (waste < min_waste) {
 			min_waste = waste;
 			chain_size = i;
@@ -2138,18 +2245,33 @@ struct zs_pool *zs_create_pool(const char *name)
 	 * for merging should be larger or equal to current size.
 	 */
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
-		int size;
+		unsigned int size = 0;
 		int pages_per_zspage;
 		int objs_per_zspage;
 		struct size_class *class;
 		int fullness;
+		int order = 0;
+		int idx = ZSMALLOC_TYPE_BASEPAGE;
+
+		if (i < ZS_PAGE_SIZE_CLASSES)
+			size = ZS_MIN_ALLOC_SIZE + i * ZS_PAGE_SIZE_CLASS_DELTA;
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+		if (i >= ZS_PAGE_SIZE_CLASSES)
+			size = PAGE_SIZE + (i - ZS_PAGE_SIZE_CLASSES) *
+					   ZS_MULTI_PAGES_SIZE_CLASS_DELTA;
+#endif
 
-		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
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
@@ -2157,8 +2279,8 @@ struct zs_pool *zs_create_pool(const char *name)
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
@@ -2168,7 +2290,7 @@ struct zs_pool *zs_create_pool(const char *name)
 			 * class because it grows by ZS_HANDLE_SIZE extra bytes
 			 * right before class lookup.
 			 */
-			huge_class_size -= (ZS_HANDLE_SIZE - 1);
+			huge_class_size[idx] -= (ZS_HANDLE_SIZE - 1);
 		}
 
 		/*
-- 
2.39.3 (Apple Git-146)

