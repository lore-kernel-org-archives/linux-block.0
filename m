Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16841 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbcK3U33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2016 15:29:29 -0500
From: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
To: axboe@fb.com
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH V2 1/5] block: add async variant of blkdev_issue_zeroout
Date: Wed, 30 Nov 2016 12:28:58 -0800
Message-Id: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Similar to __blkdev_issue_discard this variant allows submitting
the final bio asynchronously and chaining multiple ranges
into a single completion.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
---
 block/blk-lib.c        | 115 ++++++++++++++++++++++++++++++++++---------------
 include/linux/blkdev.h |   3 ++
 2 files changed, 84 insertions(+), 34 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 18abda8..bfb28b0 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -137,24 +137,24 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 EXPORT_SYMBOL(blkdev_issue_discard);
 
 /**
- * blkdev_issue_write_same - queue a write same operation
+ * __blkdev_issue_write_same - generate number of bios with same page
  * @bdev:	target blockdev
  * @sector:	start sector
  * @nr_sects:	number of sectors to write
  * @gfp_mask:	memory allocation flags (for bio_alloc)
  * @page:	page containing data to write
+ * @biop:	pointer to anchor bio
  *
  * Description:
- *    Issue a write same request for the sectors in question.
+ *  Generate and issue number of bios(REQ_OP_WRITE_SAME) with same page.
  */
-int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
-			    sector_t nr_sects, gfp_t gfp_mask,
-			    struct page *page)
+static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct page *page,
+		struct bio **biop)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	unsigned int max_write_same_sectors;
-	struct bio *bio = NULL;
-	int ret = 0;
+	struct bio *bio = *biop;
 	sector_t bs_mask;
 
 	if (!q)
@@ -164,6 +164,9 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
 
+	if (!bdev_write_same(bdev))
+		return -EOPNOTSUPP;
+
 	/* Ensure that max_write_same_sectors doesn't overflow bi_size */
 	max_write_same_sectors = UINT_MAX >> 9;
 
@@ -185,32 +188,63 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 			bio->bi_iter.bi_size = nr_sects << 9;
 			nr_sects = 0;
 		}
+		cond_resched();
 	}
 
-	if (bio) {
+	*biop = bio;
+	return 0;
+}
+
+/**
+ * blkdev_issue_write_same - queue a write same operation
+ * @bdev:	target blockdev
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to write
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @page:	page containing data
+ *
+ * Description:
+ *    Issue a write same request for the sectors in question.
+ */
+int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
+				sector_t nr_sects, gfp_t gfp_mask,
+				struct page *page)
+{
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+	int ret;
+
+	blk_start_plug(&plug);
+	ret = __blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask, page,
+			&bio);
+	if (ret == 0 && bio) {
 		ret = submit_bio_wait(bio);
 		bio_put(bio);
 	}
+	blk_finish_plug(&plug);
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
 /**
- * blkdev_issue_zeroout - generate number of zero filed write bios
+ * __blkdev_issue_zeroout - generate number of zero filed write bios
  * @bdev:	blockdev to issue
  * @sector:	start sector
  * @nr_sects:	number of sectors to write
  * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @biop:	pointer to anchor bio
+ * @discard:	discard flag
  *
  * Description:
  *  Generate and issue number of bios with zerofiled pages.
  */
-
-static int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
-				  sector_t nr_sects, gfp_t gfp_mask)
+int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
+		bool discard)
 {
 	int ret;
-	struct bio *bio = NULL;
+	int bi_size = 0;
+	struct bio *bio = *biop;
 	unsigned int sz;
 	sector_t bs_mask;
 
@@ -218,6 +252,19 @@ static int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
 
+	if (discard) {
+		ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
+				BLKDEV_DISCARD_ZERO, biop);
+		if (ret == 0 || (ret && ret != -EOPNOTSUPP))
+			goto out;
+	}
+
+	ret = __blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
+			ZERO_PAGE(0), biop);
+	if (ret == 0 || (ret && ret != -EOPNOTSUPP))
+		goto out;
+
+	ret = 0;
 	while (nr_sects != 0) {
 		bio = next_bio(bio, min(nr_sects, (sector_t)BIO_MAX_PAGES),
 				gfp_mask);
@@ -227,21 +274,20 @@ static int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 
 		while (nr_sects != 0) {
 			sz = min((sector_t) PAGE_SIZE >> 9 , nr_sects);
-			ret = bio_add_page(bio, ZERO_PAGE(0), sz << 9, 0);
-			nr_sects -= ret >> 9;
-			sector += ret >> 9;
-			if (ret < (sz << 9))
+			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz << 9, 0);
+			nr_sects -= bi_size >> 9;
+			sector += bi_size >> 9;
+			if (bi_size < (sz << 9))
 				break;
 		}
+		cond_resched();
 	}
 
-	if (bio) {
-		ret = submit_bio_wait(bio);
-		bio_put(bio);
-		return ret;
-	}
-	return 0;
+	*biop = bio;
+out:
+	return ret;
 }
+EXPORT_SYMBOL(__blkdev_issue_zeroout);
 
 /**
  * blkdev_issue_zeroout - zero-fill a block range
@@ -263,21 +309,22 @@ static int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
  *  clearing the block range. Otherwise the zeroing will be performed
  *  using regular WRITE calls.
  */
-
 int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			 sector_t nr_sects, gfp_t gfp_mask, bool discard)
 {
-	if (discard) {
-		if (!blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
-				BLKDEV_DISCARD_ZERO))
-			return 0;
-	}
+	int ret;
+	struct bio *bio = NULL;
+	struct blk_plug plug;
 
-	if (bdev_write_same(bdev) &&
-	    blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
-				    ZERO_PAGE(0)) == 0)
-		return 0;
+	blk_start_plug(&plug);
+	ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
+			&bio, discard);
+	if (ret == 0 && bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+	blk_finish_plug(&plug);
 
-	return __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask);
+	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 541fdd8..7e9d8a0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1269,6 +1269,9 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		struct bio **biop);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
+extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
+		bool discard);
 extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, bool discard);
 static inline int sb_issue_discard(struct super_block *sb, sector_t block,
-- 
1.8.3.1

