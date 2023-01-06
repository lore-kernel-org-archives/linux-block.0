Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFEC3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 04:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjAFETL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 23:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjAFESc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 23:18:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC81918393
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 20:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672978666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3D5U0CLcOV84s7r1R8hKlqth6LgR+sTNa9vWYhEUYs=;
        b=cT9HyAdI+yBIv2zk7VJvAmW3uB2KhmgRlmYtBSu+jJ63Gz1KDCYNZaygD0v0N46wJm2rpd
        NLbOxx/PTe+Zw/4xWriK5EhqcRYcJpdU/zxYFZq6bIWktYfLkFKHAr4mTPxOUTdKE4ItHp
        TeIhsGVqlr0xjBNbRR6g6EStOWFQLoc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-0xBScYi5OCSa5FQRMagzxA-1; Thu, 05 Jan 2023 23:17:44 -0500
X-MC-Unique: 0xBScYi5OCSa5FQRMagzxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07FF03C00089;
        Fri,  6 Jan 2023 04:17:44 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A722640C2064;
        Fri,  6 Jan 2023 04:17:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 6/6] ublk_drv: add mechanism for supporting unprivileged ublk device
Date:   Fri,  6 Jan 2023 12:17:11 +0800
Message-Id: <20230106041711.914434-7-ming.lei@redhat.com>
In-Reply-To: <20230106041711.914434-1-ming.lei@redhat.com>
References: <20230106041711.914434-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

unprivileged ublk device is helpful for container use case, such
as: ublk device created in one unprivileged container can be controlled
and accessed by this container only.

Implement this feature by adding flag of UBLK_F_UNPRIVILEGED_DEV, and if
this flag isn't set, any control command has been run from privileged
user. Otherwise, any control command can be sent from any unprivileged
user, but the user has to be permitted to access the ublk char device
to be controlled.

In case of UBLK_F_UNPRIVILEGED_DEV:

1) for command UBLK_CMD_ADD_DEV, it is always allowed, and user needs
to provide owner's uid/gid in this command, so that udev can set correct
ownership for the created ublk device, since the device owner uid/gid
can be queried via command of UBLK_CMD_GET_DEV_INFO.

2) for other control commands, they can only be run successfully if the
current user is allowed to access the specified ublk char device, for
running the permission check, path of the ublk char device has to be
provided by these commands.

Also add one control of command UBLK_CMD_GET_DEV_INFO2 which always
include the char dev path in payload since userspace may not have
knowledge if this device is created in unprivileged mode.

For applying this mechanism, system administrator needs to take
the following policies:

1) chmod 0666 /dev/ublk-control

2) change ownership of ublkcN & ublkbN
- chown owner_uid:owner_gid /dev/ublkcN
- chown owner_uid:owner_gid /dev/ublkbN

Both can be done via one simple udev rule.

Userspace:

	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk

'ublk add -t $TYPE --un_privileged=1' is for creating one un-privileged
ublk device if the user is un-privileged.

Link: https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst  |  49 +++++++++--
 drivers/block/ublk_drv.c      | 152 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  36 +++++++-
 3 files changed, 220 insertions(+), 17 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index ba45c46cc0da..2916fcf3ab44 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -144,6 +144,37 @@ managing and controlling ublk devices with help of several control commands:
   For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the server's
   responsibility to save IO target specific info in userspace.
 
+- ``UBLK_CMD_GET_DEV_INFO2``
+  Same purpose with ``UBLK_CMD_GET_DEV_INFO``, but ublk server has to
+  provide path of the char device of ``/dev/ublkc*`` for kernel to run
+  permission check, and this command is added for supporting unprivileged
+  ublk device, and introduced with ``UBLK_F_UNPRIVILEGED_DEV`` together.
+  Only the user owning the requested device can retrieve the device info.
+
+  How to deal with userspace/kernel compatibility:
+
+  1) if kernel is capable of handling ``UBLK_F_UNPRIVILEGED_DEV``
+    If ublk server supports ``UBLK_F_UNPRIVILEGED_DEV``:
+    ublk server should send ``UBLK_CMD_GET_DEV_INFO2``, given anytime
+    unprivileged application needs to query devices the current user owns,
+    when the application has no idea if ``UBLK_F_UNPRIVILEGED_DEV`` is set
+    given the capability info is stateless, and application should always
+    retrieve it via ``UBLK_CMD_GET_DEV_INFO2``
+
+    If ublk server doesn't support ``UBLK_F_UNPRIVILEGED_DEV``:
+    ``UBLK_CMD_GET_DEV_INFO`` is always sent to kernel, and the feature of
+    UBLK_F_UNPRIVILEGED_DEV isn't available for user
+
+  2) if kernel isn't capable of handling ``UBLK_F_UNPRIVILEGED_DEV``
+    If ublk server supports ``UBLK_F_UNPRIVILEGED_DEV``:
+    ``UBLK_CMD_GET_DEV_INFO2`` is tried first, and will be failed, then
+    ``UBLK_CMD_GET_DEV_INFO`` needs to be retried given
+    ``UBLK_F_UNPRIVILEGED_DEV`` can't be set
+
+    If ublk server doesn't support ``UBLK_F_UNPRIVILEGED_DEV``:
+    ``UBLK_CMD_GET_DEV_INFO`` is always sent to kernel, and the feature of
+    ``UBLK_F_UNPRIVILEGED_DEV`` isn't available for user
+
 - ``UBLK_CMD_START_USER_RECOVERY``
 
   This command is valid if ``UBLK_F_USER_RECOVERY`` feature is enabled. This
@@ -180,6 +211,15 @@ managing and controlling ublk devices with help of several control commands:
   double-write since the driver may issue the same I/O request twice. It
   might be useful to a read-only FS or a VM backend.
 
+Unprivileged ublk device is supported by passing ``UBLK_F_UNPRIVILEGED_DEV``.
+Once the flag is set, all control commands can be sent by unprivileged
+user. Except for command of ``UBLK_CMD_ADD_DEV``, permission check on
+the specified char device(``/dev/ublkc*``) is done for all other control
+commands by ublk driver, for doing that, path of the char device has to
+be provided in these commands' payload from ublk server. With this way,
+ublk device becomes container-ware, and device created in one container
+can be controlled/accessed just inside this container.
+
 Data plane
 ----------
 
@@ -254,15 +294,6 @@ with specified IO tag in the command data:
 Future development
 ==================
 
-Container-aware ublk deivice
-----------------------------
-
-ublk driver doesn't handle any IO logic. Its function is well defined
-for now and very limited userspace interfaces are needed, which is also
-well defined too. It is possible to make ublk devices container-aware block
-devices in future as Stefan Hajnoczi suggested [#stefan]_, by removing
-ADMIN privilege.
-
 Zero copy
 ---------
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 399137008e25..9f32553cb938 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -42,6 +42,7 @@
 #include <linux/mm.h>
 #include <asm/page.h>
 #include <linux/task_work.h>
+#include <linux/namei.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
@@ -51,7 +52,8 @@
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
 		| UBLK_F_NEED_GET_DATA \
 		| UBLK_F_USER_RECOVERY \
-		| UBLK_F_USER_RECOVERY_REISSUE)
+		| UBLK_F_USER_RECOVERY_REISSUE \
+		| UBLK_F_UNPRIVILEGED_DEV)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
@@ -1618,6 +1620,17 @@ static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
 	return ret;
 }
 
+static void ublk_store_owner_uid_gid(struct ublksrv_ctrl_dev_info *info)
+{
+	kuid_t uid;
+	kgid_t gid;
+
+	current_uid_gid(&uid, &gid);
+
+	info->owner_uid = from_kuid(&init_user_ns, uid);
+	info->owner_gid = from_kgid(&init_user_ns, gid);
+}
+
 static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 {
 	pr_devel("%s: dev id %d flags %llx\n", __func__,
@@ -1641,15 +1654,26 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 			__func__, header->queue_id);
 		return -EINVAL;
 	}
+
 	if (copy_from_user(&info, argp, sizeof(info)))
 		return -EFAULT;
-	ublk_dump_dev_info(&info);
+
+	if (capable(CAP_SYS_ADMIN))
+		info.flags &= ~UBLK_F_UNPRIVILEGED_DEV;
+	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))
+		return -EPERM;
+
+	/* the created device is always owned by current user */
+	ublk_store_owner_uid_gid(&info);
+
 	if (header->dev_id != info.dev_id) {
 		pr_warn("%s: dev id not match %u %u\n",
 			__func__, header->dev_id, info.dev_id);
 		return -EINVAL;
 	}
 
+	ublk_dump_dev_info(&info);
+
 	ret = mutex_lock_killable(&ublk_ctl_mutex);
 	if (ret)
 		return ret;
@@ -1982,6 +2006,115 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	return ret;
 }
 
+/*
+ * All control commands are sent via /dev/ublk-control, so we have to check
+ * the destination device's permission
+ */
+static int ublk_char_dev_permission(struct ublk_device *ub,
+		const char *dev_path, int mask)
+{
+	int err;
+	struct path path;
+	struct kstat stat;
+
+	err = kern_path(dev_path, LOOKUP_FOLLOW, &path);
+	if (err)
+		return err;
+
+	err = vfs_getattr(&path, &stat, STATX_TYPE, AT_STATX_SYNC_AS_STAT);
+	if (err)
+		goto exit;
+
+	err = -EPERM;
+	if (stat.rdev != ub->cdev_dev.devt || !S_ISCHR(stat.mode))
+		goto exit;
+
+	err = inode_permission(&init_user_ns,
+			d_backing_inode(path.dentry), mask);
+exit:
+	path_put(&path);
+	return err;
+}
+
+static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
+		struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
+	void __user *argp = (void __user *)(unsigned long)header->addr;
+	char *dev_path = NULL;
+	int ret = 0;
+	int mask;
+
+	if (!unprivileged) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		/*
+		 * The new added command of UBLK_CMD_GET_DEV_INFO2 includes
+		 * char_dev_path in payload too, since userspace may not
+		 * know if the specified device is created as unprivileged
+		 * mode.
+		 */
+		if (cmd->cmd_op != UBLK_CMD_GET_DEV_INFO2)
+			return 0;
+	}
+
+	/*
+	 * User has to provide the char device path for unprivileged ublk
+	 *
+	 * header->addr always points to the dev path buffer, and
+	 * header->dev_path_len records length of dev path buffer.
+	 */
+	if (!header->dev_path_len || header->dev_path_len > PATH_MAX)
+		return -EINVAL;
+
+	if (header->len < header->dev_path_len)
+		return -EINVAL;
+
+	dev_path = kmalloc(header->dev_path_len + 1, GFP_KERNEL);
+	if (!dev_path)
+		return -ENOMEM;
+
+	ret = -EFAULT;
+	if (copy_from_user(dev_path, argp, header->dev_path_len))
+		goto exit;
+	dev_path[header->dev_path_len] = 0;
+
+	ret = -EINVAL;
+	switch (cmd->cmd_op) {
+	case UBLK_CMD_GET_DEV_INFO:
+	case UBLK_CMD_GET_DEV_INFO2:
+	case UBLK_CMD_GET_QUEUE_AFFINITY:
+	case UBLK_CMD_GET_PARAMS:
+		mask = MAY_READ;
+		break;
+	case UBLK_CMD_START_DEV:
+	case UBLK_CMD_STOP_DEV:
+	case UBLK_CMD_ADD_DEV:
+	case UBLK_CMD_DEL_DEV:
+	case UBLK_CMD_SET_PARAMS:
+	case UBLK_CMD_START_USER_RECOVERY:
+	case UBLK_CMD_END_USER_RECOVERY:
+		mask = MAY_READ | MAY_WRITE;
+		break;
+	default:
+		goto exit;
+	}
+
+	ret = ublk_char_dev_permission(ub, dev_path, mask);
+	if (!ret) {
+		header->len -= header->dev_path_len;
+		header->addr += header->dev_path_len;
+	}
+	pr_devel("%s: dev id %d cmd_op %x uid %d gid %d path %s ret %d\n",
+			__func__, ub->ub_number, cmd->cmd_op,
+			ub->dev_info.owner_uid, ub->dev_info.owner_gid,
+			dev_path, ret);
+exit:
+	kfree(dev_path);
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -1997,17 +2130,21 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	if (!(issue_flags & IO_URING_F_SQE128))
 		goto out;
 
-	ret = -EPERM;
-	if (!capable(CAP_SYS_ADMIN))
-		goto out;
-
 	if (cmd->cmd_op != UBLK_CMD_ADD_DEV) {
 		ret = -ENODEV;
 		ub = ublk_get_device_from_id(header->dev_id);
 		if (!ub)
 			goto out;
+
+		ret = ublk_ctrl_uring_cmd_permission(ub, cmd);
+	} else {
+		/* ADD_DEV permission check is done in command handler */
+		ret = 0;
 	}
 
+	if (ret)
+		goto put_dev;
+
 	switch (cmd->cmd_op) {
 	case UBLK_CMD_START_DEV:
 		ret = ublk_ctrl_start_dev(ub, cmd);
@@ -2016,6 +2153,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_stop_dev(ub);
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
+	case UBLK_CMD_GET_DEV_INFO2:
 		ret = ublk_ctrl_get_dev_info(ub, cmd);
 		break;
 	case UBLK_CMD_ADD_DEV:
@@ -2043,6 +2181,8 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = -ENOTSUPP;
 		break;
 	}
+
+ put_dev:
 	if (ub)
 		ublk_put_device(ub);
  out:
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4e38b9aa0293..f6238ccc7800 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -19,6 +19,8 @@
 #define	UBLK_CMD_GET_PARAMS	0x09
 #define	UBLK_CMD_START_USER_RECOVERY	0x10
 #define	UBLK_CMD_END_USER_RECOVERY	0x11
+#define	UBLK_CMD_GET_DEV_INFO2		0x12
+
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
  *
@@ -79,6 +81,27 @@
 
 #define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
 
+/*
+ * Unprivileged user can create /dev/ublkcN and /dev/ublkbN.
+ *
+ * /dev/ublk-control needs to be available for unprivileged user, and it
+ * can be done via udev rule to make all control commands available to
+ * unprivileged user. Except for the command of UBLK_CMD_ADD_DEV, all
+ * other commands are only allowed for the owner of the specified device.
+ *
+ * When userspace sends UBLK_CMD_ADD_DEV, the device pair's owner_uid and
+ * owner_gid are stored to ublksrv_ctrl_dev_info by kernel, so far only
+ * the current user's uid/gid is stored, that said owner of the created
+ * device is always the current user.
+ *
+ * We still need udev rule to apply OWNER/GROUP with the stored owner_uid
+ * and owner_gid.
+ *
+ * Then ublk server can be run as unprivileged user, and /dev/ublkbN can
+ * be accessed and managed by its owner represented by owner_uid/owner_gid.
+ */
+#define UBLK_F_UNPRIVILEGED_DEV	(1UL << 5)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -98,7 +121,15 @@ struct ublksrv_ctrl_cmd {
 	__u64	addr;
 
 	/* inline data */
-	__u64	data[2];
+	__u64	data[1];
+
+	/*
+	 * Used for UBLK_F_UNPRIVILEGED_DEV and UBLK_CMD_GET_DEV_INFO2
+	 * only, include null char
+	 */
+	__u16	dev_path_len;
+	__u16	pad;
+	__u32	reserved;
 };
 
 struct ublksrv_ctrl_dev_info {
@@ -118,7 +149,8 @@ struct ublksrv_ctrl_dev_info {
 	/* For ublksrv internal use, invisible to ublk driver */
 	__u64	ublksrv_flags;
 
-	__u64	reserved0;
+	__u32	owner_uid;	/* store by kernel */
+	__u32	owner_gid;	/* store by kernel */
 	__u64	reserved1;
 	__u64   reserved2;
 };
-- 
2.31.1

