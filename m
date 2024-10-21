Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C31E3766
	for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553348; cv=none; b=P5zKpyj5+yfz5m5o32KfjmvhtDfOfpb/A/k+JJiKGv0HRpd+vBI/x+WsiwhEgj5/nWEtA5ZKi6aLBR1NIknek8zB3+J+99hhFmCUXPDikdxlGcTA0hXawpSlxYNUKYi4+EPxVMOeg1Je2V6tRAMVX2rMuEu7oXIBYvwqLqX1siQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553348; c=relaxed/simple;
	bh=0JLEX1bPWX8UQCbX23oDDmNcHpZv0IquPC6MyiyfZDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ugIoSYiDk6y5gfxiVPukkeurgmNHSVfhI4Cs9MlnmsRWhCnKo7Mvy+hpz4La0uH+vk82ZOTfyoTbWeC+LECaTiJDp1brp0PK/VM2gX8tUcKsNyy2i+YQnHUZguZhW7NKsqbzSCCqY9fQfygOfdadq1mikflsDYQHgqq2P5oQnCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c96fJR5B; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c96fJR5B"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cd76c513cso42034205ad.3
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729553346; x=1730158146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUAiv6wN/81E/YlXADlpRWhNGOrS/9vE12E9m8dNzzM=;
        b=c96fJR5BRX3tOthnQBV9TTs+SmkuUtvWKmi2YU+JUZQRwmanaPaYWaW4UgCs9Se+G2
         nZpIeAo0VKQ3jD4Q89DX4uA9GvqEEEdUHozs/2gc6OTdNhSs0yhYXZxCFiqXqAuL/JJG
         rPPy/NAZTYsGCYqVjve9dUsqqMyImQGm21Vsl9hK0ethGETdOGAd8dkSCr5VQbQvo38X
         JluKz7bKFCMas13yJ7K2AY2wg/9doG1YLA0mbbudUK25wvLvXbEzywJRp+3vUDprP1Qx
         ot6OKm6EtS8pbBQmOEySyIWnfioRLAOZaPPYRyvN1cNdxubuTzyXc0xYzMH257lkBT92
         lMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553346; x=1730158146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUAiv6wN/81E/YlXADlpRWhNGOrS/9vE12E9m8dNzzM=;
        b=S82ombCdKAtUqwEGg/i7COVDUFBwJpeNhn/Sq2kpBqBSBwfjIjvTSDllhgvzSIZMod
         eZIyKjwdm8A4YvHB/TPCVk28yppmY2DMupo9CUA1yprdy24EE/F8ts1ZRoxgip1X1n7o
         wIyV2R7XKtA84ncsdZaNWCelQ5rTqO2lFX5qAdA3/K7t/AnhX0zmXfCTbmt3qu9by749
         d+gs2fyMYRMHwYdCwLsAFhckl9mSFyrv1kiiWrXpDY+ZjBVItW979Yq3FIxERk7ktmiW
         g6GhN2MMJY1W3O2jcTvQ9lXk4xKB1q1gZ2/iekcb5MZk6xy/kgrvd1DFCYLu7JspC963
         nlxA==
X-Forwarded-Encrypted: i=1; AJvYcCWxEM5ymJ/p7idAelDKDcOFvtIIpI9iHXu0jTfsrUDOUJZNHycQkNLUaqcX569CxlDYqF2JmRuQThD2ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63AoBdC2fG8zNw8DJrxAe0mzdFi0CWErwpdVc0v9C++v52w8E
	j1dO6Vew/6JfmsJSqqGTsQYqVUGlmmyykAs8h9Y3G6sQS7PrVaY/
X-Google-Smtp-Source: AGHT+IEeDf+kvkUnoUvQ8TqYMN9Tjypkh9gNOW8Yihwq89sZh9BZIQ/WH47yZrSrK4dIgrBrTtAZwQ==
X-Received: by 2002:a17:903:2451:b0:20c:b9ca:c12d with SMTP id d9443c01a7336-20e9492f9e5mr19931465ad.38.1729553345425;
        Mon, 21 Oct 2024 16:29:05 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:f099:51d6:8aba:6ce3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de3fasm31431695ad.196.2024.10.21.16.28.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Oct 2024 16:29:05 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	hannes@cmpxchg.org,
	kanchana.p.sridhar@intel.com,
	kasong@tencent.com,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
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
	bala.seshasayee@linux.intel.com
Subject: [PATCH RFC 2/2] zram: support compression at the granularity of multi-pages
Date: Tue, 22 Oct 2024 12:28:52 +1300
Message-Id: <20241021232852.4061-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240327214816.31191-3-21cnbao@gmail.com>
References: <20240327214816.31191-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Tangquan Zheng <zhengtangquan@oppo.com>
> 
> Currently, when a large folio with nr_pages is submitted to zram, it is
> divided into nr_pages parts for compression and storage individually.
> By transitioning to a higher granularity, we can notably enhance
> compression rates while simultaneously reducing CPU consumption.
> 
> This patch introduces the capability for large folios to be divided
> based on the granularity specified by ZSMALLOC_MULTI_PAGES_ORDER, which
> defaults to 4. For instance, large folios smaller than 64KiB will continue
> to be compressed at a 4KiB granularity. However, for folios sized at
> 128KiB, compression will occur in two 64KiB multi-pages.
> 
> This modification will notably reduce CPU consumption and enhance
> compression ratios. The following data illustrates the time and
> compressed data for typical anonymous pages gathered from Android
> phones.
> 
> granularity   orig_data_size   compr_data_size   time(us)
> 4KiB-zstd      1048576000       246876055        50259962
> 64KiB-zstd     1048576000       199763892        18330605
> 
> We observe a precisely similar reduction in time required for decompressing
> a 64KiB block compared to decompressing 16 * 4KiB blocks.
> 
> Signed-off-by: Tangquan Zheng <zhengtangquan@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Since some people are using our patches and occasionally encountering
crashes (reported to me privately, not on the mailing list), I'm sharing
these fixes now while we finalize v2, which will be sent shortly:

> ---
>  drivers/block/zram/Kconfig    |   9 +
>  drivers/block/zram/zcomp.c    |  23 ++-
>  drivers/block/zram/zcomp.h    |  12 +-
>  drivers/block/zram/zram_drv.c | 372 +++++++++++++++++++++++++++++++---
>  drivers/block/zram/zram_drv.h |  21 ++
>  5 files changed, 399 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index 7b29cce60ab2..c8b44dd30d0f 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -96,3 +96,12 @@ config ZRAM_MULTI_COMP
>  	  re-compress pages using a potentially slower but more effective
>  	  compression algorithm. Note, that IDLE page recompression
>  	  requires ZRAM_TRACK_ENTRY_ACTIME.
> +
> +config ZRAM_MULTI_PAGES
> +	bool "Enable multiple pages compression and decompression"
> +	depends on ZRAM && ZSMALLOC_MULTI_PAGES
> +	help
> +	  Initially, zram divided large folios into blocks of nr_pages, each sized
> +	  equal to PAGE_SIZE, for compression. This option fine-tunes zram to
> +	  improve compression granularity by dividing large folios into larger
> +	  parts defined by the configuration option ZSMALLOC_MULTI_PAGES_ORDER.
> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index 8237b08c49d8..ff6df838c066 100644
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -12,7 +12,6 @@
>  #include <linux/cpu.h>
>  #include <linux/crypto.h>
>  #include <linux/vmalloc.h>
> -
>  #include "zcomp.h"
>  
>  static const char * const backends[] = {
> @@ -50,11 +49,16 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
>  static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
>  {
>  	zstrm->tfm = crypto_alloc_comp(comp->name, 0, 0);
> +	unsigned long page_size = PAGE_SIZE;
> +
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +	page_size = ZCOMP_MULTI_PAGES_SIZE;
> +#endif
>  	/*
>  	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
>  	 * case when compressed size is larger than the original one
>  	 */
> -	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
> +	zstrm->buffer = vzalloc(2 * page_size);
>  	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
>  		zcomp_strm_free(zstrm);
>  		return -ENOMEM;
> @@ -115,8 +119,8 @@ void zcomp_stream_put(struct zcomp *comp)
>  	local_unlock(&comp->stream->lock);
>  }
>  
> -int zcomp_compress(struct zcomp_strm *zstrm,
> -		const void *src, unsigned int *dst_len)
> +int zcomp_compress(struct zcomp_strm *zstrm, const void *src, unsigned int src_len,
> +		   unsigned int *dst_len)
>  {
>  	/*
>  	 * Our dst memory (zstrm->buffer) is always `2 * PAGE_SIZE' sized
> @@ -132,18 +136,17 @@ int zcomp_compress(struct zcomp_strm *zstrm,
>  	 * the dst buffer, zram_drv will take care of the fact that
>  	 * compressed buffer is too big.
>  	 */
> -	*dst_len = PAGE_SIZE * 2;
> +
> +	*dst_len = src_len * 2;
>  
>  	return crypto_comp_compress(zstrm->tfm,
> -			src, PAGE_SIZE,
> +			src, src_len,
>  			zstrm->buffer, dst_len);
>  }
>  
> -int zcomp_decompress(struct zcomp_strm *zstrm,
> -		const void *src, unsigned int src_len, void *dst)
> +int zcomp_decompress(struct zcomp_strm *zstrm, const void *src, unsigned int src_len,
> +		     void *dst, unsigned int dst_len)
>  {
> -	unsigned int dst_len = PAGE_SIZE;
> -
>  	return crypto_comp_decompress(zstrm->tfm,
>  			src, src_len,
>  			dst, &dst_len);
> diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
> index e9fe63da0e9b..6788d1b2c30f 100644
> --- a/drivers/block/zram/zcomp.h
> +++ b/drivers/block/zram/zcomp.h
> @@ -7,6 +7,12 @@
>  #define _ZCOMP_H_
>  #include <linux/local_lock.h>
>  
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +#define ZCOMP_MULTI_PAGES_ORDER	(_AC(CONFIG_ZSMALLOC_MULTI_PAGES_ORDER, UL))
> +#define ZCOMP_MULTI_PAGES_NR	(1 << ZCOMP_MULTI_PAGES_ORDER)
> +#define ZCOMP_MULTI_PAGES_SIZE	(PAGE_SIZE * ZCOMP_MULTI_PAGES_NR)
> +#endif
> +
>  struct zcomp_strm {
>  	/* The members ->buffer and ->tfm are protected by ->lock. */
>  	local_lock_t lock;
> @@ -34,9 +40,9 @@ struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
>  void zcomp_stream_put(struct zcomp *comp);
>  
>  int zcomp_compress(struct zcomp_strm *zstrm,
> -		const void *src, unsigned int *dst_len);
> +		const void *src, unsigned int src_len, unsigned int *dst_len);
>  
>  int zcomp_decompress(struct zcomp_strm *zstrm,
> -		const void *src, unsigned int src_len, void *dst);
> -
> +		const void *src, unsigned int src_len, void *dst, unsigned int dst_len);
> +bool zcomp_set_max_streams(struct zcomp *comp, int num_strm);
>  #endif /* _ZCOMP_H_ */
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index f0639df6cd18..0d7b9efd4eb4 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -49,7 +49,7 @@ static unsigned int num_devices = 1;
>   * Pages that compress to sizes equals or greater than this are stored
>   * uncompressed in memory.
>   */
> -static size_t huge_class_size;
> +static size_t huge_class_size[ZSMALLOC_TYPE_MAX];
>  
>  static const struct block_device_operations zram_devops;
>  
> @@ -201,11 +201,11 @@ static inline void zram_fill_page(void *ptr, unsigned long len,
>  	memset_l(ptr, value, len / sizeof(unsigned long));
>  }
>  
> -static bool page_same_filled(void *ptr, unsigned long *element)
> +static bool page_same_filled(void *ptr, unsigned long *element, unsigned int page_size)
>  {
>  	unsigned long *page;
>  	unsigned long val;
> -	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
> +	unsigned int pos, last_pos = page_size / sizeof(*page) - 1;
>  
>  	page = (unsigned long *)ptr;
>  	val = page[0];
> @@ -1204,13 +1204,40 @@ static ssize_t debug_stat_show(struct device *dev,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +static ssize_t multi_pages_debug_stat_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	ssize_t ret = 0;
> +
> +	down_read(&zram->init_lock);
> +	ret = scnprintf(buf, PAGE_SIZE,
> +			"zram_bio write/read multi_pages count:%8llu %8llu\n"
> +			"zram_bio failed write/read multi_pages count%8llu %8llu\n"
> +			"zram_bio partial write/read multi_pages count%8llu %8llu\n"
> +			"multi_pages_miss_free %8llu\n",
> +			(u64)atomic64_read(&zram->stats.zram_bio_write_multi_pages_count),
> +			(u64)atomic64_read(&zram->stats.zram_bio_read_multi_pages_count),
> +			(u64)atomic64_read(&zram->stats.multi_pages_failed_writes),
> +			(u64)atomic64_read(&zram->stats.multi_pages_failed_reads),
> +			(u64)atomic64_read(&zram->stats.zram_bio_write_multi_pages_partial_count),
> +			(u64)atomic64_read(&zram->stats.zram_bio_read_multi_pages_partial_count),
> +			(u64)atomic64_read(&zram->stats.multi_pages_miss_free));
> +	up_read(&zram->init_lock);
> +
> +	return ret;
> +}
> +#endif
>  static DEVICE_ATTR_RO(io_stat);
>  static DEVICE_ATTR_RO(mm_stat);
>  #ifdef CONFIG_ZRAM_WRITEBACK
>  static DEVICE_ATTR_RO(bd_stat);
>  #endif
>  static DEVICE_ATTR_RO(debug_stat);
> -
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +static DEVICE_ATTR_RO(multi_pages_debug_stat);
> +#endif
>  static void zram_meta_free(struct zram *zram, u64 disksize)
>  {
>  	size_t num_pages = disksize >> PAGE_SHIFT;
> @@ -1227,6 +1254,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
>  static bool zram_meta_alloc(struct zram *zram, u64 disksize)
>  {
>  	size_t num_pages;
> +	int i;
>  
>  	num_pages = disksize >> PAGE_SHIFT;
>  	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
> @@ -1239,8 +1267,11 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
>  		return false;
>  	}
>  
> -	if (!huge_class_size)
> -		huge_class_size = zs_huge_class_size(zram->mem_pool);
> +	for (i = 0; i < ZSMALLOC_TYPE_MAX; i++) {
> +		if (!huge_class_size[i])
> +			huge_class_size[i] = zs_huge_class_size(zram->mem_pool, i);
> +	}
> +
>  	return true;
>  }
>  
> @@ -1306,7 +1337,7 @@ static void zram_free_page(struct zram *zram, size_t index)
>   * Corresponding ZRAM slot should be locked.
>   */
>  static int zram_read_from_zspool(struct zram *zram, struct page *page,
> -				 u32 index)
> +				 u32 index, enum zsmalloc_type zs_type)
>  {
>  	struct zcomp_strm *zstrm;
>  	unsigned long handle;
> @@ -1314,6 +1345,12 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  	void *src, *dst;
>  	u32 prio;
>  	int ret;
> +	unsigned long page_size = PAGE_SIZE;
> +
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +	if (zs_type == ZSMALLOC_TYPE_MULTI_PAGES)
> +		page_size = ZCOMP_MULTI_PAGES_SIZE;
> +#endif
>  
>  	handle = zram_get_handle(zram, index);
>  	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
> @@ -1322,27 +1359,28 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  
>  		value = handle ? zram_get_element(zram, index) : 0;
>  		mem = kmap_local_page(page);
> -		zram_fill_page(mem, PAGE_SIZE, value);
> +		zram_fill_page(mem, page_size, value);
>  		kunmap_local(mem);
>  		return 0;
>  	}
>  
>  	size = zram_get_obj_size(zram, index);
>  
> -	if (size != PAGE_SIZE) {
> +	if (size != page_size) {
>  		prio = zram_get_priority(zram, index);
>  		zstrm = zcomp_stream_get(zram->comps[prio]);
>  	}
>  
>  	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
> -	if (size == PAGE_SIZE) {
> +	if (size == page_size) {
>  		dst = kmap_local_page(page);
>  		copy_page(dst, src);

	copy_page() should be changed to:

	memcpy(dst, src, page_size);

>  		kunmap_local(dst);
>  		ret = 0;
>  	} else {
>  		dst = kmap_local_page(page);
> -		ret = zcomp_decompress(zstrm, src, size, dst);
> +		ret = zcomp_decompress(zstrm, src, size, dst, page_size);
> +
>  		kunmap_local(dst);
>  		zcomp_stream_put(zram->comps[prio]);
>  	}
> @@ -1358,7 +1396,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
>  	zram_slot_lock(zram, index);
>  	if (!zram_test_flag(zram, index, ZRAM_WB)) {
>  		/* Slot should be locked through out the function call */
> -		ret = zram_read_from_zspool(zram, page, index);
> +		ret = zram_read_from_zspool(zram, page, index, ZSMALLOC_TYPE_BASEPAGE);
>  		zram_slot_unlock(zram, index);
>  	} else {
>  		/*
> @@ -1415,9 +1453,18 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	struct zcomp_strm *zstrm;
>  	unsigned long element = 0;
>  	enum zram_pageflags flags = 0;
> +	unsigned long page_size = PAGE_SIZE;
> +	int huge_class_idx = ZSMALLOC_TYPE_BASEPAGE;
> +
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +	if (folio_size(page_folio(page)) >= ZCOMP_MULTI_PAGES_SIZE) {
> +		page_size = ZCOMP_MULTI_PAGES_SIZE;
> +		huge_class_idx = ZSMALLOC_TYPE_MULTI_PAGES;
> +	}
> +#endif
>  
>  	mem = kmap_local_page(page);
> -	if (page_same_filled(mem, &element)) {
> +	if (page_same_filled(mem, &element, page_size)) {
>  		kunmap_local(mem);
>  		/* Free memory associated with this sector now. */
>  		flags = ZRAM_SAME;
> @@ -1429,7 +1476,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  compress_again:
>  	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
>  	src = kmap_local_page(page);
> -	ret = zcomp_compress(zstrm, src, &comp_len);
> +	ret = zcomp_compress(zstrm, src, page_size, &comp_len);
>  	kunmap_local(src);
>  
>  	if (unlikely(ret)) {
> @@ -1439,8 +1486,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  		return ret;
>  	}
>  
> -	if (comp_len >= huge_class_size)
> -		comp_len = PAGE_SIZE;
> +	if (comp_len >= huge_class_size[huge_class_idx])
> +		comp_len = page_size;
>  	/*
>  	 * handle allocation has 2 paths:
>  	 * a) fast path is executed with preemption disabled (for
> @@ -1469,7 +1516,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  		if (IS_ERR_VALUE(handle))
>  			return PTR_ERR((void *)handle);
>  
> -		if (comp_len != PAGE_SIZE)
> +		if (comp_len != page_size)
>  			goto compress_again;
>  		/*
>  		 * If the page is not compressible, you need to acquire the
> @@ -1493,10 +1540,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
>  
>  	src = zstrm->buffer;
> -	if (comp_len == PAGE_SIZE)
> +	if (comp_len == page_size)
>  		src = kmap_local_page(page);
>  	memcpy(dst, src, comp_len);
> -	if (comp_len == PAGE_SIZE)
> +	if (comp_len == page_size)
>  		kunmap_local(src);
>  
>  	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
> @@ -1510,7 +1557,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	zram_slot_lock(zram, index);
>  	zram_free_page(zram, index);
>  
> -	if (comp_len == PAGE_SIZE) {
> +	if (comp_len == page_size) {
>  		zram_set_flag(zram, index, ZRAM_HUGE);
>  		atomic64_inc(&zram->stats.huge_pages);
>  		atomic64_inc(&zram->stats.huge_pages_since);
> @@ -1523,6 +1570,15 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  		zram_set_handle(zram, index, handle);
>  		zram_set_obj_size(zram, index, comp_len);
>  	}
> +
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +	if (page_size == ZCOMP_MULTI_PAGES_SIZE) {
> +		/* Set multi-pages compression flag for free or overwriting */
> +		for (int i = 0; i < ZCOMP_MULTI_PAGES_NR; i++)
> +			zram_set_flag(zram, index + i, ZRAM_COMP_MULTI_PAGES);
> +	}
> +#endif
> +
>  	zram_slot_unlock(zram, index);
>  
>  	/* Update stats */
> @@ -1592,7 +1648,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
>  	if (comp_len_old < threshold)
>  		return 0;
>  
> -	ret = zram_read_from_zspool(zram, page, index);
> +	ret = zram_read_from_zspool(zram, page, index, ZSMALLOC_TYPE_BASEPAGE);
>  	if (ret)
>  		return ret;
>  
> @@ -1615,7 +1671,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
>  		num_recomps++;
>  		zstrm = zcomp_stream_get(zram->comps[prio]);
>  		src = kmap_local_page(page);
> -		ret = zcomp_compress(zstrm, src, &comp_len_new);
> +		ret = zcomp_compress(zstrm, src, PAGE_SIZE, &comp_len_new);
>  		kunmap_local(src);
>  
>  		if (ret) {
> @@ -1749,7 +1805,7 @@ static ssize_t recompress_store(struct device *dev,
>  		}
>  	}
>  
> -	if (threshold >= huge_class_size)
> +	if (threshold >= huge_class_size[ZSMALLOC_TYPE_BASEPAGE])
>  		return -EINVAL;
>  
>  	down_read(&zram->init_lock);
> @@ -1864,7 +1920,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
>  	bio_endio(bio);
>  }
>  
> -static void zram_bio_read(struct zram *zram, struct bio *bio)
> +static void zram_bio_read_page(struct zram *zram, struct bio *bio)
>  {
>  	unsigned long start_time = bio_start_io_acct(bio);
>  	struct bvec_iter iter = bio->bi_iter;
> @@ -1895,7 +1951,7 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
>  	bio_endio(bio);
>  }
>  
> -static void zram_bio_write(struct zram *zram, struct bio *bio)
> +static void zram_bio_write_page(struct zram *zram, struct bio *bio)
>  {
>  	unsigned long start_time = bio_start_io_acct(bio);
>  	struct bvec_iter iter = bio->bi_iter;
> @@ -1925,6 +1981,250 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
>  	bio_endio(bio);
>  }
>  
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +
> +/*
> + * The index is compress by multi-pages when any index ZRAM_COMP_MULTI_PAGES flag is set.
> + * Return: 0	: compress by page
> + *         > 0	: compress by multi-pages
> + */
> +static inline int __test_multi_pages_comp(struct zram *zram, u32 index)
> +{
> +	int i;
> +	int count = 0;
> +	int head_index = index & ~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
> +
> +	for (i = 0; i < ZCOMP_MULTI_PAGES_NR; i++) {
> +		if (zram_test_flag(zram, head_index + i, ZRAM_COMP_MULTI_PAGES))
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
> +static inline bool want_multi_pages_comp(struct zram *zram, struct bio *bio)
> +{
> +	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
> +
> +	if (bio->bi_io_vec->bv_len >= ZCOMP_MULTI_PAGES_SIZE)
> +		return true;
> +
> +	zram_slot_lock(zram, index);
> +	if (__test_multi_pages_comp(zram, index)) {
> +		zram_slot_unlock(zram, index);
> +		return true;
> +	}
> +	zram_slot_unlock(zram, index);
> +
> +	return false;
> +}
> +
> +static inline bool test_multi_pages_comp(struct zram *zram, struct bio *bio)
> +{
> +	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
> +
> +	return !!__test_multi_pages_comp(zram, index);
> +}
> +
> +static inline bool is_multi_pages_partial_io(struct bio_vec *bvec)
> +{
> +	return bvec->bv_len != ZCOMP_MULTI_PAGES_SIZE;
> +}
> +
> +static int zram_read_multi_pages(struct zram *zram, struct page *page, u32 index,
> +			  struct bio *parent)
> +{
> +	int ret;
> +
> +	zram_slot_lock(zram, index);
> +	if (!zram_test_flag(zram, index, ZRAM_WB)) {
> +		/* Slot should be locked through out the function call */
> +		ret = zram_read_from_zspool(zram, page, index, ZSMALLOC_TYPE_MULTI_PAGES);
> +		zram_slot_unlock(zram, index);
> +	} else {
> +		/*
> +		 * The slot should be unlocked before reading from the backing
> +		 * device.
> +		 */
> +		zram_slot_unlock(zram, index);
> +
> +		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
> +				     parent);
> +	}
> +
> +	/* Should NEVER happen. Return bio error if it does. */
> +	if (WARN_ON(ret < 0))
> +		pr_err("Decompression failed! err=%d, page=%u\n", ret, index);
> +
> +	return ret;
> +}
> +/*
> + * Use a temporary buffer to decompress the page, as the decompressor
> + * always expects a full page for the output.
> + */
> +static int zram_bvec_read_multi_pages_partial(struct zram *zram, struct bio_vec *bvec,
> +				  u32 index, int offset)
> +{
> +	struct page *page = alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MULTI_PAGES_ORDER);
> +	int ret;
> +
> +	if (!page)
> +		return -ENOMEM;
> +	ret = zram_read_multi_pages(zram, page, index, NULL);
> +	if (likely(!ret)) {
> +		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
> +		void *dst = kmap_local_page(bvec->bv_page);
> +		void *src = kmap_local_page(page);
> +
> +		memcpy(dst + bvec->bv_offset, src + offset, bvec->bv_len);
> +		kunmap_local(src);
> +		kunmap_local(dst);
> +	}
> +	__free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
> +	return ret;
> +}
> +

alloc_pages() might fail, so we don't depend on allocation:

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
+		mem = kmap_atomic(page);
+		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
+		zram_fill_page(mem, PAGE_SIZE, value); //multi_pages partial read
+		kunmap_atomic(mem);
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
+		dst = kmap_atomic(page);
+			atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
+			memcpy(dst, src + (offset << PAGE_SHIFT), PAGE_SIZE);	//multi_pages partial read
+		kunmap_atomic(dst);
+		ret = 0;
+	} else {
+		dst = kmap_atomic(page);
+		//use zstrm->buffer to store decompress thp and copy page to dst
+		atomic64_inc(&zram->stats.zram_bio_read_multi_pages_partial_count);
+		ret = zcomp_decompress(zstrm, src, size, zstrm->buffer, page_size);
+		memcpy(dst, zstrm->buffer + (offset << PAGE_SHIFT), PAGE_SIZE);  //multi_pages partial read
+		kunmap_atomic(dst);
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
+		pr_err("Decompression failed! err=%d, page=%u offset=%d\n", ret, index,offset);
+
+	return ret;
+}

> +static int zram_bvec_read_multi_pages(struct zram *zram, struct bio_vec *bvec,
> +			  u32 index, int offset, struct bio *bio)
> +{
> +	if (is_multi_pages_partial_io(bvec))
> +		return zram_bvec_read_multi_pages_partial(zram, bvec, index, offset);

should be:
	return zram_bvec_read_multi_pages_partial(zram, bvec->bv_page, index, bio, offset);

> +	return zram_read_multi_pages(zram, bvec->bv_page, index, bio);
> +}
> +
> +/*
> + * This is a partial IO. Read the full page before writing the changes.
> + */
> +static int zram_bvec_write_multi_pages_partial(struct zram *zram, struct bio_vec *bvec,
> +				   u32 index, int offset, struct bio *bio)
> +{
> +	struct page *page = alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MULTI_PAGES_ORDER);
> +	int ret;
> +	void *src, *dst;
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	ret = zram_read_multi_pages(zram, page, index, bio);
> +	if (!ret) {
> +		src = kmap_local_page(bvec->bv_page);
> +		dst = kmap_local_page(page);
> +		memcpy(dst + offset, src + bvec->bv_offset, bvec->bv_len);

should be:
	memcpy(dst + (offset << PAGE_SHIFT), src + bvec->bv_offset, bvec->bv_len);

> +		kunmap_local(dst);
> +		kunmap_local(src);
> +
> +		atomic64_inc(&zram->stats.zram_bio_write_multi_pages_partial_count);
> +		ret = zram_write_page(zram, page, index);
> +	}
> +	__free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
> +	return ret;
> +}
> +
> +static int zram_bvec_write_multi_pages(struct zram *zram, struct bio_vec *bvec,
> +			   u32 index, int offset, struct bio *bio)
> +{
> +	if (is_multi_pages_partial_io(bvec))
> +		return zram_bvec_write_multi_pages_partial(zram, bvec, index, offset, bio);
> +	return zram_write_page(zram, bvec->bv_page, index);
> +}
> +
> +
> +static void zram_bio_read_multi_pages(struct zram *zram, struct bio *bio)
> +{
> +	unsigned long start_time = bio_start_io_acct(bio);
> +	struct bvec_iter iter = bio->bi_iter;
> +
> +	do {
> +		/* Use head index, and other indexes are used as offset */
> +		u32 index = (iter.bi_sector >> SECTORS_PER_PAGE_SHIFT) &
> +				~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
> +		u32 offset = (iter.bi_sector >> SECTORS_PER_PAGE_SHIFT) &
> +				((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
> +		struct bio_vec *pbv = bio->bi_io_vec;
> +
> +		atomic64_add(1, &zram->stats.zram_bio_read_multi_pages_count);
> +		pbv->bv_len = min_t(u32, pbv->bv_len, ZCOMP_MULTI_PAGES_SIZE - offset);
> +
> +		if (zram_bvec_read_multi_pages(zram, pbv, index, offset, bio) < 0) {
> +			atomic64_inc(&zram->stats.multi_pages_failed_reads);
> +			bio->bi_status = BLK_STS_IOERR;
> +			break;
> +		}
> +		flush_dcache_page(pbv->bv_page);
> +
> +		zram_slot_lock(zram, index);
> +		zram_accessed(zram, index);
> +		zram_slot_unlock(zram, index);
> +
> +		bio_advance_iter_single(bio, &iter, pbv->bv_len);
> +	} while (iter.bi_size);
> +
> +	bio_end_io_acct(bio, start_time);
> +	bio_endio(bio);
> +}
> +
> +static void zram_bio_write_multi_pages(struct zram *zram, struct bio *bio)
> +{
> +	unsigned long start_time = bio_start_io_acct(bio);
> +	struct bvec_iter iter = bio->bi_iter;
> +
> +	do {
> +		/* Use head index, and other indexes are used as offset */
> +		u32 index = (iter.bi_sector >> SECTORS_PER_PAGE_SHIFT) &
> +				~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
> +		u32 offset = (iter.bi_sector >> SECTORS_PER_PAGE_SHIFT) &
> +				((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
> +		struct bio_vec *pbv = bio->bi_io_vec;
> +
> +		pbv->bv_len = min_t(u32, pbv->bv_len, ZCOMP_MULTI_PAGES_SIZE - offset);
> +
> +		atomic64_add(1, &zram->stats.zram_bio_write_multi_pages_count);
> +		if (zram_bvec_write_multi_pages(zram, pbv, index, offset, bio) < 0) {
> +			atomic64_inc(&zram->stats.multi_pages_failed_writes);
> +			bio->bi_status = BLK_STS_IOERR;
> +			break;
> +		}
> +
> +		zram_slot_lock(zram, index);
> +		zram_accessed(zram, index);
> +		zram_slot_unlock(zram, index);
> +
> +		bio_advance_iter_single(bio, &iter, pbv->bv_len);
> +	} while (iter.bi_size);
> +
> +	bio_end_io_acct(bio, start_time);
> +	bio_endio(bio);
> +}
> +#else
> +static inline bool test_multi_pages_comp(struct zram *zram, struct bio *bio)
> +{
> +	return false;
> +}
> +
> +static inline bool want_multi_pages_comp(struct zram *zram, struct bio *bio)
> +{
> +	return false;
> +}
> +static void zram_bio_read_multi_pages(struct zram *zram, struct bio *bio) {}
> +static void zram_bio_write_multi_pages(struct zram *zram, struct bio *bio) {}
> +#endif
> +
> +static void zram_bio_read(struct zram *zram, struct bio *bio)
> +{
> +	if (test_multi_pages_comp(zram, bio))
> +		zram_bio_read_multi_pages(zram, bio);
> +	else
> +		zram_bio_read_page(zram, bio);
> +}
> +
> +static void zram_bio_write(struct zram *zram, struct bio *bio)
> +{
> +	if (want_multi_pages_comp(zram, bio))
> +		zram_bio_write_multi_pages(zram, bio);
> +	else
> +		zram_bio_write_page(zram, bio);
> +}
> +
>  /*
>   * Handler function for all zram I/O requests.
>   */
> @@ -1962,6 +2262,25 @@ static void zram_slot_free_notify(struct block_device *bdev,
>  		return;
>  	}
>  
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +	int comp_count = __test_multi_pages_comp(zram, index);
> +
> +	if (comp_count > 1) {
> +		zram_clear_flag(zram, index, ZRAM_COMP_MULTI_PAGES);
> +		zram_slot_unlock(zram, index);
> +		return;
> +	} else if (comp_count == 1) {
> +		zram_clear_flag(zram, index, ZRAM_COMP_MULTI_PAGES);
> +		zram_slot_unlock(zram, index);
> +		/*only need to free head index*/
> +		index &= ~((unsigned long)ZCOMP_MULTI_PAGES_NR - 1);
> +		if (!zram_slot_trylock(zram, index)) {
> +			atomic64_inc(&zram->stats.multi_pages_miss_free);
> +			return;
> +		}
> +	}
> +#endif
> +
>  	zram_free_page(zram, index);
>  	zram_slot_unlock(zram, index);
>  }
> @@ -2158,6 +2477,9 @@ static struct attribute *zram_disk_attrs[] = {
>  #endif
>  	&dev_attr_io_stat.attr,
>  	&dev_attr_mm_stat.attr,
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +	&dev_attr_multi_pages_debug_stat.attr,
> +#endif
>  #ifdef CONFIG_ZRAM_WRITEBACK
>  	&dev_attr_bd_stat.attr,
>  #endif
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 37bf29f34d26..8481271b3ceb 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -38,7 +38,14 @@
>   *
>   * We use BUILD_BUG_ON() to make sure that zram pageflags don't overflow.
>   */
> +
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +#define ZRAM_FLAG_SHIFT (CONT_PTE_SHIFT + 1)
> +#else
>  #define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
> +#endif
> +
> +#define ENABLE_HUGEPAGE_ZRAM_DEBUG 1
>  
>  /* Only 2 bits are allowed for comp priority index */
>  #define ZRAM_COMP_PRIORITY_MASK	0x3
> @@ -57,6 +64,10 @@ enum zram_pageflags {
>  	ZRAM_COMP_PRIORITY_BIT1, /* First bit of comp priority index */
>  	ZRAM_COMP_PRIORITY_BIT2, /* Second bit of comp priority index */
>  
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +	ZRAM_COMP_MULTI_PAGES,	/* Compressed by multi-pages */
> +#endif
> +
>  	__NR_ZRAM_PAGEFLAGS,
>  };
>  
> @@ -91,6 +102,16 @@ struct zram_stats {
>  	atomic64_t bd_reads;		/* no. of reads from backing device */
>  	atomic64_t bd_writes;		/* no. of writes from backing device */
>  #endif
> +
> +#ifdef CONFIG_ZRAM_MULTI_PAGES
> +	atomic64_t zram_bio_write_multi_pages_count;
> +	atomic64_t zram_bio_read_multi_pages_count;
> +	atomic64_t multi_pages_failed_writes;
> +	atomic64_t multi_pages_failed_reads;
> +	atomic64_t zram_bio_write_multi_pages_partial_count;
> +	atomic64_t zram_bio_read_multi_pages_partial_count;
> +	atomic64_t multi_pages_miss_free;
> +#endif
>  };
>  
>  #ifdef CONFIG_ZRAM_MULTI_COMP
> -- 
> 2.34.1
>

Thanks
Barry

