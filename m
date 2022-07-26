Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585CCCA48B
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 12:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiGZMcb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiGZMcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 08:32:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3D24BE6
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 05:32:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E27168AA6; Tue, 26 Jul 2022 14:32:24 +0200 (CEST)
Date:   Tue, 26 Jul 2022 14:32:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] ublk_drv: store device parameters
Message-ID: <20220726123224.GA9435@lst.de>
References: <20220723150713.750369-1-ming.lei@redhat.com> <20220723150713.750369-2-ming.lei@redhat.com> <20220725064259.GA20796@lst.de> <Yt5BCtLi70Pits34@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt5BCtLi70Pits34@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 25, 2022 at 03:06:50PM +0800, Ming Lei wrote:
> There could be more parameters than the two types(), such as segments,
> zoned, ..., also in future, feature related parameters can be added
> in this way too, and most of them are optional.

Yes.  But just having a struct that grows is much cleaner and simpler
than those indirections.  e.g something like this patch on top of this
series.  With this new fields can just be added to the end of
struct ublk_params.  Old kernels will ignore them, but due to the copy
back of the parsed structure userspace can detect that if it cares:

 drivers/block/ublk_drv.c      |  320 +++++++++++++++------------------------------------------------------------------
 include/uapi/linux/ublk_cmd.h |   67 ++++++----------
 2 files changed, 85 insertions(+), 302 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 83fd65d8a2051..f9db59af12752 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -137,7 +137,7 @@ struct ublk_device {
 	spinlock_t		mm_lock;
 	struct mm_struct	*mm;
 
-	struct xarray		paras;
+	struct ublk_params	params;
 
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
@@ -151,16 +151,6 @@ struct ublk_device {
 	struct work_struct	stop_work;
 };
 
-typedef int (ublk_para_validate)(const struct ublk_device *,
-		const struct ublk_para_header *);
-typedef void (ublk_para_apply)(struct ublk_device *ub,
-		const struct ublk_para_header *);
-
-struct ublk_para_ops {
-	ublk_para_validate *validate_fn;
-	ublk_para_apply *apply_fn;
-};
-
 static dev_t ublk_chr_devt;
 static struct class *ublk_chr_class;
 
@@ -172,231 +162,69 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
-static int ublk_dev_para_basic_validate(const struct ublk_device *ub,
-		const struct ublk_para_header *header)
+static void ublk_init_default_params(struct ublk_device *ub)
 {
-	const struct ublk_basic_para *p = (struct ublk_basic_para *)header;
+	struct ublk_params *p = &ub->params;
+	struct ublksrv_ctrl_dev_info *info = &ub->dev_info;
 
-	if (p->logical_bs_shift > PAGE_SHIFT)
-		return -EINVAL;
+	p->logical_bs_shift = ilog2(info->block_size);
+	p->physical_bs_shift = ilog2(info->block_size);
+	p->io_opt_shift = ilog2(info->block_size);
+	p->io_min_shift = ilog2(info->block_size);
 
-	if (p->logical_bs_shift > p->physical_bs_shift)
-		return -EINVAL;
+	p->max_sectors = info->rq_max_blocks << (ub->bs_shift - 9);
+	p->dev_sectors = info->dev_blocks << (ub->bs_shift - 9);
 
-	return 0;
+	p->discard_granularity = PAGE_SIZE;
+	p->max_discard_sectors = UINT_MAX >> 9;
+	p->max_write_zeroes_sectors = UINT_MAX >> 9;
+	p->max_discard_segments = 1;
 }
 
-static void ublk_dev_para_basic_apply(struct ublk_device *ub,
-		const struct ublk_para_header *header)
+static int ublk_params_apply(const struct ublk_device *ub,
+		struct ublk_params *p)
 {
 	struct request_queue *q = ub->ub_disk->queue;
-	const struct ublk_basic_para *p = (struct ublk_basic_para *)header;
+
+	if (p->logical_bs_shift > PAGE_SHIFT)
+		return -EINVAL;
+	if (p->logical_bs_shift > p->physical_bs_shift)
+		return -EINVAL;
+
+	/* For now only single segment discards are supported */
+	if (p->max_discard_sectors && p->max_discard_segments != 1)
+		return -EINVAL;
 
 	blk_queue_logical_block_size(q, 1 << p->logical_bs_shift);
 	blk_queue_physical_block_size(q, 1 << p->physical_bs_shift);
 	blk_queue_io_min(q, 1 << p->io_min_shift);
 	blk_queue_io_opt(q, 1 << p->io_opt_shift);
 
-	blk_queue_write_cache(q, p->write_back_cache, p->fua);
-	if (!p->rotational)
-		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
-	else
+	blk_queue_write_cache(q, p->attrs & UBLK_ATTR_VOLATILE_CACHE,
+			p->attrs & UBLK_ATTR_FUA);
+	if (p->attrs & UBLK_ATTR_ROTATIONAL)
 		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+	else
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 
 	blk_queue_max_hw_sectors(q, p->max_sectors);
 	blk_queue_chunk_sectors(q, p->chunk_sectors);
 	blk_queue_virt_boundary(q, p->virt_boundary_mask);
 
-	if (p->read_only)
+	if (p->attrs & UBLK_ATTR_READ_ONLY)
 		set_disk_ro(ub->ub_disk, true);
 
 	set_capacity(ub->ub_disk, p->dev_sectors);
-}
-
-static int ublk_dev_para_discard_validate(const struct ublk_device *ub,
-		const struct ublk_para_header *header)
-{
-	const struct ublk_discard_para *p = (struct ublk_discard_para *)header;
-
-	/* So far, only support single segment discard */
-	if (p->max_discard_sectors && p->max_discard_segments != 1)
-		return -EINVAL;
-	return 0;
-}
-
-static void ublk_dev_para_discard_apply(struct ublk_device *ub,
-		const struct ublk_para_header *header)
-{
-	struct request_queue *q = ub->ub_disk->queue;
-	const struct ublk_discard_para *p = (struct ublk_discard_para *)
-		header;
 
-	q->limits.discard_alignment = p->discard_alignment;
+	q->limits.discard_alignment = p->discard_alignment_offset;
 	q->limits.discard_granularity = p->discard_granularity;
 	blk_queue_max_discard_sectors(q, p->max_discard_sectors);
 	blk_queue_max_write_zeroes_sectors(q,
 			p->max_write_zeroes_sectors);
 	blk_queue_max_discard_segments(q, p->max_discard_segments);
-}
-
-static const unsigned int para_len[] = {
-	[UBLK_PARA_TYPE_BASIC] = sizeof(struct ublk_basic_para),
-	[UBLK_PARA_TYPE_DISCARD] = sizeof(struct ublk_discard_para),
-};
-
-static const struct ublk_para_ops para_ops[] = {
-	[UBLK_PARA_TYPE_BASIC] = {
-		.validate_fn = ublk_dev_para_basic_validate,
-		.apply_fn = ublk_dev_para_basic_apply,
-	},
-	[UBLK_PARA_TYPE_DISCARD] = {
-		.validate_fn = ublk_dev_para_discard_validate,
-		.apply_fn = ublk_dev_para_discard_apply,
-	},
-};
-
-static void ublk_update_dev_sectors(struct ublk_device *ub,
-		sector_t sectors)
-{
-	struct ublk_basic_para  *p = xa_load(&ub->paras,
-			UBLK_PARA_TYPE_BASIC);
-
-	if (p)
-		p->dev_sectors = (__u64)sectors;
-}
-
-static struct ublk_para_header *ublk_alloc_def_basic_para(
-		struct ublk_device *ub)
-{
-	struct ublk_basic_para  *p = kzalloc(sizeof(*p), GFP_KERNEL);
-	struct ublksrv_ctrl_dev_info *info = &ub->dev_info;
-
-	if (!p)
-		return NULL;
-
-	p->header.type = UBLK_PARA_TYPE_BASIC;
-	p->header.len = sizeof(*p);
-	p->logical_bs_shift = ilog2(info->block_size);
-	p->physical_bs_shift = ilog2(info->block_size);
-	p->io_opt_shift = ilog2(info->block_size);
-	p->io_min_shift = ilog2(info->block_size);
-	p->rotational = 0;
-	p->write_back_cache = 0;
-	p->fua = 0;
-	p->read_only = 0;
-
-	p->max_sectors = info->rq_max_blocks << (ub->bs_shift - 9);
-	p->chunk_sectors = 0;
-	p->virt_boundary_mask = 0;
-	p->dev_sectors = info->dev_blocks << (ub->bs_shift - 9);
-
-	return (struct ublk_para_header *)p;
-}
-
-static struct ublk_para_header *ublk_alloc_def_discard_para(
-		struct ublk_device *ub)
-{
-	struct ublk_discard_para  *p = kzalloc(sizeof(*p), GFP_KERNEL);
-
-	if (!p)
-		return NULL;
-
-	p->header.type = UBLK_PARA_TYPE_DISCARD;
-	p->header.len = sizeof(*p);
-
-	p->discard_alignment =	0;
-	p->discard_granularity = PAGE_SIZE;
-	p->max_discard_sectors = UINT_MAX >> 9;
-	p->max_write_zeroes_sectors = UINT_MAX >> 9;
-	p->max_discard_segments = 1;
-
-	return (struct ublk_para_header *)p;
-}
-
-static int ublk_validate_para_header(const struct ublk_device *ub,
-		const struct ublk_para_header *h)
-{
-	if (h->type >= UBLK_PARA_TYPE_LAST)
-		return -EINVAL;
-
-	if (h->len != para_len[h->type])
-		return -EINVAL;
-
 	return 0;
 }
 
-
-static int ublk_validate_para(const struct ublk_device *ub,
-		const struct ublk_para_header *h)
-{
-	int ret = ublk_validate_para_header(ub, h);
-
-	if (ret)
-		return ret;
-
-	if (para_ops[h->type].validate_fn)
-		return para_ops[h->type].validate_fn(ub, h);
-
-	return 0;
-}
-
-/* Old parameter with same type will be overridden */
-static int ublk_install_para(struct ublk_device *ub,
-		struct ublk_para_header *h)
-{
-	void *old;
-	int ret;
-
-	ret = ublk_validate_para(ub, h);
-	if (ret)
-		return ret;
-
-	old = xa_store(&ub->paras, h->type, h, GFP_KERNEL);
-	if (xa_is_err(old))
-		return xa_err(old);
-	kfree(old);
-	return 0;
-}
-
-static void ublk_apply_para(struct ublk_device *ub,
-		const struct ublk_para_header *h)
-{
-	if (para_ops[h->type].apply_fn)
-		para_ops[h->type].apply_fn(ub, h);
-}
-
-/* default parameters are allocated/installed before disk is allocated */
-static void ublk_install_def_paras(struct ublk_device *ub)
-{
-	struct ublk_para_header *h;
-
-	h = ublk_alloc_def_basic_para(ub);
-	if (h && ublk_install_para(ub, h))
-		kfree(h);
-
-	h = ublk_alloc_def_discard_para(ub);
-	if (h && ublk_install_para(ub, h))
-		kfree(h);
-}
-
-static void ublk_apply_paras(struct ublk_device *ub)
-{
-	struct ublk_para_header *h;
-	unsigned long type;
-
-	xa_for_each(&ub->paras, type, h)
-		ublk_apply_para(ub, h);
-}
-
-static void ublk_uninstall_paras(struct ublk_device *ub)
-{
-	unsigned long type;
-	void *p;
-
-	xa_for_each(&ub->paras, type, p)
-		kfree(p);
-}
-
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 {
 	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
@@ -1281,10 +1109,8 @@ static void ublk_cdev_rel(struct device *dev)
 
 	blk_mq_free_tag_set(&ub->tag_set);
 	ublk_deinit_queues(ub);
-	ublk_uninstall_paras(ub);
 	ublk_free_dev_number(ub);
 	mutex_destroy(&ub->mutex);
-	xa_destroy(&ub->paras);
 	kfree(ub);
 }
 
@@ -1397,8 +1223,7 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	/* We may get disk size updated */
 	if (dev_blocks) {
 		ub->dev_info.dev_blocks = dev_blocks;
-		ublk_update_dev_sectors(ub,
-				dev_blocks << (ub->bs_shift - 9));
+		ub->params.dev_sectors = dev_blocks << (ub->bs_shift - 9);
 	}
 
 	disk = blk_mq_alloc_disk(&ub->tag_set, ub);
@@ -1413,8 +1238,6 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	ub->ub_disk = disk;
 
-	ublk_apply_paras(ub);
-
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
@@ -1525,7 +1348,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	spin_lock_init(&ub->mm_lock);
 	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
 	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
-	xa_init(&ub->paras);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -1552,6 +1374,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 			ub->dev_info.nr_hw_queues, nr_cpu_ids);
 	ublk_align_max_io_size(ub);
 
+	ublk_init_default_params(ub);
+
 	ret = ublk_init_queues(ub);
 	if (ret)
 		goto out_free_dev_number;
@@ -1569,9 +1393,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	 * ublk_add_chdev() will cleanup everything if it fails.
 	 */
 	ret = ublk_add_chdev(ub);
-	if (!ret)
-		ublk_install_def_paras(ub);
-
 	goto out_unlock;
 
 out_free_tag_set:
@@ -1674,84 +1495,65 @@ static int ublk_ctrl_get_dev_info(struct io_uring_cmd *cmd)
 	return ret;
 }
 
-static int ublk_ctrl_get_para(struct io_uring_cmd *cmd)
+static int ublk_ctrl_get_params(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	size_t psize = min_t(size_t, sizeof(struct ublk_params), header->len);
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_device *ub;
-	struct ublk_para_header ph;
-	struct ublk_para_header *para = NULL;
 	int ret = 0;
 
-	if (header->len <= sizeof(ph) || !header->addr)
+	if (!header->addr)
 		return -EINVAL;
 
 	ub = ublk_get_device_from_id(header->dev_id);
 	if (!ub)
 		return -EINVAL;
 
-	ret = -EFAULT;
-	if (copy_from_user(&ph, argp, sizeof(ph)))
-		goto out_put;
-
-	ret = ublk_validate_para_header(ub, &ph);
-	if (ret)
-		goto out_put;
-
 	mutex_lock(&ub->mutex);
-	para = xa_load(&ub->paras, ph.type);
-	mutex_unlock(&ub->mutex);
-	if (!para)
-		ret = -EINVAL;
-	else if (copy_to_user(argp, para, ph.len))
+	if (copy_to_user(argp, &ub->params, psize))
 		ret = -EFAULT;
-out_put:
+	mutex_unlock(&ub->mutex);
 	ublk_put_device(ub);
 	return ret;
 }
 
-static int ublk_ctrl_set_para(struct io_uring_cmd *cmd)
+static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	size_t psize = min_t(size_t, sizeof(struct ublk_params), header->len);
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_device *ub;
-	struct ublk_para_header ph;
-	struct ublk_para_header *para = NULL;
+	struct ublk_params params = {};
 	int ret = -EFAULT;
 
-	if (header->len <= sizeof(ph) || !header->addr)
+	if (!header->addr)
 		return -EINVAL;
 
 	ub = ublk_get_device_from_id(header->dev_id);
 	if (!ub)
 		return -EINVAL;
 
-	if (copy_from_user(&ph, argp, sizeof(ph)))
+	if (copy_from_user(&params, argp, psize))
 		goto out_put;
 
-	ret = ublk_validate_para_header(ub, &ph);
+	/* parameters can only be changed when device isn't live */
+	mutex_lock(&ub->mutex);
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+		ret = -EACCES;
+		goto out_unlock;
+	}
+	ret = ublk_params_apply(ub, &params);
 	if (ret)
-		goto out_put;
+		goto out_unlock;
 
-	para = kmalloc(ph.len, GFP_KERNEL);
-	if (!para) {
-		ret = -ENOMEM;
-	} else if (copy_from_user(para, argp, ph.len)) {
+	/* copy back the paramters that were actually applied */
+	if (copy_to_user(argp, &ub->params, psize))
 		ret = -EFAULT;
-	} else {
-		/* parameters can only be changed when device isn't live */
-		mutex_lock(&ub->mutex);
-		if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-			ret = ublk_install_para(ub, para);
-		else
-			ret = -EACCES;
-		mutex_unlock(&ub->mutex);
-	}
+out_unlock:
+	mutex_unlock(&ub->mutex);
 out_put:
 	ublk_put_device(ub);
-	if (ret)
-		kfree(para);
-
 	return ret;
 }
 
@@ -1790,11 +1592,11 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 		ret = ublk_ctrl_get_queue_affinity(cmd);
 		break;
-	case UBLK_CMD_GET_PARA:
-		ret = ublk_ctrl_get_para(cmd);
+	case UBLK_CMD_GET_PARAMS:
+		ret = ublk_ctrl_get_params(cmd);
 		break;
-	case UBLK_CMD_SET_PARA:
-		ret = ublk_ctrl_set_para(cmd);
+	case UBLK_CMD_SET_PARAMS:
+		ret = ublk_ctrl_set_params(cmd);
 		break;
 	default:
 		break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 0f7be73987551..ce406bbede082 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -15,8 +15,8 @@
 #define	UBLK_CMD_DEL_DEV		0x05
 #define	UBLK_CMD_START_DEV	0x06
 #define	UBLK_CMD_STOP_DEV	0x07
-#define	UBLK_CMD_SET_PARA	0x08
-#define	UBLK_CMD_GET_PARA	0x09
+#define	UBLK_CMD_SET_PARAMS	0x08
+#define	UBLK_CMD_GET_PARAMS	0x09
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
@@ -160,47 +160,28 @@ struct ublksrv_io_cmd {
 	__u64	addr;
 };
 
-/* ublk device parameter definition */
-enum {
-	UBLK_PARA_TYPE_BASIC,
-	UBLK_PARA_TYPE_DISCARD,
-	UBLK_PARA_TYPE_LAST,
-};
-
-struct ublk_para_header {
-	__u16 type;
-	__u16 len;
-} __attribute__ ((__packed__));
-
-struct ublk_basic_para {
-	struct ublk_para_header  header;
-	__u32   logical_bs_shift:6;
-	__u32   physical_bs_shift:6;
-	__u32	io_opt_shift:6;
-	__u32	io_min_shift:6;
-	__u32	rotational:1;
-	__u32	write_back_cache:1;
-	__u32	fua:1;
-	__u32	read_only:1;
-	__u32	unused:4;
-
-	__u32	max_sectors;
-	__u32	chunk_sectors;
-
-	__u64   dev_sectors;
-	__u64   virt_boundary_mask;
-};
-
-struct ublk_discard_para {
-	struct ublk_para_header  header;
-	__u32	discard_alignment;
-
-	__u32	discard_granularity;
-	__u32	max_discard_sectors;
-
-	__u32	max_write_zeroes_sectors;
-	__u16	max_discard_segments;
-	__u16	reserved0;
+struct ublk_params {
+	__u32		attrs;
+#define UBLK_ATTR_READ_ONLY		(1 << 0)
+#define UBLK_ATTR_ROTATIONAL		(1 << 1)
+#define UBLK_ATTR_VOLATILE_CACHE	(1 << 2)
+#define UBLK_ATTR_FUA			(1 << 3)
+	__u8		logical_bs_shift;
+	__u8		physical_bs_shift;
+	__u8		io_opt_shift;
+	__u8		io_min_shift;
+	__u32		max_sectors;
+	__u32		chunk_sectors;
+	__u64		dev_sectors;
+	__u64		virt_boundary_mask;
+
+	__u32		discard_alignment_offset;
+	__u32		discard_granularity;
+	__u32		max_discard_sectors;
+	__u32		max_write_zeroes_sectors;
+	__u16		max_discard_segments;
+	__u8		reserved0[6];
+	/* keep this 8 byte aligned */
 };
 
 #endif

