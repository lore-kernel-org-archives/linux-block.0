Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5/5] block: Get rid of blk_get_backing_dev_info()
Date: Thu,  2 Feb 2017 15:56:53 +0100
Message-Id: <20170202145653.19614-6-jack@suse.cz>
In-Reply-To: <20170202145653.19614-1-jack@suse.cz>
References: <20170202145653.19614-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

blk_get_backing_dev_info() is now a simple dereference. Remove that
function and simplify some code around that.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-core.c            | 14 --------------
 block/compat_ioctl.c        |  7 ++-----
 block/ioctl.c               |  7 ++-----
 fs/btrfs/disk-io.c          |  2 +-
 fs/btrfs/volumes.c          |  2 +-
 fs/xfs/xfs_buf.c            |  3 +--
 fs/xfs/xfs_buf.h            |  1 -
 include/linux/backing-dev.h |  2 +-
 include/linux/blkdev.h      |  1 -
 9 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 84fabb51714a..47104f6a398b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -104,20 +104,6 @@ void blk_queue_congestion_threshold(struct request_queue *q)
 	q->nr_congestion_off = nr;
 }
 
-/**
- * blk_get_backing_dev_info - get the address of a queue's backing_dev_info
- * @bdev:	device
- *
- * Locates the passed device's request queue and returns the address of its
- * backing_dev_info. The return value is never NULL however we may return
- * &noop_backing_dev_info if the bdev is not currently open.
- */
-struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev)
-{
-	return bdev->bd_bdi;
-}
-EXPORT_SYMBOL(blk_get_backing_dev_info);
-
 void blk_rq_init(struct request_queue *q, struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 556826ac7cb4..570021a0dc1c 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -661,7 +661,6 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	struct block_device *bdev = inode->i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
 	fmode_t mode = file->f_mode;
-	struct backing_dev_info *bdi;
 	loff_t size;
 	unsigned int max_sectors;
 
@@ -708,9 +707,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKFRAGET:
 		if (!arg)
 			return -EINVAL;
-		bdi = blk_get_backing_dev_info(bdev);
 		return compat_put_long(arg,
-				       (bdi->ra_pages * PAGE_SIZE) / 512);
+			       (bdev->bd_bdi->ra_pages * PAGE_SIZE) / 512);
 	case BLKROGET: /* compatible */
 		return compat_put_int(arg, bdev_read_only(bdev) != 0);
 	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
@@ -728,8 +726,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKFRASET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		bdi = blk_get_backing_dev_info(bdev);
-		bdi->ra_pages = (arg * 512) / PAGE_SIZE;
+		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
 		return 0;
 	case BLKGETSIZE:
 		size = i_size_read(bdev->bd_inode);
diff --git a/block/ioctl.c b/block/ioctl.c
index be7f4de3eb3c..7b88820b93d9 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -505,7 +505,6 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 			unsigned long arg)
 {
-	struct backing_dev_info *bdi;
 	void __user *argp = (void __user *)arg;
 	loff_t size;
 	unsigned int max_sectors;
@@ -532,8 +531,7 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKFRAGET:
 		if (!arg)
 			return -EINVAL;
-		bdi = blk_get_backing_dev_info(bdev);
-		return put_long(arg, (bdi->ra_pages * PAGE_SIZE) / 512);
+		return put_long(arg, (bdev->bd_bdi->ra_pages*PAGE_SIZE) / 512);
 	case BLKROGET:
 		return put_int(arg, bdev_read_only(bdev) != 0);
 	case BLKBSZGET: /* get block device soft block size (cf. BLKSSZGET) */
@@ -560,8 +558,7 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKFRASET:
 		if(!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-		bdi = blk_get_backing_dev_info(bdev);
-		bdi->ra_pages = (arg * 512) / PAGE_SIZE;
+		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
 		return 0;
 	case BLKBSZSET:
 		return blkdev_bszset(bdev, mode, argp);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 18004169552c..37a31b12bb0c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1800,7 +1800,7 @@ static int btrfs_congested_fn(void *congested_data, int bdi_bits)
 	list_for_each_entry_rcu(device, &info->fs_devices->devices, dev_list) {
 		if (!device->bdev)
 			continue;
-		bdi = blk_get_backing_dev_info(device->bdev);
+		bdi = device->bdev->bd_bdi;
 		if (bdi_congested(bdi, bdi_bits)) {
 			ret = 1;
 			break;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3c3c69c0eee4..b2e70073a10d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -366,7 +366,7 @@ static noinline void run_scheduled_bios(struct btrfs_device *device)
 	 */
 	blk_start_plug(&plug);
 
-	bdi = blk_get_backing_dev_info(device->bdev);
+	bdi = device->bdev->bd_bdi;
 	limit = btrfs_async_submit_limit(fs_info);
 	limit = limit * 2 / 3;
 
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 7f0a01f7b592..8bbec20aa138 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -757,7 +757,7 @@ xfs_buf_readahead_map(
 	int			nmaps,
 	const struct xfs_buf_ops *ops)
 {
-	if (bdi_read_congested(target->bt_bdi))
+	if (bdi_read_congested(target->bt_bdev->bd_bdi))
 		return;
 
 	xfs_buf_read_map(target, map, nmaps,
@@ -1790,7 +1790,6 @@ xfs_alloc_buftarg(
 	btp->bt_mount = mp;
 	btp->bt_dev =  bdev->bd_dev;
 	btp->bt_bdev = bdev;
-	btp->bt_bdi = blk_get_backing_dev_info(bdev);
 
 	if (xfs_setsize_buftarg_early(btp, bdev))
 		goto error;
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 8a9d3a9599f0..3c867e5a63e1 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -109,7 +109,6 @@ typedef unsigned int xfs_buf_flags_t;
 typedef struct xfs_buftarg {
 	dev_t			bt_dev;
 	struct block_device	*bt_bdev;
-	struct backing_dev_info	*bt_bdi;
 	struct xfs_mount	*bt_mount;
 	unsigned int		bt_meta_sectorsize;
 	size_t			bt_meta_sectormask;
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index efb6ca992d05..c52a48cb9a66 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -191,7 +191,7 @@ static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
 	sb = inode->i_sb;
 #ifdef CONFIG_BLOCK
 	if (sb_is_blkdev_sb(sb))
-		return blk_get_backing_dev_info(I_BDEV(inode));
+		return I_BDEV(inode)->bd_bdi;
 #endif
 	return sb->s_bdi;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index de85701cc699..84d367bee0a5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1166,7 +1166,6 @@ extern void blk_queue_rq_timed_out(struct request_queue *, rq_timed_out_fn *);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
-extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 
 static inline unsigned short blk_rq_nr_phys_segments(struct request *rq)
 {
-- 
2.10.2
