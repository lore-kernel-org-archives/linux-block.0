Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7900CC77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDMGlx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDMGlj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3979013
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ETZ0DgTDilFhoXLFUId9s4IBSAF7Iqpk2/nJdhCxW1Q=; b=fRN0IXIvqnpunIf8xHMUsIRkah
        B7DF1pOmQqdrLCpUm88Wjh+ssiYquLXLWBtGzqL8t730tw0NBQhpRxlVYGj+a6b0Hwlm1eXqv0rqq
        Bz5miYP0EXy0rWdTQB0+LhWlRxjD9zSYd0MyI1BRD/lHumPMvL1VlUW9KSRLQN/M6YuvMKjVbCRhd
        /93c8wZp06MC5I2P1FfjnlzOz5X5xdgxiIg6Q7d1hTj0Y94zKfRGQhW+axgQasaw/w25WJktXoY6V
        TaRoSN4yjmOhHlpeoBGVsBqvNI0YbiZpgmRRCZUNQwVHXbUP60TPJ1I4aH2xRKrK887bmWEVEOTGo
        ZQsl8IcA==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqeA-005BVR-0W;
        Thu, 13 Apr 2023 06:41:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 12/20] blk-mq: factor out a blk_mq_get_budget_and_tag helper
Date:   Thu, 13 Apr 2023 08:40:49 +0200
Message-Id: <20230413064057.707578-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out a helper from __blk_mq_try_issue_directly in preparation
of folding that function into its two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d17871c237f7df..5cb7ebefc88c14 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2624,13 +2624,27 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+static bool blk_mq_get_budget_and_tag(struct request *rq)
+{
+	int budget_token;
+
+	budget_token = blk_mq_get_dispatch_budget(rq->q);
+	if (budget_token < 0)
+		return false;
+	blk_mq_set_rq_budget_token(rq, budget_token);
+	if (!blk_mq_get_driver_tag(rq)) {
+		blk_mq_put_dispatch_budget(rq->q, budget_token);
+		return false;
+	}
+	return true;
+}
+
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						bool bypass_insert, bool last)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
-	int budget_token;
 
 	/*
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
@@ -2648,16 +2662,8 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if ((rq->rq_flags & RQF_ELV) && !bypass_insert)
 		goto insert;
 
-	budget_token = blk_mq_get_dispatch_budget(q);
-	if (budget_token < 0)
-		goto insert;
-
-	blk_mq_set_rq_budget_token(rq, budget_token);
-
-	if (!blk_mq_get_driver_tag(rq)) {
-		blk_mq_put_dispatch_budget(q, budget_token);
+	if (!blk_mq_get_budget_and_tag(rq))
 		goto insert;
-	}
 
 	return __blk_mq_issue_directly(hctx, rq, last);
 insert:
-- 
2.39.2

