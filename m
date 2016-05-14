Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60633 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbcENAEa (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 13 May 2016 20:04:30 -0400
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
Subject: [RFCv2 3/3] block: Introduce S_HIPRI inode flag
Date: Fri, 13 May 2016 18:02:48 -0600
Message-Id: <1463184168-3381-4-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

S_HIPRI is a hint that indicates the file (currently only block devices)
is a high priority file. This hint allows direct-io to the block device
to poll for completions if polling is available to the block device.

The motivation for this patch comes from tiered caching solutions. A
user may wish to have low-latency block devices act as a cache for
higher-latency storage media.

With the introduction of block polling, polling could be enabled on a
queue of a block device. The preadv2/pwritev2 sets allowed a user to
specify per-io polling, but removed the ability to poll per-queue.

Instead of having a user modify their software to use preadv2/pwritev2,
this patch allows a user to set S_HIPRI on a block device file to request
all direct-io for this file to be polled.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/ioctl.c           | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/block_dev.c          |  3 +++
 include/linux/fs.h      |  2 ++
 include/uapi/linux/fs.h |  2 ++
 4 files changed, 50 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 4ff1f92..1b50fef 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -520,6 +520,45 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
+static int blkdev_hipriget(struct block_device *bdev)
+{
+	return !!(bdev->bd_inode->i_flags & S_HIPRI);
+}
+
+static int blkdev_hipriset(struct block_device *bdev, fmode_t mode,
+		int __user *argp)
+{
+	int n;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (!argp)
+		return -EINVAL;
+	if (get_user(n, argp))
+		return -EFAULT;
+
+	n = !!n;
+	if (n == blkdev_hipriget(bdev))
+		return 0;
+
+	if (!(mode & FMODE_EXCL)) {
+		bdgrab(bdev);
+		if (blkdev_get(bdev, mode | FMODE_EXCL, &bdev) < 0)
+			return -EBUSY;
+	}
+
+	inode_lock(bdev->bd_inode);
+	if (n)
+		bdev->bd_inode->i_flags |= S_HIPRI;
+	else
+		bdev->bd_inode->i_flags &= ~S_HIPRI;
+	inode_unlock(bdev->bd_inode);
+
+	if (!(mode & FMODE_EXCL))
+		blkdev_put(bdev, mode | FMODE_EXCL);
+	return 0;
+}
+
 /*
  * always keep this in sync with compat_blkdev_ioctl()
  */
@@ -601,6 +640,10 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKDAXGET:
 		return put_int(arg, !!(bdev->bd_inode->i_flags & S_DAX));
 		break;
+	case BLKHIPRISET:
+		return blkdev_hipriset(bdev, mode, argp);
+	case BLKHIPRIGET:
+		return put_int(arg, blkdev_hipriget(bdev));
 	case IOC_PR_REGISTER:
 		return blkdev_pr_register(bdev, argp);
 	case IOC_PR_RESERVE:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 252e459..ede8325 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -170,6 +170,9 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, loff_t offset)
 	if (IS_DAX(inode))
 		return dax_do_io(iocb, inode, iter, offset, blkdev_get_block,
 				NULL, DIO_SKIP_DIO_COUNT);
+
+	if (IS_HIPRI(inode))
+		iocb->ki_flags |= IOCB_HIPRI;
 	return __blockdev_direct_IO(iocb, inode, I_BDEV(inode), iter, offset,
 				    blkdev_get_block, NULL, NULL,
 				    DIO_SKIP_DIO_COUNT);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 70e61b5..8ae39ea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1788,6 +1788,7 @@ struct super_operations {
 #else
 #define S_DAX		0	/* Make all the DAX code disappear */
 #endif
+#define S_HIPRI		16384	/* IO for this file has high priority */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -1826,6 +1827,7 @@ struct super_operations {
 #define IS_AUTOMOUNT(inode)	((inode)->i_flags & S_AUTOMOUNT)
 #define IS_NOSEC(inode)		((inode)->i_flags & S_NOSEC)
 #define IS_DAX(inode)		((inode)->i_flags & S_DAX)
+#define IS_HIPRI(inode)		((inode)->i_flags & S_HIPRI)
 
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index a079d50..d6e262c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -223,6 +223,8 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKDAXGET _IO(0x12,129)
+#define BLKHIPRISET _IOW(0x12,130,int)
+#define BLKHIPRIGET _IO(0x12,131)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
-- 
1.8.3.1

