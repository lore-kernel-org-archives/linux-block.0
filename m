Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC862C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbjDFOnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbjDFOmm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C0BAD3C
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=94/w2H+QjavGycKDBy/5i58r7LnIDcreaFFoO3HYEnk=; b=nIq8wQz2y6UpEn8jKFYOHq6aBy
        C2Runwu1zinWgYfWxcozyh2uAWwZI8OiMoiGZrRoXhUHRk4wFyTSxJml1DwALLAhFwiQNVJIM9ygr
        rQowS6qIEeoNMXVaQT3qeFwFU9p7NNsVlIgvvgqhFhjmwiBaRTZLTqjgoTnUiWm7wed6qnpbXLjB2
        8HO1lUfv9kYeGgAB4tsuIJzSADhhM08fEWvgszWBD0xrKRW1kb728uUZSpm7+mJhOmznBJP/T1GBy
        lvPHAemlTC99DcKjX68v7iV6jk2w1HjNpdwzjR/a0+uFWDSYXf5rjoW0cG/5oClzk2MDM9dm1/9eH
        5e/wbj0g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnb-007fh5-2x;
        Thu, 06 Apr 2023 14:41:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 04/16] zram: move discard handling to zram_submit_bio
Date:   Thu,  6 Apr 2023 16:40:50 +0200
Message-Id: <20230406144102.149231-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
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
---
 drivers/block/zram/zram_drv.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5f1e4fd23ade32..7adc6b02b531d6 100644
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
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		bio_endio(bio);
+	}
 }
 
 static void zram_slot_free_notify(struct block_device *bdev,
-- 
2.39.2

