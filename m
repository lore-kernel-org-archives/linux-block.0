Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4/6] genhd: Fix use after free in __blkdev_get()
Date: Tue,  6 Feb 2018 17:05:27 +0100
Message-Id: <20180206160529.20713-5-jack@suse.cz>
In-Reply-To: <20180206160529.20713-1-jack@suse.cz>
References: <20180206160529.20713-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When two blkdev_open() calls race with device removal and recreation,
__blkdev_get() can use looked up gendisk after it is freed:

CPU0				CPU1			CPU2
							del_gendisk(disk);
							  bdev_unhash_inode(inode);
blkdev_open()			blkdev_open()
  bdev = bd_acquire(inode);
    - creates and returns new inode
				  bdev = bd_acquire(inode);
				    - returns the same inode
  __blkdev_get(devt)		  __blkdev_get(devt)
    disk = get_gendisk(devt);
      - got structure of device going away
							<finish device removal>
							<new device gets
							 created under the same
							 device number>
				  disk = get_gendisk(devt);
				    - got new device structure
				  if (!bdev->bd_openers) {
				    does the first open
				  }
    if (!bdev->bd_openers)
      - false
    } else {
      put_disk_and_module(disk)
        - remember this was old device - this was last ref and disk is
          now freed
    }
    disk_unblock_events(disk); -> oops

Fix the problem by making sure we drop reference to disk in
__blkdev_get() only after we are really done with it.

Reported-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 1dbbf847911a..fe41a76769fa 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1409,6 +1409,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	int ret;
 	int partno;
 	int perm = 0;
+	bool first_open = false;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1435,6 +1436,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	disk_block_events(disk);
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
 	if (!bdev->bd_openers) {
+		first_open = true;
 		bdev->bd_disk = disk;
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
@@ -1520,14 +1522,15 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			if (ret)
 				goto out_unlock_bdev;
 		}
-		/* only one opener holds refs to the module and disk */
-		put_disk_and_module(disk);
 	}
 	bdev->bd_openers++;
 	if (for_part)
 		bdev->bd_part_count++;
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
+	/* only one opener holds refs to the module and disk */
+	if (!first_open)
+		put_disk_and_module(disk);
 	return 0;
 
  out_clear:
-- 
2.13.6
