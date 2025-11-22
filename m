Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703F27702D;
	Sat, 22 Nov 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763848447; cv=none; b=X0Dcx4XOgqiTpwYMT8obSn0NJBMEnfBw5rzYCDmEQLOiANNpaxjWUbXo/pjK0XYMdA9J1jJlIo6LtDNgE+uxe45FjAcj9gmkWLXmlUgwhPPKoDiccL8nQjBOTHhEUzGSxNBzIHf5fy4HgCEjaSOMPzheA4VSRlDbO+b1mcDLhYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763848447; c=relaxed/simple;
	bh=+KRHwAAUW4XO1yKTU+0wVlPm95HxskzXxng6AxzbgQY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eR2J0dAESzDXWfvu5gmOPheTGGYYL9oBQso/HAS3p1rShTUR/O9SU4SH94CboL0/YnySUTQE/c1wgLxHq7bgfDnvPPaop/Qqpq0A8AbTH/eMNzU9NdvFGaN60HpfBU49zhRC79eJH3IOqcc/K8/TCkpfRUM6xqaEYiCSTGyYpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EnKfKq4E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EnKfKq4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D408AC4CEF5;
	Sat, 22 Nov 2025 21:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763848447;
	bh=+KRHwAAUW4XO1yKTU+0wVlPm95HxskzXxng6AxzbgQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EnKfKq4EYsbTTCoSd98l+D10UA8GVAzzirZRMQ9H0NOr9w2S8lQXCH4mAwe9fqYOe
	 Uw4EZ6WCYYdIABl02YZ/vL29wizET8kLev0xacnVLkAUi0u9BirB9TwKkBcWOyNN5u
	 5ID9/Fp1W/I+ikiZCJ175IpsGDIiEAnNRhntAG6g=
Date: Sat, 22 Nov 2025 13:54:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>,
 Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>,
 Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCHv6 0/6] zram: introduce writeback bio batching
Message-Id: <20251122135406.dd38efa8bad778bce0daa046@linux-foundation.org>
In-Reply-To: <20251122074029.3948921-1-senozhatsky@chromium.org>
References: <20251122074029.3948921-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Nov 2025 16:40:23 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> As writeback is becoming more and more common the longstanding
> limitations of zram writeback throughput are becoming more
> visible.  Introduce writeback bio batching so that multiple
> writeback bio-s can be processed simultaneously.

Thanks, I updated mm.git's mm-unstable branch to this version.

> v5 -> v6:
> - added some comments to make code clearer
> - use write lock for batch size limit store (Andrew)
> - err on 0 batch size (Brian)
> - pickup reviewed-by tags (Brian)

Here's how this v6 series altered mm-unstable:

 drivers/block/zram/zram_drv.c |  112 +++++++++++++++++---------------
 1 file changed, 62 insertions(+), 50 deletions(-)

--- a/drivers/block/zram/zram_drv.c~b
+++ a/drivers/block/zram/zram_drv.c
@@ -503,11 +503,13 @@ out:
 #define INVALID_BDEV_BLOCK		(~0UL)
 
 struct zram_wb_ctl {
+	/* idle list is accessed only by the writeback task, no concurency */
 	struct list_head idle_reqs;
-	struct list_head inflight_reqs;
-
+	/* done list is accessed concurrently, protect by done_lock */
+	struct list_head done_reqs;
+	wait_queue_head_t done_wait;
+	spinlock_t done_lock;
 	atomic_t num_inflight;
-	struct completion done;
 };
 
 struct zram_wb_req {
@@ -591,20 +593,18 @@ static ssize_t writeback_batch_size_stor
 {
 	struct zram *zram = dev_to_zram(dev);
 	u32 val;
-	ssize_t ret = -EINVAL;
 
 	if (kstrtouint(buf, 10, &val))
-		return ret;
+		return -EINVAL;
 
 	if (!val)
-		val = 1;
+		return -EINVAL;
 
 	down_write(&zram->init_lock);
 	zram->wb_batch_size = val;
 	up_write(&zram->init_lock);
-	ret = len;
 
-	return ret;
+	return len;
 }
 
 static ssize_t writeback_batch_size_show(struct device *dev,
@@ -794,7 +794,8 @@ static void release_wb_ctl(struct zram_w
 		return;
 
 	/* We should never have inflight requests at this point */
-	WARN_ON(!list_empty(&wb_ctl->inflight_reqs));
+	WARN_ON(atomic_read(&wb_ctl->num_inflight));
+	WARN_ON(!list_empty(&wb_ctl->done_reqs));
 
 	while (!list_empty(&wb_ctl->idle_reqs)) {
 		struct zram_wb_req *req;
@@ -818,9 +819,10 @@ static struct zram_wb_ctl *init_wb_ctl(s
 		return NULL;
 
 	INIT_LIST_HEAD(&wb_ctl->idle_reqs);
-	INIT_LIST_HEAD(&wb_ctl->inflight_reqs);
+	INIT_LIST_HEAD(&wb_ctl->done_reqs);
 	atomic_set(&wb_ctl->num_inflight, 0);
-	init_completion(&wb_ctl->done);
+	init_waitqueue_head(&wb_ctl->done_wait);
+	spin_lock_init(&wb_ctl->done_lock);
 
 	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
@@ -914,10 +916,15 @@ out:
 
 static void zram_writeback_endio(struct bio *bio)
 {
+	struct zram_wb_req *req = container_of(bio, struct zram_wb_req, bio);
 	struct zram_wb_ctl *wb_ctl = bio->bi_private;
+	unsigned long flags;
 
-	if (atomic_dec_return(&wb_ctl->num_inflight) == 0)
-		complete(&wb_ctl->done);
+	spin_lock_irqsave(&wb_ctl->done_lock, flags);
+	list_add(&req->entry, &wb_ctl->done_reqs);
+	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
+
+	wake_up(&wb_ctl->done_wait);
 }
 
 static void zram_submit_wb_request(struct zram *zram,
@@ -930,49 +937,54 @@ static void zram_submit_wb_request(struc
 	 */
 	zram_account_writeback_submit(zram);
 	atomic_inc(&wb_ctl->num_inflight);
-	list_add_tail(&req->entry, &wb_ctl->inflight_reqs);
+	req->bio.bi_private = wb_ctl;
 	submit_bio(&req->bio);
 }
 
-static struct zram_wb_req *select_idle_req(struct zram_wb_ctl *wb_ctl)
+static int zram_complete_done_reqs(struct zram *zram,
+				   struct zram_wb_ctl *wb_ctl)
 {
 	struct zram_wb_req *req;
+	unsigned long flags;
+	int ret = 0, err;
 
-	req = list_first_entry_or_null(&wb_ctl->idle_reqs,
-				       struct zram_wb_req, entry);
-	if (req)
-		list_del(&req->entry);
-	return req;
-}
-
-static int zram_wb_wait_for_completion(struct zram *zram,
-				       struct zram_wb_ctl *wb_ctl)
-{
-	int ret = 0;
-
-	if (atomic_read(&wb_ctl->num_inflight))
-		wait_for_completion_io(&wb_ctl->done);
-
-	reinit_completion(&wb_ctl->done);
-	while (!list_empty(&wb_ctl->inflight_reqs)) {
-		struct zram_wb_req *req;
-		int err;
+	while (atomic_read(&wb_ctl->num_inflight) > 0) {
+		spin_lock_irqsave(&wb_ctl->done_lock, flags);
+		req = list_first_entry_or_null(&wb_ctl->done_reqs,
+					       struct zram_wb_req, entry);
+		if (req)
+			list_del(&req->entry);
+		spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 
-		req = list_first_entry(&wb_ctl->inflight_reqs,
-				       struct zram_wb_req, entry);
-		list_move(&req->entry, &wb_ctl->idle_reqs);
+		/* ->num_inflight > 0 doesn't mean we have done requests */
+		if (!req)
+			break;
 
 		err = zram_writeback_complete(zram, req);
 		if (err)
 			ret = err;
 
+		atomic_dec(&wb_ctl->num_inflight);
 		release_pp_slot(zram, req->pps);
 		req->pps = NULL;
+
+		list_add(&req->entry, &wb_ctl->idle_reqs);
 	}
 
 	return ret;
 }
 
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
 static int zram_writeback_slots(struct zram *zram,
 				struct zram_pp_ctl *ctl,
 				struct zram_wb_ctl *wb_ctl)
@@ -980,11 +992,9 @@ static int zram_writeback_slots(struct z
 	unsigned long blk_idx = INVALID_BDEV_BLOCK;
 	struct zram_wb_req *req = NULL;
 	struct zram_pp_slot *pps;
-	struct blk_plug io_plug;
-	int ret = 0, err;
+	int ret = 0, err = 0;
 	u32 index = 0;
 
-	blk_start_plug(&io_plug);
 	while ((pps = select_pp_slot(ctl))) {
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			ret = -EIO;
@@ -992,13 +1002,14 @@ static int zram_writeback_slots(struct z
 		}
 
 		while (!req) {
-			req = select_idle_req(wb_ctl);
+			req = zram_select_idle_req(wb_ctl);
 			if (req)
 				break;
 
-			blk_finish_plug(&io_plug);
-			err = zram_wb_wait_for_completion(zram, wb_ctl);
-			blk_start_plug(&io_plug);
+			wait_event(wb_ctl->done_wait,
+				   !list_empty(&wb_ctl->done_reqs));
+
+			err = zram_complete_done_reqs(zram, wb_ctl);
 			/*
 			 * BIO errors are not fatal, we continue and simply
 			 * attempt to writeback the remaining objects (pages).
@@ -1044,18 +1055,17 @@ static int zram_writeback_slots(struct z
 		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1, REQ_OP_WRITE);
 		req->bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
 		req->bio.bi_end_io = zram_writeback_endio;
-		req->bio.bi_private = wb_ctl;
 		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
 
 		zram_submit_wb_request(zram, wb_ctl, req);
 		blk_idx = INVALID_BDEV_BLOCK;
 		req = NULL;
+		cond_resched();
 		continue;
 
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
-		cond_resched();
 	}
 
 	/*
@@ -1065,10 +1075,12 @@ next:
 	if (req)
 		release_wb_req(req);
 
-	blk_finish_plug(&io_plug);
-	err = zram_wb_wait_for_completion(zram, wb_ctl);
-	if (err)
-		ret = err;
+	while (atomic_read(&wb_ctl->num_inflight) > 0) {
+		wait_event(wb_ctl->done_wait, !list_empty(&wb_ctl->done_reqs));
+		err = zram_complete_done_reqs(zram, wb_ctl);
+		if (err)
+			ret = err;
+	}
 
 	return ret;
 }
_

