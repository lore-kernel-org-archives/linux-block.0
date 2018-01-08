Return-Path: <rakesh@tuxera.com>
Date: Mon, 8 Jan 2018 13:51:20 +0200
From: Rakesh Pandit <rakesh@tuxera.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] block: remove unused return type for invalidate_partitions
Message-ID: <20180108115119.GA3852@dhcp-108-107.ws.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 block/partition-generic.c | 8 ++++----
 include/linux/genhd.h     | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 91622db..8df0d03 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -623,16 +623,16 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 	return 0;
 }
 
-int invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
+void invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	int res;
 
 	if (!bdev->bd_invalidated)
-		return 0;
+		return;
 
 	res = drop_partitions(disk, bdev);
 	if (res)
-		return res;
+		return;
 
 	set_capacity(disk, 0);
 	check_disk_size_change(disk, bdev);
@@ -640,7 +640,7 @@ int invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
 	/* tell userspace that the media / partition table may have changed */
 	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 
-	return 0;
+	return;
 }
 
 unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5144ebe..683de33 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -584,7 +584,8 @@ extern char *disk_name (struct gendisk *hd, int partno, char *buf);
 
 extern int disk_expand_part_tbl(struct gendisk *disk, int target);
 extern int rescan_partitions(struct gendisk *disk, struct block_device *bdev);
-extern int invalidate_partitions(struct gendisk *disk, struct block_device *bdev);
+extern void invalidate_partitions(struct gendisk *disk, struct block_device
+			*bdev);
 extern struct hd_struct * __must_check add_partition(struct gendisk *disk,
 						     int partno, sector_t start,
 						     sector_t len, int flags,
-- 
2.5.5
