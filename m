Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E625C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 08:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F5220714
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 08:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I7nf3Sxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgC0IJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:09:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0IJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 04:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7MkLh/AtsQmeJb55SUB0j8W/OcCYSrvtyMoSbjPhfsI=; b=I7nf3SxzztuN9ahCeBG1PEEDjJ
        xKen67JCfXq3e7EyY8dwPCMyQZAI3Qxu5MmTThGOhl8FXMk7SulJXIPGwbgpqvXJ0EzQLFxG0SVzE
        OUloYGfio6rvtc3gBcmjmkfdG9BkLWdN13qfyXRDh4vGddQd/JXuQEVyX2wukmA7tJW7C77YFVcej
        xD5oqXR8Vn0E5GWmwF+jMdVFBlgXIIxsJCV2pEs/wOEq5X+rNfbyN53EfLlDfsHAy7ohfwSTCyt25
        wIG4IAylCgfyQDV/qcc0dAOJ5Q2VVIXPhfU4qgLRe+nkWnI1ruEzevILysPpyfW4ctmtG8YZbjdrM
        45LUckCA==;
Received: from 213-225-10-87.nat.highway.a1.net ([213.225.10.87] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHk3V-0006hL-VC; Fri, 27 Mar 2020 08:09:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: move the ->devnode callback to struct block_device_operations
Date:   Fri, 27 Mar 2020 09:07:17 +0100
Message-Id: <20200327080717.1574048-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There really isn't any good reason to stash a method directly into
struct gendisk.  Move it together with the other block device
operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           |  4 ++--
 drivers/block/pktcdvd.c | 12 ++++++------
 include/linux/blkdev.h  |  1 +
 include/linux/genhd.h   |  1 -
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 6323cc789efa..14cf395a1479 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1497,8 +1497,8 @@ static char *block_devnode(struct device *dev, umode_t *mode,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	if (disk->devnode)
-		return disk->devnode(disk, mode);
+	if (disk->fops->devnode)
+		return disk->fops->devnode(disk, mode);
 	return NULL;
 }
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 5f970a7d32c0..0d286a87e647 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2679,6 +2679,11 @@ static unsigned int pkt_check_events(struct gendisk *disk,
 	return attached_disk->fops->check_events(attached_disk, clearing);
 }
 
+static char *pkt_devnode(struct gendisk *disk, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "pktcdvd/%s", disk->disk_name);
+}
+
 static const struct block_device_operations pktcdvd_ops = {
 	.owner =		THIS_MODULE,
 	.open =			pkt_open,
@@ -2686,13 +2691,9 @@ static const struct block_device_operations pktcdvd_ops = {
 	.ioctl =		pkt_ioctl,
 	.compat_ioctl =		blkdev_compat_ptr_ioctl,
 	.check_events =		pkt_check_events,
+	.devnode =		pkt_devnode,
 };
 
-static char *pktcdvd_devnode(struct gendisk *gd, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "pktcdvd/%s", gd->disk_name);
-}
-
 /*
  * Set up mapping from pktcdvd device to CD-ROM device.
  */
@@ -2748,7 +2749,6 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	disk->fops = &pktcdvd_ops;
 	disk->flags = GENHD_FL_REMOVABLE;
 	strcpy(disk->disk_name, pd->name);
-	disk->devnode = pktcdvd_devnode;
 	disk->private_data = pd;
 	disk->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!disk->queue)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 53a1325efbc3..e8defd718d62 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1697,6 +1697,7 @@ struct block_device_operations {
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
+	char *(*devnode)(struct gendisk *disk, umode_t *mode);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 };
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 927eed0be179..85b9e253cd39 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -191,7 +191,6 @@ struct gendisk {
                                          * disks that can't be partitioned. */
 
 	char disk_name[DISK_NAME_LEN];	/* name of major driver */
-	char *(*devnode)(struct gendisk *gd, umode_t *mode);
 
 	unsigned short events;		/* supported events */
 	unsigned short event_flags;	/* flags related to event processing */
-- 
2.25.1

