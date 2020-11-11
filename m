Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91517C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359D32074B
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Psd2VZRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgKKNBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:01:00 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32534 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgKKNA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099659; x=1636635659;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=kmiiJbhUyC22YQgPw/gfrmzkz4MvpWwRC2dUGM9fdm0=;
  b=Psd2VZRKlE1ALZMabtYufCu7XbxRzD6al2Z7jSWJNhSiP0y+ySU769ME
   1Fw7wYs4GHyJsTdGKwsRzOif2YsI6JhYsIvtkw1RJJ9Y403k8KNq2TUEb
   H86nA2BBf6PjD4D3HCj39OIoCH0JumALasghh21X5wim6apD6PiZSj4Um
   qCXRvwDqurjS4joSlcZ/+XgPSEoQ5Sr+vsOgW3YfaQiT/EgRRwndK3U9m
   p3+wSkPcYaqLCYLcoKDAuxOCth7S9ioUAX39Oc2sk2iLE7HWiC/xMC7ME
   bVDuX5hBaXYbJo1zgBhzpq1ntyETCn6yjLyoRY/BduQYXSZnN3YPmrGjx
   w==;
IronPort-SDR: pozfVQWVhQ5ez853dKsMJZO40mOB9BgEMUaG9BTuE9JUJ99wuQcrTrr3dibIHKbb513C6kNubX
 Z0z5qItGq8NpzLa8dNzgW75N7NnHSVkimuNIcCSBM436c+LWbJFASJeaErBvVp3dZeddjAohho
 Z0NSpo5dtp7ZhG+OhgRziECWkSfSY6/iPlZHnq8Jx9EoI9iHzIJh2oWskcgA954SliJKPJ8IJ/
 IXVn7nHMLhNYGFR+96UMjZthcigdHd9mnTzm2kyivpvZE6LCnfoLqiokaQxyd9pb4DtKeRqobX
 ffs=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283550"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:58 +0800
IronPort-SDR: 1RbK8KDfWFMrUPkYQCaNuBbrwVRq2naY6XSLTE/d4icN0DF2YWgTBJgV+RTxd+KQbEEalM3kZr
 wbnrpmpZUzLyz47IfamL2Buf0NYMDrvFvBFhEWGPq7v+vMgynWiOHY44JwNGpG6g4SpZrJ+Q6e
 fzquYuvnjg7vaAu4sMINWJPcZlFsdm/B26bDGa8YCY8fuhN4KerpnI6ARFe00vKZuKH/1cN9AS
 hbOWYBlOPsLafhePmDD5V8Aij7+CEMuLVgUmgU+YDHY1PeF3MJGUBEZVcX7KZIrFGtoM2VRHkL
 lPMepw2ZSqVqBigKSjeioo29
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:41 -0800
IronPort-SDR: 8Ut604kcAfqRDPOiGmVlp3ZcHPDwemwUjcmXYzfX/cnFuL3wUDydF8buoyazGienuYT3yIVh9U
 1bnV/LsTqYnbpbH0VKTXoBepZR9nXxjH3R1Bydkq7XRGQrrQBX7bsAwE2ReiHHcBL7W4HqRwkY
 ePBc4H2pSkPDI8Vj8ws9DCT8uX8LqorypuLH/pyRBq54QrOSdlETi26suB2ik+z+84X7I8S9xV
 RNybr4SS/E2emAhwQzul2BgaajJGXaKusxzxQHhI9rUbMKX1xe+tLH/NBXZeJk1Y1+vV2Tjym5
 cqw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:58 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 8/9] null_blk: Allow controlling max_hw_sectors limit
Date:   Wed, 11 Nov 2020 22:00:48 +0900
Message-Id: <20201111130049.967902-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
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
2.26.2

