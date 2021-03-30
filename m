Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F208FC433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEABD6195D
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhC3Hii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhC3HiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28074C061765
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id bf3so17029333edb.6
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2DinE7fVr8sYCc9qcGvfMu7UAlB1mcRN2WeeCFznEc=;
        b=MtLeDD0Tssa0QYsp9DKD9lb2qrYeM0+c08gxZ5plMkiDA8TVUo25uC4rspJilEBqQh
         k6xMQfOW968zHhDQjd+Ftg4o+jEgZdAv7FFTnrb7eJ0Mk4aB/Nfah5kM+yZm7Uyx0P8l
         fMeqv0Trg+UMrPZtCiPx0xUWdCmVmu8OmTbFU7S+6HRMf1jr4mQfopshVlytGTTNQjR/
         x5uB8eK+F0UOxRibg9L3IW3k3lBIp38mHsIq8saiD4tHbxLa25lKcTMgCXrlBwCOZvQ6
         RLEkaf1Wlp1S8Zv3NPEg52lxv7xMSSE9f7qjfCrgymqotRgc+iLxrpfrmqLF4PHgAgWG
         TMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2DinE7fVr8sYCc9qcGvfMu7UAlB1mcRN2WeeCFznEc=;
        b=rsYhtNCE13H5uVP3wvYlpSoD64yoPO6B4TZ1FVsC8l56LTX3Nxt0DnsXS6uFquKpWn
         TQfqmZOiICewJSc2+k7Om3NyH+hTMz9p2j8DunQRR160Ff2fvswOByO30EV72JdlhBXq
         jEt4qdnAkervChxqYI2H7k+cJydAxr8B4cAZxV0c0vBkdyv2GOvyZKUiQnN4Vlm8Pp5H
         IEhjX9vtD2yt/yljOTpKFKydAnbVYFbYUZ5BS6LbOk3GuWxZc6Dy/uRIlAvb69HZZj4h
         kBqyby/XXKmN0xQxHgRyLZhIUAnZJkWfot1JSzTCE0FXXckm5FHliBaBOfeZErGYFIhL
         3FUg==
X-Gm-Message-State: AOAM531aaoA30vfX9fmxxaUV3fxHsIHEOf6CCAc672dJaBn09b9jWYkb
        JFxHApOClgdWetIq5o33GWYNRWJcH6Quag==
X-Google-Smtp-Source: ABdhPJzX/qD9grJHmZjMf9AFUigADN0BXrAX4zVYlLHbuIJGfxoCZUnAeQKYjiZgFiEETRFLat/bqg==
X-Received: by 2002:aa7:d1cd:: with SMTP id g13mr32281760edp.369.1617089878759;
        Tue, 30 Mar 2021 00:37:58 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:37:58 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 03/24] block/rnbd: Enable the fault-injection
Date:   Tue, 30 Mar 2021 09:37:31 +0200
Message-Id: <20210330073752.1465613-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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

