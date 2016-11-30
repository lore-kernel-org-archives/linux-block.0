Return-Path: <Damien.LeMoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] block: Check partition alignment on zoned block devices
Date: Wed, 30 Nov 2016 17:22:19 +0900
Message-Id: <1480494139-1658-1-git-send-email-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

Both blkdev_report_zones and blkdev_reset_zones can operate on a partition of
a zoned block device. However, the first and last zones reported for a
partition make sense only if the partition start sector and size are aligned
on the device zone size. The same applies for zone reset. Resetting the first
or the last zone of a partition straddling zones may impact neighboring
partitions. Finally, if a partition start sector is not at the beginning of a
sequential zone, it will be impossible to write to the first sectors of the
partition on a host-managed device.
Avoid all these problems and incoherencies by ignoring partitions that are not
zone aligned.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/partition-generic.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 71d9ed9..c5914b2 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -430,6 +430,29 @@ static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static bool part_zone_aligned(struct gendisk *disk,
+			      struct block_device *bdev,
+			      sector_t from, sector_t size)
+{
+	sector_t zone_size = bdev_zone_size(bdev);
+
+	/* Check partition start alignement */
+	if (from & (zone_size - 1))
+		return false;
+
+	/*
+	 * Check partition end alignement.
+	 * Ignore eventual last smaller zone.
+	 */
+	if ((from + size) < get_capacity(disk) &&
+	    (size & (zone_size - 1)))
+		return false;
+
+	return true;
+}
+#endif
+
 int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state = NULL;
@@ -529,6 +552,22 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 			}
 		}
 
+#ifdef CONFIG_BLK_DEV_ZONED
+		/*
+		 * On a zoned block device, partitions should be aligned on the
+		 * device zone size (i.e. zone boundary crossing not allowed).
+		 * Otherwise, resetting the write pointer of the last zone of
+		 * one partition may impact the following partition.
+		 */
+		if (bdev_is_zoned(bdev) &&
+		    !part_zone_aligned(disk, bdev, from, size)) {
+			printk(KERN_WARNING
+			       "%s: p%d start %llu is not zone unaligned\n",
+			       disk->disk_name, p, (unsigned long long) from);
+			continue;
+		}
+#endif
+
 		part = add_partition(disk, p, from, size,
 				     state->parts[p].flags,
 				     &state->parts[p].info);
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
