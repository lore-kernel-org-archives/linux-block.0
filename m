Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0441DE4EF;
	Wed,  5 Nov 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325609; cv=none; b=BX6/uHfFXxOyklmIhqm4G7prUggjERMmjFY4DUK0xljuq7+ETBxe49FmlJbljQKkSWEyhyKBM2fIYulEIoNPZE2TDqNgJ67I+zmY0JRbYDmGPXMAG/u+isZx7MY4toZrqSU7CQHbMUMlNzDx7si60RBPusMw6ND+Py9kEP8DfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325609; c=relaxed/simple;
	bh=0mWnEOVacj3cGA7GI/EWCIoCvvtQEXQYIvQB95dcB0M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=L/KPtyOuzsY52/bqCiECwYf5IjarziCXZlwuVUHmIRXQRX2X5MlCvci8tIy+ghh0rCFSB38ww65TcCWXbnCI4A6+PpMbyaJjHieoxm43Vy/jBi7OtfNjp+2h2qjf+R1dfhAn3WHgfZFdvAU1oWKbB84edjVYetCJaQdk5pJvv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pA2Dn0SW; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pA2Dn0SW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1762325292;
	bh=mq0JclBaKBy4TWJ/ryyvsbPzM+n7z5k9LWVUwRw09pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pA2Dn0SW6uCilyS4Jd88ookYK4VOEjweQrDJle6m5y1CpoNtrvIl9U1tU7v3bpFic
	 f4hegzMgL3Sa+VUhQVPtbA6IiOxTvz6fX0XoRQ5ModbxZiCATuXaHsLLXqpz98KPdV
	 7TUNucWBp/7HzDsY3Ln3HNK6KuVpGOh9CfZuvhyo=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C09020D0; Wed, 05 Nov 2025 14:48:09 +0800
X-QQ-mid: xmsmtpt1762325289tzwix3fmp
Message-ID: <tencent_25F89AABFE39535EF957519750D107B7D406@qq.com>
X-QQ-XMAILINFO: MfXlhb1xJpsOoWvb9KDTSsn7+G3+IQwE/kGDDi09Bd4UMOaaXP8X4IJ2J3rzLL
	 MUSe1cNV5v19tJRYJSI1BAfSvmtabJBs+6WgDlzlkoF+gHPYEhST8P4nqHjmYPH/4T4WmYE/Mo+t
	 vhBuU6tI8N93MJydEZzJ0lRHAY+SzpOWNmwUBnKNnH0EFVWOTA0gr3NKZFthWWW6U/SS8Ir0lQ5w
	 wPAgA7ae2V0Pyi9AjZ1thW55/Y1kl2qYAq3JKkfe2Xk+DjryxfG1r6QXnsQQF0BCxgNv8gdVb2k3
	 UzxujK5VlTdGzchyS0X9/gl16zOMCD9p1Pg1O3CTxmSgi2LXLIyJPigRYgBnSCln++4QLC24NiFG
	 K0t6XcfSLPlV/oR0Fob8WEsyj5BtUGPbm31/7+OPXUhYYbN9LKx2xaqBlgtKTz98Kri+twmPOJu8
	 QWLdrY/ytBNcccFM/3CVMwdrry0HFRZ1n0UBkN4hFwaUegUFPUOhz1G3A55zB1YaFzOEP3SLxVWe
	 7K39ikWXeLo0c3SrDQwkTH2Zrc7LWsOudZtvo0DqLzZMERVlN2iAGvKjnTSojfSj1Brx94nmiQja
	 75LklGflGKDx4uWMO/f/kCWgcE17vtXATgDD+SF4XNLRXI799yitsBW/BDxftGR361ST4iZSjMop
	 OMaOp+E1Mk22OmXEYPq6wGwoxuVIZU8yWFA92RkxLyVHUP+lb+g7XAzKtdAlsZJ2SiHlUXwWv2FY
	 FkWRbOMTxQWe4Z89PvBhDc3xPo4j20iIUMy5RKerO96GR05+LrobD/AfeJl1Q3Hh3C49wEJwUxfa
	 YVV6Njp5p+PQw/7IEU2CmDYFm197mj/5ODR0QET1DlBo6OSXQUTiBJcYulIK5/37D2veYz66KlcP
	 +GwashhllGX9/RvhWuik3w45JFZAGBmN3oVd0CTnjOe9v4tO8CCyC0JBDCLiz7wxo827vW7Kzq10
	 lXivwfbliMbVMiRiW4Kg3GpdSt8vwvizMgdfHczCWgyFiytVJ1xCepySpvTsFURs9XTF+bwFER3I
	 JVqqYU7w4/toK3h1Quvdaa4JnJRmcMMenNcS+o6SZhPHe+BQppI3TQYQtllTG8uTy0eVAvIGyL1N
	 nL7W5QN7j+4qdBdXE=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liumartin@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	senozhatsky@chromium.org
Subject: [PATCH v3] zram: Implement multi-page write-back
Date: Wed,  5 Nov 2025 14:48:06 +0800
X-OQ-MSGID: <20251105064806.2693018-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_85F14CD7BA73843CA32FF7AEB6A21A6EC907@qq.com>
References: <tencent_85F14CD7BA73843CA32FF7AEB6A21A6EC907@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For block devices, sequential write performance is significantly
better than random write. Currently, zram's write-back function
only supports single-page operations, which fails to leverage
the sequential write advantage and leads to suboptimal performance.
This patch implements multi-page batch write-back for zram to
leverage sequential write performance of block devices.
After applying this patch, a large number of pages being merged
into batch write operations can be observed via the following test
code, which effectively improves write-back performance.

mount -t debugfs none /sys/kernel/debug/
echo "block:block_bio_frontmerge" >> /sys/kernel/debug/tracing/set_event
echo "block:block_bio_backmerge" >> /sys/kernel/debug/tracing/set_event
cat /sys/kernel/debug/tracing/trace_pipe &
echo "page_indexes=1-10000" > /sys/block/zram0/writeback

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Reviewed-by: Fengyu Lian <licayy@outlook.com>
---
Changes in v3:
  - Postpone the page allocation.
Changes in v2:
  - Rename some data structures.
  - Fix an exception caused by accessing a null pointer.
---
 drivers/block/zram/zram_drv.c | 224 ++++++++++++++++++++++++++--------
 1 file changed, 170 insertions(+), 54 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4f2824a..ce8fc3c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -751,21 +751,131 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	submit_bio(bio);
 }
 
-static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-{
-	unsigned long blk_idx = 0;
-	struct page *page = NULL;
+enum {
+	/* Indicate that the request has been allocated */
+	ZRAM_WB_REQUEST_ALLOCATED = 0,
+
+	/* the request has been processed by the block device layer */
+	ZRAM_WB_REQUEST_COMPLETED,
+};
+
+struct zram_wb_request {
+	struct completion *done;
+	unsigned long blk_idx;
+	struct page *page;
 	struct zram_pp_slot *pps;
 	struct bio_vec bio_vec;
 	struct bio bio;
-	int ret = 0, err;
-	u32 index;
+	unsigned long flags;
+};
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+static int zram_writeback_complete(struct zram *zram, struct zram_wb_request *req)
+{
+	u32 index = 0;
+	int err;
 
-	while ((pps = select_pp_slot(ctl))) {
+	if (!test_and_clear_bit(ZRAM_WB_REQUEST_COMPLETED, &req->flags))
+		return 0;
+
+	err = blk_status_to_errno(req->bio.bi_status);
+	if (err)
+		return err;
+
+	index = req->pps->index;
+	atomic64_inc(&zram->stats.bd_writes);
+	zram_slot_lock(zram, index);
+	/*
+	 * Same as above, we release slot lock during writeback so
+	 * slot can change under us: slot_free() or slot_free() and
+	 * reallocation (zram_write_page()). In both cases slot loses
+	 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
+	 * ZRAM_PP_SLOT on such slots until current post-processing
+	 * finishes.
+	 */
+	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
+		goto next;
+
+	zram_free_page(zram, index);
+	zram_set_flag(zram, index, ZRAM_WB);
+	zram_set_handle(zram, index, req->blk_idx);
+	req->blk_idx = 0;
+	atomic64_inc(&zram->stats.pages_stored);
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+
+next:
+	zram_slot_unlock(zram, index);
+	release_pp_slot(zram, req->pps);
+	req->pps = NULL;
+	return 0;
+}
+
+static void zram_writeback_endio(struct bio *bio)
+{
+	struct zram_wb_request *req = bio->bi_private;
+
+	set_bit(ZRAM_WB_REQUEST_COMPLETED, &req->flags);
+	clear_bit(ZRAM_WB_REQUEST_ALLOCATED, &req->flags);
+	complete(req->done);
+}
+
+static struct zram_wb_request *zram_writeback_next_request(struct zram_wb_request *pool,
+	int pool_cnt, int *cnt_off)
+{
+	struct zram_wb_request *req = NULL;
+	int i = 0;
+
+	for (i = *cnt_off; i < pool_cnt + *cnt_off; i++) {
+		req = &pool[i % pool_cnt];
+		if (!req->page) {
+			/* This memory should be freed by the caller. */
+			req->page = alloc_page(GFP_KERNEL);
+			if (!req->page)
+				continue;
+		}
+
+		if (!test_and_set_bit(ZRAM_WB_REQUEST_ALLOCATED, &req->flags)) {
+			*cnt_off = (i + 1) % pool_cnt;
+			return req;
+		}
+	}
+	return NULL;
+}
+
+#define ZRAM_WB_REQ_CNT (32)
+static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
+{
+	int ret = 0, err, i = 0, cnt_off = 0;
+	int req_pool_cnt = 0;
+	struct zram_wb_request req_prealloc[2] = {0};
+	struct zram_wb_request *req = NULL, *req_pool = NULL;
+	DECLARE_COMPLETION_ONSTACK(done);
+	u32 index = 0;
+	struct blk_plug plug;
+
+	/* allocate memory for req_pool */
+	req_pool = kzalloc(sizeof(*req) * ZRAM_WB_REQ_CNT, GFP_KERNEL);
+	if (req_pool) {
+		req_pool_cnt = ZRAM_WB_REQ_CNT;
+	} else {
+		req_pool = req_prealloc;
+		req_pool_cnt = ARRAY_SIZE(req_prealloc);
+	}
+
+	for (i = 0; i < req_pool_cnt; i++) {
+		req_pool[i].done = &done;
+		req_pool[i].flags = 0;
+	}
+	req = zram_writeback_next_request(req_pool, req_pool_cnt, &cnt_off);
+	if (!req) {
+		ret = -ENOMEM;
+		goto out_free_req_pool;
+	}
+
+	blk_start_plug(&plug);
+	while ((req->pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
@@ -774,15 +884,15 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		}
 		spin_unlock(&zram->wb_limit_lock);
 
-		if (!blk_idx) {
-			blk_idx = alloc_block_bdev(zram);
-			if (!blk_idx) {
+		if (!req->blk_idx) {
+			req->blk_idx = alloc_block_bdev(zram);
+			if (!req->blk_idx) {
 				ret = -ENOSPC;
 				break;
 			}
 		}
 
-		index = pps->index;
+		index = req->pps->index;
 		zram_slot_lock(zram, index);
 		/*
 		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
@@ -792,22 +902,32 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		 */
 		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		if (zram_read_from_zspool(zram, page, index))
+		if (zram_read_from_zspool(zram, req->page, index))
 			goto next;
 		zram_slot_unlock(zram, index);
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
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
+		req->bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
+		req->bio.bi_end_io = zram_writeback_endio;
+		req->bio.bi_private = req;
+		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
+
+		list_del_init(&req->pps->entry);
+		submit_bio(&req->bio);
+
+		do {
+			req = zram_writeback_next_request(req_pool, req_pool_cnt, &cnt_off);
+			if (!req) {
+				blk_finish_plug(&plug);
+				wait_for_completion_io(&done);
+				blk_start_plug(&plug);
+			}
+		} while (!req);
+		err = zram_writeback_complete(zram, req);
 		if (err) {
-			release_pp_slot(zram, pps);
+			release_pp_slot(zram, req->pps);
+			req->pps = NULL;
 			/*
 			 * BIO errors are not fatal, we continue and simply
 			 * attempt to writeback the remaining objects (pages).
@@ -817,43 +937,39 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 			 * the most recent BIO error.
 			 */
 			ret = err;
-			continue;
 		}
+		cond_resched();
+		continue;
 
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
-		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
-		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-		spin_unlock(&zram->wb_limit_lock);
 next:
 		zram_slot_unlock(zram, index);
-		release_pp_slot(zram, pps);
-
+		release_pp_slot(zram, req->pps);
+		req->pps = NULL;
 		cond_resched();
 	}
+	blk_finish_plug(&plug);
 
-	if (blk_idx)
-		free_block_bdev(zram, blk_idx);
-	if (page)
-		__free_page(page);
+	if (req)
+		clear_bit(ZRAM_WB_REQUEST_ALLOCATED, &req->flags);
+	for (i = 0; i < req_pool_cnt; i++) {
+		while (test_bit(ZRAM_WB_REQUEST_ALLOCATED, &req_pool[i].flags))
+			wait_for_completion_io(&done);
+		err = zram_writeback_complete(zram, &req_pool[i]);
+		if (err) {
+			release_pp_slot(zram, req_pool[i].pps);
+			req->pps = NULL;
+			ret = err;
+		}
+
+		if (req_pool[i].blk_idx)
+			free_block_bdev(zram, req_pool[i].blk_idx);
+		if (req_pool[i].page)
+			__free_page(req_pool[i].page);
+	}
 
+out_free_req_pool:
+	if (req_pool != req_prealloc)
+		kfree(req_pool);
 	return ret;
 }
 
-- 
2.34.1

