Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67FBC77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDMGlO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDMGlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99EA7DB3
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=57fSP5P4UMuAQLmqbWQVQVOtH1jl/55EtztjrWDOGkc=; b=lH8Anpmvo42eYpGsPQpk+3kIDO
        nPEKctSdQw/SeP/3drhIUqE51kZzNAwwz9xyuAk2mgOBVgYJdSCWRO3gF76VKjt00P+Kof2HfYL6g
        wH0yXmJohz5XuJdItC0TiK9CWQ5Z8FXfGN4xT6xWg/EPA03n70YjlaTY9OnnIFo9iPieWdH83ThZv
        b4JujuLMB57jQoGatYGwi44m+BK0bgMc/5+lN3jcrqUnXTmBeU9jrF0kAf0TXTYXJxc4YKh1MYBL7
        pa5QpR0GnvaUzGtqMT7nZPbKjCiJDZ8xN5Hvc1JQRpXiE5BYICIfn2FJdjTGpe2pwieKOIrIPbZ/V
        QhOLZIfw==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqdp-005BRq-1A;
        Thu, 13 Apr 2023 06:41:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 04/20] blk-mq: move more logic into blk_mq_insert_requests
Date:   Thu, 13 Apr 2023 08:40:41 +0200
Message-Id: <20230413064057.707578-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move all logic related to the direct insert (including the call to
blk_mq_run_hw_queue) into blk_mq_insert_requests to streamline the code
flow up a bit, and to allow marking blk_mq_try_issue_list_directly
static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq-sched.c | 17 ++---------------
 block/blk-mq.c       | 20 ++++++++++++++++++--
 block/blk-mq.h       |  4 +---
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c4b2d44b2d4ebf..811a9765b745c0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -472,23 +472,10 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 	e = hctx->queue->elevator;
 	if (e) {
 		e->type->ops.insert_requests(hctx, list, false);
+		blk_mq_run_hw_queue(hctx, run_queue_async);
 	} else {
-		/*
-		 * try to issue requests directly if the hw queue isn't
-		 * busy in case of 'none' scheduler, and this way may save
-		 * us one extra enqueue & dequeue to sw queue.
-		 */
-		if (!hctx->dispatch_busy && !run_queue_async) {
-			blk_mq_run_dispatch_ops(hctx->queue,
-				blk_mq_try_issue_list_directly(hctx, list));
-			if (list_empty(list))
-				goto out;
-		}
-		blk_mq_insert_requests(hctx, ctx, list);
+		blk_mq_insert_requests(hctx, ctx, list, run_queue_async);
 	}
-
-	blk_mq_run_hw_queue(hctx, run_queue_async);
- out:
 	percpu_ref_put(&q->q_usage_counter);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29014a0f9f39b1..536f001282bb63 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -44,6 +44,9 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
+static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
+		struct list_head *list);
+
 static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(struct request_queue *q,
 		blk_qc_t qc)
 {
@@ -2495,12 +2498,23 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 }
 
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-			    struct list_head *list)
+			    struct list_head *list, bool run_queue_async)
 
 {
 	struct request *rq;
 	enum hctx_type type = hctx->type;
 
+	/*
+	 * Try to issue requests directly if the hw queue isn't busy to save an
+	 * extra enqueue & dequeue to the sw queue.
+	 */
+	if (!hctx->dispatch_busy && !run_queue_async) {
+		blk_mq_run_dispatch_ops(hctx->queue,
+			blk_mq_try_issue_list_directly(hctx, list));
+		if (list_empty(list))
+			goto out;
+	}
+
 	/*
 	 * preemption doesn't flush plug list, so it's possible ctx->cpu is
 	 * offline now
@@ -2514,6 +2528,8 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	list_splice_tail_init(list, &ctx->rq_lists[type]);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 	spin_unlock(&ctx->lock);
+out:
+	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
@@ -2755,7 +2771,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	} while (!rq_list_empty(plug->mq_list));
 }
 
-void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
+static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
 	int queued = 0;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index fa13b694ff27d6..5d551f9ef2d6be 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -70,9 +70,7 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 				  bool run_queue);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-				struct list_head *list);
-void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
-				    struct list_head *list);
+				struct list_head *list, bool run_queue_async);
 
 /*
  * CPU -> queue mappings
-- 
2.39.2

