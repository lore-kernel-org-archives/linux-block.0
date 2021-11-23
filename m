Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBBDC4332F
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbhKWQH5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbhKWQH4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:07:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3A3C061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VMEaVlxgUAeGDp1fwEhrSCS/kMyxoA+dEOg0JJGFrHE=; b=VvovxUKc3Z71s0VD8poFFngqvc
        V4YLUB7qeB/OBc/+//AjtSD+ZenIk/W1ZzFF1KBMnfU8rjdCTBRt4GomrMRfE7wh9IlkgSC+CikU7
        6NH1ak/FUD2Vby4tlcWg1PyO7bUf/3BlscEoqEhztFs8Tqq1b3E95WfkwIjzcSABHiR+BxMXoSV+T
        McpHlhlG+il6KTxjJfYv0qGQ7kAzvu2ycFKKoe3Dj/gZYSgE+THWK0vMLlIGyeHxWdhT/8OxkJpXZ
        gMPHmje8XIya0quQ36J1MbyW7hT9PfwUdk214NWF3MIT/GFNOiweCt2S8kSdxAN/JsSXganCz6ijv
        QI9jJPPA==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpYHm-00FRiC-4o; Tue, 23 Nov 2021 16:04:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/3] blk-mq: move more plug handling from blk_mq_submit_bio into blk_add_rq_to_plug
Date:   Tue, 23 Nov 2021 17:04:42 +0100
Message-Id: <20211123160443.1315598-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123160443.1315598-1-hch@lst.de>
References: <20211123160443.1315598-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Keep all the functionality for adding a request to a plug in a single place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 64 +++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f05c458d983b4..9e91587997763 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2661,21 +2661,6 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
-static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
-{
-	if (!plug->multiple_queues) {
-		struct request *nxt = rq_list_peek(&plug->mq_list);
-
-		if (nxt && nxt->q != rq->q)
-			plug->multiple_queues = true;
-	}
-	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
-		plug->has_elevator = true;
-	rq->rq_next = NULL;
-	rq_list_add(&plug->mq_list, rq);
-	plug->rq_count++;
-}
-
 /*
  * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
  * queues. This is important for md arrays to benefit from merging
@@ -2688,6 +2673,28 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 	return BLK_MAX_REQUEST_COUNT;
 }
 
+static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
+{
+	struct request *last = rq_list_peek(&plug->mq_list);
+
+	if (!plug->rq_count) {
+		trace_block_plug(rq->q);
+	} else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
+		   (!blk_queue_nomerges(rq->q) &&
+		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
+		blk_mq_flush_plug_list(plug, false);
+		trace_block_plug(rq->q);
+	}
+
+	if (!plug->multiple_queues && last && last->q != rq->q)
+		plug->multiple_queues = true;
+	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
+		plug->has_elevator = true;
+	rq->rq_next = NULL;
+	rq_list_add(&plug->mq_list, rq);
+	plug->rq_count++;
+}
+
 static bool blk_mq_attempt_bio_merge(struct request_queue *q,
 				     struct bio *bio, unsigned int nr_segs)
 {
@@ -2838,31 +2845,14 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
 		return;
 
-	if (plug) {
-		unsigned int request_count = plug->rq_count;
-		struct request *last = NULL;
-
-		if (!request_count) {
-			trace_block_plug(q);
-		} else if (!blk_queue_nomerges(q)) {
-			last = rq_list_peek(&plug->mq_list);
-			if (blk_rq_bytes(last) < BLK_PLUG_FLUSH_SIZE)
-				last = NULL;
-		}
-
-		if (request_count >= blk_plug_max_rq_count(plug) || last) {
-			blk_mq_flush_plug_list(plug, false);
-			trace_block_plug(q);
-		}
-
+	if (plug)
 		blk_add_rq_to_plug(plug, rq);
-	} else if ((rq->rq_flags & RQF_ELV) ||
-		   (rq->mq_hctx->dispatch_busy &&
-		    (q->nr_hw_queues == 1 || !is_sync))) {
+	else if ((rq->rq_flags & RQF_ELV) ||
+		 (rq->mq_hctx->dispatch_busy &&
+		  (q->nr_hw_queues == 1 || !is_sync)))
 		blk_mq_sched_insert_request(rq, false, true, true);
-	} else {
+	else
 		blk_mq_try_issue_directly(rq->mq_hctx, rq);
-	}
 }
 
 /**
-- 
2.30.2

