Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbdHEG5e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Aug 2017 02:57:34 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 04/20] blk-mq-sched: move actual dispatching into one helper
Date: Sat,  5 Aug 2017 14:56:49 +0800
Message-Id: <20170805065705.12989-5-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-1-ming.lei@redhat.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

So that it becomes easy to support to dispatch from
sw queue in the following patch.

No functional change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 845e5baf8af1..f69752961a34 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -89,6 +89,22 @@ static bool blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
 	return false;
 }
 
+static void blk_mq_do_dispatch(struct request_queue *q,
+			       struct elevator_queue *e,
+			       struct blk_mq_hw_ctx *hctx)
+{
+	LIST_HEAD(rq_list);
+
+	do {
+		struct request *rq;
+
+		rq = e->type->ops.mq.dispatch_request(hctx);
+		if (!rq)
+			break;
+		list_add(&rq->queuelist, &rq_list);
+	} while (blk_mq_dispatch_rq_list(q, &rq_list));
+}
+
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
@@ -136,16 +152,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * on the dispatch list, OR if we did have work but weren't able
 	 * to make progress.
 	 */
-	if (do_sched_dispatch && has_sched_dispatch) {
-		do {
-			struct request *rq;
-
-			rq = e->type->ops.mq.dispatch_request(hctx);
-			if (!rq)
-				break;
-			list_add(&rq->queuelist, &rq_list);
-		} while (blk_mq_dispatch_rq_list(q, &rq_list));
-	}
+	if (do_sched_dispatch && has_sched_dispatch)
+		blk_mq_do_dispatch(q, e, hctx);
 }
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-- 
2.9.4
