Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DDC07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8A961278
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 12:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhGOMtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 08:49:18 -0400
Received: from verein.lst.de ([213.95.11.211]:38479 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhGOMtS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 08:49:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 539F267373; Thu, 15 Jul 2021 14:46:22 +0200 (CEST)
Date:   Thu, 15 Jul 2021 14:46:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG report] Deadlock in xen-blkfront upon device hot-unplug
Message-ID: <20210715124622.GA32693@lst.de>
References: <87pmvk0wep.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmvk0wep.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 15, 2021 at 11:16:30AM +0200, Vitaly Kuznetsov wrote:
> I'm observing a deadlock every time I try to unplug a xen-blkfront
> device. With 5.14-rc1+ the deadlock looks like:

I did actually stumble over this a few days ago just from code
inspection.  Below is what I come up with, can you give it a spin?

---
From 4fef3b917af51153dd99a958ee9064f0de3a8b6a Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 29 Jun 2021 13:49:22 +0200
Subject: xen-blkfront: sanitize the removal state machine

xen-blkfront has a weird protocol where close message from the remote
side can be delayed, and where hot removals are treated somewhat
differently from regular removals, all leading to potential NULL
pointer removals.  Fix this by just performing normal hot removals
even when the device is opened like all other Linux block drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 182 +++--------------------------------
 1 file changed, 16 insertions(+), 166 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8d49f8fa98bb..0ba37c97aabd 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -502,34 +502,21 @@ static int blkif_getgeo(struct block_device *bd, struct hd_geometry *hg)
 static int blkif_ioctl(struct block_device *bdev, fmode_t mode,
 		       unsigned command, unsigned long argument)
 {
-	struct blkfront_info *info = bdev->bd_disk->private_data;
 	int i;
 
-	dev_dbg(&info->xbdev->dev, "command: 0x%x, argument: 0x%lx\n",
-		command, (long)argument);
-
 	switch (command) {
 	case CDROMMULTISESSION:
-		dev_dbg(&info->xbdev->dev, "FIXME: support multisession CDs later\n");
 		for (i = 0; i < sizeof(struct cdrom_multisession); i++)
 			if (put_user(0, (char __user *)(argument + i)))
 				return -EFAULT;
 		return 0;
-
-	case CDROM_GET_CAPABILITY: {
-		struct gendisk *gd = info->gd;
-		if (gd->flags & GENHD_FL_CD)
+	case CDROM_GET_CAPABILITY:
+		if (bdev->bd_disk->flags & GENHD_FL_CD)
 			return 0;
 		return -EINVAL;
-	}
-
 	default:
-		/*printk(KERN_ALERT "ioctl %08x not supported by Xen blkdev\n",
-		  command);*/
-		return -EINVAL; /* same return as native Linux */
+		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
@@ -1179,11 +1166,8 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 static void xlvbd_release_gendisk(struct blkfront_info *info)
 {
-	unsigned int minor, nr_minors, i;
 	struct blkfront_ring_info *rinfo;
-
-	if (info->rq == NULL)
-		return;
+	unsigned int i;
 
 	/* No more blkif_request(). */
 	blk_mq_stop_hw_queues(info->rq);
@@ -1198,12 +1182,8 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 
 	del_gendisk(info->gd);
 
-	minor = info->gd->first_minor;
-	nr_minors = info->gd->minors;
-	xlbd_release_minors(minor, nr_minors);
-
+	xlbd_release_minors(info->gd->first_minor, info->gd->minors);
 	blk_cleanup_disk(info->gd);
-	info->gd = NULL;
 	blk_mq_free_tag_set(&info->tag_set);
 }
 
@@ -2126,38 +2106,16 @@ static int blkfront_resume(struct xenbus_device *dev)
 static void blkfront_closing(struct blkfront_info *info)
 {
 	struct xenbus_device *xbdev = info->xbdev;
-	struct block_device *bdev = NULL;
-
-	mutex_lock(&info->mutex);
-
-	if (xbdev->state == XenbusStateClosing) {
-		mutex_unlock(&info->mutex);
-		return;
-	}
 
-	if (info->gd)
-		bdev = bdgrab(info->gd->part0);
-
-	mutex_unlock(&info->mutex);
-
-	if (!bdev) {
-		xenbus_frontend_closed(xbdev);
+	if (xbdev->state == XenbusStateClosing)
 		return;
-	}
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-
-	if (bdev->bd_openers) {
-		xenbus_dev_error(xbdev, -EBUSY,
-				 "Device in use; refusing to close");
-		xenbus_switch_state(xbdev, XenbusStateClosing);
-	} else {
+	mutex_lock(&blkfront_mutex);
+	if (info->gd->flags & GENHD_FL_UP)
 		xlvbd_release_gendisk(info);
-		xenbus_frontend_closed(xbdev);
-	}
-
-	mutex_unlock(&bdev->bd_disk->open_mutex);
-	bdput(bdev);
+	mutex_unlock(&blkfront_mutex);
+	
+	xenbus_frontend_closed(xbdev);
 }
 
 static void blkfront_setup_discard(struct blkfront_info *info)
@@ -2472,8 +2430,7 @@ static void blkback_changed(struct xenbus_device *dev,
 			break;
 		fallthrough;
 	case XenbusStateClosing:
-		if (info)
-			blkfront_closing(info);
+		blkfront_closing(info);
 		break;
 	}
 }
@@ -2481,55 +2438,16 @@ static void blkback_changed(struct xenbus_device *dev,
 static int blkfront_remove(struct xenbus_device *xbdev)
 {
 	struct blkfront_info *info = dev_get_drvdata(&xbdev->dev);
-	struct block_device *bdev = NULL;
-	struct gendisk *disk;
 
 	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
 
-	if (!info)
-		return 0;
-
 	blkif_free(info, 0);
 
-	mutex_lock(&info->mutex);
-
-	disk = info->gd;
-	if (disk)
-		bdev = bdgrab(disk->part0);
-
-	info->xbdev = NULL;
-	mutex_unlock(&info->mutex);
-
-	if (!bdev) {
-		mutex_lock(&blkfront_mutex);
-		free_info(info);
-		mutex_unlock(&blkfront_mutex);
-		return 0;
-	}
-
-	/*
-	 * The xbdev was removed before we reached the Closed
-	 * state. See if it's safe to remove the disk. If the bdev
-	 * isn't closed yet, we let release take care of it.
-	 */
-
-	mutex_lock(&disk->open_mutex);
-	info = disk->private_data;
-
-	dev_warn(disk_to_dev(disk),
-		 "%s was hot-unplugged, %d stale handles\n",
-		 xbdev->nodename, bdev->bd_openers);
-
-	if (info && !bdev->bd_openers) {
+	mutex_lock(&blkfront_mutex);
+	if (info->gd->flags & GENHD_FL_UP)
 		xlvbd_release_gendisk(info);
-		disk->private_data = NULL;
-		mutex_lock(&blkfront_mutex);
-		free_info(info);
-		mutex_unlock(&blkfront_mutex);
-	}
-
-	mutex_unlock(&disk->open_mutex);
-	bdput(bdev);
+	free_info(info);
+	mutex_unlock(&blkfront_mutex);
 
 	return 0;
 }
@@ -2541,77 +2459,9 @@ static int blkfront_is_ready(struct xenbus_device *dev)
 	return info->is_ready && info->xbdev;
 }
 
-static int blkif_open(struct block_device *bdev, fmode_t mode)
-{
-	struct gendisk *disk = bdev->bd_disk;
-	struct blkfront_info *info;
-	int err = 0;
-
-	mutex_lock(&blkfront_mutex);
-
-	info = disk->private_data;
-	if (!info) {
-		/* xbdev gone */
-		err = -ERESTARTSYS;
-		goto out;
-	}
-
-	mutex_lock(&info->mutex);
-
-	if (!info->gd)
-		/* xbdev is closed */
-		err = -ERESTARTSYS;
-
-	mutex_unlock(&info->mutex);
-
-out:
-	mutex_unlock(&blkfront_mutex);
-	return err;
-}
-
-static void blkif_release(struct gendisk *disk, fmode_t mode)
-{
-	struct blkfront_info *info = disk->private_data;
-	struct xenbus_device *xbdev;
-
-	mutex_lock(&blkfront_mutex);
-	if (disk->part0->bd_openers)
-		goto out_mutex;
-
-	/*
-	 * Check if we have been instructed to close. We will have
-	 * deferred this request, because the bdev was still open.
-	 */
-
-	mutex_lock(&info->mutex);
-	xbdev = info->xbdev;
-
-	if (xbdev && xbdev->state == XenbusStateClosing) {
-		/* pending switch to state closed */
-		dev_info(disk_to_dev(disk), "releasing disk\n");
-		xlvbd_release_gendisk(info);
-		xenbus_frontend_closed(info->xbdev);
- 	}
-
-	mutex_unlock(&info->mutex);
-
-	if (!xbdev) {
-		/* sudden device removal */
-		dev_info(disk_to_dev(disk), "releasing disk\n");
-		xlvbd_release_gendisk(info);
-		disk->private_data = NULL;
-		free_info(info);
-	}
-
-out_mutex:
-	mutex_unlock(&blkfront_mutex);
-}
-
 static const struct block_device_operations xlvbd_block_fops =
 {
 	.owner = THIS_MODULE,
-	.open = blkif_open,
-	.release = blkif_release,
 	.getgeo = blkif_getgeo,
 	.ioctl = blkif_ioctl,
 	.compat_ioctl = blkdev_compat_ptr_ioctl,
-- 
2.30.2

