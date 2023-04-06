Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F26C77B6F
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbjDFOnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbjDFOmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790DFAF02
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EXrJqSMIduZ8P6MHIUGF5un1hfxaLITHEyB45niyPPc=; b=DkJWZ56rrZnZ2P6qhibuWdmy5k
        TAqiXfSjNxKjD8X3tgmhwtl51q7HGG+aSOUjCZh8CplX24xlpgfaGyyMES3h45pC+FMjapJQMlMYz
        j3XCV6g4wyCkmI3jnFYVid+3/ich2BvJdtb4ZjCEXhcvUyD/A+3SEs6d4kFyhFReM43gZXTU2fe/2
        HPIseOk/WreQceCzndFqT0hGAMnz3hZqKoPU+rWeVTEdDcsHHs2lairSJso9Xosf2F1MNeoWc8kQ0
        8FvO5StFsMcq4tX4u58WQ0PN7ZH/iMpQ6sl4Kxijvp5gJy+oTz8CYj/YAVP46wjd3JOfmiU1LSb+f
        xWBW+N3g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQng-007fiO-1R;
        Thu, 06 Apr 2023 14:41:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 06/16] zram: refactor highlevel read and write handling
Date:   Thu,  6 Apr 2023 16:40:52 +0200
Message-Id: <20230406144102.149231-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of having an outer loop in __zram_make_request and then branch
out for reads vs writes for each loop iteration in zram_bvec_rw, split
the main handler into separat zram_bio_read and zram_bio_write handlers
that also include the functionality formerly in zram_bvec_rw.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 58 ++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0b8e49aa3be24b..5e823dcd1975c0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1927,38 +1927,34 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 	bio_endio(bio);
 }
 
-/*
- * Returns errno if it has some problem. Otherwise return 0 or 1.
- * Returns 0 if IO request was done synchronously
- * Returns 1 if IO request was successfully submitted.
- */
-static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
-			int offset, enum req_op op, struct bio *bio)
+static void zram_bio_read(struct zram *zram, struct bio *bio)
 {
-	int ret;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	unsigned long start_time;
 
-	if (!op_is_write(op)) {
-		ret = zram_bvec_read(zram, bvec, index, offset, bio);
-		if (unlikely(ret < 0)) {
+	start_time = bio_start_io_acct(bio);
+	bio_for_each_segment(bv, bio, iter) {
+		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+				SECTOR_SHIFT;
+
+		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
 			atomic64_inc(&zram->stats.failed_reads);
-			return ret;
-		}
-		flush_dcache_page(bvec->bv_page);
-	} else {
-		ret = zram_bvec_write(zram, bvec, index, offset, bio);
-		if (unlikely(ret < 0)) {
-			atomic64_inc(&zram->stats.failed_writes);
-			return ret;
+			bio->bi_status = BLK_STS_IOERR;
+			break;
 		}
-	}
+		flush_dcache_page(bv.bv_page);
 
-	zram_slot_lock(zram, index);
-	zram_accessed(zram, index);
-	zram_slot_unlock(zram, index);
-	return 0;
+		zram_slot_lock(zram, index);
+		zram_accessed(zram, index);
+		zram_slot_unlock(zram, index);
+	}
+	bio_end_io_acct(bio, start_time);
+	bio_endio(bio);
 }
 
-static void __zram_make_request(struct zram *zram, struct bio *bio)
+static void zram_bio_write(struct zram *zram, struct bio *bio)
 {
 	struct bvec_iter iter;
 	struct bio_vec bv;
@@ -1970,11 +1966,15 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 				SECTOR_SHIFT;
 
-		if (zram_bvec_rw(zram, &bv, index, offset, bio_op(bio),
-				bio) < 0) {
+		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
+			atomic64_inc(&zram->stats.failed_writes);
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
+
+		zram_slot_lock(zram, index);
+		zram_accessed(zram, index);
+		zram_slot_unlock(zram, index);
 	}
 	bio_end_io_acct(bio, start_time);
 	bio_endio(bio);
@@ -1989,8 +1989,10 @@ static void zram_submit_bio(struct bio *bio)
 
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
+		zram_bio_read(zram, bio);
+		break;
 	case REQ_OP_WRITE:
-		__zram_make_request(zram, bio);
+		zram_bio_write(zram, bio);
 		break;
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
-- 
2.39.2

