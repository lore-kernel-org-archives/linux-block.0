Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C914C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDKNeT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDKNeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:34:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3A1BC
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YTaMM8E2BgM0JDvCSXq/r/8j6go/9mymoi3fOcuCtwQ=; b=4HP3vSWQWvgDT5LJ27piZL1xfk
        +8Ml5V+ASCMXp2ky85wUpjyhs7+UzJFKUvTf4ASZ1g6MD/sUPJzEwlrwGwa/ysylreKjTl5rU4Xvm
        ag8+baKeZ9LCfo+fB+NQI491V64Vo7RcoO30wBPdx1LkreP54Mh5gEa5GJuQLZpsULY7KPUTCzOr9
        u+MbqRsAylmtQbDaLHEuGdqUKzGvoS65eTDBJAO7tyoBDI+yCFd+zNG/xbVAxRJLddB1zf9gqKcuL
        n9VPa/rL7ayo7Ld3J1wM421QbxoMYJRwdydsuaR2T9q7xHeoDGvT/YAjxT+8S8A3WQZH4mpaol33Y
        jIVUOGUw==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE8S-0007x2-0D;
        Tue, 11 Apr 2023 13:34:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 08/16] blk-mq: refactor passthrough vs flush handling in blk_mq_insert_request
Date:   Tue, 11 Apr 2023 15:33:21 +0200
Message-Id: <20230411133329.554624-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While both passthrough and flush requests call directly into
blk_mq_request_bypass_insert, the parameters aren't the same.
Split the handling into two separate conditionals and turn the whole
function into an if/elif/elif/else flow instead of the gotos.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 438d0eca69bd81..4bd7736c173bc8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2508,37 +2508,26 @@ static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
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
 static void blk_mq_insert_request(struct request *rq, bool at_head,
 		bool run_queue, bool async)
 {
 	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
-
-	if (blk_mq_sched_bypass_insert(hctx, rq)) {
+	if (blk_rq_is_passthrough(rq)) {
+		/*
+		 * Passthrough request have to be added to hctx->dispatch
+		 * directly.  The device may be in a situation where it can't
+		 * handle FS request, and always returns BLK_STS_RESOURCE for
+		 * them, which gets them added to hctx->dispatch.
+		 *
+		 * If a passthrough request is required to unblock the queues,
+		 * and it is added to the scheduler queue, there is no chance to
+		 * dispatch it given we prioritize requests in hctx->dispatch.
+		 */
+		blk_mq_request_bypass_insert(rq, at_head, false);
+	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
 		 * sw queue, meantime we add flush request to dispatch queue(
@@ -2560,16 +2549,14 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
 		 * Simply queue flush rq to the front of hctx->dispatch so that
 		 * intensive flush workloads can benefit in case of NCQ HW.
 		 */
-		at_head = (rq->rq_flags & RQF_FLUSH_SEQ) ? true : at_head;
-		blk_mq_request_bypass_insert(rq, at_head, false);
-		goto run;
-	}
-
-	if (e) {
+		blk_mq_request_bypass_insert(rq, true, false);
+	} else if (q->elevator) {
 		LIST_HEAD(list);
 
+		WARN_ON_ONCE(rq->tag != BLK_MQ_NO_TAG);
+
 		list_add(&rq->queuelist, &list);
-		e->type->ops.insert_requests(hctx, &list, at_head);
+		q->elevator->type->ops.insert_requests(hctx, &list, at_head);
 	} else {
 		trace_block_rq_insert(rq);
 
@@ -2583,7 +2570,6 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
 		spin_unlock(&ctx->lock);
 	}
 
-run:
 	if (run_queue)
 		blk_mq_run_hw_queue(hctx, async);
 }
-- 
2.39.2

