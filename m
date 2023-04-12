Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E4C77B73
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDLFd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDLFd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AA4268A
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uBm7JobwJJslWmTbYyHUNeOmYyQL4JdlutPxKLvaYV8=; b=irbaKZVCqQVMjs1bxTBdAtM+vJ
        KIsZa4Id895QN09jguHvYq/ymEmMn4+WWooIYfOQtGrrGIhw3VkOYRGp/HqOMYlMZAW+5xv3DwTLY
        HjSktFUzRJrQOj87Li/N1BmXQO6ORQTCbZmx7bwBq0TjUvYzeg6GbmaqAq8DJx53th1cH31dmeGXU
        Wmn8ZiLMzOGiNg3jdog2yZSuMRdpA2IZDnl8cGL0cTLrewqo74rIDUn6pvu7TrTK/dTXmX0qjbwRi
        pkR5uhcbJlQ8d57hvkbWk7W+4IwcDlX/WJvgukLgxRqYbU50i6hLtxHqy8/UbAldWH1tNeAW1mNMs
        pOfTWDSg==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6g-001rJw-1a;
        Wed, 12 Apr 2023 05:33:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 12/18] blk-mq: factor out a blk_mq_get_budget_and_tag helper
Date:   Wed, 12 Apr 2023 07:32:42 +0200
Message-Id: <20230412053248.601961-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
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
---
 block/blk-mq.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5dfb927d1b9145..54bd8e30c30abd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2623,13 +2623,27 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
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
@@ -2647,16 +2661,8 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
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

