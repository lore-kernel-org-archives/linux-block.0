Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A125C77B71
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDMGmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDMGl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA686A9
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qsLgnipHksQzf4x88w1zxj21kuAp+1+c/TuJQhFSBys=; b=2rQmG1WVNvk7g9W9MeJMONeQbg
        2bRqMF2f5K8z/+971ammoxZ+AcxwK+gpYrOEuLWcNSTLIrX+618YMPWIA8lzcnZIOlELqRJZ+Qkqn
        WB2S8dt4YujHWmW5d5unjdRKT1SnCI58cir97qUseuo8kGBFl4JwFWOPMNoDKA8a1HoLGpXh/Vqa+
        ib62yoAEvGxdlQwipyWvfkUfsyatMd+FnSh6YE2NRXBr5M2zeXVgnWDxyzqDz4utFkCninogH3L3n
        YKpABr8w/T68JfSpFzIu9wzb02Ddngglns5QCLIVjRQOBtAJ4P2T95iuqFtVNnOuLnMCcHzkcGf4L
        Y8WSIATw==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqeN-005BXd-0Y;
        Thu, 13 Apr 2023 06:41:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 17/20] blk-mq: pass a flags argument to blk_mq_insert_request
Date:   Thu, 13 Apr 2023 08:40:54 +0200
Message-Id: <20230413064057.707578-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the at_head bool with a flags argument that so far only contains
a single BLK_MQ_INSERT_AT_HEAD value.  This makes it much easier to grep
for head insertions into the blk-mq dispatch queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 27 ++++++++++++++-------------
 block/blk-mq.h |  3 +++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index db806c1a194c7b..ba64c4621e29d6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -44,7 +44,7 @@
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 
-static void blk_mq_insert_request(struct request *rq, bool at_head);
+static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list);
 
@@ -1308,7 +1308,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
 		return;
 	}
 
-	blk_mq_insert_request(rq, at_head);
+	blk_mq_insert_request(rq, at_head ? BLK_MQ_INSERT_AT_HEAD : 0);
 	blk_mq_run_hw_queue(hctx, false);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
@@ -1371,7 +1371,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	rq->end_io = blk_end_sync_rq;
 
 	blk_account_io_start(rq);
-	blk_mq_insert_request(rq, at_head);
+	blk_mq_insert_request(rq, at_head ? BLK_MQ_INSERT_AT_HEAD : 0);
 	blk_mq_run_hw_queue(hctx, false);
 
 	if (blk_rq_is_poll(rq)) {
@@ -1451,14 +1451,14 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
-			blk_mq_insert_request(rq, true);
+			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
 		}
 	}
 
 	while (!list_empty(&rq_list)) {
 		rq = list_entry(rq_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		blk_mq_insert_request(rq, false);
+		blk_mq_insert_request(rq, 0);
 	}
 
 	blk_mq_run_hw_queues(q, false);
@@ -2509,7 +2509,7 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
-static void blk_mq_insert_request(struct request *rq, bool at_head)
+static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
@@ -2526,7 +2526,7 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		 * and it is added to the scheduler queue, there is no chance to
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
-		blk_mq_request_bypass_insert(rq, at_head);
+		blk_mq_request_bypass_insert(rq, flags & BLK_MQ_INSERT_AT_HEAD);
 	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
@@ -2556,12 +2556,13 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		WARN_ON_ONCE(rq->tag != BLK_MQ_NO_TAG);
 
 		list_add(&rq->queuelist, &list);
-		q->elevator->type->ops.insert_requests(hctx, &list, at_head);
+		q->elevator->type->ops.insert_requests(hctx, &list,
+				flags & BLK_MQ_INSERT_AT_HEAD);
 	} else {
 		trace_block_rq_insert(rq);
 
 		spin_lock(&ctx->lock);
-		if (at_head)
+		if (flags & BLK_MQ_INSERT_AT_HEAD)
 			list_add(&rq->queuelist, &ctx->rq_lists[hctx->type]);
 		else
 			list_add_tail(&rq->queuelist,
@@ -2653,12 +2654,12 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret;
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
-		blk_mq_insert_request(rq, false);
+		blk_mq_insert_request(rq, 0);
 		return;
 	}
 
 	if ((rq->rq_flags & RQF_ELV) || !blk_mq_get_budget_and_tag(rq)) {
-		blk_mq_insert_request(rq, false);
+		blk_mq_insert_request(rq, 0);
 		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
@@ -2683,7 +2684,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
-		blk_mq_insert_request(rq, false);
+		blk_mq_insert_request(rq, 0);
 		return BLK_STS_OK;
 	}
 
@@ -3018,7 +3019,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	hctx = rq->mq_hctx;
 	if ((rq->rq_flags & RQF_ELV) ||
 	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
-		blk_mq_insert_request(rq, false);
+		blk_mq_insert_request(rq, 0);
 		blk_mq_run_hw_queue(hctx, true);
 	} else {
 		blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq));
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 5d3761c5006346..273eee00524b98 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -36,6 +36,9 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
+typedef unsigned int __bitwise blk_insert_t;
+#define BLK_MQ_INSERT_AT_HEAD		((__force blk_insert_t)0x01)
+
 void blk_mq_submit_bio(struct bio *bio);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
 		unsigned int flags);
-- 
2.39.2

