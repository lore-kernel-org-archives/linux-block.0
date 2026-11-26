Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728233;
	b=PX40iOm74a2sFK9eoUhkwMMyQ4mK1RXFdcukNnxHJraT/DO6Qow6NcgPmYUaB3cKjC1b
	 y9fYS88fEpCSY5qVaFz1Q6gPmejZXsw5ub+X9lfohQLMZd5lDgnzOWHxPjD32qHEedqjT
	 lU3SUNzhzyYWc+6L68TSbQtqzZohj7JK9wF3YL94+zPQozrhb2tMq72Bee/oY3LCoBS71
	 +tAAwk/nE7vBNzE9ztG5CUNYgNTVHxXFeKna4NJPc9Z+txfBTCXNZAvJ1yiwZXleUkuF2
	 ngmWRUrXdqosSM3cHJxBRZIdYmVsHzeTqJ/1Hjfxb/F7Xbuv2bLI4Lb79y85hnMQEXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=iP88VGMQqYPY9tqyK1WeqNOSQjFHUiNrnQBhzpSn6VA=;
	b=JMLn6N9H12ClgLsTsCtuxXN6iJLL0SjpNMwyy4nAkUhiiMq8MwpWQ1ZWiv1Wd2JmR0Dd
	 jAB/KIZNTKZpowroxdayoWrSLyjOnAwoxQueQgJsMF+Wyk6yKIXlvtHXy45Naj2En1Pii
	 33VgoQLMKdkGcErWWMssWVdW5GdyK/XiOAI/80KWcaj5IbhoATnjsbavz/SB4h+du2swk
	 V8d/xwxXENNNApL/MWb8iM4nrzYYrDKUW73HGk4n6gI58dpkqp0cu7CUkemv+WGVmpqhK
	 3rAPbnK15w3V19H80xAf1KrHMPYH2GUn2VR1Pmht7dgI6LJWWMEhdnA+Xjh+Rk/Pkig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mdxmg5pr;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57450606A31C
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 21:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57450606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mdxmg5pr
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3ae17c536so6834441c88.0
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 13:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795728232; x=1796333032; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iP88VGMQqYPY9tqyK1WeqNOSQjFHUiNrnQBhzpSn6VA=;
        b=mdxmg5preWu+58bNH2be8D202C1ncPLxCAMePMje/UOdhNzE5X8mYesm9Y8D7hrX3b
         ze+Rkp5lz4i8j2KwS6dVxHhAGLESvaJgjsLByH+XyvZgqZOIpj0RH/U9kbmmLtr020H+
         cdRTynP5Ya2n8XNLC6JYQao+FP1rpi5fHBurgyygySdlqK2TA3NUCuhxDmfEMJPKmNnZ
         xUCtZd9aaug4q8wrjyKZNlFO8i/HRgsMr1C25Y9Lly4XzdjuC5Clwyb72RaegTiK9kqX
         C+zFEBxIhN+AHwoBY3rYYhVIMbM44ZFwjCam9BmMU/X6nDm65v+MgugUbFX/e1DOB3fA
         kUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728232; x=1796333032;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iP88VGMQqYPY9tqyK1WeqNOSQjFHUiNrnQBhzpSn6VA=;
        b=yfulUjc18bQQvDgyjPi/O3zYv2vASf4Sy5YTYqnniKt4W5gh4BiHErJqHUZY6TnqF0
         zm0cbbl6hLLDR0FSCdzNTPFb5Mr2uMji6ffebvr0MGSmExqanIH4f+dsXhtkgcQG8NjS
         FzJXvoshOSwDnDhm4TUSH2xd6+ASvR3ARGGY3ZEaf3mpXGMPwhk+A5nCoOJQ6QfxizGM
         nmJTcTSheEJXIBDfia1laav8sUvVhmlXLLsCfbM4RSEZj+8KgoAuw+69MLPlr2vOvBu0
         3T/cwOFQKvrG0HR4OMkpGEh08Zz4qZkm3AGrq07XS9XJ89yvEmGr5ZwWAlY0CU+EmbqP
         g6fQ==
X-Forwarded-Encrypted: i=1; AL+hErFiLBjYGX76izzifMc1dS8sZKxMBnkOO3VakwY9hmLvIJKAfbX9jQxXJGt046c+Wz3EGpRqIjJLdK+J4g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/nFRB6G4IJfr/oaZXrMGdykLnP+LiF8jNjR6UHkd5LulzXfNRl
	pDtohFcUVRrmLe6FAz8WraMazfzdgdBylcEYgz0WjrwbEqqMFPzGWEKj9FNlS3CPbc7xi22fovO
	N5rmLqh6FU2FV9zBMEqf4Zw==
X-Received: from dlaf15.prod.google.com ([2002:a05:701b:240f:b0:195:cde8:ab41])
 (user=nilayvaish job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e886:b0:1ac:2f6d:e1c6 with SMTP id a92af1059eb24-1b5568a4f42mr28464634c88.6.1795728231799;
 Thu, 26 Nov 2026 13:23:51 -0800 (PST)
Date: Thu, 26 Nov 2026 13:23:40 -0800
In-Reply-To: <20261126212341.916839-1-nilayvaish@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126212341.916839-1-nilayvaish@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126212341.916839-2-nilayvaish@google.com>
Subject: [PATCH v2 1/2] null_blk: convert the page stores to XArray
From: Nilay Vaish <nilayvaish@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
	Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"

The memory-backed store and its cache keep their pages in two radix
trees. Convert both to XArray, the interface that replaced the radix
tree API.

A page is inserted under nullb->lock, where the store cannot sleep. The
radix tree code preloaded nodes before taking the lock. With the XArray,
drop the lock when the store runs out of memory, let xas_nomem()
allocate, and retry.

XArray iteration reports the index of each entry, so freeing the device
storage no longer needs to look it up through the page.

A store that runs out of memory partway can leave empty nodes in the
array until the retry completes, or for good if the retry cannot
allocate either. So check that the cache holds no page after a flush
with xa_find() instead of xa_empty(), and call xa_destroy() when the
storage is freed.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Nilay Vaish <nilayvaish@google.com>
---

Notes:
    These patches were written with the help of an AI coding assistant (Gemini).

 drivers/block/null_blk/main.c     | 134 +++++++++++++++---------------
 drivers/block/null_blk/null_blk.h |   4 +-
 2 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index ec0d7ba4d938..e073eca48655 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -797,8 +797,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->init_hctx_fault_config.attr = null_init_hctx_attr;
 #endif
 
-	INIT_RADIX_TREE(&dev->data, GFP_ATOMIC);
-	INIT_RADIX_TREE(&dev->cache, GFP_ATOMIC);
+	xa_init(&dev->data);
+	xa_init(&dev->cache);
 	if (badblocks_init(&dev->badblocks, 0)) {
 		kfree(dev);
 		return NULL;
@@ -911,18 +911,18 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	unsigned int sector_bit;
 	u64 idx;
 	struct nullb_page *t_page, *ret;
-	struct radix_tree_root *root;
+	struct xarray *xa;
 
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
+	xa = is_cache ? &nullb->dev->cache : &nullb->dev->data;
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	sector_bit = (sector & SECTOR_MASK);
 
-	t_page = radix_tree_lookup(root, idx);
+	t_page = xa_load(xa, idx);
 	if (t_page) {
 		__clear_bit(sector_bit, t_page->bitmap);
 
 		if (null_page_empty(t_page)) {
-			ret = radix_tree_delete_item(root, idx, t_page);
+			ret = xa_erase(xa, idx);
 			WARN_ON(ret != t_page);
 			null_free_page(ret);
 			if (is_cache)
@@ -931,47 +931,18 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	}
 }
 
-static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
-	struct nullb_page *t_page, bool is_cache)
-{
-	struct radix_tree_root *root;
-
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
-
-	if (radix_tree_insert(root, idx, t_page)) {
-		null_free_page(t_page);
-		t_page = radix_tree_lookup(root, idx);
-		WARN_ON(!t_page || t_page->page->private != idx);
-	} else if (is_cache)
-		nullb->dev->curr_cache += PAGE_SIZE;
-
-	return t_page;
-}
-
 static void null_free_device_storage(struct nullb_device *dev, bool is_cache)
 {
-	unsigned long pos = 0;
-	int nr_pages;
-	struct nullb_page *ret, *t_pages[FREE_BATCH];
-	struct radix_tree_root *root;
-
-	root = is_cache ? &dev->cache : &dev->data;
-
-	do {
-		int i;
-
-		nr_pages = radix_tree_gang_lookup(root,
-				(void **)t_pages, pos, FREE_BATCH);
-
-		for (i = 0; i < nr_pages; i++) {
-			pos = t_pages[i]->page->private;
-			ret = radix_tree_delete_item(root, pos, t_pages[i]);
-			WARN_ON(ret != t_pages[i]);
-			null_free_page(ret);
-		}
+	struct xarray *xa = is_cache ? &dev->cache : &dev->data;
+	struct nullb_page *t_page;
+	unsigned long idx;
 
-		pos++;
-	} while (nr_pages == FREE_BATCH);
+	xa_for_each(xa, idx, t_page) {
+		xa_erase(xa, idx);
+		null_free_page(t_page);
+	}
+	/* A failed insert can leave empty nodes behind. */
+	xa_destroy(xa);
 
 	if (is_cache)
 		dev->curr_cache = 0;
@@ -983,13 +954,13 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 	unsigned int sector_bit;
 	u64 idx;
 	struct nullb_page *t_page;
-	struct radix_tree_root *root;
+	struct xarray *xa;
 
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	sector_bit = (sector & SECTOR_MASK);
 
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
-	t_page = radix_tree_lookup(root, idx);
+	xa = is_cache ? &nullb->dev->cache : &nullb->dev->data;
+	t_page = xa_load(xa, idx);
 	WARN_ON(t_page && t_page->page->private != idx);
 
 	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
@@ -1015,8 +986,10 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 	__releases(&nullb->lock)
 	__acquires(&nullb->lock)
 {
-	u64 idx;
-	struct nullb_page *t_page;
+	struct xarray *xa = ignore_cache ? &nullb->dev->data : &nullb->dev->cache;
+	u64 idx = sector >> PAGE_SECTORS_SHIFT;
+	XA_STATE(xas, xa, idx);
+	struct nullb_page *t_page, *cur;
 
 	t_page = null_lookup_page(nullb, sector, true, ignore_cache);
 	if (t_page)
@@ -1027,15 +1000,37 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 	t_page = null_alloc_page();
 	if (!t_page)
 		goto out_lock;
+	t_page->page->private = idx;
+
+	/*
+	 * The store has to happen under nullb->lock, where it cannot sleep.
+	 * If it runs out of memory, drop the lock, let xas_nomem() allocate
+	 * and try again.
+	 */
+	do {
+		spin_lock_irq(&nullb->lock);
+		xas_lock(&xas);
+		cur = xas_load(&xas);
+		if (!cur)
+			xas_store(&xas, t_page);
+		xas_unlock(&xas);
+		if (!xas_error(&xas))
+			break;
+		spin_unlock_irq(&nullb->lock);
+	} while (xas_nomem(&xas, GFP_NOIO));
 
-	if (radix_tree_preload(GFP_NOIO))
+	if (xas_error(&xas))
 		goto out_freepage;
+	xas_destroy(&xas);
 
-	spin_lock_irq(&nullb->lock);
-	idx = sector >> PAGE_SECTORS_SHIFT;
-	t_page->page->private = idx;
-	t_page = null_radix_tree_insert(nullb, idx, t_page, !ignore_cache);
-	radix_tree_preload_end();
+	if (cur) {
+		/* Somebody else inserted a page while the lock was dropped. */
+		null_free_page(t_page);
+		WARN_ON(cur->page->private != idx);
+		return cur;
+	}
+	if (!ignore_cache)
+		nullb->dev->curr_cache += PAGE_SIZE;
 
 	return t_page;
 out_freepage:
@@ -1050,7 +1045,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	int i;
 	unsigned int offset;
 	u64 idx;
-	struct nullb_page *t_page, *ret;
+	struct nullb_page *t_page;
 	void *dst, *src;
 
 	idx = c_page->page->private;
@@ -1061,8 +1056,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	if (test_bit(NULLB_PAGE_FREE, c_page->bitmap)) {
 		null_free_page(c_page);
 		if (t_page && null_page_empty(t_page)) {
-			ret = radix_tree_delete_item(&nullb->dev->data,
-				idx, t_page);
+			xa_erase(&nullb->dev->data, idx);
 			null_free_page(t_page);
 		}
 		return 0;
@@ -1087,8 +1081,8 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	kunmap_local(dst);
 	kunmap_local(src);
 
-	ret = radix_tree_delete_item(&nullb->dev->cache, idx, c_page);
-	null_free_page(ret);
+	xa_erase(&nullb->dev->cache, idx);
+	null_free_page(c_page);
 	nullb->dev->curr_cache -= PAGE_SIZE;
 
 	return 0;
@@ -1097,16 +1091,21 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 {
 	int i, err, nr_pages;
-	struct nullb_page *c_pages[FREE_BATCH];
-	unsigned long flushed = 0, one_round;
+	struct nullb_page *c_pages[FREE_BATCH], *c_page;
+	unsigned long flushed = 0, one_round, idx;
 
 again:
 	if ((nullb->dev->cache_size * 1024 * 1024) >
 	     nullb->dev->curr_cache + n || nullb->dev->curr_cache == 0)
 		return 0;
 
-	nr_pages = radix_tree_gang_lookup(&nullb->dev->cache,
-			(void **)c_pages, nullb->cache_flush_pos, FREE_BATCH);
+	nr_pages = 0;
+	xa_for_each_start(&nullb->dev->cache, idx, c_page,
+			  nullb->cache_flush_pos) {
+		c_pages[nr_pages++] = c_page;
+		if (nr_pages == FREE_BATCH)
+			break;
+	}
 	/*
 	 * nullb_flush_cache_page could unlock before using the c_pages. To
 	 * avoid race, we don't allow page free
@@ -1229,6 +1228,7 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
 
 static blk_status_t null_handle_flush(struct nullb *nullb)
 {
+	unsigned long idx = 0;
 	int err;
 
 	if (!null_cache_active(nullb))
@@ -1242,7 +1242,11 @@ static blk_status_t null_handle_flush(struct nullb *nullb)
 			break;
 	}
 
-	WARN_ON(!radix_tree_empty(&nullb->dev->cache));
+	/*
+	 * No page may be left. Do not use xa_empty(): an insert that ran out
+	 * of memory can leave empty nodes in the array.
+	 */
+	WARN_ON(xa_find(&nullb->dev->cache, &idx, ULONG_MAX, XA_PRESENT));
 	spin_unlock_irq(&nullb->lock);
 	return errno_to_blk_status(err);
 }
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 6c4c4bbe7dad..8ae2b9128e64 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -58,8 +58,8 @@ struct nullb_device {
 	struct fault_config requeue_config;
 	struct fault_config init_hctx_fault_config;
 #endif
-	struct radix_tree_root data; /* data stored in the disk */
-	struct radix_tree_root cache; /* disk cache data */
+	struct xarray data; /* data stored in the disk */
+	struct xarray cache; /* disk cache data */
 	unsigned long flags; /* device flags */
 	unsigned int curr_cache;
 	struct badblocks badblocks;
-- 
2.56.1.839.g22a8290db9-goog

