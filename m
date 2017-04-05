Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com,
	agk@redhat.com,
	snitzer@redhat.com,
	shli@kernel.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: [PATCH 22/27] block: stop using discards for zeroing
Date: Wed,  5 Apr 2017 19:21:20 +0200
Message-Id: <20170405172125.22600-23-hch@lst.de>
In-Reply-To: <20170405172125.22600-1-hch@lst.de>
References: <20170405172125.22600-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now that we have REQ_OP_WRITE_ZEROES implemented for all devices that
support efficient zeroing, we can remove the call to blkdev_issue_discard.
This means we only have two ways of zeroing left and can simplify the
code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 2f882e22890b..b0c6c4bcf441 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -279,6 +279,12 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
  *  Zero-fill a block range, either using hardware offload or by explicitly
  *  writing zeroes to the device.
  *
+ *  Note that this function may fail with -EOPNOTSUPP if the driver signals
+ *  zeroing offload support, but the device fails to process the command (for
+ *  some devices there is no non-destructive way to verify whether this
+ *  operation is actually supported).  In this case the caller should call
+ *  retry the call to blkdev_issue_zeroout() and the fallback path will be used.
+ *
  *  If a device is using logical block provisioning, the underlying space will
  *  not be released if %flags contains BLKDEV_ZERO_NOUNMAP.
  *
@@ -349,12 +355,6 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	struct bio *bio = NULL;
 	struct blk_plug plug;
 
-	if (!(flags & BLKDEV_ZERO_NOUNMAP)) {
-		if (!blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
-				BLKDEV_DISCARD_ZERO))
-			return 0;
-	}
-
 	blk_start_plug(&plug);
 	ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
 			&bio, flags);
-- 
2.11.0
