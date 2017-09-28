Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.de>
Subject: [PATCH 1/2] block: genhd: add device_add_disk_with_groups
Date: Thu, 28 Sep 2017 21:36:36 +0200
Message-Id: <20170928193637.24707-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

In the NVME subsystem, we're seeing a race condition with udev where
device_add_disk() is called (which triggers an "add" uevent), and a
sysfs attribute group is added to the disk device afterwards.
If udev rules access these attributes before they are created,
udev processing of the device is incomplete, in particular, device
WWIDs may not be determined correctly.

To fix this, this patch introduces a new function
device_add_disk_with_groups(), which takes a list of attribute groups
and adds them to the device before sending out uevents.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 block/genhd.c         | 17 ++++++++++++-----
 include/linux/genhd.h |  8 +++++++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index dd305c65ffb0..1900682a221e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -552,7 +552,8 @@ static int exact_lock(dev_t devt, void *data)
 	return 0;
 }
 
-static void register_disk(struct device *parent, struct gendisk *disk)
+static void register_disk(struct device *parent, struct gendisk *disk,
+			  const struct attribute_group **groups)
 {
 	struct device *ddev = disk_to_dev(disk);
 	struct block_device *bdev;
@@ -578,6 +579,9 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 		}
 	}
 
+	if (groups != NULL && sysfs_create_groups(&ddev->kobj, groups))
+		dev_warn(ddev, "failed to add attribute groups");
+
 	/*
 	 * avoid probable deadlock caused by allocating memory with
 	 * GFP_KERNEL in runtime_resume callback of its all ancestor
@@ -619,16 +623,19 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 }
 
 /**
- * device_add_disk - add partitioning information to kernel list
+ * device_add_disk_with_groups - add partitioning information to kernel list
  * @parent: parent device for the disk
  * @disk: per-device partitioning information
+ * @groups: NULL-terminated array of attribute groups
  *
  * This function registers the partitioning information in @disk
  * with the kernel.
  *
  * FIXME: error handling
  */
-void device_add_disk(struct device *parent, struct gendisk *disk)
+void device_add_disk_with_groups(struct device *parent,
+				struct gendisk *disk,
+				const struct attribute_group **groups)
 {
 	struct backing_dev_info *bdi;
 	dev_t devt;
@@ -664,7 +671,7 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 
 	blk_register_region(disk_devt(disk), disk->minors, NULL,
 			    exact_match, exact_lock, disk);
-	register_disk(parent, disk);
+	register_disk(parent, disk, groups);
 	blk_register_queue(disk);
 
 	/*
@@ -680,7 +687,7 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
-EXPORT_SYMBOL(device_add_disk);
+EXPORT_SYMBOL(device_add_disk_with_groups);
 
 void del_gendisk(struct gendisk *disk)
 {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ea652bfcd675..3404d92d5063 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -386,7 +386,13 @@ static inline void free_part_info(struct hd_struct *part)
 extern void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part);
 
 /* block/genhd.c */
-extern void device_add_disk(struct device *parent, struct gendisk *disk);
+extern void device_add_disk_with_groups(struct device *parent,
+					struct gendisk *disk,
+					const struct attribute_group **groups);
+static inline void device_add_disk(struct device *parent, struct gendisk *disk)
+{
+	device_add_disk_with_groups(parent, disk, NULL);
+}
 static inline void add_disk(struct gendisk *disk)
 {
 	device_add_disk(NULL, disk);
-- 
2.14.0
