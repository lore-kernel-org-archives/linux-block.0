Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F4FC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B21920661
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FNtOf73Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLCJjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AWfSmqDZ2B2JI9YmK3SlaWe9FMOXc288trASlP2+67g=; b=FNtOf73ZSOd5mPCb+n3bStgYWK
        f7IEJTSqq0mmGsJeNm80ogW9SNHO+HDtP2pLo1EBe+khj4G2t5yCfuhDfFm+do6ZAM6XozPLk1e3Y
        bHzJShmAhAPSTURePiNpwPfGe4WybgUY5Jf1x76bGorRKa+n/Z7Ytz/v1KSHOQUCZHGARJZ/Pyn8C
        30Kx+lkOfSXNcY0zn98xXjUiS03QniMmD8jLOrpXhm4nSYcrzNtHf3mrVIaOv1ZpltmjlmwxPifsx
        hXFMaMSAr2cd5pxy7Hz1EyXDtZORaZLkWQGe2Piw0yRbLwalT2ZxnPIkb2754wCAePBJ3a1Y+4eYG
        FOSL/YoQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eS-00029P-Co; Tue, 03 Dec 2019 09:39:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: [PATCH 6/8] block: allocate the zone bitmaps lazily
Date:   Tue,  3 Dec 2019 10:39:06 +0100
Message-Id: <20191203093908.24612-7-hch@lst.de>
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

Allocate the conventional zone bitmap and the sequential zone locking
bitmap only when we find a zone of the respective type.  This avoids
wasting memory on the conventional zone bitmap for devices that only
have sequential zones, and will also prepare for other future changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 65 +++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9c3931051f4f..0131f9e14bd1 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -342,6 +342,7 @@ struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
 	unsigned long	*conv_zones_bitmap;
 	unsigned long	*seq_zones_wlock;
+	unsigned int	nr_zones;
 	sector_t	sector;
 };
 
@@ -385,8 +386,22 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	/* Check zone type */
 	switch (zone->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
+		if (!args->conv_zones_bitmap) {
+			args->conv_zones_bitmap =
+				blk_alloc_zone_bitmap(q->node, args->nr_zones);
+			if (!args->conv_zones_bitmap)
+				return -ENOMEM;
+		}
+		set_bit(idx, args->conv_zones_bitmap);
+		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
+		if (!args->seq_zones_wlock) {
+			args->seq_zones_wlock =
+				blk_alloc_zone_bitmap(q->node, args->nr_zones);
+			if (!args->seq_zones_wlock)
+				return -ENOMEM;
+		}
 		break;
 	default:
 		pr_warn("%s: Invalid zone type 0x%x at sectors %llu\n",
@@ -394,37 +409,10 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-		set_bit(idx, args->conv_zones_bitmap);
-
 	args->sector += zone->len;
 	return 0;
 }
 
-static int blk_update_zone_info(struct gendisk *disk, unsigned int nr_zones,
-				struct blk_revalidate_zone_args *args)
-{
-	/*
-	 * Ensure that all memory allocations in this context are done as
-	 * if GFP_NOIO was specified.
-	 */
-	unsigned int noio_flag = memalloc_noio_save();
-	struct request_queue *q = disk->queue;
-	int ret;
-
-	args->seq_zones_wlock = blk_alloc_zone_bitmap(q->node, nr_zones);
-	if (!args->seq_zones_wlock)
-		return -ENOMEM;
-	args->conv_zones_bitmap = blk_alloc_zone_bitmap(q->node, nr_zones);
-	if (!args->conv_zones_bitmap)
-		return -ENOMEM;
-
-	ret = disk->fops->report_zones(disk, 0, nr_zones,
-				       blk_revalidate_zone_cb, args);
-	memalloc_noio_restore(noio_flag);
-	return ret;
-}
-
 /**
  * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
  * @disk:	Target disk
@@ -437,8 +425,10 @@ static int blk_update_zone_info(struct gendisk *disk, unsigned int nr_zones,
 int blk_revalidate_disk_zones(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
-	unsigned int nr_zones = blkdev_nr_zones(disk);
-	struct blk_revalidate_zone_args args = { .disk = disk };
+	struct blk_revalidate_zone_args args = {
+		.disk		= disk,
+		.nr_zones	= blkdev_nr_zones(disk),
+	};
 	int ret = 0;
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
@@ -449,12 +439,21 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	 * needs to be updated so that the sysfs exposed value is correct.
 	 */
 	if (!queue_is_mq(q)) {
-		q->nr_zones = nr_zones;
+		q->nr_zones = args.nr_zones;
 		return 0;
 	}
 
-	if (nr_zones)
-		ret = blk_update_zone_info(disk, nr_zones, &args);
+	/*
+	 * Ensure that all memory allocations in this context are done as
+	 * if GFP_NOIO was specified.
+	 */
+	if (args.nr_zones) {
+		unsigned int noio_flag = memalloc_noio_save();
+
+		ret = disk->fops->report_zones(disk, 0, args.nr_zones,
+					       blk_revalidate_zone_cb, &args);
+		memalloc_noio_restore(noio_flag);
+	}
 
 	/*
 	 * Install the new bitmaps, making sure the queue is stopped and
@@ -463,7 +462,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	 */
 	blk_mq_freeze_queue(q);
 	if (ret >= 0) {
-		q->nr_zones = nr_zones;
+		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
 		ret = 0;
-- 
2.20.1

