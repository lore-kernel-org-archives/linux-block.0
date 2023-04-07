Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E490AC6FD1D
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 08:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjDGIik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjDGIik (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 04:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2310D8
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680856676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DV3ZFTEyQSOYusUbFpfnxF5jw2+IgrmhmttyHuaxDI0=;
        b=WQZ++mD3HZnOr6iRNir4gdPcQXhJlykE01o4kbAQrUlIbFU2Uxk1CPmWnymAZAxpRTrmiK
        ErUe2U1HGIrPGt3GVxPxx1qZbURHgdtrj3JVl4ymzsbqAulJxx9QkmY5v6H2YkDTC0Htq6
        sfynm0f5BUUYkiM40NIqKwbGVXa3waY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-kNE0kPRKOye5xK6X1bNt6w-1; Fri, 07 Apr 2023 04:37:55 -0400
X-MC-Unique: kNE0kPRKOye5xK6X1bNt6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5ED03815EFB;
        Fri,  7 Apr 2023 08:37:54 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6674C33188;
        Fri,  7 Apr 2023 08:37:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: ublk: switch to ioctl command encoding
Date:   Fri,  7 Apr 2023 16:37:22 +0800
Message-Id: <20230407083722.2090706-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All ublk commands(control, IO) should have taken ioctl command encoding
from the beginning, unfortunately we didn't do that way, and it could be
one lesson learnt from ublk driver.

So switch to ioctl command encoding now, we still support commends
encoded in old way, but they become legacy definition. And new command
should take ioctl encoding.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 45 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1223fcbfc6c9..668ce8240787 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -53,7 +53,8 @@
 		| UBLK_F_NEED_GET_DATA \
 		| UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
-		| UBLK_F_UNPRIVILEGED_DEV)
+		| UBLK_F_UNPRIVILEGED_DEV \
+		| UBLK_F_CMD_IOCTL_ENCODE)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
@@ -1299,6 +1300,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 
 	switch (cmd_op) {
 	case UBLK_IO_FETCH_REQ:
+	case UBLK_U_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
 			ret = -EBUSY;
@@ -1320,6 +1322,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
+	case UBLK_U_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
 		/*
 		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if NEED GET DATA is
@@ -1335,6 +1338,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
+	case UBLK_U_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 		io->addr = ub_cmd->addr;
@@ -1743,6 +1747,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
 		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
 
+	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
@@ -2080,6 +2086,12 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 	return err;
 }
 
+static bool ublk_ctrl_is_get_info2_cmd(unsigned int cmd_op)
+{
+	return cmd_op == UBLK_CMD_GET_DEV_INFO2 || cmd_op ==
+		UBLK_U_CMD_GET_DEV_INFO2;
+}
+
 static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
@@ -2099,7 +2111,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		 * know if the specified device is created as unprivileged
 		 * mode.
 		 */
-		if (cmd->cmd_op != UBLK_CMD_GET_DEV_INFO2)
+		if (!ublk_ctrl_is_get_info2_cmd(cmd->cmd_op))
 			return 0;
 	}
 
@@ -2130,6 +2142,10 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_GET_DEV_INFO2:
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 	case UBLK_CMD_GET_PARAMS:
+	case UBLK_U_CMD_GET_DEV_INFO:
+	case UBLK_U_CMD_GET_DEV_INFO2:
+	case UBLK_U_CMD_GET_QUEUE_AFFINITY:
+	case UBLK_U_CMD_GET_PARAMS:
 		mask = MAY_READ;
 		break;
 	case UBLK_CMD_START_DEV:
@@ -2139,6 +2155,13 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	case UBLK_CMD_SET_PARAMS:
 	case UBLK_CMD_START_USER_RECOVERY:
 	case UBLK_CMD_END_USER_RECOVERY:
+	case UBLK_U_CMD_START_DEV:
+	case UBLK_U_CMD_STOP_DEV:
+	case UBLK_U_CMD_ADD_DEV:
+	case UBLK_U_CMD_DEL_DEV:
+	case UBLK_U_CMD_SET_PARAMS:
+	case UBLK_U_CMD_START_USER_RECOVERY:
+	case UBLK_U_CMD_END_USER_RECOVERY:
 		mask = MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -2159,6 +2182,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	return ret;
 }
 
+static bool ublk_ctrl_is_add_cmd(unsigned int cmd_op)
+{
+	return cmd_op == UBLK_CMD_ADD_DEV || cmd_op == UBLK_U_CMD_ADD_DEV;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -2174,7 +2202,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (!(issue_flags & IO_URING_F_SQE128))
 		goto out;
 
-	if (cmd->cmd_op != UBLK_CMD_ADD_DEV) {
+	if (!ublk_ctrl_is_add_cmd(cmd->cmd_op)) {
 		ret = -ENODEV;
 		ub = ublk_get_device_from_id(header->dev_id);
 		if (!ub)
@@ -2191,34 +2219,45 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 
 	switch (cmd->cmd_op) {
 	case UBLK_CMD_START_DEV:
+	case UBLK_U_CMD_START_DEV:
 		ret = ublk_ctrl_start_dev(ub, cmd);
 		break;
 	case UBLK_CMD_STOP_DEV:
+	case UBLK_U_CMD_STOP_DEV:
 		ret = ublk_ctrl_stop_dev(ub);
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
+	case UBLK_U_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
+	case UBLK_U_CMD_GET_DEV_INFO2:
 		ret = ublk_ctrl_get_dev_info(ub, cmd);
 		break;
 	case UBLK_CMD_ADD_DEV:
+	case UBLK_U_CMD_ADD_DEV:
 		ret = ublk_ctrl_add_dev(cmd);
 		break;
 	case UBLK_CMD_DEL_DEV:
+	case UBLK_U_CMD_DEL_DEV:
 		ret = ublk_ctrl_del_dev(&ub);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
+	case UBLK_U_CMD_GET_QUEUE_AFFINITY:
 		ret = ublk_ctrl_get_queue_affinity(ub, cmd);
 		break;
 	case UBLK_CMD_GET_PARAMS:
+	case UBLK_U_CMD_GET_PARAMS:
 		ret = ublk_ctrl_get_params(ub, cmd);
 		break;
 	case UBLK_CMD_SET_PARAMS:
+	case UBLK_U_CMD_SET_PARAMS:
 		ret = ublk_ctrl_set_params(ub, cmd);
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
+	case UBLK_U_CMD_START_USER_RECOVERY:
 		ret = ublk_ctrl_start_recovery(ub, cmd);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
+	case UBLK_U_CMD_END_USER_RECOVERY:
 		ret = ublk_ctrl_end_recovery(ub, cmd);
 		break;
 	default:
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index f6238ccc7800..640bf687b94a 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -8,6 +8,9 @@
 
 /*
  * Admin commands, issued by ublk server, and handled by ublk driver.
+ *
+ * Legacy command definition, don't use in new application, and don't
+ * add new such definition any more
  */
 #define	UBLK_CMD_GET_QUEUE_AFFINITY	0x01
 #define	UBLK_CMD_GET_DEV_INFO	0x02
@@ -21,6 +24,30 @@
 #define	UBLK_CMD_END_USER_RECOVERY	0x11
 #define	UBLK_CMD_GET_DEV_INFO2		0x12
 
+/* Any new ctrl command should encode by __IO*() */
+#define UBLK_U_CMD_GET_QUEUE_AFFINITY	\
+	_IOR('u', UBLK_CMD_GET_QUEUE_AFFINITY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_DEV_INFO		\
+	_IOR('u', UBLK_CMD_GET_DEV_INFO, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_ADD_DEV		\
+	_IOWR('u', UBLK_CMD_ADD_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_DEL_DEV		\
+	_IOWR('u', UBLK_CMD_DEL_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_START_DEV		\
+	_IOWR('u', UBLK_CMD_START_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_STOP_DEV		\
+	_IOWR('u', UBLK_CMD_STOP_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_SET_PARAMS		\
+	_IOWR('u', UBLK_CMD_SET_PARAMS, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_PARAMS		\
+	_IOR('u', UBLK_CMD_GET_PARAMS, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_START_USER_RECOVERY	\
+	_IOWR('u', UBLK_CMD_START_USER_RECOVERY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_END_USER_RECOVERY	\
+	_IOWR('u', UBLK_CMD_END_USER_RECOVERY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_DEV_INFO2	\
+	_IOR('u', UBLK_CMD_GET_DEV_INFO2, struct ublksrv_ctrl_cmd)
+
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
  *
@@ -41,10 +68,23 @@
  *      It is only used if ublksrv set UBLK_F_NEED_GET_DATA flag
  *      while starting a ublk device.
  */
+
+/*
+ * Legacy IO command definition, don't use in new application, and don't
+ * add new such definition any more
+ */
 #define	UBLK_IO_FETCH_REQ		0x20
 #define	UBLK_IO_COMMIT_AND_FETCH_REQ	0x21
 #define	UBLK_IO_NEED_GET_DATA	0x22
 
+/* Any new IO command should encode by __IOWR() */
+#define	UBLK_U_IO_FETCH_REQ		\
+	_IOWR('u', UBLK_IO_FETCH_REQ, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_COMMIT_AND_FETCH_REQ	\
+	_IOWR('u', UBLK_IO_COMMIT_AND_FETCH_REQ, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_NEED_GET_DATA		\
+	_IOWR('u', UBLK_IO_NEED_GET_DATA, struct ublksrv_io_cmd)
+
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
 #define UBLK_IO_RES_NEED_GET_DATA	1
@@ -102,6 +142,9 @@
  */
 #define UBLK_F_UNPRIVILEGED_DEV	(1UL << 5)
 
+/* use ioctl encoding for uring command */
+#define UBLK_F_CMD_IOCTL_ENCODE	(1UL << 6)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.38.1

