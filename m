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
Subject: [PATCH 03/13] block: Revalidate i_bdev reference in bd_aquire()
Date: Tue, 21 Feb 2017 18:09:48 +0100
Message-Id: <20170221170958.21845-4-jack@suse.cz>
In-Reply-To: <20170221170958.21845-1-jack@suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When a device gets removed, block device inode unhashed so that it is not
used anymore (bdget() will not find it anymore). Later when a new device
gets created with the same device number, we create new block device
inode. However there may be file system device inodes whose i_bdev still
points to the original block device inode and thus we get two active
block device inodes for the same device. They will share the same
gendisk so the only visible differences will be that page caches will
not be coherent and BDIs will be different (the old block device inode
still points to unregistered BDI).

Fix the problem by checking in bd_acquire() whether i_bdev still points
to active block device inode and re-lookup the block device if not. That
way any open of a block device happening after the old device has been
removed will get correct block device inode.

Tested-by: Lekshmi Pillai <lekshmicpillai@in.ibm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 601b71b76d7f..68e855fdce58 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1043,13 +1043,22 @@ static struct block_device *bd_acquire(struct inode *inode)
 
 	spin_lock(&bdev_lock);
 	bdev = inode->i_bdev;
-	if (bdev) {
+	if (bdev && !inode_unhashed(bdev->bd_inode)) {
 		bdgrab(bdev);
 		spin_unlock(&bdev_lock);
 		return bdev;
 	}
 	spin_unlock(&bdev_lock);
 
+	/*
+	 * i_bdev references block device inode that was already shut down
+	 * (corresponding device got removed).  Remove the reference and look
+	 * up block device inode again just in case new device got
+	 * reestablished under the same device number.
+	 */
+	if (bdev)
+		bd_forget(inode);
+
 	bdev = bdget(inode->i_rdev);
 	if (bdev) {
 		spin_lock(&bdev_lock);
-- 
2.10.2
