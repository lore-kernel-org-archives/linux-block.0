Return-Path: <BATV+6be4d56e4a565bfcc45d+4891+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: eguan@redhat.com,
	Chaitanya.Kulkarni@wdc.com,
	linux-block@vger.kernel.org
Subject: [PATCH] block: don't try to discard from __blkdev_issue_zeroout
Date: Fri, 13 Jan 2017 15:16:17 +0100
Message-Id: <1484316977-2474-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Discard can return -EIO asynchronously if the alignment for the request
isn't suitable for the driver, which makes a proper fallback to other
methods in __blkdev_issue_zeroout impossible.  Thus only issue a sync
discard from blkdev_issue_zeroout an don't try discard at all from
__blkdev_issue_zeroout as a non-invasive workaround.

One more reason why abusing discard for zeroing must die..

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Eryu Guan <eguan@redhat.com>
Fixes: e73c23ff ("block: add async variant of blkdev_issue_zeroout")
---
 block/blk-lib.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index ed89c8f..f8c82a9 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -301,13 +301,6 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
 
-	if (discard) {
-		ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
-				BLKDEV_DISCARD_ZERO, biop);
-		if (ret == 0 || (ret && ret != -EOPNOTSUPP))
-			goto out;
-	}
-
 	ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
 			biop);
 	if (ret == 0 || (ret && ret != -EOPNOTSUPP))
@@ -370,6 +363,12 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	struct bio *bio = NULL;
 	struct blk_plug plug;
 
+	if (discard) {
+		if (!blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
+				BLKDEV_DISCARD_ZERO))
+			return 0;
+	}
+
 	blk_start_plug(&plug);
 	ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
 			&bio, discard);
-- 
2.1.4
