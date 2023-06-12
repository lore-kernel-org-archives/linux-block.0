Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE28C88CB2
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 20:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjFLUd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjFLUd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 16:33:26 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36010CE
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:24 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-256766a1c43so2425550a91.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602004; x=1689194004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x31Gz5puzFT8R232eHlZC5XC6VRgSkQxD0Tkic2sb8Q=;
        b=XMKv2ql7ofyVTV+8mpOpI/I2UyrBb/z9rZGr1/214IH4sm8NnAHbCfT+VUhxx67Z6u
         XGG0Nv1vVSRXFBwYNWweuJkscqt6QEpfmy/FTbbWucwo4zx8a/rq1nZkHuicERIeaPWR
         WlOW4uTkyq8Y9aim8a7lnezbOm90o0bEfVzxNvwy6zHxuQgfzCpxJwhoFbg06H4NLVh+
         Ivs6U2/hGeP+BbA12/PXFi5x95izpI6PJS9d/7BrTOa9/QTf9WfaxniqqBrOFuJAeXr3
         mdcftL531IHjnE0tprgTzAXGhxXVDbbt3d91HYOUWTPVk1c9Mzg5qzNOWUM1HLpNZDyX
         OsDQ==
X-Gm-Message-State: AC+VfDwUJXeDRojGsHKAh9TKS/Jp7Kj7ZtOq2LVDSIi1+0q10djv35tU
        XN1PfrR5LjfwugnJupsBpWI=
X-Google-Smtp-Source: ACHHUZ4RQAplvPEhC6w29FH35KVFdNQ03BRnc8sVUMlfsZ+w4lr9VlDcClVQU2RNhdpONVEBUfSwdQ==
X-Received: by 2002:a17:90a:d98e:b0:25b:e4da:c73a with SMTP id d14-20020a17090ad98e00b0025be4dac73amr3324055pjv.13.1686602004185;
        Mon, 12 Jun 2023 13:33:24 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm3324767plb.86.2023.06.12.13.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:33:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v6 4/8] block: Make sub_page_limit_queues available in debugfs
Date:   Mon, 12 Jun 2023 13:33:10 -0700
Message-Id: <20230612203314.17820-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
References: <20230612203314.17820-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This new debugfs attribute makes it easier to verify the code that tracks
how many queues require limits below the page size.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c       | 2 ++
 block/blk-mq-debugfs.c | 9 +++++++++
 block/blk-mq-debugfs.h | 6 ++++++
 block/blk-settings.c   | 8 ++++++++
 block/blk.h            | 1 +
 5 files changed, 26 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 73b8b547ecb9..ef6173ad4731 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -45,6 +45,7 @@
 #include <trace/events/block.h>
 
 #include "blk.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-cgroup.h"
@@ -1204,6 +1205,7 @@ int __init blk_dev_init(void)
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
+	blk_mq_debugfs_init();
 
 	return 0;
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index c3b5930106b2..5649c9e3719d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -846,3 +846,12 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
 	debugfs_remove_recursive(hctx->sched_debugfs_dir);
 	hctx->sched_debugfs_dir = NULL;
 }
+
+DEFINE_DEBUGFS_ATTRIBUTE(blk_sub_page_limit_queues_fops,
+			blk_sub_page_limit_queues_get, NULL, "%llu\n");
+
+void blk_mq_debugfs_init(void)
+{
+	debugfs_create_file("sub_page_limit_queues", 0400, blk_debugfs_root,
+			    NULL, &blk_sub_page_limit_queues_fops);
+}
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 9c7d4b6117d4..7942119051f5 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -17,6 +17,8 @@ struct blk_mq_debugfs_attr {
 	const struct seq_operations *seq_ops;
 };
 
+void blk_mq_debugfs_init(void);
+
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
@@ -36,6 +38,10 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
 #else
+static inline void blk_mq_debugfs_init(void)
+{
+}
+
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
 }
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 607f21b99f3c..c1c4988cc575 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -107,6 +107,14 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
 }
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 
+/* For debugfs. */
+int blk_sub_page_limit_queues_get(void *data, u64 *val)
+{
+	*val = READ_ONCE(blk_nr_sub_page_limit_queues);
+
+	return 0;
+}
+
 /**
  * blk_enable_sub_page_limits - enable support for limits below the page size
  * @lim: request queue limits for which to enable support of these features.
diff --git a/block/blk.h b/block/blk.h
index d37ec737e05e..065449e7d0bd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -39,6 +39,7 @@ static inline bool blk_queue_sub_page_limits(const struct queue_limits *lim)
 		lim->sub_page_limits;
 }
 
+int blk_sub_page_limit_queues_get(void *data, u64 *val);
 void blk_disable_sub_page_limits(struct queue_limits *q);
 
 void blk_freeze_queue(struct request_queue *q);
