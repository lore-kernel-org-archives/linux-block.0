Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D789EC433DF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C146D2072E
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgG0WHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:07:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40999 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0WHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 18:07:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id g67so10743057pgc.8
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 15:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRnnbyunnUYJdQAMA5PZpcygTLScjixLg9gs4Fc8mvw=;
        b=l21C8NyyONJT7HjxoPBC428YryPnl/UviJygMNwxw9FByod1p5LW2gbErvxkHDHH+Y
         +LDSMCEb7dNzhlTvAMevDK3tzJdIJ5gg2QLJcetg+pNueOu/dLv8Pe0zstvRg+LyveLE
         AlxQht0bQXTe9kZ2yscUTT9gdah2pHvBWWleD6dHlLPXUwt7VxObp93OhR2ecnyAqsY7
         TUQ3K2C80aWhyRy5D7MESsVC8FrIOGE4paODK11IeBaphxVzLBkvedta+VqD33CaB2J8
         gxsvImtr/0/WcICNluIofcwUeyllkqAzByAxA+igHyECmFXnDhA6uvvfV4ELmZhw3Gt8
         FWCA==
X-Gm-Message-State: AOAM532SWl+Y159C/7/lCBt0FwTmTO9Rs/iGLHwySY44yPMrxtjILpQ7
        6iU/vAURYcGh/ka6v4aLN9E=
X-Google-Smtp-Source: ABdhPJx/0PHG/gaghPBGYo0zHRdVVbnEgP5ONLFNVKT/KxpPSy+7whwwLIC4SWqEnzoD1v+uYfUttg==
X-Received: by 2002:a63:e24d:: with SMTP id y13mr22035091pgj.248.1595887641032;
        Mon, 27 Jul 2020 15:07:21 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id s4sm2309519pfh.128.2020.07.27.15.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 15:07:20 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH v4 1/2] blk-mq: add async quiesce interface
Date:   Mon, 27 Jul 2020 15:07:16 -0700
Message-Id: <20200727220717.278116-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727220717.278116-1-sagi@grimberg.me>
References: <20200727220717.278116-1-sagi@grimberg.me>
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
 block/blk-mq.c         | 46 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  4 ++++
 2 files changed, 50 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..d913924117d2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,52 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+	int rcu = false;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
+		if (!hctx->rcu_sync) {
+			/* fallback to serial rcu sync */
+			if (hctx->flags & BLK_MQ_F_BLOCKING)
+				synchronize_srcu(hctx->srcu);
+			else
+				rcu = true;
+		} else {
+			init_completion(&hctx->rcu_sync->completion);
+			init_rcu_head(&hctx->rcu_sync->head);
+			if (hctx->flags & BLK_MQ_F_BLOCKING)
+				call_srcu(hctx->srcu, &hctx->rcu_sync->head,
+					wakeme_after_rcu);
+			else
+				call_rcu(&hctx->rcu_sync->head,
+					wakeme_after_rcu);
+		}
+	}
+	if (rcu)
+		synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (!hctx->rcu_sync)
+			continue;
+		wait_for_completion(&hctx->rcu_sync->completion);
+		destroy_rcu_head(&hctx->rcu_sync->head);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..7213ce56bb31 100644
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
 
+	struct rcu_synchronize	*rcu_sync;
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

