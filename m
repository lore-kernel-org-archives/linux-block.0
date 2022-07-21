Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD0C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiGUFRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGUFRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:17:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7685679ED6
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SomBu79KNq6WBBnExFq3YoTTYpoiFj/+uzfMfu6y9tY=; b=LIUsRZy2gHeNb+7iDWMpbWlpmh
        yEQ1HBUbpuCw/yr7xl0Sp/FXUaTs3yL5l++K4p1zOJBKBhwW6JRn/gbmp1V/DvlxZwJ9fseGeusT6
        X0dXOvGc7lCSI2rzD+anYS1l4skrxTV8FvnyyMd7aprpGgUEr5oW/OFeF0Pcfg9inFwSNOk4U9Mzn
        oaLeKNtaAx/ITGUMoJNlMb9Dfohzx5LsyOemxCTJ01P+fAGB3d5zrw4ughSlgY2GvxbZKWV6JJzVw
        XqCp3IvvII04/POuNs/sXg62WDtKiv3FocAX2KyKb3ys4vFlGsBv7mZ1uo4XkP+e7qC1pjBrciUe9
        WaTrErdw==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEOYa-00HDnt-In; Thu, 21 Jul 2022 05:17:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 8/8] ublk: defer disk allocation
Date:   Thu, 21 Jul 2022 07:16:32 +0200
Message-Id: <20220721051632.1676890-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721051632.1676890-1-hch@lst.de>
References: <20220721051632.1676890-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Defer allocating the gendisk and request_queue until UBLK_CMD_START_DEV
is called.  This avoids funky life times where a disk is allocated
and then can be added and removed multiple times, which has never been
supported by the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c | 202 ++++++++++++++++-----------------------
 1 file changed, 85 insertions(+), 117 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 67c6c46b8e07e..85c3277ade372 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -112,7 +112,6 @@ struct ublk_queue {
 
 struct ublk_device {
 	struct gendisk		*ub_disk;
-	struct request_queue	*ub_queue;
 
 	char	*__queues;
 
@@ -126,6 +125,7 @@ struct ublk_device {
 	struct device		cdev_dev;
 
 #define UB_STATE_OPEN		(1 << 0)
+#define UB_STATE_USED		(1 << 1)
 	unsigned long		state;
 	int			ub_number;
 
@@ -156,8 +156,6 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
-static struct lock_class_key ublk_bio_compl_lkclass;
-
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 {
 	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
@@ -209,8 +207,17 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
+static void ublk_free_disk(struct gendisk *disk)
+{
+	struct ublk_device *ub = disk->private_data;
+
+	clear_bit(UB_STATE_USED, &ub->state);
+	put_device(&ub->cdev_dev);
+}
+
 static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
+	.free_disk =	ublk_free_disk,
 };
 
 #define UBLK_MAX_PIN_PAGES	32
@@ -801,13 +808,16 @@ static void ublk_cancel_dev(struct ublk_device *ub)
 static void ublk_stop_dev(struct ublk_device *ub)
 {
 	mutex_lock(&ub->mutex);
-	if (!disk_live(ub->ub_disk))
+	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
 		goto unlock;
 
 	del_gendisk(ub->ub_disk);
 	ub->dev_info.state = UBLK_S_DEV_DEAD;
 	ub->dev_info.ublksrv_pid = -1;
 	ublk_cancel_dev(ub);
+	blk_mq_free_tag_set(&ub->tag_set);
+	put_disk(ub->ub_disk);
+	ub->ub_disk = NULL;
  unlock:
 	mutex_unlock(&ub->mutex);
 	cancel_delayed_work_sync(&ub->monitor_work);
@@ -1033,12 +1043,6 @@ static void ublk_cdev_rel(struct device *dev)
 {
 	struct ublk_device *ub = container_of(dev, struct ublk_device, cdev_dev);
 
-	blk_mq_destroy_queue(ub->ub_queue);
-
-	put_disk(ub->ub_disk);
-
-	blk_mq_free_tag_set(&ub->tag_set);
-
 	ublk_deinit_queues(ub);
 
 	__ublk_destroy_dev(ub);
@@ -1078,107 +1082,6 @@ static void ublk_stop_work_fn(struct work_struct *work)
 	ublk_stop_dev(ub);
 }
 
-static void ublk_update_capacity(struct ublk_device *ub)
-{
-	unsigned int max_rq_bytes;
-
-	/* make max request buffer size aligned with PAGE_SIZE */
-	max_rq_bytes = round_down(ub->dev_info.rq_max_blocks <<
-			ub->bs_shift, PAGE_SIZE);
-	ub->dev_info.rq_max_blocks = max_rq_bytes >> ub->bs_shift;
-
-	set_capacity(ub->ub_disk, ub->dev_info.dev_blocks << (ub->bs_shift - 9));
-}
-
-/* add disk & cdev, cleanup everything in case of failure */
-static int ublk_add_dev(struct ublk_device *ub)
-{
-	struct gendisk *disk;
-	int err = -ENOMEM;
-	int bsize;
-
-	/* We are not ready to support zero copy */
-	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
-
-	bsize = ub->dev_info.block_size;
-	ub->bs_shift = ilog2(bsize);
-
-	ub->dev_info.nr_hw_queues = min_t(unsigned int,
-			ub->dev_info.nr_hw_queues, nr_cpu_ids);
-
-	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
-	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
-
-	if (ublk_init_queues(ub))
-		goto out_destroy_dev;
-
-	ub->tag_set.ops = &ublk_mq_ops;
-	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
-	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
-	ub->tag_set.numa_node = NUMA_NO_NODE;
-	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
-	ub->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	ub->tag_set.driver_data = ub;
-
-	err = blk_mq_alloc_tag_set(&ub->tag_set);
-	if (err)
-		goto out_deinit_queues;
-
-	ub->ub_queue = blk_mq_init_queue(&ub->tag_set);
-	if (IS_ERR(ub->ub_queue)) {
-		err = PTR_ERR(ub->ub_queue);
-		goto out_cleanup_tags;
-	}
-	ub->ub_queue->queuedata = ub;
-
-	disk = ub->ub_disk = blk_mq_alloc_disk_for_queue(ub->ub_queue,
-						 &ublk_bio_compl_lkclass);
-	if (!disk) {
-		err = -ENOMEM;
-		goto out_free_request_queue;
-	}
-
-	blk_queue_logical_block_size(ub->ub_queue, bsize);
-	blk_queue_physical_block_size(ub->ub_queue, bsize);
-	blk_queue_io_min(ub->ub_queue, bsize);
-
-	blk_queue_max_hw_sectors(ub->ub_queue, ub->dev_info.rq_max_blocks <<
-			(ub->bs_shift - 9));
-
-	ub->ub_queue->limits.discard_granularity = PAGE_SIZE;
-
-	blk_queue_max_discard_sectors(ub->ub_queue, UINT_MAX >> 9);
-	blk_queue_max_write_zeroes_sectors(ub->ub_queue, UINT_MAX >> 9);
-
-	ublk_update_capacity(ub);
-
-	disk->fops		= &ub_fops;
-	disk->private_data	= ub;
-	disk->queue		= ub->ub_queue;
-	sprintf(disk->disk_name, "ublkb%d", ub->ub_number);
-
-	mutex_init(&ub->mutex);
-
-	/* add char dev so that ublksrv daemon can be setup */
-	err = ublk_add_chdev(ub);
-	if (err)
-		return err;
-
-	/* don't expose disk now until we got start command from cdev */
-
-	return 0;
-
-out_free_request_queue:
-	blk_mq_destroy_queue(ub->ub_queue);
-out_cleanup_tags:
-	blk_mq_free_tag_set(&ub->tag_set);
-out_deinit_queues:
-	ublk_deinit_queues(ub);
-out_destroy_dev:
-	__ublk_destroy_dev(ub);
-	return err;
-}
-
 static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
@@ -1209,6 +1112,7 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	int ublksrv_pid = (int)header->data[0];
 	unsigned long dev_blocks = header->data[1];
 	struct ublk_device *ub;
+	struct gendisk *disk;
 	int ret = -EINVAL;
 
 	if (ublksrv_pid <= 0)
@@ -1223,22 +1127,62 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
 
 	mutex_lock(&ub->mutex);
-	if (disk_live(ub->ub_disk)) {
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE ||
+	    test_bit(UB_STATE_USED, &ub->state)) {
 		ret = -EEXIST;
 		goto out_unlock;
 	}
 
 	/* We may get disk size updated */
-	if (dev_blocks) {
+	if (dev_blocks)
 		ub->dev_info.dev_blocks = dev_blocks;
-		ublk_update_capacity(ub);
+
+	ub->tag_set.ops = &ublk_mq_ops;
+	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
+	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
+	ub->tag_set.numa_node = NUMA_NO_NODE;
+	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
+	ub->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	ub->tag_set.driver_data = ub;
+	ret = blk_mq_alloc_tag_set(&ub->tag_set);
+	if (ret)
+		goto out_unlock;
+
+	disk = blk_mq_alloc_disk(&ub->tag_set, ub);
+	if (IS_ERR(disk)) {
+		ret = PTR_ERR(disk);
+		goto out_free_tag_set;
 	}
+	sprintf(disk->disk_name, "ublkb%d", ub->ub_number);
+	disk->fops = &ub_fops;
+	disk->private_data = ub;
+
+	blk_queue_logical_block_size(disk->queue, ub->dev_info.block_size);
+	blk_queue_physical_block_size(disk->queue, ub->dev_info.block_size);
+	blk_queue_io_min(disk->queue, ub->dev_info.block_size);
+	blk_queue_max_hw_sectors(disk->queue,
+		ub->dev_info.rq_max_blocks << (ub->bs_shift - 9));
+	disk->queue->limits.discard_granularity = PAGE_SIZE;
+	blk_queue_max_discard_sectors(disk->queue, UINT_MAX >> 9);
+	blk_queue_max_write_zeroes_sectors(disk->queue, UINT_MAX >> 9);
+
+	set_capacity(disk, ub->dev_info.dev_blocks << (ub->bs_shift - 9));
+
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
-	ret = add_disk(ub->ub_disk);
+	ub->ub_disk = disk;
+	get_device(&ub->cdev_dev);
+	ret = add_disk(disk);
 	if (ret)
-		goto out_unlock;
+		goto out_put_disk;
 
+	set_bit(UB_STATE_USED, &ub->state);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	goto out_unlock;
+
+out_put_disk:
+	put_disk(disk);
+out_free_tag_set:
+	blk_mq_free_tag_set(&ub->tag_set);
 out_unlock:
 	mutex_unlock(&ub->mutex);
 	ublk_put_device(ub);
@@ -1319,6 +1263,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublksrv_ctrl_dev_info info;
 	struct ublk_device *ub;
+	unsigned int max_rq_bytes;
 	int ret = -EINVAL;
 
 	if (header->len < sizeof(info) || !header->addr)
@@ -1352,12 +1297,35 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	}
 
+	mutex_init(&ub->mutex);
+	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
+	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
+
 	memcpy(&ub->dev_info, &info, sizeof(info));
 
 	/* update device id */
 	ub->dev_info.dev_id = ub->ub_number;
 
-	ret = ublk_add_dev(ub);
+	/* We are not ready to support zero copy */
+	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
+
+	ub->dev_info.nr_hw_queues = min_t(unsigned int,
+			ub->dev_info.nr_hw_queues, nr_cpu_ids);
+	ub->bs_shift = ilog2(ub->dev_info.block_size);
+
+	/* make max request buffer size aligned with PAGE_SIZE */
+	max_rq_bytes = ub->dev_info.rq_max_blocks << ub->bs_shift;
+	ub->dev_info.rq_max_blocks =
+		round_down(max_rq_bytes, PAGE_SIZE) >> ub->bs_shift;
+
+	ret = ublk_init_queues(ub);
+	if (ret) {
+		__ublk_destroy_dev(ub);
+		goto out_unlock;
+	}
+
+	/* add char dev so that ublksrv daemon can be setup */
+	ret = ublk_add_chdev(ub);
 	if (ret)
 		goto out_unlock;
 
-- 
2.30.2

