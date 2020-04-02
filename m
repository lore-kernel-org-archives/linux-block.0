Return-Path: <SRS0=2u2q=5S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D4C43331
	for <linux-block@archiver.kernel.org>; Thu,  2 Apr 2020 00:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7214C20721
	for <linux-block@archiver.kernel.org>; Thu,  2 Apr 2020 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585785614;
	bh=AQiHX8FkqiBny7pBzb7w1oGoc/AmBPy22JWbqE+ElkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hcx50SpKvOrHJ/xYgIUul3H/TgfDS72F79EZ9ORDkHXpCTNMI4p7CldK9vP32qYQp
	 5l5zoNNrR+Ldi2jSYPkvf6xLnSwuxPHteGXI1/fISZhvyBGMbc4/IuIppJii17bN7/
	 RRP8/E7sdaz4ZZQCUUuCIxAwr5VJVC63DGizLZ5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbgDBAAO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:00:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44805 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbgDBAAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Apr 2020 20:00:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so825671pfb.11;
        Wed, 01 Apr 2020 17:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFwcC/w73MX4o2yQ8rfJAUpy9x+uzW31JyxuFegsf5o=;
        b=M8tdxnMMrHpie5+x79htSm+WQsCttcDD3joPI9Yunrl74BPFoKg8XBH61EK0dgVgUB
         Og8ssomY+8D0goIgxxP3Utw9dqC5pG0tlg4cRDQx6LbvNbOdnpkhiYOniuWfLMX6ThGZ
         w2yiZsMLco988eX1jgtyzBEIg64wWFoRV+sFOm3VXaqa1DqEJo46L3T8lFiTd6tRd4j5
         FrHHm4fjVUlbYaPJhiX/cQC5/u61jh8MYVkt+Ck7YR7zGfIJbNzh4gYu68Pr8f8QcwvH
         CWpVQLkWuRcfVlUlhOk4SAEZoZ3shOtraShEmrdZuvGYolGS8aFkYBoJTtZISPKxS/Mh
         w9ng==
X-Gm-Message-State: AGi0PubcEu/hPz/cts6mY95+nVwv5fjRtqxuEl6y1gY0ce4gL8/dLyYd
        yt91ir/RjP1LolplbiE2JGU=
X-Google-Smtp-Source: APiQypKeCcDQDiyCN2rdAtJfDymVmvOrZ70v+7dz07bMma08br8CelIedf6QzSZmqp2A/+DOlwQxTQ==
X-Received: by 2002:a63:78e:: with SMTP id 136mr691233pgh.181.1585785612494;
        Wed, 01 Apr 2020 17:00:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y13sm2388379pfp.88.2020.04.01.17.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 17:00:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8FA2C4018C; Thu,  2 Apr 2020 00:00:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC 1/3] block: move main block debugfs initialization to its own file
Date:   Thu,  2 Apr 2020 00:00:00 +0000
Message-Id: <20200402000002.7442-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200402000002.7442-1-mcgrof@kernel.org>
References: <20200402000002.7442-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Single and multiqeueue block devices share some debugfs code. By
moving this into its own file it makes it easier to expand and audit
this shared code.

This patch contains no functional changes.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/Makefile      |  1 +
 block/blk-core.c    |  9 +--------
 block/blk-debugfs.c | 15 +++++++++++++++
 block/blk.h         |  7 +++++++
 4 files changed, 24 insertions(+), 8 deletions(-)
 create mode 100644 block/blk-debugfs.c

diff --git a/block/Makefile b/block/Makefile
index 206b96e9387f..1d3ab20505d8 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
 
+obj-$(CONFIG_DEBUG_FS)		+= blk-debugfs.o
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
 obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o
diff --git a/block/blk-core.c b/block/blk-core.c
index 7e4a1da0715e..5aaae7a1b338 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -48,10 +48,6 @@
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
 
-#ifdef CONFIG_DEBUG_FS
-struct dentry *blk_debugfs_root;
-#endif
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
@@ -1796,10 +1792,7 @@ int __init blk_dev_init(void)
 
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
-
-#ifdef CONFIG_DEBUG_FS
-	blk_debugfs_root = debugfs_create_dir("block", NULL);
-#endif
+	blk_debugfs_register();
 
 	return 0;
 }
diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
new file mode 100644
index 000000000000..634dea4b1507
--- /dev/null
+++ b/block/blk-debugfs.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Shared debugfs mq / non-mq functionality
+ */
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/debugfs.h>
+
+struct dentry *blk_debugfs_root;
+
+void blk_debugfs_register(void)
+{
+	blk_debugfs_root = debugfs_create_dir("block", NULL);
+}
diff --git a/block/blk.h b/block/blk.h
index 0a94ec68af32..86a66b614f08 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -487,5 +487,12 @@ struct request_queue *__blk_alloc_queue(int node_id);
 int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		bool *same_page);
+#ifdef CONFIG_DEBUG_FS
+void blk_debugfs_register(void);
+#else
+static inline void blk_debugfs_register(void)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
 
 #endif /* BLK_INTERNAL_H */
-- 
2.25.1

