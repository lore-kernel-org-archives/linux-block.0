Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560EAC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDFOnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbjDFOmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44454B47C
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BPwQtQRGYsQcM8Kv6yPqE5YjlrZCbRbsR865MBdJePw=; b=LV8hg5In7GBK/thsStg+k5oN24
        ZRV5hmMipdFIBxPsuvq7J0bm1fjwNwtKk/3uBJ6EJuQMNlSjw9naWi6GamzB3Z8m+eSe3VKx9Jf03
        dYYk5MIdy4HZTQCn9JpvNUldv5HCnCOMhoAsHUPOCxsRmzOA4s2D8iGogYs66etuHiJXXvvsxu3ju
        uEdslfp5qGX1Pddvuxoa7MUMTITnfICG8n+GpOrwzKt0T4eAqEx0UiZYssaHvi/zvmRFMMkvmI2cF
        2yDISnEGEpnPuxVJ5a3Xy4drusECGVf+RWdQMhW/ws9SCz009U6kb/4AGh8CH5o8N6vVZZSaFY1Yg
        EJIPMzVg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnw-007fnX-0r;
        Thu, 06 Apr 2023 14:41:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 13/16] zram: pass a page to read_from_bdev
Date:   Thu,  6 Apr 2023 16:40:59 +0200
Message-Id: <20230406144102.149231-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

read_from_bdev always reads a whole page, so pass a page to it instead
of the bvec and remove the now pointless zram_bvec_read_from_bdev
wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 46 +++++++++++++----------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1bd6160a49b25c..9d066c6a4f8265 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -587,7 +587,7 @@ static void zram_page_end_io(struct bio *bio)
 /*
  * Returns 1 if the submission is successful.
  */
-static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
+static int read_from_bdev_async(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent)
 {
 	struct bio *bio;
@@ -598,7 +598,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 		return -ENOMEM;
 
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
-	if (!bio_add_page(bio, bvec->bv_page, bvec->bv_len, bvec->bv_offset)) {
+	if (!bio_add_page(bio, page, PAGE_SIZE, 0)) {
 		bio_put(bio);
 		return -EIO;
 	}
@@ -794,7 +794,7 @@ struct zram_work {
 	struct zram *zram;
 	unsigned long entry;
 	struct bio *bio;
-	struct bio_vec bvec;
+	struct page *page;
 };
 
 #if PAGE_SIZE != 4096
@@ -805,7 +805,7 @@ static void zram_sync_read(struct work_struct *work)
 	unsigned long entry = zw->entry;
 	struct bio *bio = zw->bio;
 
-	read_from_bdev_async(zram, &zw->bvec, entry, bio);
+	read_from_bdev_async(zram, zw->page, entry, bio);
 }
 
 /*
@@ -813,12 +813,12 @@ static void zram_sync_read(struct work_struct *work)
  * chained IO with parent IO in same context, it's a deadlock. To avoid that,
  * use a worker thread context.
  */
-static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
+static int read_from_bdev_sync(struct zram *zram, struct page *page,
 				unsigned long entry, struct bio *bio)
 {
 	struct zram_work work;
 
-	work.bvec = *bvec;
+	work.page = page;
 	work.zram = zram;
 	work.entry = entry;
 	work.bio = bio;
@@ -831,7 +831,7 @@ static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
 	return 1;
 }
 #else
-static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
+static int read_from_bdev_sync(struct zram *zram, struct page *page,
 				unsigned long entry, struct bio *bio)
 {
 	WARN_ON(1);
@@ -839,18 +839,17 @@ static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
 }
 #endif
 
-static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
+static int read_from_bdev(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent, bool sync)
 {
 	atomic64_inc(&zram->stats.bd_reads);
 	if (sync)
-		return read_from_bdev_sync(zram, bvec, entry, parent);
-	else
-		return read_from_bdev_async(zram, bvec, entry, parent);
+		return read_from_bdev_sync(zram, page, entry, parent);
+	return read_from_bdev_async(zram, page, entry, parent);
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
+static int read_from_bdev(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent, bool sync)
 {
 	return -EIO;
@@ -1334,20 +1333,6 @@ static void zram_free_page(struct zram *zram, size_t index)
 		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
 }
 
-/*
- * Reads a page from the writeback devices. Corresponding ZRAM slot
- * should be unlocked.
- */
-static int zram_bvec_read_from_bdev(struct zram *zram, struct page *page,
-				    u32 index, struct bio *bio, bool partial_io)
-{
-	struct bio_vec bvec;
-
-	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
-	return read_from_bdev(zram, &bvec, zram_get_element(zram, index), bio,
-			      partial_io);
-}
-
 /*
  * Reads (decompresses if needed) a page from zspool (zsmalloc).
  * Corresponding ZRAM slot should be locked.
@@ -1408,11 +1393,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		ret = zram_read_from_zspool(zram, page, index);
 		zram_slot_unlock(zram, index);
 	} else {
-		/* Slot should be unlocked before the function call */
+		/*
+		 * The slot should be unlocked before reading from the backing
+		 * device.
+		 */
 		zram_slot_unlock(zram, index);
 
-		ret = zram_bvec_read_from_bdev(zram, page, index, bio,
-					       partial_io);
+		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
+				     bio, partial_io);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
-- 
2.39.2

