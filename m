Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbeADKjj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jan 2018 05:39:39 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: reddot.rocks@gmail.com, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] block: loop: remove & invalidate partitions when detaching
Date: Thu,  4 Jan 2018 18:39:24 +0800
Message-Id: <20180104103924.8814-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When detaching loop disk, neither we remove loop partitions, nor
invalidate them. This way may cause data loss, and often confuse
people.

This patch fixes the above issue by removing & invalidating loop
partitions in loop_clr_fd(),

Reported-by: reddot.rocks@gmail.com
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c         | 15 +++++++++++----
 drivers/block/loop.c  |  4 ++--
 include/linux/genhd.h |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 96a66f671720..24c66e940c0c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -695,14 +695,11 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 }
 EXPORT_SYMBOL(device_add_disk);
 
-void del_gendisk(struct gendisk *disk)
+void del_gendisk_partitions(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
-	blk_integrity_del(disk);
-	disk_del_events(disk);
-
 	/* invalidate stuff */
 	disk_part_iter_init(&piter, disk,
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
@@ -714,7 +711,17 @@ void del_gendisk(struct gendisk *disk)
 	disk_part_iter_exit(&piter);
 
 	invalidate_partition(disk, 0);
+}
+EXPORT_SYMBOL(del_gendisk_partitions);
+
+void del_gendisk(struct gendisk *disk)
+{
+	blk_integrity_del(disk);
+	disk_del_events(disk);
+
+	del_gendisk_partitions(disk);
 	bdev_unhash_inode(disk_devt(disk));
+
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc8e61506968..a84c7befcc94 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1021,6 +1021,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	if (filp == NULL)
 		return -EINVAL;
 
+	del_gendisk_partitions(lo->lo_disk);
+
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
@@ -1060,8 +1062,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
-		loop_reread_partitions(lo, bdev);
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5144ebe046c9..ae41535e705c 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -397,6 +397,7 @@ static inline void add_disk(struct gendisk *disk)
 }
 
 extern void del_gendisk(struct gendisk *gp);
+extern void del_gendisk_partitions(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
-- 
2.9.5
