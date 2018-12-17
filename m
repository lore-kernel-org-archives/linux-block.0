Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A9AC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB342133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeLQMJQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeLQMJQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 07:09:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E58E7F6CB;
        Mon, 17 Dec 2018 12:09:15 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32554101E5A5;
        Mon, 17 Dec 2018 12:09:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 3/3] blk-mq: fix dispatch from sw queue
Date:   Mon, 17 Dec 2018 20:08:44 +0800
Message-Id: <20181217120844.8131-4-ming.lei@redhat.com>
In-Reply-To: <20181217120844.8131-1-ming.lei@redhat.com>
References: <20181217120844.8131-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 17 Dec 2018 12:09:15 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When requst is added to rq list of sw queue(ctx), the rq may be from
different type of hctx, especially after multi queue mapping is introduced.

So when dispach request from sw queue via blk_mq_flush_busy_ctxs() or
blk_mq_dequeue_from_ctx(), one request belonging to other queue type of
hctx can be dispatch to current hctx in case that read queue or poll queue
is enabled.

This patch fixes this issue by introducing per-queue-type list.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 69 ++++++++++++++++++++++++++++----------------------
 block/blk-mq-sched.c   | 23 +++++++++++------
 block/blk-mq.c         | 52 ++++++++++++++++++++++---------------
 block/blk-mq.h         | 10 +++++---
 4 files changed, 91 insertions(+), 63 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1e12033be9ea..159607be5158 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -652,36 +652,43 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
-	__acquires(&ctx->lock)
-{
-	struct blk_mq_ctx *ctx = m->private;
-
-	spin_lock(&ctx->lock);
-	return seq_list_start(&ctx->rq_list, *pos);
-}
-
-static void *ctx_rq_list_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct blk_mq_ctx *ctx = m->private;
-
-	return seq_list_next(v, &ctx->rq_list, pos);
-}
+#define CTX_RQ_SEQ_OPS(name, type)					\
+static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
+	__acquires(&ctx->lock)						\
+{									\
+	struct blk_mq_ctx *ctx = m->private;				\
+									\
+	spin_lock(&ctx->list[type].lock);				\
+	return seq_list_start(&ctx->list[type].rq_list, *pos);		\
+}									\
+									\
+static void *ctx_##name##_rq_list_next(struct seq_file *m, void *v,	\
+				     loff_t *pos)			\
+{									\
+	struct blk_mq_ctx *ctx = m->private;				\
+									\
+	return seq_list_next(v, &ctx->list[type].rq_list, pos);		\
+}									\
+									\
+static void ctx_##name##_rq_list_stop(struct seq_file *m, void *v)	\
+	__releases(&ctx->lock)						\
+{									\
+	struct blk_mq_ctx *ctx = m->private;				\
+									\
+	spin_unlock(&ctx->list[type].lock);				\
+}									\
+									\
+static const struct seq_operations ctx_##name##_rq_list_seq_ops = {	\
+	.start	= ctx_##name##_rq_list_start,				\
+	.next	= ctx_##name##_rq_list_next,				\
+	.stop	= ctx_##name##_rq_list_stop,				\
+	.show	= blk_mq_debugfs_rq_show,				\
+}
+
+CTX_RQ_SEQ_OPS(default, HCTX_TYPE_DEFAULT);
+CTX_RQ_SEQ_OPS(read, HCTX_TYPE_READ);
+CTX_RQ_SEQ_OPS(poll, HCTX_TYPE_POLL);
 
-static void ctx_rq_list_stop(struct seq_file *m, void *v)
-	__releases(&ctx->lock)
-{
-	struct blk_mq_ctx *ctx = m->private;
-
-	spin_unlock(&ctx->lock);
-}
-
-static const struct seq_operations ctx_rq_list_seq_ops = {
-	.start	= ctx_rq_list_start,
-	.next	= ctx_rq_list_next,
-	.stop	= ctx_rq_list_stop,
-	.show	= blk_mq_debugfs_rq_show,
-};
 static int ctx_dispatched_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_ctx *ctx = data;
@@ -819,7 +826,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
-	{"rq_list", 0400, .seq_ops = &ctx_rq_list_seq_ops},
+	{"default_rq_list", 0400, .seq_ops = &ctx_default_rq_list_seq_ops},
+	{"read_rq_list", 0400, .seq_ops = &ctx_read_rq_list_seq_ops},
+	{"poll_rq_list", 0400, .seq_ops = &ctx_poll_rq_list_seq_ops},
 	{"dispatched", 0600, ctx_dispatched_show, ctx_dispatched_write},
 	{"merged", 0600, ctx_merged_show, ctx_merged_write},
 	{"completed", 0600, ctx_completed_show, ctx_completed_write},
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 5b4d52d9cba2..09594947933e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -301,11 +301,14 @@ EXPORT_SYMBOL_GPL(blk_mq_bio_list_merge);
  * too much time checking for merges.
  */
 static bool blk_mq_attempt_merge(struct request_queue *q,
+				 struct blk_mq_hw_ctx *hctx,
 				 struct blk_mq_ctx *ctx, struct bio *bio)
 {
-	lockdep_assert_held(&ctx->lock);
+	enum hctx_type type = hctx->type;
 
-	if (blk_mq_bio_list_merge(q, &ctx->rq_list, bio)) {
+	lockdep_assert_held(&ctx->list[type].lock);
+
+	if (blk_mq_bio_list_merge(q, &ctx->list[type].rq_list, bio)) {
 		ctx->rq_merged++;
 		return true;
 	}
@@ -319,18 +322,20 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx->cpu);
 	bool ret = false;
+	enum hctx_type type;
 
 	if (e && e->type->ops.bio_merge) {
 		blk_mq_put_ctx(ctx);
 		return e->type->ops.bio_merge(hctx, bio);
 	}
 
+	type = hctx->type;
 	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
-			!list_empty_careful(&ctx->rq_list)) {
+			!list_empty_careful(&ctx->list[type].rq_list)) {
 		/* default per sw-queue merge */
-		spin_lock(&ctx->lock);
-		ret = blk_mq_attempt_merge(q, ctx, bio);
-		spin_unlock(&ctx->lock);
+		spin_lock(&ctx->list[type].lock);
+		ret = blk_mq_attempt_merge(q, hctx, ctx, bio);
+		spin_unlock(&ctx->list[type].lock);
 	}
 
 	blk_mq_put_ctx(ctx);
@@ -392,9 +397,11 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		list_add(&rq->queuelist, &list);
 		e->type->ops.insert_requests(hctx, &list, at_head);
 	} else {
-		spin_lock(&ctx->lock);
+		enum hctx_type type = hctx->type;
+
+		spin_lock(&ctx->list[type].lock);
 		__blk_mq_insert_request(hctx, rq, at_head);
-		spin_unlock(&ctx->lock);
+		spin_unlock(&ctx->list[type].lock);
 	}
 
 run:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 313f28b2d079..06213516efd0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -958,11 +958,12 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
 	struct flush_busy_ctx_data *flush_data = data;
 	struct blk_mq_hw_ctx *hctx = flush_data->hctx;
 	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
+	enum hctx_type type = hctx->type;
 
-	spin_lock(&ctx->lock);
-	list_splice_tail_init(&ctx->rq_list, flush_data->list);
+	spin_lock(&ctx->list[type].lock);
+	list_splice_tail_init(&ctx->list[type].rq_list, flush_data->list);
 	sbitmap_clear_bit(sb, bitnr);
-	spin_unlock(&ctx->lock);
+	spin_unlock(&ctx->list[type].lock);
 	return true;
 }
 
@@ -992,15 +993,16 @@ static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr,
 	struct dispatch_rq_data *dispatch_data = data;
 	struct blk_mq_hw_ctx *hctx = dispatch_data->hctx;
 	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
+	enum hctx_type type = hctx->type;
 
-	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_list)) {
-		dispatch_data->rq = list_entry_rq(ctx->rq_list.next);
+	spin_lock(&ctx->list[type].lock);
+	if (!list_empty(&ctx->list[type].rq_list)) {
+		dispatch_data->rq = list_entry_rq(ctx->list[type].rq_list.next);
 		list_del_init(&dispatch_data->rq->queuelist);
-		if (list_empty(&ctx->rq_list))
+		if (list_empty(&ctx->list[type].rq_list))
 			sbitmap_clear_bit(sb, bitnr);
 	}
-	spin_unlock(&ctx->lock);
+	spin_unlock(&ctx->list[type].lock);
 
 	return !dispatch_data->rq;
 }
@@ -1608,15 +1610,16 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 					    bool at_head)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
+	enum hctx_type type = hctx->type;
 
-	lockdep_assert_held(&ctx->lock);
+	lockdep_assert_held(&ctx->list[type].lock);
 
 	trace_block_rq_insert(hctx->queue, rq);
 
 	if (at_head)
-		list_add(&rq->queuelist, &ctx->rq_list);
+		list_add(&rq->queuelist, &ctx->list[type].rq_list);
 	else
-		list_add_tail(&rq->queuelist, &ctx->rq_list);
+		list_add_tail(&rq->queuelist, &ctx->list[type].rq_list);
 }
 
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
@@ -1624,7 +1627,7 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
-	lockdep_assert_held(&ctx->lock);
+	lockdep_assert_held(&ctx->list[hctx->type].lock);
 
 	__blk_mq_insert_req_list(hctx, rq, at_head);
 	blk_mq_hctx_mark_pending(hctx, ctx);
@@ -1651,6 +1654,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 
 {
 	struct request *rq;
+	enum hctx_type type = hctx->type;
 
 	/*
 	 * preemption doesn't flush plug list, so it's possible ctx->cpu is
@@ -1661,10 +1665,10 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 		trace_block_rq_insert(hctx->queue, rq);
 	}
 
-	spin_lock(&ctx->lock);
-	list_splice_tail_init(list, &ctx->rq_list);
+	spin_lock(&ctx->list[type].lock);
+	list_splice_tail_init(list, &ctx->list[type].rq_list);
 	blk_mq_hctx_mark_pending(hctx, ctx);
-	spin_unlock(&ctx->lock);
+	spin_unlock(&ctx->list[type].lock);
 }
 
 static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
@@ -2200,16 +2204,18 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
+	enum hctx_type type;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
+	type = hctx->type;
 
-	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_list)) {
-		list_splice_init(&ctx->rq_list, &tmp);
+	spin_lock(&ctx->list[type].lock);
+	if (!list_empty(&ctx->list[type].rq_list)) {
+		list_splice_init(&ctx->list[type].rq_list, &tmp);
 		blk_mq_hctx_clear_pending(hctx, ctx);
 	}
-	spin_unlock(&ctx->lock);
+	spin_unlock(&ctx->list[type].lock);
 
 	if (list_empty(&tmp))
 		return 0;
@@ -2343,10 +2349,14 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 	for_each_possible_cpu(i) {
 		struct blk_mq_ctx *__ctx = per_cpu_ptr(q->queue_ctx, i);
 		struct blk_mq_hw_ctx *hctx;
+		int k;
 
 		__ctx->cpu = i;
-		spin_lock_init(&__ctx->lock);
-		INIT_LIST_HEAD(&__ctx->rq_list);
+
+		for (k = HCTX_TYPE_DEFAULT; k < HCTX_MAX_TYPES; k++) {
+			spin_lock_init(&__ctx->list[k].lock);
+			INIT_LIST_HEAD(&__ctx->list[k].rq_list);
+		}
 		__ctx->queue = q;
 
 		/*
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d1ed096723fb..0973a91eb1dd 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -12,14 +12,16 @@ struct blk_mq_ctxs {
 	struct blk_mq_ctx __percpu	*queue_ctx;
 };
 
+struct blk_mq_ctx_list {
+	spinlock_t		lock;
+	struct list_head	rq_list;
+}  ____cacheline_aligned_in_smp;
+
 /**
  * struct blk_mq_ctx - State for a software queue facing the submitting CPUs
  */
 struct blk_mq_ctx {
-	struct {
-		spinlock_t		lock;
-		struct list_head	rq_list;
-	}  ____cacheline_aligned_in_smp;
+	struct blk_mq_ctx_list  list[HCTX_MAX_TYPES];
 
 	unsigned int		cpu;
 	unsigned short		index_hw[HCTX_MAX_TYPES];
-- 
2.9.5

