Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C6C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDKRPV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDKRPS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F025591
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FHhp2jAnJ5iL5Zk6LnxZBm5T4ITZfThiEdPynD/rrpQ=; b=xTkkZA4YlfxBbjfDIrLiuVfD7o
        JCNggC1mp8IA6ztFBVvOv42cuRxWZPbEL5JeCjzWt18Dm8ImGQR0lADVkgbigx1+gXFiJz3IvV3qb
        Efzo6VNRUz7Xlxp4JjTs3zVq90qhJHyHZQL3FnAPs4y4di6qsxBgGX/eNfi2MV9h7R2tCaR1vQ7AK
        zyFC0u4brHDYOTqTNJGqdnIGxSaz5HjZCd3qm96ojaDjBsa+l4U34i44sg4HgtB3FMcJMbaSCtxdR
        vw2qx1ba3mOtunRY4lilhJxft4FhpEiZrUcZdJKCBMCFXiPRsuPIfvqfrG9q+QYV/VdrRyby3K1JG
        EW+KqGcA==;
Received: from [2001:4bb8:192:2d6c:e384:cbad:b189:57c6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmHaJ-000glD-1I;
        Tue, 11 Apr 2023 17:15:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 04/17] zram: simplify bvec iteration in __zram_make_request
Date:   Tue, 11 Apr 2023 19:14:46 +0200
Message-Id: <20230411171459.567614-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411171459.567614-1-hch@lst.de>
References: <20230411171459.567614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_for_each_segment synthetize bvecs that never cross page boundaries,
so don't duplicate that work in an inner loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 42 +++++++++--------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e9b31c19902779..e13c7d8e283b74 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -175,12 +175,6 @@ static inline u32 zram_get_priority(struct zram *zram, u32 index)
 	return prio & ZRAM_COMP_PRIORITY_MASK;
 }
 
-static void update_position(u32 *index, int *offset, struct bio_vec *bvec)
-{
-	*index  += (*offset + bvec->bv_len) / PAGE_SIZE;
-	*offset = (*offset + bvec->bv_len) % PAGE_SIZE;
-}
-
 static inline void update_used_max(struct zram *zram,
 					const unsigned long pages)
 {
@@ -1960,16 +1954,10 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 
 static void __zram_make_request(struct zram *zram, struct bio *bio)
 {
-	int offset;
-	u32 index;
-	struct bio_vec bvec;
 	struct bvec_iter iter;
+	struct bio_vec bv;
 	unsigned long start_time;
 
-	index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-	offset = (bio->bi_iter.bi_sector &
-		  (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
-
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
@@ -1980,24 +1968,16 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
 	}
 
 	start_time = bio_start_io_acct(bio);
-	bio_for_each_segment(bvec, bio, iter) {
-		struct bio_vec bv = bvec;
-		unsigned int unwritten = bvec.bv_len;
-
-		do {
-			bv.bv_len = min_t(unsigned int, PAGE_SIZE - offset,
-							unwritten);
-			if (zram_bvec_rw(zram, &bv, index, offset,
-					 bio_op(bio), bio) < 0) {
-				bio->bi_status = BLK_STS_IOERR;
-				break;
-			}
-
-			bv.bv_offset += bv.bv_len;
-			unwritten -= bv.bv_len;
-
-			update_position(&index, &offset, &bv);
-		} while (unwritten);
+	bio_for_each_segment(bv, bio, iter) {
+		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
+				SECTOR_SHIFT;
+
+		if (zram_bvec_rw(zram, &bv, index, offset, bio_op(bio),
+				bio) < 0) {
+			bio->bi_status = BLK_STS_IOERR;
+			break;
+		}
 	}
 	bio_end_io_acct(bio, start_time);
 	bio_endio(bio);
-- 
2.39.2

