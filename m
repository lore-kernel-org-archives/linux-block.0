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
Subject: [PATCH 03/10] block: Revalidate i_bdev reference in bd_aquire()
Date: Thu,  9 Feb 2017 13:44:26 +0100
Message-Id: <20170209124433.2626-4-jack@suse.cz>
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
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

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 601b71b76d7f..360439373a66 100644
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
+		bd_forget(bdev);
+
 	bdev = bdget(inode->i_rdev);
 	if (bdev) {
 		spin_lock(&bdev_lock);
-- 
2.10.2
