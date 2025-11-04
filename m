Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AB148850;
	Tue,  4 Nov 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248756; cv=none; b=dLSDiaR8YZJMTnmcj1JfNmw2z7RzJQLD+ozrjOHaN1EViSOb+/OAjgMJpuTvSEfNFfRxZejvP6shSQdZWj/xS6ifZvuHSOuKuQBzKmWSMAUNkRFwBWRMIyowZ0WpIOPn6EMdV0tuUNpy7sMn+SAaIHQ/od1irNWJgK7qjH9Tpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248756; c=relaxed/simple;
	bh=f3h/qhd09WaSZff3ymCwrZpZFHI86hjV72WO6mUiuTs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=uzTreGqsUF4DD6C6yl/JcuqtsfmDuMOqvVOs2pixrXLApoEBhzZ5hZ5LtDp/vACuInbJ97czxPTSBXw39WxBbzgUJjds5BBXpLbTmVw+UoYmXzIWWsdx4mW2Eee7gBJPVQ69LofFfj9aNMVzdTVh3/ffvvbG3DN9BeZMijIoLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=aJMhqfm7; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aJMhqfm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1762248442;
	bh=QnxkGLAVdtCmIzgdscTcRsL1d6z1DKqXbgm/QSULunI=;
	h=From:To:Cc:Subject:Date;
	b=aJMhqfm7w0r+rxWwO0AwJ+DPCBGML6o58W8fnmWNhAv2ckb7jVv3HdhCdvidNmzaA
	 mSKw8r1t6ckhG30KxIughJK8qgjOAHYBV/kOf8A/VvzZb3aCdri7ErsxUPqpoHVCho
	 1ECNkQv+JQin9+bpL0+gZ1dd8EhtG7hy2EsFql+w=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 6D48AA7D; Tue, 04 Nov 2025 17:27:20 +0800
X-QQ-mid: xmsmtpt1762248440ti4r6f9r4
Message-ID: <tencent_78FC2C4FE16BA1EBAF0897DB60FCD675ED05@qq.com>
X-QQ-XMAILINFO: NFre1Y6i/tRCYfxGf8zLohgpt8VpGCDnN270xJycvvSkX5wTTw9Gy4D7ljvpLq
	 cqqkm2Yb+szJGD/JG1RO8bwVCeywUferGocF5PCkMjpmnKFpE/zMnUouxDU87H1ka0nC3nBSi3SQ
	 07g4gmPUSJwA9pkEHRq4cohiYiHu9xACkQXhKypE0x94TRueAH2GPTdi02phZ49NoYuFCgCmEoWn
	 AU/wk2sj0D9lcT9t9kcI+sH03+dkIGeXOMc/znfBmV2o4S4MHEw3MiyRZK3sLLH56Oh8yAOv6RjY
	 j5UEUV8BT7+AhH8MjJNKZqHu+0DYZL0Lbj2NbrzGv5KJDE+RYBtlmWxPalJ9Bp39FjJDni9JCkqI
	 wCK7EG4b4LHC2DubUR6kBG3Po8zk6dex24+9K1uNrn3UUBIjc9tgdcEpCNG8LGDDmt/hb4Rttwld
	 /CTKYy/4y0Ce9Ice4g0iXIuwa1O5ze81mSH2frqBSXD6g1Xc3FaBWeeyf4wf3vBRKJ6Y5Vw4tyMa
	 1rngLtIp5F23BxWGkgyJ3bnT1jaBVZD9oYL5vFIJBeOUBRuKWx5B9bDNFkemc/Q8bE9yaqmvzjuk
	 vDQhuJbfhsBSpRrZ2YGuLJDk2PYnVtGW1O+kQ8aedhOzItm+8AFVK/xYlAQescCkTdlqiPj0etOL
	 NQ0pswSx1TbI6ip1YhHi5UtH7V7vWRs+huUL07O43RQiPzWIubtvveTT9CRdwSx/N5YgryvX8gx9
	 bBtYmET/sMWxOpHikWaR67Ufx+evx3wpOBH3Znxw8LidhCfzNG1kQuIhhVLwVjZps8gjBwMvyD1/
	 pEWHhSQMk08Lj22PprjEXX3xMkuNlKD3b+EJy2zW3kcGszTOh9q3ZcR4fVF1EQXW6dZQEU87zv7L
	 KgxCjM/lrsmIB7QTZFrbFniDI9n+cL31WJlWXS7cEdeKespr0ISnaiWimQ3rQhy9hXKPpL9QGrhH
	 LI0KZqdvSHNQOehnTEpYCU4KsYNYUmCMfhbrePzTj8dm70rLo2a+V7TlSchOCA5u4lFk1+lI2H3r
	 4gRwSifv/rc9BHxp7BOUue4perpiZ/LbJurtNG3+1gzcb4at3T0GKswvq8v5iUb/P3drnwfQSH2E
	 zn/6kaUq3X610iM7OOj4yqankHUQ1v+acvc1wsiY/4pYAroHY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	licayy@outlook.com,
	Yuwen Chen <ywen.chen@foxmail.com>
Subject: [PATCH] zram: Implement multi-page write-back
Date: Tue,  4 Nov 2025 17:27:17 +0800
X-OQ-MSGID: <20251104092717.2658029-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/block/zram/zram_drv.c | 214 +++++++++++++++++++++++++---------
 1 file changed, 161 insertions(+), 53 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..85ef07455eda 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -734,21 +734,125 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	submit_bio(bio);
 }
 
-static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-{
-	unsigned long blk_idx = 0;
-	struct page *page = NULL;
+enum {
+	ZRAM_WB_WORK_ALLOCATED = 0,
+	ZRAM_WB_WORK_COMPLETED,
+};
+struct zram_writeback_work {
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
+static int zram_writeback_complete(struct zram *zram, struct zram_writeback_work *work)
+{
+	u32 index = 0;
+	int err;
+
+	if (!test_and_clear_bit(ZRAM_WB_WORK_COMPLETED, &work->flags))
+		return 0;
+
+	err = blk_status_to_errno(work->bio.bi_status);
+	if (err)
+		return err;
+
+	index = work->pps->index;
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
+	zram_set_handle(zram, index, work->blk_idx);
+	work->blk_idx = 0;
+	atomic64_inc(&zram->stats.pages_stored);
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+
+next:
+	zram_slot_unlock(zram, index);
+	release_pp_slot(zram, work->pps);
+	work->pps = NULL;
+	return 0;
+}
+
+static void zram_writeback_endio(struct bio *bio)
+{
+	struct zram_writeback_work *work = bio->bi_private;
+
+	set_bit(ZRAM_WB_WORK_COMPLETED, &work->flags);
+	clear_bit(ZRAM_WB_WORK_ALLOCATED, &work->flags);
+	complete(work->done);
+}
+
+static struct zram_writeback_work *zram_writeback_next_work(struct zram_writeback_work **pool,
+	int size, int *off)
+{
+	struct zram_writeback_work *work = NULL;
+	int i = 0;
+
+	for (i = *off; i < size + *off; i++) {
+		work = pool[i % size];
+		if (!work->page)
+			continue;
+
+		if (!test_and_set_bit(ZRAM_WB_WORK_ALLOCATED, &work->flags)) {
+			*off = (i + 1) % size;
+			return work;
+		}
+	}
+	return NULL;
+}
+
+#define ZRAM_WRITEBACK_BIO_SIZE (32)
+static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
+{
+	int ret = 0, err, i = 0, off = 0;
+	int work_pool_size = 0;
+	struct zram_writeback_work work_prealloc[2] = {0};
+	struct zram_writeback_work *work_pool[ZRAM_WRITEBACK_BIO_SIZE] = {NULL};
+	struct zram_writeback_work *work = NULL;
+	DECLARE_COMPLETION_ONSTACK(done);
+	u32 index = 0;
+	struct blk_plug plug;
+
+	for (i = 0; i < ARRAY_SIZE(work_pool); i++) {
+		if (i < ARRAY_SIZE(work_prealloc)) {
+			work_pool[i] = &work_prealloc[i];
+		} else {
+			work_pool[i] = kzalloc(sizeof(*work), GFP_KERNEL);
+			if (!work_pool[i])
+				break;
+		}
+		work_pool[i]->done = &done;
+		work_pool[i]->flags = 0;
+		work_pool[i]->page = alloc_page(GFP_KERNEL);
+		if (!work_pool[i]->page)
+			break;
+		work = work_pool[i];
+	}
+	if (!work)
 		return -ENOMEM;
+	work_pool_size = i;
+	set_bit(ZRAM_WB_WORK_ALLOCATED, &work->flags);
 
-	while ((pps = select_pp_slot(ctl))) {
+	blk_start_plug(&plug);
+	while ((work->pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
@@ -757,15 +861,15 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		}
 		spin_unlock(&zram->wb_limit_lock);
 
-		if (!blk_idx) {
-			blk_idx = alloc_block_bdev(zram);
-			if (!blk_idx) {
+		if (!work->blk_idx) {
+			work->blk_idx = alloc_block_bdev(zram);
+			if (!work->blk_idx) {
 				ret = -ENOSPC;
 				break;
 			}
 		}
 
-		index = pps->index;
+		index = work->pps->index;
 		zram_slot_lock(zram, index);
 		/*
 		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
@@ -775,22 +879,32 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		 */
 		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		if (zram_read_from_zspool(zram, page, index))
+		if (zram_read_from_zspool(zram, work->page, index))
 			goto next;
 		zram_slot_unlock(zram, index);
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
+		bio_init(&work->bio, zram->bdev, &work->bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
-		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
-		/*
-		 * XXX: A single page IO would be inefficient for write
-		 * but it would be not bad as starter.
-		 */
-		err = submit_bio_wait(&bio);
+		work->bio.bi_iter.bi_sector = work->blk_idx * (PAGE_SIZE >> 9);
+		work->bio.bi_end_io = zram_writeback_endio;
+		work->bio.bi_private = work;
+		__bio_add_page(&work->bio, work->page, PAGE_SIZE, 0);
+
+		list_del_init(&work->pps->entry);
+		submit_bio(&work->bio);
+
+		do {
+			work = zram_writeback_next_work(work_pool, work_pool_size, &off);
+			if (!work) {
+				blk_finish_plug(&plug);
+				wait_for_completion_io(&done);
+				blk_start_plug(&plug);
+			}
+		} while (!work);
+		err = zram_writeback_complete(zram, work);
 		if (err) {
-			release_pp_slot(zram, pps);
+			release_pp_slot(zram, work->pps);
+			work->pps = NULL;
 			/*
 			 * BIO errors are not fatal, we continue and simply
 			 * attempt to writeback the remaining objects (pages).
@@ -800,43 +914,37 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
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
+		release_pp_slot(zram, work->pps);
+		work->pps = NULL;
 		cond_resched();
 	}
+	blk_finish_plug(&plug);
 
-	if (blk_idx)
-		free_block_bdev(zram, blk_idx);
-	if (page)
-		__free_page(page);
+	if (work)
+		clear_bit(ZRAM_WB_WORK_ALLOCATED, &work->flags);
+	for (i = 0; i < work_pool_size; i++) {
+		while (test_bit(ZRAM_WB_WORK_ALLOCATED, &work_pool[i]->flags))
+			wait_for_completion_io(&done);
+		err = zram_writeback_complete(zram, work_pool[i]);
+		if (err) {
+			release_pp_slot(zram, work_pool[i]->pps);
+			work->pps = NULL;
+			ret = err;
+		}
 
+		if (work_pool[i]->blk_idx)
+			free_block_bdev(zram, work_pool[i]->blk_idx);
+		if (work_pool[i]->page)
+			__free_page(work_pool[i]->page);
+		if (i >= ARRAY_SIZE(work_prealloc))
+			kfree(work_pool[i]);
+	}
 	return ret;
 }
 
-- 
2.34.1

