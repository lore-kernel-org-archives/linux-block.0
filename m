Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2873EC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 14:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiG0OQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiG0OQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 10:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A31D5F88
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658931411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cN+eWyMJt2WbsBIIPTAQKosvbq+dWrcONBW/2MooE6s=;
        b=Pi4jel41YASowRaLi9OkORDlzKlSDi/U11487FEXcXHENxs42ZxxFOQg83EDaTw7Qv4iJ0
        v6LJR7/U9GI0d9R1OF8sx/h14OgmADILwXUbK2dRHYe6XZINi0NzqMhxpJ4SpgU1uySaq7
        GRLwAb1gLkK327GyVMsHT4qReBIyrwI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-PnfgCIM5ODaBYJhK-4iehg-1; Wed, 27 Jul 2022 10:16:48 -0400
X-MC-Unique: PnfgCIM5ODaBYJhK-4iehg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4003280EE2B;
        Wed, 27 Jul 2022 14:16:47 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0E2D40C128A;
        Wed, 27 Jul 2022 14:16:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/5] ublk_drv: add SET_PARAM/GET_PARAM control command
Date:   Wed, 27 Jul 2022 22:16:26 +0800
Message-Id: <20220727141628.985429-4-ming.lei@redhat.com>
In-Reply-To: <20220727141628.985429-1-ming.lei@redhat.com>
References: <20220727141628.985429-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add two commands to set/get parameters generically.

One important goal of ublk is to provide generic framework for making
block device by userspace flexibly.

As one generic block device, there are still lots of block parameters,
such as max_sectors, write_cache/fua, discard related limits,
zoned parameters, ...., so this patch starts to add mechanism for set/get
device parameters.

Both generic block parameters(all kinds of queue settings) and ublk feature
related parameters can be covered with this way, then it becomes quite easy
to extend in future.

The parameter passed from userspace is added to one xarray because most
of parameters are optional, and their type is used as key of xarray,
meantime in future there may be lots of parameters.

This way provides mechanism to simulate any kind of generic block device from
userspace easily, from both block queue setting viewpoint or ublk
feature viewpoint.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 103 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  10 ++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cb880308a378..39bb2d943dc2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -137,6 +137,8 @@ struct ublk_device {
 	spinlock_t		mm_lock;
 	struct mm_struct	*mm;
 
+	struct xarray		params;
+
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	atomic_t		nr_aborted_queues;
@@ -160,6 +162,18 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
+static int ublk_validate_param_header(const struct ublk_device *ub,
+		const struct ublk_param_header *h)
+{
+	return -EINVAL;
+}
+
+static int ublk_install_param(struct ublk_device *ub,
+		struct ublk_param_header *h)
+{
+	return -EINVAL;
+}
+
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 {
 	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
@@ -1055,6 +1069,7 @@ static void ublk_cdev_rel(struct device *dev)
 	ublk_deinit_queues(ub);
 	ublk_free_dev_number(ub);
 	mutex_destroy(&ub->mutex);
+	xa_destroy(&ub->params);
 	kfree(ub);
 }
 
@@ -1300,6 +1315,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	spin_lock_init(&ub->mm_lock);
 	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
 	INIT_DELAYED_WORK(&ub->monitor_work, ublk_daemon_monitor_work);
+	xa_init(&ub->params);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -1445,6 +1461,87 @@ static int ublk_ctrl_get_dev_info(struct io_uring_cmd *cmd)
 	return ret;
 }
 
+static int ublk_ctrl_get_param(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublk_device *ub;
+	struct ublk_param_header ph;
+	struct ublk_param_header *param = NULL;
+	int ret = 0;
+
+	if (header->len <= sizeof(ph) || !header->addr)
+		return -EINVAL;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return -EINVAL;
+
+	ret = -EFAULT;
+	if (copy_from_user(&ph, argp, sizeof(ph)))
+		goto out_put;
+
+	ret = ublk_validate_param_header(ub, &ph);
+	if (ret)
+		goto out_put;
+
+	mutex_lock(&ub->mutex);
+	param = xa_load(&ub->params, ph.type);
+	mutex_unlock(&ub->mutex);
+	if (!param)
+		ret = -EINVAL;
+	else if (copy_to_user(argp, param, ph.len))
+		ret = -EFAULT;
+out_put:
+	ublk_put_device(ub);
+	return ret;
+}
+
+static int ublk_ctrl_set_param(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublk_device *ub;
+	struct ublk_param_header ph;
+	struct ublk_param_header *param = NULL;
+	int ret = -EFAULT;
+
+	if (header->len <= sizeof(ph) || !header->addr)
+		return -EINVAL;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return -EINVAL;
+
+	if (copy_from_user(&ph, argp, sizeof(ph)))
+		goto out_put;
+
+	ret = ublk_validate_param_header(ub, &ph);
+	if (ret)
+		goto out_put;
+
+	param = kmalloc(ph.len, GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+	} else if (copy_from_user(param, argp, ph.len)) {
+		ret = -EFAULT;
+	} else {
+		/* parameters can only be changed when device isn't live */
+		mutex_lock(&ub->mutex);
+		if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+			ret = ublk_install_param(ub, param);
+		else
+			ret = -EACCES;
+		mutex_unlock(&ub->mutex);
+	}
+out_put:
+	ublk_put_device(ub);
+	if (ret)
+		kfree(param);
+
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -1480,6 +1577,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 		ret = ublk_ctrl_get_queue_affinity(cmd);
 		break;
+	case UBLK_CMD_GET_PARAM:
+		ret = ublk_ctrl_get_param(cmd);
+		break;
+	case UBLK_CMD_SET_PARAM:
+		ret = ublk_ctrl_set_param(cmd);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index ca33092354ab..1fb56d35ba8a 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -15,6 +15,8 @@
 #define	UBLK_CMD_DEL_DEV		0x05
 #define	UBLK_CMD_START_DEV	0x06
 #define	UBLK_CMD_STOP_DEV	0x07
+#define	UBLK_CMD_SET_PARAM	0x08
+#define	UBLK_CMD_GET_PARAM	0x09
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
@@ -158,4 +160,12 @@ struct ublksrv_io_cmd {
 	__u64	addr;
 };
 
+/* 512 is big enough for single parameter */
+#define UBLK_MAX_PARAM_LEN	512
+
+struct ublk_param_header {
+	__u16 type;
+	__u16 len;
+};
+
 #endif
-- 
2.31.1

