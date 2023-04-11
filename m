Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E177DC77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDKRQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDKRP5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CF5FF3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mXZvFVgOV0EYdkDrPTky0MWvG4mlZlCP86DArKKEjVA=; b=kkSGDUQc4psf2GCUMivs/DsFvo
        FlkE4sXdF81Mf3q9u9eo0Hnlxvi9jqXSNKk4cyAN3GQLAjZTUx28dzMQxnuOn9IQUgXI6iN8r/QDw
        bNnSoAVIj9YvnWcoX2FLC+tNnsqXynUAJblVcSSfSOj19j0CQwWCswBHaayBkMyciZ86N6SbJxl5S
        99I3KoHSA5tPWoikGSReGktbQ0JDVel7tlC+I6v6eJvlQqzOJ0xkwuCq6q9Omxjx3d6suEmtD9Vxz
        mOOyuH6Hhml+XcfF96FFWpyqPRUGmzC2WaWzuybrxxgXDxez+xA9M/BmciY02RDX0r1e59XZL+ftW
        snciB6lA==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHap-000gsE-0Q;
        Tue, 11 Apr 2023 17:15:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 16/17] zram: fix synchronous reads
Date:   Tue, 11 Apr 2023 19:14:58 +0200
Message-Id: <20230411171459.567614-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently nothing waits for the synchronous reads before accessing
the data.  Switch them to an on-stack bio and submit_bio_wait to
make sure the I/O has actually completed when the work item has been
flushed.  This also removes the call to page_endio that would unlock
a page that has never been locked.

Drop the partial_io/sync flag, as chaining only makes sense for the
asynchronous reads of the entire page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 60 +++++++++++++----------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 07ebce1fde581b..07114607c1ea11 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -55,7 +55,7 @@ static const struct block_device_operations zram_devops;
 
 static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-			  struct bio *bio, bool partial_io);
+			  struct bio *parent);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -576,31 +576,15 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	atomic64_dec(&zram->stats.bd_count);
 }
 
-static void zram_page_end_io(struct bio *bio)
-{
-	struct page *page = bio_first_page_all(bio);
-
-	page_endio(page, op_is_write(bio_op(bio)),
-			blk_status_to_errno(bio->bi_status));
-	bio_put(bio);
-}
-
 static void read_from_bdev_async(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent)
 {
 	struct bio *bio;
 
-	bio = bio_alloc(zram->bdev, 1, parent ? parent->bi_opf : REQ_OP_READ,
-			GFP_NOIO);
-
+	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
-
-	if (!parent)
-		bio->bi_end_io = zram_page_end_io;
-	else
-		bio_chain(bio, parent);
-
+	bio_chain(bio, parent);
 	submit_bio(bio);
 }
 
@@ -705,7 +689,7 @@ static ssize_t writeback_store(struct device *dev,
 		/* Need for hugepage writeback racing */
 		zram_set_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
-		if (zram_read_page(zram, page, index, NULL, false)) {
+		if (zram_read_page(zram, page, index, NULL)) {
 			zram_slot_lock(zram, index);
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
@@ -785,18 +769,19 @@ struct zram_work {
 	struct work_struct work;
 	struct zram *zram;
 	unsigned long entry;
-	struct bio *bio;
 	struct page *page;
 };
 
 static void zram_sync_read(struct work_struct *work)
 {
 	struct zram_work *zw = container_of(work, struct zram_work, work);
-	struct zram *zram = zw->zram;
-	unsigned long entry = zw->entry;
-	struct bio *bio = zw->bio;
+	struct bio_vec bv;
+	struct bio bio;
 
-	read_from_bdev_async(zram, zw->page, entry, bio);
+	bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
+	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
+	submit_bio_wait(&bio);
 }
 
 /*
@@ -805,14 +790,13 @@ static void zram_sync_read(struct work_struct *work)
  * use a worker thread context.
  */
 static int read_from_bdev_sync(struct zram *zram, struct page *page,
-				unsigned long entry, struct bio *bio)
+				unsigned long entry)
 {
 	struct zram_work work;
 
 	work.page = page;
 	work.zram = zram;
 	work.entry = entry;
-	work.bio = bio;
 
 	INIT_WORK_ONSTACK(&work.work, zram_sync_read);
 	queue_work(system_unbound_wq, &work.work);
@@ -823,13 +807,13 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page,
 }
 
 static int read_from_bdev(struct zram *zram, struct page *page,
-			unsigned long entry, struct bio *parent, bool sync)
+			unsigned long entry, struct bio *parent)
 {
 	atomic64_inc(&zram->stats.bd_reads);
-	if (sync) {
+	if (!parent) {
 		if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
 			return -EIO;
-		return read_from_bdev_sync(zram, page, entry, parent);
+		return read_from_bdev_sync(zram, page, entry);
 	}
 	read_from_bdev_async(zram, page, entry, parent);
 	return 1;
@@ -837,7 +821,7 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 #else
 static inline void reset_bdev(struct zram *zram) {};
 static int read_from_bdev(struct zram *zram, struct page *page,
-			unsigned long entry, struct bio *parent, bool sync)
+			unsigned long entry, struct bio *parent)
 {
 	return -EIO;
 }
@@ -1370,7 +1354,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 }
 
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-			  struct bio *bio, bool partial_io)
+			  struct bio *parent)
 {
 	int ret;
 
@@ -1387,7 +1371,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		zram_slot_unlock(zram, index);
 
 		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
-				     bio, partial_io);
+				     parent);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
@@ -1402,14 +1386,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
  * always expects a full page for the output.
  */
 static int zram_bvec_read_partial(struct zram *zram, struct bio_vec *bvec,
-				  u32 index, int offset, struct bio *bio)
+				  u32 index, int offset)
 {
 	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
 
 	if (!page)
 		return -ENOMEM;
-	ret = zram_read_page(zram, page, index, bio, true);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (likely(!ret))
 		memcpy_to_bvec(bvec, page_address(page) + offset);
 	__free_page(page);
@@ -1420,8 +1404,8 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 			  u32 index, int offset, struct bio *bio)
 {
 	if (is_partial_io(bvec))
-		return zram_bvec_read_partial(zram, bvec, index, offset, bio);
-	return zram_read_page(zram, bvec->bv_page, index, bio, false);
+		return zram_bvec_read_partial(zram, bvec, index, offset);
+	return zram_read_page(zram, bvec->bv_page, index, bio);
 }
 
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
@@ -1561,7 +1545,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio, true);
+	ret = zram_read_page(zram, page, index, bio);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);
-- 
2.39.2

