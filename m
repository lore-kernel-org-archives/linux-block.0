Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:49612 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbdJPN7Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2017 09:59:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id b189so3568868wmd.4
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2017 06:59:23 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v3 1/2] block: factor out __blkdev_issue_zero_pages()
Date: Mon, 16 Oct 2017 15:59:09 +0200
Message-Id: <1508162350-21978-2-git-send-email-idryomov@gmail.com>
In-Reply-To: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
References: <1508162350-21978-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blkdev_issue_zeroout() will use this in !BLKDEV_ZERO_NOFALLBACK case.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 block/blk-lib.c | 63 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 62240f8832ca..9d2ab8bba52a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -274,6 +274,40 @@ static unsigned int __blkdev_sectors_to_bio_pages(sector_t nr_sects)
 	return min(pages, (sector_t)BIO_MAX_PAGES);
 }
 
+static int __blkdev_issue_zero_pages(struct block_device *bdev,
+		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio = *biop;
+	int bi_size = 0;
+	unsigned int sz;
+
+	if (!q)
+		return -ENXIO;
+
+	while (nr_sects != 0) {
+		bio = next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
+			       gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+		bio_set_dev(bio, bdev);
+		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+
+		while (nr_sects != 0) {
+			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
+			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz, 0);
+			nr_sects -= bi_size >> 9;
+			sector += bi_size >> 9;
+			if (bi_size < sz)
+				break;
+		}
+		cond_resched();
+	}
+
+	*biop = bio;
+	return 0;
+}
+
 /**
  * __blkdev_issue_zeroout - generate number of zero filed write bios
  * @bdev:	blockdev to issue
@@ -304,9 +338,6 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		unsigned flags)
 {
 	int ret;
-	int bi_size = 0;
-	struct bio *bio = *biop;
-	unsigned int sz;
 	sector_t bs_mask;
 
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
@@ -316,30 +347,10 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
 			biop, flags);
 	if (ret != -EOPNOTSUPP || (flags & BLKDEV_ZERO_NOFALLBACK))
-		goto out;
-
-	ret = 0;
-	while (nr_sects != 0) {
-		bio = next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
-			       gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-
-		while (nr_sects != 0) {
-			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
-			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz, 0);
-			nr_sects -= bi_size >> 9;
-			sector += bi_size >> 9;
-			if (bi_size < sz)
-				break;
-		}
-		cond_resched();
-	}
+		return ret;
 
-	*biop = bio;
-out:
-	return ret;
+	return __blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp_mask,
+					 biop);
 }
 EXPORT_SYMBOL(__blkdev_issue_zeroout);
 
-- 
2.4.3
