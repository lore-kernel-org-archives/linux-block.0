Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B523C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 18:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B37220854
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 18:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCGSJc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:09:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51195 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfCGSJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 13:09:31 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1h1xST-0001ks-Rp
        for linux-block@vger.kernel.org; Thu, 07 Mar 2019 18:09:29 +0000
Received: by mail-wr1-f70.google.com with SMTP id e14so8895935wrt.12
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 10:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msHBAipTtijk0UwIEQstQw/a0b7WTAeEuEqzcOHunh8=;
        b=AZnCp75qzmKBdh2r4s4/rLB73177IDIJVfQ/CVVj0R3FKnrEKBmbqRJDfHT29updzl
         c+8Y7W69spMGaZ8qAS51QC7Qd/y+Bq+BUBAG/pzRq3HUu0wbZmyw6bhSu3494O+rSQtL
         ipGq9QqzamBaR07WbLAmiT0PKmvT2RxRteebctQUrRlwKIZBHUWPWWf/2bhKtoYmxzAT
         F5Fr9F09OPcCc+kz2XcnbzlgQD71vizTQGIoA/P/hWknSmxDbdJd4x6dQ2pJqMJnDFVE
         ZFa8xCcvmUpfzoOmbc9HAtUYlugHrBT/0knldi+6QjqB797v+HUk5VLWzgF4Umahz5yV
         z1BA==
X-Gm-Message-State: APjAAAW34caIQKKLDq1EUqrMQxCZCLQs8xk2AIGkYIpW8RGbeoAlUzO0
        X8/1uM7VLFjjG+RP/mqD1CfIT9uoIHKy5n53gGxaGUbnf11LfEWz3Tn9x+sM39GCzIAa8sCxlA7
        rYtwte16Ag8lJP9Roz0JnoeY/m0DDj/608YdTDLKP
X-Received: by 2002:a1c:48f:: with SMTP id 137mr6282805wme.21.1551982169517;
        Thu, 07 Mar 2019 10:09:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrOrWH+mBOv+qbesPm46h8q7JZyeLqXfQE/4PXwLO2W361kOxwFytPiLP3snhrplrwntmGBQ==
X-Received: by 2002:a1c:48f:: with SMTP id 137mr6282785wme.21.1551982169309;
        Thu, 07 Mar 2019 10:09:29 -0800 (PST)
Received: from localhost.localdomain (host22-124-dynamic.46-79-r.retail.telecomitalia.it. [79.46.124.22])
        by smtp.gmail.com with ESMTPSA id a74sm7872747wma.22.2019.03.07.10.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:09:28 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] blkcg: introduce io.sync_isolation
Date:   Thu,  7 Mar 2019 19:08:33 +0100
Message-Id: <20190307180834.22008-3-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190307180834.22008-1-andrea.righi@canonical.com>
References: <20190307180834.22008-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
 block/blk-throttle.c                    | 37 +++++++++++++++++++++++++
 include/linux/blk-cgroup.h              |  7 +++++
 3 files changed, 53 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 53d3288c328b..17fff0ee97b8 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1448,6 +1448,15 @@ IO Interface Files
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
2.19.1

