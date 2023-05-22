Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ED4C77B75
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjEVW0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjEVW0j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:39 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EEE18C
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:23 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-25394160fd3so2319491a91.3
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794383; x=1687386383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvi1TxdGwQ+oUJ+KwvuIRaZ54tp1VuAz4INXuYgdkq4=;
        b=EJofnBu3R3BMC+Be19tLb6K5X2qeGJPqrj4cn6mWXiR7mOWfXTrmAknEEocYba5oem
         WvF4imVp2BQ8/8shnEZEdF6pLwg05UH1x2ef0uCvKWSr5R/x4FHdIz1FsCqlBU5/egeH
         SG/LLzeqydGVoojYT630VUwsJHvgg2bd4VCdvo11q+jbNSkcAofwowZ+c5OoIqhqDQNv
         YQGh6otnPHBPLv+M3JCvB3zqwJrhr37r8a9l/yQwm0LxH8wFol3uXT3SePTdBSVoNaaF
         dnSoxqcP13rkcvbUY6NizhC1+vU7oswWvHdNY8j8f5P2kld3+N9CCktHs2ZuT0C94fUI
         RRgg==
X-Gm-Message-State: AC+VfDzYnhsFaOQZ6cEJORBpEGr58TDY5CYxlfpWQB7gMd9lf2XIrhY6
        mI9AxEbL3D1buNza7x7yNak=
X-Google-Smtp-Source: ACHHUZ7PFGBd86olyez9J/FmT6rRNxJzqMzdhdqf3U8y2XkUQlGlOeItH5Pxtwhe5N3Hh9x6lAQbDw==
X-Received: by 2002:a17:90b:30d7:b0:250:a6bd:cb4a with SMTP id hi23-20020a17090b30d700b00250a6bdcb4amr10979660pjb.29.1684794383165;
        Mon, 22 May 2023 15:26:23 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:26:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v5 9/9] null_blk: Support configuring the maximum segment size
Date:   Mon, 22 May 2023 15:25:41 -0700
Message-ID: <20230522222554.525229-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
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
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c     | 19 ++++++++++++++++---
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b3fedafe301e..9c9098f1bd52 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -157,6 +157,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
+static unsigned int g_max_segment_size = BLK_MAX_SEGMENT_SIZE;
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
@@ -550,6 +555,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_max_segment_size,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -652,7 +658,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 	return snprintf(page, PAGE_SIZE,
 			"badblocks,blocking,blocksize,cache_size,"
 			"completion_nsec,discard,home_node,hw_queue_depth,"
-			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
+			"irqmode,max_sectors,max_segment_size,mbps,"
+			"memory_backed,no_sched,"
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
@@ -722,6 +729,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
+	dev->max_segment_size = g_max_segment_size;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1248,6 +1256,8 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	unsigned int valid_len = len;
 	int err = 0;
 
+	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
+		  dev->max_segment_size);
 	if (!is_write) {
 		if (dev->zoned)
 			valid_len = null_zone_valid_read_len(nullb,
@@ -1283,7 +1293,8 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
-		len = bvec.bv_len;
+		len = min(bvec.bv_len, nullb->dev->max_segment_size);
+		bvec.bv_len = len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
 				     op_is_write(req_op(rq)), sector,
 				     rq->cmd_flags & REQ_FUA);
@@ -1310,7 +1321,8 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 
 	spin_lock_irq(&nullb->lock);
 	bio_for_each_segment(bvec, bio, iter) {
-		len = bvec.bv_len;
+		len = min(bvec.bv_len, nullb->dev->max_segment_size);
+		bvec.bv_len = len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
 				     op_is_write(bio_op(bio)), sector,
 				     bio->bi_opf & REQ_FUA);
@@ -2161,6 +2173,7 @@ static int null_add_dev(struct nullb_device *dev)
 		dev->max_sectors = queue_max_hw_sectors(nullb->q);
 	dev->max_sectors = min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
+	blk_queue_max_segment_size(nullb->q, dev->max_segment_size);
 
 	if (dev->virt_boundary)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..7bf80b0035f5 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -107,6 +107,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned int max_segment_size; /* Max size of a single DMA segment. */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
