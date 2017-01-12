Return-Path: <Damien.LeMoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-block@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 1/2] block: Rename blk_queue_zone_size and bdev_zone_size
Date: Thu, 12 Jan 2017 11:42:52 +0900
Message-Id: <20170112024253.5814-2-damien.lemoal@wdc.com>
In-Reply-To: <20170112024253.5814-1-damien.lemoal@wdc.com>
References: <20170112024253.5814-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

All block device data fields and functions returning a number of 512B
sectors are by convention named xxx_sectors while names in the form
xxx_size are generally used for a number of bytes. The blk_queue_zone_size
and bdev_zone_size functions were not following this convention so rename
them.

No functional change is introduced by this patch.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c         |  4 ++--
 block/partition-generic.c | 14 +++++++-------
 include/linux/blkdev.h    |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 472211f..3bd15d8 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -16,7 +16,7 @@
 static inline sector_t blk_zone_start(struct request_queue *q,
 				      sector_t sector)
 {
-	sector_t zone_mask = blk_queue_zone_size(q) - 1;
+	sector_t zone_mask = blk_queue_zone_sectors(q) - 1;
 
 	return sector & ~zone_mask;
 }
@@ -222,7 +222,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	zone_sectors = blk_queue_zone_size(q);
+	zone_sectors = blk_queue_zone_sectors(q);
 	if (sector & (zone_sectors - 1))
 		return -EINVAL;
 
diff --git a/block/partition-generic.c b/block/partition-generic.c
index d7beb6b..7afb990 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -434,7 +434,7 @@ static bool part_zone_aligned(struct gendisk *disk,
 			      struct block_device *bdev,
 			      sector_t from, sector_t size)
 {
-	unsigned int zone_size = bdev_zone_size(bdev);
+	unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
 	/*
 	 * If this function is called, then the disk is a zoned block device
@@ -446,7 +446,7 @@ static bool part_zone_aligned(struct gendisk *disk,
 	 * regular block devices (no zone operation) and their zone size will
 	 * be reported as 0. Allow this case.
 	 */
-	if (!zone_size)
+	if (!zone_sectors)
 		return true;
 
 	/*
@@ -455,24 +455,24 @@ static bool part_zone_aligned(struct gendisk *disk,
 	 * use it. Check the zone size too: it should be a power of 2 number
 	 * of sectors.
 	 */
-	if (WARN_ON_ONCE(!is_power_of_2(zone_size))) {
+	if (WARN_ON_ONCE(!is_power_of_2(zone_sectors))) {
 		u32 rem;
 
-		div_u64_rem(from, zone_size, &rem);
+		div_u64_rem(from, zone_sectors, &rem);
 		if (rem)
 			return false;
 		if ((from + size) < get_capacity(disk)) {
-			div_u64_rem(size, zone_size, &rem);
+			div_u64_rem(size, zone_sectors, &rem);
 			if (rem)
 				return false;
 		}
 
 	} else {
 
-		if (from & (zone_size - 1))
+		if (from & (zone_sectors - 1))
 			return false;
 		if ((from + size) < get_capacity(disk) &&
-		    (size & (zone_size - 1)))
+		    (size & (zone_sectors - 1)))
 			return false;
 
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8369564..ff3d774 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -739,7 +739,7 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
-static inline unsigned int blk_queue_zone_size(struct request_queue *q)
+static inline unsigned int blk_queue_zone_sectors(struct request_queue *q)
 {
 	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
 }
@@ -1536,12 +1536,12 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
 	return false;
 }
 
-static inline unsigned int bdev_zone_size(struct block_device *bdev)
+static inline unsigned int bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
 	if (q)
-		return blk_queue_zone_size(q);
+		return blk_queue_zone_sectors(q);
 
 	return 0;
 }
-- 
2.9.3

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
