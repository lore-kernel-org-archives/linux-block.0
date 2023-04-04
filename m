Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137E2C77B6C
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 15:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjDDPFu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjDDPFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 11:05:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDB2708
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FCUSGBrF3T1s5BT4FNvAPKSPL8qNWkcoJB5AdjhHh+U=; b=KTrNDp4ypUjAO8p6q2L+ZPniRH
        WCFhp43mNru1/8qP2FReee1KivTbmXYpgVbU0BmiVt1A7aeIRYD9zxdwhdxlPUDadlbrw9vTh0fks
        RgGs3eJheml1wLMh4odkg0/Ky5oZ2JHNRoeBdz5MaNF8G5zPHC+FdFkEfNc1qwKkdvJqGPcqcPzyU
        T1/591+d/YsAb1VP6/NlNoq5eVGh/nhJWgy2Ybiq7ngtGbeOvPlu1982tVLlCbuvi/3pHf9DybMvY
        M0PjWOHyQGw/S1hkLG8PNYXaWD6qMsTOBQXzJ+chI8HNxIZUDdXlnYq7DodWFNA833QbgaEqecneO
        g5DVAnSQ==;
Received: from [2001:4bb8:191:a744:23e5:e88f:5622:7c79] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjiEF-001vpu-09;
        Tue, 04 Apr 2023 15:05:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 03/16] zram: implify bvec iteration in __zram_make_request
Date:   Tue,  4 Apr 2023 17:05:23 +0200
Message-Id: <20230404150536.2142108-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404150536.2142108-1-hch@lst.de>
References: <20230404150536.2142108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_for_each_segment synthetize bvecs that never cross page boundaries,
so don't duplicate that work in an inner loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 42 +++++++++--------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3d8e2a1db7c7d3..5f1e4fd23ade32 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -174,12 +174,6 @@ static inline u32 zram_get_priority(struct zram *zram, u32 index)
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
@@ -1966,16 +1960,10 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 
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
@@ -1986,24 +1974,16 @@ static void __zram_make_request(struct zram *zram, struct bio *bio)
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

