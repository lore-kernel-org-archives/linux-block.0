Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40933 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934056AbeGFRjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jul 2018 13:39:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id a6-v6so9722746ljj.7
        for <linux-block@vger.kernel.org>; Fri, 06 Jul 2018 10:39:17 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, damien.lemoal@wdc.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 2/2] null_blk: add zone support
Date: Fri,  6 Jul 2018 19:38:39 +0200
Message-Id: <20180706173839.28355-3-mb@lightnvm.io>
In-Reply-To: <20180706173839.28355-1-mb@lightnvm.io>
References: <20180706173839.28355-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Matias Bjørling <matias.bjorling@wdc.com>

Adds support for exposing a null_blk device through the zone device
interface.

The interface is managed with the parameters zoned and zone_size.
If zoned is set, the null_blk instance registers as a zoned block
device. The zone_size parameter defines how big each zone will be.

Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/block/null_blk.txt |   7 ++
 drivers/block/Makefile           |   5 +-
 drivers/block/null_blk.c         |  48 ++++++++++++-
 drivers/block/null_blk.h         |  28 ++++++++
 drivers/block/null_blk_zoned.c   | 149 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 234 insertions(+), 3 deletions(-)
 create mode 100644 drivers/block/null_blk_zoned.c

diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
index 07f147381f32..ea2dafe49ae8 100644
--- a/Documentation/block/null_blk.txt
+++ b/Documentation/block/null_blk.txt
@@ -85,3 +85,10 @@ shared_tags=[0/1]: Default: 0
   0: Tag set is not shared.
   1: Tag set shared between devices for blk-mq. Only makes sense with
      nr_devices > 1, otherwise there's no tag set to share.
+
+zoned=[0/1]: Default: 0
+  0: Block device is exposed as a random-access block device.
+  1: Block device is exposed as a host-managed zoned block device.
+
+zone_size=[MB]: Default: 256
+  Per zone size when exposed as a zoned block device. Must be a power of two.
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index dc061158b403..a0d88aa0c05d 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -36,8 +36,11 @@ obj-$(CONFIG_BLK_DEV_RBD)     += rbd.o
 obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
 obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
-obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 obj-$(CONFIG_ZRAM) += zram/
 
+obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk_mod.o
+null_blk_mod-objs	:= null_blk.o
+null_blk_mod-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
+
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index cd4b0849d3b4..99b6bfe7abd1 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -180,6 +180,14 @@ static bool g_use_per_node_hctx;
 module_param_named(use_per_node_hctx, g_use_per_node_hctx, bool, 0444);
 MODULE_PARM_DESC(use_per_node_hctx, "Use per-node allocation for hardware context queues. Default: false");
 
+static bool g_zoned;
+module_param_named(zoned, g_zoned, bool, S_IRUGO);
+MODULE_PARM_DESC(zoned, "Make device as a host-managed zoned block device. Default: false");
+
+static unsigned long g_zone_size = 256;
+module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
+MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -283,6 +291,8 @@ NULLB_DEVICE_ATTR(memory_backed, bool);
 NULLB_DEVICE_ATTR(discard, bool);
 NULLB_DEVICE_ATTR(mbps, uint);
 NULLB_DEVICE_ATTR(cache_size, ulong);
+NULLB_DEVICE_ATTR(zoned, bool);
+NULLB_DEVICE_ATTR(zone_size, ulong);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -394,6 +404,8 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_mbps,
 	&nullb_device_attr_cache_size,
 	&nullb_device_attr_badblocks,
+	&nullb_device_attr_zoned,
+	&nullb_device_attr_zone_size,
 	NULL,
 };
 
@@ -446,7 +458,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks\n");
+	return snprintf(page, PAGE_SIZE, "memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -505,6 +517,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
 	dev->use_per_node_hctx = g_use_per_node_hctx;
+	dev->zoned = g_zoned;
+	dev->zone_size = g_zone_size;
 	return dev;
 }
 
@@ -513,6 +527,7 @@ static void null_free_dev(struct nullb_device *dev)
 	if (!dev)
 		return;
 
+	null_zone_exit(dev);
 	badblocks_exit(&dev->badblocks);
 	kfree(dev);
 }
@@ -1145,6 +1160,11 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 	struct nullb *nullb = dev->nullb;
 	int err = 0;
 
+	if (req_op(cmd->rq) == REQ_OP_ZONE_REPORT) {
+		cmd->error = null_zone_report(nullb, cmd);
+		goto out;
+	}
+
 	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags)) {
 		struct request *rq = cmd->rq;
 
@@ -1209,6 +1229,13 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		}
 	}
 	cmd->error = errno_to_blk_status(err);
+
+	if (!cmd->error && dev->zoned) {
+		if (req_op(cmd->rq) == REQ_OP_WRITE)
+			null_zone_write(cmd);
+		else if (req_op(cmd->rq) == REQ_OP_ZONE_RESET)
+			null_zone_reset(cmd);
+	}
 out:
 	/* Complete IO by inline, softirq or timer */
 	switch (dev->irqmode) {
@@ -1736,6 +1763,15 @@ static int null_add_dev(struct nullb_device *dev)
 		blk_queue_flush_queueable(nullb->q, true);
 	}
 
+	if (dev->zoned) {
+		rv = null_zone_init(dev);
+		if (rv)
+			goto out_cleanup_blk_queue;
+
+		blk_queue_chunk_sectors(nullb->q, dev->zone_size_sects);
+		nullb->q->limits.zoned = BLK_ZONED_HM;
+	}
+
 	nullb->q->queuedata = nullb;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
@@ -1754,13 +1790,16 @@ static int null_add_dev(struct nullb_device *dev)
 
 	rv = null_gendisk_register(nullb);
 	if (rv)
-		goto out_cleanup_blk_queue;
+		goto out_cleanup_zone;
 
 	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
 	mutex_unlock(&lock);
 
 	return 0;
+out_cleanup_zone:
+	if (dev->zoned)
+		null_zone_exit(dev);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
@@ -1787,6 +1826,11 @@ static int __init null_init(void)
 		g_bs = PAGE_SIZE;
 	}
 
+	if (!is_power_of_2(g_zone_size)) {
+		pr_err("null_blk: zone_size must be power-of-two\n");
+		return -EINVAL;
+	}
+
 	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
 		if (g_submit_queues != nr_online_nodes) {
 			pr_warn("null_blk: submit_queues param is set to %u.\n",
diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index d82c5501806d..d81781f22dba 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -41,9 +41,14 @@ struct nullb_device {
 	unsigned int curr_cache;
 	struct badblocks badblocks;
 
+	unsigned int nr_zones;
+	struct blk_zone *zones;
+	sector_t zone_size_sects;
+
 	unsigned long size; /* device size in MB */
 	unsigned long completion_nsec; /* time in ns to complete a request */
 	unsigned long cache_size; /* disk cache size in MB */
+	unsigned long zone_size; /* zone size in MB if device is zoned */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int home_node; /* home node for the device */
 	unsigned int queue_mode; /* block interface */
@@ -57,6 +62,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool zoned; /* if device is zoned */
 };
 
 struct nullb {
@@ -77,4 +83,26 @@ struct nullb {
 	unsigned int nr_queues;
 	char disk_name[DISK_NAME_LEN];
 };
+
+#ifdef CONFIG_BLK_DEV_ZONED
+int null_zone_init(struct nullb_device *dev);
+void null_zone_exit(struct nullb_device *dev);
+blk_status_t null_zone_report(struct nullb *nullb,
+					    struct nullb_cmd *cmd);
+void null_zone_write(struct nullb_cmd *cmd);
+void null_zone_reset(struct nullb_cmd *cmd);
+#else
+static inline int null_zone_init(struct nullb_device *dev)
+{
+	return -EINVAL;
+}
+static inline void null_zone_exit(struct nullb_device *dev) {}
+static inline blk_status_t null_zone_report(struct nullb *nullb,
+					    struct nullb_cmd *cmd)
+{
+	return BLK_STS_NOTSUPP;
+}
+static inline void null_zone_write(struct nullb_cmd *cmd) {}
+static inline void null_zone_reset(struct nullb_cmd *cmd) {}
+#endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
new file mode 100644
index 000000000000..a979ca00d7be
--- /dev/null
+++ b/drivers/block/null_blk_zoned.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/vmalloc.h>
+#include "null_blk.h"
+
+/* zone_size in MBs to sectors. */
+#define ZONE_SIZE_SHIFT		11
+
+static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
+{
+	return sect >> ilog2(dev->zone_size_sects);
+}
+
+int null_zone_init(struct nullb_device *dev)
+{
+	sector_t dev_size = (sector_t)dev->size * 1024 * 1024;
+	sector_t sector = 0;
+	unsigned int i;
+
+	if (!is_power_of_2(dev->zone_size)) {
+		pr_err("null_blk: zone_size must be power-of-two\n");
+		return -EINVAL;
+	}
+
+	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
+	dev->nr_zones = dev_size >>
+				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
+	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
+			GFP_KERNEL | __GFP_ZERO);
+	if (!dev->zones)
+		return -ENOMEM;
+
+	for (i = 0; i < dev->nr_zones; i++) {
+		struct blk_zone *zone = &dev->zones[i];
+
+		zone->start = zone->wp = sector;
+		zone->len = dev->zone_size_sects;
+		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
+		zone->cond = BLK_ZONE_COND_EMPTY;
+
+		sector += dev->zone_size_sects;
+	}
+
+	return 0;
+}
+
+void null_zone_exit(struct nullb_device *dev)
+{
+	kvfree(dev->zones);
+}
+
+static void null_zone_fill_rq(struct nullb_device *dev, struct request *rq,
+			      unsigned int zno, unsigned int nr_zones)
+{
+	struct blk_zone_report_hdr *hdr = NULL;
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+	void *addr;
+	unsigned int zones_to_cpy;
+
+	bio_for_each_segment(bvec, rq->bio, iter) {
+		addr = kmap_atomic(bvec.bv_page);
+
+		zones_to_cpy = bvec.bv_len / sizeof(struct blk_zone);
+
+		if (!hdr) {
+			hdr = (struct blk_zone_report_hdr *)addr;
+			hdr->nr_zones = nr_zones;
+			zones_to_cpy--;
+			addr += sizeof(struct blk_zone_report_hdr);
+		}
+
+		zones_to_cpy = min_t(unsigned int, zones_to_cpy, nr_zones);
+
+		memcpy(addr, &dev->zones[zno],
+				zones_to_cpy * sizeof(struct blk_zone));
+
+		kunmap_atomic(addr);
+
+		nr_zones -= zones_to_cpy;
+		zno += zones_to_cpy;
+
+		if (!nr_zones)
+			break;
+	}
+}
+
+blk_status_t null_zone_report(struct nullb *nullb,
+				     struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = nullb->dev;
+	struct request *rq = cmd->rq;
+	unsigned int zno = null_zone_no(dev, blk_rq_pos(rq));
+	unsigned int nr_zones = dev->nr_zones - zno;
+	unsigned int max_zones = (blk_rq_bytes(rq) /
+					sizeof(struct blk_zone)) - 1;
+
+	nr_zones = min_t(unsigned int, nr_zones, max_zones);
+
+	null_zone_fill_rq(nullb->dev, rq, zno, nr_zones);
+
+	return BLK_STS_OK;
+}
+
+void null_zone_write(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	struct request *rq = cmd->rq;
+	sector_t sector = blk_rq_pos(rq);
+	unsigned int rq_sectors = blk_rq_sectors(rq);
+	unsigned int zno = null_zone_no(dev, sector);
+	struct blk_zone *zone = &dev->zones[zno];
+
+	switch (zone->cond) {
+	case BLK_ZONE_COND_FULL:
+		/* Cannot write to a full zone */
+		cmd->error = BLK_STS_IOERR;
+		break;
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_IMP_OPEN:
+		/* Writes must be at the write pointer position */
+		if (blk_rq_pos(rq) != zone->wp) {
+			cmd->error = BLK_STS_IOERR;
+			break;
+		}
+
+		if (zone->cond == BLK_ZONE_COND_EMPTY)
+			zone->cond = BLK_ZONE_COND_IMP_OPEN;
+
+		zone->wp += rq_sectors;
+		if (zone->wp == zone->start + zone->len)
+			zone->cond = BLK_ZONE_COND_FULL;
+		break;
+	default:
+		/* Invalid zone condition */
+		cmd->error = BLK_STS_IOERR;
+		break;
+	}
+}
+
+void null_zone_reset(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	struct request *rq = cmd->rq;
+	unsigned int zno = null_zone_no(dev, blk_rq_pos(rq));
+	struct blk_zone *zone = &dev->zones[zno];
+
+	zone->cond = BLK_ZONE_COND_EMPTY;
+	zone->wp = zone->start;
+}
-- 
2.11.0
