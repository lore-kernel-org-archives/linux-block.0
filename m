Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66453C433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6E561040
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbhJQBkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbhJQBkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790F1C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:56 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e144so12217359iof.3
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kulItnynzJhecGOua2JHXYjtl5ISMVm/qb97eP8VDrc=;
        b=Ht1c48nBdWf+wlcfiZRiTp5QaMW+/DmtZEmp3lEUUDWEPTU/7JPpnhsEz7CfEd+6J2
         ejTS8+GO0cNpfWJz87jtgctINCQSlzzPW0TLukYeUd7cuzD97KKI7gCaHehZrTOFWn23
         W6yiwWIR5erZZssjuawTwpx6dajBtKEjJ4q+DW3SkpaLUlcZ5VKq4TvzdNyAam3rFzA5
         vV8Ogjmq4InSjwyCAJCMQj/djbwoH5sT+u+u7T1aE/Hw3ZbqIJbEFQpEKGufrofBMRIX
         Zi2wbAEy11bRPZ0QhdbtRRY/xyV2WeSUnCf7A16nJ+8GvIu/cDw0Jk9Avf7k5lYlBRUG
         ZPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kulItnynzJhecGOua2JHXYjtl5ISMVm/qb97eP8VDrc=;
        b=h+MG6BG038qScOXfcKKRzTWUfzmO1ri/sQ3kwCFpBUveCTevn3yGzQzeYIcfdLf7yf
         lHFSPQo6E3YLzwL6XhIUFxgw9at4OEGTrgqx2FJozXgYgRcMsjEJKVx+bWBVwIZyaoJY
         g/+rQyP4xWPZskxtXgWfngV8ty7mZSnQ6iLO7zusSdGysM3gNNhYbvQdnzox6GG08Pyk
         Wsy1vF3h3fgHg9MqYFyUbzfiNkNb+HDu7gEEMARW4VNkCLT/RHxd5eYFhYZif8bYrpZE
         /mg5gJdcp8SzTc/JvznSmEVxAJgbzv0h8PtC+EfulA7jYr4mBPKrzMiWMgf5xUSpxQ1Y
         qPIQ==
X-Gm-Message-State: AOAM5306i8CyxRYjJdAvw15Cre3uNyfszUeYPdiq47vvwWhgm67Iw97K
        SeOwNKMIwtZGQpkVQbRbpoAA4KZ47sjF0w==
X-Google-Smtp-Source: ABdhPJxvQ/TuF1l8q0T8KC8j2+U3rWPSQww0UPGSDS9DaXuCJxZ6s0VKDB0FcmHc8zTcisnCqBaXSw==
X-Received: by 2002:a02:ac8a:: with SMTP id x10mr13729163jan.43.1634434675728;
        Sat, 16 Oct 2021 18:37:55 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/14] block: store elevator state in request
Date:   Sat, 16 Oct 2021 19:37:40 -0600
Message-Id: <20211017013748.76461-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add an rq private RQF_ELV flag, which tells the block layer that this
request was initialized on a queue that has an IO scheduler attached.
This allows for faster checking in the fast path, rather than having to
deference rq->q later on.

Elevator switching does full quiesce of the queue before detaching an
IO scheduler, so it's safe to cache this in the request itself.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sched.h   | 27 ++++++++++++++++-----------
 block/blk-mq.c         | 20 +++++++++++---------
 include/linux/blk-mq.h |  2 ++
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index fe252278ed9a..98836106b25f 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -56,29 +56,34 @@ static inline bool
 blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
 			 struct bio *bio)
 {
-	struct elevator_queue *e = q->elevator;
-
-	if (e && e->type->ops.allow_merge)
-		return e->type->ops.allow_merge(q, rq, bio);
+	if (rq->rq_flags & RQF_ELV) {
+		struct elevator_queue *e = q->elevator;
 
+		if (e->type->ops.allow_merge)
+			return e->type->ops.allow_merge(q, rq, bio);
+	}
 	return true;
 }
 
 static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 {
-	struct elevator_queue *e = rq->q->elevator;
+	if (rq->rq_flags & RQF_ELV) {
+		struct elevator_queue *e = rq->q->elevator;
 
-	if (e && e->type->ops.completed_request)
-		e->type->ops.completed_request(rq, now);
+		if (e->type->ops.completed_request)
+			e->type->ops.completed_request(rq, now);
+	}
 }
 
 static inline void blk_mq_sched_requeue_request(struct request *rq)
 {
-	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
+	if (rq->rq_flags & RQF_ELV) {
+		struct request_queue *q = rq->q;
+		struct elevator_queue *e = q->elevator;
 
-	if ((rq->rq_flags & RQF_ELVPRIV) && e && e->type->ops.requeue_request)
-		e->type->ops.requeue_request(rq);
+		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
+			e->type->ops.requeue_request(rq);
+	}
 }
 
 static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fa5b12200404..5d22c228f6df 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -299,7 +299,7 @@ void blk_mq_wake_waiters(struct request_queue *q)
  */
 static inline bool blk_mq_need_time_stamp(struct request *rq)
 {
-	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS)) || rq->q->elevator;
+	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
 }
 
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
@@ -309,9 +309,11 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	struct request *rq = tags->static_rqs[tag];
 
 	if (data->q->elevator) {
+		rq->rq_flags = RQF_ELV;
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
 	} else {
+		rq->rq_flags = 0;
 		rq->tag = tag;
 		rq->internal_tag = BLK_MQ_NO_TAG;
 	}
@@ -320,7 +322,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->q = data->q;
 	rq->mq_ctx = data->ctx;
 	rq->mq_hctx = data->hctx;
-	rq->rq_flags = 0;
 	rq->cmd_flags = data->cmd_flags;
 	if (data->flags & BLK_MQ_REQ_PM)
 		rq->rq_flags |= RQF_PM;
@@ -356,11 +357,11 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
 	refcount_set(&rq->ref, 1);
 
-	if (!op_is_flush(data->cmd_flags)) {
+	if (!op_is_flush(data->cmd_flags) && (rq->rq_flags & RQF_ELV)) {
 		struct elevator_queue *e = data->q->elevator;
 
 		rq->elv.icq = NULL;
-		if (e && e->type->ops.prepare_request) {
+		if (e->type->ops.prepare_request) {
 			if (e->type->icq_cache)
 				blk_mq_sched_assign_ioc(rq);
 
@@ -575,12 +576,13 @@ static void __blk_mq_free_request(struct request *rq)
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	if (rq->rq_flags & RQF_ELVPRIV) {
-		if (e && e->type->ops.finish_request)
+	if (rq->rq_flags & (RQF_ELVPRIV | RQF_ELV)) {
+		struct elevator_queue *e = q->elevator;
+
+		if (e->type->ops.finish_request)
 			e->type->ops.finish_request(rq);
 		if (rq->elv.icq) {
 			put_io_context(rq->elv.icq->ioc);
@@ -2239,7 +2241,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	if (q->elevator && !bypass_insert)
+	if ((rq->rq_flags & RQF_ELV) && !bypass_insert)
 		goto insert;
 
 	budget_token = blk_mq_get_dispatch_budget(q);
@@ -2475,7 +2477,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		}
 
 		blk_add_rq_to_plug(plug, rq);
-	} else if (q->elevator) {
+	} else if (rq->rq_flags & RQF_ELV) {
 		/* Insert the request at the IO scheduler queue */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	} else if (plug && !blk_queue_nomerges(q)) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a9c1d0882550..3a399aa372b5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -55,6 +55,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
 /* ->timeout has been called, don't expire again */
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
+/* queue has elevator attached */
+#define RQF_ELV			((__force req_flags_t)(1 << 22))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.33.1

