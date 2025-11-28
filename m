Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FF2BDC3D
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349518; cv=none; b=teI4tGfndRWG89XPVRCcAoNyupwmFOyqKFMD2Oc0kyqRzpNf1ZiDDb4VpX6Rm6Df4mJHznzxXaxpg7DAwqaaxez2g6+UMXDdLW8Au2K5hqDxLHW25eka+q4WczXgEP99A3CYwR5aS7ebbBduacrr7jYNMXILY2cuAhjoCB4rUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349518; c=relaxed/simple;
	bh=tjtNKjHFACpjoxSJpUor60yVv8ajM/HPAU18nvdLOME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNBKHYHdhCXBqd6w7OiOq5WyoIUieUKLozmq6Dv3PpOfsxo0HXgWdIPFT4hrSRGzDqTX0iEd8NoJKHHtOtaDaGeIQsZnU2K2QXsMoXuuqrqqPBVjb5bYvMoxC6pE7gJVUv41IsC0zZ+KvVZcR+YBcTZ6n44+qJkPIB0IiXipmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LVu/plq+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVu/plq+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so2561890b3a.2
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 09:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764349516; x=1764954316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLXj0jbz9Wuo33iBrbj/6+Wb1xjJkFIW5VwB+h6O148=;
        b=LVu/plq+oNwN4HvCkawuFHtZZ/H2YZlJEyjxtVsyKK/pgc8WTSOks51Pv6pOFKJXaE
         gW7kVnANLNYbq2w8ukv7I4vjqnIUm+YjnFo2BETefp30XNtz9Tn3AyuBKjiMgknQeYJL
         /2EqxHhc6/cUgc2RXcjkilcFnjyUoGU8r2Wi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764349516; x=1764954316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLXj0jbz9Wuo33iBrbj/6+Wb1xjJkFIW5VwB+h6O148=;
        b=c9YR40dQX8eWNL4spPANzCKDl/HtWc7AfgPfISV+gd9CxDrZ9bBTueoUhvXN87j8fu
         nS43lMoKIljpAgKwl8adQ1LG8qOtDQT2jadxnoZTff7uyyl2V9Gp2Hs/ETIFRcpoI9qA
         KHoqySDmgqVkNnFWorNi6xrsbRvDgpj6kOWZ81QDEJB1bn2pdMajIUZjGU/kq5VxgMJM
         FL6ZfjpTnNQZQjFCY/zLqq/FlHlBwA+uq1LVdZD6a6/gOIUMA7DyK7xO+RNL6m3v0Bjy
         18NRkCUxr63xSrOj7Kyy3Gghj6c0ONqX/zKts4G4fNX1P5tqdafCAg7LW9RD1XMvaozL
         uW9w==
X-Forwarded-Encrypted: i=1; AJvYcCUv6hNvkBcYNdV8mhG2eBv8vg+HZRZWD23R1HdvqOhcOdl7AQKhHjQQr+lZ5fvn2lG4HQL9GQF9YwE3cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0oIW0gU0BvwYywskApMM5xwtRSD6ANMxMMrWe7lBqVxh3/rP
	T+70hK9/KgmFDIyiKunZLwjsjrKO0k1mHUcNYfa2/Oy2QoGU+WVgWzP4tYk58ZYRNIfqfHSnIAw
	anNE=
X-Gm-Gg: ASbGncvhzAOD5ZsXdtAz/wN7D0x5hrSyvC75qDFr/h/mV55AxrmA7wsnAR+nTo6QmUC
	t4C93T6D3ROnmTjy5S5Ho4g3IWeNdr4Lj4SDKwitalcUUslVM0ajAC0bs8cA9QbqBTzszG69NOh
	TASsTwUYWT9n/mpoaAuXbbwIywTvgV/FD7ahnBW6mOJeg4IPHN1Dt98jGbs84VRgvCNeK8W4hR8
	axQ+3gWd84DbA+gif99DeVLSzky1mbvu4F+3HZG5tZ5UXG5khVS/UlPXejJxuabgD6u2AsKUQBt
	59ZJmDLMVgAwWqbWizSOJJp+C7HF1vyaaSPrHCVgPN8th4qLMI+L7c2y3a51gWX4OaODJpg4Pkx
	XQPnTk0AwmGiDnf3GREldrlFcMSDGmH5U+OgX1U4O5bbtnveFRKA1Gk3oKLw9+XE5N8qKMo1Q9r
	ZgcIEQb2MQE0kIh5VerQdFOO79glaLxOiuLy33gs8QxDexVBWsSgBDZIMbuVvtsQ6B2fLxTAc6T
	A==
X-Google-Smtp-Source: AGHT+IE3jdJ6BIGqZ/LrNySLI1gtSZu3kZ9H40LQzsOxlINAJwUkQtChjQ8P16I/r4Kq7vGDlsgVJw==
X-Received: by 2002:a05:6a21:3285:b0:35d:35a1:95d1 with SMTP id adf61e73a8af0-36150e27992mr26945189637.9.1764349515420;
        Fri, 28 Nov 2025 09:05:15 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:5b9f:6c7b:4d09:6126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150c5e611sm5568242b3a.6.2025.11.28.09.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:05:15 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@google.com>
Subject: [PATCH 1/2] zram: introduce compressed data writeback
Date: Sat, 29 Nov 2025 02:04:41 +0900
Message-ID: <20251128170442.2988502-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
In-Reply-To: <20251128170442.2988502-1-senozhatsky@chromium.org>
References: <20251128170442.2988502-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Chang <richardycc@google.com>

zram stores all written back slots raw, which implies that
during writeback zram first has to decompress slots (except
for ZRAM_HUGE slots, which are raw already).  The problem
with this approach is that not every written back page gets
read back (either via read() or via page-fault), which means
that zram basically wastes CPU cycles and battery decompressing
such slots.  This changes with introduction of decompression
on demand, in other words decompression on read()/page-fault.

One caveat of decompression on demand is that async read
is completed in IRQ context, while zram decompression is
sleepable.  To workaround this, read-back decompression
is offloaded to a preemptible context - system high-prio
work-queue.

Signed-off-by: Richard Chang <richardycc@google.com>
Co-developed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Suggested-by: Minchan Kim <minchan@google.com>
Suggested-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 240 +++++++++++++++++++++++++++-------
 1 file changed, 192 insertions(+), 48 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5759823d6314..eef6c0a675b5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,8 +57,8 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 
 static void zram_free_page(struct zram *zram, size_t index);
-static int zram_read_from_zspool(struct zram *zram, struct page *page,
-				 u32 index);
+static int zram_read_from_zspool_raw(struct zram *zram, struct page *page,
+				     u32 index);
 
 #define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
 
@@ -522,6 +522,22 @@ struct zram_wb_req {
 	struct list_head entry;
 };
 
+struct zram_rb_req {
+	struct work_struct work;
+	struct zram *zram;
+	struct page *page;
+	/* The read bio for backing device */
+	struct bio *bio;
+	unsigned long blk_idx;
+	union {
+		/* The original bio to complete (async read) */
+		struct bio *parent;
+		/* error status (sync read) */
+		int error;
+	};
+	u32 index;
+};
+
 static ssize_t writeback_limit_enable_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
@@ -780,18 +796,6 @@ static void zram_release_bdev_block(struct zram *zram, unsigned long blk_idx)
 	atomic64_dec(&zram->stats.bd_count);
 }
 
-static void read_from_bdev_async(struct zram *zram, struct page *page,
-			unsigned long entry, struct bio *parent)
-{
-	struct bio *bio;
-
-	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
-	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
-	__bio_add_page(bio, page, PAGE_SIZE, 0);
-	bio_chain(bio, parent);
-	submit_bio(bio);
-}
-
 static void release_wb_req(struct zram_wb_req *req)
 {
 	__free_page(req->page);
@@ -886,8 +890,9 @@ static void zram_account_writeback_submit(struct zram *zram)
 
 static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 {
-	u32 index = req->pps->index;
-	int err;
+	u32 size, index = req->pps->index;
+	int err, prio;
+	bool huge;
 
 	err = blk_status_to_errno(req->bio.bi_status);
 	if (err) {
@@ -914,9 +919,22 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 		goto out;
 	}
 
+	/*
+	 * ZRAM_WB slots get freed, we need to preserve data required for
+	 * read decompression.
+	 */
+	size = zram_get_obj_size(zram, index);
+	prio = zram_get_priority(zram, index);
+	huge = zram_test_flag(zram, index, ZRAM_HUGE);
+
 	zram_free_page(zram, index);
 	zram_set_flag(zram, index, ZRAM_WB);
+	if (huge)
+		zram_set_flag(zram, index, ZRAM_HUGE);
 	zram_set_handle(zram, index, req->blk_idx);
+	zram_set_obj_size(zram, index, size);
+	zram_set_priority(zram, index, prio);
+
 	atomic64_inc(&zram->stats.pages_stored);
 
 out:
@@ -1050,7 +1068,7 @@ static int zram_writeback_slots(struct zram *zram,
 		 */
 		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		if (zram_read_from_zspool(zram, req->page, index))
+		if (zram_read_from_zspool_raw(zram, req->page, index))
 			goto next;
 		zram_slot_unlock(zram, index);
 
@@ -1313,24 +1331,123 @@ static ssize_t writeback_store(struct device *dev,
 	return ret;
 }
 
-struct zram_work {
-	struct work_struct work;
-	struct zram *zram;
-	unsigned long entry;
-	struct page *page;
-	int error;
-};
+static int decompress_bdev_page(struct zram *zram, struct page *page, u32 index)
+{
+	struct zcomp_strm *zstrm;
+	unsigned int size;
+	int ret, prio;
+	void *src;
+
+	zram_slot_lock(zram, index);
+	/* Since slot was unlocked we need to make sure it's still ZRAM_WB */
+	if (!zram_test_flag(zram, index, ZRAM_WB)) {
+		zram_slot_unlock(zram, index);
+		/* We read some stale data, zero it out */
+		memset_page(page, 0, 0, PAGE_SIZE);
+		return -EIO;
+	}
+
+	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
+		zram_slot_unlock(zram, index);
+		return 0;
+	}
+
+	size = zram_get_obj_size(zram, index);
+	prio = zram_get_priority(zram, index);
+
+	zstrm = zcomp_stream_get(zram->comps[prio]);
+	src = kmap_local_page(page);
+	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size,
+			       zstrm->local_copy);
+	if (!ret)
+		copy_page(src, zstrm->local_copy);
+	kunmap_local(src);
+	zcomp_stream_put(zstrm);
+	zram_slot_unlock(zram, index);
+
+	return ret;
+}
+
+static void zram_deferred_decompress(struct work_struct *w)
+{
+	struct zram_rb_req *req = container_of(w, struct zram_rb_req, work);
+	struct page *page = bio_first_page_all(req->bio);
+	struct zram *zram = req->zram;
+	u32 index = req->index;
+	int ret;
+
+	ret = decompress_bdev_page(zram, page, index);
+	if (ret)
+		req->parent->bi_status = BLK_STS_IOERR;
+
+	/* Decrement parent's ->remaining */
+	bio_endio(req->parent);
+	bio_put(req->bio);
+	kfree(req);
+}
+
+static void zram_async_read_endio(struct bio *bio)
+{
+	struct zram_rb_req *req = bio->bi_private;
+
+	if (bio->bi_status) {
+		req->parent->bi_status = bio->bi_status;
+		bio_endio(req->parent);
+		bio_put(bio);
+		kfree(req);
+		return;
+	}
 
-static void zram_sync_read(struct work_struct *work)
+	/*
+	 * zram decompression is sleepable, so we need to deffer it to
+	 * a preemptible context.
+	 */
+	INIT_WORK(&req->work, zram_deferred_decompress);
+	queue_work(system_highpri_wq, &req->work);
+}
+
+static void read_from_bdev_async(struct zram *zram, struct page *page,
+				 u32 index, unsigned long blk_idx,
+				 struct bio *parent)
 {
-	struct zram_work *zw = container_of(work, struct zram_work, work);
+	struct zram_rb_req *req;
+	struct bio *bio;
+
+	req = kmalloc(sizeof(*req), GFP_NOIO);
+	if (!req)
+		return;
+
+	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
+	if (!bio) {
+		kfree(req);
+		return;
+	}
+
+	req->zram = zram;
+	req->index = index;
+	req->blk_idx = blk_idx;
+	req->bio = bio;
+	req->parent = parent;
+
+	bio->bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
+	bio->bi_private = req;
+	bio->bi_end_io = zram_async_read_endio;
+
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
+	bio_inc_remaining(parent);
+	submit_bio(bio);
+}
+
+static void zram_sync_read(struct work_struct *w)
+{
+	struct zram_rb_req *req = container_of(w, struct zram_rb_req, work);
 	struct bio_vec bv;
 	struct bio bio;
 
-	bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
-	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
-	zw->error = submit_bio_wait(&bio);
+	bio_init(&bio, req->zram->bdev, &bv, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
+	__bio_add_page(&bio, req->page, PAGE_SIZE, 0);
+	req->error = submit_bio_wait(&bio);
 }
 
 /*
@@ -1338,39 +1455,41 @@ static void zram_sync_read(struct work_struct *work)
  * chained IO with parent IO in same context, it's a deadlock. To avoid that,
  * use a worker thread context.
  */
-static int read_from_bdev_sync(struct zram *zram, struct page *page,
-				unsigned long entry)
+static int read_from_bdev_sync(struct zram *zram, struct page *page, u32 index,
+			       unsigned long blk_idx)
 {
-	struct zram_work work;
+	struct zram_rb_req req;
 
-	work.page = page;
-	work.zram = zram;
-	work.entry = entry;
+	req.page = page;
+	req.zram = zram;
+	req.blk_idx = blk_idx;
 
-	INIT_WORK_ONSTACK(&work.work, zram_sync_read);
-	queue_work(system_dfl_wq, &work.work);
-	flush_work(&work.work);
-	destroy_work_on_stack(&work.work);
+	INIT_WORK_ONSTACK(&req.work, zram_sync_read);
+	queue_work(system_dfl_wq, &req.work);
+	flush_work(&req.work);
+	destroy_work_on_stack(&req.work);
 
-	return work.error;
+	if (!req.error)
+		return decompress_bdev_page(zram, page, index);
+	return req.error;
 }
 
-static int read_from_bdev(struct zram *zram, struct page *page,
-			unsigned long entry, struct bio *parent)
+static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
+			  unsigned long blk_idx, struct bio *parent)
 {
 	atomic64_inc(&zram->stats.bd_reads);
 	if (!parent) {
 		if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
 			return -EIO;
-		return read_from_bdev_sync(zram, page, entry);
+		return read_from_bdev_sync(zram, page, index, blk_idx);
 	}
-	read_from_bdev_async(zram, page, entry, parent);
+	read_from_bdev_async(zram, page, index, blk_idx, parent);
 	return 0;
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-static int read_from_bdev(struct zram *zram, struct page *page,
-			unsigned long entry, struct bio *parent)
+static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
+			  unsigned long blk_idx, struct bio *parent)
 {
 	return -EIO;
 }
@@ -1977,6 +2096,31 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	return ret;
 }
 
+static int zram_read_from_zspool_raw(struct zram *zram, struct page *page,
+				     u32 index)
+{
+	struct zcomp_strm *zstrm;
+	unsigned long handle;
+	unsigned int size;
+	void *src;
+
+	handle = zram_get_handle(zram, index);
+	size = zram_get_obj_size(zram, index);
+
+	/*
+	 * We need to get stream just for ->local_copy buffer, in
+	 * case if object spans two physical pages. No decompression
+	 * takes place here, as we read raw compressed data.
+	 */
+	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
+	src = zs_obj_read_begin(zram->mem_pool, handle, zstrm->local_copy);
+	memcpy_to_page(page, 0, src, size);
+	zs_obj_read_end(zram->mem_pool, handle, src);
+	zcomp_stream_put(zstrm);
+
+	return 0;
+}
+
 /*
  * Reads (decompresses if needed) a page from zspool (zsmalloc).
  * Corresponding ZRAM slot should be locked.
@@ -2012,7 +2156,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		 * device.
 		 */
 		zram_slot_unlock(zram, index);
-		ret = read_from_bdev(zram, page, blk_idx, parent);
+		ret = read_from_bdev(zram, page, index, blk_idx, parent);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
-- 
2.52.0.487.g5c8c507ade-goog

