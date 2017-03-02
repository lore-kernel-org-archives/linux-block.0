Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Initialize bd_bdi on inode initialization
Date: Thu,  2 Mar 2017 16:50:13 +0100
Message-Id: <20170302155013.550-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

So far we initialized bd_bdi only in bdget(). That is fine for normal
bdev inodes however for the special case of the root inode of
blockdev_superblock that function is never called and thus bd_bdi is
left uninitialized. As a result bdev_evict_inode() may oops doing
bdi_put(root->bd_bdi) on that inode as can be seen when doing:

mount -t bdev none /mnt

Fix the problem by initializing bd_bdi when first allocating the inode
and then reinitializing bd_bdi in bdev_evict_inode().

Thanks to syzkaller team for finding the problem.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: b1d2dc5659b41741f5a29b2ade76ffb4e5bb13d8
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 77c30f15a02c..2eca00ec4370 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -870,6 +870,7 @@ static void init_once(void *foo)
 #ifdef CONFIG_SYSFS
 	INIT_LIST_HEAD(&bdev->bd_holder_disks);
 #endif
+	bdev->bd_bdi = &noop_backing_dev_info;
 	inode_init_once(&ei->vfs_inode);
 	/* Initialize mutex for freeze. */
 	mutex_init(&bdev->bd_fsfreeze_mutex);
@@ -884,8 +885,10 @@ static void bdev_evict_inode(struct inode *inode)
 	spin_lock(&bdev_lock);
 	list_del_init(&bdev->bd_list);
 	spin_unlock(&bdev_lock);
-	if (bdev->bd_bdi != &noop_backing_dev_info)
+	if (bdev->bd_bdi != &noop_backing_dev_info) {
 		bdi_put(bdev->bd_bdi);
+		bdev->bd_bdi = &noop_backing_dev_info;
+	}
 }
 
 static const struct super_operations bdev_sops = {
@@ -988,7 +991,6 @@ struct block_device *bdget(dev_t dev)
 		bdev->bd_contains = NULL;
 		bdev->bd_super = NULL;
 		bdev->bd_inode = inode;
-		bdev->bd_bdi = &noop_backing_dev_info;
 		bdev->bd_block_size = i_blocksize(inode);
 		bdev->bd_part_count = 0;
 		bdev->bd_invalidated = 0;
-- 
2.10.2
