Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D23C433FE
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352192AbhLCNTP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:19:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238833AbhLCNTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 08:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638537351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIu98v0MeP0xMIXACOn8iueeCuaNPlmhFXIjMlltfkk=;
        b=FaUr80kLW1T0JWnRzK4nHOTInGhC+m5WazlDqgSI9foqSjjXySGq+bMTJoqIwE32J3cu7m
        8tQ2iODTZaSvSiFbXbPGTqmwH+FT11O814uYPHbcpi+nmvnIc5oRbmFtIHCSzG9OruQ+WY
        Y0Ih1TFu4Yoy+urdqaZ0YIgq+HqtNRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-KwmeoQWtPE2ab24cALL7Qg-1; Fri, 03 Dec 2021 08:15:49 -0500
X-MC-Unique: KwmeoQWtPE2ab24cALL7Qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0CAE81EE62;
        Fri,  3 Dec 2021 13:15:48 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFABE60622;
        Fri,  3 Dec 2021 13:15:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] blk-mq: remove hctx_lock and hctx_unlock
Date:   Fri,  3 Dec 2021 21:15:31 +0800
Message-Id: <20211203131534.3668411-2-ming.lei@redhat.com>
In-Reply-To: <20211203131534.3668411-1-ming.lei@redhat.com>
References: <20211203131534.3668411-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove hctx_lock and hctx_unlock, and add one helper of
blk_mq_run_dispatch_ops() to run code block defined in dispatch_ops
with rcu/srcu read held.

Compared with hctx_lock()/hctx_unlock():

1) remove 2 branch to 1, so we just need to check
(hctx->flags & BLK_MQ_F_BLOCKING) once when running one dispatch_ops

2) srcu_idx needn't to be touched in case of non-blocking

3) might_sleep_if() can be moved to the blocking branch

Also put the added blk_mq_run_dispatch_ops() in private header, so that
the following patch can use it out of blk-mq.c.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 57 +++++++++-----------------------------------------
 block/blk-mq.h | 16 ++++++++++++++
 2 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fc4520e992b1..a9d69e1dea8b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1071,26 +1071,6 @@ void blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
-	__releases(hctx->srcu)
-{
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
-		rcu_read_unlock();
-	else
-		srcu_read_unlock(hctx->srcu, srcu_idx);
-}
-
-static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
-	__acquires(hctx->srcu)
-{
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		/* shut up gcc false positive */
-		*srcu_idx = 0;
-		rcu_read_lock();
-	} else
-		*srcu_idx = srcu_read_lock(hctx->srcu);
-}
-
 /**
  * blk_mq_start_request - Start processing a request
  * @rq: Pointer to request to be started
@@ -1947,19 +1927,13 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
  */
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
-	int srcu_idx;
-
 	/*
 	 * We can't run the queue inline with ints disabled. Ensure that
 	 * we catch bad users of this early.
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
-	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
-
-	hctx_lock(hctx, &srcu_idx);
-	blk_mq_sched_dispatch_requests(hctx);
-	hctx_unlock(hctx, srcu_idx);
+	blk_mq_run_dispatch_ops(hctx, blk_mq_sched_dispatch_requests(hctx));
 }
 
 static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
@@ -2071,7 +2045,6 @@ EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
  */
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
-	int srcu_idx;
 	bool need_run;
 
 	/*
@@ -2082,10 +2055,9 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
 	 * quiesced.
 	 */
-	hctx_lock(hctx, &srcu_idx);
-	need_run = !blk_queue_quiesced(hctx->queue) &&
-		blk_mq_hctx_has_pending(hctx);
-	hctx_unlock(hctx, srcu_idx);
+	blk_mq_run_dispatch_ops(hctx,
+		need_run = !blk_queue_quiesced(hctx->queue) &&
+		blk_mq_hctx_has_pending(hctx));
 
 	if (need_run)
 		__blk_mq_delay_run_hw_queue(hctx, async, 0);
@@ -2488,32 +2460,22 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq)
 {
-	blk_status_t ret;
-	int srcu_idx;
-
-	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
+	blk_status_t ret =
+		__blk_mq_try_issue_directly(hctx, rq, false, true);
 
-	hctx_lock(hctx, &srcu_idx);
-
-	ret = __blk_mq_try_issue_directly(hctx, rq, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
 		blk_mq_request_bypass_insert(rq, false, true);
 	else if (ret != BLK_STS_OK)
 		blk_mq_end_request(rq, ret);
-
-	hctx_unlock(hctx, srcu_idx);
 }
 
 static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
 	blk_status_t ret;
-	int srcu_idx;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, true, last);
-	hctx_unlock(hctx, srcu_idx);
-
+	blk_mq_run_dispatch_ops(hctx,
+		ret = __blk_mq_try_issue_directly(hctx, rq, true, last));
 	return ret;
 }
 
@@ -2826,7 +2788,8 @@ void blk_mq_submit_bio(struct bio *bio)
 		  (q->nr_hw_queues == 1 || !is_sync)))
 		blk_mq_sched_insert_request(rq, false, true, true);
 	else
-		blk_mq_try_issue_directly(rq->mq_hctx, rq);
+		blk_mq_run_dispatch_ops(rq->mq_hctx,
+				blk_mq_try_issue_directly(rq->mq_hctx, rq));
 }
 
 /**
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d516c7a46f57..e4c396204928 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -374,5 +374,21 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return __blk_mq_active_requests(hctx) < depth;
 }
 
+/* run the code block in @dispatch_ops with rcu/srcu read lock held */
+#define blk_mq_run_dispatch_ops(hctx, dispatch_ops)		\
+do {								\
+	if (!((hctx)->flags & BLK_MQ_F_BLOCKING)) {		\
+		rcu_read_lock();				\
+		(dispatch_ops);					\
+		rcu_read_unlock();				\
+	} else {						\
+		int srcu_idx;					\
+								\
+		might_sleep();					\
+		srcu_idx = srcu_read_lock((hctx)->srcu);	\
+		(dispatch_ops);					\
+		srcu_read_unlock((hctx)->srcu, srcu_idx);	\
+	}							\
+} while (0)
 
 #endif
-- 
2.31.1

