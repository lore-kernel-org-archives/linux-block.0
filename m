Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E028DB7E
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944664; cv=none; b=p0aZB4FthkY5kCHIfj5g3axcHAQUYiZx+xf6XMNtHejzd7sCgpMjzhCjVdhJp+mNZzQZRfLRX2nzH6j7xdXR4xIiN6FpMlRNom9j2wdvQys5BxQzAl338vsfU+cFXPClstyLrJsWEisqU9t8vbceBtzZoOAIvjReyIaT2BLFzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944664; c=relaxed/simple;
	bh=x5WHeabDW4C0/9wkwfhqLtOyfNkukvgRdDHl7/2SHkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fk+CdM17/AMMq78msbEZASkEws8ea15lZC2fduRWit6JsVV8RTjhRHVLQsygqvGbR653WDQ64P5xr14Bz3l6D7wcD4BCUAcrViFOQnM7BCCM1zi54aGZa7b+75L9Y4iPIDKRDiUHsF0GfH8Vyy2iowpQjwjixspoHYW6sCgjT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3qzKEPW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3qzKEPW"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4225ab1829so463394a12.0
        for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 23:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753944662; x=1754549462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9HBBhNz4JX/02iQNqHxMkOYIhfKJVrRepRJjtX/gUI=;
        b=S3qzKEPWHwrBoziGB55W2voZZJxWW1Z8KPh/jyK6xSq3AfsVIgDQp0lopqJXYUZgfm
         w4t1/4CZqKX/WASpiRegjLI1lGoLE/u98Jw2Z8dhyKtTJYYiFmxZ5Do3QT2HaOgItShZ
         cLETZGAEm1wGdpgspqwN8k7mrl22QX7zRML0hdg17riF1HtN6dOhlCWL/rcGUpaLEZCr
         XUM+sULGaeSe0HZe/2eIv4kn1SoHpnfirWoGTnKK9GpIu++1jYuVbagr9BScx31gy7qi
         EJiwDFzYXE8eEKTsJKOcaUpsGy4r+3sSVmoE8FHfn2EwTyyLNUDWLGwEpky35UjD50/5
         0Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753944662; x=1754549462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9HBBhNz4JX/02iQNqHxMkOYIhfKJVrRepRJjtX/gUI=;
        b=mgnY5c/JjkoHLPRvdGsW1HccGb+PQWPqGR9UYdYDpsyUTjXEfFJrKZ4WQvS6dO/Xe4
         xNPURnYurMGsNHO/yY7Z2+oU6hCuYnLA4WS7uLb8offt9/ZK8/JL4oAgAupa8JK2CVjA
         mgSv2pME+MYsYBKv7SnSRZi75d+IQFMg61fHPktmAh5NueHD279ohEApRJM6sO/ovYxc
         srfox0NXktdtjNiief1xdIJBZG5zztMx0zFAYdTXJ0kLK/+rmwaySGEiALkLeTyXeU4T
         oiRO1xO8iFuQABqsNFqUBb5wlDr/FbAXOyp8MStc6nY0Jrq6U728/G04HeZgeqMoFWOk
         zEZg==
X-Forwarded-Encrypted: i=1; AJvYcCWE0YkowO1821yR5VohU2KJSCQZ3DiKQzuJnJjGClGYTP3VPdIrpgpoqdPY5P9cXI1siL+53b/CKNNAIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0pK6xSibXJeQNB/0fgctT0OhhbZNSem+Gp2Hcjz7Y9XONzwtd
	DPa7Jak0+nsKlUUYZEg8uQqnS6/LVBMVoShHF8M8RccAZA0Xq8z5Qlt6eHwULKbCAJa28jtDulG
	rlrDg7gEuuuMTmgZwN0Cm
X-Google-Smtp-Source: AGHT+IHwD0DQee4gELDZbn1uwpxGmpeIotkHWXAUCxbVBgG5s7/AREeRYCR5fiI/9tCEtbg+9OUAskPwVsXk7or5
X-Received: from pgbfq19.prod.google.com ([2002:a05:6a02:2993:b0:b1f:fd39:8314])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4322:b0:231:e2e:95e4 with SMTP id adf61e73a8af0-23dc0d57f48mr10285018637.16.1753944661925;
 Wed, 30 Jul 2025 23:51:01 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:49:49 +0000
In-Reply-To: <20250731064949.1690732-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731064949.1690732-1-richardycc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731064949.1690732-4-richardycc@google.com>
Subject: [PATCH v2 3/3] zram: enable asynchronous writeback
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Richard Chang <richardycc@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace the synchronous `submit_bio_wait()` with the non-blocking
`submit_bio()` to perform writeback operations asynchronously. This
leverages the infrastructure added in the previous commit to handle
the completion of I/O operations in a dedicated kthread.

This change shows 27% speed improvement of idle writeback on Android
platform.

Test Flow:
- mkfs on the zram device, mount it
- cp three linux-6.16-rc2.tar.gz tarball files as the data
- do idle writeback
- check bd_stat writes 185072 pages

Test Result:
idle writeback for 185072 4k-pages (~723 MiB)
$ echo all > /sys/block/zram0/idle
$ time echo idle > /sys/block/zram0/writeback

Async writeback:
0m02.49s real     0m00.00s user     0m01.19s system
0m02.32s real     0m00.00s user     0m00.89s system
0m02.35s real     0m00.00s user     0m00.93s system
0m02.29s real     0m00.00s user     0m00.88s system

Sync writeback:
0m03.09s real     0m00.00s user     0m01.07s system
0m03.18s real     0m00.00s user     0m01.12s system
0m03.47s real     0m00.00s user     0m01.16s system
0m03.36s real     0m00.00s user     0m01.27s system

Signed-off-by: Richard Chang <richardycc@google.com>
---
 drivers/block/zram/zram_drv.c | 109 ++++++++++++++--------------------
 drivers/block/zram/zram_drv.h |  11 ++++
 drivers/block/zram/zram_wb.c  | 103 +++++++++++++++++++++++++++++++-
 drivers/block/zram/zram_wb.h  |   6 +-
 4 files changed, 161 insertions(+), 68 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6098c0bb773c..f459d889fa44 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,7 +57,6 @@ static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
 
-static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
 				 u32 index);
 
@@ -96,7 +95,7 @@ static __must_check bool zram_slot_trylock(struct zram *zram, u32 index)
 	return false;
 }
 
-static void zram_slot_lock(struct zram *zram, u32 index)
+void zram_slot_lock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].flags;
 
@@ -105,7 +104,7 @@ static void zram_slot_lock(struct zram *zram, u32 index)
 	lock_acquired(slot_dep_map(zram, index), _RET_IP_);
 }
 
-static void zram_slot_unlock(struct zram *zram, u32 index)
+void zram_slot_unlock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].flags;
 
@@ -128,19 +127,17 @@ static unsigned long zram_get_handle(struct zram *zram, u32 index)
 	return zram->table[index].handle;
 }
 
-static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
+void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 {
 	zram->table[index].handle = handle;
 }
 
-static bool zram_test_flag(struct zram *zram, u32 index,
-			enum zram_pageflags flag)
+bool zram_test_flag(struct zram *zram, u32 index, enum zram_pageflags flag)
 {
 	return zram->table[index].flags & BIT(flag);
 }
 
-static void zram_set_flag(struct zram *zram, u32 index,
-			enum zram_pageflags flag)
+void zram_set_flag(struct zram *zram, u32 index, enum zram_pageflags flag)
 {
 	zram->table[index].flags |= BIT(flag);
 }
@@ -243,15 +240,20 @@ static struct zram_pp_ctl *init_pp_ctl(void)
 	if (!ctl)
 		return NULL;
 
+	init_completion(&ctl->all_done);
+	atomic_set(&ctl->num_pp_slots, 0);
 	for (idx = 0; idx < NUM_PP_BUCKETS; idx++)
 		INIT_LIST_HEAD(&ctl->pp_buckets[idx]);
 	return ctl;
 }
 
-static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
+static void remove_pp_slot_from_ctl(struct zram_pp_slot *pps)
 {
 	list_del_init(&pps->entry);
+}
 
+void free_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
+{
 	zram_slot_lock(zram, pps->index);
 	zram_clear_flag(zram, pps->index, ZRAM_PP_SLOT);
 	zram_slot_unlock(zram, pps->index);
@@ -259,6 +261,12 @@ static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
 	kfree(pps);
 }
 
+static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
+{
+	remove_pp_slot_from_ctl(pps);
+	free_pp_slot(zram, pps);
+}
+
 static void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
 {
 	u32 idx;
@@ -297,6 +305,7 @@ static bool place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
 	list_add(&pps->entry, &ctl->pp_buckets[bid]);
 
 	zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
+	atomic_inc(&ctl->num_pp_slots);
 	return true;
 }
 
@@ -697,18 +706,18 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 {
 	unsigned long blk_idx = 0;
-	struct page *page = NULL;
 	struct zram_pp_slot *pps;
-	struct bio_vec bio_vec;
-	struct bio bio;
-	int ret = 0, err;
+	int ret = 0;
 	u32 index;
+	int nr_pps = atomic_read(&ctl->num_pp_slots);
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	if (!nr_pps)
+		return 0;
 
 	while ((pps = select_pp_slot(ctl))) {
+		struct zram_wb_request *req;
+		struct page *page;
+
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
@@ -725,6 +734,13 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 			}
 		}
 
+		req = alloc_wb_request(zram, pps, ctl, blk_idx);
+		if (IS_ERR(req)) {
+			ret = PTR_ERR(req);
+			break;
+		}
+		page = bio_first_page_all(req->bio);
+
 		index = pps->index;
 		zram_slot_lock(zram, index);
 		/*
@@ -739,63 +755,28 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 			goto next;
 		zram_slot_unlock(zram, index);
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
-			 REQ_OP_WRITE | REQ_SYNC);
-		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
-		/*
-		 * XXX: A single page IO would be inefficient for write
-		 * but it would be not bad as starter.
-		 */
-		err = submit_bio_wait(&bio);
-		if (err) {
-			release_pp_slot(zram, pps);
-			/*
-			 * BIO errors are not fatal, we continue and simply
-			 * attempt to writeback the remaining objects (pages).
-			 * At the same time we need to signal user-space that
-			 * some writes (at least one, but also could be all of
-			 * them) were not successful and we do so by returning
-			 * the most recent BIO error.
-			 */
-			ret = err;
-			continue;
-		}
-
-		atomic64_inc(&zram->stats.bd_writes);
-		zram_slot_lock(zram, index);
-		/*
-		 * Same as above, we release slot lock during writeback so
-		 * slot can change under us: slot_free() or slot_free() and
-		 * reallocation (zram_write_page()). In both cases slot loses
-		 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
-		 * ZRAM_PP_SLOT on such slots until current post-processing
-		 * finishes.
-		 */
-		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
-			goto next;
-
-		zram_free_page(zram, index);
-		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_handle(zram, index, blk_idx);
+		nr_pps--;
+		remove_pp_slot_from_ctl(pps);
 		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
-		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-		spin_unlock(&zram->wb_limit_lock);
+		submit_bio(req->bio);
+		continue;
+
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
+		free_wb_request(req);
 
 		cond_resched();
 	}
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	if (page)
-		__free_page(page);
+
+	if (nr_pps && atomic_sub_and_test(nr_pps, &ctl->num_pp_slots))
+		complete(&ctl->all_done);
+
+	/* wait until all async bios completed */
+	wait_for_completion(&ctl->all_done);
 
 	return ret;
 }
@@ -1579,7 +1560,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	return true;
 }
 
-static void zram_free_page(struct zram *zram, size_t index)
+void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 2c7bc05fb186..ab5ceecc8ed8 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -140,6 +140,13 @@ struct zram {
 	atomic_t pp_in_progress;
 };
 
+void zram_slot_lock(struct zram *zram, u32 index);
+void zram_slot_unlock(struct zram *zram, u32 index);
+void zram_set_handle(struct zram *zram, u32 index, unsigned long handle);
+bool zram_test_flag(struct zram *zram, u32 index, enum zram_pageflags flag);
+void zram_set_flag(struct zram *zram, u32 index, enum zram_pageflags flag);
+void zram_free_page(struct zram *zram, size_t index);
+
 #if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
 struct zram_pp_slot {
 	unsigned long		index;
@@ -155,7 +162,11 @@ struct zram_pp_slot {
 
 struct zram_pp_ctl {
 	struct list_head	pp_buckets[NUM_PP_BUCKETS];
+	struct completion	all_done;
+	atomic_t		num_pp_slots;
 };
+
+void free_pp_slot(struct zram *zram, struct zram_pp_slot *pps);
 #endif
 
 #endif
diff --git a/drivers/block/zram/zram_wb.c b/drivers/block/zram/zram_wb.c
index 63a16dae5796..3b8edd048dcb 100644
--- a/drivers/block/zram/zram_wb.c
+++ b/drivers/block/zram/zram_wb.c
@@ -43,15 +43,60 @@ void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 static void complete_wb_request(struct zram_wb_request *req)
 {
 	struct zram *zram = req->zram;
+	struct zram_pp_slot *pps = req->pps;
+	struct zram_pp_ctl *ctl = req->ppctl;
+	unsigned long index = pps->index;
 	unsigned long blk_idx = req->blk_idx;
+	struct bio *bio = req->bio;
+
+	if (bio->bi_status)
+		goto out_err;
+
+	atomic64_inc(&zram->stats.bd_writes);
+	zram_slot_lock(zram, index);
+
+	/*
+	 * We release slot lock during writeback so slot can change
+	 * under us: slot_free() or slot_free() and reallocation
+	 * (zram_write_page()). In both cases slot loses
+	 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
+	 * ZRAM_PP_SLOT on such slots until current post-processing
+	 * finishes.
+	 */
+	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
+		zram_slot_unlock(zram, index);
+		goto out_err;
+	}
 
+	zram_free_page(zram, index);
+	zram_set_flag(zram, index, ZRAM_WB);
+	zram_set_handle(zram, index, blk_idx);
+	atomic64_inc(&zram->stats.pages_stored);
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+	zram_slot_unlock(zram, index);
+	goto end;
+
+out_err:
 	free_block_bdev(zram, blk_idx);
+end:
+	free_pp_slot(zram, pps);
 	free_wb_request(req);
+
+	if (atomic_dec_and_test(&ctl->num_pp_slots))
+		complete(&ctl->all_done);
 }
 
-void enqueue_wb_request(struct zram_wb_request_list *req_list,
-			struct zram_wb_request *req)
+static void enqueue_wb_request(struct zram_wb_request_list *req_list,
+			       struct zram_wb_request *req)
 {
+	/*
+	 * The enqueue path comes from softirq context:
+	 * blk_done_softirq -> bio_endio -> zram_writeback_end_io
+	 * Use spin_lock_bh for locking.
+	 */
 	spin_lock_bh(&req_list->lock);
 	list_add_tail(&req->node, &req_list->head);
 	req_list->count++;
@@ -83,6 +128,7 @@ static void destroy_wb_request_list(struct zram_wb_request_list *req_list)
 	while (!list_empty(&req_list->head)) {
 		req = dequeue_wb_request(req_list);
 		free_block_bdev(req->zram, req->blk_idx);
+		free_pp_slot(req->zram, req->pps);
 		free_wb_request(req);
 	}
 }
@@ -117,6 +163,59 @@ static int wb_thread_func(void *data)
 	return 0;
 }
 
+static void zram_writeback_end_io(struct bio *bio)
+{
+	struct zram_wb_request *req =
+		(struct zram_wb_request *)bio->bi_private;
+
+	enqueue_wb_request(&wb_req_list, req);
+	wake_up(&wb_wq);
+}
+
+struct zram_wb_request *alloc_wb_request(struct zram *zram,
+					 struct zram_pp_slot *pps,
+					 struct zram_pp_ctl *ppctl,
+					 unsigned long blk_idx)
+{
+	struct zram_wb_request *req;
+	struct page *page;
+	struct bio *bio;
+	int err = 0;
+
+	page = alloc_page(GFP_NOIO | __GFP_NOWARN);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	bio = bio_alloc(zram->bdev, 1, REQ_OP_WRITE, GFP_NOIO | __GFP_NOWARN);
+	if (!bio) {
+		err = -ENOMEM;
+		goto out_free_page;
+	}
+
+	req = kmalloc(sizeof(struct zram_wb_request), GFP_NOIO | __GFP_NOWARN);
+	if (!req) {
+		err = -ENOMEM;
+		goto out_free_bio;
+	}
+	req->zram = zram;
+	req->pps = pps;
+	req->ppctl = ppctl;
+	req->blk_idx = blk_idx;
+	req->bio = bio;
+
+	bio->bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
+	bio->bi_private = req;
+	bio->bi_end_io = zram_writeback_end_io;
+	return req;
+
+out_free_bio:
+	bio_put(bio);
+out_free_page:
+	__free_page(page);
+	return ERR_PTR(err);
+}
+
 void free_wb_request(struct zram_wb_request *req)
 {
 	struct bio *bio = req->bio;
diff --git a/drivers/block/zram/zram_wb.h b/drivers/block/zram/zram_wb.h
index b86de0398346..f6fe7c51d496 100644
--- a/drivers/block/zram/zram_wb.h
+++ b/drivers/block/zram/zram_wb.h
@@ -26,9 +26,11 @@ unsigned long alloc_block_bdev(struct zram *zram);
 void free_block_bdev(struct zram *zram, unsigned long blk_idx);
 int setup_zram_writeback(void);
 void destroy_zram_writeback(void);
+struct zram_wb_request *alloc_wb_request(struct zram *zram,
+					 struct zram_pp_slot *pps,
+					 struct zram_pp_ctl *ppctl,
+					 unsigned long blk_idx);
 void free_wb_request(struct zram_wb_request *req);
-void enqueue_wb_request(struct zram_wb_request_list *req_list,
-			struct zram_wb_request *req);
 #else
 inline unsigned long alloc_block_bdev(struct zram *zram) { return 0; }
 inline void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
-- 
2.50.1.565.gc32cd1483b-goog

