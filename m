Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB83C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9918F61244
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhESC4v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 22:56:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5175 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbhESC4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 22:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621392930; x=1652928930;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=FLRfn93C5No2NRwuf4VUdJAND3wXj0rw1oDVweHUX84=;
  b=N7W1Prdo2zYCQY0pte/x+ej/uWm1FT/BlI6kVMz4XD+Co8jxMkR/9V4n
   DgLaprdRZ6lF6uwC+ASZZJyPplIYDuTS7fmNcGkOM/Kd4RPYEdhlGlv2P
   kLlXxjNdwDgDCVSq2KHSm1+QYh07ME8SxtGuFiiO6KyVsm9n/AIHFcn/b
   JZPXQL1RBnTvBDuJO7JKVDF7hd8gBMRDKNv+r7GbA6LeJUeTr5lv5mtJ+
   3nkEBdK1TVdyJkRPLgzJeSmwJ0/k9V9tAF98xWyym1LWfgvkeeSRKP16D
   lfAbvdkTzwvwwmOQ4cJEND7bLKb4PFSm2Im0QauAx4MbTRltzDQJaufls
   w==;
IronPort-SDR: kaDqcJe/Nt/VEZUdc8UMvF9hlHVkKI2uomlPfYrCBPdq4SY3GSgFVeOvfqX1prXZ91o3ySZ5WV
 l5kiw/HWKx0T5PNzONEss4XWxUWVAgOqltW7i7IpBtd5EqPqvuMdMHMfJBR0+NgMCd00Ifj+U9
 FfMQtP1KZAC3pU0xA0Z4kr6DVyPIJqouJ8WhSxOP0RJqPyM4ezfKzcWSGTre0YFalhDq+kBznn
 mO9sadQHeyqtQ/Z80DTYCX8ekJrHHtaS5k8INJ5ULDAzPgG3Re8AjruHtNDXtBS9utcBiPpKrg
 Ioc=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173265890"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 10:55:30 +0800
IronPort-SDR: aIXrFdQcAr4dhxOyUptEVpTzJIsV1oslcVRGEBM31K4T1D+66w6CO+MdKjRgM/GrMZAaGOVxWa
 hannOiNjeRgu0Kbgh6N0r95tEUXueevXYvJvg/UOFtgREgeriudt42Ac76JOSURy7GEUUMh7Fw
 gzwpQiBdwNLwe3EXcupNzNeq2H0fBLfaP7A573EpWKDpqxuUMr4oA1+F9rbvFkDlzV5z58jKrx
 qm4oCCJguzWOvmXiIuCXVVAAbJiZZnarEhCNX43Jnyr/776O8jq9yL845R5u3559rPOqxAaGI5
 U/uWHb6O5sj9qn9qdeebUyHV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 19:35:10 -0700
IronPort-SDR: 8SITTY2jLm6Fku0BO26dPB5D0WnriCNYdIYT8ZXHe8re3QsH8BAOrFlQ+CNb8+1DiXBOcdqD1i
 ISsrtcorNNZU2yzzXt7lQOshFPllOB/3RcJ11aCAWqHpDACxVooqn27VUXAsq2HPds0S4SmdeA
 Sm4n8Skv8GvPGv7VMt6Y8qU4bvoGz8Ffh0b2Vydaug7JJymxtC0znOJraFZqnX9xfrdTD9UDeG
 40ikyspNgP3X/D+REMGGsUCsXRtTNP9CF277qvXAlwwY2seFQlAzWKfER3VCtg3/+VXAl0NzfM
 +8Q=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 19:55:31 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] block: improve handling of all zones reset operation
Date:   Wed, 19 May 2021 11:55:19 +0900
Message-Id: <20210519025529.707897-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519025529.707897-1-damien.lemoal@wdc.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SCSI, ZNS and null_blk zoned devices support resetting all zones using
a single command (REQ_OP_ZONE_RESET_ALL), as indicated using the device
request queue flag QUEUE_FLAG_ZONE_RESETALL. This flag is not set for
device mapper targets creating zoned devices. In this case, a user
request for resetting all zones of a device is processed in
blkdev_zone_mgmt() by issuing a REQ_OP_ZONE_RESET operation for each
zone of the device. This leads to different behaviors of the
BLKRESETZONE ioctl() depending on the target device support for the
reset all operation. E.g.

blkzone reset /dev/sdX

will reset all zones of a SCSI device using a single command that will
ignore conventional, read-only or offline zones.

But a dm-linear device including conventional, read-only or offline
zones cannot be reset in the same manner as some of the single zone
reset operations issued by blkdev_zone_mgmt() will fail. E.g.:

blkzone reset /dev/dm-Y
blkzone: /dev/dm-0: BLKRESETZONE ioctl failed: Remote I/O error

To simplify applications and tools development, unify the behavior of
an all-zone reset operation by modifying blkdev_zone_mgmt() to not
issue a zone reset operation for conventional, read-only and offline
zones, thus mimicking what an actual reset-all device command does on a
device supporting REQ_OP_ZONE_RESET_ALL. The zones needing a reset are
identified using a bitmap that is initialized using a zone report.
Since empty zones do not need a reset, also ignore these zones.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c | 87 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 250cb76ee615..13f053c06d9e 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -161,18 +161,30 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
-static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,
-						sector_t sector,
-						sector_t nr_sectors)
+static inline unsigned long *blk_alloc_zone_bitmap(int node,
+						   unsigned int nr_zones)
 {
-	if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))
-		return false;
+	return kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(unsigned long),
+			    GFP_NOIO, node);
+}
 
+static int blk_zone_need_reset_cb(struct blk_zone *zone, unsigned int idx,
+				  void *data)
+{
 	/*
-	 * REQ_OP_ZONE_RESET_ALL can be executed only if the number of sectors
-	 * of the applicable zone range is the entire disk.
+	 * For an all-zones reset, ignore conventional, empty, read-only
+	 * and offline zones.
 	 */
-	return !sector && nr_sectors == get_capacity(bdev->bd_disk);
+	switch (zone->cond) {
+	case BLK_ZONE_COND_NOT_WP:
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_READONLY:
+	case BLK_ZONE_COND_OFFLINE:
+		return 0;
+	default:
+		set_bit(idx, (unsigned long *)data);
+		return 0;
+	}
 }
 
 /**
@@ -199,8 +211,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	sector_t zone_sectors = blk_queue_zone_sectors(q);
 	sector_t capacity = get_capacity(bdev->bd_disk);
 	sector_t end_sector = sector + nr_sectors;
+	unsigned long *need_reset = NULL;
 	struct bio *bio = NULL;
-	int ret;
+	bool reset_all;
+	int ret = 0;
 
 	if (!blk_queue_is_zoned(q))
 		return -EOPNOTSUPP;
@@ -222,16 +236,44 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
 		return -EINVAL;
 
+	/*
+	 * In the case of a zone reset operation over all zones,
+	 * REQ_OP_ZONE_RESET_ALL can be used with devices supporting this
+	 * command. For other devices, we emulate this command behavior by
+	 * identifying the zones needing a reset.
+	 */
+	reset_all = op == REQ_OP_ZONE_RESET &&
+		!sector && nr_sectors == capacity;
+	if (reset_all && !blk_queue_zone_resetall(q)) {
+		need_reset = blk_alloc_zone_bitmap(q->node, q->nr_zones);
+		if (!need_reset)
+			return -ENOMEM;
+		ret = bdev->bd_disk->fops->report_zones(bdev->bd_disk, 0,
+					q->nr_zones, blk_zone_need_reset_cb,
+					need_reset);
+		if (ret < 0)
+			return ret;
+		ret = 0;
+	}
+
 	while (sector < end_sector) {
-		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio_set_dev(bio, bdev);
 
 		/*
-		 * Special case for the zone reset operation that reset all
-		 * zones, this is useful for applications like mkfs.
+		 * For an all zone reset operation, if the device does not
+		 + support REQ_OP_ZONE_RESET_ALL, skip zones that do not
+		 * need a reset.
 		 */
-		if (op == REQ_OP_ZONE_RESET &&
-		    blkdev_allow_reset_all_zones(bdev, sector, nr_sectors)) {
+		if (reset_all && !blk_queue_zone_resetall(q) &&
+		    !test_bit(blk_queue_zone_no(q, sector), need_reset)) {
+			sector += zone_sectors;
+			continue;
+		}
+
+		bio = blk_next_bio(bio, 0, gfp_mask);
+		bio_set_dev(bio, bdev);
+
+		if (reset_all && blk_queue_zone_resetall(q)) {
+			/* The device supports REQ_OP_ZONE_RESET_ALL */
 			bio->bi_opf = REQ_OP_ZONE_RESET_ALL | REQ_SYNC;
 			break;
 		}
@@ -244,8 +286,12 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		cond_resched();
 	}
 
-	ret = submit_bio_wait(bio);
-	bio_put(bio);
+	if (bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+
+	kfree(need_reset);
 
 	return ret;
 }
@@ -396,13 +442,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
-static inline unsigned long *blk_alloc_zone_bitmap(int node,
-						   unsigned int nr_zones)
-{
-	return kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(unsigned long),
-			    GFP_NOIO, node);
-}
-
 void blk_queue_free_zone_bitmaps(struct request_queue *q)
 {
 	kfree(q->conv_zones_bitmap);
-- 
2.31.1

