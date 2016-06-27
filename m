Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46724 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbcF0TbC (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 27 Jun 2016 15:31:02 -0400
Subject: [PATCH v5 5/5] block: remove ->driverfs_dev
From: Dan Williams <dan.j.williams@intel.com>
To: axboe@fb.com
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ross Zwisler <ross.zwisler@linux.intel.com>, hch@lst.de
Date: Mon, 27 Jun 2016 12:30:19 -0700
Message-ID: <146705581912.39775.9811510607157155243.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146705579255.39775.12551436695635245858.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now that all drivers that specify a ->driverfs_dev have been converted
to device_add_disk(), the pointer can be removed from struct gendisk.

Cc: Jens Axboe <axboe@fb.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 block/genhd.c         |    9 ++-------
 drivers/nvdimm/bus.c  |    2 +-
 include/linux/genhd.h |    4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index fb2d9aeb75a5..a18d35390f1d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -618,10 +618,6 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 
 	blk_register_region(disk_devt(disk), disk->minors, NULL,
 			    exact_match, exact_lock, disk);
-
-	/* temporary while we convert usages to use disk_to_dev(disk)->parent */
-	disk->driverfs_dev = parent;
-
 	register_disk(parent, disk);
 	blk_register_queue(disk);
 
@@ -804,10 +800,9 @@ void __init printk_all_partitions(void)
 			       , disk_name(disk, part->partno, name_buf),
 			       part->info ? part->info->uuid : "");
 			if (is_part0) {
-				if (disk->driverfs_dev != NULL &&
-				    disk->driverfs_dev->driver != NULL)
+				if (dev->parent && dev->parent->driver)
 					printk(" driver: %s\n",
-					      disk->driverfs_dev->driver->name);
+					      dev->parent->driver->name);
 				else
 					printk(" (driver?)\n");
 			} else
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index f085f8bceae8..5e4e5c772ea5 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -312,7 +312,7 @@ EXPORT_SYMBOL(__nd_driver_register);
 
 int nvdimm_revalidate_disk(struct gendisk *disk)
 {
-	struct device *dev = disk->driverfs_dev;
+	struct device *dev = disk_to_dev(disk)->parent;
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	const char *pol = nd_region->ro ? "only" : "write";
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index df1dabbfd388..1dbf52f9c24b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -205,7 +205,6 @@ struct gendisk {
 	void *private_data;
 
 	int flags;
-	struct device *driverfs_dev;  // FIXME: remove
 	struct kobject *slave_dir;
 
 	struct timer_rand_state *random;
@@ -417,8 +416,7 @@ extern void part_round_stats(int cpu, struct hd_struct *part);
 extern void device_add_disk(struct device *parent, struct gendisk *disk);
 static inline void add_disk(struct gendisk *disk)
 {
-	/* temporary while we convert callers to device_add_disk */
-	device_add_disk(disk->driverfs_dev, disk);
+	device_add_disk(NULL, disk);
 }
 
 extern void del_gendisk(struct gendisk *gp);

