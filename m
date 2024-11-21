Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493951537CE
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227977; cv=none; b=goldh6tjCg+UbowVa5WwgDI9nrizcjdxIRKfuJ6W5GLFXlHGQObLOrs08J4Hs8vr8iB4wrcCeeVZNgnyGutLpExt1oRfkP8w+ly02SzWqFAF01Iu+9eCxtWBNk5UpsdKgs0HkhvmJVx3WsLIE2RbXU/mFLUFJCn+zSWEdBJTsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227977; c=relaxed/simple;
	bh=qG6OTJCMemddpko/GNZEkgbpiDd4aOtsAL+esH98Dys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMONVfIF6xAcwdBVzAZpZ0hQiCDL5F4ABQh2XWsYPoO4YXoYDXUwkv7b1SCfvgD0y8zsYkpTSBwLzH2dwQhGwzT+nEqdDMl8KONJbpAkseWxEdnJ8xtIqLjR08aK++Fvuz9d1GmBsWBAsNtoSTlkDPoDrIVtsfkS6GR+OX7KoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJZB1kJH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJZB1kJH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21271dc4084so14526605ad.2
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732227973; x=1732832773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCNqlqQ4rfs7IHemmBfATy34F1QXfYdj79CZjZxBivg=;
        b=fJZB1kJHKnFkeBYRsSUud02/SGaFpEoq6SYbIbeG34f+Ul4eKQeLfRJW+RD0tEdnEc
         Saa5r+D2Ci7jdlGAqIAw77eHkGhQnPq20XUiriaxfIebYU7hZmGBFG9Nhd/chz1e7GVY
         XtvnakWHNveFMFnviQl9d+O4aUs/TLFQDt2jdpb59isEIq43OypLf6Cd1HU9eFsDK6D0
         IECWiOZT0Cvz/okCwr3bZ6AbgQ46uxDtLMmeuHoPQz9uMEiWT4fZ7KsIoIWWb+3NET/j
         L+wVXBIxMkoIhttQA1eB8k+lKCxQT6CToNM7GrLo+LieFjBvTwCwUK0O+zB1MIop94fo
         ttKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227973; x=1732832773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCNqlqQ4rfs7IHemmBfATy34F1QXfYdj79CZjZxBivg=;
        b=B3Q8mK6cdW7j/GEo4spjFPWyjGJXprNn9e5iX2vcmOE9TA58RHi3ldopBszCWqqG0j
         ta0LUi3Z0BkuQgNlmMzR/HWRhfvROL3qjdqi/qU7mvVm77Y2EqyXETG05AY2k/AQ5gg1
         zmPsnT+j5dF8zochgZWn6CvN/zF2Z5EeQB6XuuSuSCCj6EvVwF910H44lR2MxJ3HCgTx
         Ww8RkN7K8D44+7H6ZBOJjL3L0RvAeOgtlKLf2OFIzABOHvjITd20Ke2+Oo2zPqhJ7VbR
         6R3hvGu8ULoY57cWsN6amWkv4ZgUVYWtI2vxHsgSnf47dUsFfeTfZ3PzOmSHzXAshW2t
         fMZA==
X-Forwarded-Encrypted: i=1; AJvYcCWjhNMA5pvvz4V3WlaTZBcjTYzJjHgQTXmiAo7X3ox/Zp8rW85RyH9FGQouLQdAM5yUEbfD2QGl4nVbzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9/QwpBPp8MWWFi0EClCjg4anF38f7upnsGusj0iOmEgoXYNMe
	KcLk/pR8s2E1y/E10sCMwqfdcHzLz1L6ymPKiD7XsVMhoye+HP1z
X-Gm-Gg: ASbGnctMYqn0BmW+VrlhU5F40TDKE6X6lFHwVxu9rADHgUF6AOr2IglHDW4zt5B5DAy
	VbRVq0TqrW3YMb4JwmP6REZHlu2REmk4zwfzuPEnMiZSvCj/MgyiAbNoQ6H4LUqhw90ojIZhp/y
	EH7/DEblfyUmdZJKfTo5GkPl7qsspLSppcRJlWyjTrjF1Sws8J0dafayO0BBIf/aJGheJHTF37s
	JWj+B2GLt6XKcTOIwtLQMPDQClIrD+AiRhHdO4Us+tLssQfKiyAC8RbG/h/LxOnUKdV3OYT
X-Google-Smtp-Source: AGHT+IEIYvAU6oHpRQ9h3xJVhAtrmO6W7kXx41o4KSLXJIlB4kYtYFzhhJPkt8xEcKZau4F/uTnsCw==
X-Received: by 2002:a17:902:d4cb:b0:212:996:3536 with SMTP id d9443c01a7336-2129f5c3cf0mr8895795ad.10.1732227973295;
        Thu, 21 Nov 2024 14:26:13 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:9d64:b0ba:faf2:680e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba22f4sm3334745ad.100.2024.11.21.14.26.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Nov 2024 14:26:12 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: axboe@kernel.dk,
	bala.seshasayee@linux.intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kanchana.p.sridhar@intel.com,
	kasong@tencent.com,
	linux-block@vger.kernel.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	surenb@google.com,
	terrelln@fb.com,
	usamaarif642@gmail.com,
	v-songbaohua@oppo.com,
	wajdi.k.feghali@intel.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	zhengtangquan@oppo.com,
	zhouchengming@bytedance.com
Subject: [PATCH RFC v3 2/4] zram: support compression at the granularity of multi-pages
Date: Fri, 22 Nov 2024 11:25:19 +1300
Message-Id: <20241121222521.83458-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241121222521.83458-1-21cnbao@gmail.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/block/zram/Kconfig    |   9 +
 drivers/block/zram/zcomp.c    |  17 +-
 drivers/block/zram/zcomp.h    |  12 +-
 drivers/block/zram/zram_drv.c | 449 +++++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h |  45 ++++
 5 files changed, 495 insertions(+), 37 deletions(-)

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
index bb514403e305..44f5b404495a 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -52,6 +52,11 @@ static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 
 static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	unsigned long page_size = ZCOMP_MULTI_PAGES_SIZE;
+#else
+	unsigned long page_size = PAGE_SIZE;
+#endif
 	int ret;
 
 	ret = comp->ops->create_ctx(comp->params, &zstrm->ctx);
@@ -62,7 +67,7 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
-	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
+	zstrm->buffer = vzalloc(2 * page_size);
 	if (!zstrm->buffer) {
 		zcomp_strm_free(comp, zstrm);
 		return -ENOMEM;
@@ -119,13 +124,13 @@ void zcomp_stream_put(struct zcomp *comp)
 }
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
-		   const void *src, unsigned int *dst_len)
+		   const void *src, unsigned int src_len, unsigned int *dst_len)
 {
 	struct zcomp_req req = {
 		.src = src,
 		.dst = zstrm->buffer,
-		.src_len = PAGE_SIZE,
-		.dst_len = 2 * PAGE_SIZE,
+		.src_len = src_len,
+		.dst_len = src_len * 2,
 	};
 	int ret;
 
@@ -136,13 +141,13 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 }
 
 int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
-		     const void *src, unsigned int src_len, void *dst)
+		     const void *src, unsigned int src_len, void *dst, unsigned int dst_len)
 {
 	struct zcomp_req req = {
 		.src = src,
 		.dst = dst,
 		.src_len = src_len,
-		.dst_len = PAGE_SIZE,
+		.dst_len = dst_len,
 	};
 
 	return comp->ops->decompress(comp->params, &zstrm->ctx, &req);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index ad5762813842..471c16be293c 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -30,6 +30,13 @@ struct zcomp_ctx {
 	void *context;
 };
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+#define ZCOMP_MULTI_PAGES_ORDER	(_AC(CONFIG_ZSMALLOC_MULTI_PAGES_ORDER, UL))
+#define ZCOMP_MULTI_PAGES_NR	(1 << ZCOMP_MULTI_PAGES_ORDER)
+#define ZCOMP_MULTI_PAGES_SIZE	(PAGE_SIZE * ZCOMP_MULTI_PAGES_NR)
+#define MULTI_PAGE_SHIFT (ZCOMP_MULTI_PAGES_ORDER + PAGE_SHIFT)
+#endif
+
 struct zcomp_strm {
 	local_lock_t lock;
 	/* compression buffer */
@@ -80,8 +87,9 @@ struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
 void zcomp_stream_put(struct zcomp *comp);
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
-		   const void *src, unsigned int *dst_len);
+		   const void *src, unsigned int src_len, unsigned int *dst_len);
 int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
-		     const void *src, unsigned int src_len, void *dst);
+		     const void *src, unsigned int src_len, void *dst,
+		     unsigned int dst_len);
 
 #endif /* _ZCOMP_H_ */
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6cb7d1e57362..90f87894ff3e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -50,7 +50,7 @@ static unsigned int num_devices = 1;
  * Pages that compress to sizes equals or greater than this are stored
  * uncompressed in memory.
  */
-static size_t huge_class_size;
+static size_t huge_class_size[ZSMALLOC_TYPE_MAX];
 
 static const struct block_device_operations zram_devops;
 
@@ -296,11 +296,11 @@ static inline void zram_fill_page(void *ptr, unsigned long len,
 	memset_l(ptr, value, len / sizeof(unsigned long));
 }
 
-static bool page_same_filled(void *ptr, unsigned long *element)
+static bool page_same_filled(void *ptr, unsigned long *element, unsigned int page_size)
 {
 	unsigned long *page;
 	unsigned long val;
-	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
+	unsigned int pos, last_pos = page_size / sizeof(*page) - 1;
 
 	page = (unsigned long *)ptr;
 	val = page[0];
@@ -1426,13 +1426,40 @@ static ssize_t debug_stat_show(struct device *dev,
 	return ret;
 }
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+static ssize_t multi_pages_debug_stat_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ssize_t ret = 0;
+
+	down_read(&zram->init_lock);
+	ret = scnprintf(buf, PAGE_SIZE,
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
+	up_read(&zram->init_lock);
+
+	return ret;
+}
+#endif
 static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RO(bd_stat);
 #endif
 static DEVICE_ATTR_RO(debug_stat);
-
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+static DEVICE_ATTR_RO(multi_pages_debug_stat);
+#endif
 static void zram_meta_free(struct zram *zram, u64 disksize)
 {
 	size_t num_pages = disksize >> PAGE_SHIFT;
@@ -1449,6 +1476,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
 	size_t num_pages, index;
+	int i;
 
 	num_pages = disksize >> PAGE_SHIFT;
 	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
@@ -1461,7 +1489,10 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		return false;
 	}
 
-	huge_class_size = zs_huge_class_size(zram->mem_pool, 0);
+	for (i = 0; i < ZSMALLOC_TYPE_MAX; i++) {
+		if (!huge_class_size[i])
+			huge_class_size[i] = zs_huge_class_size(zram->mem_pool, i);
+	}
 
 	for (index = 0; index < num_pages; index++)
 		spin_lock_init(&zram->table[index].lock);
@@ -1476,10 +1507,17 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
+	int nr_pages = 1;
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].ac_time = 0;
 #endif
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (zram_test_flag(zram, index, ZRAM_COMP_MULTI_PAGES)) {
+		zram_clear_flag(zram, index, ZRAM_COMP_MULTI_PAGES);
+		nr_pages = ZCOMP_MULTI_PAGES_NR;
+	}
+#endif
 
 	zram_clear_flag(zram, index, ZRAM_IDLE);
 	zram_clear_flag(zram, index, ZRAM_INCOMPRESSIBLE);
@@ -1503,7 +1541,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 	 */
 	if (zram_test_flag(zram, index, ZRAM_SAME)) {
 		zram_clear_flag(zram, index, ZRAM_SAME);
-		atomic64_dec(&zram->stats.same_pages);
+		atomic64_sub(nr_pages, &zram->stats.same_pages);
 		goto out;
 	}
 
@@ -1516,7 +1554,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 	atomic64_sub(zram_get_obj_size(zram, index),
 		     &zram->stats.compr_data_size);
 out:
-	atomic64_dec(&zram->stats.pages_stored);
+	atomic64_sub(nr_pages, &zram->stats.pages_stored);
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
 }
@@ -1526,7 +1564,7 @@ static void zram_free_page(struct zram *zram, size_t index)
  * Corresponding ZRAM slot should be locked.
  */
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
-				 u32 index)
+				 u32 index, enum zsmalloc_type zs_type)
 {
 	struct zcomp_strm *zstrm;
 	unsigned long handle;
@@ -1534,6 +1572,12 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 	void *src, *dst;
 	u32 prio;
 	int ret;
+	unsigned long page_size = PAGE_SIZE;
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (zs_type == ZSMALLOC_TYPE_MULTI_PAGES)
+		page_size = ZCOMP_MULTI_PAGES_SIZE;
+#endif
 
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
@@ -1542,28 +1586,28 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 		value = handle ? zram_get_element(zram, index) : 0;
 		mem = kmap_local_page(page);
-		zram_fill_page(mem, PAGE_SIZE, value);
+		zram_fill_page(mem, page_size, value);
 		kunmap_local(mem);
 		return 0;
 	}
 
 	size = zram_get_obj_size(zram, index);
 
-	if (size != PAGE_SIZE) {
+	if (size != page_size) {
 		prio = zram_get_priority(zram, index);
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 	}
 
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
-	if (size == PAGE_SIZE) {
+	if (size == page_size) {
 		dst = kmap_local_page(page);
-		copy_page(dst, src);
+		memcpy(dst, src, page_size);
 		kunmap_local(dst);
 		ret = 0;
 	} else {
 		dst = kmap_local_page(page);
 		ret = zcomp_decompress(zram->comps[prio], zstrm,
-				       src, size, dst);
+				       src, size, dst, page_size);
 		kunmap_local(dst);
 		zcomp_stream_put(zram->comps[prio]);
 	}
@@ -1579,7 +1623,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 	zram_slot_lock(zram, index);
 	if (!zram_test_flag(zram, index, ZRAM_WB)) {
 		/* Slot should be locked through out the function call */
-		ret = zram_read_from_zspool(zram, page, index);
+		ret = zram_read_from_zspool(zram, page, index, ZSMALLOC_TYPE_BASEPAGE);
 		zram_slot_unlock(zram, index);
 	} else {
 		/*
@@ -1636,13 +1680,24 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
+	unsigned long page_size = PAGE_SIZE;
+	int huge_class_idx = ZSMALLOC_TYPE_BASEPAGE;
+	int nr_pages = 1;
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (folio_size(page_folio(page)) >= ZCOMP_MULTI_PAGES_SIZE) {
+		page_size = ZCOMP_MULTI_PAGES_SIZE;
+		huge_class_idx = ZSMALLOC_TYPE_MULTI_PAGES;
+		nr_pages = ZCOMP_MULTI_PAGES_NR;
+	}
+#endif
 
 	mem = kmap_local_page(page);
-	if (page_same_filled(mem, &element)) {
+	if (page_same_filled(mem, &element, page_size)) {
 		kunmap_local(mem);
 		/* Free memory associated with this sector now. */
 		flags = ZRAM_SAME;
-		atomic64_inc(&zram->stats.same_pages);
+		atomic64_add(nr_pages, &zram->stats.same_pages);
 		goto out;
 	}
 	kunmap_local(mem);
@@ -1651,7 +1706,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	src = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
-			     src, &comp_len);
+			     src, page_size, &comp_len);
 	kunmap_local(src);
 
 	if (unlikely(ret)) {
@@ -1661,8 +1716,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return ret;
 	}
 
-	if (comp_len >= huge_class_size)
-		comp_len = PAGE_SIZE;
+	if (comp_len >= huge_class_size[huge_class_idx])
+		comp_len = page_size;
 	/*
 	 * handle allocation has 2 paths:
 	 * a) fast path is executed with preemption disabled (for
@@ -1691,7 +1746,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		if (IS_ERR_VALUE(handle))
 			return PTR_ERR((void *)handle);
 
-		if (comp_len != PAGE_SIZE)
+		if (comp_len != page_size)
 			goto compress_again;
 		/*
 		 * If the page is not compressible, you need to acquire the
@@ -1715,10 +1770,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	src = zstrm->buffer;
-	if (comp_len == PAGE_SIZE)
+	if (comp_len == page_size)
 		src = kmap_local_page(page);
 	memcpy(dst, src, comp_len);
-	if (comp_len == PAGE_SIZE)
+	if (comp_len == page_size)
 		kunmap_local(src);
 
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
@@ -1732,7 +1787,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zram_slot_lock(zram, index);
 	zram_free_page(zram, index);
 
-	if (comp_len == PAGE_SIZE) {
+	if (comp_len == page_size) {
 		zram_set_flag(zram, index, ZRAM_HUGE);
 		atomic64_inc(&zram->stats.huge_pages);
 		atomic64_inc(&zram->stats.huge_pages_since);
@@ -1745,10 +1800,19 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		zram_set_handle(zram, index, handle);
 		zram_set_obj_size(zram, index, comp_len);
 	}
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (page_size == ZCOMP_MULTI_PAGES_SIZE) {
+		/* Set multi-pages compression flag for free or overwriting */
+		for (int i = 0; i < ZCOMP_MULTI_PAGES_NR; i++)
+			zram_set_flag(zram, index + i, ZRAM_COMP_MULTI_PAGES);
+	}
+#endif
+
 	zram_slot_unlock(zram, index);
 
 	/* Update stats */
-	atomic64_inc(&zram->stats.pages_stored);
+	atomic64_add(nr_pages, &zram->stats.pages_stored);
 	return ret;
 }
 
@@ -1861,7 +1925,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	if (comp_len_old < threshold)
 		return 0;
 
-	ret = zram_read_from_zspool(zram, page, index);
+	ret = zram_read_from_zspool(zram, page, index, ZSMALLOC_TYPE_BASEPAGE);
 	if (ret)
 		return ret;
 
@@ -1892,7 +1956,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
 		ret = zcomp_compress(zram->comps[prio], zstrm,
-				     src, &comp_len_new);
+				     src, PAGE_SIZE, &comp_len_new);
 		kunmap_local(src);
 
 		if (ret) {
@@ -2056,7 +2120,7 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
-	if (threshold >= huge_class_size)
+	if (threshold >= huge_class_size[ZSMALLOC_TYPE_BASEPAGE])
 		return -EINVAL;
 
 	down_read(&zram->init_lock);
@@ -2178,7 +2242,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 	bio_endio(bio);
 }
 
-static void zram_bio_read(struct zram *zram, struct bio *bio)
+static void zram_bio_read_page(struct zram *zram, struct bio *bio)
 {
 	unsigned long start_time = bio_start_io_acct(bio);
 	struct bvec_iter iter = bio->bi_iter;
@@ -2209,7 +2273,7 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 	bio_endio(bio);
 }
 
-static void zram_bio_write(struct zram *zram, struct bio *bio)
+static void zram_bio_write_page(struct zram *zram, struct bio *bio)
 {
 	unsigned long start_time = bio_start_io_acct(bio);
 	struct bvec_iter iter = bio->bi_iter;
@@ -2239,6 +2303,311 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 	bio_endio(bio);
 }
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+
+/*
+ * The index is compress by multi-pages when any index ZRAM_COMP_MULTI_PAGES flag is set.
+ * Return: 0	: compress by page
+ *         > 0	: compress by multi-pages
+ */
+static inline int __test_multi_pages_comp(struct zram *zram, u32 index)
+{
+	int i;
+	int count = 0;
+	int head_index = index & ~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
+
+	for (i = 0; i < ZCOMP_MULTI_PAGES_NR; i++) {
+		if (zram_test_flag(zram, head_index + i, ZRAM_COMP_MULTI_PAGES))
+			count++;
+	}
+
+	return count;
+}
+
+static inline bool want_multi_pages_comp(struct zram *zram, struct bio *bio)
+{
+	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+
+	if (bio->bi_io_vec->bv_len >= ZCOMP_MULTI_PAGES_SIZE)
+		return true;
+
+	zram_slot_lock(zram, index);
+	if (__test_multi_pages_comp(zram, index)) {
+		zram_slot_unlock(zram, index);
+		return true;
+	}
+	zram_slot_unlock(zram, index);
+
+	return false;
+}
+
+static inline bool test_multi_pages_comp(struct zram *zram, struct bio *bio)
+{
+	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+
+	return !!__test_multi_pages_comp(zram, index);
+}
+
+static inline bool is_multi_pages_partial_io(struct bio_vec *bvec)
+{
+	return bvec->bv_len != ZCOMP_MULTI_PAGES_SIZE;
+}
+
+static int zram_read_multi_pages(struct zram *zram, struct page *page, u32 index,
+			  struct bio *parent)
+{
+	int ret;
+
+	zram_slot_lock(zram, index);
+	if (!zram_test_flag(zram, index, ZRAM_WB)) {
+		/* Slot should be locked through out the function call */
+		ret = zram_read_from_zspool(zram, page, index, ZSMALLOC_TYPE_MULTI_PAGES);
+		zram_slot_unlock(zram, index);
+	} else {
+		/*
+		 * The slot should be unlocked before reading from the backing
+		 * device.
+		 */
+		zram_slot_unlock(zram, index);
+
+		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
+				     parent);
+	}
+
+	/* Should NEVER happen. Return bio error if it does. */
+	if (WARN_ON(ret < 0))
+		pr_err("Decompression failed! err=%d, page=%u\n", ret, index);
+
+	return ret;
+}
+
+static int zram_read_partial_from_zspool(struct zram *zram, struct page *page,
+				 u32 index, enum zsmalloc_type zs_type, int offset)
+{
+	struct zcomp_strm *zstrm;
+	unsigned long handle;
+	unsigned int size;
+	void *src, *dst;
+	u32 prio;
+	int ret;
+	unsigned long page_size = PAGE_SIZE;
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	if (zs_type == ZSMALLOC_TYPE_MULTI_PAGES)
+		page_size = ZCOMP_MULTI_PAGES_SIZE;
+#endif
+
+	handle = zram_get_handle(zram, index);
+	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
+		unsigned long value;
+		void *mem;
+
+		value = handle ? zram_get_element(zram, index) : 0;
+		mem = kmap_local_page(page);
+		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
+		zram_fill_page(mem, PAGE_SIZE, value);
+		kunmap_local(mem);
+		return 0;
+	}
+
+	size = zram_get_obj_size(zram, index);
+
+	if (size != page_size) {
+		prio = zram_get_priority(zram, index);
+		zstrm = zcomp_stream_get(zram->comps[prio]);
+	}
+
+	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	if (size == page_size) {
+		dst = kmap_local_page(page);
+		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
+		memcpy(dst, src + offset, PAGE_SIZE);
+		kunmap_local(dst);
+		ret = 0;
+	} else {
+		dst = kmap_local_page(page);
+		/* use zstrm->buffer to store decompress thp and copy page to dst */
+		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
+		ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, zstrm->buffer, page_size);
+		memcpy(dst, zstrm->buffer + offset, PAGE_SIZE);
+		kunmap_local(dst);
+		zcomp_stream_put(zram->comps[prio]);
+	}
+	zs_unmap_object(zram->mem_pool, handle);
+	return ret;
+}
+
+/*
+ * Use a temporary buffer to decompress the page, as the decompressor
+ * always expects a full page for the output.
+ */
+static int zram_bvec_read_multi_pages_partial(struct zram *zram, struct page *page, u32 index,
+			  struct bio *parent, int offset)
+{
+	int ret;
+
+	zram_slot_lock(zram, index);
+	if (!zram_test_flag(zram, index, ZRAM_WB)) {
+		/* Slot should be locked through out the function call */
+		ret = zram_read_partial_from_zspool(zram, page, index, ZSMALLOC_TYPE_MULTI_PAGES, offset);
+		zram_slot_unlock(zram, index);
+	} else {
+		/*
+		 * The slot should be unlocked before reading from the backing
+		 * device.
+		 */
+		zram_slot_unlock(zram, index);
+
+		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
+				     parent);
+	}
+
+	/* Should NEVER happen. Return bio error if it does. */
+	if (WARN_ON(ret < 0))
+		pr_err("Decompression failed! err=%d, page=%u offset=%d\n", ret, index, offset);
+
+	return ret;
+}
+
+static int zram_bvec_read_multi_pages(struct zram *zram, struct bio_vec *bvec,
+			  u32 index, int offset, struct bio *bio)
+{
+	if (is_multi_pages_partial_io(bvec))
+		return zram_bvec_read_multi_pages_partial(zram, bvec->bv_page, index, bio, offset);
+	return zram_read_multi_pages(zram, bvec->bv_page, index, bio);
+}
+
+/*
+ * This is a partial IO. Read the full page before writing the changes.
+ */
+static int zram_bvec_write_multi_pages_partial(struct zram *zram, struct bio_vec *bvec,
+				   u32 index, int offset, struct bio *bio)
+{
+	struct page *page = alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MULTI_PAGES_ORDER);
+	int ret;
+	void *src, *dst;
+
+	if (!page)
+		return -ENOMEM;
+
+	ret = zram_read_multi_pages(zram, page, index, bio);
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
+	__free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
+	return ret;
+}
+
+static int zram_bvec_write_multi_pages(struct zram *zram, struct bio_vec *bvec,
+			   u32 index, int offset, struct bio *bio)
+{
+	if (is_multi_pages_partial_io(bvec))
+		return zram_bvec_write_multi_pages_partial(zram, bvec, index, offset, bio);
+	return zram_write_page(zram, bvec->bv_page, index);
+}
+
+
+static void zram_bio_read_multi_pages(struct zram *zram, struct bio *bio)
+{
+	unsigned long start_time = bio_start_io_acct(bio);
+	struct bvec_iter iter = bio->bi_iter;
+
+	do {
+		/* Use head index, and other indexes are used as offset */
+		u32 index = (iter.bi_sector >> SECTORS_PER_PAGE_SHIFT) &
+				~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
+		u32 offset = (iter.bi_sector & (SECTORS_PER_MULTI_PAGE - 1)) << SECTOR_SHIFT;
+		struct bio_vec bv = multi_pages_bio_iter_iovec(bio, iter);
+
+		atomic64_add(1, &zram->stats.zram_bio_read_multi_pages_count);
+		bv.bv_len = min_t(u32, bv.bv_len, ZCOMP_MULTI_PAGES_SIZE - offset);
+
+		if (zram_bvec_read_multi_pages(zram, &bv, index, offset, bio) < 0) {
+			atomic64_inc(&zram->stats.multi_pages_failed_reads);
+			bio->bi_status = BLK_STS_IOERR;
+			break;
+		}
+		flush_dcache_page(bv.bv_page);
+
+		zram_slot_lock(zram, index);
+		zram_accessed(zram, index);
+		zram_slot_unlock(zram, index);
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
+		/* Use head index, and other indexes are used as offset */
+		u32 index = (iter.bi_sector >> SECTORS_PER_PAGE_SHIFT) &
+				~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
+		u32 offset = (iter.bi_sector & (SECTORS_PER_MULTI_PAGE - 1)) << SECTOR_SHIFT;
+		struct bio_vec bv = multi_pages_bio_iter_iovec(bio, iter);
+
+		bv.bv_len = min_t(u32, bv.bv_len, ZCOMP_MULTI_PAGES_SIZE - offset);
+
+		atomic64_add(1, &zram->stats.zram_bio_write_multi_pages_count);
+		if (zram_bvec_write_multi_pages(zram, &bv, index, offset, bio) < 0) {
+			atomic64_inc(&zram->stats.multi_pages_failed_writes);
+			bio->bi_status = BLK_STS_IOERR;
+			break;
+		}
+
+		zram_slot_lock(zram, index);
+		zram_accessed(zram, index);
+		zram_slot_unlock(zram, index);
+
+		bio_advance_iter_single(bio, &iter, bv.bv_len);
+	} while (iter.bi_size);
+
+	bio_end_io_acct(bio, start_time);
+	bio_endio(bio);
+}
+#else
+static inline bool test_multi_pages_comp(struct zram *zram, struct bio *bio)
+{
+	return false;
+}
+
+static inline bool want_multi_pages_comp(struct zram *zram, struct bio *bio)
+{
+	return false;
+}
+static void zram_bio_read_multi_pages(struct zram *zram, struct bio *bio) {}
+static void zram_bio_write_multi_pages(struct zram *zram, struct bio *bio) {}
+#endif
+
+static void zram_bio_read(struct zram *zram, struct bio *bio)
+{
+	if (test_multi_pages_comp(zram, bio))
+		zram_bio_read_multi_pages(zram, bio);
+	else
+		zram_bio_read_page(zram, bio);
+}
+
+static void zram_bio_write(struct zram *zram, struct bio *bio)
+{
+	if (want_multi_pages_comp(zram, bio))
+		zram_bio_write_multi_pages(zram, bio);
+	else
+		zram_bio_write_page(zram, bio);
+}
+
 /*
  * Handler function for all zram I/O requests.
  */
@@ -2276,6 +2645,25 @@ static void zram_slot_free_notify(struct block_device *bdev,
 		return;
 	}
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	int comp_count = __test_multi_pages_comp(zram, index);
+
+	if (comp_count > 1) {
+		zram_clear_flag(zram, index, ZRAM_COMP_MULTI_PAGES);
+		zram_slot_unlock(zram, index);
+		return;
+	} else if (comp_count == 1) {
+		zram_clear_flag(zram, index, ZRAM_COMP_MULTI_PAGES);
+		zram_slot_unlock(zram, index);
+		/*only need to free head index*/
+		index &= ~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
+		if (!zram_slot_trylock(zram, index)) {
+			atomic64_inc(&zram->stats.multi_pages_miss_free);
+			return;
+		}
+	}
+#endif
+
 	zram_free_page(zram, index);
 	zram_slot_unlock(zram, index);
 }
@@ -2493,6 +2881,9 @@ static struct attribute *zram_disk_attrs[] = {
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	&dev_attr_multi_pages_debug_stat.attr,
+#endif
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_bd_stat.attr,
 #endif
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 134be414e210..ac4eb4f39cb7 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -28,6 +28,10 @@
 #define ZRAM_SECTOR_PER_LOGICAL_BLOCK	\
 	(1 << (ZRAM_LOGICAL_BLOCK_SHIFT - SECTOR_SHIFT))
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+#define SECTORS_PER_MULTI_PAGE_SHIFT	(MULTI_PAGE_SHIFT - SECTOR_SHIFT)
+#define SECTORS_PER_MULTI_PAGE	(1 << SECTORS_PER_MULTI_PAGE_SHIFT)
+#endif
 
 /*
  * ZRAM is mainly used for memory efficiency so we want to keep memory
@@ -38,7 +42,15 @@
  *
  * We use BUILD_BUG_ON() to make sure that zram pageflags don't overflow.
  */
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+#define ZRAM_FLAG_SHIFT (PAGE_SHIFT +  \
+	CONFIG_ZSMALLOC_MULTI_PAGES_ORDER + 1)
+#else
 #define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
+#endif
+
+#define ENABLE_HUGEPAGE_ZRAM_DEBUG 1
 
 /* Only 2 bits are allowed for comp priority index */
 #define ZRAM_COMP_PRIORITY_MASK	0x3
@@ -55,6 +67,10 @@ enum zram_pageflags {
 	ZRAM_COMP_PRIORITY_BIT1, /* First bit of comp priority index */
 	ZRAM_COMP_PRIORITY_BIT2, /* Second bit of comp priority index */
 
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+	ZRAM_COMP_MULTI_PAGES,	/* Compressed by multi-pages */
+#endif
+
 	__NR_ZRAM_PAGEFLAGS,
 };
 
@@ -90,6 +106,16 @@ struct zram_stats {
 	atomic64_t bd_reads;		/* no. of reads from backing device */
 	atomic64_t bd_writes;		/* no. of writes from backing device */
 #endif
+
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
@@ -141,4 +167,23 @@ struct zram {
 #endif
 	atomic_t pp_in_progress;
 };
+
+#ifdef CONFIG_ZRAM_MULTI_PAGES
+ #define multi_pages_bvec_iter_offset(bvec, iter)				\
+	(mp_bvec_iter_offset((bvec), (iter)) % ZCOMP_MULTI_PAGES_SIZE)
+
+#define multi_pages_bvec_iter_len(bvec, iter)				\
+	min_t(unsigned int, mp_bvec_iter_len((bvec), (iter)),		\
+	      ZCOMP_MULTI_PAGES_SIZE - bvec_iter_offset((bvec), (iter)))
+
+#define multi_pages_bvec_iter_bvec(bvec, iter)				\
+((struct bio_vec) {						\
+	.bv_page	= bvec_iter_page((bvec), (iter)),	\
+	.bv_len		= multi_pages_bvec_iter_len((bvec), (iter)),	\
+	.bv_offset	= multi_pages_bvec_iter_offset((bvec), (iter)),	\
+})
+
+#define multi_pages_bio_iter_iovec(bio, iter)				\
+	multi_pages_bvec_iter_bvec((bio)->bi_io_vec, (iter))
+#endif
 #endif
-- 
2.39.3 (Apple Git-146)

