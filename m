Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EF0C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 11:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8997C20759
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 11:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SD4DzZwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgJ2LFE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:05:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48833 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgJ2LFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 07:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603969503; x=1635505503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69l+1pA5379NLsJS+oY9OK8uHs2NsO78DPRtUn9H7LE=;
  b=SD4DzZwh/yEDcPrwzRvLVWHPzxzsGIykpuXGziccyfNfPMIMPRI13x5U
   B7rYk15H79qXF95abEi2u6pqxtjjh1l7k4TtlsRGaOn6HyKX5ZUCWIqm1
   h7lgU2JalsHZ6gxOVaKGi09tmzXjYcZemhK28xSCl92LikS7pym79sz8t
   aDHN1Frv/G35or4WK6ldNg/Wx6IzPk8jWWNhwgmKkRV9XU/o7vXPwYnJb
   0jTf1LVmlYW4dfXBA6iKCdbg0Ml2mEleqav0X2Wp1HwK2/H8QxzVAkFH+
   RN6KJ/loCpevea+wRkjM1tXyR77Asah3DXtDXgTwPfj3HUg1H6LPvAtQj
   Q==;
IronPort-SDR: O3k5uQ/aKM3KBrzAu08SpdT26wRJLYZ5c9kWnBULWvAS/Vc5wPD/KmPuXynXG6dINaotXzMxCx
 RFcDaGhiqoIDKkc1lisV5qFj6gkPkspUK+eVT+VDKKaAi8ixeH9adYCo7lHfnG8kkDV5QmtLKX
 Q4JwZ0/ZwEXtBVxbBIWHDUzUSnf4DfPCTS2aYqWY5MRaBgIr26DIVf/u2JfIeiLu8YKkT3eIYQ
 wEx0yNkc7p2HnbJRubB4snv5/P2k4ZYuC1+12sGD1ucrqKmCt0qhMK2KfZsb+SJeeU12PAUhIq
 Q/g=
X-IronPort-AV: E=Sophos;i="5.77,429,1596470400"; 
   d="scan'208";a="151134630"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 19:05:03 +0800
IronPort-SDR: FZnYSW9iG9tOIApR/6MW8YZKMzkVEMbUDEQn1+g6CS7q6HXyOQm3uuOETRo8K66Cab2TC1HzNn
 0SrFmMOfsRyyzTtPWbGoL8LxKpF9eNbXj+E7bWUFkz17Cz1aOCoRrlfmBR1mbSYL1MQ61IgBJN
 hXfHXjzv7GEMF+buEQmnyZWSZetWO5wwadHBwfj7NEDUKADojn0LT/Cb51U8Q5Nhi/rjxMDl4D
 MVVsmOm7+gT1r/fNPXKxbHsjIZVdtr6mVTGmveRitjHmA2wFli+oqY/pABnlnoiuOs+bO+YUxw
 ZjrqHr830jmFOqWKj+YyyjJH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 03:50:08 -0700
IronPort-SDR: TrqTikFhIBIoUFFkw+fIEkGYHvVZcYBBXUMTMyAGCpeZsfqH3c4050/O3rhNLNB/vUA7DAUNGo
 25Btvtqr4ohM8DzryOGAWc+bFDxP9Dr8DLJRBoGRlXZ4YfZOgBpQmHEL1TYJPWTRTrlo0sOg3U
 Btqw2X/ehPud9MDDo47fZy/wnlr9RJqZ8pUFerVztBpVgaQ4BeOM6/zbbMRovgtD8A/9O5RMuy
 vmnzaJ6O/o9FCo8jpnTspWnT18NCJuK3qQQ88Unl3g+bCuY2B6q4vT45EE6+VGu0KH18pa2sco
 bwg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2020 04:05:04 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/2] null_blk: Fix locking in zoned mode
Date:   Thu, 29 Oct 2020 20:05:00 +0900
Message-Id: <20201029110500.803451-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029110500.803451-1-damien.lemoal@wdc.com>
References: <20201029110500.803451-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the zoned mode is enabled in null_blk, Serializing read, write
and zone management operations for each zone is necessary to protect
device level information for managing zone resources (zone open and
closed counters) as well as each zone condition and write pointer
position. Commit 35bc10b2eafb ("null_blk: synchronization fix for
zoned device") introduced a spinlock to implement this serialization.
However, when memory backing is also enabled, GFP_NOIO memory
allocations are executed under the spinlock, resulting in might_sleep()
warnings. Furthermore, the zone_lock spinlock is locked/unlocked using
spin_lock_irq/spin_unlock_irq, similarly to the memory backing code with
the nullb->lock spinlock. This nested use of irq locks wrecks the irq
enabled/disabled state.

Fix all this by introducing a bitmap for per-zone lock, with locking
implemented using wait_on_bit_lock_io() and clear_and_wake_up_bit().
This locking mechanism allows keeping a zone locked while executing
null_process_cmd(), serializing all operations to the zone while
allowing to sleep during memory backing allocation with GFP_NOIO.
Device level zone resource management information is protected using
a spinlock which is not held while executing null_process_cmd();

Fixes: 35bc10b2eafb ("null_blk: synchronization fix for zoned device")
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       |   3 +-
 drivers/block/null_blk_zoned.c | 104 +++++++++++++++++++++++++--------
 2 files changed, 82 insertions(+), 25 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 3176b269b822..cfd00ad40355 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -47,7 +47,8 @@ struct nullb_device {
 	unsigned int nr_zones_closed;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
-	spinlock_t zone_lock;
+	spinlock_t zone_dev_lock;
+	unsigned long *zone_locks;
 
 	unsigned long size; /* device size in MB */
 	unsigned long completion_nsec; /* time in ns to complete a request */
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index b637b16a5f54..8775acbb4f8f 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/vmalloc.h>
+#include <linux/bitmap.h>
 #include "null_blk.h"
 
 #define CREATE_TRACE_POINTS
@@ -45,7 +46,13 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	if (!dev->zones)
 		return -ENOMEM;
 
-	spin_lock_init(&dev->zone_lock);
+	spin_lock_init(&dev->zone_dev_lock);
+	dev->zone_locks = bitmap_zalloc(dev->nr_zones, GFP_KERNEL);
+	if (!dev->zone_locks) {
+		kvfree(dev->zones);
+		return -ENOMEM;
+	}
+
 	if (dev->zone_nr_conv >= dev->nr_zones) {
 		dev->zone_nr_conv = dev->nr_zones - 1;
 		pr_info("changed the number of conventional zones to %u",
@@ -124,15 +131,26 @@ int null_register_zoned_dev(struct nullb *nullb)
 
 void null_free_zoned_dev(struct nullb_device *dev)
 {
+	bitmap_free(dev->zone_locks);
 	kvfree(dev->zones);
 }
 
+static inline void null_lock_zone(struct nullb_device *dev, unsigned int zno)
+{
+	wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);
+}
+
+static inline void null_unlock_zone(struct nullb_device *dev, unsigned int zno)
+{
+	clear_and_wake_up_bit(zno, dev->zone_locks);
+}
+
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct nullb *nullb = disk->private_data;
 	struct nullb_device *dev = nullb->dev;
-	unsigned int first_zone, i;
+	unsigned int first_zone, i, zno;
 	struct blk_zone zone;
 	int error;
 
@@ -143,17 +161,17 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 	nr_zones = min(nr_zones, dev->nr_zones - first_zone);
 	trace_nullb_report_zones(nullb, nr_zones);
 
-	for (i = 0; i < nr_zones; i++) {
+	zno = first_zone;
+	for (i = 0; i < nr_zones; i++, zno++) {
 		/*
 		 * Stacked DM target drivers will remap the zone information by
 		 * modifying the zone information passed to the report callback.
 		 * So use a local copy to avoid corruption of the device zone
 		 * array.
 		 */
-		spin_lock_irq(&dev->zone_lock);
-		memcpy(&zone, &dev->zones[first_zone + i],
-		       sizeof(struct blk_zone));
-		spin_unlock_irq(&dev->zone_lock);
+		null_lock_zone(dev, zno);
+		memcpy(&zone, &dev->zones[zno], sizeof(struct blk_zone));
+		null_unlock_zone(dev, zno);
 
 		error = cb(&zone, i, data);
 		if (error)
@@ -163,6 +181,10 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 	return nr_zones;
 }
 
+/*
+ * This is called in the case of memory backing from null_process_cmd()
+ * with the target zone already locked.
+ */
 size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len)
 {
@@ -299,22 +321,27 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
 
+	null_lock_zone(dev, zno);
+	spin_lock(&dev->zone_dev_lock);
+
 	switch (zone->cond) {
 	case BLK_ZONE_COND_FULL:
 		/* Cannot write to a full zone */
-		return BLK_STS_IOERR;
+		ret = BLK_STS_IOERR;
+		goto unlock;
 	case BLK_ZONE_COND_EMPTY:
 	case BLK_ZONE_COND_CLOSED:
 		ret = null_check_zone_resources(dev, zone);
 		if (ret != BLK_STS_OK)
-			return ret;
+			goto unlock;
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
 		break;
 	default:
 		/* Invalid zone condition */
-		return BLK_STS_IOERR;
+		ret = BLK_STS_IOERR;
+		goto unlock;
 	}
 
 	/*
@@ -330,11 +357,14 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		else
 			cmd->rq->__sector = sector;
 	} else if (sector != zone->wp) {
-		return BLK_STS_IOERR;
+		ret = BLK_STS_IOERR;
+		goto unlock;
 	}
 
-	if (zone->wp + nr_sectors > zone->start + zone->capacity)
-		return BLK_STS_IOERR;
+	if (zone->wp + nr_sectors > zone->start + zone->capacity) {
+		ret = BLK_STS_IOERR;
+		goto unlock;
+	}
 
 	if (zone->cond == BLK_ZONE_COND_CLOSED) {
 		dev->nr_zones_closed--;
@@ -345,9 +375,11 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 		zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
+	spin_unlock(&dev->zone_dev_lock);
 	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
+	spin_lock(&dev->zone_dev_lock);
 	if (ret != BLK_STS_OK)
-		return ret;
+		goto unlock;
 
 	zone->wp += nr_sectors;
 	if (zone->wp == zone->start + zone->capacity) {
@@ -357,7 +389,13 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			dev->nr_zones_imp_open--;
 		zone->cond = BLK_ZONE_COND_FULL;
 	}
-	return BLK_STS_OK;
+	ret = BLK_STS_OK;
+
+unlock:
+	spin_unlock(&dev->zone_dev_lock);
+	null_unlock_zone(dev, zno);
+
+	return ret;
 }
 
 static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zone)
@@ -468,21 +506,33 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 				   sector_t sector)
 {
 	struct nullb_device *dev = cmd->nq->dev;
-	unsigned int zone_no = null_zone_no(dev, sector);
-	struct blk_zone *zone = &dev->zones[zone_no];
-	blk_status_t ret = BLK_STS_OK;
+	unsigned int zone_no;
+	struct blk_zone *zone;
+	blk_status_t ret;
 	size_t i;
 
-	switch (op) {
-	case REQ_OP_ZONE_RESET_ALL:
+	if (op == REQ_OP_ZONE_RESET_ALL) {
 		for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
+			null_lock_zone(dev, i);
 			zone = &dev->zones[i];
 			if (zone->cond != BLK_ZONE_COND_EMPTY) {
+				spin_lock(&dev->zone_dev_lock);
 				null_reset_zone(dev, zone);
+				spin_unlock(&dev->zone_dev_lock);
 				trace_nullb_zone_op(cmd, i, zone->cond);
 			}
+			null_unlock_zone(dev, i);
 		}
 		return BLK_STS_OK;
+	}
+
+	zone_no = null_zone_no(dev, sector);
+	zone = &dev->zones[zone_no];
+
+	null_lock_zone(dev, zone_no);
+	spin_lock(&dev->zone_dev_lock);
+
+	switch (op) {
 	case REQ_OP_ZONE_RESET:
 		ret = null_reset_zone(dev, zone);
 		break;
@@ -496,22 +546,27 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 		ret = null_finish_zone(dev, zone);
 		break;
 	default:
-		return BLK_STS_NOTSUPP;
+		ret = BLK_STS_NOTSUPP;
+		break;
 	}
 
+	spin_unlock(&dev->zone_dev_lock);
+
 	if (ret == BLK_STS_OK)
 		trace_nullb_zone_op(cmd, zone_no, zone->cond);
 
+	null_unlock_zone(dev, zone_no);
+
 	return ret;
 }
 
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
 				    sector_t sector, sector_t nr_sectors)
 {
-	blk_status_t sts;
 	struct nullb_device *dev = cmd->nq->dev;
+	unsigned int zno = null_zone_no(dev, sector);
+	blk_status_t sts;
 
-	spin_lock_irq(&dev->zone_lock);
 	switch (op) {
 	case REQ_OP_WRITE:
 		sts = null_zone_write(cmd, sector, nr_sectors, false);
@@ -527,9 +582,10 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
 		sts = null_zone_mgmt(cmd, op, sector);
 		break;
 	default:
+		null_lock_zone(dev, zno);
 		sts = null_process_cmd(cmd, op, sector, nr_sectors);
+		null_unlock_zone(dev, zno);
 	}
-	spin_unlock_irq(&dev->zone_lock);
 
 	return sts;
 }
-- 
2.26.2

