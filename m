Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E6C433DB
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 08:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278AA23133
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 08:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbhASInP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 03:43:15 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1399 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbhASIm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 03:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611045776; x=1642581776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y6dOEwqLpl0B2L45bIDXFCcME1XrSfA+Q8mO9kbSPHc=;
  b=pSwZRHJqjM5dVqtONiDo78VTF/5wCXsg/k3IqKmWzEg4f2CZkumk8zwr
   j7wQyN52xglN95fC2ed+sbLzluOUJf7bXB7grqfGmzQXZeg49p7mePX3Q
   hyxi4SXEw+rl0DbRhU8ilAVHshFwMgcxneJZApXxi8h+vTKp9olNcx5Yd
   44n0RO7VkqNY3uF3V3SxBNUrixbUoMHBOZgS95cBj9vdfgUr+GKzRFKnC
   RAW8EeMSXBcY+KQaHl8R/B01Leu+VDqgf2HST2YK0wJXJJSadNPhG3y3I
   CtnbJD6EJZzPh2Fmo4J1PpUqbQ0oSRUIj6jp7WpU+OuBxS1yDkvjfcLOA
   g==;
IronPort-SDR: lFJyKRy674G07qSjCe/F804aGLvVKnRLzrN5iQz/LdsXERwc0bhjxRQitVVBLPC6gZ+e2rOVGx
 hgm3bCgFgbrme5N6Sxt1osCJwoj2sK0iVXYewCt+8fOOjvz7YrYsgzlfvhEzTol2doxoEmGLki
 YHmmkCfRCsB4edJeHOngTTHEzBCvpLk5ZJWE27amuRworahznR7pY7HlurfVpshgsdWCZaDEZ1
 esk41dVoc75xhjBBBcod8sQxSd0kUq2d9cr1CPaRzTfBIxx0VVS0JFt3cKGHrDU0lYG9vpEqau
 zOg=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; 
   d="scan'208";a="268098204"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 16:41:05 +0800
IronPort-SDR: RW8jNV0MnU6/2HGewFZ+50AjArxcBjEQQu/iNBLpI1s1ZZKEw1XSWouyffqyijGOJip7CZ96pZ
 usX5Qe7QB1dXtOMkeD3HSNX6YOT8odywQ0G6f51slkTkxWuc6Wd4WgObaFLiA8GBGMPF206WJt
 /8c6o6vo5HQu/2zOzqnNj42LYOeMjc1hO517L9XTzN9zy/Mo61z/9YFc1lAcOOnh7W6gEQhnms
 d7dfzajtB24EQVcVY9rhJG0LppmQxGTYoIAR6F70TRzcYZ4D45BD56j07JGwVTTwI9QXdVZFCY
 1XS2Z6mNUVnPc5PZu3V+Uwnb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 00:25:42 -0800
IronPort-SDR: i5g9NcnCtBWoAWKJyisH73qeZEiT3tqhM+pZzC6SCXDj9gAodemBU0n0tMOT9x7gRU4aWIBvIx
 dkqAULmAqwOyAPbNNX7Eil4oNcZP5yUQvgRX1/oKAk8jpeWS8LcpkHmNYfDC5IwXSCC0cgPl4d
 8qIwC7KXQFU3VCldb7nIrFB6/WUnanSjZVf/alEyx7jpUF/md205zkD+zttnGS+y2tU+VDXjJP
 hNmh0mFRbP/Lbo2b63r/sC3KglFK5mhwffen6yhoqCASom/Dn6i1z+LdK8HSL9eDb4dOeHiHdL
 je8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jan 2021 00:41:04 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/2] block: introduce zone_write_granularity limit
Date:   Tue, 19 Jan 2021 17:41:02 +0900
Message-Id: <20210119084103.1631698-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119084103.1631698-1-damien.lemoal@wdc.com>
References: <20210119084103.1631698-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Per ZBC and ZAC specifications, host-managed SMR hard-disks mandate that
all writes into sequential write required zones be aligned to the device
physical block size. However, NVMe ZNS does not have this constraint and
allows write operations into sequential zones to be logical block size
aligned. This inconsistency does not help with portability of software
across device types.
To solve this, introduce the zone_write_granularity queue limit to
indicate the alignment constraint, in bytes, of write operations into
zones of a zoned block device. This new limit is exported as a
read-only sysfs queue attribute and the helper
blk_queue_zone_write_granularity() introduced for drivers to set this
limit. The scsi disk driver is modified to use this helper to set
host-managed SMR disk zone write granularity to the disk physical block
size. The nvme driver zns support use this helper to set the new limit
to the logical block size of the zoned namespace.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/block/queue-sysfs.rst |  7 +++++++
 block/blk-settings.c                | 28 ++++++++++++++++++++++++++++
 block/blk-sysfs.c                   |  7 +++++++
 drivers/nvme/host/zns.c             |  1 +
 drivers/scsi/sd_zbc.c               | 10 ++++++++++
 include/linux/blkdev.h              |  3 +++
 6 files changed, 56 insertions(+)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 2638d3446b79..c8bf8bc3c03a 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
 do not support zone commands, they will be treated as regular block devices
 and zoned will report "none".
 
+zone_write_granularity (RO)
+---------------------------
+This indicates the alignment constraint, in bytes, for write operations in
+sequential zones of zoned block devices (devices with a zoned attributed
+that reports "host-managed" or "host-aware"). This value is always 0 for
+regular block devices.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 43990b1d148b..6be6ed9485e3 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -60,6 +60,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->zone_write_granularity = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -366,6 +367,31 @@ void blk_queue_physical_block_size(struct request_queue *q, unsigned int size)
 }
 EXPORT_SYMBOL(blk_queue_physical_block_size);
 
+/**
+ * blk_queue_zone_write_granularity - set zone write granularity for the queue
+ * @q:  the request queue for the zoned device
+ * @size:  the zone write granularity size, in bytes
+ *
+ * Description:
+ *   This should be set to the lowest possible size allowing to write in
+ *   sequential zones of a zoned block device.
+ */
+void blk_queue_zone_write_granularity(struct request_queue *q,
+				      unsigned int size)
+{
+	if (WARN_ON(!blk_queue_is_zoned(q)))
+		return;
+
+	q->limits.zone_write_granularity = size;
+
+	if (q->limits.zone_write_granularity < q->limits.logical_block_size)
+		q->limits.zone_write_granularity = q->limits.logical_block_size;
+
+	if (q->limits.zone_write_granularity < q->limits.io_min)
+		q->limits.zone_write_granularity = q->limits.io_min;
+}
+EXPORT_SYMBOL_GPL(blk_queue_zone_write_granularity);
+
 /**
  * blk_queue_alignment_offset - set physical block alignment offset
  * @q:	the request queue for the device
@@ -631,6 +657,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			t->discard_granularity;
 	}
 
+	t->zone_write_granularity = max(t->zone_write_granularity,
+					b->zone_write_granularity);
 	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..7ea3dd4d876b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -219,6 +219,11 @@ static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
 		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
 }
 
+static ssize_t queue_zone_write_granularity_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.zone_write_granularity, page);
+}
+
 static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
 {
 	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
@@ -585,6 +590,7 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
+QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
@@ -639,6 +645,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
+	&queue_zone_write_granularity_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 1dfe9a3500e3..f25311ccd996 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -113,6 +113,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
+	blk_queue_zone_write_granularity(q, q->limits.logical_block_size);
 free_data:
 	kfree(id);
 	return status;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index cf07b7f93579..41d602f7e62e 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -789,6 +789,16 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	blk_queue_max_active_zones(q, 0);
 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
 
+	/*
+	 * Per ZBC and ZAC specifications, writes in sequential write required
+	 * zones of host-managed devices must be aligned to the device physical
+	 * block size.
+	 */
+	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
+		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
+	else
+		blk_queue_zone_write_granularity(q, sdkp->device->sector_size);
+
 	/* READ16/WRITE16 is mandatory for ZBC disks */
 	sdkp->device->use_16_for_rw = 1;
 	sdkp->device->use_10_for_rw = 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..011b3d2cd273 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -337,6 +337,7 @@ struct queue_limits {
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		zone_write_granularity;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
@@ -1161,6 +1162,8 @@ extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
+void blk_queue_zone_write_granularity(struct request_queue *q,
+				      unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
 void blk_queue_update_readahead(struct request_queue *q);
-- 
2.29.2

