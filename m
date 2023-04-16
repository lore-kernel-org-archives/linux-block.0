Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F8C77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 20:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDPUJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPUJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 16:09:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD61FDE
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qsfrKo9TnFP/XO7Kg8TtLf1CJmqqiHM9xi1tWp2u9Ls=; b=iqtbBD1xF+YW68oXbAiBajuEQc
        9WPnqo6b4g5NZN9B7oh1izXlj2QeLETi78ZVS3R2vpZ1erax00YhjyLG6kh+krD141mwLgVwKkFq9
        APGQUuT/qaCEIZ+7AuRFgzbLCCDk19AMkwF97Kt5FYdUgaUkzAKwxA25uB3uXn//PEaKvhO7S3qHb
        1YO6C7R7kVmkExZLKwTd5NNVPcE80MIZ+Yk2hwOy7+rznUCtPS+tFge2QaAJdlfOcjcrENfaYK3Z+
        ztbmgyhlcG6T4K2geXttiwu3tpjMzhWYVzzTsbo0uVjjQEei5ONPT5Sp3AV9vm0RgNPK3am2m8Z8Z
        qkobMEaA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1po8gy-00EOHx-1f;
        Sun, 16 Apr 2023 20:09:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/7] blk-mq: reflow blk_insert_flush
Date:   Sun, 16 Apr 2023 22:09:25 +0200
Message-Id: <20230416200930.29542-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416200930.29542-1-hch@lst.de>
References: <20230416200930.29542-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a switch statement to decide on the disposition of a flush request
instead of multiple if statements, out of which one does checks that are
more complex than required.  Also warn on a malformed request early
on instead of doing a BUG_ON later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 53 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 422a6d5446d1c5..9fcfee7394f27d 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -402,6 +402,9 @@ void blk_insert_flush(struct request *rq)
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
+	/* FLUSH/FUA request must never be merged */
+	WARN_ON_ONCE(rq->bio != rq->biotail);
+
 	/*
 	 * @policy now records what operations need to be done.  Adjust
 	 * REQ_PREFLUSH and FUA for the driver.
@@ -417,39 +420,35 @@ void blk_insert_flush(struct request *rq)
 	 */
 	rq->cmd_flags |= REQ_SYNC;
 
-	/*
-	 * An empty flush handed down from a stacking driver may
-	 * translate into nothing if the underlying device does not
-	 * advertise a write-back cache.  In this case, simply
-	 * complete the request.
-	 */
-	if (!policy) {
+	switch (policy) {
+	case 0:
+		/*
+		 * An empty flush handed down from a stacking driver may
+		 * translate into nothing if the underlying device does not
+		 * advertise a write-back cache.  In this case, simply
+		 * complete the request.
+		 */
 		blk_mq_end_request(rq, 0);
 		return;
-	}
-
-	BUG_ON(rq->bio != rq->biotail); /*assumes zero or single bio rq */
-
-	/*
-	 * If there's data but flush is not necessary, the request can be
-	 * processed directly without going through flush machinery.  Queue
-	 * for normal execution.
-	 */
-	if ((policy & REQ_FSEQ_DATA) &&
-	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
+	case REQ_FSEQ_DATA:
+		/*
+		 * If there's data, but no flush is necessary, the request can
+		 * be processed directly without going through flush machinery.
+		 * Queue for normal execution.
+		 */
 		blk_mq_request_bypass_insert(rq, 0);
 		blk_mq_run_hw_queue(hctx, false);
 		return;
+	default:
+		/*
+		 * Mark the request as part of a flush sequence and submit it
+		 * for further processing to the flush state machine.
+		 */
+		blk_rq_init_flush(rq);
+		spin_lock_irq(&fq->mq_flush_lock);
+		blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
+		spin_unlock_irq(&fq->mq_flush_lock);
 	}
-
-	/*
-	 * @rq should go through flush machinery.  Mark it part of flush
-	 * sequence and submit for further processing.
-	 */
-	blk_rq_init_flush(rq);
-	spin_lock_irq(&fq->mq_flush_lock);
-	blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
-	spin_unlock_irq(&fq->mq_flush_lock);
 }
 
 /**
-- 
2.39.2

