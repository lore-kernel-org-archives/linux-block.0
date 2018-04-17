Return-Path: <prvs=63851e16a=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Hannes Reinecke <hare@suse.com>,
	Shaun Tancheff <shaun@tancheff.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: Avoid executing a report or reset zones while a queue is frozen
Date: Mon, 16 Apr 2018 18:00:34 -0700
Message-Id: <20180417010034.28676-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch on itself does not change the behavior of either ioctl.
However, this patch is necessary to avoid that these ioctls fail
with -EIO if sd_revalidate_disk() is called while these ioctls are
in progress because the current zoned block command code temporarily
clears data that is needed by these ioctls. See also commit
3ed05a987e0f ("blk-zoned: implement ioctls").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Shaun Tancheff <shaun@tancheff.com>
Cc: stable@vger.kernel.org # v4.10
---
 block/blk-zoned.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 20bfc37e1852..acc71e8c3473 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -127,15 +127,19 @@ int blkdev_report_zones(struct block_device *bdev,
 	if (!q)
 		return -ENXIO;
 
+	blk_queue_enter(q, 0);
+
+	ret = -EOPNOTSUPP;
 	if (!blk_queue_is_zoned(q))
-		return -EOPNOTSUPP;
+		goto exit_queue;
 
+	ret = 0;
 	if (!nrz)
-		return 0;
+		goto exit_queue;
 
 	if (sector > bdev->bd_part->nr_sects) {
 		*nr_zones = 0;
-		return 0;
+		goto exit_queue;
 	}
 
 	/*
@@ -154,9 +158,10 @@ int blkdev_report_zones(struct block_device *bdev,
 	nr_pages = min_t(unsigned int, nr_pages,
 			 queue_max_segments(q));
 
+	ret = -ENOMEM;
 	bio = bio_alloc(gfp_mask, nr_pages);
 	if (!bio)
-		return -ENOMEM;
+		goto exit_queue;
 
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = blk_zone_start(q, sector);
@@ -166,7 +171,7 @@ int blkdev_report_zones(struct block_device *bdev,
 		page = alloc_page(gfp_mask);
 		if (!page) {
 			ret = -ENOMEM;
-			goto out;
+			goto put_bio;
 		}
 		if (!bio_add_page(bio, page, PAGE_SIZE, 0)) {
 			__free_page(page);
@@ -179,7 +184,7 @@ int blkdev_report_zones(struct block_device *bdev,
 	else
 		ret = submit_bio_wait(bio);
 	if (ret)
-		goto out;
+		goto put_bio;
 
 	/*
 	 * Process the report result: skip the header and go through the
@@ -222,11 +227,14 @@ int blkdev_report_zones(struct block_device *bdev,
 	}
 
 	*nr_zones = nz;
-out:
+put_bio:
 	bio_for_each_segment_all(bv, bio, i)
 		__free_page(bv->bv_page);
 	bio_put(bio);
 
+exit_queue:
+	blk_queue_exit(q);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
@@ -256,21 +264,25 @@ int blkdev_reset_zones(struct block_device *bdev,
 	if (!q)
 		return -ENXIO;
 
+	blk_queue_enter(q, 0);
+
+	ret = -EOPNOTSUPP;
 	if (!blk_queue_is_zoned(q))
-		return -EOPNOTSUPP;
+		goto out;
 
+	ret = -EINVAL;
 	if (end_sector > bdev->bd_part->nr_sects)
 		/* Out of range */
-		return -EINVAL;
+		goto out;
 
 	/* Check alignment (handle eventual smaller last zone) */
 	zone_sectors = blk_queue_zone_sectors(q);
 	if (sector & (zone_sectors - 1))
-		return -EINVAL;
+		goto out;
 
 	if ((nr_sectors & (zone_sectors - 1)) &&
 	    end_sector != bdev->bd_part->nr_sects)
-		return -EINVAL;
+		goto out;
 
 	while (sector < end_sector) {
 
@@ -283,7 +295,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 		bio_put(bio);
 
 		if (ret)
-			return ret;
+			goto out;
 
 		sector += zone_sectors;
 
@@ -292,7 +304,11 @@ int blkdev_reset_zones(struct block_device *bdev,
 
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	blk_queue_exit(q);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(blkdev_reset_zones);
 
-- 
2.16.3
