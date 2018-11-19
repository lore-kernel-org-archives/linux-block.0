Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC83C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB6F21104
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZY9L6xbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB6F21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeKSU57 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:57:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43091 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeKSU56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:57:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so13898438wrs.10
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x0Itf0ZxI+Oxy7a9zO1EZJNmqUfunAWUlaUx3OwJfXE=;
        b=ZY9L6xbrDMh2HjcNz0YOjsrYk0Kmtklvb60AEmHSjiJI/Pk+YMBYPF0O31vnW8uYNA
         c9mhYofxWkWb+nOOBKPvdgFBpZSiuq0Z0Cb090oHVsvuIymAZOAd3UGEwStIpuBuMv3h
         6BZEXTJWgLYIrrgwNuGx/H/HnMh1Ym7GLwhns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x0Itf0ZxI+Oxy7a9zO1EZJNmqUfunAWUlaUx3OwJfXE=;
        b=BDXgwW13Hw4w8CKFuGt31oOqJ8mc8rGw6Ug+vOn8M2fUj23auTikbqLgkCv45uUqes
         KgjyfKn5luhATmnAwchcgKMrwO9HlXLH87t7DkEgHzLcqyFCktekjrVlkOjrVuTh79fa
         G+f3d6GlSU5Gz1Ob1xrLiAU6dUBEiZCaf0ZS41XXtksxXDrUgP1af8Fa18nzZoQqztFB
         V8JhNpZKcPxHkSnuVIQF2bm0QQc8G9AobUM7YLCLX5jCDmu0IpdbhVg7BZuLOfUNEG8H
         WzM16pVaFdCEjiSZKCOO7LEIj78/KGSgFAdhmq8IsPlmEwVo518eWQLkd0EeP/GDw7UI
         pwUw==
X-Gm-Message-State: AGRZ1gKDWYJY+XX+BOQ+iw1h2A1kZdwgozumx1bX047UeWuxZn3S+Uwe
        RzcRK0FXMItXjZB1QCYZKx+1jQ==
X-Google-Smtp-Source: AJdET5fXw0qKxltdCvOTqRUWYOz39k9i/6Dbg6sQgUh6yuV+I1LQ+XJzInDrAA/rwPSZrkrvF0SJ6g==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr17334824wrs.281.1542623683215;
        Mon, 19 Nov 2018 02:34:43 -0800 (PST)
Received: from localhost.localdomain ([37.162.18.180])
        by smtp.gmail.com with ESMTPSA id e9sm14973298wro.16.2018.11.19.02.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:34:42 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 03/10] cgroup: link cftypes of the same subsystem with the same name
Date:   Mon, 19 Nov 2018 11:34:17 +0100
Message-Id: <20181119103424.3853-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181119103424.3853-1-paolo.valente@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

Two entities, of any kind, are not able to create a cgroup file with
the same name in the same folder: if an entity tries to create a file
that has the same name as a file created by another entity, the cgroup
core stops it, warns the user about the error, and then proceeds to
delete all the files created by the last entity.

However, in some specific situations, it may be useful for two or more
entities to use a common file, e.g., the I/O schedulers bfq and cfq
had the same "weight" attribute, that changed the behavior of the two
schedulers in a similar way.

This commit prepares the interface that allows two entities to share
files. It adds a flag CFTYPE_SHARE_FILE for cftypes, flag that allows
cftypes to be linked together if they are part of the same subsystem
and have the same name.

There is a limitation for a cftype that wants to share a file: it can't
have the hooks seq_start/next/stop. The reason is that there is no
consistent way to show portions of a file once multiple cftypes are
attached to it, and thus more than one seq_show() is invoked: there are
neither an univocal start point, nor univocal "next" and "stop"
operations.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 include/linux/cgroup-defs.h |  9 ++++++
 kernel/cgroup/cgroup.c      | 78 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 7841db6e7fb3..d659763c7221 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -93,6 +93,8 @@ enum {
 	CFTYPE_NO_PREFIX	= (1 << 3),	/* (DON'T USE FOR NEW FILES) no subsys prefix */
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
 
+	CFTYPE_SHARES_FILE	= (1 << 5),	/* shares file w/ other cfts */
+
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
@@ -528,6 +530,13 @@ struct cftype {
 	 */
 	struct cgroup_subsys *ss;	/* NULL for cgroup core files */
 	struct list_head node;		/* anchored at ss->cfts */
+
+	/*
+	 * List of cftypes that are sharing the same file. It allows the hook
+	 * functions of the cftypes in the list to be called together.
+	 */
+	struct list_head share_node;
+
 	struct kernfs_ops *kf_ops;
 
 	int (*open)(struct kernfs_open_file *of);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9d0993dd68fe..61eafd69e2fd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1549,11 +1549,15 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 	return NULL;
 }
 
-static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
+static void cgroup_rm_file(struct cgroup *cgrp, struct cftype *cft)
 {
 	char name[CGROUP_FILE_NAME_MAX];
+	struct kernfs_node *kn = kernfs_find_and_get(cgrp->kn,
+			cgroup_file_name(cgrp, cft, name));
+	struct cftype *cfts = kn->priv;
 
 	lockdep_assert_held(&cgroup_mutex);
+	kernfs_put(kn);
 
 	if (cft->file_offset) {
 		struct cgroup_subsys_state *css = cgroup_css(cgrp, cft->ss);
@@ -1566,7 +1570,19 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		del_timer_sync(&cfile->notify_timer);
 	}
 
-	kernfs_remove_by_name(cgrp->kn, cgroup_file_name(cgrp, cft, name));
+	/* Delete the file only if it's used by one cftype */
+	if (list_empty(&cft->share_node) || atomic_read(&kn->count) == 1) {
+		kernfs_remove(kn);
+	} else {
+		/*
+		 * Update the "priv" pointer of the kernfs_node if the cftype
+		 * that first created the file is removed.
+		 */
+		if (cft == cfts)
+			kn->priv = list_next_entry(cft, share_node);
+
+		kernfs_put(kn);
+	}
 }
 
 /**
@@ -3437,6 +3453,7 @@ static int cgroup_file_open(struct kernfs_open_file *of)
 {
 	struct cftype *cft = of->kn->priv;
 
+
 	if (cft->open)
 		return cft->open(of);
 	return 0;
@@ -3585,6 +3602,22 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	key = &cft->lockdep_key;
 #endif
+
+	if (cft->flags & CFTYPE_SHARES_FILE) {
+		/* kn->count keeps track of how many cftypes share kn */
+		kn = kernfs_find_and_get(cgrp->kn,
+					 cgroup_file_name(cgrp, cft, name));
+		if (kn) {
+			struct cftype *cfts = kn->priv;
+
+			if (cfts->flags & CFTYPE_SHARES_FILE)
+				goto out_set_cfile;
+			else
+				kernfs_put(kn);
+
+		}
+	}
+
 	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
 				  cgroup_file_mode(cft),
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
@@ -3599,6 +3632,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 		return ret;
 	}
 
+out_set_cfile:
 	if (cft->file_offset) {
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
@@ -3696,11 +3730,46 @@ static void cgroup_exit_cftypes(struct cftype *cfts)
 		cft->kf_ops = NULL;
 		cft->ss = NULL;
 
+		list_del(&cft->share_node);
+
 		/* revert flags set by cgroup core while adding @cfts */
 		cft->flags &= ~(__CFTYPE_ONLY_ON_DFL | __CFTYPE_NOT_ON_DFL);
 	}
 }
 
+/*
+ * Link a cftype that wants to share a file to the list of cftypes that are
+ * using it.
+ *
+ * The conditions for a cftype to be put in an existing list of cftypes and
+ * thus start to share a file are:
+ *	- to have the flag CFTYPE_SHARES_FILE set;
+ *	- to have all flags coincide with the flags of the other cftypes in the
+ *	  list;
+ *	- to not have a seq_start hook: there is no consistent way to show
+ *	  portions of a file once multiple cftypes are attached to it, and thus
+ *	  more than one seq_show() is invoked.
+ *
+ * Once two or more cftypes are linked together, the file only points
+ * to the first of them.
+ */
+static void cgroup_link_cftype(struct cgroup_subsys *ss, struct cftype *cft)
+{
+	struct cftype *cfts;
+
+	list_for_each_entry(cfts, &ss->cfts, node) {
+		struct cftype *c;
+
+		for (c = cfts; c->name[0] != '\0'; c++)
+			if (c != cft && !(c->flags ^ cft->flags) &&
+			    !(c->seq_start || cft->seq_start) &&
+			    !strcmp(c->name, cft->name)) {
+				list_add(&cft->share_node, &c->share_node);
+				return;
+			}
+	}
+}
+
 static int cgroup_init_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 {
 	struct cftype *cft;
@@ -3730,6 +3799,11 @@ static int cgroup_init_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 
 		cft->kf_ops = kf_ops;
 		cft->ss = ss;
+
+		INIT_LIST_HEAD(&cft->share_node);
+
+		if (cft->flags & CFTYPE_SHARES_FILE)
+			cgroup_link_cftype(ss, cft);
 	}
 
 	return 0;
-- 
2.16.1

