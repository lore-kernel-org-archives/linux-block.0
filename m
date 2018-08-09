Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33854 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHIWxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 18:53:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so3278683pgv.1
        for <linux-block@vger.kernel.org>; Thu, 09 Aug 2018 13:26:57 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [RFC PATCH 1/5] block: move call of scheduler's ->completed_request() hook
Date: Thu,  9 Aug 2018 13:26:43 -0700
Message-Id: <dc018874d79575db91e3ec44c09511720e2b0ab0.1533846185.git.osandov@fb.com>
In-Reply-To: <cover.1533846185.git.osandov@fb.com>
References: <cover.1533846185.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit 4bc6339a583c ("block: move blk_stat_add() to
__blk_mq_end_request()") consolidated some calls using ktime_get() so
we'd only need to call it once. Kyber's ->completed_request() hook also
calls ktime_get(), so let's move it to the same place, too.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.h     | 4 ++--
 block/blk-mq.c           | 5 +++--
 block/kyber-iosched.c    | 5 ++---
 include/linux/elevator.h | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0cb8f938dff9..74fb6ff9a30d 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -54,12 +54,12 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
 	return true;
 }
 
-static inline void blk_mq_sched_completed_request(struct request *rq)
+static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 {
 	struct elevator_queue *e = rq->q->elevator;
 
 	if (e && e->type->ops.mq.completed_request)
-		e->type->ops.mq.completed_request(rq);
+		e->type->ops.mq.completed_request(rq, now);
 }
 
 static inline void blk_mq_sched_started_request(struct request *rq)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 654b0dc7e001..0c5be0001d0f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -524,6 +524,9 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 		blk_stat_add(rq, now);
 	}
 
+	if (rq->internal_tag != -1)
+		blk_mq_sched_completed_request(rq, now);
+
 	blk_account_io_done(rq, now);
 
 	if (rq->end_io) {
@@ -560,8 +563,6 @@ static void __blk_mq_complete_request(struct request *rq)
 
 	if (!blk_mq_mark_complete(rq))
 		return;
-	if (rq->internal_tag != -1)
-		blk_mq_sched_completed_request(rq);
 
 	if (!test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags)) {
 		rq->q->softirq_done_fn(rq);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index a1660bafc912..95d062c07c61 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -558,12 +558,12 @@ static void kyber_finish_request(struct request *rq)
 	rq_clear_domain_token(kqd, rq);
 }
 
-static void kyber_completed_request(struct request *rq)
+static void kyber_completed_request(struct request *rq, u64 now)
 {
 	struct request_queue *q = rq->q;
 	struct kyber_queue_data *kqd = q->elevator->elevator_data;
 	unsigned int sched_domain;
-	u64 now, latency, target;
+	u64 latency, target;
 
 	/*
 	 * Check if this request met our latency goal. If not, quickly gather
@@ -585,7 +585,6 @@ static void kyber_completed_request(struct request *rq)
 	if (blk_stat_is_active(kqd->cb))
 		return;
 
-	now = ktime_get_ns();
 	if (now < rq->io_start_time_ns)
 		return;
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index a02deea30185..015bb59c0331 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -111,7 +111,7 @@ struct elevator_mq_ops {
 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
-	void (*completed_request)(struct request *);
+	void (*completed_request)(struct request *, u64);
 	void (*started_request)(struct request *);
 	void (*requeue_request)(struct request *);
 	struct request *(*former_request)(struct request_queue *, struct request *);
-- 
2.18.0
