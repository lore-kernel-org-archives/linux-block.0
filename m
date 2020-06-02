Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42365C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E1320738
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSTl8LJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFBJPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:15:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbgFBJPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 05:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591089349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LNFpJcC2kxMLnCXcUcEft4/CN02dK5uQWiThijHSu6E=;
        b=QSTl8LJiDDSQ+9oLnQttYEEy6KOVQt1wNxuNFglbagq7nJwVluJz5YIMYlkXGel2yqGILS
        PrFdlzCVoSnONiuJlvscvAHasi+aN93ffxxk7vRmJtKSR16a9ZqS4sMsM3uFqLqM4KMh0/
        +M9rUdbtgoBPsTbb6sbli3Ola/fKYCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-buL0EJkkMtu_OSHBQr3Pcw-1; Tue, 02 Jun 2020 05:15:46 -0400
X-MC-Unique: buL0EJkkMtu_OSHBQr3Pcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA0DC461;
        Tue,  2 Jun 2020 09:15:44 +0000 (UTC)
Received: from localhost (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7370919D7C;
        Tue,  2 Jun 2020 09:15:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V4 5/6] blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
Date:   Tue,  2 Jun 2020 17:15:01 +0800
Message-Id: <20200602091502.1822499-6-ming.lei@redhat.com>
In-Reply-To: <20200602091502.1822499-1-ming.lei@redhat.com>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass obtained budget count to blk_mq_dispatch_rq_list(), and prepare
for supporting fully batching submission.

With the obtained budget count, it is easier to put extra budgets
in case of .queue_rq failure.

Meantime remove the old 'got_budget' parameter.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Tested-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c |  8 ++++----
 block/blk-mq.c       | 27 +++++++++++++++++++++++----
 block/blk-mq.h       |  3 ++-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 632c6f8b63f7..4c72073830f3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -130,7 +130,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));
+	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
 
 	return ret;
 }
@@ -198,7 +198,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 		/* round robin for fair dispatch */
 		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
 
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));
+	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
 	return ret;
@@ -238,7 +238,7 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		if (blk_mq_dispatch_rq_list(hctx, &rq_list, false)) {
+		if (blk_mq_dispatch_rq_list(hctx, &rq_list, 0)) {
 			if (has_sched_dispatch)
 				ret = blk_mq_do_dispatch_sched(hctx);
 			else
@@ -251,7 +251,7 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		ret = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
-		blk_mq_dispatch_rq_list(hctx, &rq_list, false);
+		blk_mq_dispatch_rq_list(hctx, &rq_list, 0);
 	}
 
 	return ret;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0e3aab91e6c0..901ef0264e44 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1259,7 +1259,8 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 		 */
 		if (!blk_mq_mark_tag_wait(hctx, rq)) {
 			/* budget is always obtained before getting tag */
-			blk_mq_put_dispatch_budget(rq->q);
+			if (ask_budget)
+				blk_mq_put_dispatch_budget(rq->q);
 			return PREP_DISPATCH_NO_TAG;
 		}
 	}
@@ -1267,11 +1268,21 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 	return PREP_DISPATCH_OK;
 }
 
+static void blk_mq_release_budgets(struct request_queue *q,
+		unsigned int nr_budgets)
+{
+	int i = 0;
+
+	/* release got budgets */
+	while (i++ < nr_budgets)
+		blk_mq_put_dispatch_budget(q);
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
-			     bool got_budget)
+			     unsigned int nr_budgets)
 {
 	enum prep_dispatch prep;
 	struct request_queue *q = hctx->queue;
@@ -1283,7 +1294,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && got_budget);
+	WARN_ON(!list_is_singular(list) && nr_budgets);
 
 	/*
 	 * Now process all the entries, sending them to the driver.
@@ -1295,7 +1306,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		WARN_ON_ONCE(hctx != rq->mq_hctx);
-		prep = blk_mq_prep_dispatch_rq(rq, !got_budget);
+		prep = blk_mq_prep_dispatch_rq(rq, !nr_budgets);
 		if (prep != PREP_DISPATCH_OK)
 			break;
 
@@ -1314,6 +1325,12 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			bd.last = !blk_mq_get_driver_tag(nxt);
 		}
 
+		/*
+		 * once the request is queued to lld, no need to cover the
+		 * budget any more
+		 */
+		if (nr_budgets)
+			nr_budgets--;
 		ret = q->mq_ops->queue_rq(hctx, &bd);
 		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
 			blk_mq_handle_dev_resource(rq, list);
@@ -1353,6 +1370,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		bool no_tag = false;
 		bool no_budget_avail = false;
 
+		blk_mq_release_budgets(q, nr_budgets);
+
 		/*
 		 * For non-shared tags, the RESTART check
 		 * will suffice.
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d2d737b16e0e..f3a93acfad03 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -40,7 +40,8 @@ struct blk_mq_ctx {
 void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
-bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *, bool);
+bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *,
+			     unsigned int);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
-- 
2.25.2

