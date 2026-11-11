Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379650;
	b=f5WQPpLLhJqO1hKJrjZOeAk3+0cwa93kQfOhxfL+uKGPv31L4CT7Bqd9mibqlKdC1A4H
	 ZKSt3mNOM/wEFg0YXvRkmjJeGFawBzepYV1ZNnRusd9n5mZe6SdwCAJ2rH6hxgSZyHy6i
	 Y75/h7u/o4Pj9ue+Y9HAXlnYZP5DW2J4NpoX9xFaOUC/yfI56QhwjT3qTH0T11g3O5Uwc
	 PpbizA7TZOoKc97lF615QXcJshjvOeQEL6Jj5CTN9I43EJWYLpzKROyvL6IBKXZ5AKsEC
	 J5/2/ZYpLTkbOluTYglrbe6zvcppGvZy4kIvHrc9WRcMqc0eftLXUar1qWARH7HHCDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1ir7CRyHEX/3uMqgVqbpHDvK9mkESk561zfXrmyj8v0=;
	b=svjoAFzg53xy47i6SV3luseXjS7vFdH1kV3MPgry+5E0F9dKb1MKX6+sgg5Icw7WP31X
	 4GRSFSez5MCrvfiCeIsknEeOKcUg52i7oszWBEXktoYD72pJeXSpgPPeRzhiN/5eXmiAL
	 7o/KOpjlJV2hEZEAbIo1EP2D43ptxnGdOUQ8oKW3ydcqr1oOUUiFw2cZLjeeclzvbKfDB
	 FmgDj0w2NmLBH5XBBs7RM6xOxRKs0XlqijtW/Cn/0tZOMga5k8JbM+A/gATCoSZ9EgvnH
	 /Q0DOqJFbT8Ds5H0hNuyniXShmt6DWQhOL87JEdg/rWeXuZq5blomZRXDpfMcQOnq/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MLENyy2L;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633160A5BC6
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A633160A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MLENyy2L
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1566269a91.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379649; x=1794984449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ir7CRyHEX/3uMqgVqbpHDvK9mkESk561zfXrmyj8v0=;
        b=MLENyy2LvDMD/8IRevEo/r8S8kJeQkpx+xD1OouysJ26Ikr+GFZjSu1bmqki1WruPY
         IixxMIRJBkdaWJtXppunmlG1E23Z7iq90qc45C8b38TnSp1k4v7uhE5NKKb3s6B60FTO
         iuXqCojP+VJhPOJ6oeky9L9D6SocD6a00bE3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379649; x=1794984449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ir7CRyHEX/3uMqgVqbpHDvK9mkESk561zfXrmyj8v0=;
        b=coEFoaIU2tLcaJZitCZ+c0vKVSOkLX5BJsSVkPi1TfWOq78iHvj7In2E5XI6eNxZsI
         PAg2MCt6yQuLFj4Oaq7eQxqz3Nn0GnAeXI6UTzBeOxWYUU7z2QlOPV0NDcg1U0umWP01
         UstvlqF4VXyBagU9wcrT5b5TtuRr2jc+uy67rE9iIwq4Nl5pGLGBgSM1JyFqKFD6RUuN
         Rk91dLA6YUie5RFOJ7J4a0tMW/K2FO62NTdvyPOdVPE5KGTHl3c05hjrIF591Z9U7QUm
         msgcN0ncmAdEwule7ZBG4Fq+ZAsV6Yr/FlyG/GkhY5lx2syJ7ikhUif6GbuDBUqnGjht
         fZzQ==
X-Forwarded-Encrypted: i=1; AL+hErH8UqSmKZkzidf+7Tn7xgqiMPWHOp3BhlZtBGMDnwHusm9il8Pq/b+eZ+teMzkeMRcCjqRc1onVI++mEA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9G5e1B+ah7agC2HyK4yLR5jBXxE5gbHk8ntJBnFVZ+6ib5yDka
	wOjfz3RDZFXgTmJVT+JP/sR1tFNt/+H2HNvf6gZkc6zgA+MQWld2UzRhlsofsRofKw==
X-Gm-Gg: AYBFou2/A3mJi+esK845D56pmEQD/dHYmf2+qfwF2t2xhWOOX9xeX1ypcaQwZs4msie
	79s+X6gQUU9hno5cNri57NV8qeL+hwWFfmrgmDxHDnS9NT+oqZX9Nj9tNKylnkPnJtJpULPMH03
	R/U8CZOs1RabkGs2mncnLdgbLylCYGSejkxLX6fLLOWAuqBtCvXcfpFq+ZP/JctHmeYD6HzNyJd
	A69FlFjeZciw7ccuShUqfcWc5g6W4Oo9UEj6ObEuIM7qPLEzeKNlmUVzdeBORRwHO2139EKZ9xr
	7hOr3YrG2H/6OGkoNW7GPY4LRQ0qg5f6WEuqBfgulLLncK1ujV9dgZq9RW5mr3W9QoSNJaM3pMl
	OIskssKOfMZxyeTiaJ0v7/eA4YmACXgwWj+QVFWFlhokoJ1lD8MRGg6WtnA8huOgtVja3adSoyt
	uCLXibMSdsDoCU47TfBNn3I0mNpfh4qEbV+/5MReCNFD3wp9XtSM5fTpf2YgT2Sz/6hAVI+u5Cs
	tmz5zVdhg4VsOr+/qdoPOh61/WtPkuLOmmejmMCup6S2fBmYFqS27VsQRB2mlUF1rR+9FgDD20h
	ACcNNiCjTVIds+OwzK1IWST+PUGvZOWWhGVwcaagdQVe9KplIpcv2cI23ZqBr2i3TNjfqJP4q7N
	VIvj1BrVZcsCGP60SPw==
X-Received: by 2002:a17:90b:1344:b0:3ab:e588:c275 with SMTP id 98e67ed59e1d1-3b182ec1ea6mr1487044a91.20.1794379648977;
        Tue, 10 Nov 2026 22:47:28 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:28 -0800 (PST)
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
Subject: [PATCH v3 05/11] zram: check mem_limit before allocating zsmalloc object
Date: Wed, 11 Nov 2026 15:46:28 +0900
Message-ID: <20261111064707.2568433-6-senozhatsky@chromium.org>
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

zram_can_store_page() is called after zs_malloc(), so once we reach
mem_limit every write that doesn't fit into a partial zspage allocates
a new zspage only to free it right away.

Check mem_limit in zram_write_page() before compressing the page and
allocating from zsmalloc, and update max_used_pages after zs_malloc()
succeeds.  mem_limit was never a hard limit, the allocation that
crosses it happens before the check anyway, so now we can go over the
limit by up to one zspage per concurrent writer, and writes fail early
until enough slots are freed.

mem_limit can change under us, so read ->limit_pages once.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  4 ++-
 drivers/block/zram/zram_drv.c               | 27 +++++++++------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 148b7cf3b924..db256c53b127 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -181,7 +181,9 @@ Set memory limit: Optional
 
 Set memory limit by writing the value to sysfs node 'mem_limit'.
 The value can be either in bytes or you can use mem suffixes.
-In addition, you could change the value in runtime.
+In addition, you could change the value in runtime.  The limit is
+checked before zsmalloc allocation, so memory usage may slightly
+exceed it (by up to one zspage per concurrent writer).
 Examples::
 
 	# limit /dev/zram0 with 50MB memory
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2c2e11b2b663..74e02cf4f53d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -177,8 +177,9 @@ static void mark_slot_accessed(struct zram *zram, unsigned long index)
 #endif
 }
 
-static inline void update_used_max(struct zram *zram, const unsigned long pages)
+static inline void update_used_max(struct zram *zram)
 {
+	unsigned long pages = zs_get_total_pages(zram->mem_pool);
 	unsigned long cur_max = atomic_long_read(&zram->stats.max_used_pages);
 
 	do {
@@ -190,12 +191,12 @@ static inline void update_used_max(struct zram *zram, const unsigned long pages)
 
 static bool zram_can_store_page(struct zram *zram)
 {
-	unsigned long alloced_pages;
+	unsigned long limit_pages = READ_ONCE(zram->limit_pages);
 
-	alloced_pages = zs_get_total_pages(zram->mem_pool);
-	update_used_max(zram, alloced_pages);
+	if (!limit_pages)
+		return true;
 
-	return !zram->limit_pages || alloced_pages <= zram->limit_pages;
+	return zs_get_total_pages(zram->mem_pool) <= limit_pages;
 }
 
 #if PAGE_SIZE != 4096
@@ -375,7 +376,7 @@ static ssize_t mem_limit_store(struct device *dev,
 		return -EINVAL;
 
 	guard(rwsem_write)(&zram->dev_lock);
-	zram->limit_pages = PAGE_ALIGN(limit) >> PAGE_SHIFT;
+	WRITE_ONCE(zram->limit_pages, PAGE_ALIGN(limit) >> PAGE_SHIFT);
 
 	return len;
 }
@@ -2266,10 +2267,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (!zram_can_store_page(zram)) {
-		zs_free(zram->mem_pool, handle);
-		return -ENOMEM;
-	}
+	update_used_max(zram);
 
 	src = kmap_local_page(page);
 	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
@@ -2308,6 +2306,9 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
+	if (!zram_can_store_page(zram))
+		return -ENOMEM;
+
 	zstrm = zcomp_cstrm_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
@@ -2333,11 +2334,7 @@ static int zram_write_page(struct zram *zram, struct page *page,
 		return PTR_ERR(handle);
 	}
 
-	if (!zram_can_store_page(zram)) {
-		zcomp_cstrm_put(zstrm);
-		zs_free(zram->mem_pool, handle);
-		return -ENOMEM;
-	}
+	update_used_max(zram);
 
 	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
 	zcomp_cstrm_put(zstrm);
-- 
2.56.0.542.g3ef89b7020-goog

