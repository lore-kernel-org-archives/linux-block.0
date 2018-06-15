Return-Path: <prvs=697b38d23=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Matias Bjorling <mb@lightnvm.io>
Subject: [PATCH 3/5] block: Remove bdev_nr_zones()
Date: Fri, 15 Jun 2018 14:55:19 -0700
Message-Id: <20180615215521.27435-4-bart.vanassche@wdc.com>
In-Reply-To: <20180615215521.27435-1-bart.vanassche@wdc.com>
References: <20180615215521.27435-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Remove this function since it has no callers. This function was
introduced in commit 6cc77e9cb080 ("block: introduce zoned block
devices zone write locking").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Matias Bjorling <mb@lightnvm.io>
---
 include/linux/blkdev.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a8b98eadebb2..05cd0c8e5735 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1648,15 +1648,6 @@ static inline unsigned int bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
-static inline unsigned int bdev_nr_zones(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return blk_queue_nr_zones(q);
-	return 0;
-}
-
 static inline int queue_dma_alignment(struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.17.0
