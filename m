Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3136EC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDKRPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjDKRPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E85B99
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=w4bovRuzWmZ+/CPNRrCY01XIlAS3yNl+nI3jTa6ZEno=; b=mEWh/p6wjp+OD+lhqe/TwxFKAk
        JDZoHhrVcMkSMZ5tCTklDHgNoMXaat3amGq3AvFY1nXSQ5HNJeR0zDbMgEVrvhb8ySllpspAdaU3a
        YZXkU9NC1JdMPDAbFKnKfZMT1Z6pPbofUkWDyIT97XXCnyI9/DWITOAqS8RBF0ymo6FfwalpPdQ91
        Q3LlnMjQ/KSgZ+Ozf/ppi8rTC229FDhip8XsXiAg/e1wrDKl/t2w+EuFIQwLgOBSZzMIGqKsoD15D
        Z5g1Efd1j288E2F8Mj5DVgRjrqAxYDd1NNnyOc37T+tuHGd40ziELbty1vB+w2scGauhxmtrpOZCq
        fuUn/D4Q==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaZ-000gpY-0g;
        Tue, 11 Apr 2023 17:15:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 10/17] zram: directly call zram_read_page in writeback_store
Date:   Tue, 11 Apr 2023 19:14:52 +0200
Message-Id: <20230411171459.567614-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

writeback_store always reads a full page, so just call zram_read_page
directly and bypass the boune buffer handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 414343b46ade8d..67b88e9a978d9e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -54,9 +54,8 @@ static size_t huge_class_size;
 static const struct block_device_operations zram_devops;
 
 static void zram_free_page(struct zram *zram, size_t index);
-static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
-				u32 index, int offset, struct bio *bio);
-
+static int zram_read_page(struct zram *zram, struct page *page, u32 index,
+			  struct bio *bio, bool partial_io);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -672,10 +671,6 @@ static ssize_t writeback_store(struct device *dev,
 	}
 
 	for (; nr_pages != 0; index++, nr_pages--) {
-		struct bio_vec bvec;
-
-		bvec_set_page(&bvec, page, PAGE_SIZE, 0);
-
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
@@ -719,7 +714,7 @@ static ssize_t writeback_store(struct device *dev,
 		/* Need for hugepage writeback racing */
 		zram_set_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
-		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
+		if (zram_read_page(zram, page, index, NULL, false)) {
 			zram_slot_lock(zram, index);
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
@@ -730,9 +725,8 @@ static ssize_t writeback_store(struct device *dev,
 		bio_init(&bio, zram->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-
-		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
-				bvec.bv_offset);
+		bio_add_page(&bio, page, PAGE_SIZE, 0);
+	
 		/*
 		 * XXX: A single page IO would be inefficient for write
 		 * but it would be not bad as starter.
-- 
2.39.2

