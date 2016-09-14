Return-Path: <BATV+6a0d0451059a4bcd7d0f+4770+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	ross.zwisler@linux.intel.com
Cc: linux-nvdimm@ml01.01.org,
	linux-block@vger.kernel.org
Subject: [PATCH] block_dev: remove DAX leftovers
Date: Wed, 14 Sep 2016 11:56:13 +0200
Message-Id: <1473846973-18798-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

DAX support for block devices was removed in commits 03cdad
("block: disable block device DAX by default") and 99a01cd
("block: remove BLK_DEV_DAX config option"), but we still kept a call to
dax_do_io and some uneeded i_flags manipulations introduced in commit
bbab37 ("block: Add support for DAX reads/writes to block devices").

Remove those leftovers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c3cdde8..45f5491 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -180,9 +180,6 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = bdev_file_inode(file);
 
-	if (IS_DAX(inode))
-		return dax_do_io(iocb, inode, iter, blkdev_get_block,
-				NULL, DIO_SKIP_DIO_COUNT);
 	return __blockdev_direct_IO(iocb, inode, I_BDEV(inode), iter,
 				    blkdev_get_block, NULL, NULL,
 				    DIO_SKIP_DIO_COUNT);
@@ -1274,7 +1271,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		bdev->bd_disk = disk;
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
-		bdev->bd_inode->i_flags = 0;
 
 		if (!partno) {
 			ret = -ENXIO;
@@ -1302,11 +1298,8 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 				}
 			}
 
-			if (!ret) {
+			if (!ret)
 				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
-				if (!bdev_dax_capable(bdev))
-					bdev->bd_inode->i_flags &= ~S_DAX;
-			}
 
 			/*
 			 * If the device is invalidated, rescan partition
@@ -1341,8 +1334,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 				goto out_clear;
 			}
 			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
-			if (!bdev_dax_capable(bdev))
-				bdev->bd_inode->i_flags &= ~S_DAX;
 		}
 	} else {
 		if (bdev->bd_contains == bdev) {
-- 
2.1.4
