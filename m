Return-Path: <gerald.schaefer@de.ibm.com>
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH] brd: fix uninitialized use of brd->dax_dev
Date: Wed,  3 May 2017 14:56:02 +0200
Message-Id: <20170503125602.26956-1-gerald.schaefer@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

commit 1647b9b9 "brd: add dax_operations support" introduced the allocation
and freeing of a dax_device, but the allocated dax_device is not stored
into the brd_device, so brd_del_one() will eventually operate on an
uninitialized brd->dax_dev.

Fix this by storing the allocated dax_device to brd->dax_dev.

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
---
 drivers/block/brd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 38f38df..57b574f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -404,9 +404,7 @@ static struct brd_device *brd_alloc(int i)
 {
 	struct brd_device *brd;
 	struct gendisk *disk;
-#ifdef CONFIG_BLK_DEV_RAM_DAX
-	struct dax_device *dax_dev;
-#endif
+
 	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
 	if (!brd)
 		goto out;
@@ -443,8 +441,8 @@ static struct brd_device *brd_alloc(int i)
 
 #ifdef CONFIG_BLK_DEV_RAM_DAX
 	queue_flag_set_unlocked(QUEUE_FLAG_DAX, brd->brd_queue);
-	dax_dev = alloc_dax(brd, disk->disk_name, &brd_dax_ops);
-	if (!dax_dev)
+	brd->dax_dev = alloc_dax(brd, disk->disk_name, &brd_dax_ops);
+	if (!brd->dax_dev)
 		goto out_free_inode;
 #endif
 
@@ -453,8 +451,8 @@ static struct brd_device *brd_alloc(int i)
 
 #ifdef CONFIG_BLK_DEV_RAM_DAX
 out_free_inode:
-	kill_dax(dax_dev);
-	put_dax(dax_dev);
+	kill_dax(brd->dax_dev);
+	put_dax(brd->dax_dev);
 #endif
 out_free_queue:
 	blk_cleanup_queue(brd->brd_queue);
-- 
2.10.2
