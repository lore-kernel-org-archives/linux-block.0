Return-Path: <prvs=350c9a9f7=damien.lemoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: Fix __blkdev_issue_zeroout loop
Date: Mon,  3 Jul 2017 15:56:34 +0900
Message-Id: <20170703065634.8311-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The BIO isuuing loop in __blkdev_issue_zeroout() was allocating BIOs
with a maximum number of pages equal to

min(nr_sects, (sector_t)BIO_MAX_PAGES)

This works since the BIO will always be limited to the absolute maximum
number of pages, but can be ineficient as too many pages may be
requested since variables with different units (number of sectors vs
number of pages) are used in the min() operation. Fix this by correctly
using the same unit (number of pages).

Also remove a trailing space after the bit shift in the internal loop
min() call.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-lib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e8caecd..7856447 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -307,14 +307,15 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 
 	ret = 0;
 	while (nr_sects != 0) {
-		bio = next_bio(bio, min(nr_sects, (sector_t)BIO_MAX_PAGES),
+		bio = next_bio(bio, min((nr_sects << 9) >> PAGE_SHIFT,
+					(sector_t)BIO_MAX_PAGES),
 				gfp_mask);
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
