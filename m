Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34211 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755814AbdDETCy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 15:02:54 -0400
Received: by mail-pg0-f41.google.com with SMTP id 21so12953801pgg.1
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 12:02:52 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v3 3/8] blk-mq-sched: set up scheduler tags when bringing up new queues
Date: Wed,  5 Apr 2017 12:01:31 -0700
Message-Id: <138eeb30ef2533cefa165a4c621abf26a1989604.1491418411.git.osandov@fb.com>
In-Reply-To: <cover.1491418411.git.osandov@fb.com>
References: <cover.1491418411.git.osandov@fb.com>
In-Reply-To: <cover.1491418411.git.osandov@fb.com>
References: <cover.1491418411.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

If a new hardware queue is added at runtime, we don't allocate scheduler
tags for it, leading to a crash. This hooks up the scheduler framework
to blk_mq_{init,exit}_hctx() to make sure everything gets properly
initialized/freed.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.c | 22 ++++++++++++++++++++++
 block/blk-mq-sched.h |  5 +++++
 block/blk-mq.c       |  9 ++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 6bd1758ea29b..0bb13bb51daa 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -461,6 +461,28 @@ void blk_mq_sched_teardown(struct request_queue *q)
 		blk_mq_sched_free_tags(set, hctx, i);
 }
 
+int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
+			   unsigned int hctx_idx)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (!e)
+		return 0;
+
+	return blk_mq_sched_alloc_tags(q, hctx, hctx_idx);
+}
+
+void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
+			    unsigned int hctx_idx)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (!e)
+		return;
+
+	blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
+}
+
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 873f9af5a35b..19db25e0c95a 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -35,6 +35,11 @@ void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_sched_teardown(struct request_queue *q);
 
+int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
+			   unsigned int hctx_idx);
+void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
+			    unsigned int hctx_idx);
+
 int blk_mq_sched_init(struct request_queue *q);
 
 static inline bool
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 09cff6d1ba76..672430c8c342 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1823,6 +1823,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 				       hctx->fq->flush_rq, hctx_idx,
 				       flush_start_tag + hctx_idx);
 
+	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
+
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
@@ -1889,9 +1891,12 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
 		goto free_bitmap;
 
+	if (blk_mq_sched_init_hctx(q, hctx, hctx_idx))
+		goto exit_hctx;
+
 	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
 	if (!hctx->fq)
-		goto exit_hctx;
+		goto sched_exit_hctx;
 
 	if (set->ops->init_request &&
 	    set->ops->init_request(set->driver_data,
@@ -1906,6 +1911,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
  free_fq:
 	kfree(hctx->fq);
+ sched_exit_hctx:
+	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
-- 
2.12.2
