Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA88C433E4
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F64620729
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgG0XK2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:10:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42080 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0XK1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 19:10:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id 1so9903668pfn.9
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 16:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEeJiYVMz8307W48t2xUueHZmcNrA0fy9az4IJZSXYM=;
        b=QqcTyrMTFTS8959efA7xt46Dhk6eX2oiDwloRcQa8c9CzGP+C5IC0SsPjcPgSKxsf/
         wg1p+P3DBKp1dQyf3PBDDjBm8fHPXf7v96dyXQ3KU/cY1VsNSNNlbMYWLfy297v4XQhJ
         8mJT56V/LZ2ZOjkP4oGzjhIhjHGCbmwgZibI4Qhe4YVuWu8+6rxf/aEJ0rPG8Z6g6/Ob
         muDuwRcLc1IgJf5MS4Zlqv2jDHWY2xnaGLyq+W4/0wn6MNLen5XpqO96NOhwjE8xZzoX
         j1rHnQXaqMtB0dPUqW8FqZ5gyUhFjZCnQ8ldoFgpLK/e3Ex+MQpbqMywjwztW2WtKL42
         eIDg==
X-Gm-Message-State: AOAM531rmu2RGSlXh5yhLDRg/VoVwpE/p5NwLgW5QKv8OM5xYoWasRKm
        agYNQCTbrTpBPemIi+/AH43JNOER
X-Google-Smtp-Source: ABdhPJz6qd0y1knZ/xbgn9QiQOsWezpqzf2TDrmqmLe7C+87nDuyXUCGxEo7DCMS51C2to1/arC4/A==
X-Received: by 2002:aa7:9422:: with SMTP id y2mr22663850pfo.211.1595891426976;
        Mon, 27 Jul 2020 16:10:26 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id z190sm7407171pfz.67.2020.07.27.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:10:26 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Date:   Mon, 27 Jul 2020 16:10:21 -0700
Message-Id: <20200727231022.307602-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727231022.307602-1-sagi@grimberg.me>
References: <20200727231022.307602-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

drivers that have shared tagsets may need to quiesce potentially a lot
of request queues that all share a single tagset (e.g. nvme). Add an interface
to quiesce all the queues on a given tagset. This interface is useful because
it can speedup the quiesce by doing it in parallel.

For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
in parallel such that all of them wait for the same rcu elapsed period with
a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
sufficient.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  4 +++
 2 files changed, 70 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..c37e37354330 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
+		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
+		if (!hctx->rcu_sync)
+			continue;
+
+		init_completion(&hctx->rcu_sync->completion);
+		init_rcu_head(&hctx->rcu_sync->head);
+		call_srcu(hctx->srcu, &hctx->rcu_sync->head,
+				wakeme_after_rcu);
+	}
+}
+
+static void blk_mq_quiesce_blocking_queue_async_wait(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
+		if (!hctx->rcu_sync) {
+			synchronize_srcu(hctx->srcu);
+			continue;
+		}
+		wait_for_completion(&hctx->rcu_sync->completion);
+		destroy_rcu_head(&hctx->rcu_sync->head);
+	}
+}
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
@@ -2884,6 +2920,36 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 	}
 }
 
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	if (set->flags & BLK_MQ_F_BLOCKING) {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_blocking_queue_async(q);
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_blocking_queue_async_wait(q);
+	} else {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_queue_nowait(q);
+		synchronize_rcu();
+	}
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_unquiesce_queue(q);
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
 static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
 					bool shared)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..a85f2dedc947 100644
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
+void blk_mq_quiesce_tagset(struct request_queue *q);
+void blk_mq_unquiesce_tagset(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-- 
2.25.1

