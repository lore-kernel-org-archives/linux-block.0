Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289732;
	b=3Xgc9PhVYPZNx1+FSznhhcizsfPdWsn0WHZmff0mwq+d+EN1pmTj8dLP3eTTPJvjJYPV
	 QQ+6lw3I/4liZmRXAmU1id/PUlNknDtnpoJx09QsmQiIkGKpo57KYW6kCMLviNGIa4lxh
	 o4SUX83Xd/AbEbwhAr+NjY/49D9CDJgNLSCrXbciw8VlzqzPk4vmz97bwk6i+daQxpgLZ
	 oTQRUm28zim5bLVJCWRwwpAYHiAyat2B7/VWsvUzSeUST1sLI+NuiUxXRq2R1bZQKPOjR
	 TFr57Fy4mOfVuMwqp4bqAsAs8h4UNbB7XkRNkMjzqNbTY2GkyzGVdbhUaSMNYa0HuYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XpnbsjJLLF0pRRHml5avH3sFfAy4a7G34t01Mzwk4xE=;
	b=HBpodi8gG9ErwusxBPI+x/vk9UIp2KnjuKZYJ3h/gVKg2UA6953OnVzaJrjCMWKlbbRj
	 EXJKt6NTZZ3THmq0YIEBGyjRwe1btSNS5hwu7y8BWkmFOS4LaxekRFPfTVSiQT5Ju8xrD
	 Hb0kaAZH8ZTPYUMWaMdZfOzx8cyNjeTw9Itl983MkodhQMmGScSVZdHIsZp1hIpMCN/yW
	 UHfYPP7gXkmi1pEgtWKj12gH8Xx5bUtjPl5BB77CBo92apmmZs7maLQG6RRvb1AUiKE2D
	 C9bigJxlBrXM7EVsv3eZUcONzI3fS1xNVl6EIQo+dCaFoH0y6SzYc9suTHZzihIDxgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=e4KCys2e;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049360A2618
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8049360A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=e4KCys2e
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b271e573adso624913b3a.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289732; x=1794894532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XpnbsjJLLF0pRRHml5avH3sFfAy4a7G34t01Mzwk4xE=;
        b=e4KCys2en/VTZutevJNS6Vowl2RHQ/IdR85AnBozyVnaUn9j/5HVu1s50JpIdhASda
         r4TrstFDhmDemAswHXkHJiQ+/l1c9tHKCWicyslXuZwgUPjlBG5eCA1MS7lqPYd5MC5y
         bADeECnCZTiimpQL9sW+Sh/g9tHd2vLbHbzz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289732; x=1794894532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XpnbsjJLLF0pRRHml5avH3sFfAy4a7G34t01Mzwk4xE=;
        b=2S5tcKBeKQfGydeiJlEnSvXIJwYSnZJRrm8Y0fElmdQRTKK0t79iqpRnLp2weLAyqt
         WON210gWGqBMF6Ui3n43WGVpsDgCnDgHabUn9xgOhUbpL54PkSEPECTnXet/8XpD5r98
         YNSlb4GI0uCjaU1IFBt2BOYqkydL9ZICQWi7CiKCuRK4s0d4Bxk7Xve6vmoCbTduaRXZ
         xICc59QxjwgivGR03YAk+eFjF7DARRIZqwpKXjjjLvICJ+lHAySceso02nkAN9tmUjVU
         CCwynIPZQqLULIhTjij+J4d8GiM26xoSnAjTeKDdvWhzmp69gyjvJGvbBz/w0RriZbya
         oKpA==
X-Forwarded-Encrypted: i=1; AL+hErF+OL7g97yvnM3XGk/a95hL1IAA+c4OnW12jxO4UgvVrAEkOtBkh+D1Nl2eK9vSUfvNVf1oq2cW4INyLw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wwahxHmNH5ME+X4tBvN1FiHNGnJhTgdQlJ1YKhmFpNjw/ysgM
	VUfYX1bP2hJX3qzFqL0vKPZ+b1TZARoczdHQeaXuYtzQ/zzoP93aK6DgS29RCWDUnw==
X-Gm-Gg: AYBFou2FDLnXa9l4cTe4KfubOQwdOqwCBilXad/2ysSU4g1K6i2FF+j1snLysm85Do4
	2U5G1upgGZRtzmLPXfcxnzylcgSK99+UY07tUaGHB1BHpfRVvnAiuLI1Vvp/RqCOnROt5uyjoVh
	Fsul/kS2VHLLILUn+rjlsMMBs1RfEFxIodZrp45IruyWnA1CpFBbsKeXeIoO/Tf6zXJVo2Xwaxk
	IFbs7iD/uN2inbH2f/tEDLq7Wkf1E6CeRr8tTS/Y4eJWzXaTNhjIn+QuS2AmNTOAaRtP6A106Y9
	SdtwogGY7qy23PDJzNgpGHi6322xAZp7o3KJbxBhkbqNHcM9ORe7NRS2j+iLS4p0L+XnCNPwg0Y
	jg1Q6pmw9JGtkEyf7gmpYOqcPuEwAz6UzhCzbm04O9jc7zpAqfXa9jKssMWeX5Wi5Mw5qmEj2po
	56xLqeDziFj4jzC4yXpTSbqAE53HYt5oCfjPgYxGI/+GNJhYvDL8Y1fKi2gvRHoHhiZ5CLAZhiI
	fEMpKyax0qMSgTKHoT+ZUYKxCLNxIr0YhNeP/GhQBUxhIGhqTjXMIEEW0csUOjS27xEDx+4z6ro
	fHB8pAmj/Djm64haXiw8RNKaqyzoT1Au4lwnhS0N9EM/OUx+S1PmIm4S6mwn0Wl6dyW4EMcqlTG
	e9j0jtysZ+finpg6JdcYb930eEla6mQGHm3XgvHQ=
X-Received: by 2002:a17:90b:548c:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3b166a64553mr2044187a91.0.1794289731797;
        Mon, 09 Nov 2026 21:48:51 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:48:51 -0800 (PST)
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
Subject: [PATCH v2 02/11] zram: drop get_slot_handle() and set_slot_handle()
Date: Tue, 10 Nov 2026 14:48:07 +0900
Message-ID: <20261110054836.1515030-3-senozhatsky@chromium.org>
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
2.56.0.506.g506a7eabc5-goog

