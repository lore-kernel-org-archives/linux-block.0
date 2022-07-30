Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17DC04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 09:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiG3J3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiG3J3A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 05:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D001A422C5
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659173337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dADtkD+woAEBWzdoLS/YmaMGO6DXiQ7aczHaZNUx7ew=;
        b=KreCzMrM5Kf5qeI4N5DidkvPGDeAkwWai2PVIA9KuTS39mJW3mkGF9epy/hor/jrGAwNEF
        vnXMl40883d9J90VzbUSkAwA7EcvPhIwxZdB4nUiLae1T99Tr7vox4q9XgMqxYNMwHCFJr
        +i/nBkX4edlJlvf/G3VuYcn7uCghZQg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-fEbREhksOX2sT3dMLLKq3Q-1; Sat, 30 Jul 2022 05:28:46 -0400
X-MC-Unique: fEbREhksOX2sT3dMLLKq3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52382185A7A4;
        Sat, 30 Jul 2022 09:28:46 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C50C218EBB;
        Sat, 30 Jul 2022 09:28:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/4] ublk_drv: add SET_PARAMS/GET_PARAMS control command
Date:   Sat, 30 Jul 2022 17:27:49 +0800
Message-Id: <20220730092750.1118167-4-ming.lei@redhat.com>
In-Reply-To: <20220730092750.1118167-1-ming.lei@redhat.com>
References: <20220730092750.1118167-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add two commands to set/get parameters generically.

One important goal of ublk is to provide generic framework for making
block device by userspace flexibly.

As one generic block device, there are still lots of block parameters,
such as max_sectors, write_cache/fua, discard related limits,
zoned parameters, ...., so this patch starts to add generic mechanism
for set/get device parameters.

Both generic block parameters(all kinds of queue settings) and ublk
feature parameters can be covered with this way, then it becomes quite
easy to extend in future.

Add two parameter types are used so far: basic(covers basic queue setting
and misc settings which can't be grouped easily) and discard, basic type
must be set, and discard type becomes optional now

This way provides mechanism to simulate any kind of generic block device
from userspace easily, from both block queue setting viewpoint or ublk
feature viewpoint.

The style of putting all parameters together is suggested by Christoph.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 205 +++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h |  47 ++++++++
 2 files changed, 234 insertions(+), 18 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ae98e81b21ce..20ad83b25318 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -49,6 +49,9 @@
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_URING_CMD_COMP_IN_TASK)
 
+/* All UBLK_PARAM_TYPE_* should be included here */
+#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
+
 struct ublk_rq_data {
 	struct callback_head work;
 };
@@ -137,6 +140,8 @@ struct ublk_device {
 	spinlock_t		mm_lock;
 	struct mm_struct	*mm;
 
+	struct ublk_params	params;
+
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	atomic_t		nr_aborted_queues;
@@ -149,6 +154,12 @@ struct ublk_device {
 	struct work_struct	stop_work;
 };
 
+/* header of ublk_params */
+struct ublk_params_header {
+	__u32	len;
+	__u32	types;
+};
+
 static dev_t ublk_chr_devt;
 static struct class *ublk_chr_class;
 
@@ -160,6 +171,91 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
+static void ublk_dev_param_basic_apply(struct ublk_device *ub)
+{
+	struct request_queue *q = ub->ub_disk->queue;
+	const struct ublk_param_basic *p = &ub->params.basic;
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
+}
+
+static void ublk_dev_param_discard_apply(struct ublk_device *ub)
+{
+	struct request_queue *q = ub->ub_disk->queue;
+	const struct ublk_param_discard *p = &ub->params.discard;
+
+	q->limits.discard_alignment = p->discard_alignment;
+	q->limits.discard_granularity = p->discard_granularity;
+	blk_queue_max_discard_sectors(q, p->max_discard_sectors);
+	blk_queue_max_write_zeroes_sectors(q,
+			p->max_write_zeroes_sectors);
+	blk_queue_max_discard_segments(q, p->max_discard_segments);
+}
+
+static int ublk_validate_params(const struct ublk_device *ub)
+{
+	/* basic param is the only one which must be set */
+	if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
+		const struct ublk_param_basic *p = &ub->params.basic;
+
+		if (p->logical_bs_shift > PAGE_SHIFT)
+			return -EINVAL;
+
+		if (p->logical_bs_shift > p->physical_bs_shift)
+			return -EINVAL;
+
+		if (p->max_sectors > (ub->dev_info.rq_max_blocks <<
+					(ub->bs_shift - 9)))
+			return -EINVAL;
+	} else
+		return -EINVAL;
+
+	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD) {
+		const struct ublk_param_discard *p = &ub->params.discard;
+
+		/* So far, only support single segment discard */
+		if (p->max_discard_sectors && p->max_discard_segments != 1)
+			return -EINVAL;
+
+		if (!p->discard_granularity)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ublk_apply_params(struct ublk_device *ub)
+{
+	if (!(ub->params.types & UBLK_PARAM_TYPE_BASIC))
+		return -EINVAL;
+
+	ublk_dev_param_basic_apply(ub);
+
+	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
+		ublk_dev_param_discard_apply(ub);
+
+	return 0;
+}
+
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 {
 	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
@@ -1138,7 +1234,6 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	int ublksrv_pid = (int)header->data[0];
-	unsigned long dev_blocks = header->data[1];
 	struct ublk_device *ub;
 	struct gendisk *disk;
 	int ret = -EINVAL;
@@ -1161,10 +1256,6 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	}
 
-	/* We may get disk size updated */
-	if (dev_blocks)
-		ub->dev_info.dev_blocks = dev_blocks;
-
 	disk = blk_mq_alloc_disk(&ub->tag_set, ub);
 	if (IS_ERR(disk)) {
 		ret = PTR_ERR(disk);
@@ -1174,19 +1265,13 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
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
+	ret = ublk_apply_params(ub);
+	if (ret)
+		goto out_put_disk;
+
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
@@ -1195,11 +1280,13 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 		 * called in case of add_disk failure.
 		 */
 		ublk_put_device(ub);
-		put_disk(disk);
-		goto out_unlock;
+		goto out_put_disk;
 	}
 	set_bit(UB_STATE_USED, &ub->state);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
+out_put_disk:
+	if (ret)
+		put_disk(disk);
 out_unlock:
 	mutex_unlock(&ub->mutex);
 	ublk_put_device(ub);
@@ -1447,6 +1534,82 @@ static int ublk_ctrl_get_dev_info(struct io_uring_cmd *cmd)
 	return ret;
 }
 
+static int ublk_ctrl_get_params(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublk_params_header ph;
+	struct ublk_device *ub;
+	int ret;
+
+	if (header->len <= sizeof(ph) || !header->addr)
+		return -EINVAL;
+
+	if (copy_from_user(&ph, argp, sizeof(ph)))
+		return -EFAULT;
+
+	if (ph.len > header->len || !ph.len)
+		return -EINVAL;
+
+	if (ph.len > sizeof(struct ublk_params))
+		ph.len = sizeof(struct ublk_params);
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return -EINVAL;
+
+	mutex_lock(&ub->mutex);
+	if (copy_to_user(argp, &ub->params, ph.len))
+		ret = -EFAULT;
+	else
+		ret = 0;
+	mutex_unlock(&ub->mutex);
+
+	ublk_put_device(ub);
+	return ret;
+}
+
+static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublk_params_header ph;
+	struct ublk_device *ub;
+	int ret = -EFAULT;
+
+	if (header->len <= sizeof(ph) || !header->addr)
+		return -EINVAL;
+
+	if (copy_from_user(&ph, argp, sizeof(ph)))
+		return -EFAULT;
+
+	if (ph.len > header->len || !ph.len || !ph.types)
+		return -EINVAL;
+
+	if (ph.len > sizeof(struct ublk_params))
+		ph.len = sizeof(struct ublk_params);
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return -EINVAL;
+
+	/* parameters can only be changed when device isn't live */
+	mutex_lock(&ub->mutex);
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+		ret = -EACCES;
+	} else if (copy_from_user(&ub->params, argp, ph.len)) {
+		ret = -EFAULT;
+	} else {
+		/* clear all we don't support yet */
+		ub->params.types &= UBLK_PARAM_TYPE_ALL;
+		ret = ublk_validate_params(ub);
+	}
+	mutex_unlock(&ub->mutex);
+	ublk_put_device(ub);
+
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -1482,6 +1645,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 		ret = ublk_ctrl_get_queue_affinity(cmd);
 		break;
+	case UBLK_CMD_GET_PARAMS:
+		ret = ublk_ctrl_get_params(cmd);
+		break;
+	case UBLK_CMD_SET_PARAMS:
+		ret = ublk_ctrl_set_params(cmd);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ca33092354ab..54d065426f06 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -15,6 +15,8 @@
 #define	UBLK_CMD_DEL_DEV		0x05
 #define	UBLK_CMD_START_DEV	0x06
 #define	UBLK_CMD_STOP_DEV	0x07
+#define	UBLK_CMD_SET_PARAMS	0x08
+#define	UBLK_CMD_GET_PARAMS	0x09
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
@@ -158,4 +160,49 @@ struct ublksrv_io_cmd {
 	__u64	addr;
 };
 
+struct ublk_param_basic {
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
+struct ublk_param_discard {
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
+struct ublk_params {
+	/*
+	 * Total length of parameters, userspace has to set 'len' for both
+	 * SET_PARAMS and GET_PARAMS command, and driver may update len
+	 * if two sides use different version of 'ublk_params', same with
+	 * 'types' fields.
+	 */
+	__u32	len;
+#define UBLK_PARAM_TYPE_BASIC           (1 << 0)
+#define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
+	__u32	types;			/* types of parameter included */
+
+	struct ublk_param_basic		basic;
+	struct ublk_param_discard	discard;
+};
+
 #endif
-- 
2.31.1

