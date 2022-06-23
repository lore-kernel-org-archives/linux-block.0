Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E7BC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 06:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiFWGWK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiFWGV6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 02:21:58 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24863BBC8
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 23:21:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655965314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3rFNVmRJ8onah0S4DT7TceMrsAcA4fzPzLKz1cfw5I=;
        b=Pk0xouu9Cdth5qUXdMQ29UvgW+GvhV8+JBAgpMQnq/p3q+yHBWoGzHjTcJezzCc1i1Llv2
        aV/rviG2IbiRbhsTEhhGOnNKM0SqSc+aOmQUZ2eS7NVmEjir5KnWWkl/DI8KYuDPnEKrDP
        I5XNgdrpGWbxF8zXcxJo4r/yPMId334=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V1 4/8] rnbd-clt: reduce the size of struct rnbd_clt_dev
Date:   Thu, 23 Jun 2022 14:21:12 +0800
Message-Id: <20220623062116.15976-5-guoqing.jiang@linux.dev>
In-Reply-To: <20220623062116.15976-1-guoqing.jiang@linux.dev>
References: <20220623062116.15976-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previously, both map and remap trigger rnbd_clt_set_dev_attr to set
some members in rnbd_clt_dev such as wc, fua and logical_block_size
etc, but those members are only useful for map scenario given the
setup_request_queue is only called from the path:

rnbd_clt_map_device -> rnbd_client_setup_device

Since rnbd_clt_map_device frees rsp after rnbd_client_setup_device,
we can pass rsp to rnbd_client_setup_device and it's callees, which
means queue's attributes can be set directly from relevant members
of rsp instead from rnbd_clt_dev.

After that, we can kill 11 members from rnbd_clt_dev, and we don't
need rnbd_clt_set_dev_attr either.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 118 ++++++++++++++++------------------
 drivers/block/rnbd/rnbd-clt.h |  11 ----
 2 files changed, 55 insertions(+), 74 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 0e93e529dd82..da2ba9477b1e 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -68,38 +68,12 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_dev *dev)
 	return refcount_inc_not_zero(&dev->refcount);
 }
 
-static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
-				 const struct rnbd_msg_open_rsp *rsp)
-{
-	struct rnbd_clt_session *sess = dev->sess;
-
-	if (!rsp->logical_block_size)
-		return -EINVAL;
-
-	dev->device_id		    = le32_to_cpu(rsp->device_id);
-	dev->nsectors		    = le64_to_cpu(rsp->nsectors);
-	dev->logical_block_size	    = le16_to_cpu(rsp->logical_block_size);
-	dev->physical_block_size    = le16_to_cpu(rsp->physical_block_size);
-	dev->max_discard_sectors    = le32_to_cpu(rsp->max_discard_sectors);
-	dev->discard_granularity    = le32_to_cpu(rsp->discard_granularity);
-	dev->discard_alignment	    = le32_to_cpu(rsp->discard_alignment);
-	dev->secure_discard	    = le16_to_cpu(rsp->secure_discard);
-	dev->wc			    = !!(rsp->cache_policy & RNBD_WRITEBACK);
-	dev->fua		    = !!(rsp->cache_policy & RNBD_FUA);
-
-	dev->max_hw_sectors = sess->max_io_size / SECTOR_SIZE;
-	dev->max_segments = sess->max_segments;
-
-	return 0;
-}
-
 static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
 				    size_t new_nsectors)
 {
-	rnbd_clt_info(dev, "Device size changed from %zu to %zu sectors\n",
-		       dev->nsectors, new_nsectors);
-	dev->nsectors = new_nsectors;
-	set_capacity_and_notify(dev->gd, dev->nsectors);
+	rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\n",
+		      get_capacity(dev->gd), new_nsectors);
+	set_capacity_and_notify(dev->gd, new_nsectors);
 	return 0;
 }
 
@@ -123,15 +97,17 @@ static int process_msg_open_rsp(struct rnbd_clt_dev *dev,
 		 * If the device was remapped and the size changed in the
 		 * meantime we need to revalidate it
 		 */
-		if (dev->nsectors != nsectors)
+		if (get_capacity(dev->gd) != nsectors)
 			rnbd_clt_change_capacity(dev, nsectors);
 		gd_kobj = &disk_to_dev(dev->gd)->kobj;
 		kobject_uevent(gd_kobj, KOBJ_ONLINE);
 		rnbd_clt_info(dev, "Device online, device remapped successfully\n");
 	}
-	err = rnbd_clt_set_dev_attr(dev, rsp);
-	if (err)
+	if (!rsp->logical_block_size) {
+		err = -EINVAL;
 		goto out;
+	}
+	dev->device_id = le32_to_cpu(rsp->device_id);
 	dev->dev_state = DEV_STATE_MAPPED;
 
 out:
@@ -970,10 +946,10 @@ static int rnbd_client_getgeo(struct block_device *block_device,
 			      struct hd_geometry *geo)
 {
 	u64 size;
-	struct rnbd_clt_dev *dev;
+	struct rnbd_clt_dev *dev = block_device->bd_disk->private_data;
+	struct queue_limits *limit = &dev->queue->limits;
 
-	dev = block_device->bd_disk->private_data;
-	size = dev->size * (dev->logical_block_size / SECTOR_SIZE);
+	size = dev->size * (limit->logical_block_size / SECTOR_SIZE);
 	geo->cylinders	= size >> 6;	/* size/64 */
 	geo->heads	= 4;
 	geo->sectors	= 16;
@@ -1357,11 +1333,15 @@ static void rnbd_init_mq_hw_queues(struct rnbd_clt_dev *dev)
 	}
 }
 
-static void setup_request_queue(struct rnbd_clt_dev *dev)
+static void setup_request_queue(struct rnbd_clt_dev *dev,
+				struct rnbd_msg_open_rsp *rsp)
 {
-	blk_queue_logical_block_size(dev->queue, dev->logical_block_size);
-	blk_queue_physical_block_size(dev->queue, dev->physical_block_size);
-	blk_queue_max_hw_sectors(dev->queue, dev->max_hw_sectors);
+	blk_queue_logical_block_size(dev->queue,
+				     le16_to_cpu(rsp->logical_block_size));
+	blk_queue_physical_block_size(dev->queue,
+				      le16_to_cpu(rsp->physical_block_size));
+	blk_queue_max_hw_sectors(dev->queue,
+				 dev->sess->max_io_size / SECTOR_SIZE);
 
 	/*
 	 * we don't support discards to "discontiguous" segments
@@ -1369,21 +1349,27 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
 	 */
 	blk_queue_max_discard_segments(dev->queue, 1);
 
-	blk_queue_max_discard_sectors(dev->queue, dev->max_discard_sectors);
-	dev->queue->limits.discard_granularity	= dev->discard_granularity;
-	dev->queue->limits.discard_alignment	= dev->discard_alignment;
-	if (dev->secure_discard)
+	blk_queue_max_discard_sectors(dev->queue,
+				      le32_to_cpu(rsp->max_discard_sectors));
+	dev->queue->limits.discard_granularity =
+					le32_to_cpu(rsp->discard_granularity);
+	dev->queue->limits.discard_alignment =
+					le32_to_cpu(rsp->discard_alignment);
+	if (le16_to_cpu(rsp->secure_discard))
 		blk_queue_max_secure_erase_sectors(dev->queue,
-				dev->max_discard_sectors);
+					le32_to_cpu(rsp->max_discard_sectors));
 	blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
 	blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
-	blk_queue_max_segments(dev->queue, dev->max_segments);
+	blk_queue_max_segments(dev->queue, dev->sess->max_segments);
 	blk_queue_io_opt(dev->queue, dev->sess->max_io_size);
 	blk_queue_virt_boundary(dev->queue, SZ_4K - 1);
-	blk_queue_write_cache(dev->queue, dev->wc, dev->fua);
+	blk_queue_write_cache(dev->queue,
+			      !!(rsp->cache_policy & RNBD_WRITEBACK),
+			      !!(rsp->cache_policy & RNBD_FUA));
 }
 
-static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
+static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev,
+				   struct rnbd_msg_open_rsp *rsp, int idx)
 {
 	int err;
 
@@ -1395,12 +1381,12 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 	dev->gd->private_data	= dev;
 	snprintf(dev->gd->disk_name, sizeof(dev->gd->disk_name), "rnbd%d",
 		 idx);
-	pr_debug("disk_name=%s, capacity=%zu\n",
+	pr_debug("disk_name=%s, capacity=%llu\n",
 		 dev->gd->disk_name,
-		 dev->nsectors * (dev->logical_block_size / SECTOR_SIZE)
-		 );
+		 le64_to_cpu(rsp->nsectors) *
+		 (le16_to_cpu(rsp->logical_block_size) / SECTOR_SIZE));
 
-	set_capacity(dev->gd, dev->nsectors);
+	set_capacity(dev->gd, le64_to_cpu(rsp->nsectors));
 
 	if (dev->access_mode == RNBD_ACCESS_RO)
 		set_disk_ro(dev->gd, true);
@@ -1416,11 +1402,13 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 	return err;
 }
 
-static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
+static int rnbd_client_setup_device(struct rnbd_clt_dev *dev,
+				    struct rnbd_msg_open_rsp *rsp)
 {
 	int idx = dev->clt_device_id;
 
-	dev->size = dev->nsectors * dev->logical_block_size;
+	dev->size = le64_to_cpu(rsp->nsectors) *
+			le16_to_cpu(rsp->logical_block_size);
 
 	dev->gd = blk_mq_alloc_disk(&dev->sess->tag_set, dev);
 	if (IS_ERR(dev->gd))
@@ -1428,8 +1416,8 @@ static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
 	dev->queue = dev->gd->queue;
 	rnbd_init_mq_hw_queues(dev);
 
-	setup_request_queue(dev);
-	return rnbd_clt_setup_gen_disk(dev, idx);
+	setup_request_queue(dev, rsp);
+	return rnbd_clt_setup_gen_disk(dev, rsp, idx);
 }
 
 static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
@@ -1632,7 +1620,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	mutex_lock(&dev->lock);
 	pr_debug("Opened remote device: session=%s, path='%s'\n",
 		 sess->sessname, pathname);
-	ret = rnbd_client_setup_device(dev);
+	ret = rnbd_client_setup_device(dev, rsp);
 	if (ret) {
 		rnbd_clt_err(dev,
 			      "map_device: Failed to configure device, err: %d\n",
@@ -1642,13 +1630,17 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	}
 
 	rnbd_clt_info(dev,
-		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
-		       dev->gd->disk_name, dev->nsectors,
-		       dev->logical_block_size, dev->physical_block_size,
-		       dev->max_discard_sectors,
-		       dev->discard_granularity, dev->discard_alignment,
-		       dev->secure_discard, dev->max_segments,
-		       dev->max_hw_sectors, dev->wc, dev->fua);
+		       "map_device: Device mapped as %s (nsectors: %llu, logical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
+		       dev->gd->disk_name, le64_to_cpu(rsp->nsectors),
+		       le16_to_cpu(rsp->logical_block_size),
+		       le16_to_cpu(rsp->physical_block_size),
+		       le32_to_cpu(rsp->max_discard_sectors),
+		       le32_to_cpu(rsp->discard_granularity),
+		       le32_to_cpu(rsp->discard_alignment),
+		       le16_to_cpu(rsp->secure_discard),
+		       sess->max_segments, sess->max_io_size / SECTOR_SIZE,
+		       !!(rsp->cache_policy & RNBD_WRITEBACK),
+		       !!(rsp->cache_policy & RNBD_FUA));
 
 	mutex_unlock(&dev->lock);
 	kfree(rsp);
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 26fb91d800e3..7520272541b1 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -117,17 +117,6 @@ struct rnbd_clt_dev {
 	char			*pathname;
 	enum rnbd_access_mode	access_mode;
 	u32			nr_poll_queues;
-	bool			wc;
-	bool			fua;
-	u32			max_hw_sectors;
-	u32			max_discard_sectors;
-	u32			discard_granularity;
-	u32			discard_alignment;
-	u16			secure_discard;
-	u16			physical_block_size;
-	u16			logical_block_size;
-	u16			max_segments;
-	size_t			nsectors;
 	u64			size;		/* device size in bytes */
 	struct list_head        list;
 	struct gendisk		*gd;
-- 
2.34.1

