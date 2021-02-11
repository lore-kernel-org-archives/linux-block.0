Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB5EC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 08:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB8164E14
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 08:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBKIaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 03:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBKI35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 03:29:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8EBC061574
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ByAbIbvD4i0tCyXR7EHxH1oHvzEt1qrBfuBBjEQzZKI=; b=l6+iOf89F5XqVT/22uVm4Hkah1
        vXu4Nc5W+TZmxlpBC4mWOJg3p0pOPykoEWb7B8EvaW8ITbDN81lcYufebf6T6gnOOPBoZ5sc6hD0h
        Ww1Mc9ZF2RebYIxGSS7qZYE3M2pw/Qli9egMOHp681w2EIVrZAvcueTnwjYKt9NSnmhUyS89PFNtO
        1lpCbvhAoaghpgPkUA4ADMNAQkyeKFZGaODDUTa98dMtoBmW2R7tGZI5WsIdfelgBiLRzMXEVIOP1
        7VptYS3SazT6jc0NXRWx6nK6hQce0ThZ4uc7bYAu53CIU0mcIfdaalCNNffrMhY6CHEqmIt3ccC9O
        UOyvKXUQ==;
Received: from 213-225-11-22.nat.highway.a1.net ([213.225.11.22] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lA7LY-009yW6-1Y; Thu, 11 Feb 2021 08:29:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: pass bdev and op to blk_next_bio
Date:   Thu, 11 Feb 2021 09:26:56 +0100
Message-Id: <20210211082656.107505-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make blk_next_bio a little more useful by setting up two more common bio
parameters.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c   | 23 ++++++++++-------------
 block/blk-zoned.c |  4 +---
 block/blk.h       |  3 ++-
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 752f9c7220622a..a7e75167003d8d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -10,10 +10,14 @@
 
 #include "blk.h"
 
-struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
+struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
+		unsigned int op, unsigned int nr_pages, gfp_t gfp)
 {
 	struct bio *new = bio_alloc(gfp, nr_pages);
 
+	bio_set_dev(new, bdev);
+	new->bi_opf = op;
+
 	if (bio) {
 		bio_chain(bio, new);
 		submit_bio(bio);
@@ -94,10 +98,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
 
-		bio = blk_next_bio(bio, 0, gfp_mask);
+		bio = blk_next_bio(bio, bdev, op, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio_set_op_attrs(bio, op, 0);
 
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
@@ -188,14 +190,12 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	max_write_same_sectors = bio_allowed_max_sectors(q);
 
 	while (nr_sects) {
-		bio = blk_next_bio(bio, 1, gfp_mask);
+		bio = blk_next_bio(bio, bdev, REQ_OP_WRITE_SAME, 1, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
 		bio->bi_vcnt = 1;
 		bio->bi_io_vec->bv_page = page;
 		bio->bi_io_vec->bv_offset = 0;
 		bio->bi_io_vec->bv_len = bdev_logical_block_size(bdev);
-		bio_set_op_attrs(bio, REQ_OP_WRITE_SAME, 0);
 
 		if (nr_sects > max_write_same_sectors) {
 			bio->bi_iter.bi_size = max_write_same_sectors << 9;
@@ -264,10 +264,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		return -EOPNOTSUPP;
 
 	while (nr_sects) {
-		bio = blk_next_bio(bio, 0, gfp_mask);
+		bio = blk_next_bio(bio, bdev, REQ_OP_WRITE_ZEROES, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio->bi_opf = REQ_OP_WRITE_ZEROES;
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
 
@@ -315,11 +313,10 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		return -EPERM;
 
 	while (nr_sects != 0) {
-		bio = blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
+		bio = blk_next_bio(bio, bdev, REQ_OP_WRITE,
+				   __blkdev_sectors_to_bio_pages(nr_sects),
 				   gfp_mask);
 		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		while (nr_sects != 0) {
 			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 833978c02e6083..ffc43ecd0f3030 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -231,8 +231,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		return -EINVAL;
 
 	while (sector < end_sector) {
-		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio_set_dev(bio, bdev);
+		bio = blk_next_bio(bio, bdev, op | REQ_SYNC, 0, gfp_mask);
 
 		/*
 		 * Special case for the zone reset operation that reset all
@@ -244,7 +243,6 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			break;
 		}
 
-		bio->bi_opf = op | REQ_SYNC;
 		bio->bi_iter.bi_sector = sector;
 		sector += zone_sectors;
 
diff --git a/block/blk.h b/block/blk.h
index 3b53e44b967e4e..0f0d8a784fee70 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -330,7 +330,8 @@ extern int blk_iolatency_init(struct request_queue *q);
 static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
 #endif
 
-struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
+struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
+		unsigned int op, unsigned int nr_pages, gfp_t gfp);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void blk_queue_free_zone_bitmaps(struct request_queue *q);
-- 
2.29.2

