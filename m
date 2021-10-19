Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F19C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11C760F93
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhJSM2M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhJSM2J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:28:09 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE7C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZYIbDlZzPzQzy1RTYXx2Hn+wB0YvobIMHvub/++Q8lo=; b=wuKQc2/3vUFWe+5iXxp/QXVTt1
        rTRjH9WEMrtLiQEG2HoCRebz5/8D0Y7zijl/Q2kln2+G2iDsru/uq0As6IWgn6S7czyHhg6YWN9j5
        BY6Ezpy6/t+CsrBb9Aw9Ot8HJPSw7bEkBM9Je7sghRKm+Ix7edpxCwv8Yh1VODtpcBdexWzS5366/
        M5zlNiF6sgkArg5mhcEiOzyj/NTdHtaOcPCfOB4mpkovdYETAgj4C/W/+1FF94tQusWWn4JthzQGv
        nBcytCQzWbGm3CS89dSGvG7LeNO+ktxXV+WxbeloVJhVD5p2AW8HWPHtHnl09md9qdo1k56HsIqtR
        Mfz4h+uw==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcoBn-001Acz-MC; Tue, 19 Oct 2021 12:25:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: don't handle non-flush requests in blk_insert_flush
Date:   Tue, 19 Oct 2021 14:25:53 +0200
Message-Id: <20211019122553.2467817-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return to the normal blk_mq_submit_bio flow if the bio did not end up
actually being a flush because the device didn't support it.  Note that
this is basically impossible to hit without special instrumentation given
that submit_bio_checks already clears these flags usually, so we'd need a
tight race to actually hit this code path.

With this the call to blk_mq_run_hw_queue for the flush requests can be
removed given that the actual flush requests are always issued via the
requeue workqueue which runs the queue unconditionally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 12 ++++++------
 block/blk-mq.c    | 14 ++++++--------
 block/blk.h       |  2 +-
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e9c0b300a1771..ebb11a87c6e30 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -382,7 +382,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
  * @rq is being submitted.  Analyze what needs to be done and put it on the
  * right queue.
  */
-void blk_insert_flush(struct request *rq)
+bool blk_insert_flush(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	unsigned long fflags = q->queue_flags;	/* may change, cache */
@@ -412,7 +412,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if (!policy) {
 		blk_mq_end_request(rq, 0);
-		return;
+		return true;
 	}
 
 	BUG_ON(rq->bio != rq->biotail); /*assumes zero or single bio rq */
@@ -423,10 +423,8 @@ void blk_insert_flush(struct request *rq)
 	 * for normal execution.
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
-	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false, false);
-		return;
-	}
+	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH)))
+		return false;
 
 	/*
 	 * @rq should go through flush machinery.  Mark it part of flush
@@ -442,6 +440,8 @@ void blk_insert_flush(struct request *rq)
 	spin_lock_irq(&fq->mq_flush_lock);
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
 	spin_unlock_irq(&fq->mq_flush_lock);
+
+	return true;
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9248edd8a7d3b..428e0e0fd5504 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2491,14 +2491,12 @@ void blk_mq_submit_bio(struct bio *bio)
 		return;
 	}
 
-	if (unlikely(is_flush_fua)) {
-		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-		/* Bypass scheduler for flush requests */
-		blk_insert_flush(rq);
-		blk_mq_run_hw_queue(hctx, true);
-	} else if (plug && (q->nr_hw_queues == 1 ||
-		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
-		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
+	if (is_flush_fua && blk_insert_flush(rq))
+		return;
+
+	if (plug && (q->nr_hw_queues == 1 ||
+	    blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
+	    q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
 		/*
 		 * Use plugging if we have a ->commit_rqs() hook as well, as
 		 * we know the driver uses bd->last in a smart fashion.
diff --git a/block/blk.h b/block/blk.h
index e80350327e6dc..cb98a10a119c8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -236,7 +236,7 @@ void __blk_account_io_done(struct request *req, u64 now);
  */
 #define ELV_ON_HASH(rq) ((rq)->rq_flags & RQF_HASHED)
 
-void blk_insert_flush(struct request *rq);
+bool blk_insert_flush(struct request *rq);
 
 int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e);
-- 
2.30.2

