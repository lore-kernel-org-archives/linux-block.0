Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD18C433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61973207DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGlK22TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgHUI5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgHUI45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 04:56:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1EDC061385;
        Fri, 21 Aug 2020 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qnhv8iYHAvUTE/7CFzUHZuKNCiy/aV6RSD2K0k6RE/I=; b=VGlK22TFQ43z+zqnc6T7CIKRZa
        7vKFed5EW0wEXRUGlLIyXKioi8CVgOBlYcWHAnqfuu5TWNhINW7TtAWeVZqUuNlouA9/qhsRrqUDT
        LCJghbOrhnfYVA9xrJqsdDcgP86Cx4l9jOd3gdi7KYTzX5UD7TAsqYAeN5S7VYCzGOUH4Ic20BE+u
        TOxcjaGkRnPKdtQnE32OD6lsVrDv56r4IOsiRIKTfEbcV569sv0ta0JisbOiTbVE15iilpVKFMOlo
        wkIZ4P6dz2/7GVXuF+WO+fkvsZpC7LocgkFZ5YJOweI2VV16tZqdPKrc2XVJdbIOa1yxtR4pCIlZz
        q6UIyDHw==;
Received: from [2001:4bb8:198:f3b2:a2b:85ba:fb78:c253] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92qM-0007g0-RC; Fri, 21 Aug 2020 08:56:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/2] block: replace bd_set_size with bd_set_nr_sectors
Date:   Fri, 21 Aug 2020 10:55:59 +0200
Message-Id: <20200821085600.2395666-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821085600.2395666-1-hch@lst.de>
References: <20200821085600.2395666-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace bd_set_size with a version that takes the number of sectors
instead, as that fits most of the current and future callers much better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c     |  4 ++--
 drivers/block/nbd.c      |  7 ++++---
 drivers/block/pktcdvd.c  |  2 +-
 drivers/nvme/host/nvme.h |  2 +-
 fs/block_dev.c           | 10 +++++-----
 include/linux/genhd.h    |  2 +-
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2f137d6ce169d5..7069899a94903e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -253,7 +253,7 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 {
 	struct block_device *bdev = lo->lo_device;
 
-	bd_set_size(bdev, size << SECTOR_SHIFT);
+	bd_set_nr_sectors(bdev, size);
 
 	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
@@ -1248,7 +1248,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	set_capacity(lo->lo_disk, 0);
 	loop_sysfs_exit(lo);
 	if (bdev) {
-		bd_set_size(bdev, 0);
+		bd_set_nr_sectors(bdev, 0);
 		/* let user-space know about this change */
 		kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 	}
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3ff4054d6834d2..f07243335472a4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -300,6 +300,7 @@ static void nbd_size_update(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
 	struct block_device *bdev = bdget_disk(nbd->disk, 0);
+	sector_t nr_sectors = config->bytesize >> 9;
 
 	if (config->flags & NBD_FLAG_SEND_TRIM) {
 		nbd->disk->queue->limits.discard_granularity = config->blksize;
@@ -308,10 +309,10 @@ static void nbd_size_update(struct nbd_device *nbd)
 	}
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
-	set_capacity(nbd->disk, config->bytesize >> 9);
+	set_capacity(nbd->disk, nr_sectors);
 	if (bdev) {
 		if (bdev->bd_disk) {
-			bd_set_size(bdev, config->bytesize);
+			bd_set_nr_sectors(bdev, nr_sectors);
 			set_blocksize(bdev, config->blksize);
 		} else
 			bdev->bd_invalidated = 1;
@@ -1138,7 +1139,7 @@ static void nbd_bdev_reset(struct block_device *bdev)
 {
 	if (bdev->bd_openers > 1)
 		return;
-	bd_set_size(bdev, 0);
+	bd_set_nr_sectors(bdev, 0);
 }
 
 static void nbd_parse_flags(struct nbd_device *nbd)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 4becc1efe775fc..015fe128fa8a35 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2192,7 +2192,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 
 	set_capacity(pd->disk, lba << 2);
 	set_capacity(pd->bdev->bd_disk, lba << 2);
-	bd_set_size(pd->bdev, (loff_t)lba << 11);
+	bd_set_nr_sectors(pd->bdev, lba << 2);
 
 	q = bdev_get_queue(pd->bdev);
 	if (write) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ebb8c3ed388554..ae5cad5a08f411 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -664,7 +664,7 @@ static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
 	struct block_device *bdev = bdget_disk(disk, 0);
 
 	if (bdev) {
-		bd_set_size(bdev, get_capacity(disk) << SECTOR_SHIFT);
+		bd_set_nr_sectors(bdev, get_capacity(disk));
 		bdput(bdev);
 	}
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8ae833e004439b..f52597172c8b79 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1371,13 +1371,13 @@ int check_disk_change(struct block_device *bdev)
 
 EXPORT_SYMBOL(check_disk_change);
 
-void bd_set_size(struct block_device *bdev, loff_t size)
+void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
 	inode_lock(bdev->bd_inode);
-	i_size_write(bdev->bd_inode, size);
+	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
 	inode_unlock(bdev->bd_inode);
 }
-EXPORT_SYMBOL(bd_set_size);
+EXPORT_SYMBOL(bd_set_nr_sectors);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
@@ -1514,7 +1514,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			}
 
 			if (!ret) {
-				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
+				bd_set_nr_sectors(bdev, get_capacity(disk));
 				set_init_blocksize(bdev);
 			}
 
@@ -1542,7 +1542,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 				ret = -ENXIO;
 				goto out_clear;
 			}
-			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
+			bd_set_nr_sectors(bdev, bdev->bd_part->nr_sects);
 			set_init_blocksize(bdev);
 		}
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4ab853461dff25..39025dc0397c04 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -375,7 +375,7 @@ void unregister_blkdev(unsigned int major, const char *name);
 int revalidate_disk(struct gendisk *disk);
 int check_disk_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
-void bd_set_size(struct block_device *bdev, loff_t size);
+void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
 /* for drivers/char/raw.c: */
 int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
-- 
2.28.0

