Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CEEC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbjDFOnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbjDFOmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E450B741
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FUcwps301urqg03haFf1fv3l0Vi868+/n2hJTcLWJfw=; b=FUOjJ3vkD9RuRK6Cfryn4wYUNz
        tpgPyBlGTDWrOGw1BV9bSxpp1uj0R32pFM7YLGrZN2hEptM8PaPhAnD/+YHxViAasiwqkuYzsJOQG
        vFR3twEpRErFafL6ZWT9FHoh6DpofCPmKqI8iWNqlFBdAcG2kiLMcLzfnYkhQonE5uVNhpNws43KK
        9dankH8nZDTBW0xSujO0Kk22XprxzdCbHvSBA3Gul4XOLd859lPJIKFRZyaoVYiOuyzsoNckJ4wG4
        IkMODNT2nefmVGRUwR5iE5z3AEo5b04jFaTAlOnSPS7hq/VDveUX9pEIReEWlViN/S9woQozSiJrX
        hzrd5qMw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQny-007fo0-1h;
        Thu, 06 Apr 2023 14:41:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 14/16] zram: don't return errors from read_from_bdev_async
Date:   Thu,  6 Apr 2023 16:41:00 +0200
Message-Id: <20230406144102.149231-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_alloc will never return a NULL bio when it is allowed to sleep,
and adding a single page to bio with a single vector also can't
fail, so switch to the asserting __bio_add_page variant and drop the
error returns.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9d066c6a4f8265..ec6df834189b7a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -584,24 +584,16 @@ static void zram_page_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-/*
- * Returns 1 if the submission is successful.
- */
-static int read_from_bdev_async(struct zram *zram, struct page *page,
+static void read_from_bdev_async(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent)
 {
 	struct bio *bio;
 
 	bio = bio_alloc(zram->bdev, 1, parent ? parent->bi_opf : REQ_OP_READ,
 			GFP_NOIO);
-	if (!bio)
-		return -ENOMEM;
 
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
-	if (!bio_add_page(bio, page, PAGE_SIZE, 0)) {
-		bio_put(bio);
-		return -EIO;
-	}
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
 
 	if (!parent)
 		bio->bi_end_io = zram_page_end_io;
@@ -609,7 +601,6 @@ static int read_from_bdev_async(struct zram *zram, struct page *page,
 		bio_chain(bio, parent);
 
 	submit_bio(bio);
-	return 1;
 }
 
 #define PAGE_WB_SIG "page_index="
@@ -845,7 +836,8 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 	atomic64_inc(&zram->stats.bd_reads);
 	if (sync)
 		return read_from_bdev_sync(zram, page, entry, parent);
-	return read_from_bdev_async(zram, page, entry, parent);
+	read_from_bdev_async(zram, page, entry, parent);
+	return 1;
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-- 
2.39.2

