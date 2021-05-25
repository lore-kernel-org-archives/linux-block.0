Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B5EC47087
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF696138C
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhEYV0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36430 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhEYV0f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977905; x=1653513905;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HZ9nR2Wt42duKB9VuSB+rN7vKo5fCE+w/TkjdyuaIWU=;
  b=nznf1nz675X/RygMqHQmYJ+3w935Wf+i/eVXjWd9H8shPbcCTdqMA6+C
   7mdvYFGfYbc+/z+Gc7gFpK9TlHlupTlFcyM/RAm5lTJlsIsCCdU4u4MxH
   MjqXgeFjvg31JXV6eDzkQzKfkRQr28Hb+Iefg5LRwIiuEljPGqAd0jsBH
   UBdhgB2ZjWpEBhoGEBkfsMAHvA/GfAh5IOQAZHp3q5iWWTs62W9ibg7r5
   et2q+3Ey72mivdDsXivzVzX4vv5Mf8ZoDtTrHnDUDNVqer+pS04QWmaXW
   XBCJYNxWrguXVtbVdgW3DdfYgJ4ztvs66ZiSujWc64kND3ybKu2yT4moQ
   Q==;
IronPort-SDR: yjJ5SRO19Fkg17LQ6JZJNXdy2LhfjX1uLlHi3TbESUrBgv9Y6uaectNRn9YBG6CzkKew0FnAAe
 J286kbU0cL1KzwenW+dGkYDOTZIebV/JPtYV98daWy5o//2owOQTPHxvsla/yh6Julnck4ywt9
 AgmSnoPxmxOd+AMKpJ66uEaGHnaVA9E3btBscv3KDpFmg8ijoLDOt0nZKXgz+DszslM/WsBRHg
 IywCg7PZYnddDyYHCsI0v5IlpjAKCRz5zfpuiiz77+5oG4iwwucqqOwkIXHFxqi+RCqYGWA9IO
 9/I=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717511"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:05 +0800
IronPort-SDR: SNXme9tGNxRjyOuwPa8+XJyiodwcNwnQbHdPSVdA1/bI/rubuq5lwVfHxqWS1QGr/rPGw+R5Dy
 PNJanEA+WFrSrA7ZLBXC36Lz4+L2XUhc1w7X9/UbvBKAEoOuOnkdhDW/3A9qDff/1nCNVEHZGx
 +CTqLJmABfoc8SBtz5EkWwVfWOhhhXSYt8NMEfPuDDncur1JgWRgT/fPAfE9WP+P/EUbwsagxz
 sIx5h+c9k8xBXX4Y9qLcchF9MRXGPzkOWhOdylHzbP3Xv7G1Fxq+koJtT5V1HJBpbpT8gc0lhI
 3C/1Vi8m3K6MeQWoS8NnEDeB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:32 -0700
IronPort-SDR: JXYChdx1ksGzEd1nsxFuICFcsVeq3qezQ9YjTp4HHfAm48yAJ4QYFmSuJzzl+J7CCn7wDZV6Nf
 qEtxIRVtV86UZxLbGnvbenK6EqJ8cBxtzhep30GM5ZokG4PGzvOG4ao2vM7cTS+4F9d1UrqHEs
 dWr5l6wGPWvs5OmWCN0ZKZkNeqNjb/syemoUm1v+HW/c8NGzmwIUe4mA4LAtZPWsAr4gIq7xYO
 lUJbnAdfpS0VEhUYMLNGqZ1GnRPkh+9YJvdvzrk6MUbvNr4f4XeIGxAqbJ9CcAGr8Ma9PxBXSB
 /2U=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:05 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 01/11] block: improve handling of all zones reset operation
Date:   Wed, 26 May 2021 06:24:51 +0900
Message-Id: <20210525212501.226888-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 119 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 92 insertions(+), 27 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 250cb76ee615..86fce751bb17 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -161,18 +161,89 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
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
+	sector_t sector = 0;
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
+
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
+
+	return submit_bio_wait(&bio);
 }
 
 /**
@@ -200,7 +271,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	sector_t capacity = get_capacity(bdev->bd_disk);
 	sector_t end_sector = sector + nr_sectors;
 	struct bio *bio = NULL;
-	int ret;
+	int ret = 0;
 
 	if (!blk_queue_is_zoned(q))
 		return -EOPNOTSUPP;
@@ -222,20 +293,21 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
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
@@ -396,13 +468,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
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

