Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35388 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdDCVnG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 17:43:06 -0400
Received: by mail-pg0-f44.google.com with SMTP id 81so132582900pgh.2
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2017 14:43:06 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 1/5] blk-mq-sched: refactor scheduler initialization
Date: Mon,  3 Apr 2017 14:42:01 -0700
Message-Id: <0fb151bd219945ab58e5ab3847c1941b1464411c.1491254827.git.osandov@fb.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
References: <cover.1491254827.git.osandov@fb.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
References: <cover.1491254827.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Preparation cleanup for the next couple of fixes, push
blk_mq_sched_setup() and e->ops.mq.init_sched() into a helper.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.c | 82 ++++++++++++++++++++++++++++------------------------
 block/blk-mq-sched.h |  2 +-
 block/elevator.c     | 32 ++++++++------------
 3 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 09af8ff18719..e08ba915343e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -431,11 +431,45 @@ static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
 	}
 }
 
-int blk_mq_sched_setup(struct request_queue *q)
+static int blk_mq_sched_alloc_tags(struct request_queue *q,
+				   struct blk_mq_hw_ctx *hctx,
+				   unsigned int hctx_idx)
+{
+	struct blk_mq_tag_set *set = q->tag_set;
+	int ret;
+
+	hctx->sched_tags = blk_mq_alloc_rq_map(set, hctx_idx, q->nr_requests,
+					       set->reserved_tags);
+	if (!hctx->sched_tags)
+		return -ENOMEM;
+
+	ret = blk_mq_alloc_rqs(set, hctx->sched_tags, hctx_idx, q->nr_requests);
+	if (ret)
+		blk_mq_sched_free_tags(set, hctx, hctx_idx);
+
+	return ret;
+}
+
+void blk_mq_sched_teardown(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
-	int ret, i;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_sched_free_tags(set, hctx, i);
+}
+
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+	int ret;
+
+	if (!e) {
+		q->elevator = NULL;
+		return 0;
+	}
 
 	/*
 	 * Default to 256, since we don't split into sync/async like the
@@ -443,49 +477,21 @@ int blk_mq_sched_setup(struct request_queue *q)
 	 */
 	q->nr_requests = 2 * BLKDEV_MAX_RQ;
 
-	/*
-	 * We're switching to using an IO scheduler, so setup the hctx
-	 * scheduler tags and switch the request map from the regular
-	 * tags to scheduler tags. First allocate what we need, so we
-	 * can safely fail and fallback, if needed.
-	 */
-	ret = 0;
 	queue_for_each_hw_ctx(q, hctx, i) {
-		hctx->sched_tags = blk_mq_alloc_rq_map(set, i,
-				q->nr_requests, set->reserved_tags);
-		if (!hctx->sched_tags) {
-			ret = -ENOMEM;
-			break;
-		}
-		ret = blk_mq_alloc_rqs(set, hctx->sched_tags, i, q->nr_requests);
+		ret = blk_mq_sched_alloc_tags(q, hctx, i);
 		if (ret)
-			break;
+			goto err;
 	}
 
-	/*
-	 * If we failed, free what we did allocate
-	 */
-	if (ret) {
-		queue_for_each_hw_ctx(q, hctx, i) {
-			if (!hctx->sched_tags)
-				continue;
-			blk_mq_sched_free_tags(set, hctx, i);
-		}
-
-		return ret;
-	}
+	ret = e->ops.mq.init_sched(q, e);
+	if (ret)
+		goto err;
 
 	return 0;
-}
 
-void blk_mq_sched_teardown(struct request_queue *q)
-{
-	struct blk_mq_tag_set *set = q->tag_set;
-	struct blk_mq_hw_ctx *hctx;
-	int i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_sched_free_tags(set, hctx, i);
+err:
+	blk_mq_sched_teardown(q);
+	return ret;
 }
 
 int blk_mq_sched_init(struct request_queue *q)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index a75b16b123f7..873f9af5a35b 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -32,7 +32,7 @@ void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
 			struct list_head *rq_list,
 			struct request *(*get_rq)(struct blk_mq_hw_ctx *));
 
-int blk_mq_sched_setup(struct request_queue *q);
+int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_sched_teardown(struct request_queue *q);
 
 int blk_mq_sched_init(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index 01139f549b5b..f236ef1d2be9 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -242,17 +242,12 @@ int elevator_init(struct request_queue *q, char *name)
 		}
 	}
 
-	if (e->uses_mq) {
-		err = blk_mq_sched_setup(q);
-		if (!err)
-			err = e->ops.mq.init_sched(q, e);
-	} else
+	if (e->uses_mq)
+		err = blk_mq_init_sched(q, e);
+	else
 		err = e->ops.sq.elevator_init_fn(q, e);
-	if (err) {
-		if (e->uses_mq)
-			blk_mq_sched_teardown(q);
+	if (err)
 		elevator_put(e);
-	}
 	return err;
 }
 EXPORT_SYMBOL(elevator_init);
@@ -987,21 +982,18 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	}
 
 	/* allocate, init and register new elevator */
-	if (new_e) {
-		if (new_e->uses_mq) {
-			err = blk_mq_sched_setup(q);
-			if (!err)
-				err = new_e->ops.mq.init_sched(q, new_e);
-		} else
-			err = new_e->ops.sq.elevator_init_fn(q, new_e);
-		if (err)
-			goto fail_init;
+	if (q->mq_ops)
+		err = blk_mq_init_sched(q, new_e);
+	else
+		err = new_e->ops.sq.elevator_init_fn(q, new_e);
+	if (err)
+		goto fail_init;
 
+	if (new_e) {
 		err = elv_register_queue(q);
 		if (err)
 			goto fail_register;
-	} else
-		q->elevator = NULL;
+	}
 
 	/* done, kill the old one and finish */
 	if (old) {
-- 
2.12.2
