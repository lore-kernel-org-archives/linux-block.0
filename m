Return-Path: <jack@suse.cz>
Date: Thu, 9 Feb 2017 16:48:11 +0100
From: Jan Kara <jack@suse.cz>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 0/10] block: Fix block device shutdown related races
Message-ID: <20170209154811.GC3009@quack2.suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
 <3243095.TlNvkxZ2GK@morokweng>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="QTprm0S8XgL7H0Dt"
In-Reply-To: <3243095.TlNvkxZ2GK@morokweng>
List-ID: <linux-block@vger.kernel.org>


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu 09-02-17 12:52:47, Thiago Jung Bauermann wrote:
> Hello Jan,
> 
> Am Donnerstag, 9. Februar 2017, 13:44:23 BRST schrieb Jan Kara:
> > People, please have a look at patches. The are mostly simple however the
> > interactions are rather complex so I may have missed something. Also I'm
> > happy for any additional testing these patches can get - I've stressed them
> > with Omar's script, tested memcg writeback, tested static (not udev managed)
> > device inodes.
> 
> Thank you for these fixes. I will have them tested and report back how it 
> goes.
> 
> Can you tell which branch I should apply them on? I tried a number of branches 
> in linux-block (and applied the bdi lifetime v3 patches if the branch didn't 
> already had them) but this series either didn't apply or the build failed 
> with:
> 
> /home/bauermann/trabalho/src/linux-2.6.git/fs/block_dev.c: In function 
> ‘bd_acquire’:
> /home/bauermann/trabalho/src/linux-2.6.git/fs/block_dev.c:1063:13: error: 
> passing argument 1 of ‘bd_forget’ from incompatible pointer type [-
> Werror=incompatible-pointer-types]
>    bd_forget(bdev);
>              ^
> In file included from /home/bauermann/trabalho/src/linux-2.6.git/include/
> linux/device_cgroup.h:1:0,
>                  from /home/bauermann/trabalho/src/linux-2.6.git/fs/
> block_dev.c:14:
> /home/bauermann/trabalho/src/linux-2.6.git/include/linux/fs.h:2351:13: note: 
> expected ‘struct inode *’ but argument is of type ‘struct block_device *’
>  extern void bd_forget(struct inode *inode);
>              ^
> cc1: some warnings being treated as errors

Indeed, I'm wondering how this could pass one of the tests I did... Hum.
Anyway thanks for spotting this and attached is a fixed up version of the
patch 3.

I've pushed out a branch with all BDI patches I have accumulated to

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdi

It includes filesystem-bdi cleanup patches as well on top of these fixes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--QTprm0S8XgL7H0Dt
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


--QTprm0S8XgL7H0Dt--
