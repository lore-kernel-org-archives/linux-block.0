Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	Tahsin Erdogan <tahsin@google.com>,
	Omar Sandoval <osandov@osandov.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/10] block: Fix bdi assignment to bdev inode when racing with disk delete
Date: Thu, 23 Mar 2017 01:36:53 +0100
Message-Id: <20170323003702.27571-2-jack@suse.cz>
In-Reply-To: <20170323003702.27571-1-jack@suse.cz>
References: <20170323003702.27571-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When disk->fops->open() in __blkdev_get() returns -ERESTARTSYS, we
restart the process of opening the block device. However we forget to
switch bdev->bd_bdi back to noop_backing_dev_info and as a result bdev
inode will be pointing to a stale bdi. Fix the problem by setting
bdev->bd_bdi later when __blkdev_get() is already guaranteed to succeed.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2eca00ec4370..53e2389ae4d4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1556,8 +1556,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		bdev->bd_disk = disk;
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
-		if (bdev->bd_bdi == &noop_backing_dev_info)
-			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 
 		if (!partno) {
 			ret = -ENXIO;
@@ -1622,6 +1620,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			}
 			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
 		}
+
+		if (bdev->bd_bdi == &noop_backing_dev_info)
+			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 	} else {
 		if (bdev->bd_contains == bdev) {
 			ret = 0;
@@ -1653,8 +1654,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	bdev->bd_disk = NULL;
 	bdev->bd_part = NULL;
 	bdev->bd_queue = NULL;
-	bdi_put(bdev->bd_bdi);
-	bdev->bd_bdi = &noop_backing_dev_info;
 	if (bdev != bdev->bd_contains)
 		__blkdev_put(bdev->bd_contains, mode, 1);
 	bdev->bd_contains = NULL;
-- 
2.10.2
