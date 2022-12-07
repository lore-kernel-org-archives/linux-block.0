Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0888FC4708E
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 12:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLGMed (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLGMec (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 07:34:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE974EC3D
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 04:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670416417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rX4lVfZI/T11CYkxFLLIXrUgV/9OQzo2FXc1z3xf/Io=;
        b=f2u0NLzo21sqDYkddR8eKPz2eHnWoL+W75JwPmn7iJPBDUOa4tAGLF5wtjgPsONWVhPLLf
        VPXeQMjIKN90ZVhLy4knVekfQysPQ/7iyrOHaMFgB2knqA891IpmoTq3ow5/QRcwoDKRZL
        UZsPW0JjiXWZeVpG2zNzztaW9e3d1OQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-UDJBsMauMqumcBBMIYt8lw-1; Wed, 07 Dec 2022 07:33:36 -0500
X-MC-Unique: UDJBsMauMqumcBBMIYt8lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C8C686F12A;
        Wed,  7 Dec 2022 12:33:36 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F33EC15BA4;
        Wed,  7 Dec 2022 12:33:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/6] ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT
Date:   Wed,  7 Dec 2022 20:33:03 +0800
Message-Id: <20221207123305.937678-5-ming.lei@redhat.com>
In-Reply-To: <20221207123305.937678-1-ming.lei@redhat.com>
References: <20221207123305.937678-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Userspace side only knows device ID, but the associated path of ublkc* and
ublkb* could be changed by udev, and that depends on userspace's policy, so
add parameter of UBLK_PARAM_TYPE_DEVT for retrieving major/minor of the
ublkc* and ublkb*, then user may figure out major/minor of the ublk disks
he/she owns. With major/minor, it is easy to find the device node path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 24 +++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h | 13 +++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9d1578384cba..baea8933a3d9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -54,7 +54,8 @@
 		| UBLK_F_USER_RECOVERY_REISSUE)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
-#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
+#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
+		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
 
 struct ublk_rq_data {
 	struct llist_node node;
@@ -255,6 +256,10 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 	}
 
+	/* dev_t is read-only */
+	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1777,6 +1782,22 @@ static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
 	return 0;
 }
 
+/* TYPE_DEVT is readonly, so fill it up before returning to userspace */
+static void ublk_ctrl_fill_params_devt(struct ublk_device *ub)
+{
+	ub->params.devt.char_major = MAJOR(ub->cdev_dev.devt);
+	ub->params.devt.char_minor = MINOR(ub->cdev_dev.devt);
+
+	if (ub->ub_disk) {
+		ub->params.devt.disk_major = MAJOR(disk_devt(ub->ub_disk));
+		ub->params.devt.disk_minor = MINOR(disk_devt(ub->ub_disk));
+	} else {
+		ub->params.devt.disk_major = 0;
+		ub->params.devt.disk_minor = 0;
+	}
+	ub->params.types |= UBLK_PARAM_TYPE_DEVT;
+}
+
 static int ublk_ctrl_get_params(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
@@ -1798,6 +1819,7 @@ static int ublk_ctrl_get_params(struct ublk_device *ub,
 		ph.len = sizeof(struct ublk_params);
 
 	mutex_lock(&ub->mutex);
+	ublk_ctrl_fill_params_devt(ub);
 	if (copy_to_user(argp, &ub->params, ph.len))
 		ret = -EFAULT;
 	else
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 8f88e3a29998..4e38b9aa0293 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -214,6 +214,17 @@ struct ublk_param_discard {
 	__u16	reserved0;
 };
 
+/*
+ * read-only, can't set via UBLK_CMD_SET_PARAMS, disk_devt is available
+ * after device is started
+ */
+struct ublk_param_devt {
+	__u32   char_major;
+	__u32   char_minor;
+	__u32   disk_major;
+	__u32   disk_minor;
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -224,10 +235,12 @@ struct ublk_params {
 	__u32	len;
 #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
+#define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
+	struct ublk_param_devt		devt;
 };
 
 #endif
-- 
2.31.1

