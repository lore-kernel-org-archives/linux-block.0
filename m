Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C2C77B77
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDLFdH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLFdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966BB4680
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uR+2N3reK7Ks88rF1/UOtDp7owoctQ2Yygc4XGrRIt0=; b=QuFopAJjmAwO+1qBzmSxw4YqxJ
        uGMAJEuJSuv8H4GqT60Mb3+KjpXZGre7I4tsplazaAORLCidSfN9cQA+O8SZFTyeK/VJCUKsh0iTF
        Jllb6ywHmfuX4ERTOaxcK+IoRT4fitZMZVTtVQfz2nh2TE0hUqomhp0UxWoRJpvEcJHWWl4cLOw3M
        EvbAe/N1utbUrYtxvYCYT9JFSPx9FI2loTyPbf+5ADtZPyyCgN7Mjlf7rhBCxoMGdG+xlb9SLviHJ
        oUyJn8o1kyioRt1ZQ+3fR7V0ZR5JPk3Nb2Oo15H3gXuJOj8Pg6zH64dbyFszkVu6xIfcRwVzgQ+iE
        Ew34mtOA==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6O-001rFm-1w;
        Wed, 12 Apr 2023 05:33:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 05/18] blk-mq: fold blk_mq_sched_insert_requests into blk_mq_dispatch_plug_list
Date:   Wed, 12 Apr 2023 07:32:35 +0200
Message-Id: <20230412053248.601961-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_dispatch_plug_list is the only caller of
blk_mq_sched_insert_requests, and it makes sense to just fold it there
as blk_mq_sched_insert_requests isn't specific to I/O schedulers despite
the name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sched.c | 24 ------------------------
 block/blk-mq-sched.h |  3 ---
 block/blk-mq.c       | 17 +++++++++++++----
 block/blk-mq.h       |  2 --
 block/mq-deadline.c  |  2 +-
 5 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 811a9765b745c0..9c0d231722d9ce 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -455,30 +455,6 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		blk_mq_run_hw_queue(hctx, async);
 }
 
-void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
-				  struct blk_mq_ctx *ctx,
-				  struct list_head *list, bool run_queue_async)
-{
-	struct elevator_queue *e;
-	struct request_queue *q = hctx->queue;
-
-	/*
-	 * blk_mq_sched_insert_requests() is called from flush plug
-	 * context only, and hold one usage counter to prevent queue
-	 * from being released.
-	 */
-	percpu_ref_get(&q->q_usage_counter);
-
-	e = hctx->queue->elevator;
-	if (e) {
-		e->type->ops.insert_requests(hctx, list, false);
-		blk_mq_run_hw_queue(hctx, run_queue_async);
-	} else {
-		blk_mq_insert_requests(hctx, ctx, list, run_queue_async);
-	}
-	percpu_ref_put(&q->q_usage_counter);
-}
-
 static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
 					  struct blk_mq_hw_ctx *hctx,
 					  unsigned int hctx_idx)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 65cab6e475be8e..1ec01e9934dc45 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -18,9 +18,6 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 				 bool run_queue, bool async);
-void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
-				  struct blk_mq_ctx *ctx,
-				  struct list_head *list, bool run_queue_async);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 536f001282bb63..f1da4f053cc691 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2497,9 +2497,9 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 		blk_mq_run_hw_queue(hctx, false);
 }
 
-void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-			    struct list_head *list, bool run_queue_async)
-
+static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
+		struct blk_mq_ctx *ctx, struct list_head *list,
+		bool run_queue_async)
 {
 	struct request *rq;
 	enum hctx_type type = hctx->type;
@@ -2725,7 +2725,16 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 
 	plug->mq_list = requeue_list;
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
-	blk_mq_sched_insert_requests(this_hctx, this_ctx, &list, from_sched);
+
+	percpu_ref_get(&this_hctx->queue->q_usage_counter);
+	if (this_hctx->queue->elevator) {
+		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
+				&list, false);
+		blk_mq_run_hw_queue(this_hctx, from_sched);
+	} else {
+		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
+	}
+	percpu_ref_put(&this_hctx->queue->q_usage_counter);
 }
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 5d551f9ef2d6be..bd7ae5e67a526b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -69,8 +69,6 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 				bool at_head);
 void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 				  bool run_queue);
-void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-				struct list_head *list, bool run_queue_async);
 
 /*
  * CPU -> queue mappings
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index af9e79050dcc1f..d62a3039c8e04f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -820,7 +820,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 }
 
 /*
- * Called from blk_mq_sched_insert_request() or blk_mq_sched_insert_requests().
+ * Called from blk_mq_sched_insert_request() or blk_mq_dispatch_plug_list().
  */
 static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       struct list_head *list, bool at_head)
-- 
2.39.2

