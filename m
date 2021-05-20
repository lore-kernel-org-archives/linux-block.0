Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F83C433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BE4611C2
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhETEXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:23:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETEXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484550; x=1653020550;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=En+z6SQhhMqS5YqgbYEJrpwAEtj9dj060SIoCjGstIQ=;
  b=CWglqxVy2NvtTBx223MS28V38j3Di3ezIbTGSSxJFcttbYR1Efeacz+/
   HT9o2i5ttcfXkYEHpxXTYIoUJ18eX4GfvAtKEowBycWJtgxEqIwIwRi57
   cGlHenuvHLHw+eiMwUw+oVvtojZXlJNcwxbEyWMq6vmq6a3SdpEtC7roB
   Hf9qr2Loz2KslSry2R5li1UTRaiGnP5G0gTc2JjzItmLRIkSQKTJdmDgH
   YY9VYUVarbrtLvcw77xESAbeDKVPLLKLlmLu/Cu4JjL310cu49NSerryD
   7kTW7Y7w1v6nu1hhCnETokOruaLiinWw2vqjWhP2o+mUEz3n3xLKU+6gr
   g==;
IronPort-SDR: ImI9k1e0y+oHMH9AC8lWS13C2vLNdAIJxlWjPAyKiZ5K5R0xIJUDtuzyfbL/eT6mdVNhuoa/BA
 b9nTq9GbvQ8t+cOx5Tr939zK1UCVZqlO6tLzVAxmkhnBGFHkE7nfD8o8vMGnJuVFOj5br3HKD3
 EfiuC/iA/8ZfwZcffmMRPhTnqa0Hf7hb6nvXkCtUN7alGk2Q1jbw2wi8Yl81545WOZNuWzKmv/
 9CFl/6Ny9Xf8gDBfX4OPMEs3T4MRzEHwrFe/qMEWIptXcL64GmiHg+nmdjz9kPIcB7LbamJpG2
 +/k=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105831"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:30 +0800
IronPort-SDR: Bau0DUBV/oBQDP21Ef8TJlBm14upRm1nbYU5JM9D/mS9O7skthtD5pvW0Vf687uElAHwbLEApr
 B9/m4dj3VoZg54XGlOr8yimNyRJ9iPPO7PBvYS0MsfcgONhIHcAbQqxoOrVJuAAjY/BVu/XGsZ
 rHnBAyDFKtbLgzQbt5pX+kXGbMywdvKh5/in7W4dKjvjWT1BNa/VL2DSEwTsHvCbj00XBzD+WL
 79TGpOG3JRd3eYuGDbEE7qF3u99JjrzUikmdAi8E6UhD/2CnC9YE2YsOgQR0ld0RfRZSuuAAN0
 Y4STprFfb9XIh4oGqfKFvWnO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:07 -0700
IronPort-SDR: gt6MzuvMay/jelRNeh6XVooUj61ms8LYauZTwb79ZgHR3WRXwuZKhb1HuHrOBzH5pQGZbR6iho
 oHAZdnaizDkMaS3rJCjgxW8RjnIFLDBhJznfuQ9kaoGjJD5h8SspKAuxrufwf83g3F47Tmjxyq
 RMxesU2q+qUhIh6T9G6gpcwfz2nspjZUF1/Mlet+SWcDCA2Q36uvTfuT/q0V9QlrCAeecf94PI
 bid4PXCYWV4snetOBMWD1UrPUqfOypNLS0hVgOBz2wNha5+3AqLicsuPFhg6+c/KMBYaQ+yW37
 voI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:29 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 01/11] block: improve handling of all zones reset operation
Date:   Thu, 20 May 2021 13:22:18 +0900
Message-Id: <20210520042228.974083-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520042228.974083-1-damien.lemoal@wdc.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
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
the all-zone reset operation by modifying blkdev_zone_mgmt() to not
issue a zone reset operation for conventional, read-only and offline
zones, thus mimicking what an actual reset-all device command does on a
device supporting REQ_OP_ZONE_RESET_ALL. This emulation is done using
the new function blkdev_zone_reset_all_emulated(). The zones needing a
reset are identified using a bitmap that is initialized using a zone
report. Since empty zones do not need a reset, also ignore these zones.
The function blkdev_zone_reset_all() is introduced for block devices
natively supporting reset all operations. blkdev_zone_mgmt() is modified
to call either function to execute an all zone reset request.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
[hch: split into multiple functions]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 117 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 27 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 250cb76ee615..0ded16b0f713 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -161,18 +161,87 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
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
+}
+
+static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
+					  gfp_t gfp_mask)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	sector_t capacity = get_capacity(bdev->bd_disk);
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+	unsigned long *need_reset;
+	struct bio *bio = NULL;
+	sector_t sector;
+	int ret;
+
+	need_reset = blk_alloc_zone_bitmap(q->node, q->nr_zones);
+	if (!need_reset)
+		return -ENOMEM;
+
+	ret = bdev->bd_disk->fops->report_zones(bdev->bd_disk, 0,
+				q->nr_zones, blk_zone_need_reset_cb,
+				need_reset);
+	if (ret < 0)
+		goto out_free_need_reset;
+
+	ret = 0;
+	while (sector < capacity) {
+		if (!test_bit(blk_queue_zone_no(q, sector), need_reset)) {
+			sector += zone_sectors;
+			continue;
+		}
+		bio = blk_next_bio(bio, 0, gfp_mask);
+		bio_set_dev(bio, bdev);
+		bio->bi_opf = REQ_OP_ZONE_RESET | REQ_SYNC;
+		bio->bi_iter.bi_sector = sector;
+		sector += zone_sectors;
+
+		/* This may take a while, so be nice to others */
+		cond_resched();
+	}
+
+	if (bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+
+out_free_need_reset:
+	kfree(need_reset);
+	return ret;
+}
+
+static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
+{
+	struct bio bio;
+
+	bio_init(&bio, NULL, 0);
+	bio_set_dev(&bio, bdev);
+	bio.bi_opf = REQ_OP_ZONE_RESET_ALL | REQ_SYNC;
+	return submit_bio_wait(&bio);
 }
 
 /**
@@ -200,7 +269,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	sector_t capacity = get_capacity(bdev->bd_disk);
 	sector_t end_sector = sector + nr_sectors;
 	struct bio *bio = NULL;
-	int ret;
+	int ret = 0;
 
 	if (!blk_queue_is_zoned(q))
 		return -EOPNOTSUPP;
@@ -222,20 +291,21 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
 		return -EINVAL;
 
+	/*
+	 * In the case of a zone reset operation over all zones,
+	 * REQ_OP_ZONE_RESET_ALL can be used with devices supporting this
+	 * command. For other devices, we emulate this command behavior by
+	 * identifying the zones needing a reset.
+	 */
+	if (op == REQ_OP_ZONE_RESET && sector == 0 && nr_sectors == capacity) {
+		if (!blk_queue_zone_resetall(q))
+			return blkdev_zone_reset_all_emulated(bdev, gfp_mask);
+		return blkdev_zone_reset_all(bdev, gfp_mask);
+	}
+
 	while (sector < end_sector) {
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio_set_dev(bio, bdev);
-
-		/*
-		 * Special case for the zone reset operation that reset all
-		 * zones, this is useful for applications like mkfs.
-		 */
-		if (op == REQ_OP_ZONE_RESET &&
-		    blkdev_allow_reset_all_zones(bdev, sector, nr_sectors)) {
-			bio->bi_opf = REQ_OP_ZONE_RESET_ALL | REQ_SYNC;
-			break;
-		}
-
 		bio->bi_opf = op | REQ_SYNC;
 		bio->bi_iter.bi_sector = sector;
 		sector += zone_sectors;
@@ -396,13 +466,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
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

