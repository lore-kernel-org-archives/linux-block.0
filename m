Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A4EC433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 06:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiKPGKH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiKPGKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 01:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE695F4D
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 22:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668578945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYszUmguYIFu8/fSywhGU0/go/84rdKzZs43sAlqRgw=;
        b=XTZBtnO2zI4nSpxQxhph2yq624Y+1bTl9/BITzUtTVqnBJLrw8TvAsXgfGs30G0i60+NB2
        LqIAE2eTMK/wYUfpMYGl9Vr/wEIc2OcDShqrA+e3A4O0mZ7YgMk8tvdDaRwNATgrL5feDk
        wKe3CQN4HsAlkhaIz94dUcHJ8H0cQ+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-G1-pNwYsOtWFEMmvuwY4Sg-1; Wed, 16 Nov 2022 01:09:02 -0500
X-MC-Unique: G1-pNwYsOtWFEMmvuwY4Sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 577A8833AED;
        Wed, 16 Nov 2022 06:09:02 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AF791415114;
        Wed, 16 Nov 2022 06:09:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/6] ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT
Date:   Wed, 16 Nov 2022 14:08:33 +0800
Message-Id: <20221116060835.159945-5-ming.lei@redhat.com>
In-Reply-To: <20221116060835.159945-1-ming.lei@redhat.com>
References: <20221116060835.159945-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
index d987f76d436f..d047b26c1e93 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -54,7 +54,8 @@
 		| UBLK_F_USER_RECOVERY_REISSUE)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
-#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
+#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
+		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
 
 struct ublk_rq_data {
 	union {
@@ -258,6 +259,10 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 	}
 
+	/* dev_t is read-only */
+	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
+		WARN_ON_ONCE(1);
+
 	return 0;
 }
 
@@ -1787,6 +1792,22 @@ static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
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
@@ -1808,6 +1829,7 @@ static int ublk_ctrl_get_params(struct ublk_device *ub,
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

