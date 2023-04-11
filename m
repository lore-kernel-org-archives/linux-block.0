Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A620C77B74
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDKRPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDKRPS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF9B5FE1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AfM9M5ejUBn8kYyNU3LON+fMnBkhC79Evbmi6FGTECM=; b=sN7xWJhPuRJwNcT98CRuimpmeG
        NvFVfGgCOt2SBoCevjx86J6uvvAZMUK8cvafpbV/rdhmRtwA2QQeVVSg/04eayE2dLDFOuHvJ2IcO
        aZMB6naSlwg1/GE2yo7AKW6XjaJyA2rjrax49oU0YBTaLDjtOfaDMmvgy8VmGA5MaBzx/XOvIwhCy
        0UX7gIU/zJP+wNTApgdhKddQF+NVmZmVfyVBIfuEy/u/ia/47DywVAJTi9VZoXGZWaVhDu60q5Q50
        N5KT4S7l7Ss4TeAuRbmWrW8zo9IJ2PIDWTsN11ohJdQu4lsU09xgbiSa07N8Qlr9HzkK3OUL+UyJo
        8273rfZg==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaL-000glu-38;
        Tue, 11 Apr 2023 17:15:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 05/17] zram: move discard handling to zram_submit_bio
Date:   Tue, 11 Apr 2023 19:14:47 +0200
Message-Id: <20230411171459.567614-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch on the bio operation in zram_submit_bio and only call into
__zram_make_request for read and write operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e13c7d8e283b74..00f13eb1c800c3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1958,15 +1958,6 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 	struct bio_vec bv;
 	unsigned long start_time;
 
-	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-	case REQ_OP_WRITE_ZEROES:
-		zram_bio_discard(zram, bio);
-		return;
-	default:
-		break;
-	}
-
 	start_time = bio_start_io_acct(bio);
 	bio_for_each_segment(bv, bio, iter) {
 		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
@@ -1990,7 +1981,19 @@ static void zram_submit_bio(struct bio *bio)
 {
 	struct zram *zram = bio->bi_bdev->bd_disk->private_data;
 
-	__zram_make_request(zram, bio);
+	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+		__zram_make_request(zram, bio);
+		break;
+	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
+		zram_bio_discard(zram, bio);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		bio_endio(bio);
+	}
 }
 
 static void zram_slot_free_notify(struct block_device *bdev,
-- 
2.39.2

