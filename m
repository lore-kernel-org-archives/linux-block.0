Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F7DCA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9442176D
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHrNRL+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbgEMJzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 05:55:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732890AbgEMJzl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 05:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589363739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6OU/DkDD48PDBgW4Zv7e/nWJ7EMYcyhuxVdos3tCxc=;
        b=CHrNRL+H5yW5SXXfgOG9PAN9OwEHIkKxXSVtomPL7aXfHp7i2R+B3SPh/VHpwsHEAs4iEG
        0VlbBG4UgkyYjpH089g8sKeWVlgTjs6SAdTJIk/yF7+aaH6HdT+WkE6bAOOnEfYfNxschg
        p6rZAvRsi+/arVSJssZv2XjxFN5xRnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-nvykJyroMZGTYNKgTqHxOw-1; Wed, 13 May 2020 05:55:37 -0400
X-MC-Unique: nvykJyroMZGTYNKgTqHxOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DAA418B6423;
        Wed, 13 May 2020 09:55:36 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7094E60C84;
        Wed, 13 May 2020 09:55:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 8/9] blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
Date:   Wed, 13 May 2020 17:54:42 +0800
Message-Id: <20200513095443.2038859-9-ming.lei@redhat.com>
In-Reply-To: <20200513095443.2038859-1-ming.lei@redhat.com>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass obtained budget count to blk_mq_dispatch_rq_list(), and prepare
for supporting fully batching submission.

With the obtained budget count, it is easier to put extra budgets
in case of .queue_rq failure.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c |  8 ++++----
 block/blk-mq.c       | 18 ++++++++++++++----
 block/blk-mq.h       |  3 ++-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 632c6f8b63f7..78fc8d80caaf 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -130,7 +130,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));
+	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true, 1));
 
 	return ret;
 }
@@ -198,7 +198,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 		/* round robin for fair dispatch */
 		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
 
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));
+	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true, 1));
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
 	return ret;
@@ -238,7 +238,7 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		if (blk_mq_dispatch_rq_list(hctx, &rq_list, false)) {
+		if (blk_mq_dispatch_rq_list(hctx, &rq_list, false, 0)) {
 			if (has_sched_dispatch)
 				ret = blk_mq_do_dispatch_sched(hctx);
 			else
@@ -251,7 +251,7 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		ret = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
-		blk_mq_dispatch_rq_list(hctx, &rq_list, false);
+		blk_mq_dispatch_rq_list(hctx, &rq_list, false, 0);
 	}
 
 	return ret;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3e3fbb13f3b9..bfdfdd61e663 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1212,7 +1212,8 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 		 */
 		if (!blk_mq_mark_tag_wait(hctx, rq)) {
 			/* budget is always obtained before getting tag */
-			blk_mq_put_dispatch_budget(rq->q);
+			if (ask_budget)
+				blk_mq_put_dispatch_budget(rq->q);
 			return PREP_DISPATCH_NO_TAG;
 		}
 	}
@@ -1233,12 +1234,17 @@ static blk_status_t blk_mq_dispatch_rq(struct request *rq, bool is_last)
 
 static void blk_mq_handle_partial_dispatch(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list, enum prep_dispatch prep,
-		blk_status_t ret, bool queued)
+		blk_status_t ret, bool queued, unsigned budgets)
 {
 	struct request_queue *q = hctx->queue;
 	bool needs_restart;
 	bool no_tag = false;
 	bool no_budget_avail = false;
+	unsigned i = 0;
+
+	/* release got budgets */
+	while (i++ < budgets)
+		blk_mq_put_dispatch_budget(hctx->queue);
 
 	/*
 	 * For non-shared tags, the RESTART check
@@ -1298,9 +1304,11 @@ static void blk_mq_handle_partial_dispatch(struct blk_mq_hw_ctx *hctx,
 
 /*
  * Returns true if we did some work AND can potentially do more.
+ *
+ * @budgets is only valid iff @got_budget is true.
  */
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
-			     bool got_budget)
+			     bool got_budget, unsigned int budgets)
 {
 	enum prep_dispatch prep;
 	struct request *rq;
@@ -1360,7 +1368,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	 * that is where we will continue on next queue run.
 	 */
 	if (!list_empty(list)) {
-		blk_mq_handle_partial_dispatch(hctx, list, prep, ret, !!queued);
+		blk_mq_handle_partial_dispatch(hctx, list, prep, ret,
+				!!queued,
+				got_budget ? budgets - queued : 0);
 		blk_mq_update_dispatch_busy(hctx, true);
 		return false;
 	} else
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9c0e93d4fe38..a37f8f673a19 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -40,7 +40,8 @@ struct blk_mq_ctx {
 void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
-bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *, bool);
+bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
+		bool, unsigned int);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
-- 
2.25.2

