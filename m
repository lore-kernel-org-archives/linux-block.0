Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4A7C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255BD20661
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XnKINMiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCJjV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oaJfHAsDAraGOTle2tw5hnd6LtUCl9rHjVLq/Ux2zyw=; b=XnKINMiByOtTRuqcp2dkBy1NBt
        bSlbrC5i+iU9rKejJKY1dbtSCZrizDxdh6vH2o7W8Xy67pbQL1KYiOmJAJ14NzTXWYBJWRACK/VPw
        xzWEWQd1E6sehekUFMspMJEwuo8hDBijJNM8Ruzhx2fFTzNQCpl61faFH0NhdVyhhFdv91XEJMYmX
        6WTbYADCfNL1RjnSf84RBVP8XqXoMfhFvlz9flvrDu/tLfvemfaj3DyjeTpSF1T4fiJP3zuf71xA3
        0P1gLTjG1AlwHEz5lrDHtmEQkzh5wt5r3bsT7AT7DV0jqnrcUjtbHfiCvtlchdJXqrZSsbvmyP31O
        gf/HcHZg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eO-00027m-0A; Tue, 03 Dec 2019 09:39:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: [PATCH 4/8] block: simplify blkdev_nr_zones
Date:   Tue,  3 Dec 2019 10:39:04 +0100
Message-Id: <20191203093908.24612-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203093908.24612-1-hch@lst.de>
References: <20191203093908.24612-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplify the arguments to blkdev_nr_zones by passing a gendisk instead
of the block_device and capacity.  This also removes the need for
__blkdev_nr_zones as all callers are outside the fast path and can
deal with the additional branch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c            | 26 ++++++++------------------
 block/ioctl.c                |  2 +-
 drivers/md/dm-zoned-target.c |  2 +-
 include/linux/blkdev.h       |  5 ++---
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 618786f8275c..65a9bdc9fe27 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -70,30 +70,20 @@ void __blk_req_zone_write_unlock(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
 
-static inline unsigned int __blkdev_nr_zones(struct request_queue *q,
-					     sector_t nr_sectors)
-{
-	sector_t zone_sectors = blk_queue_zone_sectors(q);
-
-	return (nr_sectors + zone_sectors - 1) >> ilog2(zone_sectors);
-}
-
 /**
  * blkdev_nr_zones - Get number of zones
- * @bdev:	Target block device
+ * @disk:	Target gendisk
  *
- * Description:
- *    Return the total number of zones of a zoned block device.
- *    For a regular block device, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device.  For a block
+ * device without zone capabilities, the number of zones is always 0.
  */
-unsigned int blkdev_nr_zones(struct block_device *bdev)
+unsigned int blkdev_nr_zones(struct gendisk *disk)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
+	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
 
-	if (!blk_queue_is_zoned(q))
+	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-
-	return __blkdev_nr_zones(q, get_capacity(bdev->bd_disk));
+	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
@@ -447,7 +437,7 @@ static int blk_update_zone_info(struct gendisk *disk, unsigned int nr_zones,
 int blk_revalidate_disk_zones(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
-	unsigned int nr_zones = __blkdev_nr_zones(q, get_capacity(disk));
+	unsigned int nr_zones = blkdev_nr_zones(disk);
 	struct blk_revalidate_zone_args args = { .disk = disk };
 	int ret = 0;
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 7ac8a66c9787..5de98b97af2a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -512,7 +512,7 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case BLKGETZONESZ:
 		return put_uint(arg, bdev_zone_sectors(bdev));
 	case BLKGETNRZONES:
-		return put_uint(arg, blkdev_nr_zones(bdev));
+		return put_uint(arg, blkdev_nr_zones(bdev->bd_disk));
 	case HDIO_GETGEO:
 		return blkdev_getgeo(bdev, argp);
 	case BLKRAGET:
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 4574e0dedbd6..70a1063161c0 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -727,7 +727,7 @@ static int dmz_get_zoned_device(struct dm_target *ti, char *path)
 	dev->zone_nr_blocks = dmz_sect2blk(dev->zone_nr_sectors);
 	dev->zone_nr_blocks_shift = ilog2(dev->zone_nr_blocks);
 
-	dev->nr_zones = blkdev_nr_zones(dev->bdev);
+	dev->nr_zones = blkdev_nr_zones(dev->bdev->bd_disk);
 
 	dmz->dev = dev;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6012e2592628..c5852de402b6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -357,8 +357,7 @@ typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
-
-extern unsigned int blkdev_nr_zones(struct block_device *bdev);
+unsigned int blkdev_nr_zones(struct gendisk *disk);
 extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			    sector_t sectors, sector_t nr_sectors,
 			    gfp_t gfp_mask);
@@ -371,7 +370,7 @@ extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 
 #else /* CONFIG_BLK_DEV_ZONED */
 
-static inline unsigned int blkdev_nr_zones(struct block_device *bdev)
+static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
 {
 	return 0;
 }
-- 
2.20.1

