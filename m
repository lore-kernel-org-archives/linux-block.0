Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B6C388F9
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E267522259
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RtSHHA47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgKTBzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6558 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgKTBzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837347; x=1637373347;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pNUL4ST6yu4deA5ilYSy/0HGs6YN2e4PKGkMywlWeIA=;
  b=RtSHHA47Q7WJz5tHIffyA4xj/01Zc0yQ/U9baYblltnAXukA9H/N+UQk
   aubbDLc/uf1SOYa7siHXqYhmFV+0qeymn4k0U/Bl+MWGkQy+vEpnZctzt
   cbGpl9PZH1zeHolxUAT+5RIq52EBRhTlsjUCEilWUkgmIXhy2Zs3yAeqa
   pISUYTayA5SgrqZY0hGU//gzOd02Mx/0zUTq0dl4mr2EI9qwmTvSdsCjL
   d3LUxO5duHv8y3Ip0FpIoivv/N95+5nnxs8+DfEk25L10Sy2Lx0lqraLf
   +tL2GcVhQhHDuunuutzCHqmKUq30HpZstVbxsTPl9AJWNOqEC9yACHitm
   g==;
IronPort-SDR: bN0GP3zY0iqHRJLQ3vwNzQiqaHvupTTgGV54Xa3BctXVyIXS2j5YKN3J3Uxs9pkx8NogzqKb2L
 nFuMn4kFIcrVxdKL95uMLN/c5yR9o/OKH1VXqQOAeyiY1jrcI2c+/xIvc+GpjHBPIXhwTHZoD/
 C7EtITNat2t3sf76PkzH8fhdVE1XKiUGYaWU/XQNHcrZeBFvnbwNfr0KelE7BHRyIFISnowKDo
 0/NgnnEqFqYRAbxQRtphFL5rLd55PHV71uhqn96IyusF0tPe8tFSR+ES4Li28XnsM5mvdbFNCV
 Lms=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516409"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:47 +0800
IronPort-SDR: 7CKxw/12dXVV4+UdsA5q7iO8ja2Kpj86bgyQdazFLDxJOpJJQcTqXl29G8glBMD8ZJK1fFG1Pj
 TCVhMiQElIw2Yj1K5LrvhAiQDWQLOa1vtB8fF2+9DAd9VmWrfiQMqwN5RdxjjdZtxhUlMgw1CR
 8U24ujViITpCObzJCqbVRymL9el0+b10eT5FBz92KV+BOmvlpU1pw5W7pd0e49dHogXJc6P9cp
 I4oMiq1wpaUxU6HcyC4hOIVg44GUb+HarM6kHx4DFRR2U0cp856tziECpRWxtch5vQS0At2aXU
 gFbHjlsGmFP4G9El3eIIza7J
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:36 -0800
IronPort-SDR: 4Cv15q0WRna8Bd+T9aAbYqMz7G7ajB3EdcylwfseMOkYbJhrCCpAo71WZFXm0UAXIdvL6z/MfK
 8LMQL8m+Jz6Z6Wg62LtFQYjtjx6e9aL5dthVUHxn83zQQmd0SM4XidecXGGpkozxKRczHKAtgZ
 4JplRSx/ueqHSz/GYefhpzaXYwQT4wrMsfNjAUHzgUGibBxaci3WrsKjW3XaCvacqFq203Rk4a
 +4Mi/wbYBiZhjBIN/3kBRvHxegJuMJf0WMXAvx4ZAxwhtBIjP5956Pl9jou0ruofmCLsDsok75
 6/8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:46 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 8/9] null_blk: Allow controlling max_hw_sectors limit
Date:   Fri, 20 Nov 2020 10:55:18 +0900
Message-Id: <20201120015519.276820-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk.h      |  1 +
 drivers/block/null_blk_main.c | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 63000aeeb2f3..83504f3cc9d6 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -85,6 +85,7 @@ struct nullb_device {
 	unsigned int home_node; /* home node for the device */
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
+	unsigned int max_sectors; /* Max sectors per command */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index b758b9366630..5357c3a4a36f 100644
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
@@ -1867,6 +1874,11 @@ static int null_add_dev(struct nullb_device *dev)
 
 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
+	if (!dev->max_sectors)
+		dev->max_sectors = queue_max_hw_sectors(nullb->q);
+	dev->max_sectors = min_t(unsigned int, dev->max_sectors,
+				 BLK_DEF_MAX_SECTORS);
+	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
 
 	null_config_discard(nullb);
 
@@ -1910,6 +1922,12 @@ static int __init null_init(void)
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
2.28.0

