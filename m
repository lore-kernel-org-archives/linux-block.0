Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24647 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbcFQQfX (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 17 Jun 2016 12:35:23 -0400
Subject: [PATCH v3 1/3] block: introduce device_add_disk()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Date: Fri, 17 Jun 2016 09:34:39 -0700
Message-ID: <146618127928.31030.14749842741360356417.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <146618127395.31030.11800447312061202344.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146618127395.31030.11800447312061202344.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 block/genhd.c         |   13 +++++++------
 include/linux/genhd.h |    8 +++++++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f42526b4d62..932e70c113d0 100644
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
@@ -617,7 +618,7 @@ void add_disk(struct gendisk *disk)
 
 	blk_register_region(disk_devt(disk), disk->minors, NULL,
 			    exact_match, exact_lock, disk);
-	register_disk(disk);
+	register_disk(parent, disk);
 	blk_register_queue(disk);
 
 	/*
@@ -633,7 +634,7 @@ void add_disk(struct gendisk *disk)
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

