Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBBDC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDKNd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDKNd6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:33:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F23C39
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=x7P+NwuJNE4IJ+GuHqkmzJn6c6h3EkWUNhGKkUg36kg=; b=gEeOuZVB0KCb02LwxRifS4SeQf
        sQy4tYgIE+WTwycn8y621qLPHDBhOTmdlA0gCDN457NJCqS+9qTnJk9vdLWq1hgw1iLieBD0VgcGw
        PoIUzIQrE5Ao36B1412iOUzpu1YYK4asLglOgsJzW05UxSrGi8rLBMnvB77ORC6EHh/XBR17tz6dp
        cQjQL69bF4rxZI/AaeMZqgykYjenX5UudzSXxzDXdU6/y+Jvh/6K07A0JSlUNgMc4JAi+QKby8/Xv
        RICyOHSfSr9YWugviFZn5lsl+IpU+BLaPuH+modjGv7u4NHyB/zXJrmPOOdZXdunqyj05TqZRUBz7
        hhMOBsiA==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE8C-0007tg-28;
        Tue, 11 Apr 2023 13:33:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 05/16] blk-mq: fold __blk_mq_insert_request into blk_mq_insert_request
Date:   Tue, 11 Apr 2023 15:33:18 +0200
Message-Id: <20230411133329.554624-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no good point in keeping the __blk_mq_insert_request around
for two function calls and a singler caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 14 ++------------
 block/blk-mq.h |  2 --
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 05be4ae4fc0dba..4f0ecd0561e48f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2465,17 +2465,6 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
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
@@ -2600,7 +2589,8 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
 		e->type->ops.insert_requests(hctx, &list, at_head);
 	} else {
 		spin_lock(&ctx->lock);
-		__blk_mq_insert_request(hctx, rq, at_head);
+		__blk_mq_insert_req_list(hctx, rq, at_head);
+		blk_mq_hctx_mark_pending(hctx, ctx);
 		spin_unlock(&ctx->lock);
 	}
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 192784836f8a83..c2aec5cbfa7663 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -59,8 +59,6 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 /*
  * Internal helpers for request insertion into sw queues
  */
-void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
-				bool at_head);
 void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 				  bool run_queue);
 
-- 
2.39.2

