Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD746C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbjDFOnJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjDFOmf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B494AF29
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8qqoJE/4D8dWQh1PJHW9q8zUJEH6ruAfZTs7nxXPOCE=; b=XYRAdb1hofNMagkIYgOQzFAACM
        zCIgiXIghqU3lchhQWdywR+QLFZltq5jM7yZ2pKJBC8A/1iGJjrzorFotRf41fY2mnicfKuG2zrSn
        1hYEWQy/d0DNx2H1ZPvsFEQg2fMFkGpHSQz6q38e8qBaoQDaB6czUyQipN9lIyYYAAh5uhph8mOql
        ccIVeLUvphRtKwizmi+dguymR74TdadVGoRY8LyuyUoaCbJFLiGIeajzfD6Bc0qIFWVeZE9c7MHzA
        GcIDtq7Xfv/FAHcNCroomFulp0htEwEgOVu/o/WlKgSBkcpiPg8rEG3uAzJuoUDfhNBBsA5FxyEg5
        +XorJDeA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnV-007ffe-0X;
        Thu, 06 Apr 2023 14:41:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 01/16] zram: remove valid_io_request
Date:   Thu,  6 Apr 2023 16:40:47 +0200
Message-Id: <20230406144102.149231-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All bios hande to drivers from the block layer are checked against the
device size and for logical block alignment already (and have been since
long before zram was merged), so don't duplicate those checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 34 +---------------------------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa490da3cef233..0c6b3ba2970b5f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -174,30 +174,6 @@ static inline u32 zram_get_priority(struct zram *zram, u32 index)
 	return prio & ZRAM_COMP_PRIORITY_MASK;
 }
 
-/*
- * Check if request is within bounds and aligned on zram logical blocks.
- */
-static inline bool valid_io_request(struct zram *zram,
-		sector_t start, unsigned int size)
-{
-	u64 end, bound;
-
-	/* unaligned request */
-	if (unlikely(start & (ZRAM_SECTOR_PER_LOGICAL_BLOCK - 1)))
-		return false;
-	if (unlikely(size & (ZRAM_LOGICAL_BLOCK_SIZE - 1)))
-		return false;
-
-	end = start + (size >> SECTOR_SHIFT);
-	bound = zram->disksize >> SECTOR_SHIFT;
-	/* out of range */
-	if (unlikely(start >= bound || end > bound || start > end))
-		return false;
-
-	/* I/O request is valid */
-	return true;
-}
-
 static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
 {
 	*index  += (*offset + bvec->bv_len) / PAGE_SIZE;
@@ -1190,10 +1166,9 @@ static ssize_t io_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8llu\n",
+			"%8llu %8llu 0 %8llu\n",
 			(u64)atomic64_read(&zram->stats.failed_reads),
 			(u64)atomic64_read(&zram->stats.failed_writes),
-			(u64)atomic64_read(&zram->stats.invalid_io),
 			(u64)atomic64_read(&zram->stats.notify_free));
 	up_read(&zram->init_lock);
 
@@ -2043,13 +2018,6 @@ static void zram_submit_bio(struct bio *bio)
 {
 	struct zram *zram = bio->bi_bdev->bd_disk->private_data;
 
-	if (!valid_io_request(zram, bio->bi_iter.bi_sector,
-					bio->bi_iter.bi_size)) {
-		atomic64_inc(&zram->stats.invalid_io);
-		bio_io_error(bio);
-		return;
-	}
-
 	__zram_make_request(zram, bio);
 }
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c5254626f051fa..ca7a15bd48456a 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -78,7 +78,6 @@ struct zram_stats {
 	atomic64_t compr_data_size;	/* compressed size of pages stored */
 	atomic64_t failed_reads;	/* can happen when memory is too low */
 	atomic64_t failed_writes;	/* can happen when memory is too low */
-	atomic64_t invalid_io;	/* non-page-aligned I/O requests */
 	atomic64_t notify_free;	/* no. of swap slot free notifications */
 	atomic64_t same_pages;		/* no. of same element filled pages */
 	atomic64_t huge_pages;		/* no. of huge pages */
-- 
2.39.2

