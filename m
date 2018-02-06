Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6/6] blockdev: Avoid two active bdev inodes for one device
Date: Tue,  6 Feb 2018 17:05:29 +0100
Message-Id: <20180206160529.20713-7-jack@suse.cz>
In-Reply-To: <20180206160529.20713-1-jack@suse.cz>
References: <20180206160529.20713-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When blkdev_open() races with device removal and creation it can happen
that unhashed bdev inode gets associated with newly created gendisk
like:

CPU0					CPU1
blkdev_open()
  bdev = bd_acquire()
					del_gendisk()
					  bdev_unhash_inode(bdev);
					remove device
					create new device with the same number
  __blkdev_get()
    disk = get_gendisk()
      - gets reference to gendisk of the new device

Now another blkdev_open() will not find original 'bdev' as it got
unhashed, create a new one and associate it with the same 'disk' at
which point problems start as we have two independent page caches for
one device.

Fix the problem by verifying that the bdev inode didn't get unhashed
before we acquired gendisk reference. That way we make sure gendisk can
get associated only with visible bdev inodes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index fe41a76769fa..fe09ef9c21f3 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1058,6 +1058,27 @@ static int bd_prepare_to_claim(struct block_device *bdev,
 	return 0;
 }
 
+static struct gendisk *bdev_get_gendisk(struct block_device *bdev, int *partno)
+{
+	struct gendisk *disk = get_gendisk(bdev->bd_dev, partno);
+
+	if (!disk)
+		return NULL;
+	/*
+	 * Now that we hold gendisk reference we make sure bdev we looked up is
+	 * not stale. If it is, it means device got removed and created before
+	 * we looked up gendisk and we fail open in such case. Associating
+	 * unhashed bdev with newly created gendisk could lead to two bdevs
+	 * (and thus two independent caches) being associated with one device
+	 * which is bad.
+	 */
+	if (inode_unhashed(bdev->bd_inode)) {
+		put_disk_and_module(disk);
+		return NULL;
+	}
+	return disk;
+}
+
 /**
  * bd_start_claiming - start claiming a block device
  * @bdev: block device of interest
@@ -1094,7 +1115,7 @@ static struct block_device *bd_start_claiming(struct block_device *bdev,
 	 * @bdev might not have been initialized properly yet, look up
 	 * and grab the outer block device the hard way.
 	 */
-	disk = get_gendisk(bdev->bd_dev, &partno);
+	disk = bdev_get_gendisk(bdev, &partno);
 	if (!disk)
 		return ERR_PTR(-ENXIO);
 
@@ -1429,7 +1450,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
  restart:
 
 	ret = -ENXIO;
-	disk = get_gendisk(bdev->bd_dev, &partno);
+	disk = bdev_get_gendisk(bdev, &partno);
 	if (!disk)
 		goto out;
 
-- 
2.13.6
