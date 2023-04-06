Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56218C77B70
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbjDFOnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbjDFOmk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:42:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC10CA5F4
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GgKSvWRVz3BmtqqsjylV4+F/lWQhAgOcjW+7+ZBPo2I=; b=qke4VTQ/gRDC6VlWjRAzNY3xa4
        PQDkORLNFm33eZ4euJUXpxBdZ2gf6tu6y4ILmQeImilcscTMQsZNWm4AqRXanSOoTcOawOfIB3Mgm
        cKW8VgYdBzVx4YV/x2//YjPVARTT8krHuq58D3KPGe0iuDS/yhM4qksEMwtokL++M/tcsKNMkHeIp
        Ox6Cx6fgSc8NmJGRS7ZsfZInPt5ImMvWMoBTLYfMzyMDqjE7bP77sfarwH45XdylzhCZuhLg5bZuW
        PgNj7Rx3wkHkbcTw5tDiKUFZg0CSmk7j4s1olpuI/4tnQOTYI7ewnDm6Ll6HkqUlFqJHkfBfSwmy/
        tr+JUogA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQnZ-007fgj-28;
        Thu, 06 Apr 2023 14:41:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 03/16] zram: simplify bvec iteration in __zram_make_request
Date:   Thu,  6 Apr 2023 16:40:49 +0200
Message-Id: <20230406144102.149231-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
References: <20230406144102.149231-1-hch@lst.de>
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

