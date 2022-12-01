Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5BEC43217
	for <linux-block@archiver.kernel.org>; Thu,  1 Dec 2022 06:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLAGKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 01:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLAGKm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 01:10:42 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E4AB025
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 22:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669875038; x=1701411038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uS7TWFQZbxrEA/xfny/0DrmsrwdnXyiQrJDLQL/p9SU=;
  b=ljm1qdFX6ObsyWdANNTl0V0vX6ogBNsZh7kqsff1zZrrtYPz/bJI/oKb
   SDNQPznq5SbVaS0BLdzK2W9MbBBoPzGHjcHQrryd2Ds8fxaIHfEIQOD9v
   leRiGijrTMDz7wC06H9jYpJ9U2lnaDQ77cN2sg//yS8NHC/SxFVy4wwRE
   Wnn2tYzNpQOWi7oXQSqhtoDM2UH7sPrx/O4IFncdcjD3kkpAngqhENd6f
   W9uPKkfIQeeXOtEM8PCBdXUshDaWUyUnjKay4/lTXq/FdqugJn6hdukkS
   Yj3eeIjv+XaklD1cXAU37qTaixylhoEmmWxdaIxMD+JJZ3NNr6Db7e+f+
   w==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665417600"; 
   d="scan'208";a="217624077"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2022 14:10:37 +0800
IronPort-SDR: zVSEKA2JeYUKIBHHFufUHYgCcAD9IDr9Yx1H63HPwrmkfM/yf9U4AO7uHsiWgA2uxhei7UD1D6
 0sSkMu4ZXYBj/lFwhO6kyYKj7Lwk2zX+5Hsw9s8+YYWJCZoJV4ikEJgzYZ8k7Ve1RcrSXF0L81
 YQGTnkFFTTKhCsRl0uDLwPIRaUgRMR4TW7L0VGW4nvxAsxSZUOPEj4KIR2h3rhTjOkZzvsyu5H
 Xn3NGnVM4pDvBqY7qhMGObVblHCDroGTLgdaxxUtSLqSdFcdDv04Y0W15FVj9kMB12K8MCe3kL
 MvI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 21:29:16 -0800
IronPort-SDR: fxNIyh4X8S7bZ2Rssz3YdLwn51Et/DUit6pD/OYILrhgGVRRpoKTvYUiefNan9gvJxJwNzh7ey
 Uwpba7HE7czh9QfF1vKY0JT2LwSA9wFQxoYJWt38Cudk//bEUsmdREhIGYmRDWpNjh+5Ai7auW
 SpxR574xGqrIHq/oUtDr84Con0OpeyEEqpPvwlTiSt09t2J9V812w2jSgvS3BqpFXInP30c/JH
 YaWv6+poGKotguSb+o6S6ggwrzR/X8gxc7IF/u26adui3H5jGpTFM2p/p1EC2p+Ju0958NJl16
 TgM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Nov 2022 22:10:37 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] null_blk: support read-only and offline zone conditions
Date:   Thu,  1 Dec 2022 15:10:36 +0900
Message-Id: <20221201061036.2342206-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In zoned mode, zones with write pointers can have conditions "read-only"
or "offline". In read-only condition, zones can not be written. In
offline condition, the zones can be neither written nor read. These
conditions are intended for zones with media failures, then it is
difficult to set those conditions to zones on real devices.

To test handling of zones in the conditions, add a feature to null_blk
to set up zones in read-only or offline condition. Add new configuration
attributes "zone_readonly" and "zone_offline". Write a sector to the
attribute files to specify the target zone to set the zone conditions.
For example, following command lines do it:

   echo 0 > nullb1/zone_readonly
   echo 524288 > nullb1/zone_offline

When the specified zones are already in read-only or offline condition,
normal empty condition is restored to the zones. These condition changes
can be done only after the null_blk device get powered, since status
area of each zone is not yet allocated before power-on.

Also improve zone condition checks to inhibit all commands for zones in
offline conditions. In same manner, inhibit write and zone management
commands for zones in read-only condition.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This patch conflicts with another null_blk patch series posted recently [1].
Will rework to avoid the conflict on v3 or later.

[1] https://lore.kernel.org/linux-block/20221129232813.37968-1-kch@nvidia.com/

Changes from v1:
* Removed old_cond variable and null_reset_zone call in null_set_zone_cond
* Reflected various comments on the list

 drivers/block/null_blk/main.c     | 22 ++++++-
 drivers/block/null_blk/null_blk.h |  8 +++
 drivers/block/null_blk/zoned.c    | 95 ++++++++++++++++++++++++++++++-
 3 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..7d28e3aa406c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -523,6 +523,24 @@ static ssize_t nullb_device_badblocks_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nullb_device_, badblocks);
 
+static ssize_t nullb_device_zone_readonly_store(struct config_item *item,
+						const char *page, size_t count)
+{
+	struct nullb_device *dev = to_nullb_device(item);
+
+	return zone_cond_store(dev, page, count, BLK_ZONE_COND_READONLY);
+}
+CONFIGFS_ATTR_WO(nullb_device_, zone_readonly);
+
+static ssize_t nullb_device_zone_offline_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct nullb_device *dev = to_nullb_device(item);
+
+	return zone_cond_store(dev, page, count, BLK_ZONE_COND_OFFLINE);
+}
+CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
+
 static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_size,
 	&nullb_device_attr_completion_nsec,
@@ -549,6 +567,8 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_nr_conv,
 	&nullb_device_attr_zone_max_open,
 	&nullb_device_attr_zone_max_active,
+	&nullb_device_attr_zone_readonly,
+	&nullb_device_attr_zone_offline,
 	&nullb_device_attr_virt_boundary,
 	&nullb_device_attr_no_sched,
 	&nullb_device_attr_shared_tag_bitmap,
@@ -614,7 +634,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_size\n");
+			"zone_nr_conv,zone_offline,zone_readonly,zone_size\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..eb5972c50be8 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -151,6 +151,8 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
 				    sector_t sector, sector_t nr_sectors);
 size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len);
+ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
+			size_t count, enum blk_zone_cond cond);
 #else
 static inline int null_init_zoned_dev(struct nullb_device *dev,
 				      struct request_queue *q)
@@ -174,6 +176,12 @@ static inline size_t null_zone_valid_read_len(struct nullb *nullb,
 {
 	return len;
 }
+static inline ssize_t zone_cond_store(struct nullb_device *dev,
+				      const char *page, size_t count,
+				      enum blk_zone_cond cond)
+{
+	return -EOPNOTSUPP;
+}
 #define null_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55a69e48ef8b..635ce0648133 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -384,8 +384,10 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	null_lock_zone(dev, zone);
 
-	if (zone->cond == BLK_ZONE_COND_FULL) {
-		/* Cannot write to a full zone */
+	if (zone->cond == BLK_ZONE_COND_FULL ||
+	    zone->cond == BLK_ZONE_COND_READONLY ||
+	    zone->cond == BLK_ZONE_COND_OFFLINE) {
+		/* Cannot write to the zone */
 		ret = BLK_STS_IOERR;
 		goto unlock;
 	}
@@ -613,7 +615,9 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_op op,
 		for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
 			zone = &dev->zones[i];
 			null_lock_zone(dev, zone);
-			if (zone->cond != BLK_ZONE_COND_EMPTY) {
+			if (zone->cond != BLK_ZONE_COND_EMPTY &&
+			    zone->cond != BLK_ZONE_COND_READONLY &&
+			    zone->cond != BLK_ZONE_COND_OFFLINE) {
 				null_reset_zone(dev, zone);
 				trace_nullb_zone_op(cmd, i, zone->cond);
 			}
@@ -627,6 +631,12 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_op op,
 
 	null_lock_zone(dev, zone);
 
+	if (zone->cond == BLK_ZONE_COND_READONLY ||
+	    zone->cond == BLK_ZONE_COND_OFFLINE) {
+		ret = BLK_STS_IOERR;
+		goto unlock;
+	}
+
 	switch (op) {
 	case REQ_OP_ZONE_RESET:
 		ret = null_reset_zone(dev, zone);
@@ -648,6 +658,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_op op,
 	if (ret == BLK_STS_OK)
 		trace_nullb_zone_op(cmd, zone_no, zone->cond);
 
+unlock:
 	null_unlock_zone(dev, zone);
 
 	return ret;
@@ -674,6 +685,8 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
 	default:
 		dev = cmd->nq->dev;
 		zone = &dev->zones[null_zone_no(dev, sector)];
+		if (zone->cond == BLK_ZONE_COND_OFFLINE)
+			return BLK_STS_IOERR;
 
 		null_lock_zone(dev, zone);
 		sts = null_process_cmd(cmd, op, sector, nr_sectors);
@@ -681,3 +694,79 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
 		return sts;
 	}
 }
+
+/*
+ * Set a zone in the read-only or offline condition.
+ */
+static void null_set_zone_cond(struct nullb_device *dev,
+			       struct nullb_zone *zone, enum blk_zone_cond cond)
+{
+	if (WARN_ON_ONCE(cond != BLK_ZONE_COND_READONLY &&
+			 cond != BLK_ZONE_COND_OFFLINE))
+		return;
+
+	null_lock_zone(dev, zone);
+
+	/*
+	 * If the read-only condition is requested again to zones already in
+	 * read-only condition, restore back normal empty condition. Do the same
+	 * if the offline condition is requested for offline zones. Otherwise,
+	 * set the specified zone condition to the zones. Finish the zones
+	 * beforehand to free up zone resources.
+	 */
+	if (zone->cond == cond) {
+		zone->cond = BLK_ZONE_COND_EMPTY;
+		zone->wp = zone->start;
+		if (dev->memory_backed)
+			null_handle_discard(dev, zone->start, zone->len);
+	} else {
+		if (zone->cond != BLK_ZONE_COND_READONLY &&
+		    zone->cond != BLK_ZONE_COND_OFFLINE)
+			null_finish_zone(dev, zone);
+		zone->cond = cond;
+		zone->wp = (sector_t)-1;
+	}
+
+	null_unlock_zone(dev, zone);
+}
+
+/*
+ * Identify a zone from the sector written to configfs file. Then set zone
+ * condition to the zone.
+ */
+ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
+			size_t count, enum blk_zone_cond cond)
+{
+	unsigned long long sector;
+	unsigned int zone_no;
+	int ret;
+
+	if (!dev->zoned) {
+		pr_err("null_blk device is not zoned\n");
+		return -EINVAL;
+	}
+
+	if (!dev->zones) {
+		pr_err("null_blk device is not yet powered\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtoull(page, 0, &sector);
+	if (ret < 0)
+		return ret;
+
+	zone_no = null_zone_no(dev, sector);
+	if (zone_no >= dev->nr_zones) {
+		pr_err("Sector out of range\n");
+		return -EINVAL;
+	}
+
+	if (dev->zones[zone_no].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		pr_err("Can not change condition of conventional zones\n");
+		return -EINVAL;
+	}
+
+	null_set_zone_cond(dev, &dev->zones[zone_no], cond);
+
+	return count;
+}
-- 
2.37.1

