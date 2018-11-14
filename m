Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACA0C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA7422419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xyhb2OAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA7422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbeKOCGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbeKOCGu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zdu1exNjN7c3LjbEuDGHuJWhGF4Bl8w4LVNyzm+Ohgc=; b=Xyhb2OArBh14z8LBYNX7bgKhSn
        FwfTMUnx7bFFwyVlYT5twZ6C+NjBA65Tf2ORB6qzyP9/qU5J7IWufox/VioItmNr1PD7MU4gC41WC
        9tq3xUf2tWoTR5iMpLjx+P6jeS0cSPM3JoFaVHmOJyqMi7C3uxlvkewrIFN/71xnv/MR3jZrTP4hx
        cgBWBKWpYEetCucKF+Ov+8dP+zCzKgB+XckSwiiie7fOz3hMs7oU1jY+UsP/i8+wYIdAHYtyPzFPi
        tP719vzfhqplZsykLUNqyVvy1L2ZgOpiO3Zf7iSmO2ggQRpaL0ep3P2j+n8yKocoBN8iHysXW6WMH
        BUlBaruQ==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxd6-0006QA-JT; Wed, 14 Nov 2018 16:03:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 14/16] mmc: stop abusing the request queue_lock pointer
Date:   Wed, 14 Nov 2018 17:02:17 +0100
Message-Id: <20181114160219.28328-15-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mmc uses the block layer struct request pointer to indirect their own
lock to the mmc_queue structure, given that the original lock isn't
reachable outside of block.c.  Add a lock pointer to struct mmc_queue
instead and stop overriding the block layer lock which protects fields
entirely separate from the mmc use.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/block.c | 22 ++++++++++------------
 drivers/mmc/core/queue.c | 26 +++++++++++++-------------
 drivers/mmc/core/queue.h |  1 +
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 27606e1382e5..70ec465beb69 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1483,7 +1483,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 		blk_mq_end_request(req, BLK_STS_OK);
 	}
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 
 	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
 
@@ -1491,7 +1491,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 
 	mmc_cqe_check_busy(mq);
 
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 
 	if (!mq->cqe_busy)
 		blk_mq_run_hw_queues(q, true);
@@ -1988,17 +1988,16 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 
 static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 {
-	struct request_queue *q = req->q;
 	unsigned long flags;
 	bool put_card;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 
 	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 
 	if (put_card)
 		mmc_put_card(mq->card, &mq->ctx);
@@ -2094,11 +2093,11 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
 		 * request does not need to wait (although it does need to
 		 * complete complete_req first).
 		 */
-		spin_lock_irqsave(q->queue_lock, flags);
+		spin_lock_irqsave(mq->lock, flags);
 		mq->complete_req = req;
 		mq->rw_wait = false;
 		waiting = mq->waiting;
-		spin_unlock_irqrestore(q->queue_lock, flags);
+		spin_unlock_irqrestore(mq->lock, flags);
 
 		/*
 		 * If 'waiting' then the waiting task will complete this
@@ -2117,10 +2116,10 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
 	/* Take the recovery path for errors or urgent background operations */
 	if (mmc_blk_rq_error(&mqrq->brq) ||
 	    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
-		spin_lock_irqsave(q->queue_lock, flags);
+		spin_lock_irqsave(mq->lock, flags);
 		mq->recovery_needed = true;
 		mq->recovery_req = req;
-		spin_unlock_irqrestore(q->queue_lock, flags);
+		spin_unlock_irqrestore(mq->lock, flags);
 		wake_up(&mq->wait);
 		schedule_work(&mq->recovery_work);
 		return;
@@ -2136,7 +2135,6 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
 
 static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
 {
-	struct request_queue *q = mq->queue;
 	unsigned long flags;
 	bool done;
 
@@ -2144,7 +2142,7 @@ static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
 	 * Wait while there is another request in progress, but not if recovery
 	 * is needed. Also indicate whether there is a request waiting to start.
 	 */
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 	if (mq->recovery_needed) {
 		*err = -EBUSY;
 		done = true;
@@ -2152,7 +2150,7 @@ static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
 		done = !mq->rw_wait;
 	}
 	mq->waiting = !done;
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 
 	return done;
 }
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 37617fb1f9de..ac6a5245275a 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -89,9 +89,9 @@ void mmc_cqe_recovery_notifier(struct mmc_request *mrq)
 	struct mmc_queue *mq = q->queuedata;
 	unsigned long flags;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 	__mmc_cqe_recovery_notifier(mq);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 }
 
 static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
@@ -128,14 +128,14 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irqsave(mq->lock, flags);
 
 	if (mq->recovery_needed || !mq->use_cqe)
 		ret = BLK_EH_RESET_TIMER;
 	else
 		ret = mmc_cqe_timed_out(req);
 
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irqrestore(mq->lock, flags);
 
 	return ret;
 }
@@ -157,9 +157,9 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 
 	mq->in_recovery = false;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(mq->lock);
 	mq->recovery_needed = false;
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(mq->lock);
 
 	mmc_put_card(mq->card, &mq->ctx);
 
@@ -258,10 +258,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	issue_type = mmc_issue_type(mq, req);
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(mq->lock);
 
 	if (mq->recovery_needed || mq->busy) {
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(mq->lock);
 		return BLK_STS_RESOURCE;
 	}
 
@@ -269,7 +269,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case MMC_ISSUE_DCMD:
 		if (mmc_cqe_dcmd_busy(mq)) {
 			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
-			spin_unlock_irq(q->queue_lock);
+			spin_unlock_irq(mq->lock);
 			return BLK_STS_RESOURCE;
 		}
 		break;
@@ -294,7 +294,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	get_card = (mmc_tot_in_flight(mq) == 1);
 	cqe_retune_ok = (mmc_cqe_qcnt(mq) == 1);
 
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(mq->lock);
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		req_to_mmc_queue_req(req)->retries = 0;
@@ -328,12 +328,12 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (issued != MMC_REQ_STARTED) {
 		bool put_card = false;
 
-		spin_lock_irq(q->queue_lock);
+		spin_lock_irq(mq->lock);
 		mq->in_flight[issue_type] -= 1;
 		if (mmc_tot_in_flight(mq) == 0)
 			put_card = true;
 		mq->busy = false;
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irq(mq->lock);
 		if (put_card)
 			mmc_put_card(card, &mq->ctx);
 	} else {
@@ -397,6 +397,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	int ret;
 
 	mq->card = card;
+	mq->lock = lock;
 	mq->use_cqe = host->cqe_enabled;
 
 	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
@@ -427,7 +428,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		goto free_tag_set;
 	}
 
-	mq->queue->queue_lock = lock;
 	mq->queue->queuedata = mq;
 	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 29218e12900d..5421f1542e71 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -73,6 +73,7 @@ struct mmc_queue_req {
 
 struct mmc_queue {
 	struct mmc_card		*card;
+	spinlock_t		*lock;
 	struct mmc_ctx		ctx;
 	struct blk_mq_tag_set	tag_set;
 	struct mmc_blk_data	*blkdata;
-- 
2.19.1

