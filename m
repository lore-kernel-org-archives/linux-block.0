Return-Path: <BATV+e774f35f755d74bf45df+5174+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
Date: Mon, 23 Oct 2017 16:51:15 +0200
Message-Id: <20171023145126.2471-7-hch@lst.de>
In-Reply-To: <20171023145126.2471-1-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

With this flag a driver can create a gendisk that can be used for I/O
submission inside the kernel, but which is not registered as user
facing block device.  This will be useful for the NVMe multipath
implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 57 +++++++++++++++++++++++++++++++++++----------------
 include/linux/genhd.h |  1 +
 2 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1174d24e405e..11a41cca3475 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -585,6 +585,11 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
+	if (disk->flags & GENHD_FL_HIDDEN) {
+		dev_set_uevent_suppress(ddev, 0);
+		return;
+	}
+
 	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 
@@ -616,6 +621,11 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 	while ((part = disk_part_iter_next(&piter)))
 		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
 	disk_part_iter_exit(&piter);
+
+	err = sysfs_create_link(&ddev->kobj,
+				&disk->queue->backing_dev_info->dev->kobj,
+				"bdi");
+	WARN_ON(err);
 }
 
 /**
@@ -630,7 +640,6 @@ static void register_disk(struct device *parent, struct gendisk *disk)
  */
 void device_add_disk(struct device *parent, struct gendisk *disk)
 {
-	struct backing_dev_info *bdi;
 	dev_t devt;
 	int retval;
 
@@ -639,7 +648,8 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 	 * parameters make sense.
 	 */
 	WARN_ON(disk->minors && !(disk->major || disk->first_minor));
-	WARN_ON(!disk->minors && !(disk->flags & GENHD_FL_EXT_DEVT));
+	WARN_ON(!disk->minors &&
+		!(disk->flags & (GENHD_FL_EXT_DEVT | GENHD_FL_HIDDEN)));
 
 	disk->flags |= GENHD_FL_UP;
 
@@ -648,18 +658,26 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 		WARN_ON(1);
 		return;
 	}
-	disk_to_dev(disk)->devt = devt;
 	disk->major = MAJOR(devt);
 	disk->first_minor = MINOR(devt);
 
 	disk_alloc_events(disk);
 
-	/* Register BDI before referencing it from bdev */
-	bdi = disk->queue->backing_dev_info;
-	bdi_register_owner(bdi, disk_to_dev(disk));
-
-	blk_register_region(disk_devt(disk), disk->minors, NULL,
-			    exact_match, exact_lock, disk);
+	if (disk->flags & GENHD_FL_HIDDEN) {
+		/*
+		 * Don't let hidden disks show up in /proc/partitions,
+		 * and don't bother scanning for partitions either.
+		 */
+		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
+		disk->flags |= GENHD_FL_NO_PART_SCAN;
+	} else {
+		/* Register BDI before referencing it from bdev */
+		disk_to_dev(disk)->devt = devt;
+		bdi_register_owner(disk->queue->backing_dev_info,
+				disk_to_dev(disk));
+		blk_register_region(disk_devt(disk), disk->minors, NULL,
+				    exact_match, exact_lock, disk);
+	}
 	register_disk(parent, disk);
 	blk_register_queue(disk);
 
@@ -669,10 +687,6 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 	 */
 	WARN_ON_ONCE(!blk_get_queue(disk->queue));
 
-	retval = sysfs_create_link(&disk_to_dev(disk)->kobj, &bdi->dev->kobj,
-				   "bdi");
-	WARN_ON(retval);
-
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
@@ -701,7 +715,8 @@ void del_gendisk(struct gendisk *disk)
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 
-	sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
+	if (!(disk->flags & GENHD_FL_HIDDEN))
+		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
 	if (disk->queue) {
 		/*
 		 * Unregister bdi before releasing device numbers (as they can
@@ -712,13 +727,15 @@ void del_gendisk(struct gendisk *disk)
 	} else {
 		WARN_ON(1);
 	}
-	blk_unregister_region(disk_devt(disk), disk->minors);
+
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+		blk_unregister_region(disk_devt(disk), disk->minors);
+		kobject_put(disk->part0.holder_dir);
+		kobject_put(disk->slave_dir);
+	}
 
 	part_stat_set_all(&disk->part0, 0);
 	disk->part0.stamp = 0;
-
-	kobject_put(disk->part0.holder_dir);
-	kobject_put(disk->slave_dir);
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
@@ -781,6 +798,10 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 		spin_unlock_bh(&ext_devt_lock);
 	}
 
+	if (unlikely(disk->flags & GENHD_FL_HIDDEN)) {
+		put_disk(disk);
+		disk = NULL;
+	}
 	return disk;
 }
 EXPORT_SYMBOL(get_gendisk);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5c0ed5db33c2..93aae3476f58 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -140,6 +140,7 @@ struct hd_struct {
 #define GENHD_FL_NATIVE_CAPACITY		128
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	256
 #define GENHD_FL_NO_PART_SCAN			512
+#define GENHD_FL_HIDDEN				1024
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
-- 
2.14.2
