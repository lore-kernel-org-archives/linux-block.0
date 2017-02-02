Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4/5] block: Make blk_get_backing_dev_info() safe without open bdev
Date: Thu,  2 Feb 2017 15:56:52 +0100
Message-Id: <20170202145653.19614-5-jack@suse.cz>
In-Reply-To: <20170202145653.19614-1-jack@suse.cz>
References: <20170202145653.19614-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Currenly blk_get_backing_dev_info() is not safe to be called when the
block device is not open as bdev->bd_disk is NULL in that case. However
inode_to_bdi() uses this function and may be call called from flusher
worker or other writeback related functions without bdev being open
which leads to crashes such as:

[113031.075540] Unable to handle kernel paging request for data at address 0x00000000
[113031.075614] Faulting instruction address: 0xc0000000003692e0
0:mon> t
[c0000000fb65f900] c00000000036cb6c writeback_sb_inodes+0x30c/0x590
[c0000000fb65fa10] c00000000036ced4 __writeback_inodes_wb+0xe4/0x150
[c0000000fb65fa70] c00000000036d33c wb_writeback+0x30c/0x450
[c0000000fb65fb40] c00000000036e198 wb_workfn+0x268/0x580
[c0000000fb65fc50] c0000000000f3470 process_one_work+0x1e0/0x590
[c0000000fb65fce0] c0000000000f38c8 worker_thread+0xa8/0x660
[c0000000fb65fd80] c0000000000fc4b0 kthread+0x110/0x130
[c0000000fb65fe30] c0000000000098f0 ret_from_kernel_thread+0x5c/0x6c
--- Exception: 0  at 0000000000000000
0:mon> e
cpu 0x0: Vector: 300 (Data Access) at [c0000000fb65f620]
    pc: c0000000003692e0: locked_inode_to_wb_and_lock_list+0x50/0x290
    lr: c00000000036cb6c: writeback_sb_inodes+0x30c/0x590
    sp: c0000000fb65f8a0
   msr: 800000010280b033
   dar: 0
 dsisr: 40000000
  current = 0xc0000001d69be400
  paca    = 0xc000000003480000   softe: 0        irq_happened: 0x01
    pid   = 18689, comm = kworker/u16:10

Fix the problem by grabbing reference to bdi on first open of the block
device and drop the reference only once the inode is evicted from
memory. This pins struct backing_dev_info in memory and thus fixes the
crashes.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reported-and-tested-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-core.c   | 8 +++-----
 fs/block_dev.c     | 7 +++++++
 include/linux/fs.h | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 545ccb4b96f3..84fabb51714a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -109,14 +109,12 @@ void blk_queue_congestion_threshold(struct request_queue *q)
  * @bdev:	device
  *
  * Locates the passed device's request queue and returns the address of its
- * backing_dev_info.  This function can only be called if @bdev is opened
- * and the return value is never NULL.
+ * backing_dev_info. The return value is never NULL however we may return
+ * &noop_backing_dev_info if the bdev is not currently open.
  */
 struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	return q->backing_dev_info;
+	return bdev->bd_bdi;
 }
 EXPORT_SYMBOL(blk_get_backing_dev_info);
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index ed6a34be7a1e..601b71b76d7f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -884,6 +884,8 @@ static void bdev_evict_inode(struct inode *inode)
 	spin_lock(&bdev_lock);
 	list_del_init(&bdev->bd_list);
 	spin_unlock(&bdev_lock);
+	if (bdev->bd_bdi != &noop_backing_dev_info)
+		bdi_put(bdev->bd_bdi);
 }
 
 static const struct super_operations bdev_sops = {
@@ -986,6 +988,7 @@ struct block_device *bdget(dev_t dev)
 		bdev->bd_contains = NULL;
 		bdev->bd_super = NULL;
 		bdev->bd_inode = inode;
+		bdev->bd_bdi = &noop_backing_dev_info;
 		bdev->bd_block_size = (1 << inode->i_blkbits);
 		bdev->bd_part_count = 0;
 		bdev->bd_invalidated = 0;
@@ -1542,6 +1545,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		bdev->bd_disk = disk;
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
+		if (bdev->bd_bdi == &noop_backing_dev_info)
+			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 
 		if (!partno) {
 			ret = -ENXIO;
@@ -1637,6 +1642,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	bdev->bd_disk = NULL;
 	bdev->bd_part = NULL;
 	bdev->bd_queue = NULL;
+	bdi_put(bdev->bd_bdi);
+	bdev->bd_bdi = &noop_backing_dev_info;
 	if (bdev != bdev->bd_contains)
 		__blkdev_put(bdev->bd_contains, mode, 1);
 	bdev->bd_contains = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 702cb6c50194..c930cbc19342 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -423,6 +423,7 @@ struct block_device {
 	int			bd_invalidated;
 	struct gendisk *	bd_disk;
 	struct request_queue *  bd_queue;
+	struct backing_dev_info *bd_bdi;
 	struct list_head	bd_list;
 	/*
 	 * Private data.  You must have bd_claim'ed the block_device
-- 
2.10.2
