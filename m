Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909DC433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJSWYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJSWYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:24:08 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD2176B9A
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:24:07 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id h13so18549821pfr.7
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI/XeyfgEd9A9vq9BgkRrGggHrNZputL81Ga6OcqMtw=;
        b=gPk2AEda5WRcz33NOhlPeiM7qmpF9zRjVhrznj0y6K+144lRXUlrUoy9aTsU676HEt
         JkAj17BDyODcUsZuYQjBCOHiKpzPI6HKY1fxT7QCnUE2IjprOPmYvK5gkwWlu7wFQlSJ
         Z5QR7n8xOa2c7jOkeTb5bTPZABllX+T7YyF3y56hQQenyMyJkEwWyQwgQfcPOnBS5tEk
         HOLK9uQ0RJvLuwnn9n1ol3YySr1fDOfhvVFsVPk0CwAgKVuHPiV3T7oGPCxMslLd0VuM
         WApsP/4gUaP5kEKau74YuYxm6CBWlfGU15xVeXaeev87OPICJhexuupT7ou54LBC+ngM
         j4Pg==
X-Gm-Message-State: ACrzQf3an/Kl6WR3mCdNMRfzkPvGMTIZhnMK/NeEKRaOTskoCNqOhuM6
        eDycCMIODfYYYBnx+B17dwI=
X-Google-Smtp-Source: AMsMyM5XSYASZuys5ywGgSSBDoLoVzyfDTHrITVf6lhh3tvahEdATvhP3XSuQ/COEOXligNA5flbCQ==
X-Received: by 2002:a63:1349:0:b0:44b:2240:b311 with SMTP id 9-20020a631349000000b0044b2240b311mr9028954pgt.405.1666218246951;
        Wed, 19 Oct 2022 15:24:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:24:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 10/10] null_blk: Support configuring the maximum segment size
Date:   Wed, 19 Oct 2022 15:23:24 -0700
Message-Id: <20221019222324.362705-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add support for configuring the maximum segment size.

Add support for segments smaller than the page size.

This patch enables testing segments smaller than the page size with a
driver that does not call blk_rq_map_sg().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c     | 20 +++++++++++++++++---
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..bc811ab52c4a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -157,6 +157,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
+static unsigned int g_max_segment_size = 1UL << 31;
+module_param_named(max_segment_size, g_max_segment_size, int, 0444);
+MODULE_PARM_DESC(max_segment_size, "Maximum size of a segment in bytes");
+
 static unsigned int nr_devices = 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -409,6 +413,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(max_segment_size, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -532,6 +537,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_max_segment_size,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -610,7 +616,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 	return snprintf(page, PAGE_SIZE,
 			"badblocks,blocking,blocksize,cache_size,"
 			"completion_nsec,discard,home_node,hw_queue_depth,"
-			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
+			"irqmode,max_sectors,max_segment_size,mbps,"
+			"memory_backed,no_sched,"
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
@@ -673,6 +680,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
+	dev->max_segment_size = g_max_segment_size;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1214,6 +1222,8 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	unsigned int valid_len = len;
 	int err = 0;
 
+	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
+		  dev->max_segment_size);
 	if (!is_write) {
 		if (dev->zoned)
 			valid_len = null_zone_valid_read_len(nullb,
@@ -1249,7 +1259,8 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
-		len = bvec.bv_len;
+		len = min(bvec.bv_len, nullb->dev->max_segment_size);
+		bvec.bv_len = len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
 				     op_is_write(req_op(rq)), sector,
 				     rq->cmd_flags & REQ_FUA);
@@ -1276,7 +1287,8 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 
 	spin_lock_irq(&nullb->lock);
 	bio_for_each_segment(bvec, bio, iter) {
-		len = bvec.bv_len;
+		len = min(bvec.bv_len, nullb->dev->max_segment_size);
+		bvec.bv_len = len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
 				     op_is_write(bio_op(bio)), sector,
 				     bio->bi_opf & REQ_FUA);
@@ -2088,6 +2100,7 @@ static int null_add_dev(struct nullb_device *dev)
 	nullb->q->queuedata = nullb;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
+	blk_queue_flag_set(QUEUE_FLAG_SUB_PAGE_SEGMENTS, nullb->q);
 
 	mutex_lock(&lock);
 	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
@@ -2106,6 +2119,7 @@ static int null_add_dev(struct nullb_device *dev)
 	dev->max_sectors = min_t(unsigned int, dev->max_sectors,
 				 BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
+	blk_queue_max_segment_size(nullb->q, dev->max_segment_size);
 
 	if (dev->virt_boundary)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..6784ee9f5fda 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -102,6 +102,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned int max_segment_size; /* Max size of a single DMA segment. */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
