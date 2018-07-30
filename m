Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/6] genhd: drop 'bool' argument from __device_add_disk()
Date: Mon, 30 Jul 2018 09:12:22 +0200
Message-Id: <20180730071227.22887-2-hare@suse.de>
In-Reply-To: <20180730071227.22887-1-hare@suse.de>
References: <20180730071227.22887-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Split off the last part of __device_add_disk() and move it into the
caller.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/genhd.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8cc719a37b32..62aba3d8ae19 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -647,15 +647,13 @@ static void register_disk(struct device *parent, struct gendisk *disk)
  * __device_add_disk - add disk information to kernel list
  * @parent: parent device for the disk
  * @disk: per-device partitioning information
- * @register_queue: register the queue if set to true
  *
  * This function registers the partitioning information in @disk
  * with the kernel.
  *
  * FIXME: error handling
  */
-static void __device_add_disk(struct device *parent, struct gendisk *disk,
-			      bool register_queue)
+static void __device_add_disk(struct device *parent, struct gendisk *disk)
 {
 	dev_t devt;
 	int retval;
@@ -699,8 +697,13 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 				    exact_match, exact_lock, disk);
 	}
 	register_disk(parent, disk);
-	if (register_queue)
-		blk_register_queue(disk);
+}
+
+void device_add_disk(struct device *parent, struct gendisk *disk)
+{
+	__device_add_disk(parent, disk);
+
+	blk_register_queue(disk);
 
 	/*
 	 * Take an extra ref on queue which will be put on disk_release()
@@ -711,16 +714,19 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
-
-void device_add_disk(struct device *parent, struct gendisk *disk)
-{
-	__device_add_disk(parent, disk, true);
-}
 EXPORT_SYMBOL(device_add_disk);
 
 void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 {
-	__device_add_disk(parent, disk, false);
+	__device_add_disk(parent, disk);
+	/*
+	 * Take an extra ref on queue which will be put on disk_release()
+	 * so that it sticks around as long as @disk is there.
+	 */
+	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+
+	disk_add_events(disk);
+	blk_integrity_add(disk);
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
-- 
2.12.3
