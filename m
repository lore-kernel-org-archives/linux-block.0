Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C756C433DF
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C60206DB
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cWizg878"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFOXfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:35:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40434 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgFOXfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 19:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592264117; x=1623800117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZpbFMAmySpvBozRPQvGrKys6x+U74lWtkvJm8fSa6eA=;
  b=cWizg878gmgHnQ/YKBwJHNkF0UjcUTx76LaxOoXbkVsxGGL7sDXDygGU
   M/aV1YkPldhYXNSn1qe34mvlVP8nfqhqzfkqjoz56VViBsuqUTAwkyTHw
   660E3dmOCHCXYo89Pv9STLSEgg7nUkJTm7yoAFhXQ3GvCTM9+CTkEuZbZ
   NE11houmdzadwlRtpjJpaqu2pWz/eP+VoLFYIgggv6jfh0x9hQRQv4dWW
   WARWpi5uO831hgxmk3SIkILwdqSdox7kflWtIUlXJuaRXuHTBfXXMLV7F
   InxdsQdpkbofPF3g7aT3bSUIpakseFoOlzziVp0bJnBapktvqg4qee76Y
   g==;
IronPort-SDR: fwcZzrKWMx9aHZVXlHZ2LFbYLBmrW5dpWCxK+uVWxBKRD8sCrkjLLIqsLTm30CNXgYY2GEpYYf
 BSheTil/Lt/k+FDSY9X05ZOMcevujmhTVQwB1WZGlJ9MS6HrqWNtgu/nG/NPvJf8PlZVtcJhMX
 2PZNqMA890lJ0qtPXpJfLo3UfxLWawUER8i27glK/a3ywr+Sz+0rx3Yq8Z9sYBcxefBw7t/ntI
 uqd6IbzlLUDeswlD2HHMThlV/XkGkPO0tJiG5BJOjZHEc+M6faHKMgkGXB2QQWk/V2YVyG79x2
 2cc=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; 
   d="scan'208";a="249248748"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:35:17 +0800
IronPort-SDR: C3lCLY1KXS3VbCDAdmKDIyuJ3T/Ke6yzDnaSZxCqIkEdLlT1z/ekpqBMKZs1z5m0HAuhD8RRYs
 ln4vaRlBm5+LY/Yhwsl44Xgq3fL0+M548=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 16:24:34 -0700
IronPort-SDR: d1tJr2vjjXbQf9DPO7wQAGFAV4uVB2bLOfEHpus8iwV2d7pMixn8MGzZuE468clxoLbgZgfdL/
 OXaT1ndeIb7Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun51.ssa.fujisawa.hgst.com) ([10.149.66.26])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2020 16:35:16 -0700
From:   Keith Busch <keith.busch@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <aravind.ramesh@wdc.com>
Subject: [PATCH 2/5] null_blk: introduce zone capacity for zoned device
Date:   Tue, 16 Jun 2020 08:34:21 +0900
Message-Id: <20200615233424.13458-3-keith.busch@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200615233424.13458-1-keith.busch@wdc.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Aravind Ramesh <aravind.ramesh@wdc.com>

Allow emulation of a zoned device with a per zone capacity smaller than
the zone size as as defined in the Zoned Namespace (ZNS) Command Set
specification. The zone capacity defaults to the zone size if not
specified and must be smaller than the zone size otherwise.

Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
---
 drivers/block/null_blk.h       |  2 ++
 drivers/block/null_blk_main.c  |  9 ++++++++-
 drivers/block/null_blk_zoned.c | 17 +++++++++++++++--
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 81b311c9d781..7eadf190528c 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -44,11 +44,13 @@ struct nullb_device {
 	unsigned int nr_zones;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
+	sector_t zone_capacity_sects;
 
 	unsigned long size; /* device size in MB */
 	unsigned long completion_nsec; /* time in ns to complete a request */
 	unsigned long cache_size; /* disk cache size in MB */
 	unsigned long zone_size; /* zone size in MB if device is zoned */
+	unsigned long zone_capacity; /* zone cap in MB if device is zoned */
 	unsigned int zone_nr_conv; /* number of conventional zones */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int home_node; /* home node for the device */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 87b31f9ca362..54c5b5df399d 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -200,6 +200,10 @@ static unsigned long g_zone_size = 256;
 module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
 MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
 
+static unsigned long g_zone_capacity;
+module_param_named(zone_capacity, g_zone_capacity, ulong, 0444);
+MODULE_PARM_DESC(zone_capacity, "Zone capacity in MB when block device is zoned. Can be less than or equal to zone size. Default: Zone size");
+
 static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
@@ -341,6 +345,7 @@ NULLB_DEVICE_ATTR(mbps, uint, NULL);
 NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
 NULLB_DEVICE_ATTR(zoned, bool, NULL);
 NULLB_DEVICE_ATTR(zone_size, ulong, NULL);
+NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
@@ -457,6 +462,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_badblocks,
 	&nullb_device_attr_zoned,
 	&nullb_device_attr_zone_size,
+	&nullb_device_attr_zone_capacity,
 	&nullb_device_attr_zone_nr_conv,
 	NULL,
 };
@@ -510,7 +516,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_nr_conv\n");
+	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -571,6 +577,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->use_per_node_hctx = g_use_per_node_hctx;
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
+	dev->zone_capacity = g_zone_capacity;
 	dev->zone_nr_conv = g_zone_nr_conv;
 	return dev;
 }
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 624aac09b005..b05832eb21b2 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -28,7 +28,17 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		return -EINVAL;
 	}
 
+	if (!dev->zone_capacity)
+		dev->zone_capacity = dev->zone_size;
+
+	if (dev->zone_capacity > dev->zone_size) {
+		pr_err("null_blk: zone capacity %lu more than its size %lu\n",
+					dev->zone_capacity, dev->zone_size);
+		return -EINVAL;
+	}
+
 	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
+	dev->zone_capacity_sects = dev->zone_capacity << ZONE_SIZE_SHIFT;
 	dev->nr_zones = dev_size >>
 				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
@@ -60,7 +70,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 		zone->start = zone->wp = sector;
 		zone->len = dev->zone_size_sects;
-		zone->capacity = zone->len;
+		zone->capacity = dev->zone_capacity_sects;
 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 		zone->cond = BLK_ZONE_COND_EMPTY;
 
@@ -187,6 +197,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			return BLK_STS_IOERR;
 		}
 
+		if (zone->wp + nr_sectors > zone->start + zone->capacity)
+			return BLK_STS_IOERR;
+
 		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
@@ -195,7 +208,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			return ret;
 
 		zone->wp += nr_sectors;
-		if (zone->wp == zone->start + zone->len)
+		if (zone->wp == zone->start + zone->capacity)
 			zone->cond = BLK_ZONE_COND_FULL;
 		return BLK_STS_OK;
 	default:
-- 
2.24.1

