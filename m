Return-Path: <prvs=826a7d46a=masato.suzuki@wdc.com>
From: Masato Suzuki <masato.suzuki@wdc.com>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk
Cc: Matias.Bjorling@wdc.com,
	Damien.LeMoal@wdc.com
Subject: [PATCH] null_blk: Add conventional zone configuration for zoned support
Date: Mon, 22 Oct 2018 20:25:03 +0900
Message-Id: <20181022112503.4804-1-masato.suzuki@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Allow the creation of conventional zones by adding the nr_conv_zones
configuration attribute. This new attribute is used only for zoned devices and
indicates the number of conventional zones to create. The default value is 0.
Since host-managed zoned block devices must always have at least one sequential
zone, if the value of nr_conv_zones is larger than or equal to the total number
of zones of the device nr_zones, nr_conv_zones is automatically changed to
nr_zones - 1.

Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 drivers/block/null_blk.h       |  1 +
 drivers/block/null_blk_main.c  |  7 +++++++
 drivers/block/null_blk_zoned.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34e0030f0592..b9d0b57d3642 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -49,6 +49,7 @@ struct nullb_device {
 	unsigned long completion_nsec; /* time in ns to complete a request */
 	unsigned long cache_size; /* disk cache size in MB */
 	unsigned long zone_size; /* zone size in MB if device is zoned */
+	unsigned int nr_conv_zones; /* number of conventional zones */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int home_node; /* home node for the device */
 	unsigned int queue_mode; /* block interface */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 093b614d6524..ce6fa0ddc9f9 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -188,6 +188,10 @@ static unsigned long g_zone_size = 256;
 module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
 MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
 
+static unsigned int g_nr_conv_zones;
+module_param_named(nr_conv_zones, g_nr_conv_zones, uint, S_IRUGO);
+MODULE_PARM_DESC(nr_conv_zones, "Number of conventional zones when block device is zoned. Default: 0");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -293,6 +297,7 @@ NULLB_DEVICE_ATTR(mbps, uint);
 NULLB_DEVICE_ATTR(cache_size, ulong);
 NULLB_DEVICE_ATTR(zoned, bool);
 NULLB_DEVICE_ATTR(zone_size, ulong);
+NULLB_DEVICE_ATTR(nr_conv_zones, uint);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -407,6 +412,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_badblocks,
 	&nullb_device_attr_zoned,
 	&nullb_device_attr_zone_size,
+	&nullb_device_attr_nr_conv_zones,
 	NULL,
 };
 
@@ -520,6 +526,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->use_per_node_hctx = g_use_per_node_hctx;
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
+	dev->nr_conv_zones = g_nr_conv_zones;
 	return dev;
 }
 
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 7c6b86d98700..cf0d07491d29 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -29,7 +29,25 @@ int null_zone_init(struct nullb_device *dev)
 	if (!dev->zones)
 		return -ENOMEM;
 
-	for (i = 0; i < dev->nr_zones; i++) {
+	if (dev->nr_conv_zones >= dev->nr_zones) {
+		dev->nr_conv_zones = dev->nr_zones - 1;
+		pr_info("null_blk: changed the number of conventional zones to %u",
+			dev->nr_conv_zones);
+	}
+
+	for (i = 0; i <  dev->nr_conv_zones; i++ ) {
+		struct blk_zone *zone = &dev->zones[i];
+
+		zone->start = sector;
+		zone->len = dev->zone_size_sects;
+		zone->wp = zone->start + zone->len;
+		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
+		zone->cond = BLK_ZONE_COND_NOT_WP;
+
+		sector += dev->zone_size_sects;
+	}
+
+	for (i = dev->nr_conv_zones; i < dev->nr_zones; i++) {
 		struct blk_zone *zone = &dev->zones[i];
 
 		zone->start = zone->wp = sector;
@@ -125,6 +143,8 @@ void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		if (zone->wp == zone->start + zone->len)
 			zone->cond = BLK_ZONE_COND_FULL;
 		break;
+	case BLK_ZONE_COND_NOT_WP:
+		break;
 	default:
 		/* Invalid zone condition */
 		cmd->error = BLK_STS_IOERR;
@@ -138,6 +158,11 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 	unsigned int zno = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zno];
 
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		cmd->error = BLK_STS_IOERR;
+		return;
+	}
+
 	zone->cond = BLK_ZONE_COND_EMPTY;
 	zone->wp = zone->start;
 }
-- 
2.14.4
