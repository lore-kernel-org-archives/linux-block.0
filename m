Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875ADC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDKNdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDKNdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:33:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2F40C6
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9uT5pCAQNM/TdhE59Xugyzc6I8sisbErI0Qf9V6m124=; b=DHbzPoXb7uhLMranbRavXCT8UZ
        iheHhWS4zz1ImhpZRuql0jbhkMilUbx6t0qOUFzTqIDaVQILqtX/0RPhG/wKtaF4HzhrPIailO7RX
        qw8lfUnC6oEDjsApWCWMuPsql5gELF+49zspZ8eujgWUtCQgUOL3862HRJ3WVRAHzfmajBo/Ctkbi
        1LYSFtwZVDYtyrJbrov9Ysc/HS2+i7XnnFU+p1Cg/b0Rd4JXgB5ePsVs1NsL7kRKC43e7T5JG5cBe
        zN4lPGWAp/pioTeSvHizDnPiMws7Jp4lg8k8r13UbmvF/naL4SEpUNUSHlo4FrWRWK/aE+K6ZxPEj
        dzeKlrRg==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE83-0007s4-1Q;
        Tue, 11 Apr 2023 13:33:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 03/16] blk-mq: fold blk_mq_sched_insert_requests into blk_mq_dispatch_plug_list
Date:   Tue, 11 Apr 2023 15:33:16 +0200
Message-Id: <20230411133329.554624-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_dispatch_plug_list is the only caller of
blk_mq_sched_insert_requests, and it makes sense to just fold it there
as blk_mq_sched_insert_requests isn't specific to I/O scheudlers despite
the name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 24 ------------------------
 block/blk-mq-sched.h |  3 ---
 block/blk-mq.c       | 17 +++++++++++++----
 block/blk-mq.h       |  2 --
 block/mq-deadline.c  |  2 +-
 5 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 7c7de9b94aed4a..2fa8e7cb4866aa 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -457,30 +457,6 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
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
index 0250139724539a..b25ad6ce41e95c 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -19,9 +19,6 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 				 bool run_queue, bool async);
-void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
-				  struct blk_mq_ctx *ctx,
-				  struct list_head *list, bool run_queue_async);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index be06fbfe879420..6ee05416a93f6c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2499,9 +2499,9 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
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
@@ -2727,7 +2727,16 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 
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
index 89fc2bf6cb0510..192784836f8a83 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -63,8 +63,6 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 				bool at_head);
 void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 				  bool run_queue);
-void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-				struct list_head *list, bool run_queue_async);
 
 /*
  * CPU -> queue mappings
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f10c2a0d18d411..6065c93350f84f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -822,7 +822,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 }
 
 /*
- * Called from blk_mq_sched_insert_request() or blk_mq_sched_insert_requests().
+ * Called from blk_mq_sched_insert_request() or blk_mq_dispatch_plug_list().
  */
 static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       struct list_head *list, bool at_head)
-- 
2.39.2

