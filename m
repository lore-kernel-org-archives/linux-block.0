Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F7AC433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 13:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352200AbhLCNTr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:19:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352195AbhLCNTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Dec 2021 08:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638537383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrbNS1neTOQ19aLDeR9Lk4Xy54uSJ1iptd23A75ZGh4=;
        b=SnoW3fzcVNmowlnFxpLmWliexXe3gXIhS68pG7/ej/OpUIq6CVh+uYIMcWeeVQSu5274lV
        G55gbZs7dg9sZ4iIE3sgZnA0g9lm+UnqCwVTkpUt8qRt/G2aYxR6QBk4oMO3ovHBOB53Hc
        AbF6dMdJKQjCbaBADQwSIPGoCxQdMFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-YUNvnHtVOMymN_Wo_nmQiA-1; Fri, 03 Dec 2021 08:16:20 -0500
X-MC-Unique: YUNvnHtVOMymN_Wo_nmQiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D69A485B67A;
        Fri,  3 Dec 2021 13:16:17 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C6875F4E9;
        Fri,  3 Dec 2021 13:15:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] blk-mq: pass request queue to blk_mq_run_dispatch_ops
Date:   Fri,  3 Dec 2021 21:15:33 +0800
Message-Id: <20211203131534.3668411-4-ming.lei@redhat.com>
In-Reply-To: <20211203131534.3668411-1-ming.lei@redhat.com>
References: <20211203131534.3668411-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have switched to allocate srcu into request queue, so it is fine
to pass request queue to blk_mq_run_dispatch_ops().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 9 +++++----
 block/blk-mq.h | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2186971c683b..03dc76f92555 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1925,7 +1925,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
-	blk_mq_run_dispatch_ops(hctx, blk_mq_sched_dispatch_requests(hctx));
+	blk_mq_run_dispatch_ops(hctx->queue,
+			blk_mq_sched_dispatch_requests(hctx));
 }
 
 static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
@@ -2047,7 +2048,7 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
 	 * quiesced.
 	 */
-	blk_mq_run_dispatch_ops(hctx,
+	blk_mq_run_dispatch_ops(hctx->queue,
 		need_run = !blk_queue_quiesced(hctx->queue) &&
 		blk_mq_hctx_has_pending(hctx));
 
@@ -2466,7 +2467,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	blk_status_t ret;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	blk_mq_run_dispatch_ops(hctx,
+	blk_mq_run_dispatch_ops(rq->q,
 		ret = __blk_mq_try_issue_directly(hctx, rq, true, last));
 	return ret;
 }
@@ -2780,7 +2781,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		  (q->nr_hw_queues == 1 || !is_sync)))
 		blk_mq_sched_insert_request(rq, false, true, true);
 	else
-		blk_mq_run_dispatch_ops(rq->mq_hctx,
+		blk_mq_run_dispatch_ops(rq->q,
 				blk_mq_try_issue_directly(rq->mq_hctx, rq));
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 792f0b29c6eb..d62004e2d531 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -375,9 +375,9 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 }
 
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
-#define blk_mq_run_dispatch_ops(hctx, dispatch_ops)		\
+#define blk_mq_run_dispatch_ops(q, dispatch_ops)		\
 do {								\
-	if (!((hctx)->flags & BLK_MQ_F_BLOCKING)) {		\
+	if (!blk_queue_has_srcu(q)) {				\
 		rcu_read_lock();				\
 		(dispatch_ops);					\
 		rcu_read_unlock();				\
@@ -385,9 +385,9 @@ do {								\
 		int srcu_idx;					\
 								\
 		might_sleep();					\
-		srcu_idx = srcu_read_lock((hctx)->queue->srcu);	\
+		srcu_idx = srcu_read_lock((q)->srcu);		\
 		(dispatch_ops);					\
-		srcu_read_unlock((hctx)->queue->srcu, srcu_idx); \
+		srcu_read_unlock((q)->srcu, srcu_idx);		\
 	}							\
 } while (0)
 
-- 
2.31.1

