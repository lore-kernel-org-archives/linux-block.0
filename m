Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36509 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdB0WwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 17:52:23 -0500
Received: by mail-pg0-f46.google.com with SMTP id s67so49405272pgb.3
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2017 14:50:39 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2] blk-mq: make blk_mq_alloc_request_hctx() allocate a scheduler request
Date: Mon, 27 Feb 2017 10:28:27 -0800
Message-Id: <fd943d5d48a94d75c250087b681cdb1fea669504.1488220062.git.osandov@fb.com>
In-Reply-To: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
its blk_mq_alloc_request() counterpart. It also crashes because it
doesn't update the tags->rqs map.

Fix it by making it allocate a scheduler request.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.c | 11 +++++------
 block/blk-mq.c       | 33 +++++++++++++++------------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 46ca965fff5c..5697b23412a1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -110,15 +110,14 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 					 struct blk_mq_alloc_data *data)
 {
 	struct elevator_queue *e = q->elevator;
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
 	struct request *rq;
 
 	blk_queue_enter_live(q);
-	ctx = blk_mq_get_ctx(q);
-	hctx = blk_mq_map_queue(q, ctx->cpu);
-
-	blk_mq_set_alloc_data(data, q, data->flags, ctx, hctx);
+	data->q = q;
+	if (likely(!data->ctx))
+		data->ctx = blk_mq_get_ctx(q);
+	if (likely(!data->hctx))
+		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
 	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4df5fb42c74f..85a7047d8b03 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -273,10 +273,9 @@ EXPORT_SYMBOL(blk_mq_alloc_request);
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 		unsigned int flags, unsigned int hctx_idx)
 {
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
+	struct blk_mq_alloc_data alloc_data = { .flags = flags };
 	struct request *rq;
-	struct blk_mq_alloc_data alloc_data;
+	unsigned int cpu;
 	int ret;
 
 	/*
@@ -299,25 +298,23 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
 	 */
-	hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(hctx)) {
-		ret = -EXDEV;
-		goto out_queue_exit;
+	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
+	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
+		blk_queue_exit(q);
+		return ERR_PTR(-EXDEV);
 	}
-	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
+	cpu = cpumask_first(alloc_data.hctx->cpumask);
+	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
-	rq = __blk_mq_alloc_request(&alloc_data, rw);
-	if (!rq) {
-		ret = -EWOULDBLOCK;
-		goto out_queue_exit;
-	}
-
-	return rq;
+	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
 
-out_queue_exit:
+	blk_mq_put_ctx(alloc_data.ctx);
 	blk_queue_exit(q);
-	return ERR_PTR(ret);
+
+	if (!rq)
+		return ERR_PTR(-EWOULDBLOCK);
+
+	return rq;
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-- 
2.12.0
