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
Subject: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Date: Mon, 13 Mar 2017 16:14:01 +0100
Message-Id: <20170313151410.5586-3-jack@suse.cz>
In-Reply-To: <20170313151410.5586-1-jack@suse.cz>
References: <20170313151410.5586-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

blkdev_open() may race with gendisk shutdown in two different ways.
Either del_gendisk() has already unhashed block device inode (and thus
bd_acquire() will end up creating new block device inode) however
gen_gendisk() will still return the gendisk that is being destroyed.
Or bdev returned by bd_acquire() will get unhashed and gendisk destroyed
before we get to get_gendisk() and get_gendisk() will return new gendisk
that got allocated for device that reused the device number.

In both cases this will result in possible inconsistencies between
bdev->bd_disk and bdev->bd_bdi (in the first case after gendisk gets
destroyed and device number reused, in the second case immediately).

Fix the problem by checking whether the gendisk is still alive and inode
hashed when associating bdev inode with it and its bdi. That way we are
sure that we will not associate bdev inode with disk that got past
blk_unregister_region() in del_gendisk() (and thus device number can get
reused). Similarly, we will not associate bdev that was once associated
with gendisk that is going away (and thus the corresponding bdev inode
will get unhashed in del_gendisk()) with a new gendisk that is just
reusing the device number.

Also add a warning that will tell us about unexpected inconsistencies
between bdi associated with the bdev inode and bdi associated with the
disk.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 53e2389ae4d4..5ec8750f5332 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1560,7 +1560,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		if (!partno) {
 			ret = -ENXIO;
 			bdev->bd_part = disk_get_part(disk, partno);
-			if (!bdev->bd_part)
+			if (!(disk->flags & GENHD_FL_UP) || !bdev->bd_part ||
+			    inode_unhashed(bdev->bd_inode))
 				goto out_clear;
 
 			ret = 0;
@@ -1614,7 +1615,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			bdev->bd_contains = whole;
 			bdev->bd_part = disk_get_part(disk, partno);
 			if (!(disk->flags & GENHD_FL_UP) ||
-			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
+			    !bdev->bd_part || !bdev->bd_part->nr_sects ||
+			    inode_unhashed(bdev->bd_inode)) {
 				ret = -ENXIO;
 				goto out_clear;
 			}
@@ -1623,6 +1625,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 
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
