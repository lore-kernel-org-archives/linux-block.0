Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB32CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C3A20753
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrSm9Kb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgEMM5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733236AbgEMM45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:56:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95543C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=36hC+XsCrJG5g4MetqPJ7t76uhWRnLxfqwQ7lASG+Ic=; b=WrSm9Kb9K85zk8TJ0w1m0GEkcc
        y/qGaa50jVx9xR/KOyZG4H0VnhiXPMahX7hme2Ebmv6Pg7dhe/qQE9/mAngbp6cGLI1tmFVHKxBm0
        WMitcRUrbC8E3OmfomfvFonyJPt2D+uaSQ5uyItuZSc5XHg2oJl9WxSpENv4v6gIn9IiV05Hjd1/K
        Wehkz06szx1VXuiId0BDUzCs/oKjE7IhE6HwyKiz+b+HKZIHHKxIGxlDYouztReka25JJAFG8+53A
        rmWohazzLY4leZuIh24HmmWlhrql2aCNHDqWQ43Vf+d4pf/jMreaOm9oJ/+zgXgErr2635aB6yLrV
        iFfBduEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqwS-0002Bi-Ql; Wed, 13 May 2020 12:56:56 +0000
Date:   Wed, 13 May 2020 05:56:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/9] blk-mq: move code for handling partial dispatch into
 one helper
Message-ID: <20200513125656.GF23958@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095443.2038859-7-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 05:54:40PM +0800, Ming Lei wrote:
> Move code for handling partial dispatch into one helper, so that
> blk_mq_dispatch_rq_list gets a bit simpified, and easier to read.
> 
> No functional change.

The concept looks good, but some of the logic is very convoluted.
What do you think of something like this on top:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 86beb8c668689..8c9a6a886919c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1236,24 +1236,11 @@ static void blk_mq_handle_partial_dispatch(struct blk_mq_hw_ctx *hctx,
 		blk_status_t ret, bool queued)
 {
 	struct request_queue *q = hctx->queue;
-	bool needs_restart;
-	bool no_tag = false;
 	bool no_budget_avail = false;
 
 	/*
-	 * For non-shared tags, the RESTART check
-	 * will suffice.
-	 */
-	if (prep == PREP_DISPATCH_NO_TAG &&
-			(hctx->flags & BLK_MQ_F_TAG_SHARED))
-		no_tag = true;
-	if (prep == PREP_DISPATCH_NO_BUDGET)
-		no_budget_avail = true;
-
-	/*
-	 * If we didn't flush the entire list, we could have told
-	 * the driver there was more coming, but that turned out to
-	 * be a lie.
+	 * Commit the current batch.  There are more waiting requests, but we
+	 * can't guarantee that we'll handle them ASAP.
 	 */
 	if (q->mq_ops->commit_rqs && queued)
 		q->mq_ops->commit_rqs(hctx);
@@ -1263,36 +1250,52 @@ static void blk_mq_handle_partial_dispatch(struct blk_mq_hw_ctx *hctx,
 	spin_unlock(&hctx->lock);
 
 	/*
-	 * If SCHED_RESTART was set by the caller of this function and
-	 * it is no longer set that means that it was cleared by another
-	 * thread and hence that a queue rerun is needed.
+	 * If SCHED_RESTART was set by the caller and it is no longer set, it
+	 * must have been cleared by another thread and hence a queue rerun is
+	 * needed.
 	 *
-	 * If 'no_tag' is set, that means that we failed getting
-	 * a driver tag with an I/O scheduler attached. If our dispatch
+	 * If blk_mq_prep_dispatch_rq returned PREP_DISPATCH_NO_TAG, we failed
+	 * to get a driver tag with an I/O scheduler attached. If our dispatch
 	 * waitqueue is no longer active, ensure that we run the queue
 	 * AFTER adding our entries back to the list.
+	 * If no I/O scheduler has been configured it is possible that the
+	 * hardware queue got stopped and restarted before requests were pushed
+	 * back onto the dispatch list.  Rerun the queue to avoid starvation.
 	 *
-	 * If no I/O scheduler has been configured it is possible that
-	 * the hardware queue got stopped and restarted before requests
-	 * were pushed back onto the dispatch list. Rerun the queue to
-	 * avoid starvation. Notes:
-	 * - blk_mq_run_hw_queue() checks whether or not a queue has
-	 *   been stopped before rerunning a queue.
-	 * - Some but not all block drivers stop a queue before
-	 *   returning BLK_STS_RESOURCE. Two exceptions are scsi-mq
-	 *   and dm-rq.
+	 * Notes:
+	 *   - blk_mq_run_hw_queue() checks whether or not a queue has been
+	 *     stopped before rerunning a queue.
+	 *   - Some but not all block drivers stop a queue before returning
+	 *     BLK_STS_RESOURCE. Two exceptions are scsi-mq and dm-rq.
 	 *
-	 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
-	 * bit is set, run queue after a delay to avoid IO stalls
-	 * that could otherwise occur if the queue is idle.  We'll do
-	 * similar if we couldn't get budget and SCHED_RESTART is set.
+	 * If driver returns BLK_STS_RESOURCE and the SCHED_RESTART bit is set,
+	 * run queue after a delay to avoid IO stalls that could otherwise occur
+	 * if the queue is idle.  We'll do similar if we couldn't get budget and
+	 * SCHED_RESTART is set.
 	 */
-	needs_restart = blk_mq_sched_needs_restart(hctx);
-	if (!needs_restart ||
-	    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
+	switch (prep) {
+	case PREP_DISPATCH_NO_TAG:
+		if ((hctx->flags & BLK_MQ_F_TAG_SHARED) &&
+		    list_empty_careful(&hctx->dispatch_wait.entry)) {
+		    	blk_mq_run_hw_queue(hctx, true);
+			return;
+		}
+		/*
+		 * For non-shared tags, the RESTART check will suffice.
+		 */
+		break;
+	case PREP_DISPATCH_OK:
+		if (ret == BLK_STS_RESOURCE)
+			no_budget_avail = true;
+		break;
+	case PREP_DISPATCH_NO_BUDGET:
+		no_budget_avail = true;
+		break;
+	}
+
+	if (!blk_mq_sched_needs_restart(hctx))
 		blk_mq_run_hw_queue(hctx, true);
-	else if (needs_restart && (ret == BLK_STS_RESOURCE ||
-				   no_budget_avail))
+	else if (no_budget_avail)
 		blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 }
 
@@ -1336,8 +1339,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			 * accept.
 			 */
 			blk_mq_handle_zone_resource(rq, &zone_list);
-			if (list_empty(list))
-				break;
 			continue;
 		}
 
@@ -1350,9 +1351,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		queued++;
 	} while (!list_empty(list));
 
-	if (!list_empty(&zone_list))
-		list_splice_tail_init(&zone_list, list);
-
 	hctx->dispatched[queued_to_index(queued)]++;
 
 	/*
@@ -1360,11 +1358,13 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	 * that is where we will continue on next queue run.
 	 */
 	if (!list_empty(list)) {
-		blk_mq_handle_partial_dispatch(hctx, list, prep, ret, !!queued);
+		list_splice_tail_init(&zone_list, list);
+		blk_mq_handle_partial_dispatch(hctx, list, prep, ret, queued);
 		blk_mq_update_dispatch_busy(hctx, true);
 		return false;
-	} else
-		blk_mq_update_dispatch_busy(hctx, false);
+	}
+
+	blk_mq_update_dispatch_busy(hctx, false);
 
 	/*
 	 * If the host/device is unable to accept more work, inform the

