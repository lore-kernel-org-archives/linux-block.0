Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C8296BA7
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797253; cv=none; b=hA6H2fxIl+vTIfpCWLclqZ2vxKPvOlAfjD5QHhNDVTU+f98zU1ES/RFbFwhnJVfNuPj4/dq8rqMGtFthrgx8xKkKHWEULjxe9bG//SOLG4hF9AIF3YgBQpOe3a/65KiKIqyZ4HLIkKsx62G/6AIov8aj/Vr3oawbw6WFqi0CPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797253; c=relaxed/simple;
	bh=0IGd9pECmyyazBtuzTUy3wd9EY0I+2QhQWM58mapvyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9G1onNWpiP5oQsAaKFS8/gyeh12StwXOtc9RJPCWE5IkOXNQSkXWYA1lf85jEmMtCH9bTqmwdaXn+cbv7S1YApfiGa6ZN976cC96n8mI6Vj0NgbsXRKdjM0qWlVyHu2AO96lmlGNHHxsLgLbWo+7RXktbedQ12VzG4ZY25e3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LXJlCDLE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LXJlCDLE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2955623e6faso33095155ad.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763797251; x=1764402051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CcYw/MVsIvV8b2h3Sq9n03D/rQEvwWc9LbzmpgrKxs=;
        b=LXJlCDLEfAo82LQsnuXOfSj93vf4kZqUMHsYtQweyOPxluwfsO4SWimJbdyZFeE55y
         L9qFNUO+u4fE/D2ad5eWlYF5T1QQ2w0Iw0tVsbMMnIKjL4t4ZMjS4NxOyCMFcs5lhXOU
         pPzfNaC3nOhtTVWT+ysUglEXHoaBeQFd7aL88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797251; x=1764402051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CcYw/MVsIvV8b2h3Sq9n03D/rQEvwWc9LbzmpgrKxs=;
        b=gaJqIRYHR1E9EMaSj1PdL3Ak+dKqQ/xv+7BA/N765P4vlnvU+ffHMdCvEKiuVlreA9
         h9VGQb4nq1Juk/y4OUigpOuE/VhRwnnoPxdasR1oL2hyx5/hz3Iassm2LZ1bW1MrDrj4
         elx49KERgoSlYVvaoLQJ5Zv8Yh9e/OYALwmS7UHeysxozY0fQzZDWBJd+YXi2CrsTbyH
         4a6IyY2H0UtfMZgQqroLY+kXccL7426anL6/nJEwRkCxfewri/c2uIbN4fj3W+2T+38m
         1mxEQXEKCQwR3+DYPFtWuPMPNttrKHjCVYLfzv2WeRpVfi5aU6oEgEtWbwRfptCPzmIf
         6BFg==
X-Forwarded-Encrypted: i=1; AJvYcCXs3h4QDqq/e4xk4ljE40LfV+k+Pk4nG5jUHO58P3ftGBs6oOBqIbHAbQKvnCuC2/aIYV7BLT63zV1GDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6j64YKJkQjg7YQdWqOzwmzwxu9MJYYF1ENnCAoqz1hlbVGMlK
	VrWxmKTmuG2CtOnoKdvimGQdPKFZeUlcPlVyI5AO+Vdflh0qYweTCmEOdJfmXpNWdsOSwUdn4g/
	W9G4=
X-Gm-Gg: ASbGncupIS5eKAr9Wxg67ZChtp+ajlSbXRItGgwJEMpR/LpXkJ4bGplWJzvl08cTAS8
	26FBOMVV/7rmf+oZcnMBLRfGn9wED8CUeVGxaA0Y8fJ3HoGUKIT861SVuTzwgskrVbD9vooKL4p
	dr9DiYW1xBN4mnLil2RRkB/JZe/ZqMOmEeAOmpBabRS+5CJV/2Vvo0jpeHe1/A5fbH2FATi7HHh
	sTcGKW0FC99ssAZdZezjtOBfJpxQ+WKEkccN5D8hNTmnCvNcC1xUc7AqKi1A+okfqmSf4KfJBNf
	IErvjrwosvrfl7OUUIXf+0XWYhanxCJrdx94Ajl7pn6CxdxuHVEJhSjgdDl8W9PCkbOft7nj4hc
	jDNIWXjc/nbbkqJyB1S6DwpO3OYAyRAj9xzSCkvt0KXSquaMoqRmx9S0reJIBcbQI9afIFvdS8e
	Ry+pLh2jCxT7/GBQUyn67pXW665h6h+fWfwY2/ITI1MxffD+YYLzkHzUD72FworM828vMpyOH3y
	g==
X-Google-Smtp-Source: AGHT+IFaSB7EbqaBfaqnc96XqHJ3nI/Cc67lkuc7fRADR0xDZSv+4CDROktulCgD73hI6bhlKxOYWg==
X-Received: by 2002:a17:902:e809:b0:295:738f:73fe with SMTP id d9443c01a7336-29b6bf385e6mr72914675ad.30.1763797250758;
        Fri, 21 Nov 2025 23:40:50 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138628sm77771555ad.31.2025.11.21.23.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:40:50 -0800 (PST)
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
Subject: [PATCHv6 1/6] zram: introduce writeback bio batching
Date: Sat, 22 Nov 2025 16:40:24 +0900
Message-ID: <20251122074029.3948921-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251122074029.3948921-1-senozhatsky@chromium.org>
References: <20251122074029.3948921-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As was stated in a comment [1] a single page writeback IO
is not efficient, but it works.  It's time to address this
throughput limitation as writeback becomes used more often.
Introduce batched (multiple) bio writeback support to take
advantage of parallel requests processing and better requests
scheduling.

Approach used in this patch doesn't use a dedicated kthread
like in [2], or blk-plug like in [3].  Dedicated kthread adds
complexity, which can be avoided.  Apart from that not all
zram setups use writeback, so having numerous per-device
kthreads (on systems that create multiple zram devices)
hanging around is not the most optimal thing to do.  blk-plug,
on the other hand, works best when request are sequential,
which doesn't particularly fit zram writebck IO patterns: zram
writeback IO patterns are expected to be random, due to how
bdev block reservation/release are handled.  blk-plug approach
also works in cycles: idle IO, when zram sets up requests in
a batch, is followed by bursts of IO, when zram submits the
entire batch.

Instead we use a batch of requests and submit new bio as soon
as one of the in-flight requests completes.

For the time being the writeback batch size (maximum number of
in-flight bio requests) is set to 32 for all devices.  A follow
up patch adds a writeback_batch_size device attribute, so the
batch size becomes run-time configurable.

[1] https://lore.kernel.org/all/20181203024045.153534-6-minchan@kernel.org/
[2] https://lore.kernel.org/all/20250731064949.1690732-1-richardycc@google.com/
[3] https://lore.kernel.org/all/tencent_78FC2C4FE16BA1EBAF0897DB60FCD675ED05@qq.com/

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Co-developed-by: Yuwen Chen <ywen.chen@foxmail.com>
Co-developed-by: Richard Chang <richardycc@google.com>
Suggested-by: Minchan Kim <minchan@google.com>
---
 drivers/block/zram/zram_drv.c | 369 +++++++++++++++++++++++++++-------
 1 file changed, 301 insertions(+), 68 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..06ea56f0a00f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -500,6 +500,26 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+struct zram_wb_ctl {
+	/* idle list is accessed only by the writeback task, no concurency */
+	struct list_head idle_reqs;
+	/* done list is accessed concurrently, protect by done_lock */
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
@@ -734,19 +754,221 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
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
+	while (atomic_read(&wb_ctl->num_inflight) > 0) {
+		spin_lock_irqsave(&wb_ctl->done_lock, flags);
+		req = list_first_entry_or_null(&wb_ctl->done_reqs,
+					       struct zram_wb_req, entry);
+		if (req)
+			list_del(&req->entry);
+		spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
+
+		/* ->num_inflight > 0 doesn't mean we have done requests */
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
@@ -757,6 +979,27 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
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
@@ -775,67 +1018,47 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
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
@@ -948,7 +1171,8 @@ static ssize_t writeback_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long lo = 0, hi = nr_pages;
-	struct zram_pp_ctl *ctl = NULL;
+	struct zram_pp_ctl *pp_ctl = NULL;
+	struct zram_wb_ctl *wb_ctl = NULL;
 	char *args, *param, *val;
 	ssize_t ret = len;
 	int err, mode = 0;
@@ -970,8 +1194,14 @@ static ssize_t writeback_store(struct device *dev,
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
@@ -1000,7 +1230,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1011,7 +1241,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1022,7 +1252,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 
@@ -1033,17 +1263,18 @@ static ssize_t writeback_store(struct device *dev,
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
 
@@ -1112,7 +1343,9 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 	return -EIO;
 }
 
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
+static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
+{
+}
 #endif
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
-- 
2.52.0.460.gd25c4c69ec-goog

