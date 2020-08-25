Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60054C433E1
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222802075E
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 12:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ns/XRP+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgHYMXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:23:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26120 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgHYMW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 08:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598358177; x=1629894177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AiHGO2rnOa18mTC8Y9aUfmHoyktpRSbPRkY+oAfhCYI=;
  b=ns/XRP+v/WSGVG1qkHfumu5bA3f36fXlxHTP6pKjXb7BjU/x9DScnDJt
   eVq041VZW2A7frqFD8o1TlU0K4cnXcuMtdam4Y0r2lo/D/PI4VSy06xpW
   E45zB5TX1wfKZ1lgVbMIpbYtPdWdvKNpqWSh6i6WDhKSrX2w7JuyicY4O
   NcO1A5u/ictPRY+NsYiWOMhrDw9ZIjCgPSHb92+ZQ4B1gKpEFT6h0jP/j
   bMdvjlH8yyrdSfU2KPwzOtuKmM6Ql7axCs3L7hUPb29a0eCTmX01tF20x
   ufzaqOMQgRQ3cM1nqWToeQD2MkkrPP35fiu7rHNFFF2/lWg8Cpzcx5NVN
   w==;
IronPort-SDR: nkfPEh2b4uS0xoFguGHjB9bgFh6vkGkaZjWRDnRKw4lplVf2xjkB2B2H9SPhDR8Jx+BPZYUSv/
 55lxop6/DgJVZB1hP2cNqELVbz07Qw4WgBue+X883Z8EbvQ/mxtLtLrKNDJo4n+XauDj/4kIfQ
 vCvguE1kRFLdGfXBsEb1aNWwXvUcHwUboDRXdZdzsOGFxKV2fDCWgusoS6Rs8Tocx4T0cH7UbZ
 JYCBp+YMvvnpNEOPMJ+QPgHs9xRcEeK9n1SWqk2HQ5NTtsSGVmb+nuE5oc8gC6Uqw6krBTd+Vz
 tLY=
X-IronPort-AV: E=Sophos;i="5.76,352,1592841600"; 
   d="scan'208";a="150113802"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2020 20:22:56 +0800
IronPort-SDR: cHFAnwGe5K74ZKjcZpcv3hh8Q1UuylxyVHSWPrXvMb8UZE16Z2Ya+EYbv8hze7IBc/0UGAhjKV
 EaTN1eW5vLfg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 05:09:44 -0700
IronPort-SDR: VoxwpDZYyB93stJ7KmyBTrVoQTRvov+NqfMaXT2c8AHmzSKsSp+RzX6KCer8tbHTs6NhrrV4UF
 YdjqRjX+2uyw==
WDCIronportException: Internal
Received: from usa004563.ad.shared (HELO localhost.hgst.com) ([10.86.59.127])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 05:22:55 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     damien.lemoal@wdc.com, johannes.thumshirn@wdc.com,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] null_blk: add support for max open/active zone limit for zoned devices
Date:   Tue, 25 Aug 2020 14:22:44 +0200
Message-Id: <20200825122244.126129-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for user space to set a max open zone and a max active zone
limit via configfs. By default, the default value is 0 == no limit.

Call the block layer API functions used for exposing the configured
limits to sysfs.

Add accounting in null_blk_zoned so that these new limits are respected.
Performing an operating that would exceed these limits results is a
standard I/O error.

A max open zone limit exists in the ZBC standard.
While null_blk_zoned is used to test the Zoned Block Device model in
Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned
mostly follows ZBC.

Therefore, implement the manage open zone resources function from ZBC,
but additionally add support for max active zones.
This enables user space not only to test against a device with an open
zone limit, but also to test against a device with an active zone limit.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/block/null_blk.h       |   5 +
 drivers/block/null_blk_main.c  |  16 +-
 drivers/block/null_blk_zoned.c | 316 +++++++++++++++++++++++++++------
 3 files changed, 283 insertions(+), 54 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index daed4a9c34367..d2e7db43a52a7 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -42,6 +42,9 @@ struct nullb_device {
 	struct badblocks badblocks;
 
 	unsigned int nr_zones;
+	unsigned int nr_zones_imp_open;
+	unsigned int nr_zones_exp_open;
+	unsigned int nr_zones_closed;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
 
@@ -51,6 +54,8 @@ struct nullb_device {
 	unsigned long zone_size; /* zone size in MB if device is zoned */
 	unsigned long zone_capacity; /* zone capacity in MB if device is zoned */
 	unsigned int zone_nr_conv; /* number of conventional zones */
+	unsigned int zone_max_open; /* max number of open zones */
+	unsigned int zone_max_active; /* max number of active zones */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int home_node; /* home node for the device */
 	unsigned int queue_mode; /* block interface */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index d74443a9c8fa2..53161a418611b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -208,6 +208,14 @@ static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
 
+static unsigned int g_zone_max_open;
+module_param_named(zone_max_open, g_zone_max_open, uint, 0444);
+MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones when block device is zoned. Default: 0 (no limit)");
+
+static unsigned int g_zone_max_active;
+module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
+MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when block device is zoned. Default: 0 (no limit)");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -347,6 +355,8 @@ NULLB_DEVICE_ATTR(zoned, bool, NULL);
 NULLB_DEVICE_ATTR(zone_size, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
+NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
+NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -464,6 +474,8 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_size,
 	&nullb_device_attr_zone_capacity,
 	&nullb_device_attr_zone_nr_conv,
+	&nullb_device_attr_zone_max_open,
+	&nullb_device_attr_zone_max_active,
 	NULL,
 };
 
@@ -517,7 +529,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
+			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -580,6 +592,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_size = g_zone_size;
 	dev->zone_capacity = g_zone_capacity;
 	dev->zone_nr_conv = g_zone_nr_conv;
+	dev->zone_max_open = g_zone_max_open;
+	dev->zone_max_active = g_zone_max_active;
 	return dev;
 }
 
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 3d25c9ad23831..5fb38c9bdd4ae 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -51,6 +51,24 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 			dev->zone_nr_conv);
 	}
 
+	/* Max active zones has to be <= number of sequential zones */
+	if (dev->zone_max_active > dev->nr_zones - dev->zone_nr_conv) {
+		dev->zone_max_active = dev->nr_zones - dev->zone_nr_conv;
+		pr_info("changed the maximum number of active zones to %u\n",
+			dev->nr_zones);
+	}
+
+	/* Max open zones has to be <= max active zones */
+	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) {
+		dev->zone_max_open = dev->zone_max_active;
+		pr_info("changed the maximum number of open zones to %u\n",
+			dev->nr_zones);
+	} else if (dev->zone_max_open > dev->nr_zones - dev->zone_nr_conv) {
+		dev->zone_max_open = dev->nr_zones - dev->zone_nr_conv;
+		pr_info("changed the maximum number of open zones to %u\n",
+			dev->nr_zones);
+	}
+
 	for (i = 0; i <  dev->zone_nr_conv; i++) {
 		struct blk_zone *zone = &dev->zones[i];
 
@@ -99,6 +117,8 @@ int null_register_zoned_dev(struct nullb *nullb)
 	}
 
 	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
+	blk_queue_max_open_zones(q, dev->zone_max_open);
+	blk_queue_max_active_zones(q, dev->zone_max_active);
 
 	return 0;
 }
@@ -159,6 +179,99 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 	return (zone->wp - sector) << SECTOR_SHIFT;
 }
 
+static blk_status_t null_close_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
+
+	switch (zone->cond) {
+	case BLK_ZONE_COND_CLOSED:
+		/* close operation on closed is not an error */
+		return BLK_STS_OK;
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
+	case BLK_ZONE_COND_EXP_OPEN:
+		dev->nr_zones_exp_open--;
+		break;
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_FULL:
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	if (zone->wp == zone->start) {
+		zone->cond = BLK_ZONE_COND_EMPTY;
+	} else {
+		zone->cond = BLK_ZONE_COND_CLOSED;
+		dev->nr_zones_closed++;
+	}
+
+	return BLK_STS_OK;
+}
+
+static void null_close_first_imp_zone(struct nullb_device *dev)
+{
+	unsigned int i;
+
+	for (i = 0; i < dev->nr_zones; i++) {
+		if (dev->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL)
+			continue;
+		if (dev->zones[i].cond == BLK_ZONE_COND_IMP_OPEN) {
+			null_close_zone(dev, &dev->zones[i]);
+			return;
+		}
+	}
+}
+
+static bool null_room_in_active(struct nullb_device *dev)
+{
+	if (!dev->zone_max_active)
+		return true;
+
+	return dev->nr_zones_exp_open + dev->nr_zones_imp_open +
+	       dev->nr_zones_closed < dev->zone_max_active;
+}
+
+static bool null_room_in_open(struct nullb_device *dev)
+{
+	if (!dev->zone_max_open)
+		return true;
+
+	return dev->nr_zones_exp_open + dev->nr_zones_imp_open < dev->zone_max_open;
+}
+
+/*
+ * This function matches the manage open zone resources function in the ZBC standard,
+ * with the addition of max active zones support (added in the ZNS standard).
+ *
+ * ZBC states that an implicitly open zone shall be closed only if there is not
+ * room within the open limit. However, if an active limit is set, it is not certain
+ * that an implicitly opened zone can be closed without exceeding the active limit.
+ */
+static bool null_manage_zone_resources(struct nullb_device *dev, struct blk_zone *zone)
+{
+	switch (zone->cond) {
+	case BLK_ZONE_COND_EMPTY:
+		if (!null_room_in_active(dev))
+			return false;
+		fallthrough;
+	case BLK_ZONE_COND_CLOSED:
+		if (null_room_in_open(dev)) {
+			return true;
+		} else if (dev->nr_zones_imp_open && null_room_in_active(dev)) {
+			null_close_first_imp_zone(dev);
+			return true;
+		} else {
+			return false;
+		}
+	default:
+		/* Should never be called for other states */
+		WARN_ON(1);
+		return false;
+	}
+}
+
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 				    unsigned int nr_sectors, bool append)
 {
@@ -177,43 +290,155 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		/* Cannot write to a full zone */
 		return BLK_STS_IOERR;
 	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_CLOSED:
+		if (!null_manage_zone_resources(dev, zone))
+			return BLK_STS_IOERR;
+		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
+		break;
+	default:
+		/* Invalid zone condition */
+		return BLK_STS_IOERR;
+	}
+
+	/*
+	 * Regular writes must be at the write pointer position.
+	 * Zone append writes are automatically issued at the write
+	 * pointer and the position returned using the request or BIO
+	 * sector.
+	 */
+	if (append) {
+		sector = zone->wp;
+		if (cmd->bio)
+			cmd->bio->bi_iter.bi_sector = sector;
+		else
+			cmd->rq->__sector = sector;
+	} else if (sector != zone->wp) {
+		return BLK_STS_IOERR;
+	}
+
+	if (zone->wp + nr_sectors > zone->start + zone->capacity)
+		return BLK_STS_IOERR;
+
+	if (zone->cond == BLK_ZONE_COND_CLOSED) {
+		dev->nr_zones_closed--;
+		dev->nr_zones_imp_open++;
+	} else if (zone->cond == BLK_ZONE_COND_EMPTY) {
+		dev->nr_zones_imp_open++;
+	}
+	if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
+		zone->cond = BLK_ZONE_COND_IMP_OPEN;
+
+	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
+	if (ret != BLK_STS_OK)
+		return ret;
+
+	zone->wp += nr_sectors;
+	if (zone->wp == zone->start + zone->capacity) {
+		if (zone->cond == BLK_ZONE_COND_EXP_OPEN)
+			dev->nr_zones_exp_open--;
+		else if (zone->cond == BLK_ZONE_COND_IMP_OPEN)
+			dev->nr_zones_imp_open--;
+		zone->cond = BLK_ZONE_COND_FULL;
+	}
+	return BLK_STS_OK;
+}
+
+static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
+
+	switch (zone->cond) {
+	case BLK_ZONE_COND_EXP_OPEN:
+		/* open operation on exp open is not an error */
+		return BLK_STS_OK;
+	case BLK_ZONE_COND_EMPTY:
+		if (!null_manage_zone_resources(dev, zone))
+			return BLK_STS_IOERR;
+		break;
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
 	case BLK_ZONE_COND_CLOSED:
-		/*
-		 * Regular writes must be at the write pointer position.
-		 * Zone append writes are automatically issued at the write
-		 * pointer and the position returned using the request or BIO
-		 * sector.
-		 */
-		if (append) {
-			sector = zone->wp;
-			if (cmd->bio)
-				cmd->bio->bi_iter.bi_sector = sector;
-			else
-				cmd->rq->__sector = sector;
-		} else if (sector != zone->wp) {
+		if (!null_manage_zone_resources(dev, zone))
 			return BLK_STS_IOERR;
-		}
+		dev->nr_zones_closed--;
+		break;
+	case BLK_ZONE_COND_FULL:
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	zone->cond = BLK_ZONE_COND_EXP_OPEN;
+	dev->nr_zones_exp_open++;
+
+	return BLK_STS_OK;
+}
+
+static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
 
-		if (zone->wp + nr_sectors > zone->start + zone->capacity)
+	switch (zone->cond) {
+	case BLK_ZONE_COND_FULL:
+		/* finish operation on full is not an error */
+		return BLK_STS_OK;
+	case BLK_ZONE_COND_EMPTY:
+		if (!null_manage_zone_resources(dev, zone))
+			return BLK_STS_IOERR;
+		break;
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
+	case BLK_ZONE_COND_EXP_OPEN:
+		dev->nr_zones_exp_open--;
+		break;
+	case BLK_ZONE_COND_CLOSED:
+		if (!null_manage_zone_resources(dev, zone))
 			return BLK_STS_IOERR;
+		dev->nr_zones_closed--;
+		break;
+	default:
+		return BLK_STS_IOERR;
+	}
 
-		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
-			zone->cond = BLK_ZONE_COND_IMP_OPEN;
+	zone->cond = BLK_ZONE_COND_FULL;
+	zone->wp = zone->len;
 
-		ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
-		if (ret != BLK_STS_OK)
-			return ret;
+	return BLK_STS_OK;
+}
+
+static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
 
-		zone->wp += nr_sectors;
-		if (zone->wp == zone->start + zone->capacity)
-			zone->cond = BLK_ZONE_COND_FULL;
+	switch (zone->cond) {
+	case BLK_ZONE_COND_EMPTY:
+		/* reset operation on empty is not an error */
 		return BLK_STS_OK;
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
+	case BLK_ZONE_COND_EXP_OPEN:
+		dev->nr_zones_exp_open--;
+		break;
+	case BLK_ZONE_COND_CLOSED:
+		dev->nr_zones_closed--;
+		break;
+	case BLK_ZONE_COND_FULL:
+		break;
 	default:
-		/* Invalid zone condition */
 		return BLK_STS_IOERR;
 	}
+
+	zone->cond = BLK_ZONE_COND_EMPTY;
+	zone->wp = zone->start;
+
+	return BLK_STS_OK;
 }
 
 static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
@@ -222,49 +447,34 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zone_no = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zone_no];
+	blk_status_t ret;
 	size_t i;
 
 	switch (op) {
 	case REQ_OP_ZONE_RESET_ALL:
 		for (i = 0; i < dev->nr_zones; i++) {
-			if (zone[i].type == BLK_ZONE_TYPE_CONVENTIONAL)
-				continue;
-			zone[i].cond = BLK_ZONE_COND_EMPTY;
-			zone[i].wp = zone[i].start;
+			null_reset_zone(dev, &dev->zones[i]);
 		}
 		break;
 	case REQ_OP_ZONE_RESET:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-
-		zone->cond = BLK_ZONE_COND_EMPTY;
-		zone->wp = zone->start;
+		ret = null_reset_zone(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		break;
 	case REQ_OP_ZONE_OPEN:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-		if (zone->cond == BLK_ZONE_COND_FULL)
-			return BLK_STS_IOERR;
-
-		zone->cond = BLK_ZONE_COND_EXP_OPEN;
+		ret = null_open_zone(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		break;
 	case REQ_OP_ZONE_CLOSE:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-		if (zone->cond == BLK_ZONE_COND_FULL)
-			return BLK_STS_IOERR;
-
-		if (zone->wp == zone->start)
-			zone->cond = BLK_ZONE_COND_EMPTY;
-		else
-			zone->cond = BLK_ZONE_COND_CLOSED;
+		ret = null_close_zone(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		break;
 	case REQ_OP_ZONE_FINISH:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-
-		zone->cond = BLK_ZONE_COND_FULL;
-		zone->wp = zone->start + zone->len;
+		ret = null_finish_zone(dev, zone);
+		if (ret != BLK_STS_OK)
+			return ret;
 		break;
 	default:
 		return BLK_STS_NOTSUPP;
-- 
2.26.2

