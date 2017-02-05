Return-Path: <BATV+7c9ed557eb952ccf5513+4914+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: j-nomura@ce.jp.nec.com,
	chaitanya.kulkarni@hgst.com,
	linux-block@vger.kernel.org
Subject: [PATCH] block: don't try Write Same from __blkdev_issue_zeroout
Date: Sun,  5 Feb 2017 18:10:35 +0100
Message-Id: <20170205171035.5993-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Write Same can return an error asynchronously if it turns out the
underlying SCSI device does not support Write Same, which makes a
proper fallback to other methods in __blkdev_issue_zeroout impossible.
Thus only issue a Write Same from blkdev_issue_zeroout an don't try it
at all from __blkdev_issue_zeroout as a non-invasive workaround.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
Fixes: e73c23ff ("block: add async variant of blkdev_issue_zeroout")
---
 block/blk-lib.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index f8c82a9b4012..ed1e78e24db0 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -306,11 +306,6 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	if (ret == 0 || (ret && ret != -EOPNOTSUPP))
 		goto out;
 
-	ret = __blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
-			ZERO_PAGE(0), biop);
-	if (ret == 0 || (ret && ret != -EOPNOTSUPP))
-		goto out;
-
 	ret = 0;
 	while (nr_sects != 0) {
 		bio = next_bio(bio, min(nr_sects, (sector_t)BIO_MAX_PAGES),
@@ -369,6 +364,10 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			return 0;
 	}
 
+	if (!blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
+			ZERO_PAGE(0)))
+		return 0;
+
 	blk_start_plug(&plug);
 	ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
 			&bio, discard);
-- 
2.11.0
