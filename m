Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756B2C77B60
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjDDPFu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjDDPFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:05:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AF73C16
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NWIsQFS3MEWew6mRXkydp8v8vwMH7aCLRFcNZI0s1Yk=; b=DcDn0gCnqVv4DjCe3cuqU9jTET
        3477usjPCZqo/ruGoqcKsDSVX1FniybRqhXUzcmTHNzsAIl++AExVE8adixDSvfC1fObYhM82lxST
        RdbCXnSf9yxgWchl9WWaPMSZ2v0sUXVNFn//ppqxLser5dvEFtQgIExlFMz/YePGPxVqM3wP4UZXW
        Zh+qHEqN409HkHCZixq0QRbOnNphKGG7xeuwjSW/eE/GcPREwROFU4FFQ4TZRKSI0AUtiPid4d7R2
        Z47iY/XlQhcBLcYfGCJ2m8hvzr3G/xIMnPgonURH9HZpHspc6jdItyDVTWJDwyIjMgsehIsWLMe3c
        yoNDIfFw==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEC-001vpY-1Y;
        Tue, 04 Apr 2023 15:05:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 02/16] zram: make zram_bio_discard more self-contained
Date:   Tue,  4 Apr 2023 17:05:22 +0200
Message-Id: <20230404150536.2142108-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Derive the index and offset variables inside the function, and complete
the bio directly in preparation for cleaning up the I/O path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

