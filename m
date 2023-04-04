Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7472CC77B62
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjDDPFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjDDPFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:05:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EA423C
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=z8Zjawa70TEOPAdQ9L2OwwMSo7knUe44QmNgz+ZOdwE=; b=V3Zytmk+LBzTL/99YAIcrlhBwK
        9++utgGrbvUFa5DAsXyuD6WBJ4sx3hp4wtKD1jrcPBMAX43Y/v+j+cmu30uxHO6rA7iznI77fi/zy
        bDu3U09eTWbRt9W+cjb86nO5AK2u0E6+v8gMqfMh1pT5Ge/m+SCMVLkeSDhywQB6H8kGTW3cgYlhf
        XX1UPEbLFlcv6qW9OeVym1+AudxBZYrhXR1aucQ/F7Zqg49243Ucc1/mdpXZ4RxxQSPaJY7kqQoxH
        e31k1PKrJi3JpzVxnUPH5xueTzxmzvsWPRBAzUQ6sVmqsWN0nvrXW5ehpQIC0CWCCM0BHXaN15zwG
        RYA2U4Vg==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEI-001vqD-00;
        Tue, 04 Apr 2023 15:05:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 04/16] zram: move discard handling to zram_submit_bio
Date:   Tue,  4 Apr 2023 17:05:24 +0200
Message-Id: <20230404150536.2142108-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch on the bio operation in zram_submit_bio and only call into
__zram_make_request for read and write operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5f1e4fd23ade32..6522b888839cb1 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1964,15 +1964,6 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
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
@@ -1996,7 +1987,19 @@ static void zram_submit_bio(struct bio *bio)
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
+		return;
+	default:
+		WARN_ON_ONCE(1);
+		bio_endio(bio);
+	}
 }
 
 static void zram_slot_free_notify(struct block_device *bdev,
-- 
2.39.2

