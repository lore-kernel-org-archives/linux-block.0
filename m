Return-Path: <roman.penyaev@profitbricks.com>
Return-Path: <roman.penyaev@profitbricks.com>
From: Roman Pen <roman.penyaev@profitbricks.com>
To: 
Cc: Roman Pen <roman.penyaev@profitbricks.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] blk-mq: fix hang caused by freeze/unfreeze sequence
Date: Mon,  8 Aug 2016 13:39:08 +0200
Message-Id: <20160808113908.5445-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

Long time ago there was a similar fix proposed by Akinobu Mita[1],
but it seems that time everyone decided to fix this subtle race in
percpu-refcount and Tejun Heo[2] did an attempt (as I can see that
patchset was not applied).

The following is a description of a hang in blk_mq_freeze_queue_wait() -
same fix but a bug from another angle.

The hang happens on attempt to freeze a queue while another task does
queue unfreeze.

The root cause is an incorrect sequence of percpu_ref_reinit() and
percpu_ref_kill() and as a result those two can be swapped:

 CPU#0               CPU#1
 ----------------    -----------------
 percpu_ref_kill()

                     percpu_ref_kill() << atomic reference does
 percpu_ref_reinit()                   << not guarantee the order

                     blk_mq_freeze_queue_wait() << HANG HERE

                     percpu_ref_reinit()

Firstly this wrong sequence raises two kernel warnings:

  1st. WARNING at lib/percpu-recount.c:309
       percpu_ref_kill_and_confirm called more than once

  2nd. WARNING at lib/percpu-refcount.c:331

But the most unpleasant effect is a hang of a blk_mq_freeze_queue_wait(),
which waits for a zero of a q_usage_counter, which never happens
because percpu-ref was reinited (instead of being killed) and stays in
PERCPU state forever.

The simplified sequence above can be reproduced on shared tags, when
queue A is going to die meanwhile another queue B is in init state and
is trying to freeze the queue A, which shares the same tags set:

 CPU#0                           CPU#1
 ------------------------------- ------------------------------------
 q1 = blk_mq_init_queue(shared_tags)

                                q2 = blk_mq_init_queue(shared_tags):
                                  blk_mq_add_queue_tag_set(shared_tags):
                                    blk_mq_update_tag_set_depth(shared_tags):
                                      blk_mq_freeze_queue(q1)
 blk_cleanup_queue(q1)                 ...
   blk_mq_freeze_queue(q1)   <<<->>>   blk_mq_unfreeze_queue(q1)

[1] Message id: 1443287365-4244-7-git-send-email-akinobu.mita@gmail.com
[2] Message id: 1443563240-29306-6-git-send-email-tj@kernel.org

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 v2:
   - forgotten hunk from local repo
   - minor tweaks in the commit message

 block/blk-core.c       |  3 ++-
 block/blk-mq.c         | 22 +++++++++++-----------
 include/linux/blkdev.h |  7 ++++++-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ef78848..4fd27e9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -658,7 +658,7 @@ int blk_queue_enter(struct request_queue *q, gfp_t gfp)
 			return -EBUSY;
 
 		ret = wait_event_interruptible(q->mq_freeze_wq,
-				!atomic_read(&q->mq_freeze_depth) ||
+				!q->mq_freeze_depth ||
 				blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
@@ -740,6 +740,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
+	mutex_init(&q->mq_freeze_lock);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6d6f8fe..1f3e81b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -80,13 +80,13 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 
 void blk_mq_freeze_queue_start(struct request_queue *q)
 {
-	int freeze_depth;
-
-	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
-	if (freeze_depth == 1) {
+	mutex_lock(&q->mq_freeze_lock);
+	if (++q->mq_freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
+		mutex_unlock(&q->mq_freeze_lock);
 		blk_mq_run_hw_queues(q, false);
-	}
+	} else
+		mutex_unlock(&q->mq_freeze_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_start);
 
@@ -124,14 +124,14 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
-	int freeze_depth;
-
-	freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
-	WARN_ON_ONCE(freeze_depth < 0);
-	if (!freeze_depth) {
+	mutex_lock(&q->mq_freeze_lock);
+	q->mq_freeze_depth--;
+	WARN_ON_ONCE(q->mq_freeze_depth < 0);
+	if (!q->mq_freeze_depth) {
 		percpu_ref_reinit(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
+	mutex_unlock(&q->mq_freeze_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
@@ -2105,7 +2105,7 @@ void blk_mq_free_queue(struct request_queue *q)
 static void blk_mq_queue_reinit(struct request_queue *q,
 				const struct cpumask *online_mask)
 {
-	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
+	WARN_ON_ONCE(!q->mq_freeze_depth);
 
 	blk_mq_sysfs_unregister(q);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f6ff9d1..d692c16 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -445,7 +445,7 @@ struct request_queue {
 	struct mutex		sysfs_lock;
 
 	int			bypass_depth;
-	atomic_t		mq_freeze_depth;
+	int			mq_freeze_depth;
 
 #if defined(CONFIG_BLK_DEV_BSG)
 	bsg_job_fn		*bsg_job_fn;
@@ -459,6 +459,11 @@ struct request_queue {
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
+	/*
+	 * Protect concurrent access to q_usage_counter by
+	 * percpu_ref_kill() and percpu_ref_reinit().
+	 */
+	struct mutex		mq_freeze_lock;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
-- 
2.9.0
