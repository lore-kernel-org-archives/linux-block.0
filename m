Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83DDC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjDKRP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDKRPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB98C5B9E
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+GD/frRPfQqIne2/8QVi1PQdsikaQPUGYX9RBZoMFoE=; b=DS8SIl6qkgImMnXZAZ4aK5U3me
        gZZhlYE/63NkzWF/wYTvcMPukzLDnzrQ+stprJwBhQsSW5e/NAVm4eSeCU6CDH6LhBm75P46yR2i2
        sv0LoVn6LA9n/T6RKyLNmMkgULVRhAuukxHVKevNJ8lNC1fSxs3jAb69BiRDEeme6jNvbqLh0O8mP
        VJSgneIedn/qLe8nGoAW0xl64L1Nc42JeZHAqNTHhagRBA1duzEaq4JNP25HlNDRhHggnnWaW9ouD
        QXMWLH9rQZU7EYZLp5oXWtaDfIddSTs1r9FEQ4eDnJQYPwhqY7bG+GrcvOrnkibUxim8jhw++M6K7
        HfxW5UJg==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaR-000gms-0k;
        Tue, 11 Apr 2023 17:15:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 07/17] zram: refactor highlevel read and write handling
Date:   Tue, 11 Apr 2023 19:14:49 +0200
Message-Id: <20230411171459.567614-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
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
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 58 ++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 46dc7a2748672e..2d0154489f0327 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1921,38 +1921,34 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
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
@@ -1964,11 +1960,15 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
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
@@ -1983,8 +1983,10 @@ static void zram_submit_bio(struct bio *bio)
 
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

