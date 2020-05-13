Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711CAC2D0F9
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F08D2492C
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZokLtJQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgEMJzi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 05:55:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388285AbgEMJzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 05:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589363735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQzkclllBs4XUNDegahETlcrIEqyRzbIznR5XK6bm7s=;
        b=ZokLtJQPedKxkycw86BCOaiu/BGIJQW4lm8ZEa+NVSjWAvtasWjDGbtOHu+yK5/CDIzwzk
        1o61RzYf8/M4GYuONST0WOfzG0LNht0ecfNKNpW811/qOuPfNWuIjtPk6v146cuypx2a86
        7rw8FA4nNWjoLk20Jo1agIBC8DC5/Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-u4EjNF2lPlWomqMzRNDwXg-1; Wed, 13 May 2020 05:55:30 -0400
X-MC-Unique: u4EjNF2lPlWomqMzRNDwXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E3A107ACCD;
        Wed, 13 May 2020 09:55:29 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9448762925;
        Wed, 13 May 2020 09:55:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 6/9] blk-mq: move code for handling partial dispatch into one helper
Date:   Wed, 13 May 2020 17:54:40 +0800
Message-Id: <20200513095443.2038859-7-ming.lei@redhat.com>
In-Reply-To: <20200513095443.2038859-1-ming.lei@redhat.com>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move code for handling partial dispatch into one helper, so that
blk_mq_dispatch_rq_list gets a bit simpified, and easier to read.

No functional change.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 126 ++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 60 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 34fd09adb7fc..86beb8c66868 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1231,6 +1231,71 @@ static blk_status_t blk_mq_dispatch_rq(struct request *rq, bool is_last)
 	return rq->q->mq_ops->queue_rq(rq->mq_hctx, &bd);
 }
 
+static void blk_mq_handle_partial_dispatch(struct blk_mq_hw_ctx *hctx,
+		struct list_head *list, enum prep_dispatch prep,
+		blk_status_t ret, bool queued)
+{
+	struct request_queue *q = hctx->queue;
+	bool needs_restart;
+	bool no_tag = false;
+	bool no_budget_avail = false;
+
+	/*
+	 * For non-shared tags, the RESTART check
+	 * will suffice.
+	 */
+	if (prep == PREP_DISPATCH_NO_TAG &&
+			(hctx->flags & BLK_MQ_F_TAG_SHARED))
+		no_tag = true;
+	if (prep == PREP_DISPATCH_NO_BUDGET)
+		no_budget_avail = true;
+
+	/*
+	 * If we didn't flush the entire list, we could have told
+	 * the driver there was more coming, but that turned out to
+	 * be a lie.
+	 */
+	if (q->mq_ops->commit_rqs && queued)
+		q->mq_ops->commit_rqs(hctx);
+
+	spin_lock(&hctx->lock);
+	list_splice_tail_init(list, &hctx->dispatch);
+	spin_unlock(&hctx->lock);
+
+	/*
+	 * If SCHED_RESTART was set by the caller of this function and
+	 * it is no longer set that means that it was cleared by another
+	 * thread and hence that a queue rerun is needed.
+	 *
+	 * If 'no_tag' is set, that means that we failed getting
+	 * a driver tag with an I/O scheduler attached. If our dispatch
+	 * waitqueue is no longer active, ensure that we run the queue
+	 * AFTER adding our entries back to the list.
+	 *
+	 * If no I/O scheduler has been configured it is possible that
+	 * the hardware queue got stopped and restarted before requests
+	 * were pushed back onto the dispatch list. Rerun the queue to
+	 * avoid starvation. Notes:
+	 * - blk_mq_run_hw_queue() checks whether or not a queue has
+	 *   been stopped before rerunning a queue.
+	 * - Some but not all block drivers stop a queue before
+	 *   returning BLK_STS_RESOURCE. Two exceptions are scsi-mq
+	 *   and dm-rq.
+	 *
+	 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
+	 * bit is set, run queue after a delay to avoid IO stalls
+	 * that could otherwise occur if the queue is idle.  We'll do
+	 * similar if we couldn't get budget and SCHED_RESTART is set.
+	 */
+	needs_restart = blk_mq_sched_needs_restart(hctx);
+	if (!needs_restart ||
+	    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
+		blk_mq_run_hw_queue(hctx, true);
+	else if (needs_restart && (ret == BLK_STS_RESOURCE ||
+				   no_budget_avail))
+		blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
@@ -1238,7 +1303,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			     bool got_budget)
 {
 	enum prep_dispatch prep;
-	struct request_queue *q = hctx->queue;
 	struct request *rq;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
@@ -1296,65 +1360,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	 * that is where we will continue on next queue run.
 	 */
 	if (!list_empty(list)) {
-		bool needs_restart;
-		bool no_tag = false;
-		bool no_budget_avail = false;
-
-		/*
-		 * For non-shared tags, the RESTART check
-		 * will suffice.
-		 */
-		if (prep == PREP_DISPATCH_NO_TAG &&
-				(hctx->flags & BLK_MQ_F_TAG_SHARED))
-			no_tag = true;
-		if (prep == PREP_DISPATCH_NO_BUDGET)
-			no_budget_avail = true;
-
-		/*
-		 * If we didn't flush the entire list, we could have told
-		 * the driver there was more coming, but that turned out to
-		 * be a lie.
-		 */
-		if (q->mq_ops->commit_rqs && queued)
-			q->mq_ops->commit_rqs(hctx);
-
-		spin_lock(&hctx->lock);
-		list_splice_tail_init(list, &hctx->dispatch);
-		spin_unlock(&hctx->lock);
-
-		/*
-		 * If SCHED_RESTART was set by the caller of this function and
-		 * it is no longer set that means that it was cleared by another
-		 * thread and hence that a queue rerun is needed.
-		 *
-		 * If 'no_tag' is set, that means that we failed getting
-		 * a driver tag with an I/O scheduler attached. If our dispatch
-		 * waitqueue is no longer active, ensure that we run the queue
-		 * AFTER adding our entries back to the list.
-		 *
-		 * If no I/O scheduler has been configured it is possible that
-		 * the hardware queue got stopped and restarted before requests
-		 * were pushed back onto the dispatch list. Rerun the queue to
-		 * avoid starvation. Notes:
-		 * - blk_mq_run_hw_queue() checks whether or not a queue has
-		 *   been stopped before rerunning a queue.
-		 * - Some but not all block drivers stop a queue before
-		 *   returning BLK_STS_RESOURCE. Two exceptions are scsi-mq
-		 *   and dm-rq.
-		 *
-		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
-		 * bit is set, run queue after a delay to avoid IO stalls
-		 * that could otherwise occur if the queue is idle.  We'll do
-		 * similar if we couldn't get budget and SCHED_RESTART is set.
-		 */
-		needs_restart = blk_mq_sched_needs_restart(hctx);
-		if (!needs_restart ||
-		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
-			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE ||
-					   no_budget_avail))
-			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
-
+		blk_mq_handle_partial_dispatch(hctx, list, prep, ret, !!queued);
 		blk_mq_update_dispatch_busy(hctx, true);
 		return false;
 	} else
-- 
2.25.2

