Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0CC04AB4
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 08:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6CC21773
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 08:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7bAU2KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfEUICh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 04:02:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44318 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfEUICh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 04:02:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so6641974wru.11
        for <linux-block@vger.kernel.org>; Tue, 21 May 2019 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Qyb2ZjHa3whLh+RqF+kWmGToKxa/X+H2gjIFhEE6sE=;
        b=m7bAU2KR9Hevmy1UDUpkxJIc6hl7VJkvHANJ8apIiHD0MPfPmeVhfmwmBiqv0xnW5U
         U7sBem1g0ZFi17AZiIyn5lr67YmFGZLtUGJT2Yi7AnOUTx06OheejUmpQDECITXRrOWA
         vF2TO5BlHjaWelNSh4tcisdtFMooSP8wv6xouAoYrmzEVqXWzH14BO0408AE/NX0qkyC
         bNSbwXYi/kHVOFV1S02n0+Q2fvHHqq/qTdIx2LBMlfXS2J50a2MXvHwJ8D9UtNg3wYaM
         1ikr/rvUNlLo8YRBK3YoYJi0znS3KrI/WeIlqB+tN71t7f1OwE5jCANY38DY7RhUqVVm
         9e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Qyb2ZjHa3whLh+RqF+kWmGToKxa/X+H2gjIFhEE6sE=;
        b=sO15r/KzSYMsSlmI0VNIVSDuD0XPyKls5/9G1KN1z8PHdPx2sVMFTConrNvDIML910
         gC2LR8OJZZlD7p5InO80KRJH6AFfrr0+99AHVMTaByUsbiXlGuJ0bmxva8NNuNC7qtY5
         WewsCt7+StzQWMb73dwYTGGsTpJ4crCtrQrgmGq5XfZ5hve68CQYgGRKaUgQ93UWKZ0L
         1fLM1osgTSDKf/R/jqgv2uqYmCMeiyrNWubPZM1ypmhImro87CMotCnt9LbXF/uw3RLU
         0HiNWS+qPxF0jWJ6OfKywzXDOuV/Oy+dD2zREdoTgQ0F5nXJrxYlJ2K9ZbhDIIaGeHOL
         Ixsg==
X-Gm-Message-State: APjAAAWWPP2v3bnqqpJiFQV8B1MdrScZwZy8e3u67nKg8AildVb2FOKX
        KfztS6/sr3iLYxM/4fh68FAQHIOBMYI=
X-Google-Smtp-Source: APXvYqxQvIFwezlmIsaefzH0JpE22nHQ3G2Kc1TFLSAI7PUr2y4W50DvNzt5ZshZd4aBp6JoZsV48w==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr15547070wrp.240.1558425755326;
        Tue, 21 May 2019 01:02:35 -0700 (PDT)
Received: from localhost.localdomain ([88.147.35.136])
        by smtp.gmail.com with ESMTPSA id p8sm11322301wro.0.2019.05.21.01.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:02:34 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Angelo Ruocco <angeloruocco90@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/2] cgroup: let a symlink too be created with a cftype file
Date:   Tue, 21 May 2019 10:01:54 +0200
Message-Id: <20190521080155.36178-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521080155.36178-1-paolo.valente@linaro.org>
References: <20190521080155.36178-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

This commit enables a cftype to have a symlink (of any name) that
points to the file associated with the cftype.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 include/linux/cgroup-defs.h |  3 +++
 kernel/cgroup/cgroup.c      | 33 +++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 77258d276f93..2ad9f53ecefe 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -101,6 +101,8 @@ enum {
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
 	CFTYPE_DEBUG		= (1 << 5),	/* create when cgroup_debug */
 
+	CFTYPE_SYMLINKED	= (1 << 6),	/* pointed to by symlink too */
+
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
@@ -538,6 +540,7 @@ struct cftype {
 	 * end of cftype array.
 	 */
 	char name[MAX_CFTYPE_NAME];
+	char link_name[MAX_CFTYPE_NAME];
 	unsigned long private;
 
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 217cec4e22c6..f77dee5eb82a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1460,8 +1460,8 @@ struct cgroup *task_cgroup_from_root(struct task_struct *task,
 
 static struct kernfs_syscall_ops cgroup_kf_syscall_ops;
 
-static char *cgroup_file_name(struct cgroup *cgrp, const struct cftype *cft,
-			      char *buf)
+static char *cgroup_fill_name(struct cgroup *cgrp, const struct cftype *cft,
+			      char *buf, bool write_link_name)
 {
 	struct cgroup_subsys *ss = cft->ss;
 
@@ -1471,13 +1471,26 @@ static char *cgroup_file_name(struct cgroup *cgrp, const struct cftype *cft,
 
 		snprintf(buf, CGROUP_FILE_NAME_MAX, "%s%s.%s",
 			 dbg, cgroup_on_dfl(cgrp) ? ss->name : ss->legacy_name,
-			 cft->name);
+			 write_link_name ? cft->link_name : cft->name);
 	} else {
-		strscpy(buf, cft->name, CGROUP_FILE_NAME_MAX);
+		strscpy(buf, write_link_name ? cft->link_name : cft->name,
+			CGROUP_FILE_NAME_MAX);
 	}
 	return buf;
 }
 
+static char *cgroup_file_name(struct cgroup *cgrp, const struct cftype *cft,
+			      char *buf)
+{
+	return cgroup_fill_name(cgrp, cft, buf, false);
+}
+
+static char *cgroup_link_name(struct cgroup *cgrp, const struct cftype *cft,
+			      char *buf)
+{
+	return cgroup_fill_name(cgrp, cft, buf, true);
+}
+
 /**
  * cgroup_file_mode - deduce file mode of a control file
  * @cft: the control file in question
@@ -1636,6 +1649,9 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 	}
 
 	kernfs_remove_by_name(cgrp->kn, cgroup_file_name(cgrp, cft, name));
+	if (cft->flags & CFTYPE_SYMLINKED)
+		kernfs_remove_by_name(cgrp->kn,
+				      cgroup_link_name(cgrp, cft, name));
 }
 
 /**
@@ -3809,6 +3825,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 {
 	char name[CGROUP_FILE_NAME_MAX];
 	struct kernfs_node *kn;
+	struct kernfs_node *kn_link;
 	struct lock_class_key *key = NULL;
 	int ret;
 
@@ -3839,6 +3856,14 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		spin_unlock_irq(&cgroup_file_kn_lock);
 	}
 
+	if (cft->flags & CFTYPE_SYMLINKED) {
+		kn_link = kernfs_create_link(cgrp->kn,
+					     cgroup_link_name(cgrp, cft, name),
+					     kn);
+		if (IS_ERR(kn_link))
+			return PTR_ERR(kn_link);
+	}
+
 	return 0;
 }
 
-- 
2.20.1

