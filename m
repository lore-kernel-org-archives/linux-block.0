Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A8EC433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 09:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiK3Jlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 04:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiK3JlY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 04:41:24 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91372D81
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 01:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669801283; x=1701337283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XZldu3+2TyUmPJitRBwoeTOO/nARSg3GbazzLfZZtk4=;
  b=JdebrZvg2svXXvfx36SQHn3bDttrB2rk3cIry4+NPvO+PfvleDsKho6i
   zc22yr7hTwz/ucFhU5NCaLMvftSnPeOJe6/XariJmaryTeHl40WrqG9tv
   uu7hiVrdgf7Ya3CoZrG7H69KburSZO0GTvylkZluIfmoOre2MIbBYbwp9
   s/XFFYcQzpAikANe+Hf/7IGcS98QQ1NEgxswBsfy1mdMAq9qBSNw3z/y9
   AnLBjCj5Hd9ggOP8OYw9VfXtTv5LXoxFcx6xXtBIGWgnXEoy+ZHA2iTQx
   redj9T6kI+bp4ljPypVN7nJPEBaIJFzkw9I1yCXYU0JQAILymbUYV4dqM
   w==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="329639887"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 17:41:22 +0800
IronPort-SDR: J15grDKbfK0qSNh22RWBIQSf6e0ryDxu+RPFpcuxx/i8Piy1E043fZvQ7gzFvc5cZC3ARy2Bv7
 g0navGb8jFELJpqkOsCReMJwnarZ4dY/si8nccgufNc/rw0gM4aoP7zttesCMP2/RZepwIU7Sp
 vsj6XNezGXFSlSgzPtsz72JCxdhdJdHJ1GGrtT7l+bkP0KYWwFZD5NXYvFcTHtBWdwP+DZZI8L
 +0fboHVPupBCl72EwffKRD2X0YsRUANQa6yQ83WcX+8oeB8vjI2jX91sw93t6r3ya6sBoShO7V
 1fE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 00:54:17 -0800
IronPort-SDR: tp8oxK8+XUwj6kXut60XLT1KhIINo0rW1nOK3AKxLge9/2A8d29TXXqFR1wJ1zY2j/R2BBV73A
 toDYDEUTcf/fDYEkRC7JRKfLj/8v3KUlxw1/gcXPwFPycrZN11VHXrxsh/+5QGjc8HMI4x/kl6
 RQqt0EENbCyS21Eawt9GvamYyBURo+uzI9W79QaANzgOnkJ3+pAsxCBDC2ll0G02Wz7UpO6vD8
 Z62iFQq48r/Ua+zTohSLO0eCXKAVJLX2XVx/TKbuP4A31BnPe9QObJc/UUZTJZykE6sXBVm5+O
 dZo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2022 01:41:22 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] null_blk: support readonly and offline zone conditions
Date:   Wed, 30 Nov 2022 18:41:21 +0900
Message-Id: <20221130094121.2321485-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In zoned mode, zones with write pointers can have conditions "readonly"
or "offline". In readonly condition, zones can not be written. In
offline condition, the zones can be neither written nor read. These
conditions are intended for zones with media failures, then it is
difficult to set those conditions to zones on real devices.

To test handling of zones in the conditions, add a feature to null_blk
to set up zones in readonly or offline condition. Add new configuration
attributes "zone_readonly" and "zone_offline". Write a sector to the
attribute files to specify the target zone to set the zone conditions.
For example, following command lines do it:

   echo 0 > nullb1/zone_readonly
   echo 524288 > nullb1/zone_offline

When the specified zones are already in readonly or offline condition,
normal empty condition is restored to the zones. These condition changes
can be done only after the null_blk device get powered, since status
area of each zone is not yet allocated before power-on.

Also improve zone condition checks to inhibit all commands for zones in
offline conditions. In same manner, inhibit write and zone management
commands for zones in readonly condition.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This patch conflicts with another null_blk patch series posted recently [1].
Will rework to avoid the conflict on v2 or later.

[1] https://lore.kernel.org/linux-block/20221129232813.37968-1-kch@nvidia.com/

 drivers/block/null_blk/main.c     |  22 +++++-
 drivers/block/null_blk/null_blk.h |   8 +++
 drivers/block/null_blk/zoned.c    | 112 ++++++++++++++++++++++++++++--
 3 files changed, 137 insertions(+), 5 deletions(-)

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
index 55a69e48ef8b..fac68e797803 100644
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
@@ -674,10 +685,103 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
 	default:
 		dev = cmd->nq->dev;
 		zone = &dev->zones[null_zone_no(dev, sector)];
-
+		if (zone->cond == BLK_ZONE_COND_OFFLINE)
+			return BLK_STS_IOERR;
 		null_lock_zone(dev, zone);
 		sts = null_process_cmd(cmd, op, sector, nr_sectors);
 		null_unlock_zone(dev, zone);
 		return sts;
 	}
 }
+
+/*
+ * Set specified condition COND_READONLY or COND_OFFLINE to a zone.
+ */
+static int null_set_zone_cond(struct nullb_device *dev, struct nullb_zone *zone,
+			      enum blk_zone_cond cond)
+{
+	enum blk_zone_cond old_cond;
+	int ret;
+
+	if (WARN_ON_ONCE(cond != BLK_ZONE_COND_READONLY &&
+			 cond != BLK_ZONE_COND_OFFLINE))
+		return -EINVAL;
+
+	null_lock_zone(dev, zone);
+
+	/*
+	 * When current zone condition is readonly or offline, handle the zone
+	 * as full condition to avoid failure of zone reset or zone finish.
+	 */
+	old_cond = zone->cond;
+	if (zone->cond == BLK_ZONE_COND_READONLY ||
+	    zone->cond == BLK_ZONE_COND_OFFLINE)
+		zone->cond = BLK_ZONE_COND_FULL;
+
+	/*
+	 * If readonly condition is requested again to zones already in readonly
+	 * condition, reset the zones to restore back normal empty condition.
+	 * Do same if offline condition is requested for offline zones.
+	 * Otherwise, set desired zone condition to the zones. Finish the zones
+	 * beforehand to free up zone resources.
+	 */
+	if (old_cond == cond) {
+		ret = null_reset_zone(dev, zone);
+	} else {
+		ret = null_finish_zone(dev, zone);
+		if (!ret) {
+			zone->cond = cond;
+			zone->wp = (sector_t)-1;
+		}
+	}
+
+	if (ret)
+		zone->cond = old_cond;
+
+	null_unlock_zone(dev, zone);
+	return ret;
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
+
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
+	ret = null_set_zone_cond(dev, &dev->zones[zone_no], cond);
+	if (ret)
+		return ret;
+
+	return count;
+}
-- 
2.37.1

