Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10459C43461
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD912613C8
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhDFHhw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbhDFHhw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:37:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA2C061756
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:37:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w18so15373437edc.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TG89SZIrs0KKRkA5XEHBYrgFgHV8NhOXzaK1y2WVdgI=;
        b=g7SswaiMoAYQVNxOsU++aZMIKT954cdj9F0NkBk74HSBQUJy+tc3/KU88Md7OXv6mV
         aIY5k/jLyZ3jR8FvYY/le+Y5y17/Fo1Al3XfA3Nhr7WYtsWczagKJApo3hQS8F98LpOu
         xq4sZZjYMz+wlEOYXiJhgw+VT/3oUun85/TGvWStVsigeY322PZ13lVuBPvWcy19NQoa
         5azhMm+M3oNPkjQi21fw0/F0QFleHVXEYs5xEEY1q4eEpOs2DVjzdb6ArpS11MMRWgzd
         fHVT43MCzYC5+3JZM3v20HlfdnG0y/XI362PuD4VmibGaGcBlc/QxPGHovUXBR8Ail8h
         F6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TG89SZIrs0KKRkA5XEHBYrgFgHV8NhOXzaK1y2WVdgI=;
        b=Bh6C4ntIkMHR3SpDp+4/p4Rffu/fH+QXSY6nA3XsiszVWorB5ENITmhPrhYFxTtRr2
         eUvuijXR4KS+cR7M4lm5JrN8MQzizbQ7W/35nNJPSmUo8MkDk9CN7bUDSLewT5uruOv1
         8AySz+Zzd1yvO9rc0MXJO47bJkA8FwYwRBuSxPz0/j059U0vlUz5tokBz3uC4eotgDBy
         II9/C3/OfHMbUgQa4qiwuWNtG34CguYsSiz9cWPhAXLPIF7+DRUhzUBkOxsKl5jDhMAs
         pdVO0hv7+YpTqUtwR7332CulLyIMpM4rehhg/8m5WnOT2U8fKa7pGxUlbzfe//vrS3+o
         h5Yw==
X-Gm-Message-State: AOAM532Roqu6KlDs8vhkiF+ug05rI7yYwRmqRgT6LX0tNxWA7RKG8ANX
        0xoScCE2+MCUkN1i1ccZjkx7QCBOpAehqjmt
X-Google-Smtp-Source: ABdhPJzdZrjkmBpN0UK7ErVBqZEz6sJ5ZFGWHnI8UjN+JggokBpipWt1Q1glNal9DPVQ95w3Cymt0A==
X-Received: by 2002:a50:fa0d:: with SMTP id b13mr9063791edq.354.1617694663095;
        Tue, 06 Apr 2021 00:37:43 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id o6sm12843305edw.24.2021.04.06.00.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:37:42 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-next 1/5] block/rnbd: Enable the fault-injection
Date:   Tue,  6 Apr 2021 09:37:23 +0200
Message-Id: <20210406073727.172380-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406073727.172380-1-gi-oh.kim@ionos.com>
References: <20210406073727.172380-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

This patch introduces functions to enable the fault-injection for RNBD.
* rnbd_fault_inject_init/final: initialize the fault-injection
and create a debugfs directory.
* rnbd_fault_inject_add: create a debugfs entry to enable
the fault-injection point.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-common.c | 44 ++++++++++++++++++++++++++++++++
 drivers/block/rnbd/rnbd-proto.h  | 14 ++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/block/rnbd/rnbd-common.c b/drivers/block/rnbd/rnbd-common.c
index 596c3f732403..84bfbf015f6d 100644
--- a/drivers/block/rnbd/rnbd-common.c
+++ b/drivers/block/rnbd/rnbd-common.c
@@ -21,3 +21,47 @@ const char *rnbd_access_mode_str(enum rnbd_access_mode mode)
 		return "unknown";
 	}
 }
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+static DECLARE_FAULT_ATTR(fail_default_attr);
+
+void rnbd_fault_inject_init(struct rnbd_fault_inject *fj,
+			    const char *dir_name,
+			    u32 err_status)
+{
+	struct dentry *dir, *parent;
+	struct fault_attr *attr = &fj->attr;
+
+	/* create debugfs directory and attribute */
+	parent = debugfs_create_dir(dir_name, NULL);
+	if (!parent) {
+		pr_warn("%s: failed to create debugfs directory\n", dir_name);
+		return;
+	}
+
+	*attr = fail_default_attr;
+	dir = fault_create_debugfs_attr("fault_inject", parent, attr);
+	if (IS_ERR(dir)) {
+		pr_warn("%s: failed to create debugfs attr\n", dir_name);
+		debugfs_remove_recursive(parent);
+		return;
+	}
+	fj->parent = parent;
+	fj->dir = dir;
+
+	/* create debugfs for status code */
+	fj->status = err_status;
+	debugfs_create_u32("status", 0600, dir,	&fj->status);
+}
+
+void rnbd_fault_inject_add(struct dentry *dir, const char *fname, bool *value)
+{
+	debugfs_create_bool(fname, 0600, dir, value);
+}
+
+void rnbd_fault_inject_final(struct rnbd_fault_inject *fj)
+{
+	/* remove debugfs directories */
+	debugfs_remove_recursive(fj->parent);
+}
+#endif
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index c1bc5c0fef71..d13dc1d3a00e 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -15,6 +15,7 @@
 #include <linux/inet.h>
 #include <linux/in.h>
 #include <linux/in6.h>
+#include <linux/fault-inject.h>
 #include <rdma/ib.h>
 
 #define RNBD_PROTO_VER_MAJOR 2
@@ -305,6 +306,19 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 	return rnbd_opf;
 }
 
+struct rnbd_fault_inject {
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	struct fault_attr attr;
+	struct dentry *parent;
+	struct dentry *dir;
+	u32 status;
+#endif
+};
+
 const char *rnbd_access_mode_str(enum rnbd_access_mode mode);
 
+void rnbd_fault_inject_init(struct rnbd_fault_inject *fj,
+			    const char *dev_name, u32 err_status);
+void rnbd_fault_inject_add(struct dentry *dir, const char *fname, bool *value);
+void rnbd_fault_inject_final(struct rnbd_fault_inject *fj);
 #endif /* RNBD_PROTO_H */
-- 
2.25.1

