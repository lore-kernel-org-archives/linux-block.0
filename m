Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB2C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDMGlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMGlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2886AC
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=z/C24hRh/yPojkFGpajUx2U+tiWzKuXsGaGArZK0Wv8=; b=IuOL0cyMLp0yEG7jsViyWzU9L9
        eFkh4Rk+tyZuZrEZ/iA4dD4do2n/jq+ii38gUTiSF0fQQ+NOvJp3yjd9sT8FoRs0hfN/ieEi5kvhF
        pDj1ZjJNhuJthDXPoxuDAaXmj3R/FoZ6UqLz1+C0b1J6ERUhkvzovIIpwOtBMVdMMBHsJdS/i6F56
        P5BvjwtejHAVb5tsuUxaM2J7E6jeh1pOa7RneT9u2fn+2GC8XJYf90s95ie4DJ2BQmlcG9JPbTEDE
        AcuuDiwQp8gUK+co1sUadU3CvI9G3a77M57LBFimVmocUNn3JNwiVUaE4iCC1toehc7+NOPFoKC3g
        4FtEhpDg==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqdu-005BSt-1Q;
        Thu, 13 Apr 2023 06:41:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 06/20] blk-mq: move blk_mq_sched_insert_request to blk-mq.c
Date:   Thu, 13 Apr 2023 08:40:43 +0200
Message-Id: <20230413064057.707578-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_sched_insert_request is the main request insert helper and not
directly I/O scheduler related.  Move blk_mq_sched_insert_request to
blk-mq.c, rename it to blk_mq_insert_request and mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq-sched.c | 73 -------------------------------------
 block/blk-mq-sched.h |  3 --
 block/blk-mq.c       | 87 +++++++++++++++++++++++++++++++++++++++++---
 block/mq-deadline.c  |  2 +-
 4 files changed, 82 insertions(+), 83 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9c0d231722d9ce..f90fc42a88ca2f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -382,79 +382,6 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
-static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
-				       struct request *rq)
-{
-	/*
-	 * dispatch flush and passthrough rq directly
-	 *
-	 * passthrough request has to be added to hctx->dispatch directly.
-	 * For some reason, device may be in one situation which can't
-	 * handle FS request, so STS_RESOURCE is always returned and the
-	 * FS request will be added to hctx->dispatch. However passthrough
-	 * request may be required at that time for fixing the problem. If
-	 * passthrough request is added to scheduler queue, there isn't any
-	 * chance to dispatch it given we prioritize requests in hctx->dispatch.
-	 */
-	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
-		return true;
-
-	return false;
-}
-
-void blk_mq_sched_insert_request(struct request *rq, bool at_head,
-				 bool run_queue, bool async)
-{
-	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-
-	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
-
-	if (blk_mq_sched_bypass_insert(hctx, rq)) {
-		/*
-		 * Firstly normal IO request is inserted to scheduler queue or
-		 * sw queue, meantime we add flush request to dispatch queue(
-		 * hctx->dispatch) directly and there is at most one in-flight
-		 * flush request for each hw queue, so it doesn't matter to add
-		 * flush request to tail or front of the dispatch queue.
-		 *
-		 * Secondly in case of NCQ, flush request belongs to non-NCQ
-		 * command, and queueing it will fail when there is any
-		 * in-flight normal IO request(NCQ command). When adding flush
-		 * rq to the front of hctx->dispatch, it is easier to introduce
-		 * extra time to flush rq's latency because of S_SCHED_RESTART
-		 * compared with adding to the tail of dispatch queue, then
-		 * chance of flush merge is increased, and less flush requests
-		 * will be issued to controller. It is observed that ~10% time
-		 * is saved in blktests block/004 on disk attached to AHCI/NCQ
-		 * drive when adding flush rq to the front of hctx->dispatch.
-		 *
-		 * Simply queue flush rq to the front of hctx->dispatch so that
-		 * intensive flush workloads can benefit in case of NCQ HW.
-		 */
-		at_head = (rq->rq_flags & RQF_FLUSH_SEQ) ? true : at_head;
-		blk_mq_request_bypass_insert(rq, at_head, false);
-		goto run;
-	}
-
-	if (e) {
-		LIST_HEAD(list);
-
-		list_add(&rq->queuelist, &list);
-		e->type->ops.insert_requests(hctx, &list, at_head);
-	} else {
-		spin_lock(&ctx->lock);
-		__blk_mq_insert_request(hctx, rq, at_head);
-		spin_unlock(&ctx->lock);
-	}
-
-run:
-	if (run_queue)
-		blk_mq_run_hw_queue(hctx, async);
-}
-
 static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
 					  struct blk_mq_hw_ctx *hctx,
 					  unsigned int hctx_idx)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1ec01e9934dc45..7c3cbad17f3052 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -16,9 +16,6 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
-void blk_mq_sched_insert_request(struct request *rq, bool at_head,
-				 bool run_queue, bool async);
-
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f1da4f053cc691..78e54a64fe920b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -44,6 +44,8 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
+static void blk_mq_insert_request(struct request *rq, bool at_head,
+		bool run_queue, bool async);
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list);
 
@@ -1303,7 +1305,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 	if (current->plug && !at_head)
 		blk_add_rq_to_plug(current->plug, rq);
 	else
-		blk_mq_sched_insert_request(rq, at_head, true, false);
+		blk_mq_insert_request(rq, at_head, true, false);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
@@ -1364,7 +1366,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	rq->end_io = blk_end_sync_rq;
 
 	blk_account_io_start(rq);
-	blk_mq_sched_insert_request(rq, at_head, true, false);
+	blk_mq_insert_request(rq, at_head, true, false);
 
 	if (blk_rq_is_poll(rq)) {
 		blk_rq_poll_completion(rq, &wait.done);
@@ -1438,13 +1440,13 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		if (rq->rq_flags & RQF_DONTPREP)
 			blk_mq_request_bypass_insert(rq, false, false);
 		else
-			blk_mq_sched_insert_request(rq, true, false, false);
+			blk_mq_insert_request(rq, true, false, false);
 	}
 
 	while (!list_empty(&rq_list)) {
 		rq = list_entry(rq_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		blk_mq_sched_insert_request(rq, false, false, false);
+		blk_mq_insert_request(rq, false, false, false);
 	}
 
 	blk_mq_run_hw_queues(q, false);
@@ -2532,6 +2534,79 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
+static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
+				       struct request *rq)
+{
+	/*
+	 * dispatch flush and passthrough rq directly
+	 *
+	 * passthrough request has to be added to hctx->dispatch directly.
+	 * For some reason, device may be in one situation which can't
+	 * handle FS request, so STS_RESOURCE is always returned and the
+	 * FS request will be added to hctx->dispatch. However passthrough
+	 * request may be required at that time for fixing the problem. If
+	 * passthrough request is added to scheduler queue, there isn't any
+	 * chance to dispatch it given we prioritize requests in hctx->dispatch.
+	 */
+	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
+		return true;
+
+	return false;
+}
+
+static void blk_mq_insert_request(struct request *rq, bool at_head,
+		bool run_queue, bool async)
+{
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+	struct blk_mq_ctx *ctx = rq->mq_ctx;
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
+
+	if (blk_mq_sched_bypass_insert(hctx, rq)) {
+		/*
+		 * Firstly normal IO request is inserted to scheduler queue or
+		 * sw queue, meantime we add flush request to dispatch queue(
+		 * hctx->dispatch) directly and there is at most one in-flight
+		 * flush request for each hw queue, so it doesn't matter to add
+		 * flush request to tail or front of the dispatch queue.
+		 *
+		 * Secondly in case of NCQ, flush request belongs to non-NCQ
+		 * command, and queueing it will fail when there is any
+		 * in-flight normal IO request(NCQ command). When adding flush
+		 * rq to the front of hctx->dispatch, it is easier to introduce
+		 * extra time to flush rq's latency because of S_SCHED_RESTART
+		 * compared with adding to the tail of dispatch queue, then
+		 * chance of flush merge is increased, and less flush requests
+		 * will be issued to controller. It is observed that ~10% time
+		 * is saved in blktests block/004 on disk attached to AHCI/NCQ
+		 * drive when adding flush rq to the front of hctx->dispatch.
+		 *
+		 * Simply queue flush rq to the front of hctx->dispatch so that
+		 * intensive flush workloads can benefit in case of NCQ HW.
+		 */
+		at_head = (rq->rq_flags & RQF_FLUSH_SEQ) ? true : at_head;
+		blk_mq_request_bypass_insert(rq, at_head, false);
+		goto run;
+	}
+
+	if (e) {
+		LIST_HEAD(list);
+
+		list_add(&rq->queuelist, &list);
+		e->type->ops.insert_requests(hctx, &list, at_head);
+	} else {
+		spin_lock(&ctx->lock);
+		__blk_mq_insert_request(hctx, rq, at_head);
+		spin_unlock(&ctx->lock);
+	}
+
+run:
+	if (run_queue)
+		blk_mq_run_hw_queue(hctx, async);
+}
+
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -2623,7 +2698,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-	blk_mq_sched_insert_request(rq, false, run_queue, false);
+	blk_mq_insert_request(rq, false, run_queue, false);
 
 	return BLK_STS_OK;
 }
@@ -2975,7 +3050,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	else if ((rq->rq_flags & RQF_ELV) ||
 		 (rq->mq_hctx->dispatch_busy &&
 		  (q->nr_hw_queues == 1 || !is_sync)))
-		blk_mq_sched_insert_request(rq, false, true, true);
+		blk_mq_insert_request(rq, false, true, true);
 	else
 		blk_mq_run_dispatch_ops(rq->q,
 				blk_mq_try_issue_directly(rq->mq_hctx, rq));
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index d62a3039c8e04f..ceae477c3571a3 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -820,7 +820,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 }
 
 /*
- * Called from blk_mq_sched_insert_request() or blk_mq_dispatch_plug_list().
+ * Called from blk_mq_insert_request() or blk_mq_dispatch_plug_list().
  */
 static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       struct list_head *list, bool at_head)
-- 
2.39.2

