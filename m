Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9F9C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C9364EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhBBFdo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:33:44 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64849 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBBFdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243989; x=1643779989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=534Tr8xkWdxVXk3uHPFEyMGR+GwOeZelBohwBeP7J9M=;
  b=Ynwbh2WuAzO691JWPppBfOX0XsElQ7yXLuOy6nNM3zSk4OgRzuPCoYpt
   93keIJo6Yc2icJRFx9RhuJjj7fndOJR0qThyyNjVgkBDqDMepfReUxvuQ
   9hWhNx1h9dFh0REE9j37ESVt/XHzXxtVo9zBUnHYSlIe7gQs6kTo6OjWB
   Xv+hJ+YAjXNdU7lntAQzIlt0/u3jN+Yo/eZRZ2tDk4MNT7rmDa0euIN17
   Rtf/ypqFlzvuB0i2rq3H7ecF57E48YrodhuVY+KGTOe/H8CFSb5hiMc7C
   9X9GxyYGY44qYaD+/f2F8uoKsF539FfE6XfB7fb+q1QGlfzeJVMZPqdRD
   g==;
IronPort-SDR: Roz5GtFjFsLeqAEIJ2U4KJZtwZuaC1iwziO2UpK/Wkil2leaLsuEOHBcR7DwXOmGYPYS5VfugK
 L6on4gi9FUDYq6HLf3aGgAPco2dFjshEHiv0xSv4Jmro1cZf7Wq+Ji909TSDWi8XX4E6xRyAcC
 kbopa9Gt16PvttxBvNAxjn/Q/yQhB1fnYl29UVcHfJZln0pTFqX+RR5bv8QpXHxbIeII8qYrPv
 AkdLZezF887nwvL1UX8B+QWYcUMyQRRhOCT4HiedpZuiHpldHI/YRaTYbBHVwc+PgAicqOCIO4
 IVw=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163333729"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:28:11 +0800
IronPort-SDR: Y1Oi1KUDKzoelBhzJP1Ac1Bb1gLCkYo9L/Y2cLEhVX3B4/6J4iOwkZogPdBgMil2ugHTLDa+rV
 5/0YrLfKRcQ+kKciwHgigr0qnyiMDu98eJY7u3hIOHFP6z/Ig4KPyZxnGfYrgNyN+sbsuGRdrT
 OqCebNeIl5t/8j0Vd1VKvobLDnFlT+LIr5xWewD3N/idgfpfUwpmPfAHr9PGEMMt5HdL/g48XX
 RO3jVq4L4SdV8PT8tFj80lwOuVkkZH3f9o7lbgWWDJRhTwkBmWqsR8F5B+YyEkRxdCtjA1LPFJ
 u1aTbQqE+OMp5TNJlumbqxU4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:12:20 -0800
IronPort-SDR: AAUWh9h7PZfhBHDPw1HLT5bDvNAh2LJXbUSYG7HGiRUnumCUDayE8gh/F8TN5OXF+AOg6MraT1
 cal2YFCrYd8IKtWSFT7QCYitCORhq6mS8wv7m1fgaapuT60LXAoK1liFayBeiEF1D4iqb1eQer
 uR4PKrjUYDrC43f2PqTRqfRudQz96X/TJ/OWceB+ucfnTWy1bUjNeGlMcl6RGNkN2kbME0bMKo
 AMjWRssFqpLxir/dT1uvGubjdXuVkyRQBJuOqWkKJm8pz+0iaEzk1ijS+VmNNaix+mjwHsEZqD
 IL0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:28:11 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH 7/7] null_blk: add module param queue bounce limit
Date:   Mon,  1 Feb 2021 21:25:44 -0800
Message-Id: <20210202052544.4108-16-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a new module parameter to set the queue bounce limit.
Various queue limits parameters are usually present in the sysfs.
This is needed for testing purpose only so instead of poluting the
sysfs space just update the null_blk drivers.

This is needed especially for blktrace bounce related tracepoint
testing.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
# modprobe null_blk bounce_pfn=0x1000
# for bs in 512 1024 2048 4096 8192
> do
> 	dd if=/dev/zero of=/dev/nullb0 bs=${bs} count=1 oflag=direct
> done
# ~/blktrace/blktrace -a write -d /dev/nullb0 -o -| ~/blktrace/blkparse -i -
#
# # With null_blk bounce 
# modprobe null_blk bounce_pfn=0x1000
#
252,0   34        1     0.000000000  4390  Q  WS 0 + 1 [dd]
252,0   34        2     0.000010139  4390  B  WS 0 + 1 [dd]
252,0   34        3     0.000018996  4390  G  WS 0 + 1 [dd]
252,0   34        4     0.000024576  4390  I  WS 0 + 1 [dd]
252,0   34        5     0.000065152   829  D  WS 0 + 1 [kworker/34:1H]
252,0   34        6     0.000092303   182  C  WS 0 + 1 [0]
252,0   34        7     0.000098164   182  C  WS 0 + 1 [0]
252,0   27        1     0.004573597  4391  Q  WS 0 + 2 [dd]
252,0   27        2     0.004580891  4391  B  WS 0 + 2 [dd]
252,0   27        3     0.004589687  4391  G  WS 0 + 2 [dd]
252,0   27        4     0.004594356  4391  I  WS 0 + 2 [dd]
252,0   27        5     0.004619473  1049  D  WS 0 + 2 [kworker/27:1H]
252,0   27        6     0.004634411   147  C  WS 0 + 2 [0]
252,0   27        7     0.004638609   147  C  WS 0 + 2 [0]
252,0   29        1     0.014589610  4394  Q  WS 0 + 8 [dd]
252,0   29        2     0.014595792  4394  B  WS 0 + 8 [dd]
252,0   29        3     0.014599028  4394  G  WS 0 + 8 [dd]
252,0   29        4     0.014601713  4394  I  WS 0 + 8 [dd]
252,0   29        5     0.014621330   807  D  WS 0 + 8 [kworker/29:1H]
252,0   29        6     0.014633813   157  C  WS 0 + 8 [0]
252,0   29        7     0.014637660   157  C  WS 0 + 8 [0]
252,0   30        1     0.009147174  4392  Q  WS 0 + 4 [dd]
252,0   30        2     0.009154377  4392  B  WS 0 + 4 [dd]
252,0   30        3     0.009163064  4392  G  WS 0 + 4 [dd]
252,0   30        4     0.009167161  4392  I  WS 0 + 4 [dd]
252,0   30        5     0.009191437  1084  D  WS 0 + 4 [kworker/30:1H]
252,0   30        6     0.009206084   162  C  WS 0 + 4 [0]
252,0   30        7     0.009210863   162  C  WS 0 + 4 [0]
252,0   30        8     0.018510473  4395  Q  WS 0 + 16 [dd]
252,0   30        9     0.018517767  4395  B  WS 0 + 16 [dd]
252,0   30       10     0.018521213  4395  G  WS 0 + 16 [dd]
252,0   30       11     0.018524229  4395  I  WS 0 + 16 [dd]
252,0   30       12     0.018544026  1084  D  WS 0 + 16 [kworker/30:1H]
252,0   30       13     0.018555127   162  C  WS 0 + 16 [0]
252,0   30       14     0.018558333   162  C  WS 0 + 16 [0]

# # Without null_blk bounce 
252,0   38        1     0.000000000  4744  Q  WS 0 + 1 [dd]
252,0   38        2     0.000014768  4744  G  WS 0 + 1 [dd]
252,0   38        3     0.000021771  4744  I  WS 0 + 1 [dd]
252,0   38        4     0.000062557   914  D  WS 0 + 1 [kworker/38:1H]
252,0   38        5     0.000089768   202  C  WS 0 + 1 [0]
252,0   32        1     0.018453947  4749  Q  WS 0 + 16 [dd]
252,0   32        2     0.018466080  4749  G  WS 0 + 16 [dd]
252,0   32        3     0.018470619  4749  I  WS 0 + 16 [dd]
252,0   32        4     0.018495195   514  D  WS 0 + 16 [kworker/32:1H]
252,0   32        5     0.018509942   172  C  WS 0 + 16 [0]
252,0   55        1     0.005000087  4745  Q  WS 0 + 2 [dd]
252,0   55        2     0.005005637  4745  G  WS 0 + 2 [dd]
252,0   55        3     0.005008453  4745  I  WS 0 + 2 [dd]
252,0   55        4     0.005029352  1082  D  WS 0 + 2 [kworker/55:1H]
252,0   55        5     0.005041915   287  C  WS 0 + 2 [0]
252,0   31        1     0.014158231  4748  Q  WS 0 + 8 [dd]
252,0   31        2     0.014164173  4748  G  WS 0 + 8 [dd]
252,0   31        3     0.014167308  4748  I  WS 0 + 8 [dd]
252,0   31        4     0.014188759  1151  D  WS 0 + 8 [kworker/31:1H]
252,0   31        5     0.014203015   167  C  WS 0 + 8 [0]
252,0   58        1     0.010016655  4747  D  WS 0 + 4 [systemd-udevd]
252,0   60        1     0.009982571  4746  Q  WS 0 + 4 [dd]
252,0   60        2     0.009993942  4746  G  WS 0 + 4 [dd]
252,0   60        3     0.009998661  4746  I  WS 0 + 4 [dd]
252,0   60        4     0.010136269     0  C  WS 0 + 4 [0]

---
 drivers/block/null_blk/main.c     | 20 +++++++++++++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6e6cbb953a12..8ddf2ba961f7 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -156,6 +156,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
+static unsigned int g_bounce_pfn;
+module_param_named(bounce_pfn, g_bounce_pfn, int, 0444);
+MODULE_PARM_DESC(bounce_pfn, "Queue Bounce limit (default: 0)");
+
 static unsigned int nr_devices = 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -354,6 +358,7 @@ NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
 NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
+NULLB_DEVICE_ATTR(bounce_pfn, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
@@ -472,6 +477,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_home_node,
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
+	&nullb_device_attr_bounce_pfn,
 	&nullb_device_attr_max_sectors,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
@@ -543,7 +549,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors\n");
+			"memory_backed,discard,bounce_pfn,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -1610,6 +1616,17 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
+static void null_config_bounce_pfn(struct nullb *nullb)
+{
+	if (nullb->dev->memory_backed && nullb->dev->bounce_pfn == false)
+		return;
+
+	if (!nullb->dev->memory_backed && !g_bounce_pfn)
+		return;
+
+	blk_queue_bounce_limit(nullb->q, nullb->dev->bounce_pfn);
+}
+
 static const struct block_device_operations null_bio_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= null_submit_bio,
@@ -1882,6 +1899,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
 
 	null_config_discard(nullb);
+	null_config_bounce_pfn(nullb);
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 83504f3cc9d6..cd55f99118bf 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -86,6 +86,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned int bounce_pfn; /* bounce page frame number */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
-- 
2.22.1

