Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5357CC433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 09:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31071207D3
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 09:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjbDDMPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFCJoU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:44:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56309 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbgFCJoU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 05:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591177458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pgznPy8EpYuZ3LtOa2bFAOMOanpr7TYXAaMz04cvJ4=;
        b=FjbDDMPwXujD5M1MRh4/zt87Llrg7h7Ma0qOd6ThqmMo1jLyf421mUwOS4mAC/+qUNjATf
        4Sjz1mRdnFpJIfkAkOuHanbJYSbBj8QI5mNz0zSHyzChA+8JditIMV9x7MbYDtF4N6hM0k
        Gv4wRqMPKT10LGxiPtnnX8RNvsVrbOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-sy9dKoKaPAeR8cb0yw6nHg-1; Wed, 03 Jun 2020 05:44:17 -0400
X-MC-Unique: sy9dKoKaPAeR8cb0yw6nHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DDC6107ACCA;
        Wed,  3 Jun 2020 09:44:15 +0000 (UTC)
Received: from localhost (ovpn-12-230.pek2.redhat.com [10.72.12.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F38078B56;
        Wed,  3 Jun 2020 09:44:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V5 5/6] blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
Date:   Wed,  3 Jun 2020 17:43:36 +0800
Message-Id: <20200603094337.2064181-6-ming.lei@redhat.com>
In-Reply-To: <20200603094337.2064181-1-ming.lei@redhat.com>
References: <20200603094337.2064181-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 block/blk-mq.c       | 31 +++++++++++++++++++++++++++----
 block/blk-mq.h       |  3 ++-
 3 files changed, 33 insertions(+), 9 deletions(-)

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
index 4085dc59bea6..adb2e81c1aac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1258,7 +1258,12 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 		 * we'll re-run it below.
 		 */
 		if (!blk_mq_mark_tag_wait(hctx, rq)) {
-			blk_mq_put_dispatch_budget(rq->q);
+			/*
+			 * All budgets not got from this function will be put
+			 * together during handling partial dispatch
+			 */
+			if (need_budget)
+				blk_mq_put_dispatch_budget(rq->q);
 			return PREP_DISPATCH_NO_TAG;
 		}
 	}
@@ -1266,11 +1271,21 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 	return PREP_DISPATCH_OK;
 }
 
+/* release all allocated budgets before calling to blk_mq_dispatch_rq_list */
+static void blk_mq_release_budgets(struct request_queue *q,
+		unsigned int nr_budgets)
+{
+	int i;
+
+	for (i = 0; i < nr_budgets; i++)
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
@@ -1282,7 +1297,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && got_budget);
+	WARN_ON(!list_is_singular(list) && nr_budgets);
 
 	/*
 	 * Now process all the entries, sending them to the driver.
@@ -1294,7 +1309,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		WARN_ON_ONCE(hctx != rq->mq_hctx);
-		prep = blk_mq_prep_dispatch_rq(rq, !got_budget);
+		prep = blk_mq_prep_dispatch_rq(rq, !nr_budgets);
 		if (prep != PREP_DISPATCH_OK)
 			break;
 
@@ -1313,6 +1328,12 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
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
@@ -1354,6 +1375,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
                         (hctx->flags & BLK_MQ_F_TAG_SHARED);
 		bool no_budget_avail = prep == PREP_DISPATCH_NO_BUDGET;
 
+		blk_mq_release_budgets(q, nr_budgets);
+
 		/*
 		 * If we didn't flush the entire list, we could have told
 		 * the driver there was more coming, but that turned out to
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

