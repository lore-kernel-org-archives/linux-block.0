Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DA3C77B73
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDLFdM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDLFdM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA91F268A
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EXAxMbBp1CYMTeT+FBKpJnWmaTCMRlnQtgKWlw9PmNo=; b=Dn87i0Rnkt4kX4WF4YFi9phG9B
        bVwks3Ol4U/bfwF3Vko/vU9CKKTV1UHaFkZVW2rvMeW4RxZl7wOHiF98PHt/Sm7zix0mII7MYZVZ0
        ixnWtNQMjzfgexgnldiyOwyR+SbH9gxX7zaxQXRD4zjgWrbVs7lZ0sVpu30tlEM5YK8SUY6qKVoIm
        P1QRL5FOwIehYTMaBVpjof1YF9klk3yW5QWpLjHEUt7q3JQ1/85u116sqI1xldO3yen9rVuDkXyXD
        qNsPXSjJbq7ksQkGRqfTR20TwLP2NDpllYl2/7VIOzamdquFDvAhECAZp6ZLS73P2weC/tsgmiwDr
        8rf9pcSg==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6T-001rGb-2a;
        Wed, 12 Apr 2023 05:33:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 07/18] blk-mq: fold __blk_mq_insert_request into blk_mq_insert_request
Date:   Wed, 12 Apr 2023 07:32:37 +0200
Message-Id: <20230412053248.601961-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no good point in keeping the __blk_mq_insert_request around
for two function calls and a singler caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 14 ++------------
 block/blk-mq.h |  2 --
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 78e54a64fe920b..103caf1bae2769 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2463,17 +2463,6 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 		list_add_tail(&rq->queuelist, &ctx->rq_lists[type]);
 }
 
-void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
-			     bool at_head)
-{
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-
-	lockdep_assert_held(&ctx->lock);
-
-	__blk_mq_insert_req_list(hctx, rq, at_head);
-	blk_mq_hctx_mark_pending(hctx, ctx);
-}
-
 /**
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
@@ -2598,7 +2587,8 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
 		e->type->ops.insert_requests(hctx, &list, at_head);
 	} else {
 		spin_lock(&ctx->lock);
-		__blk_mq_insert_request(hctx, rq, at_head);
+		__blk_mq_insert_req_list(hctx, rq, at_head);
+		blk_mq_hctx_mark_pending(hctx, ctx);
 		spin_unlock(&ctx->lock);
 	}
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index bd7ae5e67a526b..e2d59e33046e30 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -65,8 +65,6 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 /*
  * Internal helpers for request insertion into sw queues
  */
-void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
-				bool at_head);
 void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 				  bool run_queue);
 
-- 
2.39.2

