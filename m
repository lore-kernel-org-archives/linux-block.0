Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49390 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbeHBUWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Aug 2018 16:22:04 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 8/9] blk-mq: Insert blk_pm_{add,put}_request() calls
Date: Thu,  2 Aug 2018 11:29:43 -0700
Message-Id: <20180802182944.14442-9-bart.vanassche@wdc.com>
In-Reply-To: <20180802182944.14442-1-bart.vanassche@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make sure that blk_pm_add_request() is called exactly once before
a request is added to a software queue, to the scheduler and also
before .queue_rq() is called directly. Call blk_pm_put_request()
after a request has finished.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq-sched.c | 13 +++++++++++--
 block/blk-mq.c       |  8 ++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index cf9c66c6d35a..d87839b31d56 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -14,6 +14,7 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-mq-tag.h"
+#include "blk-pm.h"
 #include "blk-wbt.h"
 
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
@@ -349,6 +350,8 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 {
 	/* dispatch flush rq directly */
 	if (rq->rq_flags & RQF_FLUSH_SEQ) {
+		blk_pm_add_request(rq->q, rq);
+
 		spin_lock(&hctx->lock);
 		list_add(&rq->queuelist, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
@@ -380,6 +383,8 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq))
 		goto run;
 
+	blk_pm_add_request(q, rq);
+
 	if (e && e->type->ops.mq.insert_requests) {
 		LIST_HEAD(list);
 
@@ -402,10 +407,14 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 {
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	struct elevator_queue *e = hctx->queue->elevator;
+	struct request *rq;
+
+	if (e && e->type->ops.mq.insert_requests) {
+		list_for_each_entry(rq, list, queuelist)
+			blk_pm_add_request(q, rq);
 
-	if (e && e->type->ops.mq.insert_requests)
 		e->type->ops.mq.insert_requests(hctx, list, false);
-	else {
+	} else {
 		/*
 		 * try to issue requests directly if the hw queue isn't
 		 * busy in case of 'none' scheduler, and this way may save
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8d845872ea02..592d81c37b07 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -36,6 +36,7 @@
 #include "blk-mq-tag.h"
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
+#include "blk-pm.h"
 #include "blk-rq-qos.h"
 
 static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
@@ -476,6 +477,8 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	const int sched_tag = rq->internal_tag;
 
+	blk_pm_put_request(rq);
+
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -1565,6 +1568,8 @@ void blk_mq_request_bypass_insert(struct request *rq, bool run_queue)
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, ctx->cpu);
 
+	blk_pm_add_request(rq->q, rq);
+
 	spin_lock(&hctx->lock);
 	list_add_tail(&rq->queuelist, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
@@ -1586,6 +1591,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	list_for_each_entry(rq, list, queuelist) {
 		BUG_ON(rq->mq_ctx != ctx);
 		trace_block_rq_insert(hctx->queue, rq);
+		blk_pm_add_request(rq->q, rq);
 	}
 
 	spin_lock(&ctx->lock);
@@ -1682,6 +1688,8 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	blk_qc_t new_cookie;
 	blk_status_t ret;
 
+	blk_pm_add_request(q, rq);
+
 	new_cookie = request_to_qc_t(hctx, rq);
 
 	/*
-- 
2.18.0
