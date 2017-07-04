Return-Path: <prvs=3513b4a18=damien.lemoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] block: Fix __blkdev_issue_zeroout loop
Date: Tue,  4 Jul 2017 17:27:02 +0900
Message-Id: <20170704082702.15727-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The BIO issuing loop in __blkdev_issue_zeroout() is allocating BIOs
with a maximum number of bvec (pages) equal to

min(nr_sects, (sector_t)BIO_MAX_PAGES)

This works since the BIO will always be limited to the absolute maximum
number of pages but this is ineficient as too many bvec entries may be
requested since different units (number of sectors vs number of pages)
are used in the min() operation. Fix this by correctly using the same
unit (number of pages), making sure that this number is at least 1 for
cases where the number of sectors is less that the number of sectors in
a page.

Also remove a trailing space after the bit shift in the internal loop
min() call.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-lib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e8caecd..a19e6cd 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -307,14 +307,15 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 
 	ret = 0;
 	while (nr_sects != 0) {
-		bio = next_bio(bio, min(nr_sects, (sector_t)BIO_MAX_PAGES),
-				gfp_mask);
+		sz = min((nr_sects << 9) >> PAGE_SHIFT,
+			 (sector_t)BIO_MAX_PAGES);
+		bio = next_bio(bio, max(1U, sz), gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_bdev   = bdev;
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		while (nr_sects != 0) {
-			sz = min((sector_t) PAGE_SIZE >> 9 , nr_sects);
+			sz = min((sector_t) PAGE_SIZE >> 9, nr_sects);
 			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz << 9, 0);
 			nr_sects -= bi_size >> 9;
 			sector += bi_size >> 9;
-- 
2.9.4
