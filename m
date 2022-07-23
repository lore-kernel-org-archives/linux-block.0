Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C165C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 15:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbiGWPHl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbiGWPHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 11:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 145A71A82F
        for <linux-block@vger.kernel.org>; Sat, 23 Jul 2022 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658588859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9frz5sI+kGcAzZlm+hfkm8rSp0rpwMvP7rdg2Zj9EU=;
        b=eLW3w5eODwV6mTpHfsXTBirDIiB5J5A5cHlqyOIUwIs+AZHcFTQ8xSdIcl7XGpHHXhC1gn
        iEQH/eqrUOOZoRWEaK1ugII7/Ovx1C8AjCFQLf0rmm+9F0rKWQ1EWlytFl88SH6lvcfamw
        3mdlKit39HqDg6GgPr8a+KDrVZsUQes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-z3qrlOLqP2Gj3fwiIEvrmA-1; Sat, 23 Jul 2022 11:07:33 -0400
X-MC-Unique: z3qrlOLqP2Gj3fwiIEvrmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9917101A54E;
        Sat, 23 Jul 2022 15:07:32 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB5EA1121314;
        Sat, 23 Jul 2022 15:07:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] ublk_drv: add SET_PARA/GET_PARA control command
Date:   Sat, 23 Jul 2022 23:07:13 +0800
Message-Id: <20220723150713.750369-3-ming.lei@redhat.com>
In-Reply-To: <20220723150713.750369-1-ming.lei@redhat.com>
References: <20220723150713.750369-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add two commands to set/get parameters generically.

Both generic block device parameters and feature related parameters
can be covered with this way, then it becomes quite easy to extend
in future.

Meantime this way provides mechanism to simulate any kind of generic
block device from userspace easily.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 87 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  2 +
 2 files changed, 89 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e185bdb165de..83fd65d8a205 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1674,6 +1674,87 @@ static int ublk_ctrl_get_dev_info(struct io_uring_cmd *cmd)
 	return ret;
 }
 
+static int ublk_ctrl_get_para(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublk_device *ub;
+	struct ublk_para_header ph;
+	struct ublk_para_header *para = NULL;
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
+	ret = ublk_validate_para_header(ub, &ph);
+	if (ret)
+		goto out_put;
+
+	mutex_lock(&ub->mutex);
+	para = xa_load(&ub->paras, ph.type);
+	mutex_unlock(&ub->mutex);
+	if (!para)
+		ret = -EINVAL;
+	else if (copy_to_user(argp, para, ph.len))
+		ret = -EFAULT;
+out_put:
+	ublk_put_device(ub);
+	return ret;
+}
+
+static int ublk_ctrl_set_para(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	struct ublk_device *ub;
+	struct ublk_para_header ph;
+	struct ublk_para_header *para = NULL;
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
+	ret = ublk_validate_para_header(ub, &ph);
+	if (ret)
+		goto out_put;
+
+	para = kmalloc(ph.len, GFP_KERNEL);
+	if (!para) {
+		ret = -ENOMEM;
+	} else if (copy_from_user(para, argp, ph.len)) {
+		ret = -EFAULT;
+	} else {
+		/* parameters can only be changed when device isn't live */
+		mutex_lock(&ub->mutex);
+		if (ub->dev_info.state != UBLK_S_DEV_LIVE)
+			ret = ublk_install_para(ub, para);
+		else
+			ret = -EACCES;
+		mutex_unlock(&ub->mutex);
+	}
+out_put:
+	ublk_put_device(ub);
+	if (ret)
+		kfree(para);
+
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -1709,6 +1790,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 		ret = ublk_ctrl_get_queue_affinity(cmd);
 		break;
+	case UBLK_CMD_GET_PARA:
+		ret = ublk_ctrl_get_para(cmd);
+		break;
+	case UBLK_CMD_SET_PARA:
+		ret = ublk_ctrl_set_para(cmd);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 99f81a1e9a95..0f7be7398755 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -15,6 +15,8 @@
 #define	UBLK_CMD_DEL_DEV		0x05
 #define	UBLK_CMD_START_DEV	0x06
 #define	UBLK_CMD_STOP_DEV	0x07
+#define	UBLK_CMD_SET_PARA	0x08
+#define	UBLK_CMD_GET_PARA	0x09
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
-- 
2.31.1

