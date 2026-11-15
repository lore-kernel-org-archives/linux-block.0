Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794710818;
	b=SnASg7wFbZPC2u8XzR3elOC+mIDzFgSvOmBr46xPw+gBl7ndOmC7feyQDMEhlla/qNYI
	 6E0JI3UxjHe+HXi5Sd5BGvvb4MyozackMySLVbMtzD1u5gMS63OHS0aVOaS9mjr96oox6
	 8XV1jbx4hoNOZrPpjwXU76bPJehonAFXAW3jinOmsMajhmpexUYxWipgspZbU1TbKqpz5
	 qC1fLNYKqcV5np4WfSe6en7f4tEN/6+L02JDUe5DqhsEUTNu+IYnSaaSFOX7o9HOdjcoV
	 aH1VBivMHEOTisv3iRjlYTWBnv5N+Gaf0BKGx0Y4NEiWIA7N2p7luguSjZSLGrztUfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794710818;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=nQKvSqWLu//w6U830tOKBBV5GH07PcpsYggjXC2CdsE=;
	b=UWNe3Ji+VKBXuT+URv6gdmJujy4O3rvgSGz5Qe5ywAIIEid64ZVf9uMhBRJYQWYjMv8/
	 4AjLsAswh8owv1yBNznxNEgOtjRpdf2wgtRKygvdUIVmGN0Z77pj1VtSJB5wTaj4CL6UN
	 o8YKARGtakUMK/r4lly3wIKwZr1WnHUhQp1RbbO8IxopcJNqks3QfzQwwZVlZbZqK4QZH
	 qDve6Vsp2ZfYaA2eoiWhq9lisuvOx/aLxsB0A4XCTMoJpM/8kbHJgETxo4yW1kl6oa4lK
	 cvJhb1v6gGCYqHSin79MT9ZgNJKUmjzHulsnk8W4urZNW9FByBDB2kSX8ULgbbtZ9WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=hzH1+qJN;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53E606A33E;
	Sun, 15 Nov 2026 02:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F53E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=hzH1+qJN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nQ
	KvSqWLu//w6U830tOKBBV5GH07PcpsYggjXC2CdsE=; b=hzH1+qJNhPpTr93c1f
	idfmobArqnsvsITAhnSPXCXv15uPdYeXeeCZYLM67rMNauAeY6OP9i+10iv0LwP8
	jpoFTG32PsDLCg0OnjzRTvz42ZbHrvMqVQkgncFE4p8a6gKqdFrQvLhK5TwGbGEf
	+J/5MKYhreLlBIRZ/4a0YPNqg=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3H_OtHPlq+ob+DQ--.31738S4;
	Sun, 15 Nov 2026 10:45:18 +0800 (CST)
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
Subject: [RFC PATCH v4 2/4] zram: support compression at the granularity of multi-pages
Date: Sun, 15 Nov 2026 10:44:49 +0800
Message-ID: <20261115024455.1465726-3-zhaonanzhe@xiaomi.com>
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
X-CM-TRANSID:PikvCgD3H_OtHPlq+ob+DQ--.31738S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfWF1UGF18CFWktF4DArWfGrg_yoW5tw4Uuo
	W7JFs3J3W8Gry5JFW0yr1xKayYva1vkF93CF1rGr1DWrZxur1Yqa47Cw1YqF1xAr4rGF4S
	vr9av3W5Xr48Ja9xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsc_-DUUUU
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoh9PH2r5HL8jCwAA31

From: Tangquan Zheng <zhengtangquan@oppo.com>

Currently, when a large folio with nr_pages is submitted to zram, it is
divided into nr_pages parts for compression and storage individually.
By transitioning to a higher granularity, we can notably enhance
compression rates while simultaneously reducing CPU consumption.

This patch introduces the capability for large folios to be divided
based on the granularity specified by ZSMALLOC_MULTI_PAGES_ORDER, which
defaults to 2. For instance, for folios sized at 128KiB, compression
will occur in eight 16KiB multi-pages.

This modification will notably reduce CPU consumption and enhance
compression ratios. The following data illustrates the time and
compressed data for typical anonymous pages gathered from Android
phones.

Signed-off-by: Tangquan Zheng <zhengtangquan@oppo.com>
Co-developed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Barry Song <baohua@kernel.org>
Co-developed-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 drivers/block/zram/Kconfig    |   9 +
 drivers/block/zram/zcomp.c    |  31 ++-
 drivers/block/zram/zcomp.h    |  19 +-
 drivers/block/zram/zram_drv.c | 500 ++++++++++++++++++++++++++++++----
 drivers/block/zram/zram_drv.h |  43 +++
 mm/zsmalloc.c                 |   3 +-
 6 files changed, 549 insertions(+), 56 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 402b7b175863..716e92c5fdfe 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -145,3 +145,12 @@ config ZRAM_MULTI_COMP
 	  re-compress pages using a potentially slower but more effective
 	  compression algorithm. Note, that IDLE page recompression
 	  requires ZRAM_TRACK_ENTRY_ACTIME.
+
+config ZRAM_MULTI_PAGES
+	bool "Enable multiple pages compression and decompression"
+	depends on ZRAM && ZSMALLOC_MULTI_PAGES
+	help
+	  Initially, zram divided large folios into blocks of nr_pages, each sized
+	  equal to PAGE_SIZE, for compression. This option fine-tunes zram to
+	  improve compression granularity by dividing large folios into larger
+	  parts defined by the configuration option ZSMALLOC_MULTI_PAGES_ORDER.
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index ad8c7dc73922..8fa2a44adaa3 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -71,7 +71,7 @@ static int zcomp_cstrm_init(struct zcomp *comp, struct zcomp_cstrm *zstrm)
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
-	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
+	zstrm->buffer = vzalloc(2 * ZCOMP_MULTI_PAGES_SIZE);
 	if (!zstrm->buffer) {
 		zcomp_cstrm_free(comp, zstrm);
 		return -ENOMEM;
@@ -83,6 +83,10 @@ static void zcomp_dstrm_free(struct zcomp *comp, struct zcomp_dstrm *zstrm)
 {
 	if (comp->ops->destroy_dctx)
 		comp->ops->destroy_dctx(&zstrm->ctx);
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	vfree(zstrm->decomp_buf);
+	zstrm->decomp_buf = NULL;
+#endif
 	vfree(zstrm->local_copy);
 	zstrm->local_copy = NULL;
 	zstrm->ctx.context = NULL;
@@ -101,11 +105,23 @@ static int zcomp_dstrm_init(struct zcomp *comp, struct zcomp_dstrm *zstrm)
 		}
 	}
 
-	zstrm->local_copy = vzalloc(PAGE_SIZE);
+	zstrm->local_copy = vzalloc(ZCOMP_MULTI_PAGES_SIZE);
 	if (!zstrm->local_copy) {
 		zcomp_dstrm_free(comp, zstrm);
 		return -ENOMEM;
 	}
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	/*
+	 * Preallocate a decompression buffer for partial multi-page reads to
+	 * avoid memory allocation in the swapin path.
+	 */
+	zstrm->decomp_buf = vzalloc(ZCOMP_MULTI_PAGES_SIZE);
+	if (!zstrm->decomp_buf) {
+		zcomp_dstrm_free(comp, zstrm);
+		return -ENOMEM;
+	}
+	mutex_init(&zstrm->buf_lock);
+#endif
 	return 0;
 }
 
@@ -255,13 +271,13 @@ void zcomp_dstrm_put(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 }
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
-		   const void *src, unsigned int *dst_len)
+		   const void *src, unsigned int src_len, unsigned int *dst_len)
 {
 	struct zcomp_req req = {
 		.src = src,
 		.dst = zstrm->buffer,
-		.src_len = PAGE_SIZE,
-		.dst_len = 2 * PAGE_SIZE,
+		.src_len = src_len,
+		.dst_len = 2 * src_len,
 	};
 	int ret;
 
@@ -282,12 +298,13 @@ static int zcomp_decompress_buf(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 }
 
 int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
-		     struct scatterlist *sg, unsigned int src_len, void *dst)
+		     struct scatterlist *sg, unsigned int src_len, void *dst,
+		     unsigned int dst_len)
 {
 	struct zcomp_req req = {
 		.dst = dst,
 		.src_len = src_len,
-		.dst_len = PAGE_SIZE,
+		.dst_len = dst_len,
 	};
 	void *src;
 	int ret;
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 39efefc43a13..fee105f876b4 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -47,6 +47,15 @@ struct zcomp_ctx {
 	void *context;
 };
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+#define ZCOMP_MULTI_PAGES_ORDER	(_AC(CONFIG_ZSMALLOC_MULTI_PAGES_ORDER, UL))
+#define ZCOMP_MULTI_PAGES_NR	(1 << ZCOMP_MULTI_PAGES_ORDER)
+#define ZCOMP_MULTI_PAGES_SIZE	(PAGE_SIZE * ZCOMP_MULTI_PAGES_NR)
+#define MULTI_PAGE_SHIFT (ZCOMP_MULTI_PAGES_ORDER + PAGE_SHIFT)
+#else
+#define ZCOMP_MULTI_PAGES_SIZE	PAGE_SIZE
+#endif
+
 struct zcomp_cstrm {
 	struct mutex lock;
 	/* compression buffer */
@@ -65,6 +74,11 @@ struct zcomp_dstrm {
 	struct mutex excl_lock;
 	/* local copy of handle memory */
 	void *local_copy;
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	/* Temporary buffer and lock for partial multi-page decompression */
+	void *decomp_buf;
+	struct mutex buf_lock;
+#endif
 	struct zcomp_ctx ctx;
 };
 
@@ -124,8 +138,9 @@ void zcomp_dstrm_put(struct zcomp *comp, struct zcomp_dstrm *zstrm,
 		     enum zcomp_dstrm_mode mode);
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
-		   const void *src, unsigned int *dst_len);
+		   const void *src, unsigned int src_len, unsigned int *dst_len);
 int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
-		     struct scatterlist *sg, unsigned int src_len, void *dst);
+		     struct scatterlist *sg, unsigned int src_len, void *dst,
+		     unsigned int dst_len);
 
 #endif /* _ZCOMP_H_ */
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 24eefcf143de..0d33220f4b22 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -53,11 +53,12 @@ static unsigned int num_devices = 1;
  * Pages that compress to sizes equals or greater than this are stored
  * uncompressed in memory.
  */
-static size_t huge_class_size;
+static size_t huge_class_size[ZSMALLOC_TYPE_MAX];
 
 static const struct block_device_operations zram_devops;
 
 static void slot_free(struct zram *zram, unsigned long index);
+static void slot_free_npages(struct zram *zram, unsigned long index, int nr_pages);
 
 /*
  * entry locking rules:
@@ -321,11 +322,12 @@ static inline void zram_fill_page(void *ptr, unsigned long len,
 	memset_l(ptr, value, len / sizeof(unsigned long));
 }
 
-static bool page_same_filled(void *ptr, unsigned long *element)
+static bool page_same_filled(void *ptr, unsigned long *element,
+			     unsigned int page_size)
 {
 	unsigned long *page;
 	unsigned long val;
-	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
+	unsigned int pos, last_pos = page_size / sizeof(*page) - 1;
 
 	page = (unsigned long *)ptr;
 	val = page[0];
@@ -484,7 +486,7 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 static int read_from_zspool_raw(struct zram *zram, struct page *page,
 				unsigned long index);
 static int read_from_zspool(struct zram *zram, struct page *page,
-			    unsigned long index);
+			    unsigned long index, unsigned long page_size);
 
 struct zram_wb_ctl {
 	/* idle list is accessed only by the writeback task, no concurency */
@@ -1092,7 +1094,7 @@ static int zram_writeback_slots(struct zram *zram,
 		if (zram->compressed_wb)
 			err = read_from_zspool_raw(zram, req->page, index);
 		else
-			err = read_from_zspool(zram, req->page, index);
+			err = read_from_zspool(zram, req->page, index, PAGE_SIZE);
 		if (err)
 			goto next;
 		slot_unlock(zram, index);
@@ -1379,7 +1381,7 @@ static int decompress_bdev_page(struct zram *zram, struct page *page,
 
 	zstrm = zcomp_dstrm_get(zram->comps[prio], ZCOMP_DSTRM_EXCLUSIVE);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size,
-			       zstrm->local_copy);
+			       zstrm->local_copy, PAGE_SIZE);
 	if (!ret) {
 		void *dst = kmap_local_page(page);
 
@@ -1989,6 +1991,31 @@ static ssize_t debug_stat_show(struct device *dev,
 	return ret;
 }
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+static ssize_t multi_pages_debug_stat_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ssize_t ret;
+
+	guard(rwsem_read)(&zram->dev_lock);
+	ret = sysfs_emit(buf,
+			"zram_bio write/read multi_pages count:%8llu %8llu\n"
+			"zram_bio failed write/read multi_pages count%8llu %8llu\n"
+			"zram_bio partial write/read multi_pages count%8llu %8llu\n"
+			"multi_pages_miss_free %8llu\n",
+			(u64)atomic64_read(&zram->stats.zram_bio_write_multi_pages_count),
+			(u64)atomic64_read(&zram->stats.zram_bio_read_multi_pages_count),
+			(u64)atomic64_read(&zram->stats.multi_pages_failed_writes),
+			(u64)atomic64_read(&zram->stats.multi_pages_failed_reads),
+			(u64)atomic64_read(&zram->stats.zram_bio_write_multi_pages_partial_count),
+			(u64)atomic64_read(&zram->stats.zram_bio_read_multi_pages_partial_count),
+			(u64)atomic64_read(&zram->stats.multi_pages_miss_free));
+
+	return ret;
+}
+#endif
+
 static void zram_meta_free(struct zram *zram, u64 disksize)
 {
 	unsigned long num_pages = disksize >> PAGE_SHIFT;
@@ -2010,6 +2037,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
 	unsigned long num_pages;
+	int i;
 
 	num_pages = disksize >> PAGE_SHIFT;
 	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
@@ -2023,9 +2051,10 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		return false;
 	}
 
-	if (!huge_class_size)
-		huge_class_size = zs_huge_class_size(zram->mem_pool,
-						ZSMALLOC_TYPE_BASEPAGE);
+	for (i = 0; i < ZSMALLOC_TYPE_MAX; i++) {
+		if (!huge_class_size[i])
+			huge_class_size[i] = zs_huge_class_size(zram->mem_pool, i);
+	}
 
 	lockdep_register_key(&zram->table_lock_key);
 	lockdep_init_map(&zram->table_lock_map, "zram->table[index].lock", &zram->table_lock_key, 0);
@@ -2033,10 +2062,18 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	return true;
 }
 
-static void slot_free(struct zram *zram, unsigned long index)
+static void slot_free_npages(struct zram *zram, unsigned long index,
+			     int nr_pages)
 {
 	struct zs_handle *handle;
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (test_slot_flag(zram, index, ZRAM_COMP_MULTI_PAGES)) {
+		clear_slot_flag(zram, index, ZRAM_COMP_MULTI_PAGES);
+		nr_pages = max(nr_pages, ZCOMP_MULTI_PAGES_NR);
+	}
+#endif
+
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].attr.ac_time = 0;
 #endif
@@ -2068,7 +2105,7 @@ static void slot_free(struct zram *zram, unsigned long index)
 	 */
 	if (test_slot_flag(zram, index, ZRAM_SAME)) {
 		clear_slot_flag(zram, index, ZRAM_SAME);
-		atomic64_dec(&zram->stats.same_pages);
+		atomic64_sub(nr_pages, &zram->stats.same_pages);
 		goto out;
 	}
 
@@ -2081,44 +2118,49 @@ static void slot_free(struct zram *zram, unsigned long index)
 	atomic64_sub(get_slot_size(zram, index),
 		     &zram->stats.compr_data_size);
 out:
-	atomic64_dec(&zram->stats.pages_stored);
+	atomic64_sub(nr_pages, &zram->stats.pages_stored);
 	zram->table[index].element = 0;
 	set_slot_size(zram, index, 0);
 }
 
+static void slot_free(struct zram *zram, unsigned long index)
+{
+	slot_free_npages(zram, index, 1);
+}
+
 static int read_same_filled_page(struct zram *zram, struct page *page,
-				 unsigned long index)
+				 unsigned long index, unsigned long page_size)
 {
 	void *mem;
 
 	mem = kmap_local_page(page);
-	zram_fill_page(mem, PAGE_SIZE, zram->table[index].element);
+	zram_fill_page(mem, page_size, zram->table[index].element);
 	kunmap_local(mem);
 	return 0;
 }
 
 static int read_incompressible_page(struct zram *zram, struct page *page,
-				    unsigned long index)
+				    unsigned long index,
+				    unsigned long page_size)
 {
 	struct scatterlist sg[2];
 	struct zs_handle *handle;
-	void *src, *dst;
+	void *dst;
 
 	handle = &zram->table[index].handle;
-	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, PAGE_SIZE);
+	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, page_size);
 	/* an incompressible object never spans two pages */
-	src = kmap_local_page(sg_page(sg));
 	dst = kmap_local_page(page);
-	copy_page(dst, src);
+	sg_copy_to_buffer(sg, sg_nents(sg), dst, page_size);
 	kunmap_local(dst);
-	kunmap_local(src);
 	zs_obj_read_sg_end(zram->mem_pool, handle);
 
 	return 0;
 }
 
 static int read_compressed_page(struct zram *zram, struct page *page,
-				unsigned long index)
+				unsigned long index,
+				unsigned long page_size)
 {
 	enum zcomp_dstrm_mode mode = ZCOMP_DSTRM_EXCLUSIVE;
 	struct zcomp_dstrm *zstrm;
@@ -2138,7 +2180,8 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 
 	zstrm = zcomp_dstrm_get(zram->comps[prio], mode);
 	dst = kmap_local_page(page);
-	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size, dst);
+	ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size, dst,
+			       page_size);
 	kunmap_local(dst);
 	zcomp_dstrm_put(zram->comps[prio], zstrm, mode);
 	zs_obj_read_sg_end(zram->mem_pool, handle);
@@ -2179,20 +2222,21 @@ static int read_from_zspool_raw(struct zram *zram, struct page *page,
  * Corresponding ZRAM slot should be locked.
  */
 static int read_from_zspool(struct zram *zram, struct page *page,
-			    unsigned long index)
+			    unsigned long index, unsigned long page_size)
 {
 	if (test_slot_flag(zram, index, ZRAM_SAME) ||
 	    !zs_handle_is_allocated(&zram->table[index].handle))
-		return read_same_filled_page(zram, page, index);
+		return read_same_filled_page(zram, page, index, page_size);
 
 	if (!test_slot_flag(zram, index, ZRAM_HUGE))
-		return read_compressed_page(zram, page, index);
+		return read_compressed_page(zram, page, index, page_size);
 	else
-		return read_incompressible_page(zram, page, index);
+		return read_incompressible_page(zram, page, index, page_size);
 }
 
-static int zram_read_page(struct zram *zram, struct page *page,
-			  unsigned long index, struct bio *parent)
+static int zram_read_page_size(struct zram *zram, struct page *page,
+			       unsigned long index, struct bio *parent,
+			       unsigned long page_size)
 {
 	int ret;
 
@@ -2200,7 +2244,7 @@ static int zram_read_page(struct zram *zram, struct page *page,
 	mark_slot_accessed(zram, index);
 	if (!test_slot_flag(zram, index, ZRAM_WB)) {
 		/* Slot should be locked through out the function call */
-		ret = read_from_zspool(zram, page, index);
+		ret = read_from_zspool(zram, page, index, page_size);
 		slot_unlock(zram, index);
 	} else {
 		unsigned long blk_idx = zram->table[index].blk_idx;
@@ -2216,6 +2260,12 @@ static int zram_read_page(struct zram *zram, struct page *page,
 	return ret;
 }
 
+static int zram_read_page(struct zram *zram, struct page *page,
+			  unsigned long index, struct bio *parent)
+{
+	return zram_read_page_size(zram, page, index, parent, PAGE_SIZE);
+}
+
 /*
  * Use a temporary buffer to decompress the page, as the decompressor
  * always expects a full page for the output.
@@ -2244,23 +2294,32 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 }
 
 static int write_same_filled_page(struct zram *zram, unsigned long fill,
-				  unsigned long index)
+				  unsigned long index, int nr_pages)
 {
 	slot_lock(zram, index);
 	slot_free(zram, index);
 	set_slot_flag(zram, index, ZRAM_SAME);
 	zram->table[index].element = fill;
 	mark_slot_accessed(zram, index);
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (nr_pages > 1) {
+		int i;
+
+		for (i = 0; i < nr_pages; i++)
+			set_slot_flag(zram, index + i, ZRAM_COMP_MULTI_PAGES);
+	}
+#endif
 	slot_unlock(zram, index);
 
-	atomic64_inc(&zram->stats.same_pages);
-	atomic64_inc(&zram->stats.pages_stored);
+	atomic64_add(nr_pages, &zram->stats.same_pages);
+	atomic64_add(nr_pages, &zram->stats.pages_stored);
 
 	return 0;
 }
 
 static int write_incompressible_page(struct zram *zram, struct page *page,
-				     unsigned long index)
+				     unsigned long index, unsigned int page_size,
+				     int nr_pages)
 {
 	void *src;
 	int ret;
@@ -2269,7 +2328,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	slot_free(zram, index);
 	src = kmap_local_page(page);
 	ret = zs_store(zram->mem_pool, &zram->table[index].handle, src,
-		       PAGE_SIZE, GFP_NOIO | __GFP_NOWARN |
+		       page_size, GFP_NOIO | __GFP_NOWARN |
 		       __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
 	kunmap_local(src);
 	if (ret) {
@@ -2280,14 +2339,22 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	update_used_max(zram);
 
 	set_slot_flag(zram, index, ZRAM_HUGE);
-	set_slot_size(zram, index, PAGE_SIZE);
+	set_slot_size(zram, index, page_size);
 	mark_slot_accessed(zram, index);
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (nr_pages > 1) {
+		int i;
+
+		for (i = 0; i < nr_pages; i++)
+			set_slot_flag(zram, index + i, ZRAM_COMP_MULTI_PAGES);
+	}
+#endif
 	slot_unlock(zram, index);
 
-	atomic64_add(PAGE_SIZE, &zram->stats.compr_data_size);
+	atomic64_add(page_size, &zram->stats.compr_data_size);
 	atomic64_inc(&zram->stats.huge_pages);
 	atomic64_inc(&zram->stats.huge_pages_since);
-	atomic64_inc(&zram->stats.pages_stored);
+	atomic64_add(nr_pages, &zram->stats.pages_stored);
 
 	return 0;
 }
@@ -2301,12 +2368,27 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	struct zcomp_cstrm *zstrm;
 	unsigned long element;
 	bool same_filled;
+	unsigned long page_size = PAGE_SIZE;
+	int huge_class_idx = ZSMALLOC_TYPE_BASEPAGE;
+	int nr_pages = 1;
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	/*
+	 * Multi-page compression packs ZCOMP_MULTI_PAGES_NR pages into one
+	 * compressed object.
+	 */
+	if (folio_size(page_folio(page)) >= ZCOMP_MULTI_PAGES_SIZE) {
+		page_size = ZCOMP_MULTI_PAGES_SIZE;
+		huge_class_idx = ZSMALLOC_TYPE_MULTI_PAGES;
+		nr_pages = ZCOMP_MULTI_PAGES_NR;
+	}
+#endif
 
 	mem = kmap_local_page(page);
-	same_filled = page_same_filled(mem, &element);
+	same_filled = page_same_filled(mem, &element, page_size);
 	kunmap_local(mem);
 	if (same_filled)
-		return write_same_filled_page(zram, element, index);
+		return write_same_filled_page(zram, element, index, nr_pages);
 
 	if (!zram_can_store_page(zram))
 		return -ENOMEM;
@@ -2314,7 +2396,7 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	zstrm = zcomp_cstrm_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
-			     mem, &comp_len);
+			     mem, page_size, &comp_len);
 	kunmap_local(mem);
 
 	if (unlikely(ret)) {
@@ -2323,9 +2405,10 @@ static int zram_write_page(struct zram *zram, struct page *page,
 		return ret;
 	}
 
-	if (comp_len >= huge_class_size) {
+	if (comp_len >= huge_class_size[huge_class_idx]) {
 		zcomp_cstrm_put(zstrm);
-		return write_incompressible_page(zram, page, index);
+		return write_incompressible_page(zram, page, index, page_size,
+						 nr_pages);
 	}
 
 	slot_lock(zram, index);
@@ -2344,10 +2427,18 @@ static int zram_write_page(struct zram *zram, struct page *page,
 
 	set_slot_size(zram, index, comp_len);
 	mark_slot_accessed(zram, index);
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (nr_pages > 1) {
+		int i;
+
+		for (i = 0; i < nr_pages; i++)
+			set_slot_flag(zram, index + i, ZRAM_COMP_MULTI_PAGES);
+	}
+#endif
 	slot_unlock(zram, index);
 
 	/* Update stats */
-	atomic64_inc(&zram->stats.pages_stored);
+	atomic64_add(nr_pages, &zram->stats.pages_stored);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
 
 	return ret;
@@ -2467,7 +2558,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	if (comp_len_old < threshold)
 		return 0;
 
-	ret = read_from_zspool(zram, page, index);
+	ret = read_from_zspool(zram, page, index, PAGE_SIZE);
 	if (ret)
 		return ret;
 
@@ -2480,7 +2571,8 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 
 	zstrm = zcomp_cstrm_get(zram->comps[prio]);
 	src = kmap_local_page(page);
-	ret = zcomp_compress(zram->comps[prio], zstrm, src, &comp_len_new);
+	ret = zcomp_compress(zram->comps[prio], zstrm, src, PAGE_SIZE,
+			      &comp_len_new);
 	kunmap_local(src);
 
 	/*
@@ -2615,7 +2707,7 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
-	if (threshold >= huge_class_size)
+	if (threshold >= huge_class_size[ZSMALLOC_TYPE_BASEPAGE])
 		return -EINVAL;
 
 	guard(rwsem_write)(&zram->dev_lock);
@@ -2727,8 +2819,283 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 	bio_endio(bio);
 }
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+
+static inline unsigned long zram_multi_pages_head_index(unsigned long index)
+{
+	return index & ~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
+}
+
+static inline int __test_multi_pages_comp(struct zram *zram,
+					 unsigned long index)
+{
+	unsigned long head = zram_multi_pages_head_index(index);
+	int i, count = 0;
+
+	for (i = 0; i < ZCOMP_MULTI_PAGES_NR; i++) {
+		if (test_slot_flag(zram, head + i, ZRAM_COMP_MULTI_PAGES))
+			count++;
+	}
+
+	return count;
+}
+
+static inline bool want_multi_pages_comp(struct zram *zram, struct bio *bio)
+{
+	unsigned long index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+
+	if (bio->bi_io_vec->bv_len >= ZCOMP_MULTI_PAGES_SIZE)
+		return true;
+
+	slot_lock(zram, index);
+	if (__test_multi_pages_comp(zram, index)) {
+		slot_unlock(zram, index);
+		return true;
+	}
+	slot_unlock(zram, index);
+
+	return false;
+}
+
+static inline bool test_multi_pages_comp(struct zram *zram, struct bio *bio)
+{
+	unsigned long index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+
+	return !!__test_multi_pages_comp(zram, index);
+}
+
+static inline bool is_multi_pages_partial_io(struct bio_vec *bvec)
+{
+	return bvec->bv_len != ZCOMP_MULTI_PAGES_SIZE;
+}
+
+static int zram_read_partial_from_zspool(struct zram *zram, struct page *page,
+					unsigned long index, int offset)
+{
+	struct zs_handle *handle = &zram->table[index].handle;
+	struct zcomp_dstrm *zstrm;
+	struct scatterlist sg[2];
+	enum zcomp_dstrm_mode mode;
+	unsigned int size;
+	void *src, *dst;
+	u32 prio;
+	int ret;
+	unsigned long page_size = ZCOMP_MULTI_PAGES_SIZE;
+
+	if (test_slot_flag(zram, index, ZRAM_SAME) ||
+	    !zs_handle_is_allocated(handle)) {
+		void *mem;
+
+		mem = kmap_local_page(page);
+		zram_fill_page(mem, PAGE_SIZE, zram->table[index].element);
+		kunmap_local(mem);
+		return 0;
+	}
+
+	size = get_slot_size(zram, index);
+	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, size);
+
+	if (size == page_size) {
+		src = kmap_local_page(sg_page(sg));
+		dst = kmap_local_page(page);
+		memcpy(dst, src + offset, PAGE_SIZE);
+		kunmap_local(dst);
+		kunmap_local(src);
+		ret = 0;
+	} else {
+		prio = get_slot_comp_priority(zram, index);
+		mode = ZCOMP_DSTRM_EXCLUSIVE;
+		if (zcomp_shared_decomp(zram->comps[prio]))
+			mode = ZCOMP_DSTRM_SHARED;
+
+		zstrm = zcomp_dstrm_get(zram->comps[prio], mode);
+		mutex_lock(&zstrm->buf_lock);
+		ret = zcomp_decompress(zram->comps[prio], zstrm, sg, size,
+				       zstrm->decomp_buf, page_size);
+		if (!ret) {
+			dst = kmap_local_page(page);
+			memcpy(dst, zstrm->decomp_buf + offset, PAGE_SIZE);
+			kunmap_local(dst);
+		}
+		mutex_unlock(&zstrm->buf_lock);
+		zcomp_dstrm_put(zram->comps[prio], zstrm, mode);
+	}
+	zs_obj_read_sg_end(zram->mem_pool, handle);
+
+	return ret;
+}
+
+static int zram_bvec_read_multi_pages_partial(struct zram *zram,
+					      struct bio_vec *bvec,
+					      unsigned long index, int offset,
+					      struct bio *bio)
+{
+	int ret;
+
+	slot_lock(zram, index);
+	if (!test_slot_flag(zram, index, ZRAM_WB)) {
+		ret = zram_read_partial_from_zspool(zram, bvec->bv_page,
+						    index, offset);
+		slot_unlock(zram, index);
+	} else {
+		unsigned long blk_idx = zram->table[index].blk_idx;
+
+		slot_unlock(zram, index);
+		ret = read_from_bdev(zram, bvec->bv_page, index, blk_idx, bio);
+	}
+
+	if (WARN_ON(ret < 0))
+		pr_err("Decompression failed! err=%d, page=%lu offset=%d\n",
+		       ret, index, offset);
+	if (!ret)
+		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
+
+	return ret;
+}
+
+static int zram_bvec_read_multi_pages(struct zram *zram, struct bio_vec *bvec,
+				      unsigned long index, int offset,
+				      struct bio *bio)
+{
+	if (is_multi_pages_partial_io(bvec))
+		return zram_bvec_read_multi_pages_partial(zram, bvec, index,
+							  offset, bio);
+
+	return zram_read_page_size(zram, bvec->bv_page, index, bio,
+				   ZCOMP_MULTI_PAGES_SIZE);
+}
+
+static int zram_bvec_write_multi_pages_partial(struct zram *zram,
+					       struct bio_vec *bvec,
+					       unsigned long index, int offset,
+					       struct bio *bio)
+{
+	struct page *page;
+	void *src, *dst;
+	int ret;
+
+	page = alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MULTI_PAGES_ORDER);
+	if (!page)
+		return -ENOMEM;
+
+	ret = zram_read_page_size(zram, page, index, bio,
+				  ZCOMP_MULTI_PAGES_SIZE);
+	if (!ret) {
+		src = kmap_local_page(bvec->bv_page);
+		dst = kmap_local_page(page);
+		memcpy(dst + offset, src + bvec->bv_offset, bvec->bv_len);
+		kunmap_local(dst);
+		kunmap_local(src);
+
+		atomic64_inc(&zram->stats.zram_bio_write_multi_pages_partial_count);
+		ret = zram_write_page(zram, page, index);
+	}
+
+	__free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
+	return ret;
+}
+
+static int zram_bvec_write_multi_pages(struct zram *zram, struct bio_vec *bvec,
+				       unsigned long index, int offset,
+				       struct bio *bio)
+{
+	if (is_multi_pages_partial_io(bvec))
+		return zram_bvec_write_multi_pages_partial(zram, bvec, index,
+							   offset, bio);
+
+	return zram_write_page(zram, bvec->bv_page, index);
+}
+
+static void zram_bio_read_multi_pages(struct zram *zram, struct bio *bio)
+{
+	unsigned long start_time = bio_start_io_acct(bio);
+	struct bvec_iter iter = bio->bi_iter;
+
+	do {
+		unsigned long index = zram_multi_pages_head_index(
+			iter.bi_sector >> SECTORS_PER_PAGE_SHIFT);
+		u32 offset = (iter.bi_sector & (SECTORS_PER_MULTI_PAGE - 1)) <<
+			     SECTOR_SHIFT;
+		struct bio_vec bv = multi_pages_bio_iter_iovec(bio, iter);
+
+		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_count);
+		bv.bv_len = min_t(u32, bv.bv_len,
+				  ZCOMP_MULTI_PAGES_SIZE - offset);
+
+		if (zram_bvec_read_multi_pages(zram, &bv, index, offset, bio) < 0) {
+			atomic64_inc(&zram->stats.multi_pages_failed_reads);
+			bio->bi_status = BLK_STS_IOERR;
+			break;
+		}
+		flush_dcache_page(bv.bv_page);
+
+		slot_lock(zram, index);
+		mark_slot_accessed(zram, index);
+		slot_unlock(zram, index);
+
+		bio_advance_iter_single(bio, &iter, bv.bv_len);
+	} while (iter.bi_size);
+
+	bio_end_io_acct(bio, start_time);
+	bio_endio(bio);
+}
+
+static void zram_bio_write_multi_pages(struct zram *zram, struct bio *bio)
+{
+	unsigned long start_time = bio_start_io_acct(bio);
+	struct bvec_iter iter = bio->bi_iter;
+
+	do {
+		unsigned long index = zram_multi_pages_head_index(
+			iter.bi_sector >> SECTORS_PER_PAGE_SHIFT);
+		u32 offset = (iter.bi_sector & (SECTORS_PER_MULTI_PAGE - 1)) <<
+			     SECTOR_SHIFT;
+		struct bio_vec bv = multi_pages_bio_iter_iovec(bio, iter);
+
+		bv.bv_len = min_t(u32, bv.bv_len,
+				  ZCOMP_MULTI_PAGES_SIZE - offset);
+
+		atomic64_inc(&zram->stats.zram_bio_write_multi_pages_count);
+		if (zram_bvec_write_multi_pages(zram, &bv, index, offset, bio) < 0) {
+			atomic64_inc(&zram->stats.multi_pages_failed_writes);
+			bio->bi_status = BLK_STS_IOERR;
+			break;
+		}
+
+		slot_lock(zram, index);
+		mark_slot_accessed(zram, index);
+		slot_unlock(zram, index);
+
+		bio_advance_iter_single(bio, &iter, bv.bv_len);
+	} while (iter.bi_size);
+
+	bio_end_io_acct(bio, start_time);
+	bio_endio(bio);
+}
+#else /* CONFIG_ZRAM_MULTI_PAGES */
+static inline bool test_multi_pages_comp(struct zram *zram, struct bio *bio)
+{
+	return false;
+}
+
+static inline bool want_multi_pages_comp(struct zram *zram, struct bio *bio)
+{
+	return false;
+}
+
+static inline void zram_bio_read_multi_pages(struct zram *zram,
+					     struct bio *bio) { }
+static inline void zram_bio_write_multi_pages(struct zram *zram,
+					      struct bio *bio) { }
+#endif
+
 static void zram_bio_read(struct zram *zram, struct bio *bio)
 {
+	if (test_multi_pages_comp(zram, bio)) {
+		zram_bio_read_multi_pages(zram, bio);
+		return;
+	}
+
 	unsigned long start_time = bio_start_io_acct(bio);
 	struct bvec_iter iter = bio->bi_iter;
 
@@ -2756,6 +3123,11 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 
 static void zram_bio_write(struct zram *zram, struct bio *bio)
 {
+	if (want_multi_pages_comp(zram, bio)) {
+		zram_bio_write_multi_pages(zram, bio);
+		return;
+	}
+
 	unsigned long start_time = bio_start_io_acct(bio);
 	struct bvec_iter iter = bio->bi_iter;
 
@@ -2808,6 +3180,9 @@ static void zram_slot_free_notify(struct block_device *bdev,
 				unsigned long index)
 {
 	struct zram *zram;
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	int nr_pages_to_free = 1;
+#endif
 
 	zram = bdev->bd_disk->private_data;
 
@@ -2817,7 +3192,34 @@ static void zram_slot_free_notify(struct block_device *bdev,
 		return;
 	}
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	{
+		int comp_count = __test_multi_pages_comp(zram, index);
+
+		if (comp_count > 1) {
+			clear_slot_flag(zram, index, ZRAM_COMP_MULTI_PAGES);
+			slot_unlock(zram, index);
+			return;
+		}
+
+		if (comp_count == 1) {
+			clear_slot_flag(zram, index, ZRAM_COMP_MULTI_PAGES);
+			slot_unlock(zram, index);
+			index = zram_multi_pages_head_index(index);
+			nr_pages_to_free = ZCOMP_MULTI_PAGES_NR;
+			if (!slot_trylock(zram, index)) {
+				atomic64_inc(&zram->stats.multi_pages_miss_free);
+				return;
+			}
+		}
+	}
+#endif
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	slot_free_npages(zram, index, nr_pages_to_free);
+#else
 	slot_free(zram, index);
+#endif
 	slot_unlock(zram, index);
 }
 
@@ -2991,6 +3393,9 @@ static const struct block_device_operations zram_devops = {
 static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
 static DEVICE_ATTR_RO(debug_stat);
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+static DEVICE_ATTR_RO(multi_pages_debug_stat);
+#endif
 static DEVICE_ATTR_WO(compact);
 static DEVICE_ATTR_RW(disksize);
 static DEVICE_ATTR_RO(initstate);
@@ -3035,6 +3440,9 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
 	&dev_attr_debug_stat.attr,
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	&dev_attr_multi_pages_debug_stat.attr,
+#endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 	&dev_attr_recomp_algorithm.attr,
 	&dev_attr_recompress.attr,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index d64c99b74214..1e3ebfec972e 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -28,6 +28,11 @@
 #define ZRAM_SECTOR_PER_LOGICAL_BLOCK	\
 	(1 << (ZRAM_LOGICAL_BLOCK_SHIFT - SECTOR_SHIFT))
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+#define SECTORS_PER_MULTI_PAGE_SHIFT	(MULTI_PAGE_SHIFT - SECTOR_SHIFT)
+#define SECTORS_PER_MULTI_PAGE		(1 << SECTORS_PER_MULTI_PAGE_SHIFT)
+#endif
+
 /*
  * ZRAM is mainly used for memory efficiency so we want to keep memory
  * footprint small and thus squeeze size and zram pageflags into a flags
@@ -37,7 +42,12 @@
  *
  * We use BUILD_BUG_ON() to make sure that zram pageflags don't overflow.
  */
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + CONFIG_ZSMALLOC_MULTI_PAGES_ORDER + 1)
+#else
 #define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
+#endif
+
 
 /* Only 2 bits are allowed for comp priority index */
 #define ZRAM_COMP_PRIORITY_MASK	0x3
@@ -55,6 +65,10 @@ enum zram_pageflags {
 	ZRAM_COMP_PRIORITY_BIT1, /* First bit of comp priority index */
 	ZRAM_COMP_PRIORITY_BIT2, /* Second bit of comp priority index */
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	ZRAM_COMP_MULTI_PAGES,	/* Compressed by multi-pages */
+#endif
+
 	__NR_ZRAM_PAGEFLAGS,
 };
 
@@ -110,6 +124,15 @@ struct zram_stats {
 	atomic64_t bd_reads;		/* no. of reads from backing device */
 	atomic64_t bd_writes;		/* no. of writes from backing device */
 #endif
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	atomic64_t zram_bio_write_multi_pages_count;
+	atomic64_t zram_bio_read_multi_pages_count;
+	atomic64_t multi_pages_failed_writes;
+	atomic64_t multi_pages_failed_reads;
+	atomic64_t zram_bio_write_multi_pages_partial_count;
+	atomic64_t zram_bio_read_multi_pages_partial_count;
+	atomic64_t multi_pages_miss_free;
+#endif
 };
 
 #ifdef CONFIG_ZRAM_MULTI_COMP
@@ -167,4 +190,24 @@ struct zram {
 	struct dentry *debugfs_dir;
 #endif
 };
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+#define multi_pages_bvec_iter_offset(bvec, iter)				\
+	(mp_bvec_iter_offset((bvec), (iter)) % ZCOMP_MULTI_PAGES_SIZE)
+
+#define multi_pages_bvec_iter_len(bvec, iter)				\
+	min_t(unsigned int, mp_bvec_iter_len((bvec), (iter)),		\
+	      ZCOMP_MULTI_PAGES_SIZE -					\
+	      multi_pages_bvec_iter_offset((bvec), (iter)))
+
+#define multi_pages_bvec_iter_bvec(bvec, iter)				\
+((struct bio_vec) {							\
+	.bv_page	= mp_bvec_iter_page((bvec), (iter)),		\
+	.bv_len		= multi_pages_bvec_iter_len((bvec), (iter)),	\
+	.bv_offset	= multi_pages_bvec_iter_offset((bvec), (iter)),	\
+})
+
+#define multi_pages_bio_iter_iovec(bio, iter)				\
+	multi_pages_bvec_iter_bvec((bio)->bi_io_vec, (iter))
+#endif
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2d83fcc8610d..81d908d6d5a8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1697,7 +1697,8 @@ static struct zs_handle *find_alloced_obj(struct size_class *class,
 	offset += class->size * index;
 
 	while (offset < page_size) {
-		if (obj_allocated(zpdesc, addr + offset, &handle))
+		handle = obj_allocated(zpdesc, addr + offset);
+		if (handle)
 			break;
 
 		offset += class->size;
-- 
2.43.0

