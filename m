Return-Path: <SRS0=9ghM=BF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14833C433DF
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0836206D7
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGZAXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:23:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42108 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZAXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jul 2020 20:23:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id q17so6319383pls.9
        for <linux-block@vger.kernel.org>; Sat, 25 Jul 2020 17:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0EepSRNlenjv5tADlT5X1AQfZpXiJRu0WwPL9UNMkQ=;
        b=l9GbipjOIkouiYxBdTBhjV4kkkt5gq+6Ks5hwNobJr09phKA8wa6Vf7uYrChY5SdNz
         2IT6bxiRB0GR8QLank+qAjYLJejfBPu+n+YDHbVK/prU8/j7qWJ9Lt+BVC3N4FpkTNTz
         jCDN/+0QH7gWnOpUkkyy26ljDt/T6aI8ErTItLk/64JRLlzxSeTKDV1ukXbrVxtXn5Rh
         1gwO5z2jVBuORx60zZSpUAW8ZjoflkI+/7je+QecP40mAm5eiJDVnWqJ4Lbd8LClj5S+
         kYhSe0wYRH4EboST8zUcNnNwgrpgRKCMf2iydiUPWqQjmMryUK3m/JqKBPgYo57ZYNeU
         owYg==
X-Gm-Message-State: AOAM531T+vU95pja/8JffW1920keGTv6SipzWQ/nhU5ROqFN5ykXFLOu
        9ox6gmdxZO6q0G9/1maST94=
X-Google-Smtp-Source: ABdhPJyY1H3XUwh7A70dLeGsqWcPlhb9xbHUynZGCza/hLlr1fi9sK1k3W9EwFz2C8Rt6t6Xc4D3Hg==
X-Received: by 2002:a17:90a:30c2:: with SMTP id h60mr11508704pjb.23.1595722986432;
        Sat, 25 Jul 2020 17:23:06 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:c428:8d39:30dd:38a5])
        by smtp.gmail.com with ESMTPSA id z62sm10185620pfb.47.2020.07.25.17.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 17:23:05 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
Subject: [PATCH v3 1/2] blk-mq: add async quiesce interface
Date:   Sat, 25 Jul 2020 17:23:00 -0700
Message-Id: <20200726002301.145627-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726002301.145627-1-sagi@grimberg.me>
References: <20200726002301.145627-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers that may have to quiesce a large amount of request queues at once
(e.g. controller or adapter reset). These drivers would benefit from an
async quiesce interface such that the can trigger quiesce asynchronously
and wait for all in parallel.

This leaves the synchronization responsibility to the driver, but adds
a convenient interface to quiesce async and wait in a single pass.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c         | 32 ++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..60d137265bd9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,38 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		init_completion(&hctx->rcu_sync.completion);
+		init_rcu_head(&hctx->rcu_sync.head);
+		if (hctx->flags & BLK_MQ_F_BLOCKING)
+			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
+				wakeme_after_rcu);
+		else
+			call_rcu(&hctx->rcu_sync.head,
+				wakeme_after_rcu);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		wait_for_completion(&hctx->rcu_sync.completion);
+		destroy_rcu_head(&hctx->rcu_sync.head);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..5536e434311a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -5,6 +5,7 @@
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
 #include <linux/srcu.h>
+#include <linux/rcupdate_wait.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
 	 */
 	struct list_head	hctx_list;
 
+	struct rcu_synchronize	rcu_sync;
 	/**
 	 * @srcu: Sleepable RCU. Use as lock when type of the hardware queue is
 	 * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
@@ -532,6 +534,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_quiesce_queue_async(struct request_queue *q);
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-- 
2.25.1

