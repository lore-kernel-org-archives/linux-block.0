Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C19C7EE2D
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEVW0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjEVW0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:09 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1171119
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:05 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-64d3578c25bso4377970b3a.3
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794365; x=1687386365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPIbIXxr3KoaTgZOYO2EXrOAlILk6z3u8A9roW3UQ0U=;
        b=fHkyOEdvrbi3wEfY1IeBrLoFanr0IHttW0G33sseB8/FcL8mSEuSgf0Thp/oN4fUtJ
         GdozIqcOQt7Bc7FXuO3kFA5rBSE9SNxq6rdUbZRWtY50t2rL/qFw5Rb0lJSMOWPnnw5Y
         tBwgepIy/IsYdWsxv4hxfU10g3CrjlmluaqL/8WUP+U8Hx5x2dAkqQElcPbaoEA//3GE
         h4gOW9M/4WhO0TGppERUMoEogirdkP1sDRfpL7BdsLzct6wQDLvnGv1EsKwqW1cwM47S
         1ypmyhB/BWKHIUrJmz2WtXAaCEZq7zgnIWfi748Fb8vPnPNJkl88pUfgyRJwfx9Qeysh
         pmyQ==
X-Gm-Message-State: AC+VfDwG24z0brA054lNUE3jah4TrGIdKb2dVyGrhjLq1zqj2z66/TF/
        xEZLXA6DciPdAloMOkNPcIo=
X-Google-Smtp-Source: ACHHUZ4JnRS7tS0KXGvnGky3eDmskP5xYnhe/n9mq7H9Y66AxEDcGSOP6UM3Qbal2mCijdGEpcc5QA==
X-Received: by 2002:a05:6a00:13a2:b0:64a:f9c7:1365 with SMTP id t34-20020a056a0013a200b0064af9c71365mr14279594pfg.30.1684794365177;
        Mon, 22 May 2023 15:26:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:26:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 4/9] block: Make sub_page_limit_queues available in debugfs
Date:   Mon, 22 May 2023 15:25:36 -0700
Message-ID: <20230522222554.525229-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This new debugfs attribute makes it easier to verify the code that tracks
how many queues require limits below the page size.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c       | 2 ++
 block/blk-mq-debugfs.c | 9 +++++++++
 block/blk-mq-debugfs.h | 6 ++++++
 block/blk-settings.c   | 8 ++++++++
 block/blk.h            | 1 +
 5 files changed, 26 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 814bfb9c9489..a6726a64d8bc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -45,6 +45,7 @@
 #include <trace/events/block.h>
 
 #include "blk.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-cgroup.h"
@@ -1203,6 +1204,7 @@ int __init blk_dev_init(void)
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
+	blk_mq_debugfs_init();
 
 	return 0;
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 68165a50951b..30db8db91e07 100644
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
index a4ef1dfeef76..5cd95a3785fd 100644
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
  * blk_enable_sub_page_limits - enable support for max_segment_size values smaller than PAGE_SIZE and for max_hw_sectors values below PAGE_SIZE >> SECTOR_SHIFT
  * @lim: request queue limits for which to enable support of these features.
diff --git a/block/blk.h b/block/blk.h
index 49526127ea08..3c63ec0f1721 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -39,6 +39,7 @@ static inline bool blk_queue_sub_page_limits(const struct queue_limits *lim)
 		lim->sub_page_limits;
 }
 
+int blk_sub_page_limit_queues_get(void *data, u64 *val);
 void blk_disable_sub_page_limits(struct queue_limits *q);
 
 void blk_freeze_queue(struct request_queue *q);
