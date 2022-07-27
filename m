Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D649C04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 14:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiG0OQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiG0OQ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 10:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DA3426D5
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658931415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HcG9SNM3+TqLH0UOCsc2d1Ouo2pxCELcWXthbCjGRKI=;
        b=NKdlGDFV98cIype860mGef0oCRgrMuHc6GDRpajtkTEaJZCvnlWGVhwIOEBqCxNozbqfzV
        hKxoCZcP9EFIYumyPQbJzcRCTo32iAHWGn0Cdtgj2B3uWExxud681VP6Gb1/n0SfGbG4it
        NWQjcpaaS6FcbcFTMhM3ov2W7cUY4z0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-_QMIejT9PuWcnAq3yITL9A-1; Wed, 27 Jul 2022 10:16:51 -0400
X-MC-Unique: _QMIejT9PuWcnAq3yITL9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64AEF85A586;
        Wed, 27 Jul 2022 14:16:51 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 803411415118;
        Wed, 27 Jul 2022 14:16:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/5] ublk_drv: add two parameter types
Date:   Wed, 27 Jul 2022 22:16:27 +0800
Message-Id: <20220727141628.985429-5-ming.lei@redhat.com>
In-Reply-To: <20220727141628.985429-1-ming.lei@redhat.com>
References: <20220727141628.985429-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each block devices have lots of queue setting, most of them needs
device's knowledge to configure correctly. Device parameter can be
thought as device's side knowledge since ublk does implement block
device from userspace.

Add ublk_basic_param & ublk_discard_param first, both two types are
used now.

Another change is that discard support becomes not enabled at default,
and it needs userspace to send ublk_discard_param for enabling it.

Also ublk_basic_param has to be set before sending START_DEV, otherwise
ublk block device won't be setup. Meantime not set dev_blocks from
handling START_DEV any more.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 197 ++++++++++++++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h |  37 +++++++
 2 files changed, 216 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 39bb2d943dc2..8188079ea185 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -129,6 +129,7 @@ struct ublk_device {
 
 #define UB_STATE_OPEN		(1 << 0)
 #define UB_STATE_USED		(1 << 1)
+#define UB_STATE_CONFIGURED	(1 << 2)
 	unsigned long		state;
 	int			ub_number;
 
@@ -151,6 +152,16 @@ struct ublk_device {
 	struct work_struct	stop_work;
 };
 
+typedef int (ublk_param_validate)(const struct ublk_device *,
+		const struct ublk_param_header *);
+typedef void (ublk_param_apply)(struct ublk_device *ub,
+		const struct ublk_param_header *);
+
+struct ublk_param_ops {
+	ublk_param_validate *validate_fn;
+	ublk_param_apply *apply_fn;
+};
+
 static dev_t ublk_chr_devt;
 static struct class *ublk_chr_class;
 
@@ -162,16 +173,166 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
+static int ublk_dev_param_basic_validate(const struct ublk_device *ub,
+		const struct ublk_param_header *header)
+{
+	const struct ublk_basic_param *p = (struct ublk_basic_param *)header;
+
+	if (p->logical_bs_shift > PAGE_SHIFT)
+		return -EINVAL;
+
+	if (p->logical_bs_shift > p->physical_bs_shift)
+		return -EINVAL;
+
+	if (p->max_sectors > (ub->dev_info.rq_max_blocks << (ub->bs_shift - 9)))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* basic param is the only one parameter which has to be set */
+static void ublk_dev_param_basic_apply(struct ublk_device *ub,
+		const struct ublk_param_header *header)
+{
+	struct request_queue *q = ub->ub_disk->queue;
+	const struct ublk_basic_param *p = (struct ublk_basic_param *)header;
+
+	blk_queue_logical_block_size(q, 1 << p->logical_bs_shift);
+	blk_queue_physical_block_size(q, 1 << p->physical_bs_shift);
+	blk_queue_io_min(q, 1 << p->io_min_shift);
+	blk_queue_io_opt(q, 1 << p->io_opt_shift);
+
+	blk_queue_write_cache(q, p->attrs & UBLK_ATTR_VOLATILE_CACHE,
+			p->attrs & UBLK_ATTR_FUA);
+	if (p->attrs & UBLK_ATTR_ROTATIONAL)
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+	else
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+
+	blk_queue_max_hw_sectors(q, p->max_sectors);
+	blk_queue_chunk_sectors(q, p->chunk_sectors);
+	blk_queue_virt_boundary(q, p->virt_boundary_mask);
+
+	if (p->attrs & UBLK_ATTR_READ_ONLY)
+		set_disk_ro(ub->ub_disk, true);
+
+	set_capacity(ub->ub_disk, p->dev_sectors);
+
+	set_bit(UB_STATE_CONFIGURED, &ub->state);
+}
+
+static int ublk_dev_param_discard_validate(const struct ublk_device *ub,
+		const struct ublk_param_header *header)
+{
+	const struct ublk_discard_param *p = (struct ublk_discard_param *)header;
+
+	/* So far, only support single segment discard */
+	if (p->max_discard_sectors && p->max_discard_segments != 1)
+		return -EINVAL;
+	return 0;
+}
+
+static void ublk_dev_param_discard_apply(struct ublk_device *ub,
+		const struct ublk_param_header *header)
+{
+	struct request_queue *q = ub->ub_disk->queue;
+	const struct ublk_discard_param *p = (struct ublk_discard_param *)
+		header;
+
+	q->limits.discard_alignment = p->discard_alignment;
+	q->limits.discard_granularity = p->discard_granularity;
+	blk_queue_max_discard_sectors(q, p->max_discard_sectors);
+	blk_queue_max_write_zeroes_sectors(q,
+			p->max_write_zeroes_sectors);
+	blk_queue_max_discard_segments(q, p->max_discard_segments);
+}
+
+static const unsigned int param_len[] = {
+	[UBLK_PARAM_TYPE_BASIC] = sizeof(struct ublk_basic_param),
+	[UBLK_PARAM_TYPE_DISCARD] = sizeof(struct ublk_discard_param),
+};
+
+static const struct ublk_param_ops param_ops[] = {
+	[UBLK_PARAM_TYPE_BASIC] = {
+		.validate_fn = ublk_dev_param_basic_validate,
+		.apply_fn = ublk_dev_param_basic_apply,
+	},
+	[UBLK_PARAM_TYPE_DISCARD] = {
+		.validate_fn = ublk_dev_param_discard_validate,
+		.apply_fn = ublk_dev_param_discard_apply,
+	},
+};
+
 static int ublk_validate_param_header(const struct ublk_device *ub,
 		const struct ublk_param_header *h)
 {
-	return -EINVAL;
+	if (h->type >= UBLK_PARAM_TYPE_LAST)
+		return -EINVAL;
+
+	if (h->len > UBLK_MAX_PARAM_LEN)
+		return -EINVAL;
+
+	if (h->len != param_len[h->type])
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ublk_validate_param(const struct ublk_device *ub,
+		const struct ublk_param_header *h)
+{
+	int ret = ublk_validate_param_header(ub, h);
+
+	if (ret)
+		return ret;
+
+	if (param_ops[h->type].validate_fn)
+		return param_ops[h->type].validate_fn(ub, h);
+
+	return 0;
 }
 
+/* Old parameter with same type will be overridden */
 static int ublk_install_param(struct ublk_device *ub,
 		struct ublk_param_header *h)
 {
-	return -EINVAL;
+	void *old;
+	int ret;
+
+	ret = ublk_validate_param(ub, h);
+	if (ret)
+		return ret;
+
+	old = xa_store(&ub->params, h->type, h, GFP_KERNEL);
+	if (xa_is_err(old))
+		return xa_err(old);
+	kfree(old);
+	return 0;
+}
+
+static void ublk_apply_param(struct ublk_device *ub,
+		const struct ublk_param_header *h)
+{
+	if (param_ops[h->type].apply_fn)
+		param_ops[h->type].apply_fn(ub, h);
+}
+
+static void ublk_apply_params(struct ublk_device *ub)
+{
+	struct ublk_param_header *h;
+	unsigned long type;
+
+	xa_for_each(&ub->params, type, h)
+		ublk_apply_param(ub, h);
+}
+
+static void ublk_uninstall_params(struct ublk_device *ub)
+{
+	unsigned long type;
+	void *p;
+
+	xa_for_each(&ub->params, type, p)
+		kfree(p);
 }
 
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
@@ -234,6 +395,7 @@ static void ublk_free_disk(struct gendisk *disk)
 		clear_bit(UB_STATE_USED, &ub->state);
 		put_device(&ub->cdev_dev);
 	}
+	clear_bit(UB_STATE_CONFIGURED, &ub->state);
 }
 
 static const struct block_device_operations ub_fops = {
@@ -1067,6 +1229,7 @@ static void ublk_cdev_rel(struct device *dev)
 
 	blk_mq_free_tag_set(&ub->tag_set);
 	ublk_deinit_queues(ub);
+	ublk_uninstall_params(ub);
 	ublk_free_dev_number(ub);
 	mutex_destroy(&ub->mutex);
 	xa_destroy(&ub->params);
@@ -1156,7 +1319,6 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	int ublksrv_pid = (int)header->data[0];
-	unsigned long dev_blocks = header->data[1];
 	struct ublk_device *ub;
 	struct gendisk *disk;
 	int ret = -EINVAL;
@@ -1179,10 +1341,6 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	}
 
-	/* We may get disk size updated */
-	if (dev_blocks)
-		ub->dev_info.dev_blocks = dev_blocks;
-
 	disk = blk_mq_alloc_disk(&ub->tag_set, ub);
 	if (IS_ERR(disk)) {
 		ret = PTR_ERR(disk);
@@ -1192,21 +1350,21 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	disk->fops = &ub_fops;
 	disk->private_data = ub;
 
-	blk_queue_logical_block_size(disk->queue, ub->dev_info.block_size);
-	blk_queue_physical_block_size(disk->queue, ub->dev_info.block_size);
-	blk_queue_io_min(disk->queue, ub->dev_info.block_size);
-	blk_queue_max_hw_sectors(disk->queue,
-		ub->dev_info.rq_max_blocks << (ub->bs_shift - 9));
-	disk->queue->limits.discard_granularity = PAGE_SIZE;
-	blk_queue_max_discard_sectors(disk->queue, UINT_MAX >> 9);
-	blk_queue_max_write_zeroes_sectors(disk->queue, UINT_MAX >> 9);
-
-	set_capacity(disk, ub->dev_info.dev_blocks << (ub->bs_shift - 9));
-
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	ub->ub_disk = disk;
+
+	ublk_apply_params(ub);
+
+	/* ublk_basic_param has to be set from userspace */
+	if (!test_bit(UB_STATE_CONFIGURED, &ub->state)) {
+		ret = -EINVAL;
+		put_disk(disk);
+		goto out_unlock;
+	}
+
 	ret = add_disk(disk);
 	if (ret) {
+		clear_bit(UB_STATE_CONFIGURED, &ub->state);
 		put_disk(disk);
 		goto out_unlock;
 	}
@@ -1610,6 +1768,9 @@ static int __init ublk_init(void)
 {
 	int ret;
 
+	BUILD_BUG_ON(sizeof(struct ublk_basic_param) > UBLK_MAX_PARAM_LEN);
+	BUILD_BUG_ON(sizeof(struct ublk_discard_param) > UBLK_MAX_PARAM_LEN);
+
 	init_waitqueue_head(&ublk_idr_wq);
 
 	ret = misc_register(&ublk_misc);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 1fb56d35ba8a..85b61c1f7e3d 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -168,4 +168,41 @@ struct ublk_param_header {
 	__u16 len;
 };
 
+enum {
+	UBLK_PARAM_TYPE_BASIC,
+	UBLK_PARAM_TYPE_DISCARD,
+	UBLK_PARAM_TYPE_LAST,
+};
+
+struct ublk_basic_param {
+	struct ublk_param_header  header;
+#define UBLK_ATTR_READ_ONLY            (1 << 0)
+#define UBLK_ATTR_ROTATIONAL           (1 << 1)
+#define UBLK_ATTR_VOLATILE_CACHE       (1 << 2)
+#define UBLK_ATTR_FUA                  (1 << 3)
+	__u32	attrs;
+	__u8	logical_bs_shift;
+	__u8	physical_bs_shift;
+	__u8	io_opt_shift;
+	__u8	io_min_shift;
+
+	__u32	max_sectors;
+	__u32	chunk_sectors;
+
+	__u64   dev_sectors;
+	__u64   virt_boundary_mask;
+};
+
+struct ublk_discard_param {
+	struct ublk_param_header  header;
+	__u32	discard_alignment;
+
+	__u32	discard_granularity;
+	__u32	max_discard_sectors;
+
+	__u32	max_write_zeroes_sectors;
+	__u16	max_discard_segments;
+	__u16	reserved0;
+};
+
 #endif
-- 
2.31.1

