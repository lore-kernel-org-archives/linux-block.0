Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D4C77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 06:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjDPGPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDPGPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 02:15:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291041BF9
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 23:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xVMTembh6Ys3SR5qW/BIHUnHQhdIQJE8bNbv0929alM=; b=CConqrHThwqTYVPwJdUxmDtuIQ
        1sT2MT5XVaR0Y4R9qG5qI44IH8Ri1eeJ2BaaRxoOoDgM4ZFMVVDqhw8yl8GJprNlyEihO0a4AArXR
        4yvdlkYvPsj4Jz+MnhEJ3wOPqd696XI2jpL3VnB4UkSsCSXVvcsJ0flGUeV7SCb0ytFAVuiplWRhu
        wkdsbYWaIjrhAkCU0bQJ6D/u93filDMdDoHznb84hZv672UDHYBBiiGc/Vj8/9rU7hUxGKm4haY0O
        g9dzVYML82J6fsPEFR3L5JAFaLOowCxNmbjR5gzJ5Jf+3rIchRIbL/+3UjS1NwafEgNchQfYkphEk
        7GOr2LtA==;
Received: from [2001:4bb8:192:2d6c:1ebd:68b7:179c:f32a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvff-00DDMT-11;
        Sun, 16 Apr 2023 06:15:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: move dispatch helpers to blk-mq.c
Date:   Sun, 16 Apr 2023 08:15:29 +0200
Message-Id: <20230416061529.959070-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the main per-hctx dispatch is in blk-mq-sched.c, which is a bit
confusing.  Move it to blk-mq.c and drop a few redundant "do_"s in the
function names.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 151 +-----------------------------------------
 block/blk-mq-sched.h |   3 +-
 block/blk-mq.c       | 153 +++++++++++++++++++++++++++++++++++++++++--
 block/blk-mq.h       |   3 +-
 4 files changed, 153 insertions(+), 157 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 67c95f31b15bb1..438338eb78139e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -74,8 +74,6 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
 	return blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
 }
 
-#define BLK_MQ_BUDGET_DELAY	3		/* ms units */
-
 /*
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
@@ -84,7 +82,7 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
  * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
  * be run again.  This is necessary to avoid starving flushes.
  */
-static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static int __blk_mq_sched_dispatch(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
@@ -175,13 +173,13 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	return !!dispatched;
 }
 
-static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+int blk_mq_sched_dispatch(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned long end = jiffies + HZ;
 	int ret;
 
 	do {
-		ret = __blk_mq_do_dispatch_sched(hctx);
+		ret = __blk_mq_sched_dispatch(hctx);
 		if (ret != 1)
 			break;
 		if (need_resched() || time_is_before_jiffies(end)) {
@@ -193,149 +191,6 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	return ret;
 }
 
-static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
-					  struct blk_mq_ctx *ctx)
-{
-	unsigned short idx = ctx->index_hw[hctx->type];
-
-	if (++idx == hctx->nr_ctx)
-		idx = 0;
-
-	return hctx->ctxs[idx];
-}
-
-/*
- * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
- * its queue by itself in its completion handler, so we don't need to
- * restart queue if .get_budget() fails to get the budget.
- *
- * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
- * be run again.  This is necessary to avoid starving flushes.
- */
-static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
-{
-	struct request_queue *q = hctx->queue;
-	LIST_HEAD(rq_list);
-	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
-	int ret = 0;
-	struct request *rq;
-
-	do {
-		int budget_token;
-
-		if (!list_empty_careful(&hctx->dispatch)) {
-			ret = -EAGAIN;
-			break;
-		}
-
-		if (!sbitmap_any_bit_set(&hctx->ctx_map))
-			break;
-
-		budget_token = blk_mq_get_dispatch_budget(q);
-		if (budget_token < 0)
-			break;
-
-		rq = blk_mq_dequeue_from_ctx(hctx, ctx);
-		if (!rq) {
-			blk_mq_put_dispatch_budget(q, budget_token);
-			/*
-			 * We're releasing without dispatching. Holding the
-			 * budget could have blocked any "hctx"s with the
-			 * same queue and if we didn't dispatch then there's
-			 * no guarantee anyone will kick the queue.  Kick it
-			 * ourselves.
-			 */
-			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
-			break;
-		}
-
-		blk_mq_set_rq_budget_token(rq, budget_token);
-
-		/*
-		 * Now this rq owns the budget which has to be released
-		 * if this rq won't be queued to driver via .queue_rq()
-		 * in blk_mq_dispatch_rq_list().
-		 */
-		list_add(&rq->queuelist, &rq_list);
-
-		/* round robin for fair dispatch */
-		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
-
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
-
-	WRITE_ONCE(hctx->dispatch_from, ctx);
-	return ret;
-}
-
-static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
-{
-	bool need_dispatch = false;
-	LIST_HEAD(rq_list);
-
-	/*
-	 * If we have previous entries on our dispatch list, grab them first for
-	 * more fair dispatch.
-	 */
-	if (!list_empty_careful(&hctx->dispatch)) {
-		spin_lock(&hctx->lock);
-		if (!list_empty(&hctx->dispatch))
-			list_splice_init(&hctx->dispatch, &rq_list);
-		spin_unlock(&hctx->lock);
-	}
-
-	/*
-	 * Only ask the scheduler for requests, if we didn't have residual
-	 * requests from the dispatch list. This is to avoid the case where
-	 * we only ever dispatch a fraction of the requests available because
-	 * of low device queue depth. Once we pull requests out of the IO
-	 * scheduler, we can no longer merge or sort them. So it's best to
-	 * leave them there for as long as we can. Mark the hw queue as
-	 * needing a restart in that case.
-	 *
-	 * We want to dispatch from the scheduler if there was nothing
-	 * on the dispatch list or we were able to dispatch from the
-	 * dispatch list.
-	 */
-	if (!list_empty(&rq_list)) {
-		blk_mq_sched_mark_restart_hctx(hctx);
-		if (!blk_mq_dispatch_rq_list(hctx, &rq_list, 0))
-			return 0;
-		need_dispatch = true;
-	} else {
-		need_dispatch = hctx->dispatch_busy;
-	}
-
-	if (hctx->queue->elevator)
-		return blk_mq_do_dispatch_sched(hctx);
-
-	/* dequeue request one by one from sw queue if queue is busy */
-	if (need_dispatch)
-		return blk_mq_do_dispatch_ctx(hctx);
-	blk_mq_flush_busy_ctxs(hctx, &rq_list);
-	blk_mq_dispatch_rq_list(hctx, &rq_list, 0);
-	return 0;
-}
-
-void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
-{
-	struct request_queue *q = hctx->queue;
-
-	/* RCU or SRCU read lock is needed before checking quiesced flag */
-	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
-		return;
-
-	hctx->run++;
-
-	/*
-	 * A return of -EAGAIN is an indication that hctx->dispatch is not
-	 * empty and we must run again in order to avoid starving flushes.
-	 */
-	if (__blk_mq_sched_dispatch_requests(hctx) == -EAGAIN) {
-		if (__blk_mq_sched_dispatch_requests(hctx) == -EAGAIN)
-			blk_mq_run_hw_queue(hctx, true);
-	}
-}
-
 bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 7c3cbad17f3052..3d492f6a6a8cb8 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -15,8 +15,7 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 				   struct list_head *free);
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
-
-void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
+int blk_mq_sched_dispatch(struct blk_mq_hw_ctx *hctx);
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2d297efe229db..21ad97e23ae15b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1685,7 +1685,8 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
  * Process software queues that have been marked busy, splicing them
  * to the for-dispatch
  */
-void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
+static void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx,
+		struct list_head *list)
 {
 	struct flush_busy_ctx_data data = {
 		.hctx = hctx,
@@ -1694,7 +1695,6 @@ void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 
 	sbitmap_for_each_set(&hctx->ctx_map, flush_busy_ctx, &data);
 }
-EXPORT_SYMBOL_GPL(blk_mq_flush_busy_ctxs);
 
 struct dispatch_rq_data {
 	struct blk_mq_hw_ctx *hctx;
@@ -2209,6 +2209,149 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
+static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
+					  struct blk_mq_ctx *ctx)
+{
+	unsigned short idx = ctx->index_hw[hctx->type];
+
+	if (++idx == hctx->nr_ctx)
+		idx = 0;
+
+	return hctx->ctxs[idx];
+}
+
+/*
+ * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
+ * its queue by itself in its completion handler, so we don't need to
+ * restart queue if .get_budget() fails to get the budget.
+ *
+ * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
+ * be run again.  This is necessary to avoid starving flushes.
+ */
+static int blk_mq_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+	LIST_HEAD(rq_list);
+	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
+	int ret = 0;
+	struct request *rq;
+
+	do {
+		int budget_token;
+
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		if (!sbitmap_any_bit_set(&hctx->ctx_map))
+			break;
+
+		budget_token = blk_mq_get_dispatch_budget(q);
+		if (budget_token < 0)
+			break;
+
+		rq = blk_mq_dequeue_from_ctx(hctx, ctx);
+		if (!rq) {
+			blk_mq_put_dispatch_budget(q, budget_token);
+			/*
+			 * We're releasing without dispatching. Holding the
+			 * budget could have blocked any "hctx"s with the
+			 * same queue and if we didn't dispatch then there's
+			 * no guarantee anyone will kick the queue.  Kick it
+			 * ourselves.
+			 */
+			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
+			break;
+		}
+
+		blk_mq_set_rq_budget_token(rq, budget_token);
+
+		/*
+		 * Now this rq owns the budget which has to be released
+		 * if this rq won't be queued to driver via .queue_rq()
+		 * in blk_mq_dispatch_rq_list().
+		 */
+		list_add(&rq->queuelist, &rq_list);
+
+		/* round robin for fair dispatch */
+		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
+
+	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
+
+	WRITE_ONCE(hctx->dispatch_from, ctx);
+	return ret;
+}
+
+static int __blk_mq_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+{
+	bool need_dispatch = false;
+	LIST_HEAD(rq_list);
+
+	/*
+	 * If we have previous entries on our dispatch list, grab them first for
+	 * more fair dispatch.
+	 */
+	if (!list_empty_careful(&hctx->dispatch)) {
+		spin_lock(&hctx->lock);
+		if (!list_empty(&hctx->dispatch))
+			list_splice_init(&hctx->dispatch, &rq_list);
+		spin_unlock(&hctx->lock);
+	}
+
+	/*
+	 * Only ask the scheduler for requests, if we didn't have residual
+	 * requests from the dispatch list. This is to avoid the case where
+	 * we only ever dispatch a fraction of the requests available because
+	 * of low device queue depth. Once we pull requests out of the IO
+	 * scheduler, we can no longer merge or sort them. So it's best to
+	 * leave them there for as long as we can. Mark the hw queue as
+	 * needing a restart in that case.
+	 *
+	 * We want to dispatch from the scheduler if there was nothing
+	 * on the dispatch list or we were able to dispatch from the
+	 * dispatch list.
+	 */
+	if (!list_empty(&rq_list)) {
+		blk_mq_sched_mark_restart_hctx(hctx);
+		if (!blk_mq_dispatch_rq_list(hctx, &rq_list, 0))
+			return 0;
+		need_dispatch = true;
+	} else {
+		need_dispatch = hctx->dispatch_busy;
+	}
+
+	if (hctx->queue->elevator)
+		return blk_mq_sched_dispatch(hctx);
+
+	/* dequeue request one by one from sw queue if queue is busy */
+	if (need_dispatch)
+		return blk_mq_dispatch_ctx(hctx);
+	blk_mq_flush_busy_ctxs(hctx, &rq_list);
+	blk_mq_dispatch_rq_list(hctx, &rq_list, 0);
+	return 0;
+}
+
+static void blk_mq_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+
+	/* RCU or SRCU read lock is needed before checking quiesced flag */
+	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
+		return;
+
+	hctx->run++;
+
+	/*
+	 * A return of -EAGAIN is an indication that hctx->dispatch is not
+	 * empty and we must run again in order to avoid starving flushes.
+	 */
+	if (__blk_mq_dispatch_requests(hctx) == -EAGAIN) {
+		if (__blk_mq_dispatch_requests(hctx) == -EAGAIN)
+			blk_mq_run_hw_queue(hctx, true);
+	}
+}
+
 /**
  * blk_mq_run_hw_queue - Start to run a hardware queue.
  * @hctx: Pointer to the hardware queue to run.
@@ -2248,8 +2391,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 	}
 
-	blk_mq_run_dispatch_ops(hctx->queue,
-				blk_mq_sched_dispatch_requests(hctx));
+	blk_mq_run_dispatch_ops(hctx->queue, blk_mq_dispatch_requests(hctx));
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
@@ -2417,8 +2559,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	struct blk_mq_hw_ctx *hctx =
 		container_of(work, struct blk_mq_hw_ctx, run_work.work);
 
-	blk_mq_run_dispatch_ops(hctx->queue,
-				blk_mq_sched_dispatch_requests(hctx));
+	blk_mq_run_dispatch_ops(hctx->queue, blk_mq_dispatch_requests(hctx));
 }
 
 /**
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f882677ff106a5..b5a20244452c75 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -48,7 +48,6 @@ void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
 			     unsigned int);
 void blk_mq_add_to_requeue_list(struct request *rq, blk_insert_t insert_flags);
-void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
 void blk_mq_put_rq_ref(struct request *rq);
@@ -246,6 +245,8 @@ unsigned int blk_mq_in_flight(struct request_queue *q,
 void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 		unsigned int inflight[2]);
 
+#define BLK_MQ_BUDGET_DELAY	3		/* ms units */
+
 static inline void blk_mq_put_dispatch_budget(struct request_queue *q,
 					      int budget_token)
 {
-- 
2.39.2

