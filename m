Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9908C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 15:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGWPHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbiGWPHf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 11:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 851BA1AD89
        for <linux-block@vger.kernel.org>; Sat, 23 Jul 2022 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658588853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYBYBoH2KecpFFxt15KG7Zm3gdBLx73bIdGe5saBHaE=;
        b=e3VBv3aT6Qm03B4CyWMSlHvd2DYdgK6gDVW5+zSaWzJMADZ7Ezufv5zDjXQ7paxoFHBsq+
        UhnN4Zbc0F5+Gmgv4rakw6bT1QY9FzVqsRCfnUiD/lcC4k6onNhaR1uBq241V2U8yMrMtB
        mERWuD5HKtXPZsYEP/Q13vCNrDTpOsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-t022k4ZgMLKc5-vOVQq7eA-1; Sat, 23 Jul 2022 11:07:29 -0400
X-MC-Unique: t022k4ZgMLKc5-vOVQq7eA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B985801755;
        Sat, 23 Jul 2022 15:07:29 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF62B1415124;
        Sat, 23 Jul 2022 15:07:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] ublk_drv: store device parameters
Date:   Sat, 23 Jul 2022 23:07:12 +0800
Message-Id: <20220723150713.750369-2-ming.lei@redhat.com>
In-Reply-To: <20220723150713.750369-1-ming.lei@redhat.com>
References: <20220723150713.750369-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One important goal of ublk is to provide generic framework for
making one block device by userspace.

As one generic block device, there are still lots of parameters,
such as max_sectors, write_cache/fua, discard related limits,
zoned parameters, ...., so this patch starts to store & retrieve
device parameters and prepares for implementing ctrl command of
SET/GET_DEV_PARAMETERS.

Device parameters have to be stored somewhere, one reason is that
disk/queue won't be allocated until START_DEV command is received,
but device parameters have to setup before starting device.

Add two default parameter group for covering default disk setting,
more parameter groups can be added in future, but all should be optional.
Parameter groups will become part of ABI since new commands will be
added to set/get parameters in following patch. Most of parameter
groups should be optional, so store them in xarray.

Not only block device related parameter, feature related parameters can
be set/get with this generic framework too, then ublk can be extended
easily with help of dev_info->flags.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 262 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  43 ++++++
 2 files changed, 293 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 255b2de46a24..e185bdb165de 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -137,6 +137,8 @@ struct ublk_device {
 	spinlock_t		mm_lock;
 	struct mm_struct	*mm;
 
+	struct xarray		paras;
+
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	atomic_t		nr_aborted_queues;
@@ -149,6 +151,16 @@ struct ublk_device {
 	struct work_struct	stop_work;
 };
 
+typedef int (ublk_para_validate)(const struct ublk_device *,
+		const struct ublk_para_header *);
+typedef void (ublk_para_apply)(struct ublk_device *ub,
+		const struct ublk_para_header *);
+
+struct ublk_para_ops {
+	ublk_para_validate *validate_fn;
+	ublk_para_apply *apply_fn;
+};
+
 static dev_t ublk_chr_devt;
 static struct class *ublk_chr_class;
 
@@ -160,6 +172,231 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
+static int ublk_dev_para_basic_validate(const struct ublk_device *ub,
+		const struct ublk_para_header *header)
+{
+	const struct ublk_basic_para *p = (struct ublk_basic_para *)header;
+
+	if (p->logical_bs_shift > PAGE_SHIFT)
+		return -EINVAL;
+
+	if (p->logical_bs_shift > p->physical_bs_shift)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void ublk_dev_para_basic_apply(struct ublk_device *ub,
+		const struct ublk_para_header *header)
+{
+	struct request_queue *q = ub->ub_disk->queue;
+	const struct ublk_basic_para *p = (struct ublk_basic_para *)header;
+
+	blk_queue_logical_block_size(q, 1 << p->logical_bs_shift);
+	blk_queue_physical_block_size(q, 1 << p->physical_bs_shift);
+	blk_queue_io_min(q, 1 << p->io_min_shift);
+	blk_queue_io_opt(q, 1 << p->io_opt_shift);
+
+	blk_queue_write_cache(q, p->write_back_cache, p->fua);
+	if (!p->rotational)
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+
+	blk_queue_max_hw_sectors(q, p->max_sectors);
+	blk_queue_chunk_sectors(q, p->chunk_sectors);
+	blk_queue_virt_boundary(q, p->virt_boundary_mask);
+
+	if (p->read_only)
+		set_disk_ro(ub->ub_disk, true);
+
+	set_capacity(ub->ub_disk, p->dev_sectors);
+}
+
+static int ublk_dev_para_discard_validate(const struct ublk_device *ub,
+		const struct ublk_para_header *header)
+{
+	const struct ublk_discard_para *p = (struct ublk_discard_para *)header;
+
+	/* So far, only support single segment discard */
+	if (p->max_discard_sectors && p->max_discard_segments != 1)
+		return -EINVAL;
+	return 0;
+}
+
+static void ublk_dev_para_discard_apply(struct ublk_device *ub,
+		const struct ublk_para_header *header)
+{
+	struct request_queue *q = ub->ub_disk->queue;
+	const struct ublk_discard_para *p = (struct ublk_discard_para *)
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
+static const unsigned int para_len[] = {
+	[UBLK_PARA_TYPE_BASIC] = sizeof(struct ublk_basic_para),
+	[UBLK_PARA_TYPE_DISCARD] = sizeof(struct ublk_discard_para),
+};
+
+static const struct ublk_para_ops para_ops[] = {
+	[UBLK_PARA_TYPE_BASIC] = {
+		.validate_fn = ublk_dev_para_basic_validate,
+		.apply_fn = ublk_dev_para_basic_apply,
+	},
+	[UBLK_PARA_TYPE_DISCARD] = {
+		.validate_fn = ublk_dev_para_discard_validate,
+		.apply_fn = ublk_dev_para_discard_apply,
+	},
+};
+
+static void ublk_update_dev_sectors(struct ublk_device *ub,
+		sector_t sectors)
+{
+	struct ublk_basic_para  *p = xa_load(&ub->paras,
+			UBLK_PARA_TYPE_BASIC);
+
+	if (p)
+		p->dev_sectors = (__u64)sectors;
+}
+
+static struct ublk_para_header *ublk_alloc_def_basic_para(
+		struct ublk_device *ub)
+{
+	struct ublk_basic_para  *p = kzalloc(sizeof(*p), GFP_KERNEL);
+	struct ublksrv_ctrl_dev_info *info = &ub->dev_info;
+
+	if (!p)
+		return NULL;
+
+	p->header.type = UBLK_PARA_TYPE_BASIC;
+	p->header.len = sizeof(*p);
+	p->logical_bs_shift = ilog2(info->block_size);
+	p->physical_bs_shift = ilog2(info->block_size);
+	p->io_opt_shift = ilog2(info->block_size);
+	p->io_min_shift = ilog2(info->block_size);
+	p->rotational = 0;
+	p->write_back_cache = 0;
+	p->fua = 0;
+	p->read_only = 0;
+
+	p->max_sectors = info->rq_max_blocks << (ub->bs_shift - 9);
+	p->chunk_sectors = 0;
+	p->virt_boundary_mask = 0;
+	p->dev_sectors = info->dev_blocks << (ub->bs_shift - 9);
+
+	return (struct ublk_para_header *)p;
+}
+
+static struct ublk_para_header *ublk_alloc_def_discard_para(
+		struct ublk_device *ub)
+{
+	struct ublk_discard_para  *p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+	if (!p)
+		return NULL;
+
+	p->header.type = UBLK_PARA_TYPE_DISCARD;
+	p->header.len = sizeof(*p);
+
+	p->discard_alignment =	0;
+	p->discard_granularity = PAGE_SIZE;
+	p->max_discard_sectors = UINT_MAX >> 9;
+	p->max_write_zeroes_sectors = UINT_MAX >> 9;
+	p->max_discard_segments = 1;
+
+	return (struct ublk_para_header *)p;
+}
+
+static int ublk_validate_para_header(const struct ublk_device *ub,
+		const struct ublk_para_header *h)
+{
+	if (h->type >= UBLK_PARA_TYPE_LAST)
+		return -EINVAL;
+
+	if (h->len != para_len[h->type])
+		return -EINVAL;
+
+	return 0;
+}
+
+
+static int ublk_validate_para(const struct ublk_device *ub,
+		const struct ublk_para_header *h)
+{
+	int ret = ublk_validate_para_header(ub, h);
+
+	if (ret)
+		return ret;
+
+	if (para_ops[h->type].validate_fn)
+		return para_ops[h->type].validate_fn(ub, h);
+
+	return 0;
+}
+
+/* Old parameter with same type will be overridden */
+static int ublk_install_para(struct ublk_device *ub,
+		struct ublk_para_header *h)
+{
+	void *old;
+	int ret;
+
+	ret = ublk_validate_para(ub, h);
+	if (ret)
+		return ret;
+
+	old = xa_store(&ub->paras, h->type, h, GFP_KERNEL);
+	if (xa_is_err(old))
+		return xa_err(old);
+	kfree(old);
+	return 0;
+}
+
+static void ublk_apply_para(struct ublk_device *ub,
+		const struct ublk_para_header *h)
+{
+	if (para_ops[h->type].apply_fn)
+		para_ops[h->type].apply_fn(ub, h);
+}
+
+/* default parameters are allocated/installed before disk is allocated */
+static void ublk_install_def_paras(struct ublk_device *ub)
+{
+	struct ublk_para_header *h;
+
+	h = ublk_alloc_def_basic_para(ub);
+	if (h && ublk_install_para(ub, h))
+		kfree(h);
+
+	h = ublk_alloc_def_discard_para(ub);
+	if (h && ublk_install_para(ub, h))
+		kfree(h);
+}
+
+static void ublk_apply_paras(struct ublk_device *ub)
+{
+	struct ublk_para_header *h;
+	unsigned long type;
+
+	xa_for_each(&ub->paras, type, h)
+		ublk_apply_para(ub, h);
+}
+
+static void ublk_uninstall_paras(struct ublk_device *ub)
+{
+	unsigned long type;
+	void *p;
+
+	xa_for_each(&ub->paras, type, p)
+		kfree(p);
+}
+
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 {
 	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
@@ -1044,8 +1281,10 @@ static void ublk_cdev_rel(struct device *dev)
 
 	blk_mq_free_tag_set(&ub->tag_set);
 	ublk_deinit_queues(ub);
+	ublk_uninstall_paras(ub);
 	ublk_free_dev_number(ub);
 	mutex_destroy(&ub->mutex);
+	xa_destroy(&ub->paras);
 	kfree(ub);
 }
 
@@ -1156,8 +1395,11 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	}
 
 	/* We may get disk size updated */
-	if (dev_blocks)
+	if (dev_blocks) {
 		ub->dev_info.dev_blocks = dev_blocks;
+		ublk_update_dev_sectors(ub,
+				dev_blocks << (ub->bs_shift - 9));
+	}
 
 	disk = blk_mq_alloc_disk(&ub->tag_set, ub);
 	if (IS_ERR(disk)) {
@@ -1168,19 +1410,11 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
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
+	ublk_apply_paras(ub);
+
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
@@ -1291,6 +1525,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	spin_lock_init(&ub->mm_lock);
 	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
 	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
+	xa_init(&ub->paras);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -1334,6 +1569,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	 * ublk_add_chdev() will cleanup everything if it fails.
 	 */
 	ret = ublk_add_chdev(ub);
+	if (!ret)
+		ublk_install_def_paras(ub);
+
 	goto out_unlock;
 
 out_free_tag_set:
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ca33092354ab..99f81a1e9a95 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -158,4 +158,47 @@ struct ublksrv_io_cmd {
 	__u64	addr;
 };
 
+/* ublk device parameter definition */
+enum {
+	UBLK_PARA_TYPE_BASIC,
+	UBLK_PARA_TYPE_DISCARD,
+	UBLK_PARA_TYPE_LAST,
+};
+
+struct ublk_para_header {
+	__u16 type;
+	__u16 len;
+} __attribute__ ((__packed__));
+
+struct ublk_basic_para {
+	struct ublk_para_header  header;
+	__u32   logical_bs_shift:6;
+	__u32   physical_bs_shift:6;
+	__u32	io_opt_shift:6;
+	__u32	io_min_shift:6;
+	__u32	rotational:1;
+	__u32	write_back_cache:1;
+	__u32	fua:1;
+	__u32	read_only:1;
+	__u32	unused:4;
+
+	__u32	max_sectors;
+	__u32	chunk_sectors;
+
+	__u64   dev_sectors;
+	__u64   virt_boundary_mask;
+};
+
+struct ublk_discard_para {
+	struct ublk_para_header  header;
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

