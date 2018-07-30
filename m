Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>
Subject: [PATCH 5/6] zram: register default groups with device_add_disk()
Date: Mon, 30 Jul 2018 09:12:26 +0200
Message-Id: <20180730071227.22887-6-hare@suse.de>
In-Reply-To: <20180730071227.22887-1-hare@suse.de>
References: <20180730071227.22887-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Register default sysfs groups during device_add-disk() to avoid a
race condition with udev during startup.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
---
 drivers/block/zram/zram_drv.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2907a8156aaf..fc3626cb7fe5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1618,6 +1618,11 @@ static const struct attribute_group zram_disk_attr_group = {
 	.attrs = zram_disk_attrs,
 };
 
+static const struct attribute_group *zram_disk_attr_groups[] = {
+	&zram_disk_attr_group,
+	NULL,
+};
+
 /*
  * Allocate and initialize new zram device. the function returns
  * '>= 0' device_id upon success, and negative value otherwise.
@@ -1698,24 +1703,14 @@ static int zram_add(void)
 
 	zram->disk->queue->backing_dev_info->capabilities |=
 			(BDI_CAP_STABLE_WRITES | BDI_CAP_SYNCHRONOUS_IO);
-	add_disk(zram->disk);
-
-	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
-				&zram_disk_attr_group);
-	if (ret < 0) {
-		pr_err("Error creating sysfs group for device %d\n",
-				device_id);
-		goto out_free_disk;
-	}
+	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
+
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
-out_free_disk:
-	del_gendisk(zram->disk);
-	put_disk(zram->disk);
 out_free_queue:
 	blk_cleanup_queue(queue);
 out_free_idr:
@@ -1744,15 +1739,6 @@ static int zram_remove(struct zram *zram)
 	mutex_unlock(&bdev->bd_mutex);
 
 	zram_debugfs_unregister(zram);
-	/*
-	 * Remove sysfs first, so no one will perform a disksize
-	 * store while we destroy the devices. This also helps during
-	 * hot_remove -- zram_reset_device() is the last holder of
-	 * ->init_lock, no later/concurrent disksize_store() or any
-	 * other sysfs handlers are possible.
-	 */
-	sysfs_remove_group(&disk_to_dev(zram->disk)->kobj,
-			&zram_disk_attr_group);
 
 	/* Make sure all the pending I/O are finished */
 	fsync_bdev(bdev);
-- 
2.12.3
