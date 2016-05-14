Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60633 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116AbcENAE3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 13 May 2016 20:04:29 -0400
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
	linux-nvme@lists.infradead.org,
	"Christoph Hellwig" <hch@infradead.org>
Subject: [RFCv2 2/3] block: add helper for setting and clearing S_DAX on inode
Date: Fri, 13 May 2016 18:02:47 -0600
Message-Id: <1463184168-3381-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

inode->i_flags locking rules suggest using the i_mutex lock. This patch
adds a helper to do the locking and setting of S_DAX on the block device
inode.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 fs/block_dev.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d4fa725..252e459 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1159,6 +1159,18 @@ void bd_set_size(struct block_device *bdev, loff_t size)
 }
 EXPORT_SYMBOL(bd_set_size);
 
+static void bd_set_dax(struct block_device *bdev, bool enabled)
+{
+	struct inode *inode = bdev->bd_inode;
+
+	inode_lock(inode);
+	if (enabled)
+		inode->i_flags = S_DAX;
+	else
+		inode->i_flags &= ~S_DAX;
+	inode_unlock(inode);
+}
+
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
 /*
@@ -1206,9 +1218,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
 		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
-			bdev->bd_inode->i_flags = S_DAX;
+			bd_set_dax(bdev, 1);
 		else
-			bdev->bd_inode->i_flags &= ~S_DAX;
+			bd_set_dax(bdev, 0);
 
 		if (!partno) {
 			ret = -ENXIO;
@@ -1239,7 +1251,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			if (!ret) {
 				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
 				if (!blkdev_dax_capable(bdev))
-					bdev->bd_inode->i_flags &= ~S_DAX;
+					bd_set_dax(bdev, 0);
 			}
 
 			/*
@@ -1276,7 +1288,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			}
 			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
 			if (!blkdev_dax_capable(bdev))
-				bdev->bd_inode->i_flags &= ~S_DAX;
+				bd_set_dax(bdev, 0);
 		}
 	} else {
 		if (bdev->bd_contains == bdev) {
-- 
1.8.3.1

