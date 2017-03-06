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
Subject: [PATCH 09/11] block: Fix oops in locked_inode_to_wb_and_lock_list()
Date: Mon,  6 Mar 2017 17:34:02 +0100
Message-Id: <20170306163404.1238-10-jack@suse.cz>
In-Reply-To: <20170306163404.1238-1-jack@suse.cz>
References: <20170306163404.1238-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When block device is closed, we call inode_detach_wb() in __blkdev_put()
which sets inode->i_wb to NULL. That is contrary to expectations that
inode->i_wb stays valid once set during the whole inode's lifetime and
leads to oops in wb_get() in locked_inode_to_wb_and_lock_list() because
inode_to_wb() returned NULL.

The reason why we called inode_detach_wb() is not valid anymore though.
BDI is guaranteed to stay along until we call bdi_put() from
bdev_evict_inode() so we can postpone calling inode_detach_wb() to that
moment.

Also add a warning to catch if someone uses inode_detach_wb() in a
dangerous way.

Reported-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c            | 8 ++------
 include/linux/writeback.h | 1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e1993a2827f..4b8a0f871f2d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -885,6 +885,8 @@ static void bdev_evict_inode(struct inode *inode)
 	spin_lock(&bdev_lock);
 	list_del_init(&bdev->bd_list);
 	spin_unlock(&bdev_lock);
+	/* Detach inode from wb early as bdi_put() may free bdi->wb */
+	inode_detach_wb(inode);
 	if (bdev->bd_bdi != &noop_backing_dev_info) {
 		bdi_put(bdev->bd_bdi);
 		bdev->bd_bdi = &noop_backing_dev_info;
@@ -1878,12 +1880,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
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
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a3c0cbd7c888..d5815794416c 100644
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
