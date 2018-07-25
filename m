Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Martin Wilck <martin.wilck@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 2/5] block: genhd: add device_add_disk_with_groups
Date: Wed, 25 Jul 2018 08:28:37 +0200
Message-Id: <20180725062840.94114-3-hare@suse.de>
In-Reply-To: <20180725062840.94114-1-hare@suse.de>
References: <20180725062840.94114-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Update __device_add_disk() to take an 'groups' argument so that
individual drivers can register a device with additional sysfs
attributes.
This avoids race condition the driver would otherwise have if these
groups need to be created with sysfs_add_groups().

Signed-off-by: Martin Wilck <martin.wilck@suse.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/genhd.c         | 28 +++++++++++++++++++++++-----
 include/linux/genhd.h |  3 +++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cfa7f4f78435..fbe27cb2c9d7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -567,7 +567,8 @@ static int exact_lock(dev_t devt, void *data)
 	return 0;
 }
 
-static void register_disk(struct device *parent, struct gendisk *disk)
+static void register_disk(struct device *parent, struct gendisk *disk,
+			  const struct attribute_group **groups)
 {
 	struct device *ddev = disk_to_dev(disk);
 	struct block_device *bdev;
@@ -582,6 +583,10 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
 
+	if (groups) {
+		WARN_ON(ddev->groups);
+		ddev->groups = groups;
+	}
 	if (device_add(ddev))
 		return;
 	if (!sysfs_deprecated) {
@@ -647,13 +652,15 @@ static void register_disk(struct device *parent, struct gendisk *disk)
  * __device_add_disk - add disk information to kernel list
  * @parent: parent device for the disk
  * @disk: per-device partitioning information
+ * @groups: Additional per-device sysfs groups
  *
  * This function registers the partitioning information in @disk
  * with the kernel.
  *
  * FIXME: error handling
  */
-static void __device_add_disk(struct device *parent, struct gendisk *disk)
+static void __device_add_disk(struct device *parent, struct gendisk *disk,
+			      const struct attribute_group **groups)
 {
 	dev_t devt;
 	int retval;
@@ -696,7 +703,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk)
 		blk_register_region(disk_devt(disk), disk->minors, NULL,
 				    exact_match, exact_lock, disk);
 	}
-	register_disk(parent, disk);
+	register_disk(parent, disk, groups);
 }
 
 void __device_get_disk(struct gendisk *disk)
@@ -711,9 +718,20 @@ void __device_get_disk(struct gendisk *disk)
 	blk_integrity_add(disk);
 }
 
+void device_add_disk_with_groups(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups)
+{
+	__device_add_disk(parent, disk, groups);
+
+	blk_register_queue(disk);
+
+	__device_get_disk(disk);
+}
+EXPORT_SYMBOL(device_add_disk_with_groups);
+
 void device_add_disk(struct device *parent, struct gendisk *disk)
 {
-	__device_add_disk(parent, disk);
+	__device_add_disk(parent, disk, NULL);
 
 	blk_register_queue(disk);
 
@@ -723,7 +741,7 @@ EXPORT_SYMBOL(device_add_disk);
 
 void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 {
-	__device_add_disk(parent, disk);
+	__device_add_disk(parent, disk, NULL);
 	__device_get_disk(disk);
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6cb8a5789668..f41152979296 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -394,6 +394,9 @@ extern void part_round_stats(struct request_queue *q, int cpu, struct hd_struct
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk);
+extern void device_add_disk_with_groups(struct device *parent,
+					struct gendisk *disk,
+					const struct attribute_group **groups);
 static inline void add_disk(struct gendisk *disk)
 {
 	device_add_disk(NULL, disk);
-- 
2.12.3
