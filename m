Return-Path: <jack@suse.cz>
Date: Thu, 9 Feb 2017 16:54:17 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 03/10] block: Revalidate i_bdev reference in bd_aquire()
Message-ID: <20170209155417.GA15818@quack2.suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
 <20170209124433.2626-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <20170209124433.2626-4-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 09-02-17 13:44:26, Jan Kara wrote:
> When a device gets removed, block device inode unhashed so that it is not
> used anymore (bdget() will not find it anymore). Later when a new device
> gets created with the same device number, we create new block device
> inode. However there may be file system device inodes whose i_bdev still
> points to the original block device inode and thus we get two active
> block device inodes for the same device. They will share the same
> gendisk so the only visible differences will be that page caches will
> not be coherent and BDIs will be different (the old block device inode
> still points to unregistered BDI).
> 
> Fix the problem by checking in bd_acquire() whether i_bdev still points
> to active block device inode and re-lookup the block device if not. That
> way any open of a block device happening after the old device has been
> removed will get correct block device inode.

Thiago spotted a stupid bug in this patch (calling bd_forget() on bdev
instead of inode). Fixed version is attached.

								Honza
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/block_dev.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 601b71b76d7f..360439373a66 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1043,13 +1043,22 @@ static struct block_device *bd_acquire(struct inode *inode)
>  
>  	spin_lock(&bdev_lock);
>  	bdev = inode->i_bdev;
> -	if (bdev) {
> +	if (bdev && !inode_unhashed(bdev->bd_inode)) {
>  		bdgrab(bdev);
>  		spin_unlock(&bdev_lock);
>  		return bdev;
>  	}
>  	spin_unlock(&bdev_lock);
>  
> +	/*
> +	 * i_bdev references block device inode that was already shut down
> +	 * (corresponding device got removed).  Remove the reference and look
> +	 * up block device inode again just in case new device got
> +	 * reestablished under the same device number.
> +	 */
> +	if (bdev)
> +		bd_forget(bdev);
> +
>  	bdev = bdget(inode->i_rdev);
>  	if (bdev) {
>  		spin_lock(&bdev_lock);
> -- 
> 2.10.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--SLDf9lqlvOQaIe6s
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0003-block-Revalidate-i_bdev-reference-in-bd_aquire.patch"

>From aaf612333753b948a96aebe4a2f8066ed45ef164 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 9 Feb 2017 12:16:30 +0100
Subject: [PATCH 03/10] block: Revalidate i_bdev reference in bd_aquire()

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


--SLDf9lqlvOQaIe6s--
