Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BA6C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A0920729
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HwFLI5rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgKKFQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:16:59 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43941 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKKFQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071818; x=1636607818;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=rJy0p4QkOCx1xuA3M6loEpPfRJYBhFY0EOc0HkW8SBs=;
  b=HwFLI5rgH988OMqYtYubdnxr0i9pJj5kXMzlrEwG7o7V0c8ZSoCxJ7D1
   r+ibPSYTXUB7VHY5GNDOMPRA4Dki0ABK1oKSfOcZKss4Qhav9lqhYansC
   NsEP7L3ty7taDa7i8s2PruIUKMJzD+mRH7ksLY5SUse4koRAQpCGSwQRB
   N1nmU/6eq/ivZ78+rIlXxdlWgWulbUDXjsUFHxOxR4ENqmoxCQLZGNK7f
   yGjskastsMlKFBsZmsfTgUeCCp+fXDFyC7hMI3WwxPG/Zdn3GbEd8X5DW
   LUkR4AFSVonvcoJ/aQwIc3ihqntCCgey22EM+vllmYXfM4DbsnkL08sYq
   A==;
IronPort-SDR: RXrZiYRz+sd1xMgcrGtQOrgpBqnB+XO7a7j8HbMD10jhXYJjw3h85uov/xChp4CpzgREdiiJH4
 EO4V4tTR53QdTERVCN7nDV4eb+4wZDwO2ezsZqYTVyf/Su1pPuywHsIREyMOqfviuZCPvzo57h
 20eKpxv+ji3J/J7MGS9XVNRZ0344XXzdNEPg3gDK/4oWcvJHWPEqTtQKlb/Kzmj5YkCmZXS881
 Vz+v48wpEiRycUojesfeSq5d/oUN9Rz3XjYVVmTIgwn5dSa0o0BQo3zA1Enu3tk9P+xcTJdIzV
 vu8=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152254644"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:16:57 +0800
IronPort-SDR: SiA++XGD0bepJo+qpXlOEsi55TDYdJ0hHI2LG15pBZgnWQFpN8uj9qXRFMqHvf2y+Wg8zrjn2j
 aGHopkgPIPMXiGWvV6/MBxtaDnvQX/ly6V3K9m3E0BsyhFNuiK94F1+L6dmklTO82h491Mt3GN
 nBKtPePLx5eg4bDwbFaJmoYvL+UaLxvxoNeppAuqquSDuu/i9G8T+IRIVavPwtZsBDbkWdKFH7
 31yIM5H0TByAcpg4FWa5m488A4+DYxNAxAMf/hK4HuT1A56BAWffF/UOVngnp1Oh9QrqgLxzcm
 kn19uNHtqwGfwtKmRiOiX7Wp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:01:43 -0800
IronPort-SDR: Hm3rJEca4beTDTJZwNoaJ3IXDutsIVgIJY1HOKbMM5xXkA59XCjw1hg1WpMGMKE1c8K1X4Tl7H
 +HgXYk8rQAm2Y0X7/n5xzPKh1lKLFajJItsAK0wN2tHy4mby5uFj2Wwa6fOJfWk5BTDNDtxYGo
 +LNm21Pz/a2n5I/Zifh2ZxkuwsAO2ErA01Q/y8sVfgmKBuLzH3HiBi++tRNKXBmdzO8bIQ/oFw
 x14KvFJBfWBB/dtjwp45TsT4CR7i5aADKRkSV0yA3iDkrhiiA0mmPE0WRg7OW3MasCRDdDYFAi
 Gfs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:16:56 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 8/9] null_blk: Allow controlling max_hw_sectors limit
Date:   Wed, 11 Nov 2020 14:16:47 +0900
Message-Id: <20201111051648.635300-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111051648.635300-1-damien.lemoal@wdc.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the module option and configfs attribute max_sectors to allow
configuring the maximum size of a command issued to a null_blk device.
This allows exercising the block layer BIO splitting with different
limits than the default BLK_SAFE_MAX_SECTORS. This is also useful for
testing the zone append write path of file systems as the max_hw_sectors
limit value is also used for the max_zone_append_sectors limit.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h      |  1 +
 drivers/block/null_blk_main.c | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 76bd190fa185..6e5197987093 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -64,6 +64,7 @@ struct nullb_device {
 	unsigned int home_node; /* home node for the device */
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
+	unsigned int max_sectors; /* Max sectors per command */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index fa0bc65bbd1e..5f7fbcd56489 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -152,6 +152,10 @@ static int g_bs = 512;
 module_param_named(bs, g_bs, int, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
+static int g_max_sectors;
+module_param_named(max_sectors, g_max_sectors, int, 0444);
+MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
+
 static unsigned int nr_devices = 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -346,6 +350,7 @@ NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
 NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
+NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -463,6 +468,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_home_node,
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
+	&nullb_device_attr_max_sectors,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -533,7 +539,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active\n");
+			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -588,6 +594,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->home_node = g_home_node;
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
+	dev->max_sectors = g_max_sectors;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1867,9 +1874,13 @@ static int null_add_dev(struct nullb_device *dev)
 
 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
-	blk_queue_max_hw_sectors(nullb->q,
-				 round_down(queue_max_hw_sectors(nullb->q),
-					    dev->blocksize >> SECTOR_SHIFT));
+	if (!dev->max_sectors)
+		dev->max_sectors = queue_max_hw_sectors(nullb->q);
+	dev->max_sectors = min_t(unsigned int, dev->max_sectors,
+				 BLK_DEF_MAX_SECTORS);
+	dev->max_sectors = round_down(dev->max_sectors,
+				      dev->blocksize >> SECTOR_SHIFT);
+	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
 
 	null_config_discard(nullb);
 
@@ -1913,6 +1924,12 @@ static int __init null_init(void)
 		g_bs = PAGE_SIZE;
 	}
 
+	if (g_max_sectors > BLK_DEF_MAX_SECTORS) {
+		pr_warn("invalid max sectors\n");
+		pr_warn("defaults max sectors to %u\n", BLK_DEF_MAX_SECTORS);
+		g_max_sectors = BLK_DEF_MAX_SECTORS;
+	}
+
 	if (g_home_node != NUMA_NO_NODE && g_home_node >= nr_online_nodes) {
 		pr_err("invalid home_node value\n");
 		g_home_node = NUMA_NO_NODE;
-- 
2.26.2

