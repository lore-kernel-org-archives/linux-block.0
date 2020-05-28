Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4650DC433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267E02145D
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdWuf2qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE1IBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 04:01:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42750 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726063AbgE1IBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 04:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590652898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ9wmxgeA0IEILToZXkdoC9Gd3VpEK4qn6KqEhMbTd4=;
        b=RdWuf2qgkOKboIsTFYKvl97uO7fm4ZF7VezENdxwmNUCk2MwxWREs9x66ICxEnGFZA08aC
        sKgzrzz3CxGwnm1t7c57j94P+NVxvqZKxuv1tFafKXAz8nvzMLAOHDDiFzxR+m3NeJXeIx
        YUwciIGsjni5yJU5WIGf0JUt/wmfbvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-IoXFJC3VOlytBbYy_j4cDw-1; Thu, 28 May 2020 04:01:36 -0400
X-MC-Unique: IoXFJC3VOlytBbYy_j4cDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5876C460;
        Thu, 28 May 2020 08:01:35 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78D1819D82;
        Thu, 28 May 2020 08:01:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 5/6] blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
Date:   Thu, 28 May 2020 16:00:52 +0800
Message-Id: <20200528080053.1062653-6-ming.lei@redhat.com>
In-Reply-To: <20200528080053.1062653-1-ming.lei@redhat.com>
References: <20200528080053.1062653-1-ming.lei@redhat.com>
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
index d41a0bffde88..626757414a6a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1222,7 +1222,8 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
 		 */
 		if (!blk_mq_mark_tag_wait(hctx, rq)) {
 			/* budget is always obtained before getting tag */
-			blk_mq_put_dispatch_budget(rq->q);
+			if (ask_budget)
+				blk_mq_put_dispatch_budget(rq->q);
 			return PREP_DISPATCH_NO_TAG;
 		}
 	}
@@ -1230,11 +1231,21 @@ static enum prep_dispatch blk_mq_prep_dispatch_rq(struct request *rq,
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
@@ -1246,7 +1257,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && got_budget);
+	WARN_ON(!list_is_singular(list) && nr_budgets);
 
 	/*
 	 * Now process all the entries, sending them to the driver.
@@ -1258,7 +1269,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		WARN_ON_ONCE(hctx != rq->mq_hctx);
-		prep = blk_mq_prep_dispatch_rq(rq, !got_budget);
+		prep = blk_mq_prep_dispatch_rq(rq, !nr_budgets);
 		if (prep != PREP_DISPATCH_OK)
 			break;
 
@@ -1279,6 +1290,12 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 
 		ret = q->mq_ops->queue_rq(hctx, &bd);
 		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
+			/*
+			 * once the request is queued to lld, we don't need to
+			 * cover budget any more
+			 */
+			if (nr_budgets)
+				nr_budgets--;
 			blk_mq_handle_dev_resource(rq, list);
 			break;
 		} else if (ret == BLK_STS_ZONE_RESOURCE) {
@@ -1316,6 +1333,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		bool no_tag = false;
 		bool no_budget_avail = false;
 
+		blk_mq_release_budgets(q, nr_budgets);
+
 		/*
 		 * For non-shared tags, the RESTART check
 		 * will suffice.
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9c0e93d4fe38..97d39a63353a 100644
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

