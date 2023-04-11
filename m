Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34386C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDKRPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDKRPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5359DF
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Od06VxnWXU32hE89elXuKU9B9zMKaeX580dzPcJg1nY=; b=P4wHQASlTghE74y8AVE7vI/R4S
        h65HWK1knMNDSxEhsFd73HCr1x5KymVx/GjkAoWj0byNDodTmqfCX9iskKvMPL9A4nTVeZS9ei61Z
        r15MmMgNNN3CX8wVA5RES4SJHDFLvEEpclbRUfkoa088HZrb1uWIIRUfJsPYg9hrUBrhGAtLqe4xU
        7FaIYdF9dAhA9iqTvsboR6KOJ1MPZoHsXJAsrJaued0WLHWYlaTFNsChQJpSBQFdIG+m6IX135CKH
        MnFDrRIVKCrLFCT3sNRBL3wK5FOGthXJl8KMOJB2cvSMWj6uxTBrgfB7xhlwce9FpdA/n032JDXHU
        NmOt4Ucw==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaG-000gkw-2k;
        Tue, 11 Apr 2023 17:15:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 03/17] zram: make zram_bio_discard more self-contained
Date:   Tue, 11 Apr 2023 19:14:45 +0200
Message-Id: <20230411171459.567614-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Derive the index and offset variables inside the function, and complete
the bio directly in preparation for cleaning up the I/O path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f4466ad1fd4aef..e9b31c19902779 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1890,15 +1890,12 @@ static ssize_t recompress_store(struct device *dev,
 }
 #endif
 
-/*
- * zram_bio_discard - handler on discard request
- * @index: physical block index in PAGE_SIZE units
- * @offset: byte offset within physical block
- */
-static void zram_bio_discard(struct zram *zram, u32 index,
-			     int offset, struct bio *bio)
+static void zram_bio_discard(struct zram *zram, struct bio *bio)
 {
 	size_t n = bio->bi_iter.bi_size;
+	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+	u32 offset = (bio->bi_iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+			SECTOR_SHIFT;
 
 	/*
 	 * zram manages data in physical block size units. Because logical block
@@ -1926,6 +1923,8 @@ static void zram_bio_discard(struct zram *zram, u32 index,
 		index++;
 		n -= PAGE_SIZE;
 	}
+
+	bio_endio(bio);
 }
 
 /*
@@ -1974,8 +1973,7 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
-		zram_bio_discard(zram, index, offset, bio);
-		bio_endio(bio);
+		zram_bio_discard(zram, bio);
 		return;
 	default:
 		break;
-- 
2.39.2

