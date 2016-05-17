Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: linux-block@vger.kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	"Jens Axboe" <axboe@fb.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	"Dan Williams" <dan.j.williams@intel.com>,
	"Jeff Moyer" <jmoyer@redhat.com>,
	"Stephen Bates" <stephen.bates@microsemi.com>,
	"Keith Busch" <keith.busch@intel.com>,
	"Christoph Hellwig" <hch@infradead.org>,
	"Robert Elliott" <elliott@hpe.com>
Subject: [PATCH] block: Fix S_DAX inode flag locking
Date: Tue, 17 May 2016 12:29:57 -0600
Message-Id: <1463509797-10324-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1463509797-10324-1-git-send-email-jonathan.derrick@intel.com>
References: <1463509797-10324-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

This patch fixes S_DAX bd_inode i_flag locking to conform to suggested
locking rules. It is presumed that S_DAX is the only valid inode flag
for a block device which subscribes to direct-access, and will restore
any previously set flags if direct-access initialization fails.

This reverts to i_flags behavior prior to
bbab37ddc20bae4709bca8745c128c4f46fe63c5
by allowing other bd_inode flags when DAX is disabled

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 fs/block_dev.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 20a2c02..d41e37f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1159,6 +1159,20 @@ void bd_set_size(struct block_device *bdev, loff_t size)
 }
 EXPORT_SYMBOL(bd_set_size);
 
+static void bd_add_dax(struct inode *inode)
+{
+	inode_lock(inode);
+	inode->i_flags |= S_DAX;
+	inode_unlock(inode);
+}
+
+static void bd_clear_dax(struct inode *inode)
+{
+	inode_lock(inode);
+	inode->i_flags &= ~S_DAX;
+	inode_unlock(inode);
+}
+
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
 /*
@@ -1172,6 +1186,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 {
 	struct gendisk *disk;
 	struct module *owner;
+	struct inode *inode;
 	int ret;
 	int partno;
 	int perm = 0;
@@ -1198,6 +1213,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	if (!disk)
 		goto out;
 	owner = disk->fops->owner;
+	inode = bdev->bd_inode;
 
 	disk_block_events(disk);
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
@@ -1206,9 +1222,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
 		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
-			bdev->bd_inode->i_flags = S_DAX;
-		else
-			bdev->bd_inode->i_flags = 0;
+			bd_add_dax(inode);
 
 		if (!partno) {
 			ret = -ENXIO;
@@ -1228,6 +1242,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 					bdev->bd_part = NULL;
 					bdev->bd_disk = NULL;
 					bdev->bd_queue = NULL;
+					bd_clear_dax(inode);
 					mutex_unlock(&bdev->bd_mutex);
 					disk_unblock_events(disk);
 					put_disk(disk);
@@ -1239,7 +1254,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			if (!ret) {
 				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
 				if (!blkdev_dax_capable(bdev))
-					bdev->bd_inode->i_flags &= ~S_DAX;
+					bd_clear_dax(inode);
 			}
 
 			/*
@@ -1276,7 +1291,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			}
 			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
 			if (!blkdev_dax_capable(bdev))
-				bdev->bd_inode->i_flags &= ~S_DAX;
+				bd_clear_dax(inode);
 		}
 	} else {
 		if (bdev->bd_contains == bdev) {
@@ -1297,6 +1312,11 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		put_disk(disk);
 		module_put(owner);
 	}
+	inode_lock(inode);
+	if (inode->i_flags & S_DAX)
+		inode->i_flags = S_DAX;
+	inode_unlock(inode);
+
 	bdev->bd_openers++;
 	if (for_part)
 		bdev->bd_part_count++;
@@ -1309,6 +1329,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	bdev->bd_disk = NULL;
 	bdev->bd_part = NULL;
 	bdev->bd_queue = NULL;
+	bd_clear_dax(inode);
 	if (bdev != bdev->bd_contains)
 		__blkdev_put(bdev->bd_contains, mode, 1);
 	bdev->bd_contains = NULL;
-- 
1.8.3.1

