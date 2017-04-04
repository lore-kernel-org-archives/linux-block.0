Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34812 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbdDDQvJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 12:51:09 -0400
Received: by mail-pg0-f44.google.com with SMTP id 21so158018666pgg.1
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2017 09:51:04 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 3/5] blk-mq-sched: make completed_request() callback more useful
Date: Tue,  4 Apr 2017 09:49:56 -0700
Message-Id: <fd069c79175711a85f37f1105aecf7c974d001a9.1491324365.git.osandov@fb.com>
In-Reply-To: <cover.1491324365.git.osandov@fb.com>
References: <cover.1491324365.git.osandov@fb.com>
In-Reply-To: <cover.1491324365.git.osandov@fb.com>
References: <cover.1491324365.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, this callback is called right after put_request() and has no
distinguishable purpose. Instead, let's call it before put_request() as
soon as I/O has completed on the request, before we account it in
blk-stat. With this, Kyber can enable stats when it sees a latency
outlier and make sure the outlier gets accounted.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.h     | 11 +++--------
 block/blk-mq.c           |  5 ++++-
 include/linux/elevator.h |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index c6e760df0fb4..d846e07bb564 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -82,17 +82,12 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
 	return true;
 }
 
-static inline void
-blk_mq_sched_completed_request(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static inline void blk_mq_sched_completed_request(struct request *rq)
 {
-	struct elevator_queue *e = hctx->queue->elevator;
+	struct elevator_queue *e = rq->q->elevator;
 
 	if (e && e->type->ops.mq.completed_request)
-		e->type->ops.mq.completed_request(hctx, rq);
-
-	BUG_ON(rq->internal_tag == -1);
-
-	blk_mq_put_tag(hctx, hctx->sched_tags, rq->mq_ctx, rq->internal_tag);
+		e->type->ops.mq.completed_request(rq);
 }
 
 static inline void blk_mq_sched_started_request(struct request *rq)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b49fdfde7e06..3dbfed6d0e5b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -350,7 +350,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
-		blk_mq_sched_completed_request(hctx, rq);
+		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart_queues(hctx);
 	blk_queue_exit(q);
 }
@@ -443,6 +443,9 @@ static void __blk_mq_complete_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
+	if (rq->internal_tag != -1)
+		blk_mq_sched_completed_request(rq);
+
 	blk_mq_stat_add(rq);
 
 	if (!q->softirq_done_fn)
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index b7ec315ee7e7..3a216318ae73 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -106,7 +106,7 @@ struct elevator_mq_ops {
 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
-	void (*completed_request)(struct blk_mq_hw_ctx *, struct request *);
+	void (*completed_request)(struct request *);
 	void (*started_request)(struct request *);
 	void (*requeue_request)(struct request *);
 	struct request *(*former_request)(struct request_queue *, struct request *);
-- 
2.12.2
