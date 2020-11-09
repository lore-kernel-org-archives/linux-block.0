Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1812C2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862DE20657
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UDBj8eHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgKIMvg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:51:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43853 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgKIMvR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 07:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604926276; x=1636462276;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/sqLQMfQYenx55jJTXo6s06gN8iuh66SJUBivy49YyU=;
  b=UDBj8eHElw+gjHvP0v/i3pidz9+EccgfHQTf4FLqaP8OsjyrWoicRMl5
   wuvdy3rWCy/wRogE9U5fZh8F8Zjw7RID+QNA7DdwCvJ1wM+kIm5RDsWYi
   vot5PCFAMpW26+6JmKm2PxQPEPAj2H4Vb8x19QRk0386KpGZmCxp7uWqi
   VHU2RcpWA5/W6HgqbbEczODqS3pDx79u0z/gBlK5FUCeFP2wubcEluY6z
   JCsIOImU+fAUkVcucIrjCI6meKdW7s/FteXAG5W60vXAmEHTMuzJtQdV9
   CIExS3pBth8Ft+8i3cyE9YP6wbz5vMQkkwTPqsFI4YvfbYTrcDJlMPL9U
   w==;
IronPort-SDR: LCtefJWtbe7/wpNcoeWY+hTIIhKM1upcutmfByfpSIzvlycrPLuuKchrdygisR5aXqq804or1Q
 BTJJNLrKJMwRCyvUktC788eziphMZRFoVvgy9cxZF7QunzeODPFYPEmOOqih19TNJ1OFJU5ZOv
 LZTqQ6ktyDsd1RTNz5YjDcYl2YCgkd6bnCzE6hg/jZVtCkeYmewxDFtzLk2XY1usOMg1alvhv7
 MNw9vBE8P6LkSdFXubOVKiXRFxNDq79jAqZwOw968pqlDGaT71HLpmgswSQ/y/SuruiGpDOMQ9
 l+M=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="156668399"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 20:51:10 +0800
IronPort-SDR: NlPyOZ3ZbXhmVq7guy/PhCzyOdXmYNeXfdJTBP8dUcjl+6ynNwJebbu9YaMj07rQ6Mo15g+sdE
 hXzDqniaOOf4KFfWiAp545MyexnJFBZYGsjjBlNkCDvQPMBPKtInBHsILNmS1grrINQEDi3Za+
 XQrIARfl2BYVCHNzV25WmowoSPegvsG/jIL54WsecNpopp2aQk0OnZs5PJXf4oH7D/jj9LOdI7
 ypc6C+Kq2JCOeFjebdH4e1eEHuJ8iAI85yv1pSABt0aEDUqyTXcp3cqZ1rULFU4yCYc0gN52t1
 KPnX5DyUEVPVJv+PDxJ+TpmS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:37:12 -0800
IronPort-SDR: qoRODy154LBciMFwfeqQY4IPNT4eBZNd0t5C/HcvEsLZdN/A8kc3hL7RjX5hF5cSTRFZcm+vKM
 ObrLeC3DrZ7CjPDbzDM9v+plR5F3UPDCMnvay/WXMJexQDP4goceHIYPtuU1qvJlpRW8owwHqi
 U7m6KVSzz8uJkjyRPU2zzWJSGeSjWxE7XRJvG2sS2+qFC2Xq2SUoXQNL04DEzKYecHDNhnwJdm
 cXU8+K5I/lcnyp1UesxoIGC/tofOJGnBCJ6lVUWXH+ZPW1wRNXJhPGGboT1Q/kNc8vfLe69Isb
 qeU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 04:51:10 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] null_blk: improve zone locking
Date:   Mon,  9 Nov 2020 21:51:01 +0900
Message-Id: <20201109125105.551734-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109125105.551734-1-damien.lemoal@wdc.com>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With memory backing disabled, using a single spinlock for protecting
zone information and zone resource management prevent the parallel
execution on multiple queue of IO requests to different zones.
Furthermore, regardless of the use of memory backing, if a null_blk
device is created without limits on the number of opn and active zones,
accounting for zone resource management is not necessary.

From these observations, zone locking is changed as follow to improve
performance:
1) the zone_lock spinlock is renamed zone_res_lock and used only if zone
   resource management is necessary, that is, if either zone_max_open or
   zone_max_active are not 0. This is indicated using the new boolean
   need_zone_res_mgmt in the nullb_device structure. null_zone_write()
   is modified to reduce the amount of code executed with the
   zone_res_lock spinlock held. null_zone_valid_read_len() is also
   modified to avoid taking the zone lock before calling
   null_process_cmd() for read operations in null_process_zoned_cmd().
2) With memory backing disabled, per zone locking is changed to a
   spinlock per zone.

With these changes, fio performance with zonemode=zbd for 4K random
read and random write on a dual socket (24 cores per socket) machine
using the none schedulder is as follows:

before patch:
	write (psync x 96 jobs) = 465 KIOPS
	read (libaio@qd=8 x 96 jobs) = 1361 KIOPS
after patch:
	write (psync x 96 jobs) = 468 KIOPS
	read (libaio@qd=8 x 96 jobs) = 3340 KIOPS

Write performance remains mostly unchanged but read performance more
than double. Performance when using the mq-deadline scheduler is not
changed by this patch as mq-deadline becomes the bottleneck for a
multi-queue device.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       |   5 +-
 drivers/block/null_blk_zoned.c | 192 +++++++++++++++++++++------------
 2 files changed, 126 insertions(+), 71 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index c24d9b5ad81a..4c101c39c3d1 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -47,8 +47,9 @@ struct nullb_device {
 	unsigned int nr_zones_closed;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
-	spinlock_t zone_lock;
-	unsigned long *zone_locks;
+	bool need_zone_res_mgmt;
+	spinlock_t zone_res_lock;
+	void *zone_locks;
 
 	unsigned long size; /* device size in MB */
 	unsigned long completion_nsec; /* time in ns to complete a request */
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 18911e67f792..b2812ee01d3d 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -58,13 +58,15 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	 * wait_on_bit_lock_io(). Sleeping on the lock is OK as memory backing
 	 * implies that the queue is marked with BLK_MQ_F_BLOCKING.
 	 */
-	spin_lock_init(&dev->zone_lock);
-	if (dev->memory_backed) {
+	spin_lock_init(&dev->zone_res_lock);
+	if (dev->memory_backed)
 		dev->zone_locks = bitmap_zalloc(dev->nr_zones, GFP_KERNEL);
-		if (!dev->zone_locks) {
-			kvfree(dev->zones);
-			return -ENOMEM;
-		}
+	else
+		dev->zone_locks = kmalloc_array(dev->nr_zones,
+						sizeof(spinlock_t), GFP_KERNEL);
+	if (!dev->zone_locks) {
+		kvfree(dev->zones);
+		return -ENOMEM;
 	}
 
 	if (dev->zone_nr_conv >= dev->nr_zones) {
@@ -88,10 +90,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		dev->zone_max_open = 0;
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
 	}
+	dev->need_zone_res_mgmt = dev->zone_max_active || dev->zone_max_open;
 
 	for (i = 0; i <  dev->zone_nr_conv; i++) {
 		struct blk_zone *zone = &dev->zones[i];
 
+		if (!dev->memory_backed)
+			spin_lock_init((spinlock_t *)dev->zone_locks + i);
+
 		zone->start = sector;
 		zone->len = dev->zone_size_sects;
 		zone->capacity = zone->len;
@@ -105,6 +111,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
 		struct blk_zone *zone = &dev->zones[i];
 
+		if (!dev->memory_backed)
+			spin_lock_init((spinlock_t *)dev->zone_locks + i);
+
 		zone->start = zone->wp = sector;
 		if (zone->start + dev->zone_size_sects > dev_capacity)
 			zone->len = dev_capacity - zone->start;
@@ -149,23 +158,41 @@ int null_register_zoned_dev(struct nullb *nullb)
 
 void null_free_zoned_dev(struct nullb_device *dev)
 {
-	bitmap_free(dev->zone_locks);
+	if (dev->memory_backed)
+		bitmap_free(dev->zone_locks);
+	else
+		kfree(dev->zone_locks);
 	kvfree(dev->zones);
 }
 
+#define null_lock_zone_res(dev, flags)					\
+	do {								\
+		if ((dev)->need_zone_res_mgmt)				\
+			spin_lock_irqsave(&(dev)->zone_res_lock,	\
+					  (flags));			\
+	} while (0)
+
+#define null_unlock_zone_res(dev, flags)				\
+	do {								\
+		if ((dev)->need_zone_res_mgmt)				\
+			spin_unlock_irqrestore(&(dev)->zone_res_lock,	\
+					       (flags));		\
+	} while (0)
+
 static inline void null_lock_zone(struct nullb_device *dev, unsigned int zno)
 {
 	if (dev->memory_backed)
 		wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);
-	spin_lock_irq(&dev->zone_lock);
+	else
+		spin_lock_irq((spinlock_t *)dev->zone_locks + zno);
 }
 
 static inline void null_unlock_zone(struct nullb_device *dev, unsigned int zno)
 {
-	spin_unlock_irq(&dev->zone_lock);
-
 	if (dev->memory_backed)
 		clear_and_wake_up_bit(zno, dev->zone_locks);
+	else
+		spin_unlock_irq((spinlock_t *)dev->zone_locks + zno);
 }
 
 int null_report_zones(struct gendisk *disk, sector_t sector,
@@ -226,11 +253,9 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 	return (zone->wp - sector) << SECTOR_SHIFT;
 }
 
-static blk_status_t null_close_zone(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t __null_close_zone(struct nullb_device *dev,
+				      struct blk_zone *zone)
 {
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-		return BLK_STS_IOERR;
-
 	switch (zone->cond) {
 	case BLK_ZONE_COND_CLOSED:
 		/* close operation on closed is not an error */
@@ -263,7 +288,7 @@ static void null_close_first_imp_zone(struct nullb_device *dev)
 
 	for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
 		if (dev->zones[i].cond == BLK_ZONE_COND_IMP_OPEN) {
-			null_close_zone(dev, &dev->zones[i]);
+			__null_close_zone(dev, &dev->zones[i]);
 			return;
 		}
 	}
@@ -337,6 +362,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zno];
+	unsigned long flags;
 	blk_status_t ret;
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
@@ -346,24 +372,10 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	null_lock_zone(dev, zno);
 
-	switch (zone->cond) {
-	case BLK_ZONE_COND_FULL:
+	if (zone->cond == BLK_ZONE_COND_FULL) {
 		/* Cannot write to a full zone */
 		ret = BLK_STS_IOERR;
 		goto unlock;
-	case BLK_ZONE_COND_EMPTY:
-	case BLK_ZONE_COND_CLOSED:
-		ret = null_check_zone_resources(dev, zone);
-		if (ret != BLK_STS_OK)
-			goto unlock;
-		break;
-	case BLK_ZONE_COND_IMP_OPEN:
-	case BLK_ZONE_COND_EXP_OPEN:
-		break;
-	default:
-		/* Invalid zone condition */
-		ret = BLK_STS_IOERR;
-		goto unlock;
 	}
 
 	/*
@@ -388,37 +400,43 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		goto unlock;
 	}
 
-	if (zone->cond == BLK_ZONE_COND_CLOSED) {
-		dev->nr_zones_closed--;
-		dev->nr_zones_imp_open++;
-	} else if (zone->cond == BLK_ZONE_COND_EMPTY) {
-		dev->nr_zones_imp_open++;
+	if (zone->cond == BLK_ZONE_COND_CLOSED ||
+	    zone->cond == BLK_ZONE_COND_EMPTY) {
+		null_lock_zone_res(dev, flags);
+
+		ret = null_check_zone_resources(dev, zone);
+		if (ret != BLK_STS_OK) {
+			null_unlock_zone_res(dev, flags);
+			goto unlock;
+		}
+		if (zone->cond == BLK_ZONE_COND_CLOSED) {
+			dev->nr_zones_closed--;
+			dev->nr_zones_imp_open++;
+		} else if (zone->cond == BLK_ZONE_COND_EMPTY) {
+			dev->nr_zones_imp_open++;
+		}
+
+		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
+			zone->cond = BLK_ZONE_COND_IMP_OPEN;
+
+		null_unlock_zone_res(dev, flags);
 	}
-	if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
-		zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
-	/*
-	 * Memory backing allocation may sleep: release the zone_lock spinlock
-	 * to avoid scheduling in atomic context. Zone operation atomicity is
-	 * still guaranteed through the zone_locks bitmap.
-	 */
-	if (dev->memory_backed)
-		spin_unlock_irq(&dev->zone_lock);
 	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
-	if (dev->memory_backed)
-		spin_lock_irq(&dev->zone_lock);
-
 	if (ret != BLK_STS_OK)
 		goto unlock;
 
 	zone->wp += nr_sectors;
 	if (zone->wp == zone->start + zone->capacity) {
+		null_lock_zone_res(dev, flags);
 		if (zone->cond == BLK_ZONE_COND_EXP_OPEN)
 			dev->nr_zones_exp_open--;
 		else if (zone->cond == BLK_ZONE_COND_IMP_OPEN)
 			dev->nr_zones_imp_open--;
 		zone->cond = BLK_ZONE_COND_FULL;
+		null_unlock_zone_res(dev, flags);
 	}
+
 	ret = BLK_STS_OK;
 
 unlock:
@@ -429,19 +447,22 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zone)
 {
-	blk_status_t ret;
+	blk_status_t ret = BLK_STS_OK;
+	unsigned long flags;
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
+	null_lock_zone_res(dev, flags);
+
 	switch (zone->cond) {
 	case BLK_ZONE_COND_EXP_OPEN:
 		/* open operation on exp open is not an error */
-		return BLK_STS_OK;
+		goto unlock;
 	case BLK_ZONE_COND_EMPTY:
 		ret = null_check_zone_resources(dev, zone);
 		if (ret != BLK_STS_OK)
-			return ret;
+			goto unlock;
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 		dev->nr_zones_imp_open--;
@@ -449,35 +470,57 @@ static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zo
 	case BLK_ZONE_COND_CLOSED:
 		ret = null_check_zone_resources(dev, zone);
 		if (ret != BLK_STS_OK)
-			return ret;
+			goto unlock;
 		dev->nr_zones_closed--;
 		break;
 	case BLK_ZONE_COND_FULL:
 	default:
-		return BLK_STS_IOERR;
+		ret = BLK_STS_IOERR;
+		goto unlock;
 	}
 
 	zone->cond = BLK_ZONE_COND_EXP_OPEN;
 	dev->nr_zones_exp_open++;
 
-	return BLK_STS_OK;
+unlock:
+	null_unlock_zone_res(dev, flags);
+
+	return ret;
 }
 
-static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t null_close_zone(struct nullb_device *dev, struct blk_zone *zone)
 {
+	unsigned long flags;
 	blk_status_t ret;
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
+	null_lock_zone_res(dev, flags);
+	ret = __null_close_zone(dev, zone);
+	null_unlock_zone_res(dev, flags);
+
+	return ret;
+}
+
+static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	blk_status_t ret = BLK_STS_OK;
+	unsigned long flags;
+
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
+
+	null_lock_zone_res(dev, flags);
+
 	switch (zone->cond) {
 	case BLK_ZONE_COND_FULL:
 		/* finish operation on full is not an error */
-		return BLK_STS_OK;
+		goto unlock;
 	case BLK_ZONE_COND_EMPTY:
 		ret = null_check_zone_resources(dev, zone);
 		if (ret != BLK_STS_OK)
-			return ret;
+			goto unlock;
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 		dev->nr_zones_imp_open--;
@@ -488,27 +531,36 @@ static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *
 	case BLK_ZONE_COND_CLOSED:
 		ret = null_check_zone_resources(dev, zone);
 		if (ret != BLK_STS_OK)
-			return ret;
+			goto unlock;
 		dev->nr_zones_closed--;
 		break;
 	default:
-		return BLK_STS_IOERR;
+		ret = BLK_STS_IOERR;
+		goto unlock;
 	}
 
 	zone->cond = BLK_ZONE_COND_FULL;
 	zone->wp = zone->start + zone->len;
 
-	return BLK_STS_OK;
+unlock:
+	null_unlock_zone_res(dev, flags);
+
+	return ret;
 }
 
 static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *zone)
 {
+	unsigned long flags;
+
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
+	null_lock_zone_res(dev, flags);
+
 	switch (zone->cond) {
 	case BLK_ZONE_COND_EMPTY:
 		/* reset operation on empty is not an error */
+		null_unlock_zone_res(dev, flags);
 		return BLK_STS_OK;
 	case BLK_ZONE_COND_IMP_OPEN:
 		dev->nr_zones_imp_open--;
@@ -522,12 +574,15 @@ static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *z
 	case BLK_ZONE_COND_FULL:
 		break;
 	default:
+		null_unlock_zone_res(dev, flags);
 		return BLK_STS_IOERR;
 	}
 
 	zone->cond = BLK_ZONE_COND_EMPTY;
 	zone->wp = zone->start;
 
+	null_unlock_zone_res(dev, flags);
+
 	return BLK_STS_OK;
 }
 
@@ -587,29 +642,28 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
 				    sector_t sector, sector_t nr_sectors)
 {
-	struct nullb_device *dev = cmd->nq->dev;
-	unsigned int zno = null_zone_no(dev, sector);
+	struct nullb_device *dev;
+	unsigned int zno;
 	blk_status_t sts;
 
 	switch (op) {
 	case REQ_OP_WRITE:
-		sts = null_zone_write(cmd, sector, nr_sectors, false);
-		break;
+		return null_zone_write(cmd, sector, nr_sectors, false);
 	case REQ_OP_ZONE_APPEND:
-		sts = null_zone_write(cmd, sector, nr_sectors, true);
-		break;
+		return null_zone_write(cmd, sector, nr_sectors, true);
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_FINISH:
-		sts = null_zone_mgmt(cmd, op, sector);
-		break;
+		return null_zone_mgmt(cmd, op, sector);
 	default:
+		dev = cmd->nq->dev;
+		zno = null_zone_no(dev, sector);
+
 		null_lock_zone(dev, zno);
 		sts = null_process_cmd(cmd, op, sector, nr_sectors);
 		null_unlock_zone(dev, zno);
+		return sts;
 	}
-
-	return sts;
 }
-- 
2.26.2

