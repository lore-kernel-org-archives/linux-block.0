Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0054C43331
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8756964F57
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhCDRPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Mar 2021 12:15:00 -0500
Received: from mx4.veeam.com ([104.41.138.86]:54496 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231374AbhCDROf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Mar 2021 12:14:35 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 354FE114A94;
        Thu,  4 Mar 2021 20:13:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1614878032; bh=TYaXRqDRCEs2PMBaoiW/qVmPuFZVeQxVq43GzQdhb/o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=NNS50koujeOmLv8ytRwRnkDk+8Dj3tIXlG34BNdzZs6izVoTx63w65e9eR7+pazYP
         xkRXe5e/cxbvHVtu82NyhWSvSm4tD82EM9mvGH/qUf8Zd/w8qB6yf/JQDCpLpVGte3
         ZUC8oaZTlDkOLDwd6NJrCdIzAWvchLWLLe4fvj9k=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 4 Mar 2021 18:13:50 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <snitzer@redhat.com>, <agk@redhat.com>, <hare@suse.de>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH 1/1] dm: adds an IOCTL to work with device-filters
Date:   Thu, 4 Mar 2021 20:13:38 +0300
Message-ID: <1614878018-23278-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614878018-23278-1-git-send-email-sergei.shtepa@veeam.com>
References: <1614878018-23278-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58637265
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The four simplest IOCTL's allow to create new filters, remove them
and pass control commands specific to each target.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/Makefile           |  2 +-
 drivers/md/dm-ioctl.c         | 22 ++++++++++++++++++++++
 drivers/md/flt-ctl.c          | 25 +++++++++++++++++++++++++
 drivers/md/flt-ctl.h          | 10 ++++++++++
 include/uapi/linux/dm-ioctl.h | 18 ++++++++++++++++--
 5 files changed, 74 insertions(+), 3 deletions(-)
 create mode 100644 drivers/md/flt-ctl.c
 create mode 100644 drivers/md/flt-ctl.h

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index bd5b38bee82e..1b650950adc1 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -5,7 +5,7 @@
 
 dm-mod-y	+= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
 		   dm-ioctl.o dm-io.o dm-kcopyd.o dm-sysfs.o dm-stats.o \
-		   dm-rq.o dm-interposer.o
+		   dm-rq.o dm-interposer.o flt-ctl.o
 dm-multipath-y	+= dm-path-selector.o dm-mpath.o
 dm-historical-service-time-y += dm-ps-historical-service-time.o
 dm-io-affinity-y += dm-ps-io-affinity.o
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 2bcb316144a1..f5f0c9377752 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -6,6 +6,7 @@
  */
 
 #include "dm-core.h"
+#include "flt-control.h"
 
 #include <linux/module.h>
 #include <linux/vmalloc.h>
@@ -1700,6 +1701,27 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
 		{DM_GET_TARGET_VERSION, 0, get_target_version},
 	};
 
+	static const struct {
+		int cmd;
+		int flags;
+		ioctl_fn fn;
+	} _flt_ioctls[] = {
+		{FLT_REMOVE_ALL_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, filter_remove_all},
+		{FLT_CREATE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, filter_create},
+		{FLT_REMOVE_CMD, IOCTL_FLAGS_NO_PARAMS | IOCTL_FLAGS_ISSUE_GLOBAL_EVENT, filter_remove},
+		{FLT_CONTROL_CMD, 0, filter_control},
+	};
+
+	if (cmd >= DM_FILTER_CMD) {
+		cmd -= DM_FILTER_CMD;
+
+		if (unlikely(cmd >= ARRAY_SIZE(_flt_ioctls)))
+			return NULL;
+
+		*ioctl_flags = _flt_ioctls[cmd].flags;
+		return _flt_ioctls[cmd].fn;
+	}
+
 	if (unlikely(cmd >= ARRAY_SIZE(_ioctls)))
 		return NULL;
 
diff --git a/drivers/md/flt-ctl.c b/drivers/md/flt-ctl.c
new file mode 100644
index 000000000000..aadf04be1438
--- /dev/null
+++ b/drivers/md/flt-ctl.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/dm-ioctl.h>
+
+#include "flt-ctl.h"
+
+int filter_remove_all(struct file *filp, struct dm_ioctl *param, size_t param_size)
+{
+	return 0;
+};
+int filter_create(struct file *filp, struct dm_ioctl *param, size_t param_size)
+{
+	return 0;
+};
+int filter_remove(struct file *filp, struct dm_ioctl *param, size_t param_size)
+{
+	return 0;
+};
+int filter_control(struct file *filp, struct dm_ioctl *param, size_t param_size)
+{
+	return 0;
+};
+
diff --git a/drivers/md/flt-ctl.h b/drivers/md/flt-ctl.h
new file mode 100644
index 000000000000..61a80184abae
--- /dev/null
+++ b/drivers/md/flt-ctl.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
+#ifndef FLT_CTL_H
+#define FLT_CTL_H
+
+int filter_remove_all(struct file *filp, struct dm_ioctl *param, size_t param_size);
+int filter_create(struct file *filp, struct dm_ioctl *param, size_t param_size);
+int filter_remove(struct file *filp, struct dm_ioctl *param, size_t param_size);
+int filter_control(struct file *filp, struct dm_ioctl *param, size_t param_size);
+
+#endif
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index e942e7d7c594..012e16761ba9 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -16,6 +16,7 @@
 #define DM_MAX_TYPE_NAME 16
 #define DM_NAME_LEN 128
 #define DM_UUID_LEN 129
+#define DM_FILTER_CMD 128	/* First filters command */
 
 /*
  * A traditional ioctl interface for the device mapper.
@@ -244,6 +245,14 @@ enum {
 	DM_DEV_SET_GEOMETRY_CMD,
 	DM_DEV_ARM_POLL_CMD,
 	DM_GET_TARGET_VERSION_CMD,
+
+	/* Reserved space for additional DM ioctl */
+
+	/* Filters commands */
+	FLT_REMOVE_ALL_CMD = DM_FILTER_CMD, /* Cleanup all filters */
+	FLT_CREATE_CMD,		/* Create new filter */
+	FLT_REMOVE_CMD,		/* Remove filter */
+	FLT_CONTROL_CMD,	/* Send a filter-specific command */
 };
 
 #define DM_IOCTL 0xfd
@@ -271,10 +280,15 @@ enum {
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
+#define FLT_REMOVE_ALL   _IOWR(DM_IOCTL, FLT_REMOVE_ALL_CMD, struct dm_ioctl)
+#define FLT_CREATE       _IOWR(DM_IOCTL, FLT_CREATE_CMD, struct dm_ioctl)
+#define FLT_REMOVE       _IOWR(DM_IOCTL, FLT_REMOVE_CMD, struct dm_ioctl)
+#define FLT_CONTROL      _IOWR(DM_IOCTL, FLT_CONTROL_CMD, struct dm_ioctl)
+
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	43
+#define DM_VERSION_MINOR	44
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2020-10-01)"
+#define DM_VERSION_EXTRA	"-ioctl (2021-03-03)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
-- 
2.20.1

