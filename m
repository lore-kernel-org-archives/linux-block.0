Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0329FC00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 07:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiG2HaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiG2HaV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 03:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3464B205D7
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659079819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQIn/aIh7ILU7uSe6SnqPtja40v2K2lxLpQY2A66b9g=;
        b=b5yzMxnJYeBqzAiHKXrNPHgXmBPj6PaPToj+xGtgUkq4yerG2XOQKN212CDIKN0cSZVCDY
        0SdUMaukZobgdEQ51+CAT7VaM/5WCqvt/1X2l6d7Q6y4Nx/3eSGrVNNn1ze1wXKecLT62v
        wHIo1POKnly1bsk7B4ltwVT4btPNL90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-2ByRmeFNO-Sn_-aPY4CILQ-1; Fri, 29 Jul 2022 03:30:17 -0400
X-MC-Unique: 2ByRmeFNO-Sn_-aPY4CILQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5366A811E75;
        Fri, 29 Jul 2022 07:30:17 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D75118EB7;
        Fri, 29 Jul 2022 07:30:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/5] ublk_drv: add SET_PARAM/GET_PARAM control command
Date:   Fri, 29 Jul 2022 15:29:52 +0800
Message-Id: <20220729072954.1070514-4-ming.lei@redhat.com>
In-Reply-To: <20220729072954.1070514-1-ming.lei@redhat.com>
References: <20220729072954.1070514-1-ming.lei@redhat.com>
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
zoned parameters, ...., so this patch starts to add mechanism for set/get
device parameters.

Both generic block parameters(all kinds of queue settings) and ublk feature
related parameters can be covered with this way, then it becomes quite easy
to extend in future.

The parameter passed from userspace is added to one array, and the type is
used as index of the array. The following patch will add two parameter
types: basic(covers basic queue setting and misc settings which can't be grouped
easily) and discard. Also segment, zoned[1], userspace recovery[2] and
userspace backing buffer(in my todo list) parameters will be added in near
future.

This way provides mechanism to simulate any kind of generic block device from
userspace easily, from both block queue setting viewpoint or ublk feature
viewpoint.

[1] https://lore.kernel.org/qemu-devel/fa7de750-8def-c532-8c86-64c7505608e0@opensource.wdc.com/T/#u
[2] https://lore.kernel.org/linux-block/60bc9e53-605e-ee1d-9bd2-020693768339@linux.alibaba.com/

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 111 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  14 +++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 00b04f395de0..f949c0d96360 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -137,6 +137,8 @@ struct ublk_device {
 	spinlock_t		mm_lock;
 	struct mm_struct	*mm;
 
+	struct ublk_param_header *params[UBLK_PARAM_TYPE_LAST];
+
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	atomic_t		nr_aborted_queues;
@@ -160,6 +162,28 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
+static int ublk_validate_param_header(const struct ublk_device *ub,
+		const struct ublk_param_header *h)
+{
+	if (h->type >= UBLK_PARAM_TYPE_LAST)
+		return -EINVAL;
+	if (h->len > UBLK_MAX_PARAM_LEN)
+		return -EINVAL;
+	return 0;
+}
+
+/* Old parameter with same type will be overridden */
+static int ublk_install_param(struct ublk_device *ub,
+		struct ublk_param_header *h)
+{
+	struct ublk_param_header *old = ub->params[h->type];
+
+	kfree(old);
+	ub->params[h->type] = h;
+
+	return 0;
+}
+
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 {
 	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
@@ -1447,6 +1471,87 @@ static int ublk_ctrl_get_dev_info(struct io_uring_cmd *cmd)
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
+	param = ub->params[ph.type];
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
@@ -1482,6 +1587,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
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
index ca33092354ab..f6433bb1f5f6 100644
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
@@ -158,4 +160,16 @@ struct ublksrv_io_cmd {
 	__u64	addr;
 };
 
+/* 512 is big enough for single parameter */
+#define UBLK_MAX_PARAM_LEN	512
+
+enum {
+	UBLK_PARAM_TYPE_LAST,
+};
+
+struct ublk_param_header {
+	__u16 type;
+	__u16 len;
+};
+
 #endif
-- 
2.31.1

