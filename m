Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64841 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbcF0Tal (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 27 Jun 2016 15:30:41 -0400
Subject: [PATCH v5 1/5] block: introduce device_add_disk()
From: Dan Williams <dan.j.williams@intel.com>
To: axboe@fb.com
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>, hch@lst.de
Date: Mon, 27 Jun 2016 12:29:58 -0700
Message-ID: <146705579791.39775.15665203168655855394.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation for removing the ->driverfs_dev member of a gendisk, add
an api that takes the parent device as a parameter to add_disk().  For
now this maintains the status quo of WARN()ing on failure, but not
return a error code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 block/genhd.c         |   17 +++++++++++------
 include/linux/genhd.h |    8 +++++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f42526b4d62..fb2d9aeb75a5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -506,7 +506,7 @@ static int exact_lock(dev_t devt, void *data)
 	return 0;
 }
 
-static void register_disk(struct gendisk *disk)
+static void register_disk(struct device *parent, struct gendisk *disk)
 {
 	struct device *ddev = disk_to_dev(disk);
 	struct block_device *bdev;
@@ -514,7 +514,7 @@ static void register_disk(struct gendisk *disk)
 	struct hd_struct *part;
 	int err;
 
-	ddev->parent = disk->driverfs_dev;
+	ddev->parent = parent;
 
 	dev_set_name(ddev, "%s", disk->disk_name);
 
@@ -573,7 +573,8 @@ exit:
 }
 
 /**
- * add_disk - add partitioning information to kernel list
+ * device_add_disk - add partitioning information to kernel list
+ * @parent: parent device for the disk
  * @disk: per-device partitioning information
  *
  * This function registers the partitioning information in @disk
@@ -581,7 +582,7 @@ exit:
  *
  * FIXME: error handling
  */
-void add_disk(struct gendisk *disk)
+void device_add_disk(struct device *parent, struct gendisk *disk)
 {
 	struct backing_dev_info *bdi;
 	dev_t devt;
@@ -617,7 +618,11 @@ void add_disk(struct gendisk *disk)
 
 	blk_register_region(disk_devt(disk), disk->minors, NULL,
 			    exact_match, exact_lock, disk);
-	register_disk(disk);
+
+	/* temporary while we convert usages to use disk_to_dev(disk)->parent */
+	disk->driverfs_dev = parent;
+
+	register_disk(parent, disk);
 	blk_register_queue(disk);
 
 	/*
@@ -633,7 +638,7 @@ void add_disk(struct gendisk *disk)
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
-EXPORT_SYMBOL(add_disk);
+EXPORT_SYMBOL(device_add_disk);
 
 void del_gendisk(struct gendisk *disk)
 {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 359a8e4bd44d..df1dabbfd388 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -414,7 +414,13 @@ static inline void free_part_info(struct hd_struct *part)
 extern void part_round_stats(int cpu, struct hd_struct *part);
 
 /* block/genhd.c */
-extern void add_disk(struct gendisk *disk);
+extern void device_add_disk(struct device *parent, struct gendisk *disk);
+static inline void add_disk(struct gendisk *disk)
+{
+	/* temporary while we convert callers to device_add_disk */
+	device_add_disk(disk->driverfs_dev, disk);
+}
+
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);

