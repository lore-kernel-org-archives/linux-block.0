Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E3AC7EE2F
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 07:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjEXHBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbjEXHBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 03:01:12 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C27E52
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 00:00:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684911649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7v8MjfGj91SztoHcp4d64pIJrJxL66wGoag9shwhdY=;
        b=Y00aI1fzX4F1VN68QC4exCrTiKZqk7hHV4YAwOP0qEJZ/Df/fnLeQJjYj51TRknS7S18aK
        Hj0cXpbX1+JOXssBiQwITMvaLfbQOdrludMWmsAKzWJYGKENPYznRDGD741zLJRjCQaVYF
        e7m5LCviDEqyf74v95JAeMLKdX4ouxI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 3/8] block/rnbd: introduce rnbd_access_modes
Date:   Wed, 24 May 2023 15:00:21 +0800
Message-Id: <20230524070026.2932-4-guoqing.jiang@linux.dev>
In-Reply-To: <20230524070026.2932-1-guoqing.jiang@linux.dev>
References: <20230524070026.2932-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one new array (marked with __maybe_unused to prevent gcc warning about
"defined but not used" with W=1), then we can remove rnbd_access_mode_str
and rnbd-common.c accordingly.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/Makefile         |  6 ++----
 drivers/block/rnbd/rnbd-clt-sysfs.c |  4 ++--
 drivers/block/rnbd/rnbd-common.c    | 23 -----------------------
 drivers/block/rnbd/rnbd-proto.h     |  9 +++++++++
 drivers/block/rnbd/rnbd-srv-sysfs.c |  2 +-
 drivers/block/rnbd/rnbd-srv.c       |  4 ++--
 6 files changed, 16 insertions(+), 32 deletions(-)
 delete mode 100644 drivers/block/rnbd/rnbd-common.c

diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
index 40b31630822c..208e5f865497 100644
--- a/drivers/block/rnbd/Makefile
+++ b/drivers/block/rnbd/Makefile
@@ -3,13 +3,11 @@
 ccflags-y := -I$(srctree)/drivers/infiniband/ulp/rtrs
 
 rnbd-client-y := rnbd-clt.o \
-		  rnbd-clt-sysfs.o \
-		  rnbd-common.o
+		  rnbd-clt-sysfs.o
 
 CFLAGS_rnbd-srv-trace.o = -I$(src)
 
-rnbd-server-y := rnbd-common.o \
-		  rnbd-srv.o \
+rnbd-server-y := rnbd-srv.o \
 		  rnbd-srv-sysfs.o \
 		  rnbd-srv-trace.o
 
diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 8c6087949794..a0b49a0c0bdd 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -278,7 +278,7 @@ static ssize_t access_mode_show(struct kobject *kobj,
 
 	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
 
-	return sysfs_emit(page, "%s\n", rnbd_access_mode_str(dev->access_mode));
+	return sysfs_emit(page, "%s\n", rnbd_access_modes[dev->access_mode].str);
 }
 
 static struct kobj_attribute rnbd_clt_access_mode =
@@ -596,7 +596,7 @@ static ssize_t rnbd_clt_map_device_store(struct kobject *kobj,
 
 	pr_info("Mapping device %s on session %s, (access_mode: %s, nr_poll_queues: %d)\n",
 		pathname, sessname,
-		rnbd_access_mode_str(access_mode),
+		rnbd_access_modes[access_mode].str,
 		nr_poll_queues);
 
 	dev = rnbd_clt_map_device(sessname, paths, path_cnt, port_nr, pathname,
diff --git a/drivers/block/rnbd/rnbd-common.c b/drivers/block/rnbd/rnbd-common.c
deleted file mode 100644
index 596c3f732403..000000000000
--- a/drivers/block/rnbd/rnbd-common.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * RDMA Network Block Driver
- *
- * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
- * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
- * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
- */
-#include "rnbd-proto.h"
-
-const char *rnbd_access_mode_str(enum rnbd_access_mode mode)
-{
-	switch (mode) {
-	case RNBD_ACCESS_RO:
-		return "ro";
-	case RNBD_ACCESS_RW:
-		return "rw";
-	case RNBD_ACCESS_MIGRATION:
-		return "migration";
-	default:
-		return "unknown";
-	}
-}
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index 84fd69844b7d..e32f8f2c868a 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -61,6 +61,15 @@ enum rnbd_access_mode {
 	RNBD_ACCESS_MIGRATION,
 };
 
+static const __maybe_unused struct {
+	enum rnbd_access_mode mode;
+	const char *str;
+} rnbd_access_modes[] = {
+	[RNBD_ACCESS_RO] = {RNBD_ACCESS_RO, "ro"},
+	[RNBD_ACCESS_RW] = {RNBD_ACCESS_RW, "rw"},
+	[RNBD_ACCESS_MIGRATION] = {RNBD_ACCESS_MIGRATION, "migration"},
+};
+
 /**
  * struct rnbd_msg_sess_info - initial session info from client to server
  * @hdr:		message header
diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 9fe7d9e0ab63..4962826e9639 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -103,7 +103,7 @@ static ssize_t access_mode_show(struct kobject *kobj,
 	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
 
 	return sysfs_emit(page, "%s\n",
-			  rnbd_access_mode_str(sess_dev->access_mode));
+			  rnbd_access_modes[sess_dev->access_mode].str);
 }
 
 static struct kobj_attribute rnbd_srv_dev_session_access_mode_attr =
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 2cfed2e58d64..e9ef6bd4b50c 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -483,7 +483,7 @@ static int rnbd_srv_check_update_open_perm(struct rnbd_srv_dev *srv_dev,
 			pr_err("Mapping device '%s' for session %s with RW permissions failed. Device already opened as 'RW' by %d client(s), access mode %s.\n",
 			       srv_dev->id, srv_sess->sessname,
 			       srv_dev->open_write_cnt,
-			       rnbd_access_mode_str(access_mode));
+			       rnbd_access_modes[access_mode].str);
 		}
 		break;
 	case RNBD_ACCESS_MIGRATION:
@@ -494,7 +494,7 @@ static int rnbd_srv_check_update_open_perm(struct rnbd_srv_dev *srv_dev,
 			pr_err("Mapping device '%s' for session %s with migration permissions failed. Device already opened as 'RW' by %d client(s), access mode %s.\n",
 			       srv_dev->id, srv_sess->sessname,
 			       srv_dev->open_write_cnt,
-			       rnbd_access_mode_str(access_mode));
+			       rnbd_access_modes[access_mode].str);
 		}
 		break;
 	default:
-- 
2.35.3

