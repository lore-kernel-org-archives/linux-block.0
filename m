Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A495C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjDGARZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjDGARY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:24 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0C29ECC
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:22 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so184244pja.2
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826642; x=1683418642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97cM6iAZmdUOfT6s3oQ1fU2j6sZ1EQX65qrvjYxJW28=;
        b=5PD6wfQ4qsLx9rs3l+mix8Qgtyx3QUTtW0MhYBTi7bpKd+c5AnJqIk3BL9Diau8r3j
         89XB6h5ZuYlnNUE1a37zhdLKMYKG1qyLgOOiLSj9LddIWWA02OJASiJqPWMcSAWsIE1X
         wzAZWItRk8EE/msBJJrhl+RXHwJHc4xZvHQ2QJPBkfGI6IoB5cJmbWku4aElHfe1nof5
         nOfKGDXKAPQqeTe3GVkq52pLQUXZZ2gNldCPjJztV3KNjLH528IRKBiXYTTGPkAfWVJf
         ectOMmHMbyFYGGyhJWHp9SSg8gu2YIpYUhwBGacTxpbYT1iKc+s4iP3Txb16FUTSKd3S
         tc9A==
X-Gm-Message-State: AAQBX9cArkf2fFTo+Li6nG7hicidlDs8CLuHs5bMhEhkUbs/97wmxUKq
        yTMaOsjLKA8dTpP8J642xZE=
X-Google-Smtp-Source: AKy350ayUAWPGjtbmMFkgfrRxFWdKSLkrJz0uv5tvED2eAIfSbGdt6Gujwdfow/i3pC9PNfXCcZKMg==
X-Received: by 2002:a17:903:11c4:b0:1a2:9e64:bc5e with SMTP id q4-20020a17090311c400b001a29e64bc5emr851473plh.39.1680826641632;
        Thu, 06 Apr 2023 17:17:21 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 05/12] block: One requeue list per hctx
Date:   Thu,  6 Apr 2023 17:17:03 -0700
Message-Id: <20230407001710.104169-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for processing the requeue list from inside __blk_mq_run_hw_queue().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c | 66 +++++++++++++++++++++---------------------
 block/blk-mq.c         | 55 ++++++++++++++++++++++-------------
 include/linux/blk-mq.h |  4 +++
 include/linux/blkdev.h |  4 ---
 4 files changed, 72 insertions(+), 57 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 212a7f301e73..5eb930754347 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -20,37 +20,6 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
-	__acquires(&q->requeue_lock)
-{
-	struct request_queue *q = m->private;
-
-	spin_lock_irq(&q->requeue_lock);
-	return seq_list_start(&q->requeue_list, *pos);
-}
-
-static void *queue_requeue_list_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct request_queue *q = m->private;
-
-	return seq_list_next(v, &q->requeue_list, pos);
-}
-
-static void queue_requeue_list_stop(struct seq_file *m, void *v)
-	__releases(&q->requeue_lock)
-{
-	struct request_queue *q = m->private;
-
-	spin_unlock_irq(&q->requeue_lock);
-}
-
-static const struct seq_operations queue_requeue_list_seq_ops = {
-	.start	= queue_requeue_list_start,
-	.next	= queue_requeue_list_next,
-	.stop	= queue_requeue_list_stop,
-	.show	= blk_mq_debugfs_rq_show,
-};
-
 static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 			  const char *const *flag_name, int flag_name_count)
 {
@@ -156,11 +125,10 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{ "poll_stat", 0400, queue_poll_stat_show },
-	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
 	{ "pm_only", 0600, queue_pm_only_show, NULL },
 	{ "state", 0600, queue_state_show, queue_state_write },
 	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
-	{ },
+	{},
 };
 
 #define HCTX_STATE_NAME(name) [BLK_MQ_S_##name] = #name
@@ -513,6 +481,37 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static void *hctx_requeue_list_start(struct seq_file *m, loff_t *pos)
+	__acquires(&hctx->requeue_lock)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	spin_lock_irq(&hctx->requeue_lock);
+	return seq_list_start(&hctx->requeue_list, *pos);
+}
+
+static void *hctx_requeue_list_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	return seq_list_next(v, &hctx->requeue_list, pos);
+}
+
+static void hctx_requeue_list_stop(struct seq_file *m, void *v)
+	__releases(&hctx->requeue_lock)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	spin_unlock_irq(&hctx->requeue_lock);
+}
+
+static const struct seq_operations hctx_requeue_list_seq_ops = {
+	.start = hctx_requeue_list_start,
+	.next = hctx_requeue_list_next,
+	.stop = hctx_requeue_list_stop,
+	.show = blk_mq_debugfs_rq_show,
+};
+
 #define CTX_RQ_SEQ_OPS(name, type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
 	__acquires(&ctx->lock)						\
@@ -628,6 +627,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"run", 0600, hctx_run_show, hctx_run_write},
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
+	{"requeue_list", 0400, .seq_ops = &hctx_requeue_list_seq_ops},
 	{"type", 0400, hctx_type_show},
 	{},
 };
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8bb35deff5ec..1e285b0cfba3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1411,14 +1411,17 @@ EXPORT_SYMBOL(blk_mq_requeue_request);
 
 static void blk_mq_requeue_work(struct work_struct *work)
 {
-	struct request_queue *q =
-		container_of(work, struct request_queue, requeue_work.work);
+	struct blk_mq_hw_ctx *hctx =
+		container_of(work, struct blk_mq_hw_ctx, requeue_work.work);
 	LIST_HEAD(rq_list);
 	struct request *rq, *next;
 
-	spin_lock_irq(&q->requeue_lock);
-	list_splice_init(&q->requeue_list, &rq_list);
-	spin_unlock_irq(&q->requeue_lock);
+	if (list_empty_careful(&hctx->requeue_list))
+		return;
+
+	spin_lock_irq(&hctx->requeue_lock);
+	list_splice_init(&hctx->requeue_list, &rq_list);
+	spin_unlock_irq(&hctx->requeue_lock);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
 		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
@@ -1435,13 +1438,15 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		blk_mq_sched_insert_request(rq, false, false, false);
 	}
 
-	blk_mq_run_hw_queues(q, false);
+	blk_mq_run_hw_queue(hctx, false);
 }
 
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list)
 {
 	struct request_queue *q = rq->q;
+	struct blk_mq_hw_ctx *hctx =
+		rq->mq_hctx ?: q->queue_ctx[0].hctxs[HCTX_TYPE_DEFAULT];
 	unsigned long flags;
 
 	/*
@@ -1450,14 +1455,14 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 	 */
 	BUG_ON(rq->rq_flags & RQF_SOFTBARRIER);
 
-	spin_lock_irqsave(&q->requeue_lock, flags);
+	spin_lock_irqsave(&hctx->requeue_lock, flags);
 	if (at_head) {
 		rq->rq_flags |= RQF_SOFTBARRIER;
-		list_add(&rq->queuelist, &q->requeue_list);
+		list_add(&rq->queuelist, &hctx->requeue_list);
 	} else {
-		list_add_tail(&rq->queuelist, &q->requeue_list);
+		list_add_tail(&rq->queuelist, &hctx->requeue_list);
 	}
-	spin_unlock_irqrestore(&q->requeue_lock, flags);
+	spin_unlock_irqrestore(&hctx->requeue_lock, flags);
 
 	if (kick_requeue_list)
 		blk_mq_kick_requeue_list(q);
@@ -1465,15 +1470,25 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
-	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work, 0);
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
+					    &hctx->requeue_work, 0);
 }
 EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 
 void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 				    unsigned long msecs)
 {
-	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work,
-				    msecs_to_jiffies(msecs));
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
+					    &hctx->requeue_work,
+					    msecs_to_jiffies(msecs));
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
@@ -3595,6 +3610,10 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
+	INIT_DELAYED_WORK(&hctx->requeue_work, blk_mq_requeue_work);
+	INIT_LIST_HEAD(&hctx->requeue_list);
+	spin_lock_init(&hctx->requeue_lock);
+
 	hctx->queue_num = hctx_idx;
 
 	if (!(hctx->flags & BLK_MQ_F_STACKING))
@@ -4210,10 +4229,6 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 	blk_mq_update_poll_flag(q);
 
-	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
-	INIT_LIST_HEAD(&q->requeue_list);
-	spin_lock_init(&q->requeue_lock);
-
 	q->nr_requests = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
@@ -4758,10 +4773,10 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
-	cancel_delayed_work_sync(&q->requeue_work);
-
-	queue_for_each_hw_ctx(q, hctx, i)
+	queue_for_each_hw_ctx(q, hctx, i) {
+		cancel_delayed_work_sync(&hctx->requeue_work);
 		cancel_delayed_work_sync(&hctx->run_work);
+	}
 }
 
 static int __init blk_mq_init(void)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3a3bee9085e3..0157f1569980 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -311,6 +311,10 @@ struct blk_mq_hw_ctx {
 		unsigned long		state;
 	} ____cacheline_aligned_in_smp;
 
+	struct list_head	requeue_list;
+	spinlock_t		requeue_lock;
+	struct delayed_work	requeue_work;
+
 	/**
 	 * @run_work: Used for scheduling a hardware queue run at a later time.
 	 */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e3242e67a8e3..f5fa53cd13bd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -491,10 +491,6 @@ struct request_queue {
 	 */
 	struct blk_flush_queue	*fq;
 
-	struct list_head	requeue_list;
-	spinlock_t		requeue_lock;
-	struct delayed_work	requeue_work;
-
 	struct mutex		sysfs_lock;
 	struct mutex		sysfs_dir_lock;
 
