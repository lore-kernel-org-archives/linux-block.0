Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B2C77B60
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjDDPGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjDDPGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:06:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF2C3AAC
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bVyjwuzlJ1I0PCcevEE14jYw7gKtiOYiWr+7Pje49B4=; b=wuDDalc2SA1DwvAwHBDEM1UIhJ
        +6Dwh83s+80FzpjTHU3PzEDFdTppRaFbv4+qum6ybzuTjKsgWqKL/yZqzAdkxuks5kg0WVeRFsdOM
        F85yv3zPWbq34OgoS/AgZ3Hy6bj1fuNhrqsUpRt4nTg0vAvQm/IgZtLOrSSo2FxFlTON5X4zP13wW
        Tmzu6yBuKp+iejvt/1rd+gZ2maE85llT2EfIJibwbPR23iNuSmQyM+s4882HEz/fWkC1igFgA8gtj
        uzJPPIgJVHKqDvwX7Sj5EUy7LhyJGPyl+5SSFGdsaFaCJePbqW+06jaqziB2ER7E2velP03bx6qol
        tI0pVJlw==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEU-001vsv-2D;
        Tue, 04 Apr 2023 15:06:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 09/16] zram: directly call zram_read_page in writeback_store
Date:   Tue,  4 Apr 2023 17:05:29 +0200
Message-Id: <20230404150536.2142108-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

writeback_store always reads a full page, so just call zram_read_page
directly and bypass the boune buffer handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6187e41a346fd8..9d2b6ef4638903 100644
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
@@ -671,10 +670,6 @@ static ssize_t writeback_store(struct device *dev,
 	}
 
 	for (; nr_pages != 0; index++, nr_pages--) {
-		struct bio_vec bvec;
-
-		bvec_set_page(&bvec, page, PAGE_SIZE, 0);
-
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
@@ -718,7 +713,7 @@ static ssize_t writeback_store(struct device *dev,
 		/* Need for hugepage writeback racing */
 		zram_set_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
-		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
+		if (zram_read_page(zram, page, index, NULL, false)) {
 			zram_slot_lock(zram, index);
 			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
 			zram_clear_flag(zram, index, ZRAM_IDLE);
@@ -729,9 +724,8 @@ static ssize_t writeback_store(struct device *dev,
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

