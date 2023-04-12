Return-Path: <linux-block-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD0C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDLFdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDLFdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9934C2D
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rro+ZI+u2rPQ/tpmdkMzKFPLbkneC7kptEnVxugEQ5E=; b=KvDKVT5Sy4bW8LFDxmWQqQb8bU
        2VM0pATnzaJ6soORWeJi0hsHE2154TBgeeypWR9VaR2WO+OR1UkBF62STajUllOG2mp9az0tvgD8Q
        xJ7QQ5HtSt85BmvRiMDpsr4ZVXZ4Siu7WQ/R5fdgJNMDlMA6WLp8DHhh6W7sskqoY0gRLnCo3lA/P
        clFjVlfpoB0+EzFMxnhaXIEz9TBk3VwKcBMwT8EdoWAQFkKaBV1LfiGDJ/oLYvC0sDKhvP8GOg0Wp
        AY+WXezX1CAcKpfUER9/GGSuMHgF6V1H8aTrOA0LT3w3WB0CZDrBokzjQAfM2wyo2b+v0JXOBE3lY
        l+IU+pEw==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6W-001rIM-1G;
        Wed, 12 Apr 2023 05:33:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 08/18] blk-mq: fold __blk_mq_insert_req_list into blk_mq_insert_request
Date:   Wed, 12 Apr 2023 07:32:38 +0200
Message-Id: <20230412053248.601961-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove this very small helper and fold it into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

