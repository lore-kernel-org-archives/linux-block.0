Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ADFC63697
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1D92225B
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g3shkMuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgKTBzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6553 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKTBzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837344; x=1637373344;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BQVIFkJwoTMhWrpqBPlwL1BTlp60IXDuv/f5gp+gJWU=;
  b=g3shkMuOyLCFFgpOgaauYPaxH/FOCALPaqDAsjMFwHF+z8MXyB5j6EBA
   h/U94qh/4jhNV30mWUBY8OpVG256WWxw4fRHigrfajMmQOztxzsNZ6CE4
   0bCCS+WgUWqtMIZrPsAhk2z44VUZ9jaILVEi4aN7FZkUwedzFyUw6UpRR
   SphWh9YtFG3/H986qxrKJYrNajImEjNzTj1rg9vtyJ4soUL2DSbtL0kyc
   SvMX0o0lBdfatNY9iROpGKQ2GeXCenD5KCVQsQhXUncUZEWmNQN65TZ6s
   pn6nBeY517rJ7y31vsjID068QYw/D6aU8f71AIDFjJc/2A2t0EQ8M7KN8
   Q==;
IronPort-SDR: XfW56YTBq8S39PMEVaQe3xjsR1EfUr2DZfzXYUfri+5Ospqer+hwSlHKRe48VREKLlIebGMyqz
 HvmzkMnnz1Qbn3BgWuwk6ZnvSG8xVI0rKS2+DTVGiXqde4rvYXulk0fu0Q0qFEUIk6yfGaSEPk
 ijgyYci+IEGRjwtut+lMNg9kpgnW3JszDDcJss652awT2yksrswRKXziOld+xSsffYRM1w286F
 OfW8McbcoIxnijMEiGTnN+pOAZQrDEr8VeiIZssqnRAT8aJNOQZUKDjC1S9Z5zMG4KJa0jjdvF
 pcY=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516403"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:43 +0800
IronPort-SDR: RnpN0Q3j02o8RfgqbbgmmIq8uyJK8WTZ/rucpmBpSGaIAoa43ki9rE5MFlagBnD1I2OrrCNsk8
 Gicy8UYcg5mP2i2tstHOayGSz+WXV+XGae4OwqGdXL3JNT/uDXnxApx0nuWN1cQ2KNzxAPqXjl
 qnmMvDZdTq0gBtiNB2B4s4NQOQfRhMsn5swn/XuLnNPI/+h7rWf7IIgcy1VM3nu61mydRsY4N0
 usx4UHmCtGHu3WF2fiCW5K8TExGh6tXbJzzZpAI81/JFlEWeWkVcLBxXPEfsnI4x5lpTSV93W1
 oglLHZl+z/9R5O0GwlJzhuOS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:33 -0800
IronPort-SDR: IhEZ2CaLcFVIFafrYMgm8MXp0Rv9kD7qSEhKMdDU1UzpbrbvkXUakz2zan8AaGnhYLsrtl98yj
 efIS89LP7KqA32Sr2tQTPOA+G2lglM2VRcZhZjVajO9rwP4m6QYrjdTmVe46uud6clPN8g1WTX
 UJQAN9+FjhRyhL01+Ntq5jFYyodG8Zf/Iw5Qr4EwKtT4Tscztjx6a7ljbHNsYIcDA1ysKPr6u2
 MILPEOwVAlAcVTYNUHrX0UWrjuZyEzNBRiYyn2ghuxQ0p6d5EeJerA4lX82fam9nni5X9dWhFy
 MOU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:43 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 4/9] null_blk: improve zone locking
Date:   Fri, 20 Nov 2020 10:55:14 +0900
Message-Id: <20201120015519.276820-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk.h       |  28 +++-
 drivers/block/null_blk_zoned.c | 280 +++++++++++++++++++--------------
 2 files changed, 188 insertions(+), 120 deletions(-)

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
index 172f720b8d63..4d5c0b938618 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -13,9 +13,49 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
+static inline void null_lock_zone_res(struct nullb_device *dev)
+{
+	if (dev->need_zone_res_mgmt)
+		spin_lock_irq(&dev->zone_res_lock);
+}
+
+static inline void null_unlock_zone_res(struct nullb_device *dev)
+{
+	if (dev->need_zone_res_mgmt)
+		spin_unlock_irq(&dev->zone_res_lock);
+}
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
 
@@ -44,26 +84,12 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
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
@@ -86,10 +112,12 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
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
@@ -101,8 +129,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	}
 
 	for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
-		struct blk_zone *zone = &dev->zones[i];
+		zone = &dev->zones[i];
 
+		null_init_zone_lock(dev, zone);
 		zone->start = zone->wp = sector;
 		if (zone->start + dev->zone_size_sects > dev_capacity_sects)
 			zone->len = dev_capacity_sects - zone->start;
@@ -147,32 +176,17 @@ int null_register_zoned_dev(struct nullb *nullb)
 
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
@@ -182,19 +196,25 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
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
@@ -210,7 +230,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len)
 {
 	struct nullb_device *dev = nullb->dev;
-	struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
+	struct nullb_zone *zone = &dev->zones[null_zone_no(dev, sector)];
 	unsigned int nr_sectors = len >> SECTOR_SHIFT;
 
 	/* Read must be below the write pointer position */
@@ -224,11 +244,9 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
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
@@ -261,7 +279,7 @@ static void null_close_first_imp_zone(struct nullb_device *dev)
 
 	for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
 		if (dev->zones[i].cond == BLK_ZONE_COND_IMP_OPEN) {
-			null_close_zone(dev, &dev->zones[i]);
+			__null_close_zone(dev, &dev->zones[i]);
 			return;
 		}
 	}
@@ -310,7 +328,8 @@ static blk_status_t null_check_open(struct nullb_device *dev)
  * it is not certain that closing an implicit open zone will allow a new zone
  * to be opened, since we might already be at the active limit capacity.
  */
-static blk_status_t null_check_zone_resources(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t null_check_zone_resources(struct nullb_device *dev,
+					      struct nullb_zone *zone)
 {
 	blk_status_t ret;
 
@@ -334,7 +353,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
-	struct blk_zone *zone = &dev->zones[zno];
+	struct nullb_zone *zone = &dev->zones[zno];
 	blk_status_t ret;
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
@@ -345,26 +364,12 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
@@ -389,60 +394,69 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		goto unlock;
 	}
 
-	if (zone->cond == BLK_ZONE_COND_CLOSED) {
-		dev->nr_zones_closed--;
-		dev->nr_zones_imp_open++;
-	} else if (zone->cond == BLK_ZONE_COND_EMPTY) {
-		dev->nr_zones_imp_open++;
+	if (zone->cond == BLK_ZONE_COND_CLOSED ||
+	    zone->cond == BLK_ZONE_COND_EMPTY) {
+		null_lock_zone_res(dev);
+
+		ret = null_check_zone_resources(dev, zone);
+		if (ret != BLK_STS_OK) {
+			null_unlock_zone_res(dev);
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
+		null_unlock_zone_res(dev);
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
+		null_lock_zone_res(dev);
 		if (zone->cond == BLK_ZONE_COND_EXP_OPEN)
 			dev->nr_zones_exp_open--;
 		else if (zone->cond == BLK_ZONE_COND_IMP_OPEN)
 			dev->nr_zones_imp_open--;
 		zone->cond = BLK_ZONE_COND_FULL;
+		null_unlock_zone_res(dev);
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
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
+	null_lock_zone_res(dev);
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
@@ -450,35 +464,57 @@ static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zo
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
+	null_unlock_zone_res(dev);
+
+	return ret;
 }
 
-static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t null_close_zone(struct nullb_device *dev,
+				    struct nullb_zone *zone)
 {
 	blk_status_t ret;
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
+	null_lock_zone_res(dev);
+	ret = __null_close_zone(dev, zone);
+	null_unlock_zone_res(dev);
+
+	return ret;
+}
+
+static blk_status_t null_finish_zone(struct nullb_device *dev,
+				     struct nullb_zone *zone)
+{
+	blk_status_t ret = BLK_STS_OK;
+
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
+
+	null_lock_zone_res(dev);
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
@@ -489,27 +525,35 @@ static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *
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
+	null_unlock_zone_res(dev);
+
+	return ret;
 }
 
-static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *zone)
+static blk_status_t null_reset_zone(struct nullb_device *dev,
+				    struct nullb_zone *zone)
 {
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
+	null_lock_zone_res(dev);
+
 	switch (zone->cond) {
 	case BLK_ZONE_COND_EMPTY:
 		/* reset operation on empty is not an error */
+		null_unlock_zone_res(dev);
 		return BLK_STS_OK;
 	case BLK_ZONE_COND_IMP_OPEN:
 		dev->nr_zones_imp_open--;
@@ -523,12 +567,15 @@ static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *z
 	case BLK_ZONE_COND_FULL:
 		break;
 	default:
+		null_unlock_zone_res(dev);
 		return BLK_STS_IOERR;
 	}
 
 	zone->cond = BLK_ZONE_COND_EMPTY;
 	zone->wp = zone->start;
 
+	null_unlock_zone_res(dev);
+
 	return BLK_STS_OK;
 }
 
@@ -537,19 +584,19 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
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
@@ -557,7 +604,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	zone_no = null_zone_no(dev, sector);
 	zone = &dev->zones[zone_no];
 
-	null_lock_zone(dev, zone_no);
+	null_lock_zone(dev, zone);
 
 	switch (op) {
 	case REQ_OP_ZONE_RESET:
@@ -580,7 +627,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	if (ret == BLK_STS_OK)
 		trace_nullb_zone_op(cmd, zone_no, zone->cond);
 
-	null_unlock_zone(dev, zone_no);
+	null_unlock_zone(dev, zone);
 
 	return ret;
 }
@@ -588,29 +635,28 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
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
2.28.0

