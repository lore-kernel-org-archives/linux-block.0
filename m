Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5A302CA2
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009107; cv=none; b=q+yG42jKW4BTUtwBcHEy+6UbK9Tg1ESmA5y6zUUwjtJFFGKhxRE2uZfzyYAAEeWsqFEQdQZpOJ+usajB4sBSW+FfkqE9ZwLa+h1oLnI1TcC51UQhyc4d/F8QceWXr9BUIo3eiI8im2xzB1BSGuaR5o1S8rWcf1luwFVOdQVZKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009107; c=relaxed/simple;
	bh=9EPIpqcnaT1yw4HrsxdZwVmGVBvkiak5aKzp2vbsEow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf4d8ZtWatx0DPGnLXMeIVnkS39GdvOxIQV6nCe7yX6dV/vF/YBmji7gHdgBOBr0OUR9a/PwyezECKcX0vxGKS0xjSR8jIrU0VDmkY7bltQ5o6yKsIQoYKWePOcbiGLD8X55CPyaHT5+OxhHP2ELOXlfsLhcnF96XgZqK3ehy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RRX8lkjk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RRX8lkjk"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so243337b3a.1
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 20:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763009104; x=1763613904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WW9NVt//V73VxoeUFc0q/YGH8xho76ZVJ4bJ41hK3dU=;
        b=RRX8lkjkD3/hjoYzOWSu0Vqo3ePPINIgZo2Y1uzZRHqLR5o3Qa1ggvOPQhFpX6St0j
         Qz3LmATsCEkMYFYjSgiS9/tjHAixVnGQCZBa665B5E6JQIlNcpo2kCY1s58kvRh1ggJB
         PVpT7/0Scz18k3O0VDcgxrYzPdEWeY+twzFHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763009104; x=1763613904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW9NVt//V73VxoeUFc0q/YGH8xho76ZVJ4bJ41hK3dU=;
        b=C7MQNqzr8vxM6w79107GXBoRfWEiVDPMSSIdVV2ksqBzqGIoAbKzLpcVYXOCoryRrf
         1PCn7U7IQrAoS+SCQcGaX0pyXO7UifRpF1Bmg4/yeEOOnhHPMjW7OCbrXa0lAjwZTmBQ
         3BqSP9VPOBBQsIwgf2k9lo6Yve5MSnaa6vEjf5K+amMDPITLKDtHcxU096Qz1UAXgxBX
         dsTfYPVxUe2Rw5pxi0u+OqBGgEYmQBFGYraLKcQ/Twz0CNBMCEwomGwsMHMjhYX5W9vR
         0XXiHrr2vDQJ2X9a2D5Jz3f+UV1BOHVGVPkkX/DJpHbAgCBLFdpWFeS/dPzpH68newGJ
         p0CA==
X-Forwarded-Encrypted: i=1; AJvYcCV4DjQzSkGYa6+NSdgnhQHJAR+UKAQdb/85KGaB9LR0rQdbxj1X1GrQE+9wLVLYzOCBOGEHrUd/Db42dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNIzSdEdfz/qIzjCELgmGvJowCDQPFUzvYDQboRHkSrL02nRf
	CtWpJJuvHX23up9oSj2gmQlWhrTMSwn5DSfEeshTyuPcCWzuU/ZWGu7PUJ2H4ltk5w==
X-Gm-Gg: ASbGncsa9uvf0HsOysdGQj/XAkh94nK5/6uZwl7YOuBsxEZoLay87MTgeiTI0iCWCbA
	lZc08y0UqyKanP8RxEa6AlbhhZGpffvI9E1ibBa/EGMIOuPFfSh1VGdbtmda8n4bv/9Vz2mb3mF
	2vXFl1A/jtSf+QZSmbFn8xXhE06tjzd6DOxs0lQCMgPwqpjDEjt4VTZmoGj2gdj5ERkuGLYE+3v
	m+hW2oDdej61m9diSAjb5NkuG+enwSbsjJdzyMB8KLdiPtNhYocoIC/ci2o5JxvUqE+TO3sDcWT
	7+sA9P8v1l8WP8HtfqDfYNwpxkhggdtGeVLNipw9YNA3SNU15VwJ9XnQhHltZhfd7X5NBUOPxWi
	Sk8rkXZxxeur+dTWAS7RA/J3GXtnmXnT19LPl+mSSF9yAQ0pXUWqYZ1fMt8231lZvbbSSrxi46k
	Uiv+AU
X-Google-Smtp-Source: AGHT+IEXtpLJGicudobq9OA6veeDOdY2jEZwNvXU511J/iL1OnckJnRZMsgb0VebRnUOGKc0IoD+1A==
X-Received: by 2002:a05:6a21:6d98:b0:33e:6885:2bd4 with SMTP id adf61e73a8af0-3590b513a3fmr7350959637.29.1763009104090;
        Wed, 12 Nov 2025 20:45:04 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927731e65sm723162b3a.62.2025.11.12.20.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 20:45:03 -0800 (PST)
Date: Thu, 13 Nov 2025 13:44:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <xovdviolzjnf6bwbvw4heskfmeasrku7s32xzzljtyomv55do3@s7uy5jb5itqq>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
 <x6ksirxv2xffhzpvdxmm5fa7r4b56mlh3kbhopljdsvwzg62wm@rrsslefk4rb4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x6ksirxv2xffhzpvdxmm5fa7r4b56mlh3kbhopljdsvwzg62wm@rrsslefk4rb4>

On (25/11/13 11:20), Sergey Senozhatsky wrote:
> On (25/11/06 09:49), Yuwen Chen wrote:
> > +static struct zram_wb_request *zram_writeback_next_request(struct zram_wb_request *pool,
> > +	int pool_cnt, int *cnt_off)
> > +{
> > +	struct zram_wb_request *req = NULL;
> > +	int i = 0;
> > +
> > +	for (i = *cnt_off; i < pool_cnt + *cnt_off; i++) {
> > +		req = &pool[i % pool_cnt];
> > +		if (!req->page) {
> > +			/* This memory should be freed by the caller. */
> > +			req->page = alloc_page(GFP_KERNEL);
> > +			if (!req->page)
> > +				continue;
> > +		}
> > +
> > +		if (!test_and_set_bit(ZRAM_WB_REQUEST_ALLOCATED, &req->flags)) {
> > +			*cnt_off = (i + 1) % pool_cnt;
> > +			return req;
> > +		}
> > +	}
> > +	return NULL;
> > +}
> 
> So I wonder if things will look simpler (is this the word I'm looking
> for?) if you just have two lists for requests: one list for completed/idle
> requests and one list for in-flight requests (and you move requests
> around accordingly).  Then you don't need to iterate the pool and check
> flags, you just can check list_empty(&idle_requests) and take the first
> (front) element.


OK, so this is (look below) roughly what I want it to look like.
It's closer (in sense of logic and approach) to what we do for
post-processing, and I think it's easier to understand.

1. factored out a new structure zram_wb_ctl, similar to zram_pp_ctl;
2. zram_wb_ctl is initialized outside of zram_writeback_slots(),
   because this function is purely about pp-slot writeback. wb_ctl
   is passed to zram_writeback_slots() as an argument, just like pp_ctl;
3. requests move between two lists: idle and inflight requests;
4. factored out and unified the wait-for-completion logic;

TODO: writeback_batch_size device attr.

Please take a look?  Does this make sense to you, do this
work for you?

---
 drivers/block/zram/zram_drv.c | 312 ++++++++++++++++++++++++++--------
 1 file changed, 244 insertions(+), 68 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..60c3a61c7ee8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -734,20 +734,195 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	submit_bio(bio);
 }
 
-static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-{
-	unsigned long blk_idx = 0;
-	struct page *page = NULL;
+struct zram_wb_ctl {
+	struct list_head idle_reqs;
+	struct list_head inflight_reqs;
+
+	atomic_t num_inflight;
+	struct completion done;
+	struct blk_plug plug;
+};
+
+struct zram_wb_req {
+	unsigned long blk_idx;
+	struct page *page;
 	struct zram_pp_slot *pps;
 	struct bio_vec bio_vec;
 	struct bio bio;
-	int ret = 0, err;
+
+	struct list_head entry;
+};
+
+static void release_wb_req(struct zram_wb_req *req)
+{
+	__free_page(req->page);
+	kfree(req);
+}
+
+static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
+{
+	/* We should never have inflight requests at this point */
+	WARN_ON(!list_empty(&wb_ctl->inflight_reqs));
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
+/* should be a module param */
+#define ZRAM_WB_REQ_CNT (32)
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
+	INIT_LIST_HEAD(&wb_ctl->inflight_reqs);
+	atomic_set(&wb_ctl->num_inflight, 0);
+	init_completion(&wb_ctl->done);
+
+	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+		struct zram_wb_req *req;
+
+		req = kmalloc(sizeof(*req), GFP_KERNEL);
+		if (!req)
+			goto release_wb_ctl;
+
+		req->page = alloc_page(GFP_KERNEL);
+		if (!req->page) {
+			kfree(req);
+			goto release_wb_ctl;
+		}
+
+		INIT_LIST_HEAD(&req->entry);
+		list_add(&req->entry, &wb_ctl->idle_reqs);
+	}
+
+	return wb_ctl;
+
+release_wb_ctl:
+	release_wb_ctl(wb_ctl);
+	return NULL;
+}
+
+static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
+{
 	u32 index;
+	int err;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	index = req->pps->index;
+	release_pp_slot(zram, req->pps);
+	req->pps = NULL;
+
+	err = blk_status_to_errno(req->bio.bi_status);
+	if (err)
+		return err;
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
+	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
+		goto out;
+
+	zram_free_page(zram, index);
+	zram_set_flag(zram, index, ZRAM_WB);
+	zram_set_handle(zram, index, req->blk_idx);
+	atomic64_inc(&zram->stats.pages_stored);
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+
+out:
+	zram_slot_unlock(zram, index);
+	return 0;
+}
+
+static void zram_writeback_endio(struct bio *bio)
+{
+	struct zram_wb_ctl *wb_ctl = bio->bi_private;
+
+	if (atomic_dec_return(&wb_ctl->num_inflight) == 0)
+		complete(&wb_ctl->done);
+}
+
+static void zram_submit_wb_request(struct zram_wb_ctl *wb_ctl,
+				   struct zram_wb_req *req)
+{
+	atomic_inc(&wb_ctl->num_inflight);
+	list_add_tail(&req->entry, &wb_ctl->inflight_reqs);
+	submit_bio(&req->bio);
+}
+
+static struct zram_wb_req *select_idle_req(struct zram_wb_ctl *wb_ctl)
+{
+	struct zram_wb_req *req = NULL;
+
+	if (!list_empty(&wb_ctl->idle_reqs)) {
+		req = list_first_entry(&wb_ctl->idle_reqs,
+				       struct zram_wb_req, entry);
+		list_del(&req->entry);
+	}
 
+	return req;
+}
+
+static int zram_wb_wait_for_completion(struct zram *zram,
+				       struct zram_wb_ctl *wb_ctl)
+{
+	int ret = 0;
+
+	if (atomic_read(&wb_ctl->num_inflight) == 0)
+		return 0;
+
+	wait_for_completion_io(&wb_ctl->done);
+	reinit_completion(&wb_ctl->done);
+
+	while (!list_empty(&wb_ctl->inflight_reqs)) {
+		struct zram_wb_req *req;
+		int err;
+
+		req = list_first_entry(&wb_ctl->inflight_reqs,
+				       struct zram_wb_req, entry);
+		list_move(&req->entry, &wb_ctl->idle_reqs);
+
+		err = zram_writeback_complete(zram, req);
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static int zram_writeback_slots(struct zram *zram,
+				struct zram_wb_ctl *wb_ctl,
+				struct zram_pp_ctl *ctl)
+{
+	struct zram_wb_req *req = NULL;
+	unsigned long blk_idx = 0;
+	struct zram_pp_slot *pps;
+	int ret = 0, err;
+	u32 index = 0;
+
+	blk_start_plug(&wb_ctl->plug);
 	while ((pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
@@ -757,15 +932,34 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		}
 		spin_unlock(&zram->wb_limit_lock);
 
+		while (!req) {
+			req = select_idle_req(wb_ctl);
+			if (req)
+				break;
+
+			blk_finish_plug(&wb_ctl->plug);
+			err = zram_wb_wait_for_completion(zram, wb_ctl);
+			blk_start_plug(&wb_ctl->plug);
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
-			if (!blk_idx) {
+			if (blk_idx) {
 				ret = -ENOSPC;
 				break;
 			}
 		}
 
-		index = pps->index;
 		zram_slot_lock(zram, index);
 		/*
 		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
@@ -775,67 +969,41 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		 */
 		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		if (zram_read_from_zspool(zram, page, index))
+		if (zram_read_from_zspool(zram, req->page, index))
 			goto next;
 		zram_slot_unlock(zram, index);
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
+		req->blk_idx = blk_idx;
+		req->pps = pps;
+		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
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
+		req->bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
+		req->bio.bi_end_io = zram_writeback_endio;
+		req->bio.bi_private = wb_ctl;
+		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
 
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
+		zram_submit_wb_request(wb_ctl, req);
 		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
-		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-		spin_unlock(&zram->wb_limit_lock);
+		req = NULL;
+		continue;
+
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
-
 		cond_resched();
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
+	blk_finish_plug(&wb_ctl->plug);
+	err = zram_wb_wait_for_completion(zram, wb_ctl);
+	if (err)
+		ret = err;
 
 	return ret;
 }
@@ -948,7 +1116,8 @@ static ssize_t writeback_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long lo = 0, hi = nr_pages;
-	struct zram_pp_ctl *ctl = NULL;
+	struct zram_pp_ctl *pp_ctl = NULL;
+	struct zram_wb_ctl *wb_ctl = NULL;
 	char *args, *param, *val;
 	ssize_t ret = len;
 	int err, mode = 0;
@@ -970,8 +1139,14 @@ static ssize_t writeback_store(struct device *dev,
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
@@ -1000,7 +1175,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1011,7 +1186,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1022,7 +1197,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 
@@ -1033,17 +1208,18 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 	}
 
-	err = zram_writeback_slots(zram, ctl);
+	err = zram_writeback_slots(zram, wb_ctl, pp_ctl);
 	if (err)
 		ret = err;
 
 release_init_lock:
-	release_pp_ctl(zram, ctl);
+	release_pp_ctl(zram, pp_ctl);
+	release_wb_ctl(wb_ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
 
-- 
2.51.2.1041.gc1ab5b90ca-goog

