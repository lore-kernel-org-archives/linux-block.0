Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E59C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjDDPGW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjDDPGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:06:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDE74493
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PgV94jq0pqm0XP4KHz0HLPfbo2jIUcDCbLKMGSqIU4U=; b=MKDsmbNJav69Ej/e0IZArIiwh1
        AjRFsEf39HAM0ie54zdo0SuywT1z6IZrSpvCOrfde4Fvscp74vZd2LEznEmfNvh/brviol0WrfyrJ
        q0PCYpZAFmDMgaufMIh362JKilfBKLTUD19cqnRsRnvqvoMYmekNHqVIUUYPHE5e+yqh7UYxk+Jen
        QCC2ucHd2iM/Q+aiH5YnTRR8dnPD+iddtmt5LjFTIS9BC5sRO8oeqhtXRN9G9x88buaRZxtL9PIM5
        MUpb2K5yWSau04iVrfxk7Azt0Tqoyx2MskUPRPMynwgt9HuLRgM44fhZ1iWmutFfXHhpvy4Rbz+rJ
        X7e9hEzg==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEe-001vuH-2Z;
        Tue, 04 Apr 2023 15:06:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 13/16] zram: pass a page to read_from_bdev
Date:   Tue,  4 Apr 2023 17:05:33 +0200
Message-Id: <20230404150536.2142108-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
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
---
 drivers/block/zram/zram_drv.c | 46 +++++++++++++----------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9a3bee1dda01c0..762f617d8ba9ad 100644
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

