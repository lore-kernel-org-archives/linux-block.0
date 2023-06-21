Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93FCEB64D8
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjFUUMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFUUMu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 16:12:50 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520951994
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:48 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1a98a7fde3fso5995897fac.3
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378367; x=1689970367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUr56bfPDsXFz4FCvapGiSGfc8o8Vh8NU54JbYxiwrs=;
        b=JvtLfj66SZ5jhvDyIGmvXG0ihwRB5pigWxZYcNzlWXrmaXNSE3+OMXG3ZzAnnF7/vt
         dRDqaSQrbvAX7MKvpJ3AFzzM4EmBWTA0dB3ZNkseo+apTynvYnxKfr1fr+Qny1jV7t1M
         o8Wn8FJuoZmDo5nGgP7VnSIGSDetYlo8o29TxQJCurKDUaV28UtzpYWhsZDQRboJHUxr
         vsv4gXzQrQ9Xla+OawmG68V2ntMkcK5N0McEjZ4fYgT1MeOcrEs9nrWvtg556Mk4Rgpk
         ohDA2i1Z5l0/zKhhSJ5N9/bcBNFkRy/zjfvaeoXCtotziPu4FG1aEdJDU3dS2IKDXkMo
         lQVQ==
X-Gm-Message-State: AC+VfDxubwklhxg0N2rji7XVnrQM39sw2tKV64v5bEFXUPZjEJbXwFGR
        PqPkQwVo94wGYiF5iZFq+ZE=
X-Google-Smtp-Source: ACHHUZ6s5eDsXrcJ5nHgY1tWd+A2qbZMyh0fjQtc/snv2owJq+Amth8kPktJhpHdIYxXameMeSidCg==
X-Received: by 2002:a05:6870:2206:b0:1ad:f52:81c7 with SMTP id i6-20020a056870220600b001ad0f5281c7mr3139654oaf.17.1687378367504;
        Wed, 21 Jun 2023 13:12:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm3522983pgj.37.2023.06.21.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:12:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v4 4/7] block: One requeue list per hctx
Date:   Wed, 21 Jun 2023 13:12:31 -0700
Message-ID: <20230621201237.796902-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621201237.796902-1-bvanassche@acm.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
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
 block/blk-flush.c      | 24 ++++++++--------
 block/blk-mq-debugfs.c | 64 +++++++++++++++++++++---------------------
 block/blk-mq.c         | 53 ++++++++++++++++++++--------------
 include/linux/blk-mq.h |  6 ++++
 include/linux/blkdev.h |  5 ----
 5 files changed, 83 insertions(+), 69 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index dba392cf22be..4bfb92f58aa9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -91,7 +91,7 @@ enum {
 	FLUSH_PENDING_TIMEOUT	= 5 * HZ,
 };
 
-static void blk_kick_flush(struct request_queue *q,
+static void blk_kick_flush(struct blk_mq_hw_ctx *hctx,
 			   struct blk_flush_queue *fq, blk_opf_t flags);
 
 static inline struct blk_flush_queue *
@@ -165,6 +165,7 @@ static void blk_flush_complete_seq(struct request *rq,
 				   unsigned int seq, blk_status_t error)
 {
 	struct request_queue *q = rq->q;
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	blk_opf_t cmd_flags;
 
@@ -188,9 +189,9 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	case REQ_FSEQ_DATA:
 		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
-		spin_lock(&q->requeue_lock);
-		list_add_tail(&rq->queuelist, &q->flush_list);
-		spin_unlock(&q->requeue_lock);
+		spin_lock(&hctx->requeue_lock);
+		list_add_tail(&rq->queuelist, &hctx->flush_list);
+		spin_unlock(&hctx->requeue_lock);
 		blk_mq_kick_requeue_list(q);
 		break;
 
@@ -210,7 +211,7 @@ static void blk_flush_complete_seq(struct request *rq,
 		BUG();
 	}
 
-	blk_kick_flush(q, fq, cmd_flags);
+	blk_kick_flush(hctx, fq, cmd_flags);
 }
 
 static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
@@ -275,7 +276,7 @@ bool is_flush_rq(struct request *rq)
 
 /**
  * blk_kick_flush - consider issuing flush request
- * @q: request_queue being kicked
+ * @hctx: hwq being kicked
  * @fq: flush queue
  * @flags: cmd_flags of the original request
  *
@@ -286,9 +287,10 @@ bool is_flush_rq(struct request *rq)
  * spin_lock_irq(fq->mq_flush_lock)
  *
  */
-static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
-			   blk_opf_t flags)
+static void blk_kick_flush(struct blk_mq_hw_ctx *hctx,
+			   struct blk_flush_queue *fq, blk_opf_t flags)
 {
+	struct request_queue *q = hctx->queue;
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	struct request *first_rq =
 		list_first_entry(pending, struct request, flush.list);
@@ -348,9 +350,9 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	smp_wmb();
 	req_ref_set(flush_rq, 1);
 
-	spin_lock(&q->requeue_lock);
-	list_add_tail(&flush_rq->queuelist, &q->flush_list);
-	spin_unlock(&q->requeue_lock);
+	spin_lock(&hctx->requeue_lock);
+	list_add_tail(&flush_rq->queuelist, &hctx->flush_list);
+	spin_unlock(&hctx->requeue_lock);
 
 	blk_mq_kick_requeue_list(q);
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index c3b5930106b2..787bdff3cc64 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -18,37 +18,6 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
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
@@ -157,7 +126,6 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{ "poll_stat", 0400, queue_poll_stat_show },
-	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
 	{ "pm_only", 0600, queue_pm_only_show, NULL },
 	{ "state", 0600, queue_state_show, queue_state_write },
 	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
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
index 453a90767f7a..c359a28d9b25 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1421,6 +1421,7 @@ static void __blk_mq_requeue_request(struct request *rq)
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 {
 	struct request_queue *q = rq->q;
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	unsigned long flags;
 
 	__blk_mq_requeue_request(rq);
@@ -1428,9 +1429,9 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 	/* this request will be re-inserted to io scheduler queue */
 	blk_mq_sched_requeue_request(rq);
 
-	spin_lock_irqsave(&q->requeue_lock, flags);
-	list_add_tail(&rq->queuelist, &q->requeue_list);
-	spin_unlock_irqrestore(&q->requeue_lock, flags);
+	spin_lock_irqsave(&hctx->requeue_lock, flags);
+	list_add_tail(&rq->queuelist, &hctx->requeue_list);
+	spin_unlock_irqrestore(&hctx->requeue_lock, flags);
 
 	if (kick_requeue_list)
 		blk_mq_kick_requeue_list(q);
@@ -1439,16 +1440,16 @@ EXPORT_SYMBOL(blk_mq_requeue_request);
 
 static void blk_mq_requeue_work(struct work_struct *work)
 {
-	struct request_queue *q =
-		container_of(work, struct request_queue, requeue_work.work);
+	struct blk_mq_hw_ctx *hctx =
+		container_of(work, struct blk_mq_hw_ctx, requeue_work.work);
 	LIST_HEAD(requeue_list);
 	LIST_HEAD(flush_list);
 	struct request *rq;
 
-	spin_lock_irq(&q->requeue_lock);
-	list_splice_init(&q->requeue_list, &requeue_list);
-	list_splice_init(&q->flush_list, &flush_list);
-	spin_unlock_irq(&q->requeue_lock);
+	spin_lock_irq(&hctx->requeue_lock);
+	list_splice_init(&hctx->requeue_list, &requeue_list);
+	list_splice_init(&hctx->flush_list, &flush_list);
+	spin_unlock_irq(&hctx->requeue_lock);
 
 	while (!list_empty(&requeue_list)) {
 		rq = list_entry(requeue_list.next, struct request, queuelist);
@@ -1471,20 +1472,30 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		blk_mq_insert_request(rq, 0);
 	}
 
-	blk_mq_run_hw_queues(q, false);
+	blk_mq_run_hw_queue(hctx, false);
 }
 
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
 
@@ -3614,6 +3625,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
+	INIT_DELAYED_WORK(&hctx->requeue_work, blk_mq_requeue_work);
+	INIT_LIST_HEAD(&hctx->flush_list);
+	INIT_LIST_HEAD(&hctx->requeue_list);
+	spin_lock_init(&hctx->requeue_lock);
+
 	hctx->queue_num = hctx_idx;
 
 	if (!(hctx->flags & BLK_MQ_F_STACKING))
@@ -4229,11 +4245,6 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 	blk_mq_update_poll_flag(q);
 
-	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
-	INIT_LIST_HEAD(&q->flush_list);
-	INIT_LIST_HEAD(&q->requeue_list);
-	spin_lock_init(&q->requeue_lock);
-
 	q->nr_requests = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
@@ -4782,10 +4793,10 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
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
index 2610b299ec77..672e8880f9e2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -308,6 +308,12 @@ struct blk_mq_hw_ctx {
 		unsigned long		state;
 	} ____cacheline_aligned_in_smp;
 
+	struct list_head	flush_list;
+
+	struct list_head	requeue_list;
+	spinlock_t		requeue_lock;
+	struct delayed_work	requeue_work;
+
 	/**
 	 * @run_work: Used for scheduling a hardware queue run at a later time.
 	 */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..ed4f89657f1f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -479,11 +479,6 @@ struct request_queue {
 	 * for flush operations
 	 */
 	struct blk_flush_queue	*fq;
-	struct list_head	flush_list;
-
-	struct list_head	requeue_list;
-	spinlock_t		requeue_lock;
-	struct delayed_work	requeue_work;
 
 	struct mutex		sysfs_lock;
 	struct mutex		sysfs_dir_lock;
