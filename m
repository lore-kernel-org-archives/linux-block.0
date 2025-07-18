Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E118E20
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866947; cv=none; b=D00TKKRXS4ejw05XUZ9yZXxWDxhj2yj5pUJSq3YPHPIMWDHGXKnU4IfIUpnEaw5fsG0LqrdYj6bO0aHSKq4cxytFHj6IG4sALec6Yn3lK0L1lK7wdPu153nAvn7OLploLaMpHj7t8+RHWTmWiBiKNz89bbMqqtLiL+KGKvs0EY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866947; c=relaxed/simple;
	bh=w8TFfPmwh3CFXA/a4xNIyoNkvsKKWIOKcEuhRq3nxk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgTct+j5XGuXSvcAvVdQpPJRFDdZH4PhbBFEgbGz5/jpXfhrT3xahivi8nZ7tinim0gJKLQUFuO/hEcYG467ANIG9mKdOMfqQFGrvKeafBXeDk9qOVsfp1Ihdfl0clvjaWKUmk0e9hGurzHZ7OxAu1t9uQaElgpGmxwzKIhlaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h+kv9jGg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h+kv9jGg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ibhB5k2nGD58BHK76zOX4KXEMeZsX6suWyBUk1IHYyc=; b=h+kv9jGgibBc/AErj80c0x0nzY
	cTBLcT8R03tR2M/GpsaPiyI3UXq9GBE3RtgQvdlWi6q7NVaN46Bdj2q0jewreikpaFMffWzkmk6V3
	DQZYZjyr0N3dKgsZcwwrnzKvNJccpVQf8DvaAmxZDYLWfGk6v3xevmc6bwKQ8OnJ8VDoCJ2saNuhR
	DeD/I/7sbAzUkHdgrqh/Da+zD8mJJ/oZmqUM6p6d1WhhvAwMERkrlp0fPPDA3lPPzh44FoxWwIozJ
	D7KVHujI6QvyPMxbgwAvM+V4KJwVfcgJWjEeUCyQ7w9cM+tkZQ7jpgbvWWnc6FkKVIaHklBIVJVfO
	xMcpEQZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucqlT-0000000DZAg-2amm;
	Fri, 18 Jul 2025 19:29:03 +0000
Date: Fri, 18 Jul 2025 20:29:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: [RFC][PATCH 3/3] block: switch ->getgeo() to struct gendisk
Message-ID: <20250718192903.GH2580412@ZenIV>
References: <20250718192642.GE2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718192642.GE2580412@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Instances are happier that way and it makes more sense anyway -
the only part of the result that is related to partition we are given
is the start sector, and that has been filled in by the caller.

Everything else is a function of the disk.  Only one instance
(DASD) is ever looking at anything other than bdev->bd_disk and
that one is trivial to adjust.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/locking.rst |  2 +-
 arch/m68k/emu/nfblock.c               |  4 ++--
 arch/um/drivers/ubd_kern.c            |  6 +++---
 block/ioctl.c                         |  4 ++--
 block/partitions/ibm.c                |  2 +-
 drivers/block/amiflop.c               | 10 +++++-----
 drivers/block/aoe/aoeblk.c            |  4 ++--
 drivers/block/floppy.c                |  4 ++--
 drivers/block/mtip32xx/mtip32xx.c     |  6 +++---
 drivers/block/rnbd/rnbd-clt.c         |  4 ++--
 drivers/block/sunvdc.c                |  3 +--
 drivers/block/swim.c                  |  4 ++--
 drivers/block/virtio_blk.c            |  6 +++---
 drivers/block/xen-blkfront.c          |  4 ++--
 drivers/md/dm.c                       |  4 ++--
 drivers/md/md.c                       |  4 ++--
 drivers/memstick/core/ms_block.c      |  4 ++--
 drivers/memstick/core/mspro_block.c   |  4 ++--
 drivers/mmc/core/block.c              |  4 ++--
 drivers/mtd/mtd_blkdevs.c             |  4 ++--
 drivers/mtd/ubi/block.c               |  4 ++--
 drivers/nvdimm/btt.c                  |  4 ++--
 drivers/nvme/host/core.c              |  4 ++--
 drivers/nvme/host/nvme.h              |  2 +-
 drivers/s390/block/dasd.c             |  7 ++++---
 drivers/scsi/sd.c                     |  8 ++++----
 include/linux/blkdev.h                |  2 +-
 27 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 2e567e341c3b..cb32ec9382ac 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -443,7 +443,7 @@ prototypes::
 	int (*direct_access) (struct block_device *, sector_t, void **,
 				unsigned long *);
 	void (*unlock_native_capacity) (struct gendisk *);
-	int (*getgeo)(struct block_device *, struct hd_geometry *);
+	int (*getgeo)(struct gendisk *, struct hd_geometry *);
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 
 locking rules:
diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 83410f8184ec..94a4fadc651a 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -77,9 +77,9 @@ static void nfhd_submit_bio(struct bio *bio)
 	bio_endio(bio);
 }
 
-static int nfhd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int nfhd_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct nfhd_device *dev = bdev->bd_disk->private_data;
+	struct nfhd_device *dev = disk->private_data;
 
 	geo->cylinders = dev->blocks >> (6 - dev->bshift);
 	geo->heads = 4;
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 4de6613e7468..f2b2feeeb455 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -108,7 +108,7 @@ static DEFINE_MUTEX(ubd_lock);
 
 static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg);
-static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
+static int ubd_getgeo(struct gendisk *disk, struct hd_geometry *geo);
 
 #define MAX_DEV (16)
 
@@ -1324,9 +1324,9 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return res;
 }
 
-static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int ubd_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct ubd *ubd_dev = bdev->bd_disk->private_data;
+	struct ubd *ubd_dev = disk->private_data;
 
 	geo->heads = 128;
 	geo->sectors = 32;
diff --git a/block/ioctl.c b/block/ioctl.c
index e472cc1030c6..57ee2b9d3c8d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -480,7 +480,7 @@ static int blkdev_getgeo(struct block_device *bdev,
 	 */
 	memset(&geo, 0, sizeof(geo));
 	geo.start = get_start_sect(bdev);
-	ret = disk->fops->getgeo(bdev, &geo);
+	ret = disk->fops->getgeo(disk, &geo);
 	if (ret)
 		return ret;
 	if (copy_to_user(argp, &geo, sizeof(geo)))
@@ -514,7 +514,7 @@ static int compat_hdio_getgeo(struct block_device *bdev,
 	 * want to override it.
 	 */
 	geo.start = get_start_sect(bdev);
-	ret = disk->fops->getgeo(bdev, &geo);
+	ret = disk->fops->getgeo(disk, &geo);
 	if (ret)
 		return ret;
 
diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 82d9c4c3fb41..631291fbb356 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -358,7 +358,7 @@ int ibm_partition(struct parsed_partitions *state)
 		goto out_nolab;
 	/* set start if not filled by getgeo function e.g. virtblk */
 	geo->start = get_start_sect(bdev);
-	if (disk->fops->getgeo(bdev, geo))
+	if (disk->fops->getgeo(disk, geo))
 		goto out_freeall;
 	if (!fn || fn(disk, info)) {
 		kfree(info);
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 6357d86eafdc..2932b6653b6f 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1523,13 +1523,13 @@ static blk_status_t amiflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int fd_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	int drive = MINOR(bdev->bd_dev) & 3;
+	struct amiga_floppy_struct *p = disk->private_data;
 
-	geo->heads = unit[drive].type->heads;
-	geo->sectors = unit[drive].dtype->sects * unit[drive].type->sect_mult;
-	geo->cylinders = unit[drive].type->tracks;
+	geo->heads = p->type->heads;
+	geo->sectors = p->dtype->sects * p->type->sect_mult;
+	geo->cylinders = p->type->tracks;
 	return 0;
 }
 
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 00b74a845328..34ead75e7e02 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -269,9 +269,9 @@ static blk_status_t aoeblk_queue_rq(struct blk_mq_hw_ctx *hctx,
 }
 
 static int
-aoeblk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+aoeblk_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct aoedev *d = bdev->bd_disk->private_data;
+	struct aoedev *d = disk->private_data;
 
 	if ((d->flags & DEVFL_UP) == 0) {
 		printk(KERN_ERR "aoe: disk not up\n");
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index e97432032f01..307be2817466 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3363,9 +3363,9 @@ static int get_floppy_geometry(int drive, int type, struct floppy_struct **g)
 	return 0;
 }
 
-static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int fd_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	int drive = (long)bdev->bd_disk->private_data;
+	int drive = (long)disk->private_data;
 	int type = ITYPE(drive_state[drive].fd_device);
 	struct floppy_struct *g;
 	int ret;
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 66ce6b81c7d9..ac0f8bfb6b89 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3143,17 +3143,17 @@ static int mtip_block_compat_ioctl(struct block_device *dev,
  * that each partition is also 4KB aligned. Non-aligned partitions adversely
  * affects performance.
  *
- * @dev Pointer to the block_device strucutre.
+ * @disk Pointer to the gendisk strucutre.
  * @geo Pointer to a hd_geometry structure.
  *
  * return value
  *	0       Operation completed successfully.
  *	-ENOTTY An error occurred while reading the drive capacity.
  */
-static int mtip_block_getgeo(struct block_device *dev,
+static int mtip_block_getgeo(struct gendisk *disk,
 				struct hd_geometry *geo)
 {
-	struct driver_data *dd = dev->bd_disk->private_data;
+	struct driver_data *dd = disk->private_data;
 	sector_t capacity;
 
 	if (!dd)
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 15627417f12e..119b7e27023f 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -942,11 +942,11 @@ static void rnbd_client_release(struct gendisk *gen)
 	rnbd_clt_put_dev(dev);
 }
 
-static int rnbd_client_getgeo(struct block_device *block_device,
+static int rnbd_client_getgeo(struct gendisk *disk,
 			      struct hd_geometry *geo)
 {
 	u64 size;
-	struct rnbd_clt_dev *dev = block_device->bd_disk->private_data;
+	struct rnbd_clt_dev *dev = disk->private_data;
 	struct queue_limits *limit = &dev->queue->limits;
 
 	size = dev->size * (limit->logical_block_size / SECTOR_SIZE);
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index b5727dea15bd..0172c0bc34ea 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -119,9 +119,8 @@ static inline u32 vdc_tx_dring_avail(struct vio_dring_state *dr)
 	return vio_dring_avail(dr, VDC_TX_RING_SIZE);
 }
 
-static int vdc_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int vdc_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct gendisk *disk = bdev->bd_disk;
 	sector_t nsect = get_capacity(disk);
 	sector_t cylinders = nsect;
 
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index eda33c5eb5e2..416015947ae6 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -711,9 +711,9 @@ static int floppy_ioctl(struct block_device *bdev, blk_mode_t mode,
 	return -ENOTTY;
 }
 
-static int floppy_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int floppy_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct floppy_state *fs = bdev->bd_disk->private_data;
+	struct floppy_state *fs = disk->private_data;
 	struct floppy_struct *g;
 	int ret;
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30bca8cb7106..4a6b1e6dcd17 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -829,9 +829,9 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 }
 
 /* We provide getgeo only to please some old bootloader/partitioning tools */
-static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
+static int virtblk_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct virtio_blk *vblk = bd->bd_disk->private_data;
+	struct virtio_blk *vblk = disk->private_data;
 	int ret = 0;
 
 	mutex_lock(&vblk->vdev_mutex);
@@ -853,7 +853,7 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 		/* some standard values, similar to sd */
 		geo->heads = 1 << 6;
 		geo->sectors = 1 << 5;
-		geo->cylinders = get_capacity(bd->bd_disk) >> 11;
+		geo->cylinders = get_capacity(disk) >> 11;
 	}
 out:
 	mutex_unlock(&vblk->vdev_mutex);
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 5babe575c288..04fc6b552c04 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -493,11 +493,11 @@ static void blkif_restart_queue_callback(void *arg)
 	schedule_work(&rinfo->work);
 }
 
-static int blkif_getgeo(struct block_device *bd, struct hd_geometry *hg)
+static int blkif_getgeo(struct gendisk *disk, struct hd_geometry *hg)
 {
 	/* We don't have real geometry info, but let's at least return
 	   values consistent with the size of the device */
-	sector_t nsect = get_capacity(bd->bd_disk);
+	sector_t nsect = get_capacity(disk);
 	sector_t cylinders = nsect;
 
 	hg->heads = 0xff;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1726f0f828cc..20202f8ad4ce 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -403,9 +403,9 @@ static void do_deferred_remove(struct work_struct *w)
 	dm_deferred_remove();
 }
 
-static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int dm_blk_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct mapped_device *md = bdev->bd_disk->private_data;
+	struct mapped_device *md = disk->private_data;
 
 	return dm_get_geometry(md, geo);
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0f03b21e66e4..5e75b388b096 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7669,9 +7669,9 @@ static int set_disk_faulty(struct mddev *mddev, dev_t dev)
  * 4 sectors (with a BIG number of cylinders...). This drives
  * dosfs just mad... ;-)
  */
-static int md_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int md_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct mddev *mddev = bdev->bd_disk->private_data;
+	struct mddev *mddev = disk->private_data;
 
 	geo->heads = 2;
 	geo->sectors = 4;
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index d34892782f6e..1af157ce0a63 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1953,10 +1953,10 @@ static void msb_data_clear(struct msb_data *msb)
 	msb->card = NULL;
 }
 
-static int msb_bd_getgeo(struct block_device *bdev,
+static int msb_bd_getgeo(struct gendisk *disk,
 				 struct hd_geometry *geo)
 {
-	struct msb_data *msb = bdev->bd_disk->private_data;
+	struct msb_data *msb = disk->private_data;
 	*geo = msb->geometry;
 	return 0;
 }
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index c9853d887d28..075519caa547 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -189,10 +189,10 @@ static void mspro_block_bd_free_disk(struct gendisk *disk)
 	kfree(msb);
 }
 
-static int mspro_block_bd_getgeo(struct block_device *bdev,
+static int mspro_block_bd_getgeo(struct gendisk *disk,
 				 struct hd_geometry *geo)
 {
-	struct mspro_block_data *msb = bdev->bd_disk->private_data;
+	struct mspro_block_data *msb = disk->private_data;
 
 	geo->heads = msb->heads;
 	geo->sectors = msb->sectors_per_track;
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9cc47bf94804..d1f295af9713 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -435,9 +435,9 @@ static void mmc_blk_release(struct gendisk *disk)
 }
 
 static int
-mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+mmc_blk_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	geo->cylinders = get_capacity(bdev->bd_disk) / (4 * 16);
+	geo->cylinders = get_capacity(disk) / (4 * 16);
 	geo->heads = 4;
 	geo->sectors = 16;
 	return 0;
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 847c11542f02..28e09d080440 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -246,9 +246,9 @@ static void blktrans_release(struct gendisk *disk)
 	blktrans_dev_put(dev);
 }
 
-static int blktrans_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int blktrans_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct mtd_blktrans_dev *dev = bdev->bd_disk->private_data;
+	struct mtd_blktrans_dev *dev = disk->private_data;
 	int ret = -ENXIO;
 
 	mutex_lock(&dev->lock);
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 39cc0a6a4d37..b53fd147fa65 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -282,12 +282,12 @@ static void ubiblock_release(struct gendisk *gd)
 	mutex_unlock(&dev->dev_mutex);
 }
 
-static int ubiblock_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int ubiblock_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
 	/* Some tools might require this information */
 	geo->heads = 1;
 	geo->cylinders = 1;
-	geo->sectors = get_capacity(bdev->bd_disk);
+	geo->sectors = get_capacity(disk);
 	geo->start = 0;
 	return 0;
 }
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 423dcd190906..88ac859258f9 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1478,12 +1478,12 @@ static void btt_submit_bio(struct bio *bio)
 	bio_endio(bio);
 }
 
-static int btt_getgeo(struct block_device *bd, struct hd_geometry *geo)
+static int btt_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
 	/* some standard values */
 	geo->heads = 1 << 6;
 	geo->sectors = 1 << 5;
-	geo->cylinders = get_capacity(bd->bd_disk) >> 11;
+	geo->cylinders = get_capacity(disk) >> 11;
 	return 0;
 }
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7493e5aa984c..3f2cfb007a65 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1799,12 +1799,12 @@ static void nvme_release(struct gendisk *disk)
 	nvme_ns_release(disk->private_data);
 }
 
-int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+int nvme_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
 	/* some standard values */
 	geo->heads = 1 << 6;
 	geo->sectors = 1 << 5;
-	geo->cylinders = get_capacity(bdev->bd_disk) >> 11;
+	geo->cylinders = get_capacity(disk) >> 11;
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7df2ea21851f..83bc93fa124a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -936,7 +936,7 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
 int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_id_ns **id);
-int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
+int nvme_getgeo(struct gendisk *disk, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
 extern const struct attribute_group *nvme_ns_attr_groups[];
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index b16efecfde4b..d7307c68b1b5 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3316,11 +3316,11 @@ static void dasd_release(struct gendisk *disk)
 /*
  * Return disk geometry.
  */
-static int dasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int dasd_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
 	struct dasd_device *base;
 
-	base = dasd_device_from_gendisk(bdev->bd_disk);
+	base = dasd_device_from_gendisk(disk);
 	if (!base)
 		return -ENODEV;
 
@@ -3330,7 +3330,8 @@ static int dasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 		return -EINVAL;
 	}
 	base->discipline->fill_geometry(base->block, geo);
-	geo->start = get_start_sect(bdev) >> base->block->s2b_shift;
+	// geo->start is left unchanged by the above
+	geo->start >>= base->block->s2b_shift;
 	dasd_put_device(base);
 	return 0;
 }
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0dd2a092170a..9f701bca6dae 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1594,9 +1594,9 @@ static void sd_release(struct gendisk *disk)
 	scsi_device_put(sdev);
 }
 
-static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int sd_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 {
-	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
+	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdp = sdkp->device;
 	struct Scsi_Host *host = sdp->host;
 	sector_t capacity = logical_to_sectors(sdp, sdkp->capacity);
@@ -1609,9 +1609,9 @@ static int sd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 
 	/* override with calculated, extended default, or driver values */
 	if (host->hostt->bios_param)
-		host->hostt->bios_param(sdp, bdev->bd_disk, capacity, diskinfo);
+		host->hostt->bios_param(sdp, disk, capacity, diskinfo);
 	else
-		scsicam_bios_param(bdev->bd_disk, capacity, diskinfo);
+		scsicam_bios_param(disk, capacity, diskinfo);
 
 	geo->heads = diskinfo[0];
 	geo->sectors = diskinfo[1];
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a59880c809c7..3a1695007395 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1597,7 +1597,7 @@ struct block_device_operations {
 	unsigned int (*check_events) (struct gendisk *disk,
 				      unsigned int clearing);
 	void (*unlock_native_capacity) (struct gendisk *);
-	int (*getgeo)(struct block_device *, struct hd_geometry *);
+	int (*getgeo)(struct gendisk *, struct hd_geometry *);
 	int (*set_read_only)(struct block_device *bdev, bool ro);
 	void (*free_disk)(struct gendisk *disk);
 	/* this callback is with swap_lock and sometimes page table lock held */
-- 
2.39.5

