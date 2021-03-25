Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83187C433E4
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC4661A2D
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCYPab (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhCYP3z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:29:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D430C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so3608072ejc.4
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2DinE7fVr8sYCc9qcGvfMu7UAlB1mcRN2WeeCFznEc=;
        b=AmfMoC96ytS5s9Iis5USSyujC8SkZmpx3eToG6kkJEFhdM6lhhZ/ck8KVUjeVJacI8
         5EgkTA5Tv9mVFtouZwbI1qIDUaJysIPN3/9xkQ3URJ57u21+JRA61D5KdiyRTAOT8cJY
         h2Yh1dNnuEk6YE3jlt1lw5dAjR16SVo9MWoRCWu5e/p+LmrjI3Ku87mVJYX/J0zsJAXU
         KRma5YcUU1M7yOzMrYvyNJ/Ki1J8lIfUqTqCubDq+wCK3p1QmMuSp1ZeHRD7yG1QA+uk
         6oTM1QF0p81WCADBHD1qey61ksLdjZN6/PYCBv/JPw0LD1okPHtEuLxXmUaCY6JDm2pj
         8WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2DinE7fVr8sYCc9qcGvfMu7UAlB1mcRN2WeeCFznEc=;
        b=JMGR6zqs37aZrP2hKIjsvk6jFo4g5pfHFTzOgigiSXt2MPE/S9+UIlILpPCw/lbFl5
         jCgI70h7gE6Xk8p7UEMTZJvdPvabXVWANl4alb7EFMsQKqP10lO4ljtLjdeFYhM87yL5
         o1MbIc8TieEEYQWOIrp/cJ9Bhj8dLFSxnWm7BDCCKm1n+jNcEeM+Bhw2BYLqETa55jz0
         FTiQCBLXGVWcvica0/AOp2smM6sijz06XqmohH6afMBXkqbH6urqnPJBdBoFQN4dcidn
         Yhs3UvvFCbxMv921K5y/79Hv6ziaft7Cdrj/GZRxGzLJdUmbEJbPIL9Zwh8ZIdWoYT2f
         UeTA==
X-Gm-Message-State: AOAM531EDUymjyG0oD/FhMNdXy3A3aDVMNkpeggA+ILonsLBuYREBy/f
        sR7WqPxlBPmlAtZX+VONF0NI9tZUfqkqGQ==
X-Google-Smtp-Source: ABdhPJz4nJWE+C0oKsPcTIIUUezeGO2k+dR0pvqnQeLh7ke1fVANsRIB1liiKgEeVJqu/qITMHX9Bg==
X-Received: by 2002:a17:906:71c3:: with SMTP id i3mr10088587ejk.391.1616686192819;
        Thu, 25 Mar 2021 08:29:52 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:52 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-rc 03/24] block/rnbd: Enable the fault-injection
Date:   Thu, 25 Mar 2021 16:28:50 +0100
Message-Id: <20210325152911.1213627-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

This patch introduces functions to enable the fault-injection for RTRS.
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

