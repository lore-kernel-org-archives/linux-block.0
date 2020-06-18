Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC4C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E2D208C3
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592492049;
	bh=YV+tl9i0l4hpz3Vlmv2brq9JsiltvYjbkzuQET+6SlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqa2O+Tl34/B/aAInK9sWM9tYSPJMxfNt4YXwMUFrvcNllhpCXOoZ8kphtOH6a58N
	 Cu+J8LEjQkv2f7SJeHkrfX5GYT7z6Xs5FyRFODNgk/P+THc4oVWrxQf6JlIiP0Ta2T
	 pGybnkcuKUyJzUenA9TZC86u7jjIiWo2YE5fUxDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgFROyI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbgFROyH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:54:07 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D0D2075E;
        Thu, 18 Jun 2020 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592492046;
        bh=YV+tl9i0l4hpz3Vlmv2brq9JsiltvYjbkzuQET+6SlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xRfnBuPcVruSDXZD+YPhFjncSQA1QpaoCCguynPDDTe4O9+x/AuY0e07ntMqONqj7
         MdWRHHx85PzeslD0/ForSbThXvPxA6nJtF1qvvk2HI3rCh7IH2DiyJhtkrqmipbJPb
         CDC0ZnMGFGa5DTZ3aW8fEkcWOfJIe7HT7toeDxKc=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     axboe@kernel.dk, Aravind Ramesh <aravind.ramesh@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv2 2/5] null_blk: introduce zone capacity for zoned device
Date:   Thu, 18 Jun 2020 07:53:51 -0700
Message-Id: <20200618145354.1139350-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200618145354.1139350-1-kbusch@kernel.org>
References: <20200618145354.1139350-1-kbusch@kernel.org>
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

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
---
 drivers/block/null_blk.h       |  1 +
 drivers/block/null_blk_main.c  | 10 +++++++++-
 drivers/block/null_blk_zoned.c | 16 ++++++++++++++--
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 81b311c9d781..daed4a9c3436 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -49,6 +49,7 @@ struct nullb_device {
 	unsigned long completion_nsec; /* time in ns to complete a request */
 	unsigned long cache_size; /* disk cache size in MB */
 	unsigned long zone_size; /* zone size in MB if device is zoned */
+	unsigned long zone_capacity; /* zone capacity in MB if device is zoned */
 	unsigned int zone_nr_conv; /* number of conventional zones */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int home_node; /* home node for the device */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 87b31f9ca362..a2a0e199215b 100644
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
@@ -510,7 +516,8 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_nr_conv\n");
+	return snprintf(page, PAGE_SIZE,
+			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -571,6 +578,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->use_per_node_hctx = g_use_per_node_hctx;
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
+	dev->zone_capacity = g_zone_capacity;
 	dev->zone_nr_conv = g_zone_nr_conv;
 	return dev;
 }
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 624aac09b005..3d25c9ad2383 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -28,6 +28,15 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		return -EINVAL;
 	}
 
+	if (!dev->zone_capacity)
+		dev->zone_capacity = dev->zone_size;
+
+	if (dev->zone_capacity > dev->zone_size) {
+		pr_err("null_blk: zone capacity (%lu MB) larger than zone size (%lu MB)\n",
+					dev->zone_capacity, dev->zone_size);
+		return -EINVAL;
+	}
+
 	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
 	dev->nr_zones = dev_size >>
 				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
@@ -60,7 +69,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 		zone->start = zone->wp = sector;
 		zone->len = dev->zone_size_sects;
-		zone->capacity = zone->len;
+		zone->capacity = dev->zone_capacity << ZONE_SIZE_SHIFT;
 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 		zone->cond = BLK_ZONE_COND_EMPTY;
 
@@ -187,6 +196,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			return BLK_STS_IOERR;
 		}
 
+		if (zone->wp + nr_sectors > zone->start + zone->capacity)
+			return BLK_STS_IOERR;
+
 		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
@@ -195,7 +207,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			return ret;
 
 		zone->wp += nr_sectors;
-		if (zone->wp == zone->start + zone->len)
+		if (zone->wp == zone->start + zone->capacity)
 			zone->cond = BLK_ZONE_COND_FULL;
 		return BLK_STS_OK;
 	default:
-- 
2.24.1

