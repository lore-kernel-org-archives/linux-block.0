Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289741;
	b=zFtjdQrQWpRl98z6ODvvPA6SeXeIBiMw/SuIRwHBNZF2Nx0NsGOW1SGkIYloRjJhIIk8
	 /XOzvZz+Rudgu4UXiJ95Lha5j7QhA1NJeZ4W0KPetB9da7mmvnJ9zqxvPzlERxNpSqS06
	 ORE8ju72tdnS238sBkYlC0EFgnkgC0mgbGkfhdhjeSAtfCumNCWZuBbAc8cmUzS1FYCB/
	 dnMl5CQ9rbk0bck22ni+EiWXBdrzaJat7N7NpqlI+Pv5diw7X3nyoLHzIULRzv4kA5zBY
	 UjbFWzb0/Wp4elD7BvxaZbB5FioFEGSQbv2M7PKlfT2zaPU0ms/iD9WNFq4KUHxwQkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xEWSzx4ZGcyPZGxiCFnQgQ4OA1lpLc+LVHPbJjOB2UQ=;
	b=ghHGcgbRR9nOmLNLBM+80AtJapHybY8cWVuLHhTU+oS8ojibZTvzaQwlQSlbBt3BQfLT
	 Oxe97CLL/udZtZzNMz5sxL9BCMGksn1FGj7PltThLUmpsd5s9a7EnqNfGpteC5746mb1D
	 ROLrwAtCHvdTntbRsbG5VjcKk82x8yq8D8aIoi/p/nRsIJ5qB2271C7JjJhBP+XwMPyMq
	 klMn92OqIBuPLU+GcrnIB8E/U8Rnobm1sUel0uyHj8nCpvyasegCC4eoGuz4EtQF8XTJK
	 TUTa/3+5UYDErTEteQ1cYvRSqYtIiF2yVfQaU8SlDVDO7s2gU0CcieuMop7qDZ8ZnTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IR6wF7Di;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6960A2612
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB6960A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IR6wF7Di
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a60f90a924so626230b3a.3
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289740; x=1794894540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xEWSzx4ZGcyPZGxiCFnQgQ4OA1lpLc+LVHPbJjOB2UQ=;
        b=IR6wF7Did2sGiE/Vf2nG8/SuD2dZYjeiM6nhvGjMTSRS8m/AwT7K2RlgEPZQoQAEjk
         nOIEPTCcDVfopg8xZe0JhAMbWqzTqrRwhPupKjVu+h8Zf54EMMdlAQjTcyfXTmdNfZWL
         qOv1vpNBqoOPFPmKRg00gLY1HNHafoycGRQpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289740; x=1794894540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xEWSzx4ZGcyPZGxiCFnQgQ4OA1lpLc+LVHPbJjOB2UQ=;
        b=HruXx64q8xb70+RPzA9IH3Wt0szxKcuWMtDwN1n0bPHOJGjoznTIacIOSq8VmWXnHP
         Tqo973buuNJiO2pvJBGkgWKcXqQMnqRImbV37Sq02IWt4b8x3A7o0tUIrTYEK/1OZ0wo
         mDz/iOwSHjc+AfzwQOE5WauRlR76X8UVe3Sj5h9/KKmaJ6zUHzlGsFvJTWv7gAGSRkeK
         5W41WPYn7/BPKljvMny5x16ZXiEpa+wZ1vrzZ/gCXVnqJckSdLifbMx8KHVpY9SXp5S8
         XyNwTV3OEJekpDV2Z669LnStNtMXhjMMYA1PfX4vl98rXB4PplNLeHs9vgpUqEjg5e5+
         dzBg==
X-Forwarded-Encrypted: i=1; AL+hErFMmzte4KChzWleZIjZungOrD25AeAHYo8HQ/p1ojpjrUB37k3/creU4YbJPpBFJd9SfxlkXpCKxglW4w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8nm7kOcSvmwGW0CSnKSM/KOiFy2fvatf3ZVFgZc7kWTY6UdGbL
	HeWDlV/fsIGRlJDoOM8BjMpiAjjwZIt0yiOCtpokXS0b/Fc8721rjTWBf5HbevjkNw==
X-Gm-Gg: AYBFou3SL1y4n/D+sxStW2Hb+uUxeb9KbeuKnZheyE50sMrAfZfB5jx6u71Zk7hsIBw
	kKX0jhaf6aO50+Zn7mWviuV+klqbXJVuayT+V4MVMaXO074T6UZ32GZWWbUqFLR1l4opZHLCD1i
	UUzdFxq9/s/2ylEofXjQoYWhyLUwRyUbNM1LDcbYV1WGJUOGXyduZzb4Gq2kyy+4z/pf/q43zcC
	xYb17+5+qdcjy7d3h5xDnavD349nElVNnLkGevU8KiUSsnUelM3OBZHuKYUhyMbwZ0FS+ze93rR
	J8KebEhdbAg7ABEmJqfoMGVNGhzVe+It/M7Bq023rXBt0j9p0ChiHlljunF87/R/kuWJPV23yIa
	m+hPRlWOHEXdHF6ZNVAmXyOpCNWbyP2N5B/9lcZdHkuosUPNLqCELsCB0M4/ru6P1lFofj7PaD1
	iKzXJU4qpvxu3GKcdoyY1Gln1A6e4a6b4z/s9IWP1iUx/g62zmNb9I68qY+7hF8xxF6kWwhyxS8
	zTtbKUbMTLOWT52UPnEgtfUysLz8Nj5L8KhmGQ4VQGUhU6+Kl7FaCZXuWeQELOeg+K59k0Vr12H
	iSwjlDhwaTDGgLU1xzyWGf+xjYuF4hQXvBxoBId0+SplVU9uk8nHjqPYr5k7MuvegxUlp2aO0Yu
	SnZCthkF+dQN3wzTwQA==
X-Received: by 2002:a05:6a21:6e04:b0:3e2:3392:53f1 with SMTP id adf61e73a8af0-3f18c6267ebmr1458477637.5.1794289740404;
        Mon, 09 Nov 2026 21:49:00 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:48:59 -0800 (PST)
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
Subject: [PATCH v2 05/11] zram: check mem_limit before allocating zsmalloc object
Date: Tue, 10 Nov 2026 14:48:10 +0900
Message-ID: <20261110054836.1515030-6-senozhatsky@chromium.org>
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

zram_can_store_page() is called after zs_malloc(), so once we reach
mem_limit every write that doesn't fit into a partial zspage allocates
a new zspage only to free it right away.

Check mem_limit in zram_write_page() before compressing the page and
allocating from zsmalloc, and update max_used_pages after zs_malloc()
succeeds.  mem_limit was never a hard limit, the allocation that
crosses it happens before the check anyway, so now we can go over the
limit by up to one zspage per concurrent writer, and writes fail early
until enough slots are freed.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  4 +++-
 drivers/block/zram/zram_drv.c               | 25 +++++++++------------
 2 files changed, 13 insertions(+), 16 deletions(-)

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
index 2c2e11b2b663..d38b20a22595 100644
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
@@ -190,12 +191,10 @@ static inline void update_used_max(struct zram *zram, const unsigned long pages)
 
 static bool zram_can_store_page(struct zram *zram)
 {
-	unsigned long alloced_pages;
-
-	alloced_pages = zs_get_total_pages(zram->mem_pool);
-	update_used_max(zram, alloced_pages);
+	if (!zram->limit_pages)
+		return true;
 
-	return !zram->limit_pages || alloced_pages <= zram->limit_pages;
+	return zs_get_total_pages(zram->mem_pool) <= zram->limit_pages;
 }
 
 #if PAGE_SIZE != 4096
@@ -2266,10 +2265,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (!zram_can_store_page(zram)) {
-		zs_free(zram->mem_pool, handle);
-		return -ENOMEM;
-	}
+	update_used_max(zram);
 
 	src = kmap_local_page(page);
 	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
@@ -2308,6 +2304,9 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	if (same_filled)
 		return write_same_filled_page(zram, element, index);
 
+	if (!zram_can_store_page(zram))
+		return -ENOMEM;
+
 	zstrm = zcomp_cstrm_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	mem = kmap_local_page(page);
 	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
@@ -2333,11 +2332,7 @@ static int zram_write_page(struct zram *zram, struct page *page,
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
2.56.0.506.g506a7eabc5-goog

