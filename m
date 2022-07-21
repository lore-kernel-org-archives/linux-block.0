Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00165C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 13:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiGUNJx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiGUNJt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66797A512
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hTf5yPWA/ZOwGD7kD9LYQTRXkHyt9pU1KVLgibepbmo=; b=qTXLkeb3wlSz5r6/WjJcSb2cDY
        G8JHpEsQJ45n+89KhYRTYmSR/4MnaeSVrcxcTkZ86SpAr5R6KR0G1fh2z4E554yH/dQ8K/yMdj1dW
        mE7B8SKCILGgaqPWYtTk/w9U2JaVWhR5egPzw3HouB5qs+yqE7WGeNdwxHesG14161ov+4ggjMgch
        SpQ9b6TnMqx+rHyNCEg6bJxgYmFjC9tQWLAQuRUa5koZW51NW2vtjzPgNxPiIWzpo7Dkd7ahIKoEi
        F0flUaVIJlQiY4T0sDsw4VkVwLePuC8/5z738mKHEF3163GSsXef9t7SGY+dM8LQzy1n5DLtvRm8m
        xrZlKh7Q==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEVvo-006mtM-Fc; Thu, 21 Jul 2022 13:09:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 5/8] ublk: cleanup ublk_ctrl_uring_cmd
Date:   Thu, 21 Jul 2022 15:09:13 +0200
Message-Id: <20220721130916.1869719-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721130916.1869719-1-hch@lst.de>
References: <20220721130916.1869719-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move all per-command work into the per-command ublk_ctrl_* helpers
instead of being split over those, ublk_ctrl_cmd_validate, and the main
ublk_ctrl_uring_cmd handler.  To facilitate that, the old
ublk_ctrl_stop_dev function that just contained two function calls is
folded into both callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 234 +++++++++++++++++++--------------------
 1 file changed, 116 insertions(+), 118 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1f7bbbc3276a2..2032d677b9f18 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -813,13 +813,6 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	cancel_delayed_work_sync(&ub->monitor_work);
 }
 
-static int ublk_ctrl_stop_dev(struct ublk_device *ub)
-{
-	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->stop_work);
-	return 0;
-}
-
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
 {
 	return ubq->nr_io_ready == ubq->q_depth;
@@ -1205,8 +1198,8 @@ static int ublk_add_dev(struct ublk_device *ub)
 
 static void ublk_remove(struct ublk_device *ub)
 {
-	ublk_ctrl_stop_dev(ub);
-
+	ublk_stop_dev(ub);
+	cancel_work_sync(&ub->stop_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	put_device(&ub->cdev_dev);
 }
@@ -1227,36 +1220,45 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 	return ub;
 }
 
-static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
+static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
-	int ret = -EINVAL;
 	int ublksrv_pid = (int)header->data[0];
 	unsigned long dev_blocks = header->data[1];
+	struct ublk_device *ub;
+	int ret = -EINVAL;
 
 	if (ublksrv_pid <= 0)
-		return ret;
+		return -EINVAL;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return -EINVAL;
 
 	wait_for_completion_interruptible(&ub->completion);
 
 	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
 
 	mutex_lock(&ub->mutex);
-	if (!disk_live(ub->ub_disk)) {
-		/* We may get disk size updated */
-		if (dev_blocks) {
-			ub->dev_info.dev_blocks = dev_blocks;
-			ublk_update_capacity(ub);
-		}
-		ub->dev_info.ublksrv_pid = ublksrv_pid;
-		ret = add_disk(ub->ub_disk);
-		if (!ret)
-			ub->dev_info.state = UBLK_S_DEV_LIVE;
-	} else {
+	if (disk_live(ub->ub_disk)) {
 		ret = -EEXIST;
+		goto out_unlock;
 	}
-	mutex_unlock(&ub->mutex);
 
+	/* We may get disk size updated */
+	if (dev_blocks) {
+		ub->dev_info.dev_blocks = dev_blocks;
+		ublk_update_capacity(ub);
+	}
+	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	ret = add_disk(ub->ub_disk);
+	if (ret)
+		goto out_unlock;
+
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
+out_unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_device(ub);
 	return ret;
 }
 
@@ -1281,6 +1283,13 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	unsigned long queue;
 	unsigned int retlen;
 	int ret = -EINVAL;
+	
+	if (header->len * BITS_PER_BYTE < nr_cpu_ids)
+		return -EINVAL;
+	if (header->len & (sizeof(unsigned long)-1))
+		return -EINVAL;
+	if (!header->addr)
+		return -EINVAL;
 
 	ub = ublk_get_device_from_id(header->dev_id);
 	if (!ub)
@@ -1311,38 +1320,64 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	return ret;
 }
 
-static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_dev_info *info,
-		void __user *argp, int idx)
+static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 {
+	pr_devel("%s: dev id %d flags %llx\n", __func__,
+			info->dev_id, info->flags[0]);
+	pr_devel("\t nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
+			info->nr_hw_queues, info->queue_depth,
+			info->block_size, info->dev_blocks);
+}
+
+static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublksrv_ctrl_dev_info info;
 	struct ublk_device *ub;
-	int ret;
+	int ret = -EINVAL;
+
+	if (header->len < sizeof(info) || !header->addr)
+		return -EINVAL;
+	if (header->queue_id != (u16)-1) {
+		pr_warn("%s: queue_id is wrong %x\n",
+			__func__, header->queue_id);
+		return -EINVAL;
+	}
+	if (copy_from_user(&info, argp, sizeof(info)))
+		return -EFAULT;
+	ublk_dump_dev_info(&info);
+	if (header->dev_id != info.dev_id) {
+		pr_warn("%s: dev id not match %u %u\n",
+			__func__, header->dev_id, info.dev_id);
+		return -EINVAL;
+	}
 
 	ret = mutex_lock_killable(&ublk_ctl_mutex);
 	if (ret)
 		return ret;
 
-	ub = __ublk_create_dev(idx);
-	if (!IS_ERR_OR_NULL(ub)) {
-		memcpy(&ub->dev_info, info, sizeof(*info));
+	ub = __ublk_create_dev(header->dev_id);
+	if (IS_ERR(ub)) {
+		ret = PTR_ERR(ub);
+		goto out_unlock;
+	}
 
-		/* update device id */
-		ub->dev_info.dev_id = ub->ub_number;
+	memcpy(&ub->dev_info, &info, sizeof(info));
 
-		ret = ublk_add_dev(ub);
-		if (!ret) {
-			if (copy_to_user(argp, &ub->dev_info, sizeof(*info))) {
-				ublk_remove(ub);
-				ret = -EFAULT;
-			}
-		}
-	} else {
-		if (IS_ERR(ub))
-			ret = PTR_ERR(ub);
-		else
-			ret = -ENOMEM;
+	/* update device id */
+	ub->dev_info.dev_id = ub->ub_number;
+
+	ret = ublk_add_dev(ub);
+	if (ret)
+		goto out_unlock;
+
+	if (copy_to_user(argp, &ub->dev_info, sizeof(info))) {
+		ublk_remove(ub);
+		ret = -EFAULT;
 	}
+out_unlock:
 	mutex_unlock(&ublk_ctl_mutex);
-
 	return ret;
 }
 
@@ -1386,16 +1421,6 @@ static int ublk_ctrl_del_dev(int idx)
 	return ret;
 }
 
-
-static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
-{
-	pr_devel("%s: dev id %d flags %llx\n", __func__,
-			info->dev_id, info->flags[0]);
-	pr_devel("\t nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
-			info->nr_hw_queues, info->queue_depth,
-			info->block_size, info->dev_blocks);
-}
-
 static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
@@ -1405,59 +1430,47 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 			header->data[0], header->addr, header->len);
 }
 
-static int ublk_ctrl_cmd_validate(struct io_uring_cmd *cmd,
-		struct ublksrv_ctrl_dev_info *info)
+static int ublk_ctrl_stop_dev(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
-	u32 cmd_op = cmd->cmd_op;
-	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublk_device *ub;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return -EINVAL;
 
-	switch (cmd_op) {
-	case UBLK_CMD_GET_DEV_INFO:
-		if (header->len < sizeof(*info) || !header->addr)
-			return -EINVAL;
-		break;
-	case UBLK_CMD_ADD_DEV:
-		if (header->len < sizeof(*info) || !header->addr)
-			return -EINVAL;
-		if (copy_from_user(info, argp, sizeof(*info)) != 0)
-			return -EFAULT;
-		ublk_dump_dev_info(info);
-		if (header->dev_id != info->dev_id) {
-			printk(KERN_WARNING "%s: cmd %x, dev id not match %u %u\n",
-					__func__, cmd_op, header->dev_id,
-					info->dev_id);
-			return -EINVAL;
-		}
-		if (header->queue_id != (u16)-1) {
-			printk(KERN_WARNING "%s: cmd %x queue_id is wrong %x\n",
-					__func__, cmd_op, header->queue_id);
-			return -EINVAL;
-		}
-		break;
-	case UBLK_CMD_GET_QUEUE_AFFINITY:
-		if ((header->len * BITS_PER_BYTE) < nr_cpu_ids)
-			return -EINVAL;
-		if (header->len & (sizeof(unsigned long)-1))
-			return -EINVAL;
-		if (!header->addr)
-			return -EINVAL;
-	}
+	ublk_stop_dev(ub);
+	cancel_work_sync(&ub->stop_work);
 
+	ublk_put_device(ub);
 	return 0;
 }
 
-static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
-		unsigned int issue_flags)
+static int ublk_ctrl_get_dev_info(struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
-	struct ublksrv_ctrl_dev_info info;
-	u32 cmd_op = cmd->cmd_op;
 	struct ublk_device *ub;
+	int ret = 0;
+
+	if (header->len < sizeof(struct ublksrv_ctrl_dev_info) || !header->addr)
+		return -EINVAL;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return -EINVAL;
+
+	if (copy_to_user(argp, &ub->dev_info, sizeof(ub->dev_info)))
+		ret = -EFAULT;
+	ublk_put_device(ub);
+
+	return ret;
+}
+
+static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
+		unsigned int issue_flags)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	int ret = -EINVAL;
 
 	ublk_ctrl_cmd_dump(cmd);
@@ -1465,38 +1478,23 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (!(issue_flags & IO_URING_F_SQE128))
 		goto out;
 
-	ret = ublk_ctrl_cmd_validate(cmd, &info);
-	if (ret)
+	ret = -EPERM;
+	if (!capable(CAP_SYS_ADMIN))
 		goto out;
 
 	ret = -ENODEV;
-	switch (cmd_op) {
+	switch (cmd->cmd_op) {
 	case UBLK_CMD_START_DEV:
-		ub = ublk_get_device_from_id(header->dev_id);
-		if (ub) {
-			ret = ublk_ctrl_start_dev(ub, cmd);
-			ublk_put_device(ub);
-		}
+		ret = ublk_ctrl_start_dev(cmd);
 		break;
 	case UBLK_CMD_STOP_DEV:
-		ub = ublk_get_device_from_id(header->dev_id);
-		if (ub) {
-			ret = ublk_ctrl_stop_dev(ub);
-			ublk_put_device(ub);
-		}
+		ret = ublk_ctrl_stop_dev(cmd);
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
-		ub = ublk_get_device_from_id(header->dev_id);
-		if (ub) {
-			if (copy_to_user(argp, &ub->dev_info, sizeof(info)))
-				ret = -EFAULT;
-			else
-				ret = 0;
-			ublk_put_device(ub);
-		}
+		ret = ublk_ctrl_get_dev_info(cmd);
 		break;
 	case UBLK_CMD_ADD_DEV:
-		ret = ublk_ctrl_add_dev(&info, argp, header->dev_id);
+		ret = ublk_ctrl_add_dev(cmd);
 		break;
 	case UBLK_CMD_DEL_DEV:
 		ret = ublk_ctrl_del_dev(header->dev_id);
-- 
2.30.2

