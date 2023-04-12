Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EAAC77B76
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDLFdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDLFdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A549FD
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1P9374sRIBIGqvCd6TtE6uJrwQXedIobeMS9uvYBhao=; b=tUPTV3Ap6lBly8eVGWVVqd3geh
        0V63uaBRQ/LjrKIbrmOTdKp49Tfx72L7Tcrwu+kpH6SThUn5tLkHz7mUknY9vcJr6Rccna23AnfUg
        WTjaPgVDHmRpLqFyojHhzYg5unk7N0C9gwu0b9YRD2GXn6TgctZElrIBjQqD16j+nGzo4R2WXgoog
        MFC5Shu2xUaziUF0gXl9O/c8athIG7KKwFF1dIJxAG7T96ik9XZgREVgeNkHrCkvKPeYlSXpjyoPo
        Ktq6c8OIr/HlNpQTMkCf6F/k7ilIkqqUApoelOW9KTr27b13VhEAQcZRxqyYLvmCBpJ3iZEIAhSgZ
        emRzX2gA==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6M-001rFD-02;
        Wed, 12 Apr 2023 05:33:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 04/18] blk-mq: move more logic into blk_mq_insert_requests
Date:   Wed, 12 Apr 2023 07:32:34 +0200
Message-Id: <20230412053248.601961-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move all logic related to the direct insert into blk_mq_insert_requests
to clean the code flow up a bit, and to allow marking
blk_mq_try_issue_list_directly static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

