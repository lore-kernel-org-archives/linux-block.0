Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379641;
	b=TBNLbuKF3UV2w1Q/Urr/iw9HeF9gafBASStqktBPlBr620MpBla6fqDT6WJ3dHjinc7e
	 KdPWCoNQaUBUAuAWH+gSDHZchm7eUkjCLqLCCdJdmKJatglD0/28Y2R17MUTYH8AQ3GJS
	 nCMIwsBSDUbh+/xGXmUxBbMA68f/+LvipHPBGK8RBMf4UBrVcEFITYTeb7LxStE41NtB+
	 8GC1RRS4/wdcbFAt6C1Ihuz4vwAwMikphyjzcgXdVLkKU/8uJKY4PEn71JXj8lv/0WJKM
	 1x0HG5fzqIditsDTu3pCHsluc/22TEUSFIlsn8fqfLdp5x1SZDcY333XJYnsQrgaT4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tu9NrHqKlXzz55x+volPwRYKOdbYof5nwc5oAEpTpeM=;
	b=OBuhYAueQCuPsxVD3iEauCnKZoacIIBmMgWdFGYTvX8yaBdnJ2lSVpgMM+DayqTeuA5e
	 6BzGeJPc4AzT1/xtoiEK0uyDiTpYDBotI/fzhjBMMGplnB9ijIB5qWFmNNBolpGQEteZM
	 x0DXJUxRDsPxmBtENYeRt7e2Fl49is2Y11gbOogrwunaJKwSc8Rh0geHNOWXT9+GORKIh
	 boWGr6PENQV/tNjGcc2diC2hb0ejbzGN1QrBsI17uZgP5D4pP3p70r7S7m8+tUfmYU05j
	 XimTojQ3RpELl7q9Ex6jQ94iOIaztzNh5r6wyzfhHdqRh1CkMd4+d9NnDVMaU+25BOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iC9w5x6X;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FCE606A334
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32FCE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iC9w5x6X
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so1558575a91.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379640; x=1794984440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tu9NrHqKlXzz55x+volPwRYKOdbYof5nwc5oAEpTpeM=;
        b=iC9w5x6XeMtu9ENPS1bTfEyeJWymArJpnhBRNqZ9ZXUP8hbKKNhfgb3hkAe1WQ5KkN
         /0sQh8rS8KLsE8jabCd8nRU8JHsVyyvWJXvjqNyoAx2Mn4UgKOpU+6j6x1VTxgMwCjvn
         MSAK2d+YZoYS1FD5DN+2JlaQo0BmaNhAKRqcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379640; x=1794984440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tu9NrHqKlXzz55x+volPwRYKOdbYof5nwc5oAEpTpeM=;
        b=VVt0ZLUnrD430ic8He5e/eW7nVBLHYoY6jvNbuXUxisV9ofaDd5JIo7DBPB2pdxtyf
         9ssA6xQg6gLP5ZRK+7y/PWFUf4l6obVNsuvc1mKIcn0WUgQzlxArPb6rMQlRi71jhv0V
         xLlfG9/KS89gh95uOQGXSSsx+J0lvcTZYl8P1QPa48BcaTqubt2rypO1uFptmkQtInid
         vIb9uqe+W5EGNwR28C+07BAzlFzRjyRsrwpEPFfPuR8yqIuFZvBLdasUErnkyo/1w4Jb
         dUSYyZwMWlRqk5e1Q0ZFV5Q1y5+qybpWleBrqZc/7u3APx2YFaLPQsWEgKZCwM7zLTq5
         nCZw==
X-Forwarded-Encrypted: i=1; AL+hErGps/e8o0yJtP7xYY8AYUj4m0qhiIpVOcA67QW5yqi+wAC9snzq9yjSpKvn/2Qt++VfTJMvmoX9QdhxOQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/eKr/E0yDytgtsOOzP5EfPTJjpDCbOajV8I14UHI7JRzB/A/FC
	ZgqONW3gS25J3krgGUSTff7g4p53rSi2AC22SbRVYtY2TYNzhXJlvt8mzjapvniImA==
X-Gm-Gg: AYBFou0arWdlQuJmgf85Lpvaej8Uz7FhdKjLFHBkGzQGm9xZxLtFuwcW3AOK4rdYyFK
	nPWio2CoqR2Dc9JyikGDtvy+kBd2ddkqqh3zoNvkZ+osLs7kuzXR9NMwIyBZy5xp+X7MjYjnF3r
	c2yZklWyEkS+iqT6VZxtwlJIhX+3tV8HergcZ18lTMAF67+1q1mSOLazSXxr4nh7sA884yeBDK/
	1WWKhGeu0oiOY0lvDdoQ4zWlXTLcOdwhq+F0z4lHOca+OJUVHO9RFGbUQycafhyAPb+TDVJMqVC
	UViCn3mkrESbGDrcRmnHj5y7OcDVCkM4GTu5W9MQzq17IcPzfZoscpmXWmo3CzgaqLQaUG9nePY
	oN4sNzgfIsfHFJEh6fbsVlfK87+IVb+uwJVVoU5BfJfcBoJVOjGrCk/7+XvLckEOW23Jb0EQuWW
	JQTFlm8BAvJ4G90LJdZ4/qKv9dKpUmL23N1gzVgCcC5eVA2iBhqtzF0NK3U5jI1CTUsZgrfdTXg
	G2rCZ25bxHtKFnVQ1sNtvnpU5hy2IH7ILxbRPcACMUDKS7QDQFnfyaotgS4+AfTvOOUyuDg46E2
	/hqIm43ePlEuQQ4qZMOhRd15IadqKdAuJO6gJ9rgDoNmZeumqFVl6p6Z59/w62E6mcV2glgch/A
	aOWJHpdAHpyC9AC3O8w==
X-Received: by 2002:a17:90b:2b43:b0:3a4:b509:88bd with SMTP id 98e67ed59e1d1-3b182e0c1fcmr1171979a91.2.1794379640543;
        Tue, 10 Nov 2026 22:47:20 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:19 -0800 (PST)
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
Subject: [PATCH v3 02/11] zram: drop get_slot_handle() and set_slot_handle()
Date: Wed, 11 Nov 2026 15:46:25 +0900
Message-ID: <20261111064707.2568433-3-senozhatsky@chromium.org>
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

zram_table_entry ->handle is overloaded to store zsmalloc handle,
same-filled page pattern and writeback block index, so calling
set_slot_handle() or get_slot_handle() for blk_idx and same-filled
pattern is confusing.

Turn ->handle into a union of handle, element and blk_idx, drop
get_slot_handle() and set_slot_handle(), and open-code field
accesses.  No functional change.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 43 +++++++++++++----------------------
 drivers/block/zram/zram_drv.h |  6 ++++-
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 380615b73446..5c13addd22f6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -111,17 +111,6 @@ static inline struct zram *dev_to_zram(struct device *dev)
 	return (struct zram *)dev_to_disk(dev)->private_data;
 }
 
-static unsigned long get_slot_handle(struct zram *zram, unsigned long index)
-{
-	return zram->table[index].handle;
-}
-
-static void set_slot_handle(struct zram *zram, unsigned long index,
-			    unsigned long handle)
-{
-	zram->table[index].handle = handle;
-}
-
 static bool test_slot_flag(struct zram *zram, unsigned long index,
 			   enum zram_pageflags flag)
 {
@@ -962,8 +951,8 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	if (test_slot_flag(zram, index, ZRAM_HUGE))
 		atomic64_dec(&zram->stats.huge_pages);
 	atomic64_sub(get_slot_size(zram, index), &zram->stats.compr_data_size);
-	zs_free(zram->mem_pool, get_slot_handle(zram, index));
-	set_slot_handle(zram, index, req->blk_idx);
+	zs_free(zram->mem_pool, zram->table[index].handle);
+	zram->table[index].blk_idx = req->blk_idx;
 	set_slot_flag(zram, index, ZRAM_WB);
 
 out:
@@ -2064,7 +2053,7 @@ static void slot_free(struct zram *zram, unsigned long index)
 
 	if (test_slot_flag(zram, index, ZRAM_WB)) {
 		clear_slot_flag(zram, index, ZRAM_WB);
-		zram_release_bdev_block(zram, get_slot_handle(zram, index));
+		zram_release_bdev_block(zram, zram->table[index].blk_idx);
 		goto out;
 	}
 
@@ -2078,7 +2067,7 @@ static void slot_free(struct zram *zram, unsigned long index)
 		goto out;
 	}
 
-	handle = get_slot_handle(zram, index);
+	handle = zram->table[index].handle;
 	if (!handle)
 		return;
 
@@ -2088,7 +2077,7 @@ static void slot_free(struct zram *zram, unsigned long index)
 		     &zram->stats.compr_data_size);
 out:
 	atomic64_dec(&zram->stats.pages_stored);
-	set_slot_handle(zram, index, 0);
+	zram->table[index].element = 0;
 	set_slot_size(zram, index, 0);
 }
 
@@ -2098,7 +2087,7 @@ static int read_same_filled_page(struct zram *zram, struct page *page,
 	void *mem;
 
 	mem = kmap_local_page(page);
-	zram_fill_page(mem, PAGE_SIZE, get_slot_handle(zram, index));
+	zram_fill_page(mem, PAGE_SIZE, zram->table[index].element);
 	kunmap_local(mem);
 	return 0;
 }
@@ -2110,7 +2099,7 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
 	unsigned long handle;
 	void *src, *dst;
 
-	handle = get_slot_handle(zram, index);
+	handle = zram->table[index].handle;
 	zs_obj_read_sg_begin(zram->mem_pool, handle, sg, PAGE_SIZE);
 	/* an incompressible object never spans two pages */
 	src = kmap_local_page(sg_page(sg));
@@ -2134,7 +2123,7 @@ static int read_compressed_page(struct zram *zram, struct page *page,
 	void *dst;
 	int ret, prio;
 
-	handle = get_slot_handle(zram, index);
+	handle = zram->table[index].handle;
 	size = get_slot_size(zram, index);
 	prio = get_slot_comp_priority(zram, index);
 
@@ -2161,7 +2150,7 @@ static int read_from_zspool_raw(struct zram *zram, struct page *page,
 	unsigned int size;
 	void *dst;
 
-	handle = get_slot_handle(zram, index);
+	handle = zram->table[index].handle;
 	size = get_slot_size(zram, index);
 
 	/*
@@ -2188,7 +2177,7 @@ static int read_from_zspool(struct zram *zram, struct page *page,
 			    unsigned long index)
 {
 	if (test_slot_flag(zram, index, ZRAM_SAME) ||
-	    !get_slot_handle(zram, index))
+	    !zram->table[index].handle)
 		return read_same_filled_page(zram, page, index);
 
 	if (!test_slot_flag(zram, index, ZRAM_HUGE))
@@ -2209,7 +2198,7 @@ static int zram_read_page(struct zram *zram, struct page *page,
 		ret = read_from_zspool(zram, page, index);
 		slot_unlock(zram, index);
 	} else {
-		unsigned long blk_idx = get_slot_handle(zram, index);
+		unsigned long blk_idx = zram->table[index].blk_idx;
 
 		/*
 		 * The slot should be unlocked before reading from the backing
@@ -2255,7 +2244,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 	slot_lock(zram, index);
 	slot_free(zram, index);
 	set_slot_flag(zram, index, ZRAM_SAME);
-	set_slot_handle(zram, index, fill);
+	zram->table[index].element = fill;
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
 
@@ -2289,7 +2278,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	slot_lock(zram, index);
 	slot_free(zram, index);
 	set_slot_flag(zram, index, ZRAM_HUGE);
-	set_slot_handle(zram, index, handle);
+	zram->table[index].handle = handle;
 	set_slot_size(zram, index, PAGE_SIZE);
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
@@ -2355,7 +2344,7 @@ static int zram_write_page(struct zram *zram, struct page *page,
 
 	slot_lock(zram, index);
 	slot_free(zram, index);
-	set_slot_handle(zram, index, handle);
+	zram->table[index].handle = handle;
 	set_slot_size(zram, index, comp_len);
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
@@ -2471,7 +2460,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	void *src;
 	int ret = 0;
 
-	handle_old = get_slot_handle(zram, index);
+	handle_old = zram->table[index].handle;
 	if (!handle_old)
 		return -EINVAL;
 
@@ -2554,7 +2543,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	zcomp_cstrm_put(zstrm);
 
 	slot_free(zram, index);
-	set_slot_handle(zram, index, handle_new);
+	zram->table[index].handle = handle_new;
 	set_slot_size(zram, index, comp_len_new);
 	set_slot_comp_priority(zram, index, prio);
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c563a7c13a49..5416e25e64e8 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -78,7 +78,11 @@ enum zram_pageflags {
  * of each entry and hence of the meta table.
  */
 struct zram_table_entry {
-	unsigned long handle;
+	union {
+		unsigned long handle;
+		unsigned long element;
+		unsigned long blk_idx;
+	};
 	union {
 		unsigned long __lock;
 		struct attr {
-- 
2.56.0.542.g3ef89b7020-goog

