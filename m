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
Subject: [PATCH 1/5] genhd: drop 'bool' argument from __device_add_disk()
Date: Wed, 25 Jul 2018 08:28:36 +0200
Message-Id: <20180725062840.94114-2-hare@suse.de>
In-Reply-To: <20180725062840.94114-1-hare@suse.de>
References: <20180725062840.94114-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Split off the last part of __device_add_disk() into __device_get_disk().
With that we can drop the 'bool' argument and streamline the function.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/genhd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index f1543a45e73b..cfa7f4f78435 100644
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
@@ -699,9 +697,10 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 				    exact_match, exact_lock, disk);
 	}
 	register_disk(parent, disk);
-	if (register_queue)
-		blk_register_queue(disk);
+}
 
+void __device_get_disk(struct gendisk *disk)
+{
 	/*
 	 * Take an extra ref on queue which will be put on disk_release()
 	 * so that it sticks around as long as @disk is there.
@@ -714,13 +713,18 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 void device_add_disk(struct device *parent, struct gendisk *disk)
 {
-	__device_add_disk(parent, disk, true);
+	__device_add_disk(parent, disk);
+
+	blk_register_queue(disk);
+
+	__device_get_disk(disk);
 }
 EXPORT_SYMBOL(device_add_disk);
 
 void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 {
-	__device_add_disk(parent, disk, false);
+	__device_add_disk(parent, disk);
+	__device_get_disk(disk);
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
-- 
2.12.3
