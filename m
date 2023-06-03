Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254B2C77B7A
	for <linux-block@archiver.kernel.org>; Sat,  3 Jun 2023 04:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjFCEG7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Jun 2023 00:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCEG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Jun 2023 00:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F4E41
        for <linux-block@vger.kernel.org>; Fri,  2 Jun 2023 21:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685765169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hu7EqT2cV9Zgt+AQ8wsgKorG7FjMDGY0hGsztGB6wCo=;
        b=J3Kh/E+elMbbysEuscS33wCdoavZL8qfQ2dgFnzcuOzEYmlsAsF0oYyfSKNEh0nNWysTmQ
        ZOaC/kL+UPmhMro89YqC107BC/ZmRk1EauvdppkvyVr/jMMEo6xKzgUgRKZY8tkDAYp/bF
        j4lVY0LbJaNGcgBH8rAVLAK+xjQI86Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-uXHOr3c2OA2v7YKq1aA-0w-1; Sat, 03 Jun 2023 00:06:05 -0400
X-MC-Unique: uXHOr3c2OA2v7YKq1aA-0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 668641C04333;
        Sat,  3 Jun 2023 04:06:05 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88BA140C6EC4;
        Sat,  3 Jun 2023 04:06:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: add control command of UBLK_U_CMD_GET_FEATURES
Date:   Sat,  3 Jun 2023 12:06:01 +0800
Message-Id: <20230603040601.775227-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add control command of UBLK_U_CMD_GET_FEATURES for returning driver's
feature set or capability.

This way can simplify userspace for maintaining compatibility because
userspace doesn't need to send command to one device for querying driver
feature set any more. Such as, with the queried feature set, userspace
can choose to use:

- UBLK_CMD_GET_DEV_INFO2 or UBLK_CMD_GET_DEV_INFO,
- UBLK_U_CMD_* or UBLK_CMD_*

Userspace code:
	https://github.com/ming1/ubdsrv/commits/features-cmd

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 21 +++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  8 ++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 539eada32861..222a0341913f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2343,6 +2343,21 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	return ret;
 }
 
+static int ublk_ctrl_get_features(struct io_uring_cmd *cmd)
+{
+	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	u64 features = UBLK_F_ALL & ~UBLK_F_SUPPORT_ZERO_COPY;
+
+	if (header->len != UBLK_FEATURES_LEN || !header->addr)
+		return -EINVAL;
+
+	if (copy_to_user(argp, &features, UBLK_FEATURES_LEN))
+		return -EFAULT;
+
+	return 0;
+}
+
 /*
  * All control commands are sent via /dev/ublk-control, so we have to check
  * the destination device's permission
@@ -2423,6 +2438,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_GET_DEV_INFO2:
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 	case UBLK_CMD_GET_PARAMS:
+	case (_IOC_NR(UBLK_U_CMD_GET_FEATURES)):
 		mask = MAY_READ;
 		break;
 	case UBLK_CMD_START_DEV:
@@ -2472,6 +2488,11 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (ret)
 		goto out;
 
+	if (cmd_op == UBLK_U_CMD_GET_FEATURES) {
+		ret = ublk_ctrl_get_features(cmd);
+		goto out;
+	}
+
 	if (_IOC_NR(cmd_op) != UBLK_CMD_ADD_DEV) {
 		ret = -ENODEV;
 		ub = ublk_get_device_from_id(header->dev_id);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 54b5b0aeefca..4b8558db90e1 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -47,6 +47,14 @@
 	_IOWR('u', UBLK_CMD_END_USER_RECOVERY, struct ublksrv_ctrl_cmd)
 #define UBLK_U_CMD_GET_DEV_INFO2	\
 	_IOR('u', UBLK_CMD_GET_DEV_INFO2, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_FEATURES	\
+	_IOR('u', 0x13, struct ublksrv_ctrl_cmd)
+
+/*
+ * 64bits are enough now, and it should be easy to extend in case of
+ * running out of feature flags
+ */
+#define UBLK_FEATURES_LEN  8
 
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
-- 
2.40.1

