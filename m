Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEB6C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 13:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjDRNTG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 09:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjDRNTC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 09:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCAE4C
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681823902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V7MLqWJdztOCzpM6chr//3Asr+og95+otUwQDD6cuGM=;
        b=dk5S0crfqjf5qyNFK3hOZPU0GfGOFmQuLhasZzHGRhZFo50anz4+Im1Lv8M8N4TycObAhM
        sBCPlEIylfamXfSpVQCl5SIUNL3LiH+nThVzLYL0kacKKLide5nhic6+Qf2xBORUrPkMgv
        EZnmjQhtFPD3P3+D075bPPsjp+VzLJE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-joK3DDLMPtCc6EhJ7zDJPA-1; Tue, 18 Apr 2023 09:18:17 -0400
X-MC-Unique: joK3DDLMPtCc6EhJ7zDJPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 009812999B35;
        Tue, 18 Apr 2023 13:18:17 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D48F910DF8;
        Tue, 18 Apr 2023 13:18:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH V3] block: ublk: switch to ioctl command encoding
Date:   Tue, 18 Apr 2023 21:18:10 +0800
Message-Id: <20230418131810.855959-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All ublk commands(control, IO) should have taken ioctl command encoding
from the beginning, because ioctl command encoding defines each code
uniquely, so driver can figure out wrong command sent from userspace
easily; 2) it might help security subsystem for audit uring cmd[1].

Unfortunately we didn't do that way, and it could be one lesson for
ublk driver.

So switch to ioctl command encoding now, we still support commands encoded
in old way, but they become legacy definition. Any new command should take
ioctl encoding.

See ublksrv code for switching to ioctl command encoding in [2].

[1] https://lore.kernel.org/io-uring/CAHC9VhSVzujW9LOj5Km80AjU0EfAuukoLrxO6BEfnXeK_s6bAg@mail.gmail.com/
[2] https://github.com/ming1/ubdsrv/commits/ioctl_cmd_encoding

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ken Kurematsu <k.kurematsu@nskint.co.jp>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- rename config option to BLKDEV_UBLK_LEGACY_OPCODES, suggested by
	  Christoph
	- add helper of ublk_check_cmd_op()
	- commit log style & patch style change
V2:
	- simplify implementation
	- add config option of BLK_DEV_UBLK_NO_OLD_CMD, suggested by Christoph
	- improve commit log, and fix typo

 drivers/block/Kconfig         | 17 +++++++++++++
 drivers/block/ublk_drv.c      | 47 +++++++++++++++++++++++++----------
 include/uapi/linux/ublk_cmd.h | 43 ++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index f79f20430ef7..5b9d4aaebb81 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -385,6 +385,23 @@ config BLK_DEV_UBLK
 	  can handle batch more effectively, but task_work_add() isn't exported
 	  for module, so ublk has to be built to kernel.
 
+config BLKDEV_UBLK_LEGACY_OPCODES
+	bool "Support legacy command opcode"
+	depends on BLK_DEV_UBLK
+	default y
+	help
+	  ublk driver started to take plain command encoding, which turns out
+	  one bad way. The traditional ioctl command opcode encodes more
+	  info and basically defines each code uniquely, so opcode conflict
+	  is avoided, and driver can handle wrong command easily, meantime it
+	  may help security subsystem to audit io_uring command.
+
+	  Say Y if your application still uses legacy command opcode.
+
+	  Say N if you don't want to support legacy command opcode. It is
+	  suggested to enable N if your application(ublk server) switches to
+	  ioctl command encoding.
+
 source "drivers/block/rnbd/Kconfig"
 
 endif # BLK_DEV
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1223fcbfc6c9..5da5876a4443 100644
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
@@ -1253,6 +1254,19 @@ static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
 	ublk_queue_cmd(ubq, req);
 }
 
+static inline int ublk_check_cmd_op(u32 cmd_op)
+{
+	u32 ioc_type = _IOC_TYPE(cmd_op);
+
+	if (IS_ENABLED(CONFIG_BLKDEV_UBLK_LEGACY_OPCODES) && ioc_type != 'u')
+		return -EOPNOTSUPP;
+
+	if (ioc_type != 'u' && ioc_type != 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
@@ -1294,10 +1308,14 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
 	 */
 	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
-			^ (cmd_op == UBLK_IO_NEED_GET_DATA))
+			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
+		goto out;
+
+	ret = ublk_check_cmd_op(cmd_op);
+	if (ret)
 		goto out;
 
-	switch (cmd_op) {
+	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
@@ -1743,6 +1761,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
 		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
 
+	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
@@ -2099,7 +2119,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		 * know if the specified device is created as unprivileged
 		 * mode.
 		 */
-		if (cmd->cmd_op != UBLK_CMD_GET_DEV_INFO2)
+		if (_IOC_NR(cmd->cmd_op) != UBLK_CMD_GET_DEV_INFO2)
 			return 0;
 	}
 
@@ -2125,7 +2145,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 	dev_path[header->dev_path_len] = 0;
 
 	ret = -EINVAL;
-	switch (cmd->cmd_op) {
+	switch (_IOC_NR(cmd->cmd_op)) {
 	case UBLK_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
@@ -2164,6 +2184,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 {
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	struct ublk_device *ub = NULL;
+	u32 cmd_op = cmd->cmd_op;
 	int ret = -EINVAL;
 
 	if (issue_flags & IO_URING_F_NONBLOCK)
@@ -2174,22 +2195,22 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (!(issue_flags & IO_URING_F_SQE128))
 		goto out;
 
-	if (cmd->cmd_op != UBLK_CMD_ADD_DEV) {
+	ret = ublk_check_cmd_op(cmd_op);
+	if (ret)
+		goto out;
+
+	if (_IOC_NR(cmd_op) != UBLK_CMD_ADD_DEV) {
 		ret = -ENODEV;
 		ub = ublk_get_device_from_id(header->dev_id);
 		if (!ub)
 			goto out;
 
 		ret = ublk_ctrl_uring_cmd_permission(ub, cmd);
-	} else {
-		/* ADD_DEV permission check is done in command handler */
-		ret = 0;
+		if (ret)
+			goto put_dev;
 	}
 
-	if (ret)
-		goto put_dev;
-
-	switch (cmd->cmd_op) {
+	switch (_IOC_NR(cmd_op)) {
 	case UBLK_CMD_START_DEV:
 		ret = ublk_ctrl_start_dev(ub, cmd);
 		break;
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

