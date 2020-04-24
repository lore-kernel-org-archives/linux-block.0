Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B12C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F952063A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuM+BZfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgDXPxm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgDXPxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 11:53:42 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB62C09B046
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 08:53:40 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a18so9859953qkl.0
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lMQvFTtuTw6kNlBxtxkqtbssFCtHBR2FRtmMk0xCduU=;
        b=WuM+BZfN2f2K8PeB8zeAMu1uSBTEQQcy3jadaZaxu0hXdSM2+0ZSleQc8OoKCypGbq
         cpYym+HQQEBWNfdSrOJBaiU0UE/RfhhsaLGKqGj0b7R2JR/YAKcZzUEbAHNimy/bV+aQ
         o7zMZA5LBhGziX1lc93Tb/7e4F3JuQm0Q3/Ssi9rJrZ7m4BxwgeQOXaVK7/R3/pLiFTh
         nSMifeb/reCxUKWjGrggcFOliuUypD8RXqWN3d1K2KBZhWW1l8jiYpoU2z2m9T6RVtVm
         kuduB/9vEEMY9PiVvQXyd8FvtNg4isZqjarCBovLiTSGbsTaLiisAX4woIdWhcboxvFl
         Q8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lMQvFTtuTw6kNlBxtxkqtbssFCtHBR2FRtmMk0xCduU=;
        b=eRuEjp2TqaErsX6jZnUs1tA+4vLBLDyah1w6dnuW+i6BFTaeXExGIHpgF6/em+SvUb
         cJ9TQ3658TbZf025ULFiCSr68n2wcZRDE7FAjXUERMxg4Fb9l6arOCdfWrs6c32vMQXy
         +OW7XMuV4NcQIrV/+D41zE1whR8PX7gjDLQWsmSL018MgFtK2+fmd64GDvtwTTyLrYpD
         HUJMPPpOdc8aQNmEUiqjGhs0WWwkVKKggUe3hslx495gYAh3ubgPhzcdSujc2Z3m17Wi
         707m7n4FiDbs4xGY8LkNNlTs6DAjp6MrApX/2xOQ60nDXFbRqj8B+lE5qswTZ1CSokeT
         8ivQ==
X-Gm-Message-State: AGi0PubfnnyJBbLq8YVSUgNKBTaYQH4MXkTRBBJnTbW/5R3+9CZkk3My
        qJnZOdx8qziPZvciUbZGmeb5/g1zaw==
X-Google-Smtp-Source: APiQypKtqUH8bX6hdDPwC8R0M0bM9FGGsnwRt9hoDS2kUCXaRMJJNNuQg3q+K+Z0rrHGzNocbJa2Rwq+2w==
X-Received: by 2002:ac8:70d:: with SMTP id g13mr9835143qth.91.1587743619648;
 Fri, 24 Apr 2020 08:53:39 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:53:35 -0700
Message-Id: <20200424155335.63787-1-sqazi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v4] block: Limit number of items taken from the I/O scheduler
 in one go
From:   Salman Qazi <sqazi@google.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Salman Qazi <sqazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flushes bypass the I/O scheduler and get added to hctx->dispatch
in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
hctx->run_work work item and is past the point in
blk_mq_sched_dispatch_requests where hctx->dispatch is checked.

The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
because the I/O scheduler can feed an arbitrary number of commands.

Since we have only one hctx->run_work, the commands waiting in
hctx->dispatch will wait an arbitrary length of time for run_work to be
rerun.

A similar phenomenon exists with dispatches from the software queue.

The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
blk_mq_do_dispatch_ctx and return from the run_work handler and let it
rerun.

Signed-off-by: Salman Qazi <sqazi@google.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
Changes since v3

Updated a comment to make it clear why we call __blk_mq_sched_dispatch_requests
twice before rerunning the work item.

 block/blk-mq-sched.c | 67 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74cedea56034..31ce6dbec93e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -84,12 +84,16 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ *
+ * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
+ * be run again.  This is necessary to avoid starving flushes.
  */
-static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	LIST_HEAD(rq_list);
+	int ret = 0;
 
 	do {
 		struct request *rq;
@@ -97,6 +101,11 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = -EAGAIN;
+			break;
+		}
+
 		if (!blk_mq_get_dispatch_budget(hctx))
 			break;
 
@@ -113,6 +122,8 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 */
 		list_add(&rq->queuelist, &rq_list);
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+
+	return ret;
 }
 
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
@@ -130,16 +141,25 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ *
+ * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
+ * to be run again.  This is necessary to avoid starving flushes.
  */
-static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
+static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	LIST_HEAD(rq_list);
 	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
+	int ret = 0;
 
 	do {
 		struct request *rq;
 
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = -EAGAIN;
+			break;
+		}
+
 		if (!sbitmap_any_bit_set(&hctx->ctx_map))
 			break;
 
@@ -165,21 +185,17 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
+	return ret;
 }
 
-void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
+	int ret = 0;
 	LIST_HEAD(rq_list);
 
-	/* RCU or SRCU read lock is needed before checking quiesced flag */
-	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
-		return;
-
-	hctx->run++;
-
 	/*
 	 * If we have previous entries on our dispatch list, grab them first for
 	 * more fair dispatch.
@@ -208,19 +224,44 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		blk_mq_sched_mark_restart_hctx(hctx);
 		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
 			if (has_sched_dispatch)
-				blk_mq_do_dispatch_sched(hctx);
+				ret = blk_mq_do_dispatch_sched(hctx);
 			else
-				blk_mq_do_dispatch_ctx(hctx);
+				ret = blk_mq_do_dispatch_ctx(hctx);
 		}
 	} else if (has_sched_dispatch) {
-		blk_mq_do_dispatch_sched(hctx);
+		ret = blk_mq_do_dispatch_sched(hctx);
 	} else if (hctx->dispatch_busy) {
 		/* dequeue request one by one from sw queue if queue is busy */
-		blk_mq_do_dispatch_ctx(hctx);
+		ret = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
 		blk_mq_dispatch_rq_list(q, &rq_list, false);
 	}
+
+	return ret;
+}
+
+void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+
+	/* RCU or SRCU read lock is needed before checking quiesced flag */
+	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
+		return;
+
+	hctx->run++;
+
+	/*
+	 * A return of -EAGAIN is an indication that hctx->dispatch is not
+	 * empty and we must run again in order to avoid starving flushes.
+	 * As an optimization, we run again locally once.  In the unlikely
+	 * event that we encounter the same race again, we reschedule
+	 * the work item.
+	 */
+	if (__blk_mq_sched_dispatch_requests(hctx) == -EAGAIN) {
+		if (__blk_mq_sched_dispatch_requests(hctx) == -EAGAIN)
+			blk_mq_run_hw_queue(hctx, true);
+	}
 }
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-- 
2.26.2.303.gf8c07b1a785-goog

