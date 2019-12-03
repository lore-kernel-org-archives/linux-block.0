Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B28C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6690920661
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYpVquDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLCJj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfLCJj3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tld7yeuyFzA1rKT+6njc/e7upZje2HvkNA0/lhtjung=; b=AYpVquDdaR80Q8mXlCflpdMaS/
        +XKV25/4CARhT1oI2q5PMmtah1sNmGrL7xjku5mQmVC0vgj5Cm08+5myhLsqdSFYFXzZn1ucoSO1N
        prgLJ3AmYWt0faO+TR0Q+6MsbAo2MZTJDV/KilKn+P70uvW/xabjHKkCweDSzx9rf2448BvZBbY0W
        gTL5wjqrE2PoYud20ffOulT0f3w+S33RQpYmTA3Di6ltcA3V4j7jJdpDyS7iUqRAE1/QedbOrf/Mm
        LllovtJngGgxUMfdUIgOWcLdjcGQDKWhPitywgDkJnGwcgerS/BpvRtD+M58x9iEHp55fbhV97NXP
        Y0gl/X6g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eW-0002AR-OH; Tue, 03 Dec 2019 09:39:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: [PATCH 8/8] block: set the zone size in blk_revalidate_disk_zones atomically
Date:   Tue,  3 Dec 2019 10:39:08 +0100
Message-Id: <20191203093908.24612-9-hch@lst.de>
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

The current zone revalidation code has a major problem in that it
doesn't update the zone size and q->nr_zones atomically, leading
to a short window where an out of bounds access to the zone arrays
is possible.

To fix this move the setting of the zone size into the crticial
sections blk_revalidate_disk_zones so that it gets updated together
with the zone bitmaps and q->nr_zones.  This also slightly simplifies
the caller as it deducts the zone size from the report_zones.

This change also allows to check for a power of two zone size in generic
code.

Reported-by: Hans Holmberg <hans@owltronix.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c             | 59 ++++++++++++++++++++---------------
 drivers/block/null_blk_main.c |  3 +-
 drivers/scsi/sd_zbc.c         |  2 --
 3 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 51d427659ce7..d00fcfd71dfe 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -343,6 +343,7 @@ struct blk_revalidate_zone_args {
 	unsigned long	*conv_zones_bitmap;
 	unsigned long	*seq_zones_wlock;
 	unsigned int	nr_zones;
+	sector_t	zone_sectors;
 	sector_t	sector;
 };
 
@@ -355,25 +356,33 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	struct blk_revalidate_zone_args *args = data;
 	struct gendisk *disk = args->disk;
 	struct request_queue *q = disk->queue;
-	sector_t zone_sectors = blk_queue_zone_sectors(q);
 	sector_t capacity = get_capacity(disk);
 
 	/*
 	 * All zones must have the same size, with the exception on an eventual
 	 * smaller last zone.
 	 */
-	if (zone->start + zone_sectors < capacity &&
-	    zone->len != zone_sectors) {
-		pr_warn("%s: Invalid zoned device with non constant zone size\n",
-			disk->disk_name);
-		return false;
-	}
+	if (zone->start == 0) {
+		if (zone->len == 0 || !is_power_of_2(zone->len)) {
+			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
+				disk->disk_name, zone->len);
+			return -ENODEV;
+		}
 
-	if (zone->start + zone->len >= capacity &&
-	    zone->len > zone_sectors) {
-		pr_warn("%s: Invalid zoned device with larger last zone size\n",
-			disk->disk_name);
-		return -ENODEV;
+		args->zone_sectors = zone->len;
+		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+	} else if (zone->start + args->zone_sectors < capacity) {
+		if (zone->len != args->zone_sectors) {
+			pr_warn("%s: Invalid zoned device with non constant zone size\n",
+				disk->disk_name);
+			return -ENODEV;
+		}
+	} else {
+		if (zone->len > args->zone_sectors) {
+			pr_warn("%s: Invalid zoned device with larger last zone size\n",
+				disk->disk_name);
+			return -ENODEV;
+		}
 	}
 
 	/* Check for holes in the zone report */
@@ -428,9 +437,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct blk_revalidate_zone_args args = {
 		.disk		= disk,
-		.nr_zones	= blkdev_nr_zones(disk),
 	};
-	int ret = 0;
+	unsigned int noio_flag;
+	int ret;
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
 		return -EIO;
@@ -438,24 +447,22 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		return -EIO;
 
 	/*
-	 * Ensure that all memory allocations in this context are done as
-	 * if GFP_NOIO was specified.
+	 * Ensure that all memory allocations in this context are done as if
+	 * GFP_NOIO was specified.
 	 */
-	if (args.nr_zones) {
-		unsigned int noio_flag = memalloc_noio_save();
-
-		ret = disk->fops->report_zones(disk, 0, args.nr_zones,
-					       blk_revalidate_zone_cb, &args);
-		memalloc_noio_restore(noio_flag);
-	}
+	noio_flag = memalloc_noio_save();
+	ret = disk->fops->report_zones(disk, 0, UINT_MAX,
+				       blk_revalidate_zone_cb, &args);
+	memalloc_noio_restore(noio_flag);
 
 	/*
-	 * Install the new bitmaps, making sure the queue is stopped and
-	 * all I/Os are completed (i.e. a scheduler is not referencing the
-	 * bitmaps).
+	 * Install the new bitmaps and update nr_zones only once the queue is
+	 * stopped and all I/Os are completed (i.e. a scheduler is not
+	 * referencing the bitmaps).
 	 */
 	blk_mq_freeze_queue(q);
 	if (ret >= 0) {
+		blk_queue_chunk_sectors(q, args.zone_sectors);
 		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 068cd0ae6e2c..997b7dc095b9 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1583,6 +1583,8 @@ static int null_gendisk_register(struct nullb *nullb)
 			if (ret)
 				return ret;
 		} else {
+			blk_queue_chunk_sectors(nullb->q,
+					nullb->dev->zone_size_sects);
 			nullb->q->nr_zones = blkdev_nr_zones(disk);
 		}
 	}
@@ -1746,7 +1748,6 @@ static int null_add_dev(struct nullb_device *dev)
 		if (rv)
 			goto out_cleanup_blk_queue;
 
-		blk_queue_chunk_sectors(nullb->q, dev->zone_size_sects);
 		nullb->q->limits.zoned = BLK_ZONED_HM;
 		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, nullb->q);
 		blk_queue_required_elevator_features(nullb->q,
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 0e5ede48f045..27d72c1d4654 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -412,8 +412,6 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 		goto err;
 
 	/* The drive satisfies the kernel restrictions: set it up */
-	blk_queue_chunk_sectors(sdkp->disk->queue,
-			logical_to_sectors(sdkp->device, zone_blocks));
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, sdkp->disk->queue);
 	blk_queue_required_elevator_features(sdkp->disk->queue,
 					     ELEVATOR_F_ZBD_SEQ_WRITE);
-- 
2.20.1

