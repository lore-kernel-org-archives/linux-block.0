Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36439 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdDCVnI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 17:43:08 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so130864135pge.3
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2017 14:43:08 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 3/5] blk-mq-sched: fix crash in switch error path
Date: Mon,  3 Apr 2017 14:42:03 -0700
Message-Id: <d5ac5194fccde2e72b4b10f59ae91f10a3cc3dea.1491254827.git.osandov@fb.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
References: <cover.1491254827.git.osandov@fb.com>
In-Reply-To: <cover.1491254827.git.osandov@fb.com>
References: <cover.1491254827.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In elevator_switch(), if blk_mq_init_sched() fails, we attempt to fall
back to the original scheduler. However, at this point, we've already
torn down the original scheduler's tags, so this causes a crash. Doing
the fallback like the legacy elevator path is much harder for mq, so fix
it by just falling back to none, instead.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.c     | 13 +++++--
 block/blk-mq-sched.h     |  2 +-
 block/blk-mq.c           |  2 --
 block/blk-sysfs.c        |  2 +-
 block/elevator.c         | 94 +++++++++++++++++++++++++++---------------------
 include/linux/elevator.h |  2 +-
 6 files changed, 67 insertions(+), 48 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 3fd918bb13a2..63281fe34090 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -450,7 +450,7 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
 	return ret;
 }
 
-void blk_mq_sched_teardown(struct request_queue *q)
+static void blk_mq_sched_tags_teardown(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
@@ -512,10 +512,19 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	return 0;
 
 err:
-	blk_mq_sched_teardown(q);
+	blk_mq_sched_tags_teardown(q);
+	q->elevator = NULL;
 	return ret;
 }
 
+void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
+{
+	if (e->type->ops.mq.exit_sched)
+		e->type->ops.mq.exit_sched(e);
+	blk_mq_sched_tags_teardown(q);
+	q->elevator = NULL;
+}
+
 int blk_mq_sched_init(struct request_queue *q)
 {
 	int ret;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 19db25e0c95a..e704956e0862 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -33,7 +33,7 @@ void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
 			struct request *(*get_rq)(struct blk_mq_hw_ctx *));
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
-void blk_mq_sched_teardown(struct request_queue *q);
+void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 
 int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 			   unsigned int hctx_idx);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ac830cb488d7..477951d10cc9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2153,8 +2153,6 @@ void blk_mq_release(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	blk_mq_sched_teardown(q);
-
 	/* hctx kobj stays in hctx */
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 45854266e398..c47db43a40cc 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -803,7 +803,7 @@ static void blk_release_queue(struct kobject *kobj)
 
 	if (q->elevator) {
 		ioc_clear_queue(q);
-		elevator_exit(q->elevator);
+		elevator_exit(q, q->elevator);
 	}
 
 	blk_free_queue_stats(q->stats);
diff --git a/block/elevator.c b/block/elevator.c
index f236ef1d2be9..dbeecf7be719 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -252,11 +252,11 @@ int elevator_init(struct request_queue *q, char *name)
 }
 EXPORT_SYMBOL(elevator_init);
 
-void elevator_exit(struct elevator_queue *e)
+void elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	mutex_lock(&e->sysfs_lock);
 	if (e->uses_mq && e->type->ops.mq.exit_sched)
-		e->type->ops.mq.exit_sched(e);
+		blk_mq_exit_sched(q, e);
 	else if (!e->uses_mq && e->type->ops.sq.elevator_exit_fn)
 		e->type->ops.sq.elevator_exit_fn(e);
 	mutex_unlock(&e->sysfs_lock);
@@ -941,6 +941,45 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
 
+static int elevator_switch_mq(struct request_queue *q,
+			      struct elevator_type *new_e)
+{
+	int ret;
+
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
+	if (q->elevator) {
+		if (q->elevator->registered)
+			elv_unregister_queue(q);
+		ioc_clear_queue(q);
+		elevator_exit(q, q->elevator);
+	}
+
+	ret = blk_mq_init_sched(q, new_e);
+	if (ret)
+		goto out;
+
+	if (new_e) {
+		ret = elv_register_queue(q);
+		if (ret) {
+			elevator_exit(q, q->elevator);
+			goto out;
+		}
+	}
+
+	if (new_e)
+		blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	else
+		blk_add_trace_msg(q, "elv switch: none");
+
+out:
+	blk_mq_unfreeze_queue(q);
+	blk_mq_start_stopped_hw_queues(q, true);
+	return ret;
+
+}
+
 /*
  * switch to new_e io scheduler. be careful not to introduce deadlocks -
  * we don't free the old io scheduler, before we have allocated what we
@@ -953,10 +992,8 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	bool old_registered = false;
 	int err;
 
-	if (q->mq_ops) {
-		blk_mq_freeze_queue(q);
-		blk_mq_quiesce_queue(q);
-	}
+	if (q->mq_ops)
+		return elevator_switch_mq(q, new_e);
 
 	/*
 	 * Turn on BYPASS and drain all requests w/ elevator private data.
@@ -968,11 +1005,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	if (old) {
 		old_registered = old->registered;
 
-		if (old->uses_mq)
-			blk_mq_sched_teardown(q);
-
-		if (!q->mq_ops)
-			blk_queue_bypass_start(q);
+		blk_queue_bypass_start(q);
 
 		/* unregister and clear all auxiliary data of the old elevator */
 		if (old_registered)
@@ -982,53 +1015,32 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	}
 
 	/* allocate, init and register new elevator */
-	if (q->mq_ops)
-		err = blk_mq_init_sched(q, new_e);
-	else
-		err = new_e->ops.sq.elevator_init_fn(q, new_e);
+	err = new_e->ops.sq.elevator_init_fn(q, new_e);
 	if (err)
 		goto fail_init;
 
-	if (new_e) {
-		err = elv_register_queue(q);
-		if (err)
-			goto fail_register;
-	}
+	err = elv_register_queue(q);
+	if (err)
+		goto fail_register;
 
 	/* done, kill the old one and finish */
 	if (old) {
-		elevator_exit(old);
-		if (!q->mq_ops)
-			blk_queue_bypass_end(q);
+		elevator_exit(q, old);
+		blk_queue_bypass_end(q);
 	}
 
-	if (q->mq_ops) {
-		blk_mq_unfreeze_queue(q);
-		blk_mq_start_stopped_hw_queues(q, true);
-	}
-
-	if (new_e)
-		blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
-	else
-		blk_add_trace_msg(q, "elv switch: none");
+	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
 
 	return 0;
 
 fail_register:
-	if (q->mq_ops)
-		blk_mq_sched_teardown(q);
-	elevator_exit(q->elevator);
+	elevator_exit(q, q->elevator);
 fail_init:
 	/* switch failed, restore and re-register old elevator */
 	if (old) {
 		q->elevator = old;
 		elv_register_queue(q);
-		if (!q->mq_ops)
-			blk_queue_bypass_end(q);
-	}
-	if (q->mq_ops) {
-		blk_mq_unfreeze_queue(q);
-		blk_mq_start_stopped_hw_queues(q, true);
+		blk_queue_bypass_end(q);
 	}
 
 	return err;
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index aebecc4ed088..22d39e8d4de1 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -211,7 +211,7 @@ extern ssize_t elv_iosched_show(struct request_queue *, char *);
 extern ssize_t elv_iosched_store(struct request_queue *, const char *, size_t);
 
 extern int elevator_init(struct request_queue *, char *);
-extern void elevator_exit(struct elevator_queue *);
+extern void elevator_exit(struct request_queue *, struct elevator_queue *);
 extern int elevator_change(struct request_queue *, const char *);
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
 extern struct elevator_queue *elevator_alloc(struct request_queue *,
-- 
2.12.2
