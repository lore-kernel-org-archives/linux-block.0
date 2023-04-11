Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66CBC77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDKNeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDKNeG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:34:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FB14EE8
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WFUajtszmpsOtzIOwkpcTC9bWC+TFQbCH5N2SBR55xc=; b=cBz4THbuKWlFOFDtNP/Mcl+C7j
        JovRRviRmZZd8/7DjpFjYtXcVAGqedntG96IBSR+DeZvr6bQKuzrgseLSMQZ5DCsR164596eejJhi
        kI6gmWFSZqpgjaSEQhqLicPHuOcFQ6FxZ8KMTw0Bc+s7VAtH8MfrQFclRA9EQM3cqiYdHEstOiawr
        VPpJXKg2CS+jhKRRhIbLK4/A6qqGedDm0KlapOPH7xPj981hyi1SWbx7n+9ktmRoL2LhWXgj/lin/
        4pcHdmJLdSei7F4cJIdEhkOOdet1Rvnszt6gk4/oZyzKRr0Inv0Se+t1VQQcNYp8L8IWupZFiEjrl
        jzL3BPiQ==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE8I-0007vC-0x;
        Tue, 11 Apr 2023 13:34:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 06/16] blk-mq: fold __blk_mq_insert_req_list into blk_mq_insert_request
Date:   Tue, 11 Apr 2023 15:33:19 +0200
Message-Id: <20230411133329.554624-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove this very small helper and fold it into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f0ecd0561e48f..438d0eca69bd81 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2448,23 +2448,6 @@ static void blk_mq_run_work_fn(struct work_struct *work)
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
@@ -2588,8 +2571,14 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
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

