Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847EEC77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDMGl2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDMGl2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE98F8A4C
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TMtTlKfCuetYUJgc0QRnzMY+chc7R5bQdBcHUv8owP8=; b=3S6zM4WJ611DejkF+pPFi1LsMD
        7SdqKwqVxxeLuX9kIZaC/tvsez/fZuHFLQ46ffWYRTK10hEi2bi2kn2YLPrv4PsTD8YlEE0qj5m0H
        y4Bsj2S5LeJPseKrk65hFbf4LG/bhJcwykn4RSj6mL049UOmj30u5aXhPbBEz31pzx0dGD6TCveCw
        z8FKAFKmwXZ1zRlTQdqSGzvyeoLoHcLQeVzwqPPLwXB7vUGLiaAKoqsc99Nvw7FP4E0fkOpR1cPAs
        uD2OBxuLkvENO99LU3BQumEEEeckbKl33+QNApavGbWhVuSOIBXISTaGfEA+5YXloVZuZmp3bYQGp
        Pv8THSCA==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqdz-005BUC-28;
        Thu, 13 Apr 2023 06:41:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 08/20] blk-mq: fold __blk_mq_insert_req_list into blk_mq_insert_request
Date:   Thu, 13 Apr 2023 08:40:45 +0200
Message-Id: <20230413064057.707578-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove this very small helper and fold it into the only caller.

Note that this moves the trace_block_rq_insert out of ctx->lock, matching
the other calls to this tracepoint.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 103caf1bae2769..7e9f7d00452f11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2446,23 +2446,6 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	__blk_mq_run_hw_queue(hctx);
 }
 
-static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
-					    struct request *rq,
-					    bool at_head)
-{
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	enum hctx_type type = hctx->type;
-
-	lockdep_assert_held(&ctx->lock);
-
-	trace_block_rq_insert(rq);
-
-	if (at_head)
-		list_add(&rq->queuelist, &ctx->rq_lists[type]);
-	else
-		list_add_tail(&rq->queuelist, &ctx->rq_lists[type]);
-}
-
 /**
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
@@ -2586,8 +2569,14 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
 		list_add(&rq->queuelist, &list);
 		e->type->ops.insert_requests(hctx, &list, at_head);
 	} else {
+		trace_block_rq_insert(rq);
+
 		spin_lock(&ctx->lock);
-		__blk_mq_insert_req_list(hctx, rq, at_head);
+		if (at_head)
+			list_add(&rq->queuelist, &ctx->rq_lists[hctx->type]);
+		else
+			list_add_tail(&rq->queuelist,
+				      &ctx->rq_lists[hctx->type]);
 		blk_mq_hctx_mark_pending(hctx, ctx);
 		spin_unlock(&ctx->lock);
 	}
-- 
2.39.2

