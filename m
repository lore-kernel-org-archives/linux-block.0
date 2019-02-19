Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA8AC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 15:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2137A21738
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 15:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc7yKF8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfBSP16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:27:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43776 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSP1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 10:27:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so8015087wre.10;
        Tue, 19 Feb 2019 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2q6fbrSJpEIdLncW4UFN3mJBQ17i3z8yQuQeSIDg2n4=;
        b=Hc7yKF8Q0KWei9jPYZqwtPGUg6enGpDzAb3GPtEE+uGJT2GIltg9n8oYO6EmU47dnm
         +wYlQ647qj51UGlYZNKeCAdC/Pk0mmoluTHFpcgfSvyMEmQeUgq4AKiVejeZ6dfnPl4m
         rMc4yjeoJI8TOMezjLRVtcmIiw5XFWC3QpxlfLZ8teQOFbg4AbFQwkGBp+rnIwRF3/on
         D/79xbnlJeVugNzjBBwnaDqvY/giTuukLGhCR5ATHdj0LlJe2WxnNXvk35VkbBIHm6jG
         uWEuO55gt+o6aMnwdIRi0a3mwOkcjPyWJl8raBZDs8rP2AGQwOL0p2GaLPU8i5ndeUIc
         /Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2q6fbrSJpEIdLncW4UFN3mJBQ17i3z8yQuQeSIDg2n4=;
        b=nwPnDSwsbYO2EmCoZItAGVw02eQ76mUe2OrXqUrIiVXR/yud4CbGAyz04wXPRT7u2U
         cCHCPKXmsw4T2zOlkwSiJruJNhrOg2cA/ZZmjFL4i/oM+WEGEbLBbOcCFGUOoZMemxab
         d1Rc8P/RJXmhEyIuF8IikWl3cH2wZuvRCULLjTVAUKaEcfD71z7kq8J5TdacCdhTmFQ4
         8x8bBf/iVOTf8oAVfJl69RRelGisAka+pBiZjN7PIW4ZCifvfeh7RTH4RS/TZxy7Fyzn
         EJDJ+32S/+CVK4nvNz3OG1MueueBlYT8MHlu4jnff0WR40ZpICeH+qZmJehShUTK/v+a
         X7oA==
X-Gm-Message-State: AHQUAuY65Z5VgL+KT45cuK3dWd3DBZqNLp9V8ipwoWr/6pHOBKP3nY8E
        VRO8bli5UqNB3XnjSX1TfA==
X-Google-Smtp-Source: AHgI3IZFIvl6ReS7nWK/NP1LCBsakFB+dO/D+RYZzjjCia5PB7ivC+IK/A1H93SbBT6YSgC2IHc0YA==
X-Received: by 2002:adf:f786:: with SMTP id q6mr4734864wrp.125.1550590063818;
        Tue, 19 Feb 2019 07:27:43 -0800 (PST)
Received: from xps-13.homenet.telecomitalia.it (host117-125-dynamic.33-79-r.retail.telecomitalia.it. [79.33.125.117])
        by smtp.gmail.com with ESMTPSA id v6sm29029503wrd.88.2019.02.19.07.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 07:27:43 -0800 (PST)
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] blkcg: introduce io.sync_isolation
Date:   Tue, 19 Feb 2019 16:27:11 +0100
Message-Id: <20190219152712.9855-3-righi.andrea@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219152712.9855-1-righi.andrea@gmail.com>
References: <20190219152712.9855-1-righi.andrea@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a flag to the blkcg cgroups to make sync()'ers in a cgroup only be
allowed to write out pages that have been dirtied by the cgroup itself.

This flag is disabled by default (meaning that we are not changing the
previous behavior by default).

When this flag is enabled any cgroup can write out only dirty pages that
belong to the cgroup itself (except for the root cgroup that would still
be able to write out all pages globally).

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
 block/blk-throttle.c                    | 37 +++++++++++++++++++++++++
 include/linux/blk-cgroup.h              |  7 +++++
 3 files changed, 53 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7bf3f129c68b..f98027fc2398 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1432,6 +1432,15 @@ IO Interface Files
 	Shows pressure stall information for IO. See
 	Documentation/accounting/psi.txt for details.
 
+  io.sync_isolation
+        A flag (0|1) that determines whether a cgroup is allowed to write out
+        only pages that have been dirtied by the cgroup itself. This option is
+        set to false (0) by default, meaning that any cgroup would try to write
+        out dirty pages globally, even those that have been dirtied by other
+        cgroups.
+
+        Setting this option to true (1) provides a better isolation across
+        cgroups that are doing an intense write I/O activity.
 
 Writeback
 ~~~~~~~~~
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index da817896cded..4bc3b40a4d93 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1704,6 +1704,35 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+static int sync_isolation_show(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+
+	seq_printf(sf, "%d\n", test_bit(BLKCG_SYNC_ISOLATION, &blkcg->flags));
+	return 0;
+}
+
+static ssize_t sync_isolation_write(struct kernfs_open_file *of,
+				    char *buf, size_t nbytes, loff_t off)
+{
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
+	unsigned long val;
+	int err;
+
+	buf = strstrip(buf);
+	err = kstrtoul(buf, 0, &val);
+	if (err)
+		return err;
+	if (val)
+		set_bit(BLKCG_SYNC_ISOLATION, &blkcg->flags);
+	else
+		clear_bit(BLKCG_SYNC_ISOLATION, &blkcg->flags);
+
+	return nbytes;
+}
+#endif
+
 static struct cftype throtl_files[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	{
@@ -1721,6 +1750,14 @@ static struct cftype throtl_files[] = {
 		.write = tg_set_limit,
 		.private = LIMIT_MAX,
 	},
+#ifdef CONFIG_CGROUP_WRITEBACK
+	{
+		.name = "sync_isolation",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = sync_isolation_show,
+		.write = sync_isolation_write,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 0f7dcb70e922..6ac5aa049334 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -44,6 +44,12 @@ enum blkg_rwstat_type {
 
 struct blkcg_gq;
 
+/* blkcg->flags */
+enum {
+	/* sync()'ers allowed to write out pages dirtied by the blkcg */
+	BLKCG_SYNC_ISOLATION,
+};
+
 struct blkcg {
 	struct cgroup_subsys_state	css;
 	spinlock_t			lock;
@@ -55,6 +61,7 @@ struct blkcg {
 	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
 
 	struct list_head		all_blkcgs_node;
+	unsigned long			flags;
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head		cgwb_wait_node;
 	struct list_head		cgwb_list;
-- 
2.17.1

