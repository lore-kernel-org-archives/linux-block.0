Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Omar Sandoval <osandov@osandov.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Date: Mon,  6 Mar 2017 17:33:55 +0100
Message-Id: <20170306163404.1238-3-jack@suse.cz>
In-Reply-To: <20170306163404.1238-1-jack@suse.cz>
References: <20170306163404.1238-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

blkdev_open() may race with gendisk shutdown in such a way that
del_gendisk() has already unhashed block device inode (and thus
bd_acquire() will end up creating new block device inode) however
gen_gendisk() will still return the gendisk that is being destroyed.
This will result in the new bdev inode being associated with bdi of the
request queue that is going away and when the device number gets
eventually reused, the block device will still be pointing to the stale
bdi.

Fix the problem by checking whether the gendisk is still alive when
associating bdev inode with it and its bdi. That way we are sure that
once we are unhashing block device inodes in del_gendisk(), newly
created bdev inodes cannot be associated with bdi of the deleted gendisk
anymore. We actually already do this check when opening a partition so
we need to add it only for the case when the whole device is opened.

Also add a warning that will tell us about unexpected inconsistencies
between bdi associated with the bdev inode and bdi associated with the
disk.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c  | 7 ++++++-
 fs/block_dev.c | 5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b26a5ea115d0..e8df37de03af 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -662,6 +662,12 @@ void del_gendisk(struct gendisk *disk)
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
+	disk->flags &= ~GENHD_FL_UP;
+	/*
+	 * Make sure __blkdev_open() sees the disk is going away before
+	 * starting to unhash bdev inodes.
+	 */
+	smp_wmb();
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
@@ -678,7 +684,6 @@ void del_gendisk(struct gendisk *disk)
 	invalidate_partition(disk, 0);
 	bdev_unhash_inode(disk_devt(disk));
 	set_capacity(disk, 0);
-	disk->flags &= ~GENHD_FL_UP;
 
 	sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
 	/*
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 53e2389ae4d4..9e1993a2827f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1560,7 +1560,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		if (!partno) {
 			ret = -ENXIO;
 			bdev->bd_part = disk_get_part(disk, partno);
-			if (!bdev->bd_part)
+			if (!(disk->flags & GENHD_FL_UP) || !bdev->bd_part)
 				goto out_clear;
 
 			ret = 0;
@@ -1623,6 +1623,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 
 		if (bdev->bd_bdi == &noop_backing_dev_info)
 			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
+		else
+			WARN_ON_ONCE(bdev->bd_bdi !=
+				     disk->queue->backing_dev_info);
 	} else {
 		if (bdev->bd_contains == bdev) {
 			ret = 0;
-- 
2.10.2
