Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C667C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbjDFOnK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbjDFOmj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC7AF36
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=c33atGis5DRAbnbU0ZyoIQZCHNnGQCJ14FIVt18Suf8=; b=Qkn17SspA2HThWFdFrDFpCooUB
        mo+hRd8mUUdIF1yB+L6Jp0bEkum4Yx+74fCsIqzh2chyr1b1lvBswlJzdhx0pDiSxXEk9Fm/4kksF
        Xi9vLRKa2ZWxqYxj6LUk5eJ2AIhmzK86rHtV7jAcm/kmnwnoQQJIUyRODrJ1bBUhHZWl/1PoLba1N
        Ot9hKOnGsB8gudoQgHxohpwFk1WKDatCCC4hG13y5+vae3L4L8E49P6PWvwjZUuyGnG4c9e/Yh917
        TmfFy412hlx6+dGPzodmj5gxq/CVo0Oe2e3HOwfq+C0VGltSxXI2Sed7bvT6xr/fZKFLxJAw3sqty
        qwUI4t1w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnX-007fgJ-1I;
        Thu, 06 Apr 2023 14:41:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 02/16] zram: make zram_bio_discard more self-contained
Date:   Thu,  6 Apr 2023 16:40:48 +0200
Message-Id: <20230406144102.149231-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
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
---
 drivers/block/zram/zram_drv.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0c6b3ba2970b5f..3d8e2a1db7c7d3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1896,15 +1896,12 @@ static ssize_t recompress_store(struct device *dev,
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
@@ -1932,6 +1929,8 @@ static void zram_bio_discard(struct zram *zram, u32 index,
 		index++;
 		n -= PAGE_SIZE;
 	}
+
+	bio_endio(bio);
 }
 
 /*
@@ -1980,8 +1979,7 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
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

