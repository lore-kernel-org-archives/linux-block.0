Return-Path: <prvs=353861e16=damien.lemoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3] block: Fix __blkdev_issue_zeroout loop
Date: Thu,  6 Jul 2017 20:21:15 +0900
Message-Id: <20170706112115.616-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The BIO issuing loop in __blkdev_issue_zeroout() is allocating BIOs
with a maximum number of bvec (pages) equal to

min(nr_sects, (sector_t)BIO_MAX_PAGES)

This works since the requested number of bvecs will always be limited
to the absolute maximum number supported (BIO_MAX_PAGES), but this is
ineficient as too many bvec entries may be requested due to the
different units being used in the min() operation (number of sectors vs
number of pages).
To fix this, introduce the helper __blkdev_sectors_to_bio_pages() to
correctly calculate the number of bvecs for zeroout BIOs as the issuing
loop progresses. The calculation is done using consistent units and
makes sure that the number of pages return is at least 1 (for cases
where the number of sectors is less that the number of sectors in
a page).

Also remove a trailing space after the bit shift in the internal loop
min() call.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-lib.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e8caecd..3fe0aec 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -261,6 +261,19 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 	return 0;
 }
 
+/*
+ * Convert a number of 512B sectors to a number of pages.
+ * The result is limited to a number of pages that can fit into a BIO.
+ * Also make sure that the result is always at least 1 (page) for the cases
+ * where nr_sects is lower than the number of sectors in a page.
+ */
+static unsigned int __blkdev_sectors_to_bio_pages(sector_t nr_sects)
+{
+	sector_t bytes = (nr_sects << 9) + PAGE_SIZE - 1;
+
+	return min(bytes >> PAGE_SHIFT, (sector_t)BIO_MAX_PAGES);
+}
+
 /**
  * __blkdev_issue_zeroout - generate number of zero filed write bios
  * @bdev:	blockdev to issue
@@ -307,18 +320,18 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 
 	ret = 0;
 	while (nr_sects != 0) {
-		bio = next_bio(bio, min(nr_sects, (sector_t)BIO_MAX_PAGES),
-				gfp_mask);
+		bio = next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
+			       gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_bdev   = bdev;
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		while (nr_sects != 0) {
-			sz = min((sector_t) PAGE_SIZE >> 9 , nr_sects);
-			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz << 9, 0);
+			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
+			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz, 0);
 			nr_sects -= bi_size >> 9;
 			sector += bi_size >> 9;
-			if (bi_size < (sz << 9))
+			if (bi_size < sz)
 				break;
 		}
 		cond_resched();
-- 
2.9.4
