Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854087;
	b=geyVZ/+kZXYZ63FyRuJXOngetB/+dDAmUwboU7sDafQU33jRDn7Y5ljjAE6GfX+LZgg3
	 SERSyUr1+bTKaQ0ygPCo/q6UNmwEE0f3J7FUt0JjPagSdAo8wlF7dyHemnZ9ZsfLKZH3b
	 IE19c6+XAZ+ztTxApy+af8q9C5I4PNuAKTuyGZnhBKjwvCk4fuFwi+ccwvVaT1rfu3FTv
	 In8pVPrDGzPX2iNV8QmGJZwvcN6gvIMmYL5B9vaLUENDYch8dX0AweP+MwIhV5eAMA4Be
	 iraK5InpD9mTIdIlqL3mdtNisnfwDEY3rRmmtF5lW4xSqavvvYnyjLrHSwsHH6EbxjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zjrFI2LAiEBxbMGOO9GEbnSWXVWxtBu2H3xiPKEbLJY=;
	b=DG+T8c/Vb9P9MA+pvLeslY99gOLTKeWD50BvQ1urWGDs0/EasPZYzR8VoMYxtdXRJQNv
	 3AqaqOrT0rZ/YAZiciX+VyOlHxdeMtMT4nqP/yxE8odK+0WHEtl+/icLiuf4XuNtXlcMT
	 cvPudBBXtF8W+XU/7ymJzLVs7Eu1h4paSLmQuMCn7fbqkQCJp4A46aB4kfVUZLbOdJwB6
	 GK3lNNIeSmOeoBTqa8ybSNOItCVcieKrZZUdmtlu2PSofjA7lJnymvvYdlLv0n3jn98Oo
	 RIABv9th/A2i8HActJUxKN9gUBGbeuq4tBwJ6O9SRAnGLBuqxtwzlH8H6EiTy1wZTSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oZr+IZxn;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE2606D804
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 04:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEBE2606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oZr+IZxn
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3819817eec.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 20:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793854086; x=1794458886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjrFI2LAiEBxbMGOO9GEbnSWXVWxtBu2H3xiPKEbLJY=;
        b=oZr+IZxn3DZRW37A8SjBdVtPYAbkITq/Nbkfu2w7ppX0AQ3S2Y/bqAIskBC4bn3ifZ
         iujXoi5hx2F+A9HzV+HPzlc3RGbklHbrhI6DH+KwD0T7kfocHYwbsurberJDjKkr1ifR
         uwVC82EzVKb7h0lXJ6YMxqGS54EDQZ5vRFWXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854086; x=1794458886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjrFI2LAiEBxbMGOO9GEbnSWXVWxtBu2H3xiPKEbLJY=;
        b=EdXbpet66SVpjrFjxEW1rFBOLFP+9H7egzFoRNe2De8bOuiWLfbUACYlSPuFz2GIXW
         XMjUcdN+3vStiNBotyxE7Ws9kR3Sfn3ror+QSmcBU4Yzzr1p+wNHxssLfexutA0luQBd
         r4oNwsZNkHmipOU5HAe4aDM8Eh+EzmKPu2AnO9t5S8DtMpCh/wH+3kaSs4/0Hrz/fG6l
         SUqj/PHFYpY51hNpI2leSFUqcua2Qs29WTCW5H8eDJzX+CCLrofDlaj1KAjIsOoMB4EO
         6dXHdrnffFaNpDAefEhJFbgSmfneWNSMJocnTqMgmpJc6FmD08yzUQGV8PjGYVO3kLOQ
         w7/g==
X-Forwarded-Encrypted: i=1; AKwUvBzLOi9Mt24tYt1w4nKFnMCX0q928l2FJffOjpapPI3FwMUC9Vzfv3SxA5b1RvAbhlafTUmH/mdI7mxLjQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+iixyLws9HDT165BJ7zQFMpSyedDmI3/SrebXqW3wQCEGPJ57k
	dxb24wMwfpVGGNBG8y8Tc9XkOHJO9mKg7yYqsZThCn9qz7saV1feUNVvOTSTdNRKEw==
X-Gm-Gg: AYBFou3TmOSChSLdQK0JUl16vMyNbfX/EiW4P5MfzdmjhhGmYBHIoqICgMar0kKyI7c
	0VVD003RGxDylTW/ZTpXs+PgvSrTafr4Lamfh6LdSgOy7tT3KZifDHFGlaFc0olWaaBj21BUmAz
	s/9zX04oRjjozRQl/NLABJgslRwLunvMC/p5UU1w26a404Jnm1Qn+OC3+DO7xR7eKmO+JBRI4Mc
	WsTQki8DDyNSX+AA7qm2iSnGH+z9bvg5RaPbxQa48TN6EaFqDcYGEXlnZXDIHvUOijr/hweY4/C
	XApzOAsPGZNa1sd4NbmEQY5XZ49tY3TKx0PP+WvKUq54/GAZ1BRsZ3N36wNm3ROAtYaPzXrWua/
	aJbZmRpVF/XgY+xWu50um3YAyWQ1ggDWwgAn4mzjG2oZw8zrnQLuBPyUniz4Cww+7ea6LccOcBG
	atTy2t/KXmJ7ibsLvtcRZoSfGkSBggnrYFeulieQB/inEhkHGiLuSw+zOqdkrhcM27rujJaHAdZ
	Vj5+1XoVlaSvX3AJmu+b4wfJb1qkob0z564OPDdIgw2LG184JWRLGwSFkAJLKwvCi/X1wUirysA
	pOJtSg81NbCxOjMZg9cRu8bXgikHfYULg2g+QBSBi9ONg6hiEPLYT1W8uBcjbMCn8EkkXUo6B3K
	mGTFH82wtaxmZdV8EdHce08k45+uhxf9yvo2kit8=
X-Received: by 2002:a05:7022:3b88:b0:16d:1e24:5cc3 with SMTP id a92af1059eb24-1ac5c64c610mr30136742c88.19.1793854085519;
        Wed, 04 Nov 2026 20:48:05 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:37bc:b763:7ec7:65b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm17142927c88.21.2026.11.04.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:48:04 -0800 (PST)
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
Subject: [PATCH 2/7] zram: drop get_slot_handle() and set_slot_handle()
Date: Thu,  5 Nov 2026 13:47:32 +0900
Message-ID: <20261105044752.1997895-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105044752.1997895-1-senozhatsky@chromium.org>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
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
2.56.0.398.g882cbad275-goog

