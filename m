Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794710818;
	b=uaVoupybA/UXshh63y/DZhtoBxyJWL7Bkx3ao9eAsFYDnKmlagTrna2gUd3vvxNrmDgW
	 iQKJpAKirb82gMo7Ir//9a5PRDKelus4KnPUEp6WwANIy5HyrJ4ehKFeZpFhXD2yDDUYX
	 bc6tY17MFMwqUWs1vEImV2NDW1o2cZ7XCvocvHXSP8D1VprRzpBK6FQevT7saJWARlrVd
	 UOmZiwt8T6/XgGludlNYCV1Rnt4Bc0C400XE7uIbkvZuanXEdGr6e1rKbyIXt55UGKpyG
	 giV0U7Apam0QrfCou2iotr65P+b8a1FEkpkCN1EmUdyFVk1bBGuTw8vOlFVBqyyiYww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794710818;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=p+mtGTN23RcZbgFnjq65NAFEiOonjS3vFwdm7GrwEFo=;
	b=JlEGyNqcnwt4w1A1KCPY9lqiYrMYAfpHdk3PkEuDC2PgO09z1b6sHgYF4d37N6BJkhSa
	 4wl6PeH0d5NxsJWwQyQJk3eQDoakFJxZZIqxpkGD2tBiAs6wVOEnCmTUKzDFy7TPi3zsa
	 E0wsteaa1KXtfbh0jVeRUd95owYYC9I+J9ZZAix5uCUqoZ+Zw73UF8WygzcWmfnoE6Sbs
	 oX+zbs5T6jUTf94Otnygtet3xXx9R5YYXiiYkoVG3tHiDCnpepOgAjhM8liUiVI85wuo/
	 BDNcet7YYGsF1XY9dMMUR1MYRKGfDxZyzmKPipeuOsZdskkSJxJg+jR3ZIJjQZU0p1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=qDhr0ppZ;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E090606A880;
	Sun, 15 Nov 2026 02:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E090606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=qDhr0ppZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=p+
	mtGTN23RcZbgFnjq65NAFEiOonjS3vFwdm7GrwEFo=; b=qDhr0ppZKtKjnEEYYn
	AqOBgpYLAPyb4uERZXWkzbPYm0yTM3Ows7+eo4N59oJMomixIw6v+32hD/HQakNj
	00QYA9xIuA4wp4NRufR6UF/MzL3RrCZdCmvzeVnbVRbZJpxEguIj4jhkniTBYU2d
	oCTBATIxDdlsI3ZmZJ/Llmh+w=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3H_OtHPlq+ob+DQ--.31738S3;
	Sun, 15 Nov 2026 10:45:15 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	Yosry Ahmed <yosry@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Ying Huang <ying.huang@intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Wajdi K Feghali <wajdi.k.feghali@intel.com>,
	Bala Seshasayee <bala.seshasayee@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Subject: [RFC PATCH v4 1/4] mm: zsmalloc: support objects compressed based on multiple pages
Date: Sun, 15 Nov 2026 10:44:48 +0800
Message-ID: <20261115024455.1465726-2-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com>
References: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com>
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
X-CM-TRANSID:PikvCgD3H_OtHPlq+ob+DQ--.31738S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfCrW3Cw1xWr13WFy8Wr4rXwb_yoW5XFyUGo
	Z2yFsrJF48Wry7Gr4UCr17KFnxZa1qkr97Jws3Grs8uF9xu398K3y2yw45XFWfGr48KFnx
	Zr10q34093Z7Jw1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxnYFDUUUU
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohtOHmr5HLsi6wAA3U

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
Co-developed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Barry Song <baohua@kernel.org>
Co-developed-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 drivers/block/zram/zram_drv.c |   3 +-
 include/linux/zsmalloc.h      |  10 +-
 mm/Kconfig                    |  29 +++-
 mm/zsmalloc.c                 | 245 +++++++++++++++++++++++-----------
 4 files changed, 204 insertions(+), 83 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4f479d905142..24eefcf143de 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2024,7 +2024,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	}
 
 	if (!huge_class_size)
-		huge_class_size = zs_huge_class_size(zram->mem_pool);
+		huge_class_size = zs_huge_class_size(zram->mem_pool,
+						ZSMALLOC_TYPE_BASEPAGE);
 
 	lockdep_register_key(&zram->table_lock_key);
 	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &zram->table_lock_key, 0);
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 8971eef333ba..738260358a9a 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -17,6 +17,14 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
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
@@ -55,7 +63,7 @@ void zs_free(struct zs_pool *pool, struct zs_handle *handle);
 void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
 		      struct zs_handle *src);
 
-size_t zs_huge_class_size(struct zs_pool *pool);
+size_t zs_huge_class_size(struct zs_pool *pool, enum zsmalloc_type type);
 
 unsigned long zs_get_total_pages(struct zs_pool *pool);
 unsigned long zs_compact(struct zs_pool *pool);
diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..b68720f6fb6b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -140,14 +140,15 @@ config ZSMALLOC_STAT
 	  If unsure, say N.
 
 config ZSMALLOC_CHAIN_SIZE
-	int "Maximum number of physical pages per-zspage"
+	int "Maximum number of chain elements per-zspage"
 	default 8
 	range 4 16
 	help
-	  This option sets the upper limit on the number of physical pages
-	  that a zmalloc page (zspage) can consist of. The optimal zspage
-	  chain size is calculated for each size class during the
-	  initialization of the pool.
+	  This option sets the upper limit on the number of chain elements
+	  that a zsmalloc page (zspage) can consist of. Each element is a
+	  single page, or a multi-page allocation when ZSMALLOC_MULTI_PAGES
+	  is enabled. The optimal zspage chain size is calculated for each
+	  size class during the initialization of the pool.
 
 	  Changing this option can alter the characteristics of size classes,
 	  such as the number of pages per zspage and the number of objects
@@ -157,6 +158,24 @@ config ZSMALLOC_CHAIN_SIZE
 
 	  For more information, see zsmalloc documentation.
 
+config ZSMALLOC_MULTI_PAGES
+	bool "support zsmalloc multiple pages"
+	depends on ZSMALLOC && !HIGHMEM
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
 endmenu
 
 menu "Slab allocator options"
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 4a6ec43f418b..2d83fcc8610d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -48,6 +48,12 @@
 
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
@@ -114,7 +120,7 @@
 
 #define HUGE_BITS	1
 #define FULLNESS_BITS	4
-#define CLASS_BITS	8
+#define CLASS_BITS	9
 #define MAGIC_VAL_BITS	8
 
 #define ZS_MAX_PAGES_PER_ZSPAGE	(_AC(CONFIG_ZSMALLOC_CHAIN_SIZE, UL))
@@ -172,7 +178,11 @@ static_assert(ZS_OBJ_IDX_BITS >= ZS_PAGES_PER_ZSPAGE_BITS,
 	      "zsmalloc: ZS_MIN_ALLOC_SIZE would exceed ZS_MAX_ALLOC_SIZE");
 
 /* each chunk includes extra space to keep handle */
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+#define ZS_MAX_ALLOC_SIZE	ZSMALLOC_MULTI_PAGES_SIZE
+#else
 #define ZS_MAX_ALLOC_SIZE	PAGE_SIZE
+#endif
 
 /*
  * On systems with 4K page size, this gives 255 size classes! There is a
@@ -187,14 +197,45 @@ static_assert(ZS_OBJ_IDX_BITS >= ZS_PAGES_PER_ZSPAGE_BITS,
  *  ZS_MIN_ALLOC_SIZE and ZS_SIZE_CLASS_DELTA must be multiple of ZS_ALIGN
  *  (reason above)
  */
-#define ZS_SIZE_CLASS_DELTA	(PAGE_SIZE >> CLASS_BITS)
+#define ZS_SIZE_CLASS_DELTA	(PAGE_SIZE >> (CLASS_BITS - 1))
 #define _ZS_MIN_ALLOC_RAW \
 	DIV_ROUND_UP(ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT, ZS_OBJ_IDX_MASK)
 #define ZS_MIN_ALLOC_SIZE \
 	MIN(ZS_MAX_ALLOC_SIZE, \
 	    MAX(32UL, ALIGN(_ZS_MIN_ALLOC_RAW, ZS_ALIGN)))
-#define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
-				      ZS_SIZE_CLASS_DELTA) + 1)
+
+#define ZS_PAGE_SIZE_CLASSES	(DIV_ROUND_UP(PAGE_SIZE - ZS_MIN_ALLOC_SIZE, \
+					    ZS_SIZE_CLASS_DELTA) + 1)
+
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+#define ZS_MULTI_PAGES_SIZE_CLASS_DELTA	(ZSMALLOC_MULTI_PAGES_SIZE >> (CLASS_BITS - 1))
+#define ZS_MULTI_PAGES_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - PAGE_SIZE, \
+					      ZS_MULTI_PAGES_SIZE_CLASS_DELTA) + 1)
+#define ZS_SIZE_CLASSES		(ZS_PAGE_SIZE_CLASSES + ZS_MULTI_PAGES_SIZE_CLASSES)
+#else
+#define ZS_SIZE_CLASSES		(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
+					      ZS_SIZE_CLASS_DELTA) + 1)
+#endif
+
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+static inline unsigned int class_size_to_zs_order(unsigned long size)
+{
+	if (size > PAGE_SIZE)
+		return ZSMALLOC_MULTI_PAGES_ORDER;
+
+	return 0;
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
 
 /*
  * Pages are distinguished by the ratio of used memory (that is the ratio
@@ -230,7 +271,7 @@ struct zs_size_stat {
 static struct dentry *zs_stat_root;
 #endif
 
-static size_t huge_class_size;
+static size_t huge_class_size[ZSMALLOC_TYPE_MAX];
 
 struct size_class {
 	spinlock_t lock;
@@ -241,13 +282,20 @@ struct size_class {
 	 */
 	int size;
 	int objs_per_zspage;
-	/* Number of PAGE_SIZE sized pages to combine to form a 'zspage' */
-	int pages_per_zspage;
+	/* Number of zpdescs to combine to form a 'zspage' */
+	int zpdescs_per_zspage;
 
 	unsigned int index;
 	struct zs_size_stat stats;
 };
 
+/* Number of physical pages in a zspage */
+static inline unsigned long class_pages_per_zspage(const struct size_class *class)
+{
+	return (unsigned long)class->zpdescs_per_zspage <<
+	       class_size_to_zs_order(class->size);
+}
+
 /*
  * Placed within free objects to form a singly linked list.
  * For every zspage, zspage->freeobj gives head of this list.
@@ -295,27 +343,28 @@ struct zs_pool {
 
 static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
 {
-	inc_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
+	__zone_stat_add_folio(zpdesc_folio(zpdesc), NR_ZSPAGES);
 }
 
 static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
 {
-	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
+	__zone_stat_sub_folio(zpdesc_folio(zpdesc), NR_ZSPAGES);
 }
 
-static inline struct zpdesc *alloc_zpdesc(gfp_t gfp, const int nid)
+static inline struct zpdesc *alloc_zpdesc(gfp_t gfp, const int nid,
+					  unsigned int order)
 {
-	struct page *page = alloc_pages_node(nid, gfp, 0);
+	struct page *page = alloc_pages_node(nid, gfp | __GFP_COMP, order);
 
 	return page_zpdesc(page);
 }
 
-static inline void free_zpdesc(struct zpdesc *zpdesc)
+static inline void free_zpdesc(struct zpdesc *zpdesc, unsigned int order)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
 	/* PageZsmalloc is sticky until the page is freed to the buddy. */
-	__free_page(page);
+	__free_pages(page, order);
 }
 
 #define ZS_PAGE_UNLOCKED	0
@@ -420,7 +469,7 @@ static void zspage_write_unlock(struct zspage *zspage)
 	spin_unlock(&zsl->lock);
 }
 
-/* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
+/* huge object: zpdescs_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
 	zspage->huge = 1;
@@ -535,6 +584,15 @@ static int get_size_class_index(int size)
 {
 	int idx = 0;
 
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+	if (size > PAGE_SIZE + ZS_HANDLE_SIZE) {
+		idx = ZS_PAGE_SIZE_CLASSES;
+		idx += DIV_ROUND_UP(size - PAGE_SIZE,
+				    ZS_MULTI_PAGES_SIZE_CLASS_DELTA);
+		return min_t(int, ZS_SIZE_CLASSES - 1, idx);
+	}
+#endif
+
 	if (likely(size > ZS_MIN_ALLOC_SIZE))
 		idx = DIV_ROUND_UP(size - ZS_MIN_ALLOC_SIZE,
 				ZS_SIZE_CLASS_DELTA);
@@ -594,11 +652,11 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
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
 
@@ -609,7 +667,8 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 
 		spin_lock(&class->lock);
 
-		seq_printf(s, " %5u %5u ", i, class->size);
+		seq_printf(s, " %5u %5u %5u", i, class->size,
+			   class_size_to_zs_order(class->size));
 		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
 			inuse_totals[fg] += class_stat_read(class, fg);
 			seq_printf(s, "%9lu ", class_stat_read(class, fg));
@@ -622,11 +681,12 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 
 		objs_per_zspage = class->objs_per_zspage;
 		pages_used = obj_allocated / objs_per_zspage *
-				class->pages_per_zspage;
+				class_pages_per_zspage(class);
 
-		seq_printf(s, "%13lu %10lu %10lu %16d %8lu\n",
+		seq_printf(s, "%13lu %10lu %10lu %16lu %16d %8lu\n",
 			   obj_allocated, obj_used, pages_used,
-			   class->pages_per_zspage, freeable);
+			   class_pages_per_zspage(class), objs_per_zspage,
+			   freeable);
 
 		total_objs += obj_allocated;
 		total_used_objs += obj_used;
@@ -634,13 +694,13 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		total_freeable += freeable;
 	}
 
-	seq_printf(s, "\n %5s %5s ", "Total", "");
+	seq_printf(s, "\n %5s %5s %5s ", "Total", "", "");
 
 	for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++)
 		seq_printf(s, "%9lu ", inuse_totals[fg]);
 
-	seq_printf(s, "%13lu %10lu %10lu %16s %8lu\n",
-		   total_objs, total_used_objs, total_pages, "",
+	seq_printf(s, "%13lu %10lu %10lu %16s %16s %8lu\n",
+		   total_objs, total_used_objs, total_pages, "", "",
 		   total_freeable);
 
 	return 0;
@@ -915,7 +975,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	assert_spin_locked(&class->lock);
 	__free_zspage_lockless(zspage);
 	class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
-	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
+	atomic_long_sub(class_pages_per_zspage(class), &pool->pages_allocated);
 }
 
 static void free_zspage(struct zs_pool *pool, struct size_class *class,
@@ -943,6 +1003,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 {
 	unsigned int freeobj = 1;
 	unsigned long off = 0;
+	unsigned long page_size = class_size_to_zs_size(class->size);
 	struct zpdesc *zpdesc = get_first_zpdesc(zspage);
 
 	while (zpdesc) {
@@ -955,7 +1016,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		vaddr = kmap_local_zpdesc(zpdesc);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
 
-		while ((off += class->size) < PAGE_SIZE) {
+		while ((off += class->size) < page_size) {
 			link->next = freeobj++ << OBJ_TAG_BITS;
 			link += class->size / sizeof(*link);
 		}
@@ -977,7 +1038,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		}
 		kunmap_local(vaddr);
 		zpdesc = next_zpdesc;
-		off %= PAGE_SIZE;
+		off %= page_size;
 	}
 
 	set_freeobj(zspage, 0);
@@ -989,7 +1050,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 	int i;
 	struct zpdesc *zpdesc;
 	struct zpdesc *prev_zpdesc = NULL;
-	int nr_zpdescs = class->pages_per_zspage;
+	int nr_zpdescs = class->zpdescs_per_zspage;
 
 	/*
 	 * Allocate individual pages and link them together as:
@@ -1006,7 +1067,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 		if (i == 0) {
 			zspage->first_zpdesc = zpdesc;
 			if (unlikely(class->objs_per_zspage == 1 &&
-					class->pages_per_zspage == 1))
+					class->zpdescs_per_zspage == 1))
 				SetZsHugePage(zspage);
 		} else {
 			prev_zpdesc->next = zpdesc;
@@ -1023,6 +1084,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 				   gfp_t gfp, const int nid)
 {
 	int i;
+	unsigned int order = class_size_to_zs_order(class->size);
 	struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
 	struct zspage *zspage = cache_alloc_zspage(gfp);
 
@@ -1032,19 +1094,24 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!IS_ENABLED(CONFIG_COMPACTION))
 		gfp &= ~__GFP_MOVABLE;
 
+	/*
+	 * Multi-page zspages are not movable, keep them out of ZONE_MOVABLE.
+	 */
+	if (order)
+		gfp &= ~__GFP_MOVABLE;
+
 	zspage->magic = ZSPAGE_MAGIC;
 	zspage->pool = pool;
 	zspage->class = class->index;
 	zspage_lock_init(zspage);
 
-	for (i = 0; i < class->pages_per_zspage; i++) {
-		struct zpdesc *zpdesc;
+	for (i = 0; i < class->zpdescs_per_zspage; i++) {
+		struct zpdesc *zpdesc = alloc_zpdesc(gfp, nid, order);
 
-		zpdesc = alloc_zpdesc(gfp, nid);
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
-				free_zpdesc(zpdescs[i]);
+				free_zpdesc(zpdescs[i], order);
 			}
 			cache_free_zspage(zspage);
 			return NULL;
@@ -1076,10 +1143,10 @@ static struct zspage *find_get_zspage(struct size_class *class)
 	return zspage;
 }
 
-static bool can_merge(struct size_class *prev, int pages_per_zspage,
+static bool can_merge(struct size_class *prev, int zpdescs_per_zspage,
 					int objs_per_zspage)
 {
-	if (prev->pages_per_zspage == pages_per_zspage &&
+	if (prev->zpdescs_per_zspage == zpdescs_per_zspage &&
 		prev->objs_per_zspage == objs_per_zspage)
 		return true;
 
@@ -1128,7 +1195,7 @@ void zs_obj_read_sg_begin(struct zs_pool *pool, const struct zs_handle *handle,
 {
 	struct zspage *zspage;
 	struct zpdesc *zpdesc;
-	unsigned long obj, off;
+	unsigned long obj, off, page_size;
 	unsigned int obj_idx;
 	struct size_class *class;
 
@@ -1143,12 +1210,13 @@ void zs_obj_read_sg_begin(struct zs_pool *pool, const struct zs_handle *handle,
 	read_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
-	off = offset_in_page(class->size * obj_idx);
+	page_size = class_size_to_zs_size(class->size);
+	off = (class->size * obj_idx) & (page_size - 1);
 
 	if (!ZsHugePage(zspage))
 		off += ZS_HANDLE_SIZE;
 
-	if (off + mem_len <= PAGE_SIZE) {
+	if (off + mem_len <= page_size) {
 		/* this object is contained entirely within a page */
 		sg_init_table(sg, 1);
 		sg_set_page(sg, zpdesc_page(zpdesc), mem_len, off);
@@ -1156,7 +1224,7 @@ void zs_obj_read_sg_begin(struct zs_pool *pool, const struct zs_handle *handle,
 		size_t sizes[2];
 
 		/* this object spans two pages */
-		sizes[0] = PAGE_SIZE - off;
+		sizes[0] = page_size - off;
 		sizes[1] = mem_len - sizes[0];
 
 		sg_init_table(sg, 2);
@@ -1189,16 +1257,17 @@ static void obj_write(struct size_class *class, struct zspage *zspage,
 		      unsigned long obj, const void *src, size_t size)
 {
 	struct zpdesc *zpdesc;
+	unsigned long page_size = class_size_to_zs_size(class->size);
 	unsigned long off;
 	unsigned int obj_idx;
 
 	obj_to_location(obj, &zpdesc, &obj_idx);
-	off = offset_in_page(class->size * obj_idx);
+	off = (class->size * obj_idx) & (page_size - 1);
 
 	if (!ZsHugePage(zspage))
 		off += ZS_HANDLE_SIZE;
 
-	if (off + size <= PAGE_SIZE) {
+	if (off + size <= page_size) {
 		/* this object is contained entirely within a page */
 		void *dst = kmap_local_zpdesc(zpdesc);
 
@@ -1208,7 +1277,7 @@ static void obj_write(struct size_class *class, struct zspage *zspage,
 		/* this object spans two pages */
 		size_t sizes[2];
 
-		sizes[0] = PAGE_SIZE - off;
+		sizes[0] = page_size - off;
 		sizes[1] = size - sizes[0];
 
 		memcpy_to_page(zpdesc_page(zpdesc), off, src, sizes[0]);
@@ -1230,9 +1299,9 @@ static void obj_write(struct size_class *class, struct zspage *zspage,
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
 
@@ -1245,15 +1314,17 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	struct size_class *class;
 
 	struct zpdesc *m_zpdesc;
-	unsigned long m_offset;
+	unsigned long m_offset, page_size, page_shift;
 	void *vaddr;
 
 	class = pool->size_class[zspage->class];
 	obj = get_freeobj(zspage);
 
+	page_size = class_size_to_zs_size(class->size);
+	page_shift = PAGE_SHIFT + class_size_to_zs_order(class->size);
 	offset = obj * class->size;
-	nr_zpdesc = offset >> PAGE_SHIFT;
-	m_offset = offset_in_page(offset);
+	nr_zpdesc = offset >> page_shift;
+	m_offset = offset & (page_size - 1);
 	m_zpdesc = get_first_zpdesc(zspage);
 
 	for (i = 0; i < nr_zpdesc; i++)
@@ -1348,12 +1419,13 @@ int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
 	spin_lock(&class->lock);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
-	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
+	atomic_long_add(class_pages_per_zspage(class), &pool->pages_allocated);
 	class_stat_add(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	class_stat_add(class, ZS_OBJS_INUSE, 1);
 
 	/* We completely set up zspage so mark them as movable */
-	SetZsPageMovable(pool, zspage);
+	if (class_size_to_zs_order(class->size) == 0)
+		SetZsPageMovable(pool, zspage);
 	spin_unlock(&class->lock);
 
 	return 0;
@@ -1365,13 +1437,15 @@ static void obj_free(int class_size, unsigned long obj)
 	struct link_free *link;
 	struct zspage *zspage;
 	struct zpdesc *f_zpdesc;
-	unsigned long f_offset;
+	unsigned long f_offset, page_size, page_mask;
 	unsigned int f_objidx;
 	void *vaddr;
 
 
 	obj_to_location(obj, &f_zpdesc, &f_objidx);
-	f_offset = offset_in_page(class_size * f_objidx);
+	page_size = class_size_to_zs_size(class_size);
+	page_mask = ~(page_size - 1);
+	f_offset = (class_size * f_objidx) & ~page_mask;
 	zspage = get_zspage(f_zpdesc);
 
 	vaddr = kmap_local_zpdesc(f_zpdesc);
@@ -1482,7 +1556,7 @@ void zs_free(struct zs_pool *pool, struct zs_handle *handle)
 
 	if (zspage_to_free) {
 		__free_zspage_lockless(zspage_to_free);
-		atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
+		atomic_long_sub(class_pages_per_zspage(class), &pool->pages_allocated);
 	}
 }
 EXPORT_SYMBOL_GPL(zs_free);
@@ -1540,6 +1614,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	struct zpdesc *s_zpdesc, *d_zpdesc;
 	unsigned int s_objidx, d_objidx;
 	unsigned long s_off, d_off;
+	unsigned long page_size = class_size_to_zs_size(class->size);
+	unsigned long page_mask = ~(page_size - 1);
 	void *s_addr, *d_addr;
 	int s_size, d_size, size;
 	int written = 0;
@@ -1549,14 +1625,14 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	obj_to_location(src, &s_zpdesc, &s_objidx);
 	obj_to_location(dst, &d_zpdesc, &d_objidx);
 
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
 
 	s_addr = kmap_local_zpdesc(s_zpdesc);
 	d_addr = kmap_local_zpdesc(d_zpdesc);
@@ -1581,7 +1657,7 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		 * kunmap_local(d_addr). For more details see
 		 * Documentation/mm/highmem.rst.
 		 */
-		if (s_off >= PAGE_SIZE) {
+		if (s_off >= page_size) {
 			kunmap_local(d_addr);
 			kunmap_local(s_addr);
 			s_zpdesc = get_next_zpdesc(s_zpdesc);
@@ -1591,7 +1667,7 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 			s_off = 0;
 		}
 
-		if (d_off >= PAGE_SIZE) {
+		if (d_off >= page_size) {
 			kunmap_local(d_addr);
 			d_zpdesc = get_next_zpdesc(d_zpdesc);
 			d_addr = kmap_local_zpdesc(d_zpdesc);
@@ -1615,13 +1691,13 @@ static struct zs_handle *find_alloced_obj(struct size_class *class,
 	int index = *obj_idx;
 	struct zs_handle *handle = NULL;
 	void *addr = kmap_local_zpdesc(zpdesc);
+	unsigned long page_size = class_size_to_zs_size(class->size);
 
 	offset = get_first_obj_offset(zpdesc);
 	offset += class->size * index;
 
-	while (offset < PAGE_SIZE) {
-		handle = obj_allocated(zpdesc, addr + offset);
-		if (handle)
+	while (offset < page_size) {
+		if (obj_allocated(zpdesc, addr + offset, &handle))
 			break;
 
 		offset += class->size;
@@ -2002,7 +2078,7 @@ static unsigned long zs_can_compact(struct size_class *class)
 	obj_wasted = obj_allocated - obj_used;
 	obj_wasted /= class->objs_per_zspage;
 
-	return obj_wasted * class->pages_per_zspage;
+	return obj_wasted * class_pages_per_zspage(class);
 }
 
 static unsigned long __zs_compact(struct zs_pool *pool,
@@ -2041,7 +2117,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		fg = putback_zspage(class, src_zspage);
 		if (fg == ZS_INUSE_RATIO_0) {
 			free_zspage(pool, class, src_zspage);
-			pages_freed += class->pages_per_zspage;
+			pages_freed += class_pages_per_zspage(class);
 		}
 		src_zspage = NULL;
 
@@ -2164,6 +2240,7 @@ static int calculate_zspage_chain_size(int class_size)
 {
 	int i, min_waste = INT_MAX;
 	int chain_size = 1;
+	unsigned long page_size = class_size_to_zs_size(class_size);
 
 	if (is_power_of_2(class_size))
 		return chain_size;
@@ -2171,7 +2248,7 @@ static int calculate_zspage_chain_size(int class_size)
 	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
 		int waste;
 
-		waste = (i * PAGE_SIZE) % class_size;
+		waste = (i * page_size) % class_size;
 		if (waste < min_waste) {
 			min_waste = waste;
 			chain_size = i;
@@ -2215,16 +2292,32 @@ struct zs_pool *zs_create_pool(const char *name)
 	 */
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		int size;
-		int pages_per_zspage;
+		int zpdescs_per_zspage;
 		int objs_per_zspage;
 		struct size_class *class;
 		int fullness;
+		int idx = ZSMALLOC_TYPE_BASEPAGE;
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+		int order = 0;
+#endif
 
-		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
+		if (i < ZS_PAGE_SIZE_CLASSES)
+			size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+		if (i >= ZS_PAGE_SIZE_CLASSES)
+			size = PAGE_SIZE + (i - ZS_PAGE_SIZE_CLASSES) *
+			       ZS_MULTI_PAGES_SIZE_CLASS_DELTA;
+#endif
 		if (size > ZS_MAX_ALLOC_SIZE)
 			size = ZS_MAX_ALLOC_SIZE;
-		pages_per_zspage = calculate_zspage_chain_size(size);
-		objs_per_zspage = pages_per_zspage * PAGE_SIZE / size;
+#ifdef CONFIG_ZSMALLOC_MULTI_PAGES
+		order = class_size_to_zs_order(size);
+		if (order == ZSMALLOC_MULTI_PAGES_ORDER)
+			idx = ZSMALLOC_TYPE_MULTI_PAGES;
+#endif
+		zpdescs_per_zspage = calculate_zspage_chain_size(size);
+		objs_per_zspage = zpdescs_per_zspage *
+				  class_size_to_zs_size(size) / size;
 
 		/*
 		 * We iterate from biggest down to smallest classes,
@@ -2232,9 +2325,9 @@ struct zs_pool *zs_create_pool(const char *name)
 		 * class. Any object bigger than or equal to that will
 		 * endup in the huge class.
 		 */
-		if (pages_per_zspage != 1 && objs_per_zspage != 1 &&
-				!huge_class_size) {
-			huge_class_size = size;
+		if (zpdescs_per_zspage != 1 && objs_per_zspage != 1 &&
+				!huge_class_size[idx]) {
+			huge_class_size[idx] = size;
 			/*
 			 * The object uses ZS_HANDLE_SIZE bytes to store the
 			 * handle. We need to subtract it, because zs_store()
@@ -2244,7 +2337,7 @@ struct zs_pool *zs_create_pool(const char *name)
 			 * class because it grows by ZS_HANDLE_SIZE extra bytes
 			 * right before class lookup.
 			 */
-			huge_class_size -= (ZS_HANDLE_SIZE - 1);
+			huge_class_size[idx] -= (ZS_HANDLE_SIZE - 1);
 		}
 
 		/*
@@ -2257,7 +2350,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		 * previous size_class if possible.
 		 */
 		if (prev_class) {
-			if (can_merge(prev_class, pages_per_zspage, objs_per_zspage)) {
+			if (can_merge(prev_class, zpdescs_per_zspage, objs_per_zspage)) {
 				pool->size_class[i] = prev_class;
 				continue;
 			}
@@ -2269,7 +2362,7 @@ struct zs_pool *zs_create_pool(const char *name)
 
 		class->size = size;
 		class->index = i;
-		class->pages_per_zspage = pages_per_zspage;
+		class->zpdescs_per_zspage = zpdescs_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
 		spin_lock_init(&class->lock);
 		pool->size_class[i] = class;
-- 
2.43.0

