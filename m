Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 08/10] block: Fix oops in locked_inode_to_wb_and_lock_list()
Date: Thu,  9 Feb 2017 13:44:31 +0100
Message-Id: <20170209124433.2626-9-jack@suse.cz>
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When block device is closed, we call inode_detach_wb() in __blkdev_put()
which sets inode->i_wb to NULL. That is contrary to expectations that
inode->i_wb stays valid once set during the whole inode's lifetime and
leads to oops in wb_get() in locked_inode_to_wb_and_lock_list() because
inode_to_wb() returned NULL.

The reason why we called inode_detach_wb() is not valid anymore though.
BDI is guaranteed to stay along until we call bdi_put() from
bdev_evict_inode() so we can postpone calling inode_detach_wb() to that
moment. A complication is that i_wb can point to non-root wb_writeback
structure and in that case we do need to clean it up as bdi_unregister()
blocks waiting for all non-root wb_writeback references to get dropped.
Thus this i_wb reference could block device removal e.g. from
__scsi_remove_device() (which indirectly ends up calling
bdi_unregister()). We cannot rely on block device inode to go away soon
(and thus i_wb reference to get dropped) as the device may got
hot-removed e.g. under a mounted filesystem. We deal with these issues
by switching block device inode from non-root wb_writeback structure to
bdi->wb when needed.  Since this is rather expensive (requires
synchronize_rcu()) we do the switching only in del_gendisk() when we
know the device is going away.

Also add a warning to catch if someone uses inode_detach_wb() in a
dangerous way.

Reported-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c             |  4 ++--
 fs/block_dev.c            | 11 ++++-------
 include/linux/fs.h        |  2 +-
 include/linux/writeback.h |  1 +
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 68c613edb93a..721921a140cc 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -649,13 +649,13 @@ void del_gendisk(struct gendisk *disk)
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
 		invalidate_partition(disk, part->partno);
-		bdev_unhash_inode(part_devt(part));
+		bdev_cleanup_inode(part_devt(part));
 		delete_partition(disk, part->partno);
 	}
 	disk_part_iter_exit(&piter);
 
 	invalidate_partition(disk, 0);
-	bdev_unhash_inode(disk_devt(disk));
+	bdev_cleanup_inode(disk_devt(disk));
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 360439373a66..65ac3a60ac8e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -884,6 +884,8 @@ static void bdev_evict_inode(struct inode *inode)
 	spin_lock(&bdev_lock);
 	list_del_init(&bdev->bd_list);
 	spin_unlock(&bdev_lock);
+	/* Detach inode from wb early as bdi_put() may free bdi->wb */
+	inode_detach_wb(inode);
 	if (bdev->bd_bdi != &noop_backing_dev_info)
 		bdi_put(bdev->bd_bdi);
 }
@@ -960,13 +962,14 @@ static LIST_HEAD(all_bdevs);
  * If there is a bdev inode for this device, unhash it so that it gets evicted
  * as soon as last inode reference is dropped.
  */
-void bdev_unhash_inode(dev_t dev)
+void bdev_cleanup_inode(dev_t dev)
 {
 	struct inode *inode;
 
 	inode = ilookup5(blockdev_superblock, hash(dev), bdev_test, &dev);
 	if (inode) {
 		remove_inode_hash(inode);
+		inode_switch_to_default_wb_sync(inode);
 		iput(inode);
 	}
 }
@@ -1874,12 +1877,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 		kill_bdev(bdev);
 
 		bdev_write_inode(bdev);
-		/*
-		 * Detaching bdev inode from its wb in __destroy_inode()
-		 * is too late: the queue which embeds its bdi (along with
-		 * root wb) can be gone as soon as we put_disk() below.
-		 */
-		inode_detach_wb(bdev->bd_inode);
 	}
 	if (bdev->bd_contains == bdev) {
 		if (disk->fops->release)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 319fb76f9081..f8c86b9c31d5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2344,7 +2344,7 @@ extern struct kmem_cache *names_cachep;
 #ifdef CONFIG_BLOCK
 extern int register_blkdev(unsigned int, const char *);
 extern void unregister_blkdev(unsigned int, const char *);
-extern void bdev_unhash_inode(dev_t dev);
+extern void bdev_cleanup_inode(dev_t dev);
 extern struct block_device *bdget(dev_t);
 extern struct block_device *bdgrab(struct block_device *bdev);
 extern void bd_set_size(struct block_device *, loff_t size);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 0d3ba83a0f7f..6d27b78c9a79 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -237,6 +237,7 @@ static inline void inode_attach_wb(struct inode *inode, struct page *page)
 static inline void inode_detach_wb(struct inode *inode)
 {
 	if (inode->i_wb) {
+		WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
 		wb_put(inode->i_wb);
 		inode->i_wb = NULL;
 	}
-- 
2.10.2
