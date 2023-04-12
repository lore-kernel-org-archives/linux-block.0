Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743D7C77B77
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDLFda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDLFd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305894EDA
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UO36R7/4WBCLEponLbFuVTPZS5Qp1MteACE82XudWXU=; b=ofiprRwZ0wGXtvppwmgdVhq0FP
        j2ko+9GDj5S4E9Wq3MKT+RZWg/HXnza7ud6MoVnz0DY1ed2yo/2KWGV5KwSo5pjAIPXYpxnA84g2e
        djauP3sOjLdYa8XiujWMLjx0Ytllty6PFFcZtBXjRUFPksNg/nvLIe+tsj7NwHOPS8hi/3/foh45D
        IgeHTXfoMGtu/PEWpeI7cPaXUNTa/QbKmvqTXJ7hmRJI5hXMfscVm8/BHC+1piNJB37DrHE2el59C
        MJ0t/r8nrFZAgWtLk9fpa4lE5qhV81GlHMTGVCHn6TMT+kdC5vTTEY3xiCvp47XZ5RQnXjrLP/rX4
        DpEu/SAA==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6j-001rKR-0A;
        Wed, 12 Apr 2023 05:33:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 13/18] blk-mq: fold __blk_mq_try_issue_directly into its two callers
Date:   Wed, 12 Apr 2023 07:32:43 +0200
Message-Id: <20230412053248.601961-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Due the wildly different behavior based on the bypass_insert argument,
not a whole lot of code in __blk_mq_try_issue_directly is actually shared
between blk_mq_try_issue_directly and blk_mq_request_issue_directly.

Remove __blk_mq_try_issue_directly and fold the code into the two callers
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 72 ++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 54bd8e30c30abd..4309debfa1ca84 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2638,42 +2638,6 @@ static bool blk_mq_get_budget_and_tag(struct request *rq)
 	return true;
 }
 
-static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-						struct request *rq,
-						bool bypass_insert, bool last)
-{
-	struct request_queue *q = rq->q;
-	bool run_queue = true;
-
-	/*
-	 * RCU or SRCU read lock is needed before checking quiesced flag.
-	 *
-	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
-	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
-	 * and avoid driver to try to dispatch again.
-	 */
-	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
-		run_queue = false;
-		bypass_insert = false;
-		goto insert;
-	}
-
-	if ((rq->rq_flags & RQF_ELV) && !bypass_insert)
-		goto insert;
-
-	if (!blk_mq_get_budget_and_tag(rq))
-		goto insert;
-
-	return __blk_mq_issue_directly(hctx, rq, last);
-insert:
-	if (bypass_insert)
-		return BLK_STS_RESOURCE;
-
-	blk_mq_insert_request(rq, false, run_queue, false);
-
-	return BLK_STS_OK;
-}
-
 /**
  * blk_mq_try_issue_directly - Try to send a request directly to device driver.
  * @hctx: Pointer of the associated hardware queue.
@@ -2687,18 +2651,44 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq)
 {
-	blk_status_t ret =
-		__blk_mq_try_issue_directly(hctx, rq, false, true);
+	blk_status_t ret;
+
+	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
+		blk_mq_insert_request(rq, false, false, false);
+		return;
+	}
+
+	if ((rq->rq_flags & RQF_ELV) || !blk_mq_get_budget_and_tag(rq)) {
+		blk_mq_insert_request(rq, false, true, false);
+		return;
+	}
 
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
+	ret = __blk_mq_issue_directly(hctx, rq, true);
+	switch (ret) {
+	case BLK_STS_OK:
+		break;
+	case BLK_STS_RESOURCE:
+	case BLK_STS_DEV_RESOURCE:
 		blk_mq_request_bypass_insert(rq, false, true);
-	else if (ret != BLK_STS_OK)
+		break;
+	default:
 		blk_mq_end_request(rq, ret);
+		break;
+	}
 }
 
 static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
-	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
+		blk_mq_insert_request(rq, false, false, false);
+		return BLK_STS_OK;
+	}
+
+	if (!blk_mq_get_budget_and_tag(rq))
+		return BLK_STS_RESOURCE;
+	return __blk_mq_issue_directly(hctx, rq, last);
 }
 
 static void blk_mq_plug_issue_direct(struct blk_plug *plug)
-- 
2.39.2

