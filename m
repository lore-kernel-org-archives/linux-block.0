Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48F9C352A1
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 12:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLGMeb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLGMea (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 07:34:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214234EC37
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 04:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670416414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=feEfdtqcF+JZvZoG9QGAIhat3FG64KfuS34ym8eKdKk=;
        b=Af9kCNECLFz/Q536NhuUI5c2SLFKPermBzbNAJplJg62GthoKepvFjTOF71vEVZQJem9dp
        WBvhxfd33aUrK5LyhlQ9DUK5HKXkfe91quHfeLdTTgRVWy1sPGqsJ30qykUuxDt5Vm4SDq
        XvfJ2mnxTl9HXpljR+rEUTh0R93B9uA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-GkjenCLuMZe7xhcXCheBnQ-1; Wed, 07 Dec 2022 07:33:31 -0500
X-MC-Unique: GkjenCLuMZe7xhcXCheBnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6CB4802314;
        Wed,  7 Dec 2022 12:33:30 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DAF640C2064;
        Wed,  7 Dec 2022 12:33:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/6] ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
Date:   Wed,  7 Dec 2022 20:33:02 +0800
Message-Id: <20221207123305.937678-4-ming.lei@redhat.com>
In-Reply-To: <20221207123305.937678-1-ming.lei@redhat.com>
References: <20221207123305.937678-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is annoying for each control command handler to get/put ublk
device and deal with failure.

Control command handler is simplified a lot by moving
ublk_get_device_from_id into ublk_ctrl_uring_cmd().

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 138 ++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 89 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a3d776a1c2f5..9d1578384cba 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1496,21 +1496,16 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 	return ub;
 }
 
-static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
+static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	int ublksrv_pid = (int)header->data[0];
-	struct ublk_device *ub;
 	struct gendisk *disk;
 	int ret = -EINVAL;
 
 	if (ublksrv_pid <= 0)
 		return -EINVAL;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	wait_for_completion_interruptible(&ub->completion);
 
 	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
@@ -1559,21 +1554,20 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 		put_disk(disk);
 out_unlock:
 	mutex_unlock(&ub->mutex);
-	ublk_put_device(ub);
 	return ret;
 }
 
-static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
+static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
-	struct ublk_device *ub;
 	cpumask_var_t cpumask;
 	unsigned long queue;
 	unsigned int retlen;
 	unsigned int i;
-	int ret = -EINVAL;
-	
+	int ret;
+
 	if (header->len * BITS_PER_BYTE < nr_cpu_ids)
 		return -EINVAL;
 	if (header->len & (sizeof(unsigned long)-1))
@@ -1581,17 +1575,12 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	if (!header->addr)
 		return -EINVAL;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	queue = header->data[0];
 	if (queue >= ub->dev_info.nr_hw_queues)
-		goto out_put_device;
+		return -EINVAL;
 
-	ret = -ENOMEM;
 	if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
-		goto out_put_device;
+		return -ENOMEM;
 
 	for_each_possible_cpu(i) {
 		if (ub->tag_set.map[HCTX_TYPE_DEFAULT].mq_map[i] == queue)
@@ -1609,8 +1598,6 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	ret = 0;
 out_free_cpumask:
 	free_cpumask_var(cpumask);
-out_put_device:
-	ublk_put_device(ub);
 	return ret;
 }
 
@@ -1731,30 +1718,27 @@ static inline bool ublk_idr_freed(int id)
 	return ptr == NULL;
 }
 
-static int ublk_ctrl_del_dev(int idx)
+static int ublk_ctrl_del_dev(struct ublk_device **p_ub)
 {
-	struct ublk_device *ub;
+	struct ublk_device *ub = *p_ub;
+	int idx = ub->ub_number;
 	int ret;
 
 	ret = mutex_lock_killable(&ublk_ctl_mutex);
 	if (ret)
 		return ret;
 
-	ub = ublk_get_device_from_id(idx);
-	if (ub) {
-		ublk_remove(ub);
-		ublk_put_device(ub);
-		ret = 0;
-	} else {
-		ret = -ENODEV;
-	}
+	ublk_remove(ub);
+
+	/* Mark the reference as consumed */
+	*p_ub = NULL;
+	ublk_put_device(ub);
 
 	/*
 	 * Wait until the idr is removed, then it can be reused after
 	 * DEL_DEV command is returned.
 	 */
-	if (!ret)
-		wait_event(ublk_idr_wq, ublk_idr_freed(idx));
+	wait_event(ublk_idr_wq, ublk_idr_freed(idx));
 	mutex_unlock(&ublk_ctl_mutex);
 
 	return ret;
@@ -1769,50 +1753,36 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 			header->data[0], header->addr, header->len);
 }
 
-static int ublk_ctrl_stop_dev(struct io_uring_cmd *cmd)
+static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
-	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
-	struct ublk_device *ub;
-
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	ublk_stop_dev(ub);
 	cancel_work_sync(&ub->stop_work);
 	cancel_work_sync(&ub->quiesce_work);
 
-	ublk_put_device(ub);
 	return 0;
 }
 
-static int ublk_ctrl_get_dev_info(struct io_uring_cmd *cmd)
+static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
-	struct ublk_device *ub;
-	int ret = 0;
 
 	if (header->len < sizeof(struct ublksrv_ctrl_dev_info) || !header->addr)
 		return -EINVAL;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	if (copy_to_user(argp, &ub->dev_info, sizeof(ub->dev_info)))
-		ret = -EFAULT;
-	ublk_put_device(ub);
+		return -EFAULT;
 
-	return ret;
+	return 0;
 }
 
-static int ublk_ctrl_get_params(struct io_uring_cmd *cmd)
+static int ublk_ctrl_get_params(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_params_header ph;
-	struct ublk_device *ub;
 	int ret;
 
 	if (header->len <= sizeof(ph) || !header->addr)
@@ -1827,10 +1797,6 @@ static int ublk_ctrl_get_params(struct io_uring_cmd *cmd)
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	mutex_lock(&ub->mutex);
 	if (copy_to_user(argp, &ub->params, ph.len))
 		ret = -EFAULT;
@@ -1838,16 +1804,15 @@ static int ublk_ctrl_get_params(struct io_uring_cmd *cmd)
 		ret = 0;
 	mutex_unlock(&ub->mutex);
 
-	ublk_put_device(ub);
 	return ret;
 }
 
-static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
+static int ublk_ctrl_set_params(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	void __user *argp = (void __user *)(unsigned long)header->addr;
 	struct ublk_params_header ph;
-	struct ublk_device *ub;
 	int ret = -EFAULT;
 
 	if (header->len <= sizeof(ph) || !header->addr)
@@ -1862,10 +1827,6 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return -EINVAL;
-
 	/* parameters can only be changed when device isn't live */
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
@@ -1878,7 +1839,6 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 		ret = ublk_validate_params(ub);
 	}
 	mutex_unlock(&ub->mutex);
-	ublk_put_device(ub);
 
 	return ret;
 }
@@ -1905,17 +1865,13 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 }
 
-static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
+static int ublk_ctrl_start_recovery(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
-	struct ublk_device *ub;
 	int ret = -EINVAL;
 	int i;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return ret;
-
 	mutex_lock(&ub->mutex);
 	if (!ublk_can_use_recovery(ub))
 		goto out_unlock;
@@ -1948,21 +1904,16 @@ static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
-	ublk_put_device(ub);
 	return ret;
 }
 
-static int ublk_ctrl_end_recovery(struct io_uring_cmd *cmd)
+static int ublk_ctrl_end_recovery(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	int ublksrv_pid = (int)header->data[0];
-	struct ublk_device *ub;
 	int ret = -EINVAL;
 
-	ub = ublk_get_device_from_id(header->dev_id);
-	if (!ub)
-		return ret;
-
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 	/* wait until new ubq_daemon sending all FETCH_REQ */
@@ -1990,7 +1941,6 @@ static int ublk_ctrl_end_recovery(struct io_uring_cmd *cmd)
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
-	ublk_put_device(ub);
 	return ret;
 }
 
@@ -1998,6 +1948,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublk_device *ub = NULL;
 	int ret = -EINVAL;
 
 	ublk_ctrl_cmd_dump(cmd);
@@ -2009,41 +1960,50 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (!capable(CAP_SYS_ADMIN))
 		goto out;
 
-	ret = -ENODEV;
+	if (cmd->cmd_op != UBLK_CMD_ADD_DEV) {
+		ret = -ENODEV;
+		ub = ublk_get_device_from_id(header->dev_id);
+		if (!ub)
+			goto out;
+	}
+
 	switch (cmd->cmd_op) {
 	case UBLK_CMD_START_DEV:
-		ret = ublk_ctrl_start_dev(cmd);
+		ret = ublk_ctrl_start_dev(ub, cmd);
 		break;
 	case UBLK_CMD_STOP_DEV:
-		ret = ublk_ctrl_stop_dev(cmd);
+		ret = ublk_ctrl_stop_dev(ub);
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
-		ret = ublk_ctrl_get_dev_info(cmd);
+		ret = ublk_ctrl_get_dev_info(ub, cmd);
 		break;
 	case UBLK_CMD_ADD_DEV:
 		ret = ublk_ctrl_add_dev(cmd);
 		break;
 	case UBLK_CMD_DEL_DEV:
-		ret = ublk_ctrl_del_dev(header->dev_id);
+		ret = ublk_ctrl_del_dev(&ub);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
-		ret = ublk_ctrl_get_queue_affinity(cmd);
+		ret = ublk_ctrl_get_queue_affinity(ub, cmd);
 		break;
 	case UBLK_CMD_GET_PARAMS:
-		ret = ublk_ctrl_get_params(cmd);
+		ret = ublk_ctrl_get_params(ub, cmd);
 		break;
 	case UBLK_CMD_SET_PARAMS:
-		ret = ublk_ctrl_set_params(cmd);
+		ret = ublk_ctrl_set_params(ub, cmd);
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
-		ret = ublk_ctrl_start_recovery(cmd);
+		ret = ublk_ctrl_start_recovery(ub, cmd);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
-		ret = ublk_ctrl_end_recovery(cmd);
+		ret = ublk_ctrl_end_recovery(ub, cmd);
 		break;
 	default:
+		ret = -ENOTSUPP;
 		break;
 	}
+	if (ub)
+		ublk_put_device(ub);
  out:
 	io_uring_cmd_done(cmd, ret, 0);
 	pr_devel("%s: cmd done ret %d cmd_op %x, dev id %d qid %d\n",
-- 
2.31.1

