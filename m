Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EdDDejVk"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BD1A7
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 00:51:46 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so4873089b3a.3
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 00:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701161506; x=1701766306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94o0KeTip+rCuWEfzJrNX+wyBtGRxjUM9HxWnyozCLQ=;
        b=EdDDejVkitTTn3TNYxlOyxzk+/prfGd9Tcn/blxm0vuFnAZiEVgpqtXKNvgxjiPzmD
         lFpmubm7s7hGjTiWFVUlDyx2kalCLHc1yeO6PNI27eoKjGQXy5PYR4Dk1QgoOxzlhGfy
         Mcqj1b+L/WFUgLiqTp7Bbl8+xRXNrdjUw1xOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161506; x=1701766306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94o0KeTip+rCuWEfzJrNX+wyBtGRxjUM9HxWnyozCLQ=;
        b=H7dk3hRHf85d1aD8TBHoit7f9g8xLpAWC3TnovXjT4V1KRAoYE6/PZsUJUULua43FT
         hqfCD94A/uLZQ+N4cxST72gofcnuRv6Ctr+BGj2eO/B3ZPWuv68KgvUj04ZPgr5Mexkq
         /RoCGYdEBcZ8wdU3H4oxwh/ikVFtGxZYcMcwjvsZqFBXCj2M/o1+QpX4YSQbOaQu16lQ
         5SCItVbfPx6cbuikCLr5N0U8qw5HwN8A8a2hwZ3Ht8QzOrRxffIenfoazYJhF50O/CUE
         WgkoCroOe1m5oBFmv75P4DA0cE76Fz2UpTSw01bnhdBTlF+YopoQfQXbRBNrxasJORgO
         q8sQ==
X-Gm-Message-State: AOJu0YwI9bFRN3om6QaX3/+UHqREKGzB3/yf8hz3ajE44BjX07tuxIEF
	xwEdYH/MFn4dxARqirkyg6PS4g==
X-Google-Smtp-Source: AGHT+IHMKshrmRNnMzzg4/8dNzoZKqap30uAvyxMhlZKsne9AVXAU18u328Z/i26C5Jup7cgG+5V8w==
X-Received: by 2002:a05:6a21:3392:b0:18c:ba47:74ea with SMTP id yy18-20020a056a21339200b0018cba4774eamr4337244pzb.31.1701161505865;
        Tue, 28 Nov 2023 00:51:45 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3bea:3548:1aab:8181])
        by smtp.gmail.com with ESMTPSA id f7-20020aa782c7000000b006cb537b09f0sm8447794pfn.199.2023.11.28.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:51:45 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: Use kmap_local_page()
Date: Tue, 28 Nov 2023 17:22:07 +0900
Message-ID: <20231128083845.848008-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kmap_local_page() instead of kmap_atomic() which has been
deprecated.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f6b286e7f310..2b1d82473be8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1321,9 +1321,9 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		void *mem;
 
 		value = handle ? zram_get_element(zram, index) : 0;
-		mem = kmap_atomic(page);
+		mem = kmap_local_page(page);
 		zram_fill_page(mem, PAGE_SIZE, value);
-		kunmap_atomic(mem);
+		kunmap_local(mem);
 		return 0;
 	}
 
@@ -1336,14 +1336,14 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
-		dst = kmap_atomic(page);
+		dst = kmap_local_page(page);
 		memcpy(dst, src, PAGE_SIZE);
-		kunmap_atomic(dst);
+		kunmap_local(dst);
 		ret = 0;
 	} else {
-		dst = kmap_atomic(page);
+		dst = kmap_local_page(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
-		kunmap_atomic(dst);
+		kunmap_local(dst);
 		zcomp_stream_put(zram->comps[prio]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
@@ -1416,21 +1416,21 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
 
-	mem = kmap_atomic(page);
+	mem = kmap_local_page(page);
 	if (page_same_filled(mem, &element)) {
-		kunmap_atomic(mem);
+		kunmap_local(mem);
 		/* Free memory associated with this sector now. */
 		flags = ZRAM_SAME;
 		atomic64_inc(&zram->stats.same_pages);
 		goto out;
 	}
-	kunmap_atomic(mem);
+	kunmap_local(mem);
 
 compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
-	src = kmap_atomic(page);
+	src = kmap_local_page(page);
 	ret = zcomp_compress(zstrm, src, &comp_len);
-	kunmap_atomic(src);
+	kunmap_local(src);
 
 	if (unlikely(ret)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
@@ -1494,10 +1494,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	src = zstrm->buffer;
 	if (comp_len == PAGE_SIZE)
-		src = kmap_atomic(page);
+		src = kmap_local_page(page);
 	memcpy(dst, src, comp_len);
 	if (comp_len == PAGE_SIZE)
-		kunmap_atomic(src);
+		kunmap_local(src);
 
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
@@ -1614,9 +1614,9 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
-		src = kmap_atomic(page);
+		src = kmap_local_page(page);
 		ret = zcomp_compress(zstrm, src, &comp_len_new);
-		kunmap_atomic(src);
+		kunmap_local(src);
 
 		if (ret) {
 			zcomp_stream_put(zram->comps[prio]);
-- 
2.43.0.rc1.413.gea7ed67945-goog

