Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200C369977
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652131; cv=none; b=gITR8AOWgFBKaYoiP4spEtVF9/vhbK7lvZhD1VwB728Ee8mHGMBPoyRr/PGWkY/qAOOa6gEPLHoBlSALAb82I1RbkgJd7EDP1IQjlQeZIvoPankuWTwiC2GxxKnBXR5BXmzDpOUrKmdUcWvBANVBcdSZQJ8JuRgwHn9gsvj5ZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652131; c=relaxed/simple;
	bh=5+AU9S/f5polyQyYvakR9BB1IIFdi+/V+avVO9Xt2j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liY8CV/YhAoda9vE43BKAfmHppwr20iPCkzzMr/nUwZZRx/3UEQ5qbWTHR4fjRRqvIOwAzQlPerxrCjWPy4X7v4PVL5+bjah/6BzbRU/52T2Gxa/dEJVh7v3jiCioh5N0eaMImovZwka/VZ6xe0LZX1JjqwVsnOX9LFY6OLDcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UFEXDB/1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UFEXDB/1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b9387df58cso1592086b3a.3
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763652129; x=1764256929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQMGDA1+u1LPAuL+BCiFc4Yo1PBFGHEJGqJGazuFeIc=;
        b=UFEXDB/1Sb2IIrmjGyVphMUR2Pnt1cf+YARbMVuRW9soR7jCbiW/GL6FJT5yKuUfJd
         JrlKyCRX96HfDvIWLrWbMnKJ5tUgoOPlXj/pznmUHPV/V4npZFtEIl9NOh4EliK31qQj
         9uNXHlXnV97VDGJGDJ3sEI5knQZMP9KZxnCSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652129; x=1764256929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQMGDA1+u1LPAuL+BCiFc4Yo1PBFGHEJGqJGazuFeIc=;
        b=oMWlFkkixFphXUa3yWvu9uEEQE9jJ3/4mlilV0HpcLK+P/ovfeCdBeqYDIkv74sZr1
         RsFkYFwyEGKZnCdBK77gEs9VbJHHbDsYqJSLyjz2D644RaV+ZL3Z085SxaPMs/9cjh32
         9d1ennre2zelFbvXvlYn76oDJe21jhdjuTKut4BhivkuPwUR4WTej3CdQ6lnvEqGXlCl
         K4TzTcdbPEg4hU5w6LbgptwWpbr3/mqWeOZOlv8dFeUI+sLrZjfNDsQqszFzKFAOeZaW
         0Gj6QR9ENbP1YC+dAxYYwXn16Wh/O+8UfJj9/4NBFsuViB5nsp/ZSSr3SXzhZwCx4Tki
         V4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDxl77wlVBTX3c7WVE+m03ofDZ4kV75H09Yl6DkwR14n0m5m9Oawhl2pYiH6xXxLZcycHUgvJ6G+BzpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9P9ZEjqPtw5n8rJGt2Lz06C3VzlB0acfsGynaVrrXtiCAAdW
	Oon3ebWhVYH5POx5CjqIUoaZHGFmjGU2SrCjqzykYiJXpUpIxqI64qPjD1o1dR+7eg==
X-Gm-Gg: ASbGnctLd/GJb0co4aq+ohHQvtYcENDFeZcls+IUxT4SR1XG3/vyPIh5/kg79Ry3PWb
	X5rGKrX7ezwI3m9Pc4JOi+XDjVKJNxHbLV5mEzyaoH8l8M3NZFJ7b5sdWhNnMrZ+UGmP/7Rg5jm
	s+13+ug5QtH3RY/8/KdLKHAuKkvRTXBTVe6ztvNftXiHwH6MjImorG6h9HUN4Hkq28ETv2+HSAY
	GuOWcYVGliAn0rtmyc+85soXkhxNjkP55lFBbwxvN/IH5u63GP7uAwa5ooqXA25FXG49hTVzn0U
	UL2mW0mFnr4/QHa3bEtdT1KlQ6kz6ny7bb7C6+HiaU+q9NiqsY9GvMYY+4sOjreyxzgZY/26iv0
	+wvIL9eeyNJfVFQuwEwrAXxNob6ysoVk923AxshNBpuGd3grLiIClWIQztDWK8trNsFsDlHStzU
	81l3TgXNWpnEH6SX6MpRXzey0LnQM4QNzEI2Pq3g==
X-Google-Smtp-Source: AGHT+IH4Kqb6jdeCprkIAeBP8l5L/2bdYTnDn0ERK7+4rx4S17p67ukAm1nlmWjmMsyD/cMn7l50fA==
X-Received: by 2002:a05:6a00:1248:b0:7ad:386e:3b6d with SMTP id d2e1a72fcca58-7c3f07656fbmr4373751b3a.21.1763652129027;
        Thu, 20 Nov 2025 07:22:09 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023f968sm3179642b3a.38.2025.11.20.07.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:22:08 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@google.com>
Subject: [RFC PATCHv5 1/6] zram: introduce writeback bio batching
Date: Fri, 21 Nov 2025 00:21:21 +0900
Message-ID: <20251120152126.3126298-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251120152126.3126298-1-senozhatsky@chromium.org>
References: <20251120152126.3126298-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, zram writeback supports only a single bio writeback
operation, waiting for bio completion before post-processing
next pp-slot.  This works, in general, but has certain throughput
limitations.  Introduce batched (multiple) bio writeback support
to take advantage of parallel requests processing and better
requests scheduling.

For the time being the writeback batch size (maximum number of
in-flight bio requests) is set to 32 for all devices.  A follow
up patch adds a writeback_batch_size device attribute, so the
batch size becomes run-time configurable.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Co-developed-by: Yuwen Chen <ywen.chen@foxmail.com>
Co-developed-by: Richard Chang <richardycc@google.com>
Suggested-by: Minchan Kim <minchan@google.com>
---
 drivers/block/zram/zram_drv.c | 366 +++++++++++++++++++++++++++-------
 1 file changed, 298 insertions(+), 68 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..37c1416ac902 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -500,6 +500,24 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+struct zram_wb_ctl {
+	struct list_head idle_reqs;
+	struct list_head done_reqs;
+	wait_queue_head_t done_wait;
+	spinlock_t done_lock;
+	atomic_t num_inflight;
+};
+
+struct zram_wb_req {
+	unsigned long blk_idx;
+	struct page *page;
+	struct zram_pp_slot *pps;
+	struct bio_vec bio_vec;
+	struct bio bio;
+
+	struct list_head entry;
+};
+
 static ssize_t writeback_limit_enable_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -734,19 +752,220 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	submit_bio(bio);
 }
 
-static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
+static void release_wb_req(struct zram_wb_req *req)
 {
-	unsigned long blk_idx = 0;
-	struct page *page = NULL;
-	struct zram_pp_slot *pps;
-	struct bio_vec bio_vec;
-	struct bio bio;
+	__free_page(req->page);
+	kfree(req);
+}
+
+static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
+{
+	if (!wb_ctl)
+		return;
+
+	/* We should never have inflight requests at this point */
+	WARN_ON(atomic_read(&wb_ctl->num_inflight));
+	WARN_ON(!list_empty(&wb_ctl->done_reqs));
+
+	while (!list_empty(&wb_ctl->idle_reqs)) {
+		struct zram_wb_req *req;
+
+		req = list_first_entry(&wb_ctl->idle_reqs,
+				       struct zram_wb_req, entry);
+		list_del(&req->entry);
+		release_wb_req(req);
+	}
+
+	kfree(wb_ctl);
+}
+
+/* XXX: should be a per-device sysfs attr */
+#define ZRAM_WB_REQ_CNT 32
+
+static struct zram_wb_ctl *init_wb_ctl(void)
+{
+	struct zram_wb_ctl *wb_ctl;
+	int i;
+
+	wb_ctl = kmalloc(sizeof(*wb_ctl), GFP_KERNEL);
+	if (!wb_ctl)
+		return NULL;
+
+	INIT_LIST_HEAD(&wb_ctl->idle_reqs);
+	INIT_LIST_HEAD(&wb_ctl->done_reqs);
+	atomic_set(&wb_ctl->num_inflight, 0);
+	init_waitqueue_head(&wb_ctl->done_wait);
+	spin_lock_init(&wb_ctl->done_lock);
+
+	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+		struct zram_wb_req *req;
+
+		/*
+		 * This is fatal condition only if we couldn't allocate
+		 * any requests at all.  Otherwise we just work with the
+		 * requests that we have successfully allocated, so that
+		 * writeback can still proceed, even if there is only one
+		 * request on the idle list.
+		 */
+		req = kzalloc(sizeof(*req), GFP_KERNEL | __GFP_NOWARN);
+		if (!req)
+			break;
+
+		req->page = alloc_page(GFP_KERNEL | __GFP_NOWARN);
+		if (!req->page) {
+			kfree(req);
+			break;
+		}
+
+		list_add(&req->entry, &wb_ctl->idle_reqs);
+	}
+
+	/* We couldn't allocate any requests, so writeabck is not possible */
+	if (list_empty(&wb_ctl->idle_reqs))
+		goto release_wb_ctl;
+
+	return wb_ctl;
+
+release_wb_ctl:
+	release_wb_ctl(wb_ctl);
+	return NULL;
+}
+
+static void zram_account_writeback_rollback(struct zram *zram)
+{
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable)
+		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+}
+
+static void zram_account_writeback_submit(struct zram *zram)
+{
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+}
+
+static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
+{
+	u32 index = req->pps->index;
+	int err;
+
+	err = blk_status_to_errno(req->bio.bi_status);
+	if (err) {
+		/*
+		 * Failed wb requests should not be accounted in wb_limit
+		 * (if enabled).
+		 */
+		zram_account_writeback_rollback(zram);
+		free_block_bdev(zram, req->blk_idx);
+		return err;
+	}
+
+	atomic64_inc(&zram->stats.bd_writes);
+	zram_slot_lock(zram, index);
+	/*
+	 * We release slot lock during writeback so slot can change under us:
+	 * slot_free() or slot_free() and zram_write_page(). In both cases
+	 * slot loses ZRAM_PP_SLOT flag. No concurrent post-processing can
+	 * set ZRAM_PP_SLOT on such slots until current post-processing
+	 * finishes.
+	 */
+	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
+		free_block_bdev(zram, req->blk_idx);
+		goto out;
+	}
+
+	zram_free_page(zram, index);
+	zram_set_flag(zram, index, ZRAM_WB);
+	zram_set_handle(zram, index, req->blk_idx);
+	atomic64_inc(&zram->stats.pages_stored);
+
+out:
+	zram_slot_unlock(zram, index);
+	return 0;
+}
+
+static void zram_writeback_endio(struct bio *bio)
+{
+	struct zram_wb_req *req = container_of(bio, struct zram_wb_req, bio);
+	struct zram_wb_ctl *wb_ctl = bio->bi_private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wb_ctl->done_lock, flags);
+	list_add(&req->entry, &wb_ctl->done_reqs);
+	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
+
+	wake_up(&wb_ctl->done_wait);
+}
+
+static void zram_submit_wb_request(struct zram *zram,
+				   struct zram_wb_ctl *wb_ctl,
+				   struct zram_wb_req *req)
+{
+	/*
+	 * wb_limit (if enabled) should be adjusted before submission,
+	 * so that we don't over-submit.
+	 */
+	zram_account_writeback_submit(zram);
+	atomic_inc(&wb_ctl->num_inflight);
+	req->bio.bi_private = wb_ctl;
+	submit_bio(&req->bio);
+}
+
+static int zram_complete_done_reqs(struct zram *zram,
+				   struct zram_wb_ctl *wb_ctl)
+{
+	struct zram_wb_req *req;
+	unsigned long flags;
 	int ret = 0, err;
-	u32 index;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	while (1) {
+		spin_lock_irqsave(&wb_ctl->done_lock, flags);
+		req = list_first_entry_or_null(&wb_ctl->done_reqs,
+					       struct zram_wb_req, entry);
+		if (req)
+			list_del(&req->entry);
+		spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
+
+		if (!req)
+			break;
+
+		err = zram_writeback_complete(zram, req);
+		if (err)
+			ret = err;
+
+		atomic_dec(&wb_ctl->num_inflight);
+		release_pp_slot(zram, req->pps);
+		req->pps = NULL;
+
+		list_add(&req->entry, &wb_ctl->idle_reqs);
+	}
+
+	return ret;
+}
+
+static struct zram_wb_req *zram_select_idle_req(struct zram_wb_ctl *wb_ctl)
+{
+	struct zram_wb_req *req;
+
+	req = list_first_entry_or_null(&wb_ctl->idle_reqs,
+				       struct zram_wb_req, entry);
+	if (req)
+		list_del(&req->entry);
+	return req;
+}
+
+static int zram_writeback_slots(struct zram *zram,
+				struct zram_pp_ctl *ctl,
+				struct zram_wb_ctl *wb_ctl)
+{
+	struct zram_wb_req *req = NULL;
+	unsigned long blk_idx = 0;
+	struct zram_pp_slot *pps;
+	int ret = 0, err = 0;
+	u32 index = 0;
 
 	while ((pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
@@ -757,6 +976,27 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		}
 		spin_unlock(&zram->wb_limit_lock);
 
+		while (!req) {
+			req = zram_select_idle_req(wb_ctl);
+			if (req)
+				break;
+
+			wait_event(wb_ctl->done_wait,
+				   !list_empty(&wb_ctl->done_reqs));
+
+			err = zram_complete_done_reqs(zram, wb_ctl);
+			/*
+			 * BIO errors are not fatal, we continue and simply
+			 * attempt to writeback the remaining objects (pages).
+			 * At the same time we need to signal user-space that
+			 * some writes (at least one, but also could be all of
+			 * them) were not successful and we do so by returning
+			 * the most recent BIO error.
+			 */
+			if (err)
+				ret = err;
+		}
+
 		if (!blk_idx) {
 			blk_idx = alloc_block_bdev(zram);
 			if (!blk_idx) {
@@ -775,67 +1015,47 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		 */
 		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		if (zram_read_from_zspool(zram, page, index))
+		if (zram_read_from_zspool(zram, req->page, index))
 			goto next;
 		zram_slot_unlock(zram, index);
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
-			 REQ_OP_WRITE | REQ_SYNC);
-		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
 		/*
-		 * XXX: A single page IO would be inefficient for write
-		 * but it would be not bad as starter.
+		 * From now on pp-slot is owned by the req, remove it from
+		 * its pp bucket.
 		 */
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
+		list_del_init(&pps->entry);
 
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
+		req->blk_idx = blk_idx;
+		req->pps = pps;
+		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1, REQ_OP_WRITE);
+		req->bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
+		req->bio.bi_end_io = zram_writeback_endio;
+		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
 
-		zram_free_page(zram, index);
-		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_handle(zram, index, blk_idx);
+		zram_submit_wb_request(zram, wb_ctl, req);
 		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
-		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-		spin_unlock(&zram->wb_limit_lock);
+		req = NULL;
+		cond_resched();
+		continue;
+
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
-
-		cond_resched();
 	}
 
-	if (blk_idx)
-		free_block_bdev(zram, blk_idx);
-	if (page)
-		__free_page(page);
+	/*
+	 * Selected idle req, but never submitted it due to some error or
+	 * wb limit.
+	 */
+	if (req)
+		release_wb_req(req);
+
+	while (atomic_read(&wb_ctl->num_inflight) > 0) {
+		wait_event(wb_ctl->done_wait, !list_empty(&wb_ctl->done_reqs));
+		err = zram_complete_done_reqs(zram, wb_ctl);
+		if (err)
+			ret = err;
+	}
 
 	return ret;
 }
@@ -948,7 +1168,8 @@ static ssize_t writeback_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long lo = 0, hi = nr_pages;
-	struct zram_pp_ctl *ctl = NULL;
+	struct zram_pp_ctl *pp_ctl = NULL;
+	struct zram_wb_ctl *wb_ctl = NULL;
 	char *args, *param, *val;
 	ssize_t ret = len;
 	int err, mode = 0;
@@ -970,8 +1191,14 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	ctl = init_pp_ctl();
-	if (!ctl) {
+	pp_ctl = init_pp_ctl();
+	if (!pp_ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	wb_ctl = init_wb_ctl();
+	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
 	}
@@ -1000,7 +1227,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1011,7 +1238,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1022,7 +1249,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 
@@ -1033,17 +1260,18 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 	}
 
-	err = zram_writeback_slots(zram, ctl);
+	err = zram_writeback_slots(zram, pp_ctl, wb_ctl);
 	if (err)
 		ret = err;
 
 release_init_lock:
-	release_pp_ctl(zram, ctl);
+	release_pp_ctl(zram, pp_ctl);
+	release_wb_ctl(wb_ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
 
@@ -1112,7 +1340,9 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 	return -EIO;
 }
 
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
+static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
+{
+}
 #endif
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
-- 
2.52.0.rc1.455.g30608eb744-goog

