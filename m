Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32817 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdDCVnJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 17:43:09 -0400
Received: by mail-pg0-f48.google.com with SMTP id x125so132435280pgb.0
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2017 14:43:09 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 5/5] blk-mq-sched: provide hooks for initializing hardware queue data
Date: Mon,  3 Apr 2017 14:42:05 -0700
Message-Id: <17c182924cb4c6c415d3efccaebcabe5f0f0f9a1.1491254827.git.osandov@fb.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
References: <cover.1491254827.git.osandov@fb.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
References: <cover.1491254827.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Schedulers need to be informed when a hardware queue is added or removed
at runtime so they can allocate/free per-hardware queue data. So,
replace the blk_mq_sched_init_hctx_data() helper, which only makes sense
at init time, with .init_hctx() and .exit_hctx() hooks.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.c     | 81 +++++++++++++++++++++++++-----------------------
 block/blk-mq-sched.h     |  4 ---
 include/linux/elevator.h |  2 ++
 3 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 63281fe34090..435f91bc724f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -30,43 +30,6 @@ void blk_mq_sched_free_hctx_data(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
 
-int blk_mq_sched_init_hctx_data(struct request_queue *q, size_t size,
-				int (*init)(struct blk_mq_hw_ctx *),
-				void (*exit)(struct blk_mq_hw_ctx *))
-{
-	struct blk_mq_hw_ctx *hctx;
-	int ret;
-	int i;
-
-	queue_for_each_hw_ctx(q, hctx, i) {
-		hctx->sched_data = kmalloc_node(size, GFP_KERNEL, hctx->numa_node);
-		if (!hctx->sched_data) {
-			ret = -ENOMEM;
-			goto error;
-		}
-
-		if (init) {
-			ret = init(hctx);
-			if (ret) {
-				/*
-				 * We don't want to give exit() a partially
-				 * initialized sched_data. init() must clean up
-				 * if it fails.
-				 */
-				kfree(hctx->sched_data);
-				hctx->sched_data = NULL;
-				goto error;
-			}
-		}
-	}
-
-	return 0;
-error:
-	blk_mq_sched_free_hctx_data(q, exit);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(blk_mq_sched_init_hctx_data);
-
 static void __blk_mq_sched_assign_ioc(struct request_queue *q,
 				      struct request *rq,
 				      struct bio *bio,
@@ -464,11 +427,24 @@ int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 			   unsigned int hctx_idx)
 {
 	struct elevator_queue *e = q->elevator;
+	int ret;
 
 	if (!e)
 		return 0;
 
-	return blk_mq_sched_alloc_tags(q, hctx, hctx_idx);
+	ret = blk_mq_sched_alloc_tags(q, hctx, hctx_idx);
+	if (ret)
+		return ret;
+
+	if (e->type->ops.mq.init_hctx) {
+		ret = e->type->ops.mq.init_hctx(hctx, hctx_idx);
+		if (ret) {
+			blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
@@ -479,12 +455,18 @@ void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 	if (!e)
 		return;
 
+	if (e->type->ops.mq.exit_hctx && hctx->sched_data) {
+		e->type->ops.mq.exit_hctx(hctx, hctx_idx);
+		hctx->sched_data = NULL;
+	}
+
 	blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
 }
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	struct blk_mq_hw_ctx *hctx;
+	struct elevator_queue *eq;
 	unsigned int i;
 	int ret;
 
@@ -509,6 +491,18 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (ret)
 		goto err;
 
+	if (e->ops.mq.init_hctx) {
+		queue_for_each_hw_ctx(q, hctx, i) {
+			ret = e->ops.mq.init_hctx(hctx, i);
+			if (ret) {
+				eq = q->elevator;
+				blk_mq_exit_sched(q, eq);
+				kobject_put(&eq->kobj);
+				return ret;
+			}
+		}
+	}
+
 	return 0;
 
 err:
@@ -519,6 +513,17 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 {
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	if (e->type->ops.mq.exit_hctx) {
+		queue_for_each_hw_ctx(q, hctx, i) {
+			if (hctx->sched_data) {
+				e->type->ops.mq.exit_hctx(hctx, i);
+				hctx->sched_data = NULL;
+			}
+		}
+	}
 	if (e->type->ops.mq.exit_sched)
 		e->type->ops.mq.exit_sched(e);
 	blk_mq_sched_tags_teardown(q);
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index e704956e0862..c6e760df0fb4 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -4,10 +4,6 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
-int blk_mq_sched_init_hctx_data(struct request_queue *q, size_t size,
-				int (*init)(struct blk_mq_hw_ctx *),
-				void (*exit)(struct blk_mq_hw_ctx *));
-
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *));
 
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 22d39e8d4de1..b7ec315ee7e7 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -93,6 +93,8 @@ struct blk_mq_hw_ctx;
 struct elevator_mq_ops {
 	int (*init_sched)(struct request_queue *, struct elevator_type *);
 	void (*exit_sched)(struct elevator_queue *);
+	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
+	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
 	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);
-- 
2.12.2
