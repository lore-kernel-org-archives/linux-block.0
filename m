Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC3BC77B73
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDMGl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjDMGlq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593F7ECF
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QKE61Pg36TLIuJ4jcy+tuRkq6LLxJ9h8r54jEamR+3A=; b=fQg0TZBgH42upTAb76xikzbCyh
        iv0C7PjwGVKKG3PI2OMtxVPGetQE8I4dC0GVayyxA9O2J16x6iAav12AvQa6piUJMGs2MQhwN++14
        QjSB3zn0MAOrZJbruFku98eXuLtDiiZoLAdkjTKybK3e9TJE+11Gs6jnlHiNNOxrIFdb4rhAFCobU
        wLO2Qi5Zmvl+dEN53+10q7lBhvgMkQtZyEHhL/YHNxuoXAmT9dsYzLuJ2SaVItV5FnA8TeL6a5yHP
        1p1oZ66B0pOWDBy9QZhwrYYp0ZH6xYuYPocZbEaTgNh+TOH2AIVQnEg2CemIZiCD/tsFNHVObOFoW
        9Nd9gFKA==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqeF-005BWh-1O;
        Thu, 13 Apr 2023 06:41:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 14/20] blk-mq: don't run the hw_queue from blk_mq_insert_request
Date:   Thu, 13 Apr 2023 08:40:51 +0200
Message-Id: <20230413064057.707578-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_insert_request takes two bool parameters to control how to run
the queue at the end of the function.  Move the blk_mq_run_hw_queue call
to the callers that want it instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c5b42476337c99..d1941db1ad3c97 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -44,8 +44,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
-static void blk_mq_insert_request(struct request *rq, bool at_head,
-		bool run_queue, bool async);
+static void blk_mq_insert_request(struct request *rq, bool at_head);
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list);
 
@@ -1292,6 +1291,8 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
  */
 void blk_execute_rq_nowait(struct request *rq, bool at_head)
 {
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
 
@@ -1302,10 +1303,13 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 	 * device, directly accessing the plug instead of using blk_mq_plug()
 	 * should not have any consequences.
 	 */
-	if (current->plug && !at_head)
+	if (current->plug && !at_head) {
 		blk_add_rq_to_plug(current->plug, rq);
-	else
-		blk_mq_insert_request(rq, at_head, true, false);
+		return;
+	}
+
+	blk_mq_insert_request(rq, at_head);
+	blk_mq_run_hw_queue(hctx, false);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
@@ -1355,6 +1359,7 @@ static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
  */
 blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 {
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	struct blk_rq_wait wait = {
 		.done = COMPLETION_INITIALIZER_ONSTACK(wait.done),
 	};
@@ -1366,7 +1371,8 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	rq->end_io = blk_end_sync_rq;
 
 	blk_account_io_start(rq);
-	blk_mq_insert_request(rq, at_head, true, false);
+	blk_mq_insert_request(rq, at_head);
+	blk_mq_run_hw_queue(hctx, false);
 
 	if (blk_rq_is_poll(rq)) {
 		blk_rq_poll_completion(rq, &wait.done);
@@ -1440,14 +1446,14 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
-			blk_mq_insert_request(rq, true, false, false);
+			blk_mq_insert_request(rq, true);
 		}
 	}
 
 	while (!list_empty(&rq_list)) {
 		rq = list_entry(rq_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		blk_mq_insert_request(rq, false, false, false);
+		blk_mq_insert_request(rq, false);
 	}
 
 	blk_mq_run_hw_queues(q, false);
@@ -2507,8 +2513,7 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
-static void blk_mq_insert_request(struct request *rq, bool at_head,
-		bool run_queue, bool async)
+static void blk_mq_insert_request(struct request *rq, bool at_head)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
@@ -2568,9 +2573,6 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
 		blk_mq_hctx_mark_pending(hctx, ctx);
 		spin_unlock(&ctx->lock);
 	}
-
-	if (run_queue)
-		blk_mq_run_hw_queue(hctx, async);
 }
 
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
@@ -2655,12 +2657,13 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret;
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
-		blk_mq_insert_request(rq, false, false, false);
+		blk_mq_insert_request(rq, false);
 		return;
 	}
 
 	if ((rq->rq_flags & RQF_ELV) || !blk_mq_get_budget_and_tag(rq)) {
-		blk_mq_insert_request(rq, false, true, false);
+		blk_mq_insert_request(rq, false);
+		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
 
@@ -2683,7 +2686,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
-		blk_mq_insert_request(rq, false, false, false);
+		blk_mq_insert_request(rq, false);
 		return BLK_STS_OK;
 	}
 
@@ -2963,6 +2966,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blk_plug *plug = blk_mq_plug(bio);
 	const int is_sync = op_is_sync(bio->bi_opf);
+	struct blk_mq_hw_ctx *hctx;
 	struct request *rq;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
@@ -3007,15 +3011,19 @@ void blk_mq_submit_bio(struct bio *bio)
 		return;
 	}
 
-	if (plug)
+	if (plug) {
 		blk_add_rq_to_plug(plug, rq);
-	else if ((rq->rq_flags & RQF_ELV) ||
-		 (rq->mq_hctx->dispatch_busy &&
-		  (q->nr_hw_queues == 1 || !is_sync)))
-		blk_mq_insert_request(rq, false, true, true);
-	else
-		blk_mq_run_dispatch_ops(rq->q,
-				blk_mq_try_issue_directly(rq->mq_hctx, rq));
+		return;
+	}
+
+	hctx = rq->mq_hctx;
+	if ((rq->rq_flags & RQF_ELV) ||
+	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
+		blk_mq_insert_request(rq, false);
+		blk_mq_run_hw_queue(hctx, true);
+	} else {
+		blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq));
+	}
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
-- 
2.39.2

