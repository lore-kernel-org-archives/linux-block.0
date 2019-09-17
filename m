Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413CEC4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0861121881
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHiW8B/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfIQQwU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:52:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfIQQwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 12:52:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so3965381wrd.3
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D17brve6b6KAv4fqOmqA3INLGXx33zG7oskk+r6jVO8=;
        b=hHiW8B/QKwHCS22NUzjtEbLG8SCk2S3zBzArHW2Q9oZ8//kdEgusup7MhqecS/2AEB
         yF6OG6N6oV+f1nDE1wDU+LMtO2czrB56uU2oRX6x+4hPmUxkl0a8vFBZpIoGa3xz48Uv
         +gc6kHj7G3csBtOnlLWFxsddt8gxaJQhJ3bdoqNriEauIH7KxJcvbFbPNHoEIqRaHXEu
         28FafC+evdI7HfXnQMXvkY6ibAMw0fgvvunmPYKCljgkH2xkNdfJwwsxa+Mg3xnJ7p0P
         z+Zi669gBxRrsg5sUV9Qj5Be2Cxm7XPszByLZoicHHs242Qo8chu3PxPnKH9sEzlphSF
         EyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D17brve6b6KAv4fqOmqA3INLGXx33zG7oskk+r6jVO8=;
        b=ND/PergMzfFYrtl1PQx2wFpxz4+5Jx8aXlDWUkTsADojVNbSKKJ2yo4XYDldQX0cpB
         MPL8YFKHe9JQUV1UNERYmdq/n/UI5fpTlNRBEZ7gZUefgfM0ewgqGy0rVnp0ce3i8DAz
         xfYa6Bh1MaW55qvduGK8HErlvs7LOoMEQReDKBS4yQNz/9xqe5UVsXSIapQNbO6OMRIu
         LgE8WWwjirV7GRAv/+0m3BXorC0+/ttTMRLVz6yMKF4HFKCpzWuMvvFAZRqdd4gCU4DD
         W4X3F2RIzUf48UDds2Hv44XcY4aJrCeXFiJzGjVk3dEWm/fG4pIq2EKevs/vdZyjdEG1
         a93A==
X-Gm-Message-State: APjAAAU/Hj7/sPp25Vb9sffwptyOZktv+RJQKXTKX+lC8H77UgOhQt+Q
        oss5LPOY9iBf2IEFcHXnx8KxvQ==
X-Google-Smtp-Source: APXvYqz+JIm5NzzIioOZ+1thydASKJ+eQAcvmXAA0O0HwMtzk5VXPo+NJIR6yYpELIXHqYc1wQyNGg==
X-Received: by 2002:adf:9d84:: with SMTP id p4mr3668012wre.39.1568739129746;
        Tue, 17 Sep 2019 09:52:09 -0700 (PDT)
Received: from localhost.localdomain (146-241-53-114.dyn.eolo.it. [146.241.53.114])
        by smtp.gmail.com with ESMTPSA id g73sm4012378wme.10.2019.09.17.09.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:52:09 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/2] blkcg: Make bfq disable iocost when enabled
Date:   Tue, 17 Sep 2019 18:51:47 +0200
Message-Id: <20190917165148.19146-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917165148.19146-1-paolo.valente@linaro.org>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

Both iocost and bfq implement weight based IO control.  Currently, bfq
is using io.bfq prefix but wants to drop the bfq part.  To avoid
interface conflict, make bfq disable iocost when it's selected as the
IO scheduler for any block device on the system.  iocost is only
re-enabled when bfq is built as a module and unloaded.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 ++++---
 block/bfq-cgroup.c                      |  2 ++
 block/bfq-iosched.c                     | 32 +++++++++++++++++++++++++
 block/blk-iocost.c                      |  5 ++--
 include/linux/blk-cgroup.h              |  5 ++++
 kernel/cgroup/cgroup.c                  |  2 ++
 6 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3deacdc5e6d2..d4d06a970f8a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1406,9 +1406,11 @@ IO
 
 The "io" controller regulates the distribution of IO resources.  This
 controller implements both weight based and absolute bandwidth or IOPS
-limit distribution; however, weight based distribution is available
-only if cfq-iosched is in use and neither scheme is available for
-blk-mq devices.
+limit distribution.  Weight based distribution is implemented by
+either iocost controller or bfq IO scheduler.  When bfq is selected as
+the IO scheduler for any block device, iocost is disabled and bfq's
+implementation overrides for all devices.  If bfq is built as a kernel
+module, unloading it re-enables iocost.
 
 
 IO Interface Files
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 86a607cf19a1..decda96770f4 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1194,7 +1194,9 @@ struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 }
 
 struct blkcg_policy blkcg_policy_bfq = {
+#ifndef CONFIG_BLK_CGROUP_IOCOST
 	.dfl_cftypes		= bfq_blkg_files,
+#endif
 	.legacy_cftypes		= bfq_blkcg_legacy_files,
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0319d6339822..21d1b08610b1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6382,6 +6382,36 @@ static void bfq_init_root_group(struct bfq_group *root_group,
 	root_group->sched_data.bfq_class_idle_last_service = jiffies;
 }
 
+#if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_BLK_CGROUP_IOCOST)
+static bool bfq_enabled = false;
+
+static void bfq_enable(void)
+{
+	static DEFINE_MUTEX(bfq_enable_mutex);
+
+	mutex_lock(&bfq_enable_mutex);
+	if (!bfq_enabled) {
+		pr_info("bfq-iosched: Overriding iocost\n");
+		blkcg_policy_unregister(&blkcg_policy_iocost);
+		cgroup_add_dfl_cftypes(&io_cgrp_subsys, bfq_blkg_files);
+		bfq_enabled = true;
+	}
+	mutex_unlock(&bfq_enable_mutex);
+}
+
+static void __exit bfq_disable(void)
+{
+	if (bfq_enabled) {
+		pr_info("bfq-iosched: Restoring iocost\n");
+		cgroup_rm_cftypes(bfq_blkg_files);
+		blkcg_policy_register(&blkcg_policy_iocost);
+	}
+}
+#else
+static void bfq_enable(void) {}
+static void __exit bfq_disable(void) {}
+#endif
+
 static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
@@ -6506,6 +6536,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
 
 	wbt_disable_default(q);
+	bfq_enable();
 	return 0;
 
 out_free:
@@ -6823,6 +6854,7 @@ static void __exit bfq_exit(void)
 	blkcg_policy_unregister(&blkcg_policy_bfq);
 #endif
 	bfq_slab_kill();
+	bfq_disable();
 }
 
 module_init(bfq_init);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3b39deb8b9f8..1ef5b443c09a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -605,8 +605,6 @@ static u32 vrate_adj_pct[] =
 	  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
 	  4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8, 16 };
 
-static struct blkcg_policy blkcg_policy_iocost;
-
 /* accessors and helpers */
 static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
 {
@@ -2434,7 +2432,7 @@ static struct cftype ioc_files[] = {
 	{}
 };
 
-static struct blkcg_policy blkcg_policy_iocost = {
+struct blkcg_policy blkcg_policy_iocost = {
 	.dfl_cftypes	= ioc_files,
 	.cpd_alloc_fn	= ioc_cpd_alloc,
 	.cpd_free_fn	= ioc_cpd_free,
@@ -2442,6 +2440,7 @@ static struct blkcg_policy blkcg_policy_iocost = {
 	.pd_init_fn	= ioc_pd_init,
 	.pd_free_fn	= ioc_pd_free,
 };
+EXPORT_SYMBOL_GPL(blkcg_policy_iocost);
 
 static int __init ioc_init(void)
 {
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index bed9e43f9426..5669e3cfa1bc 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -815,6 +815,11 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
+
+#ifdef CONFIG_BLK_CGROUP_IOCOST
+extern struct blkcg_policy blkcg_policy_iocost;
+#endif
+
 #else	/* CONFIG_BLK_CGROUP */
 
 struct blkcg {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8be1da1ebd9a..4d015328ebb0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4059,6 +4059,7 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 	mutex_unlock(&cgroup_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cgroup_rm_cftypes);
 
 /**
  * cgroup_add_cftypes - add an array of cftypes to a subsystem
@@ -4115,6 +4116,7 @@ int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 		cft->flags |= __CFTYPE_ONLY_ON_DFL;
 	return cgroup_add_cftypes(ss, cfts);
 }
+EXPORT_SYMBOL_GPL(cgroup_add_dfl_cftypes);
 
 /**
  * cgroup_add_legacy_cftypes - add an array of cftypes for legacy hierarchies
-- 
2.20.1

