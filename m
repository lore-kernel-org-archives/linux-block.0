Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C883DC55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D6820809
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LK/bpd7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKKNA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:00:57 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32529 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgKKNA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099655; x=1636635655;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qcYCwdTa7MEOA2G0DIVgHokzSg7yN1zFCVytEw1esTw=;
  b=LK/bpd7RFRZmy+UotoH0FDyO83I3N2Iyd9Df/A6UhpR+sAAMafQZUhfl
   qeb8W5fcRZ9yr1oJDqiR92aJ5xEUn+PKCvQTzVp/seP1Xt+jcywxS/4TK
   C0J+w0G5M2cGxjqDc0n830eOujZGko3NAEY4zGPJU5I6qocM4U79pR2Li
   JDzMe80qdJRS1DxaPEqoD9AjmmAMRHTQ0CywZ4uUx4X5lu/pft5ja2Gk2
   I5pW+khnEwjjqTJoq2bfm0MpkP+TbZvZeIl41r54mDei8j1U9MRDZx9sA
   KKPlTNuyo9WlH/hchNZsEYrC+zk1f1zdzXsBJzPVq7nucx8zyr4u9y4CS
   Q==;
IronPort-SDR: Tx+k23CiCYTgAJBHvYqvBcOJtmsOQVdpkuNi/0S/Cs8Ktj9SEAiBqIWd4j7Lo4mdKAOMv/Fd6X
 V9cJMPz6iuGcmuwwMM7wSZaq2sm5By0HKuQQBVMjWZx3KyW8aLTCDxmUuq7q9YPM+9bPbDArwS
 nwHX730CtPXs2a1coDedaelSWELcBODbyJ9jZpFyoEeg1nZ3SPDaJ1xRfIZIzFlIX0Y4aC8RE4
 8gmEB/uv4vPSyddfLtIkEe8ZhNFIeRN2eX0IQSz4fnpze6IaJAm2i6atOmaZs7n0M7pvtttajb
 oDc=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283542"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:55 +0800
IronPort-SDR: sbc3toky+0arMAQz7yiulTN+6+OIa95VyOcGlj1Cd6BBO96q7tkodcBPBWh6Zk2o0wK7j3ULB7
 y5208Ha5fa1VHZJN9teuWzwVlAjO1Xw823N6ekqT6u4QUoEe4ZfZ+yY4rTuYKBFmH8eQJ/YRYR
 mOhjRxEAS9sX2RdzOm3XXPs8EYjPOoM47tVroSY0DClmwuO+VjFsbN18KWk4ioNtU59JyrJiut
 QWFeCwTwHQnlLsWV5H9w989MFiMFgA5jUsICtPx6xPCSytnFNdr3Y5dskPWy+3mY0cTNadaD19
 0kc5q3FrkTtYOXy0hkxSY6bw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:38 -0800
IronPort-SDR: 86fDaH7RmEtndHArRttWHbZsG9VVoE1QCQK8fIjNGZXfq4Suk/DmrtiBMJj1O8Tb5tRDKut29W
 xTaulQcWyKUO446PhUUdXD0UuqujG1kydyi8Ya2k8RrDYWm7XiVN2zvurh0uBpa4wdHL9E2uTl
 AMR5/0X6ir7OolQlat3oYrzbZ8md2ldODvrmgi8MWvgAviJQZK+rff3c7DKybEVrt/Slebp+EZ
 inrmWAojlRnbcujdbwY11DZu7VQkl1IUA1zBTzGQ1dj/ANZCkw8EDPLi/ze6iQfZUSswsnT1Fn
 e90=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:55 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 4/9] null_blk: improve zone locking
Date:   Wed, 11 Nov 2020 22:00:44 +0900
Message-Id: <20201111130049.967902-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With memory backing disabled, using a single spinlock for protecting
zone information and zone resource management prevents the parallel
execution on multiple queue of IO requests to different zones.
Furthermore, regardless of the use of memory backing, if a null_blk
device is created without limits on the number of open and active zones,
accounting for zone resource management is not necessary.

From these observations, zone locking is changed as follows to improve
performance:
1) the zone_lock spinlock is renamed zone_res_lock and used only if
   zone resource management is necessary, that is, if either
   zone_max_open or zone_max_active are not 0. This is indicated using
   the new boolean need_zone_res_mgmt in the nullb_device structure.
   null_zone_write() is modified to reduce the amount of code executed
   with the zone_res_lock spinlock held.
2) With memory backing disabled, per zone locking is changed to a
   spinlock per zone.
3) Introduce the structure nullb_zone to replace the use of
   struct blk_zone for zone information. This new structure includes a
   union of a spinlock and a mutex for zone locking. The spinlock is
   used when memory backing is disabled and the mutex is used with
   memory backing.

With these changes, fio performance with zonemode=zbd for 4K random
read and random write on a dual socket (24 cores per socket) machine
using the none schedulder is as follows:

before patch:
	write (psync x 96 jobs) = 465 KIOPS
	read (libaio@qd=8 x 96 jobs) = 1361 KIOPS
after patch:
	write (psync x 96 jobs) = 456 KIOPS
	read (libaio@qd=8 x 96 jobs) = 4096 KIOPS

Write performance remains mostly unchanged but read performance is three
times higher. Performance when using the mq-deadline scheduler is not
changed by this patch as mq-deadline becomes the bottleneck for a
multi-queue device.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       |  28 +++-
 drivers/block/null_blk_zoned.c | 288 +++++++++++++++++++--------------
 2 files changed, 196 insertions(+), 120 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index c24d9b5ad81a..14546ead1d66 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -12,6 +12,8 @@
 #include <linux/configfs.h>
 #include <linux/badblocks.h>
 #include <linux/fault-inject.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
 
 struct nullb_cmd {
 	struct request *rq;
@@ -32,6 +34,26 @@ struct nullb_queue {
 	struct nullb_cmd *cmds;
 };
 
+struct nullb_zone {
+	/*
+	 * Zone lock to prevent concurrent modification of a zone write
+	 * pointer position and condition: with memory backing, a write
+	 * command execution may sleep on memory allocation. For this case,
+	 * use mutex as the zone lock. Otherwise, use the spinlock for
+	 * locking the zone.
+	 */
+	union {
+		spinlock_t spinlock;
+		struct mutex mutex;
+	};
+	enum blk_zone_type type;
+	enum blk_zone_cond cond;
+	sector_t start;
+	sector_t wp;
+	unsigned int len;
+	unsigned int capacity;
+};
+
 struct nullb_device {
 	struct nullb *nullb;
 	struct config_item item;
@@ -45,10 +67,10 @@ struct nullb_device {
 	unsigned int nr_zones_imp_open;
 	unsigned int nr_zones_exp_open;
 	unsigned int nr_zones_closed;
-	struct blk_zone *zones;
+	struct nullb_zone *zones;
 	sector_t zone_size_sects;
-	spinlock_t zone_lock;
-	unsigned long *zone_locks;
+	bool need_zone_res_mgmt;
+	spinlock_t zone_res_lock;
 
 	unsigned long size; /* device size in MB */
 	unsigned long completion_nsec; /* time in ns to complete a request */
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 172f720b8d63..2c746221e8e6 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -13,9 +13,51 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 	return sect >> ilog2(dev->zone_size_sects);
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
+static inline void null_init_zone_lock(struct nullb_device *dev,
+				       struct nullb_zone *zone)
+{
+	if (!dev->memory_backed)
+		spin_lock_init(&zone->spinlock);
+	else
+		mutex_init(&zone->mutex);
+}
+
+static inline void null_lock_zone(struct nullb_device *dev,
+				  struct nullb_zone *zone)
+{
+	if (!dev->memory_backed)
+		spin_lock_irq(&zone->spinlock);
+	else
+		mutex_lock(&zone->mutex);
+}
+
+static inline void null_unlock_zone(struct nullb_device *dev,
+				    struct nullb_zone *zone)
+{
+	if (!dev->memory_backed)
+		spin_unlock_irq(&zone->spinlock);
+	else
+		mutex_unlock(&zone->mutex);
+}
+
 int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 {
 	sector_t dev_capacity_sects, zone_capacity_sects;
+	struct nullb_zone *zone;
 	sector_t sector = 0;
 	unsigned int i;
 
@@ -44,26 +86,12 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	if (dev_capacity_sects & (dev->zone_size_sects - 1))
 		dev->nr_zones++;
 
-	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
-			GFP_KERNEL | __GFP_ZERO);
+	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
+				    GFP_KERNEL | __GFP_ZERO);
 	if (!dev->zones)
 		return -ENOMEM;
 
-	/*
-	 * With memory backing, the zone_lock spinlock needs to be temporarily
-	 * released to avoid scheduling in atomic context. To guarantee zone
-	 * information protection, use a bitmap to lock zones with
-	 * wait_on_bit_lock_io(). Sleeping on the lock is OK as memory backing
-	 * implies that the queue is marked with BLK_MQ_F_BLOCKING.
-	 */
-	spin_lock_init(&dev->zone_lock);
-	if (dev->memory_backed) {
-		dev->zone_locks = bitmap_zalloc(dev->nr_zones, GFP_KERNEL);
-		if (!dev->zone_locks) {
-			kvfree(dev->zones);
-			return -ENOMEM;
-		}
-	}
+	spin_lock_init(&dev->zone_res_lock);
 
 	if (dev->zone_nr_conv >= dev->nr_zones) {
 		dev->zone_nr_conv = dev->nr_zones - 1;
@@ -86,10 +114,12 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		dev->zone_max_open = 0;
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
 	}
+	dev->need_zone_res_mgmt = dev->zone_max_active || dev->zone_max_open;
 
 	for (i = 0; i <  dev->zone_nr_conv; i++) {
-		struct blk_zone *zone = &dev->zones[i];
+		zone = &dev->zones[i];
 
+		null_init_zone_lock(dev, zone);
 		zone->start = sector;
 		zone->len = dev->zone_size_sects;
 		zone->capacity = zone->len;
@@ -101,8 +131,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	}
 
 	for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
-		struct blk_zone *zone = &dev->zones[i];
+		zone = &dev->zones[i];
 
+		null_init_zone_lock(dev, zone);
 		zone->start = zone->wp = sector;
 		if (zone->start + dev->zone_size_sects > dev_capacity_sects)
 			zone->len = dev_capacity_sects - zone->start;
@@ -147,32 +178,17 @@ int null_register_zoned_dev(struct nullb *nullb)
 
 void null_free_zoned_dev(struct nullb_device *dev)
 {
-	bitmap_free(dev->zone_locks);
 	kvfree(dev->zones);
 }
 
-static inline void null_lock_zone(struct nullb_device *dev, unsigned int zno)
-{
-	if (dev->memory_backed)
-		wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);
-	spin_lock_irq(&dev->zone_lock);
-}
-
-static inline void null_unlock_zone(struct nullb_device *dev, unsigned int zno)
-{
-	spin_unlock_irq(&dev->zone_lock);
-
-	if (dev->memory_backed)
-		clear_and_wake_up_bit(zno, dev->zone_locks);
-}
-
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct nullb *nullb = disk->private_data;
 	struct nullb_device *dev = nullb->dev;
-	unsigned int first_zone, i, zno;
-	struct blk_zone zone;
+	unsigned int first_zone, i;
+	struct nullb_zone *zone;
+	struct blk_zone blkz;
 	int error;
 
 	first_zone = null_zone_no(dev, sector);
@@ -182,19 +198,25 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 	nr_zones = min(nr_zones, dev->nr_zones - first_zone);
 	trace_nullb_report_zones(nullb, nr_zones);
 
-	zno = first_zone;
-	for (i = 0; i < nr_zones; i++, zno++) {
+	memset(&blkz, 0, sizeof(struct blk_zone));
+	zone = &dev->zones[first_zone];
+	for (i = 0; i < nr_zones; i++, zone++) {
 		/*
 		 * Stacked DM target drivers will remap the zone information by
 		 * modifying the zone information passed to the report callback.
 		 * So use a local copy to avoid corruption of the device zone
 		 * array.
 		 */
-		null_lock_zone(dev, zno);
-		memcpy(&zone, &dev->zones[zno], sizeof(struct blk_zone));
-		null_unlock_zone(dev, zno);
-
-		error = cb(&zone, i, data);
+		null_lock_zone(dev, zone);
+		blkz.start = zone->start;
+		blkz.len = zone->len;
+		blkz.wp = zone->wp;
+		blkz.type = zone->type;
+		blkz.cond = zone->cond;
+		blkz.capacity = zone->capacity;
+		null_unlock_zone(dev, zone);
+
+		error = cb(&blkz, i, data);
 		if (error)
 			return error;
 	}
@@ -210,7 +232,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len)
 {
 	struct nullb_device *dev = nullb->dev;
-	struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
+	struct nullb_zone *zone = &dev->zones[null_zone_no(dev, sector)];
 	unsigned int nr_sectors = len >> SECTOR_SHIFT;
 
 	/* Read must be below the write pointer position */
@@ -224,11 +246,9 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 	return (zone->wp - sector) << SECTOR_SHIFT;
 }
 
-static blk_status_t null_close_zone(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t __null_close_zone(struct nullb_device *dev,
+				      struct nullb_zone *zone)
 {
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-		return BLK_STS_IOERR;
-
 	switch (zone->cond) {
 	case BLK_ZONE_COND_CLOSED:
 		/* close operation on closed is not an error */
@@ -261,7 +281,7 @@ static void null_close_first_imp_zone(struct nullb_device *dev)
 
 	for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
 		if (dev->zones[i].cond == BLK_ZONE_COND_IMP_OPEN) {
-			null_close_zone(dev, &dev->zones[i]);
+			__null_close_zone(dev, &dev->zones[i]);
 			return;
 		}
 	}
@@ -310,7 +330,8 @@ static blk_status_t null_check_open(struct nullb_device *dev)
  * it is not certain that closing an implicit open zone will allow a new zone
  * to be opened, since we might already be at the active limit capacity.
  */
-static blk_status_t null_check_zone_resources(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t null_check_zone_resources(struct nullb_device *dev,
+					      struct nullb_zone *zone)
 {
 	blk_status_t ret;
 
@@ -334,7 +355,8 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
-	struct blk_zone *zone = &dev->zones[zno];
+	struct nullb_zone *zone = &dev->zones[zno];
+	unsigned long flags;
 	blk_status_t ret;
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
@@ -345,26 +367,12 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
 	}
 
-	null_lock_zone(dev, zno);
+	null_lock_zone(dev, zone);
 
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
@@ -389,60 +397,70 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
-	null_unlock_zone(dev, zno);
+	null_unlock_zone(dev, zone);
 
 	return ret;
 }
 
-static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t null_open_zone(struct nullb_device *dev,
+				   struct nullb_zone *zone)
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
@@ -450,35 +468,59 @@ static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zo
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
+static blk_status_t null_close_zone(struct nullb_device *dev,
+				    struct nullb_zone *zone)
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
+static blk_status_t null_finish_zone(struct nullb_device *dev,
+				     struct nullb_zone *zone)
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
@@ -489,27 +531,37 @@ static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *
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
 
-static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t null_reset_zone(struct nullb_device *dev,
+				    struct nullb_zone *zone)
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
@@ -523,12 +575,15 @@ static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *z
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
 
@@ -537,19 +592,19 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zone_no;
-	struct blk_zone *zone;
+	struct nullb_zone *zone;
 	blk_status_t ret;
 	size_t i;
 
 	if (op == REQ_OP_ZONE_RESET_ALL) {
 		for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
-			null_lock_zone(dev, i);
 			zone = &dev->zones[i];
+			null_lock_zone(dev, zone);
 			if (zone->cond != BLK_ZONE_COND_EMPTY) {
 				null_reset_zone(dev, zone);
 				trace_nullb_zone_op(cmd, i, zone->cond);
 			}
-			null_unlock_zone(dev, i);
+			null_unlock_zone(dev, zone);
 		}
 		return BLK_STS_OK;
 	}
@@ -557,7 +612,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	zone_no = null_zone_no(dev, sector);
 	zone = &dev->zones[zone_no];
 
-	null_lock_zone(dev, zone_no);
+	null_lock_zone(dev, zone);
 
 	switch (op) {
 	case REQ_OP_ZONE_RESET:
@@ -580,7 +635,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	if (ret == BLK_STS_OK)
 		trace_nullb_zone_op(cmd, zone_no, zone->cond);
 
-	null_unlock_zone(dev, zone_no);
+	null_unlock_zone(dev, zone);
 
 	return ret;
 }
@@ -588,29 +643,28 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
 				    sector_t sector, sector_t nr_sectors)
 {
-	struct nullb_device *dev = cmd->nq->dev;
-	unsigned int zno = null_zone_no(dev, sector);
+	struct nullb_device *dev;
+	struct nullb_zone *zone;
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
-		null_lock_zone(dev, zno);
+		dev = cmd->nq->dev;
+		zone = &dev->zones[null_zone_no(dev, sector)];
+
+		null_lock_zone(dev, zone);
 		sts = null_process_cmd(cmd, op, sector, nr_sectors);
-		null_unlock_zone(dev, zno);
+		null_unlock_zone(dev, zone);
+		return sts;
 	}
-
-	return sts;
 }
-- 
2.26.2

