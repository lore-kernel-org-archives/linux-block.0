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
Subject: [PATCH 04/13] block: Move bdi_unregister() to del_gendisk()
Date: Tue, 21 Feb 2017 18:09:49 +0100
Message-Id: <20170221170958.21845-5-jack@suse.cz>
In-Reply-To: <20170221170958.21845-1-jack@suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Commit 6cd18e711dd8 "block: destroy bdi before blockdev is
unregistered." moved bdi unregistration (at that time through
bdi_destroy()) from blk_release_queue() to blk_cleanup_queue() because
it needs to happen before blk_unregister_region() call in del_gendisk()
for MD. As much as it is fine for device registration / unregistration
purposes, it does not fit our needs wrt writeback code. For those we
will need bdi_unregister() to happen after bdev_unhash_inode() so that
we are sure bdev inode is destroyed or soon to be destroyed (as soon as
last inode reference is dropped and nobody should be holding bdev inode
reference for long at this point) because bdi_unregister() may block
waiting for bdev's inode i_wb reference to be dropped and that happens
only once bdev inode gets destroyed.

Also SCSI will free up the device number from sd_remove() called through
a maze of callbacks from device_del() in __scsi_remove_device() before
blk_cleanup_queue() and thus similar races as described in 6cd18e711dd8
can happen for SCSI as well as reported by Omar [1]. Moving
bdi_unregister() to del_gendisk() fixes these problems as well since
del_gendisk() gets called from sd_remove() before freeing the device
number.

This also makes device_add_disk() (calling bdi_register_owner()) more
symmetric with del_gendisk().

[1] http://marc.info/?l=linux-block&m=148554717109098&w=2

Tested-by: Lekshmi Pillai <lekshmicpillai@in.ibm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-core.c | 2 --
 block/genhd.c    | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 47104f6a398b..9a901dcfdd5c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -580,8 +580,6 @@ void blk_cleanup_queue(struct request_queue *q)
 		q->queue_lock = &q->__queue_lock;
 	spin_unlock_irq(lock);
 
-	bdi_unregister(q->backing_dev_info);
-
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
 }
diff --git a/block/genhd.c b/block/genhd.c
index f6c4d4400759..68c613edb93a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -660,6 +660,13 @@ void del_gendisk(struct gendisk *disk)
 	disk->flags &= ~GENHD_FL_UP;
 
 	sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
+	/*
+	 * Unregister bdi before releasing device numbers (as they can get
+	 * reused and we'd get clashes in sysfs) but after bdev inodes are
+	 * unhashed and thus will be soon destroyed as bdev inode's reference
+	 * to wb_writeback can block bdi_unregister().
+	 */
+	bdi_unregister(disk->queue->backing_dev_info);
 	blk_unregister_queue(disk);
 	blk_unregister_region(disk_devt(disk), disk->minors);
 
-- 
2.10.2
