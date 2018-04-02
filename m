Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 2 Apr 2018 12:00:53 -0700
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] blk-mq: Factor out [s]rcu synchronization
Message-ID: <20180402190053.GC388343@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Factor out [s]rcu synchronization in blk_mq_timeout_work() into
blk_mq_timeout_sync_rcu().  This is to add another user in the future
and doesn't cause any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>
---
Hello,

We were tracking this down in the following thread

  http://lkml.kernel.org/r/20180207011133.25957-1-bart.vanassche@wdc.com

but lost the reproducer in the middle and couldn't fully verify these
two patches fix the problem; however, the identified race is real and
a bug, so I think it'd be best to apply these two patches.

Given the lack of further reports on this front, I don't think it's
necessary to rush these patches.  I think it'd be best to apply these
once the merge window closes.  If we need to backport these to
-stable, we can tag them later.

Thanks.

 block/blk-mq.c         |   39 +++++++++++++++++++++++----------------
 include/linux/blk-mq.h |    2 +-
 2 files changed, 24 insertions(+), 17 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -876,13 +876,34 @@ static void blk_mq_check_expired(struct
 	    time_after_eq(jiffies, deadline)) {
 		blk_mq_rq_update_aborted_gstate(rq, gstate);
 		data->nr_expired++;
-		hctx->nr_expired++;
+		hctx->need_sync_rcu = true;
 	} else if (!data->next_set || time_after(data->next, deadline)) {
 		data->next = deadline;
 		data->next_set = 1;
 	}
 }
 
+static void blk_mq_timeout_sync_rcu(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	bool has_rcu = false;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (!hctx->need_sync_rcu)
+			continue;
+
+		if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+			has_rcu = true;
+		else
+			synchronize_srcu(hctx->srcu);
+
+		hctx->need_sync_rcu = false;
+	}
+	if (has_rcu)
+		synchronize_rcu();
+}
+
 static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
@@ -930,27 +951,13 @@ static void blk_mq_timeout_work(struct w
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
 	if (data.nr_expired) {
-		bool has_rcu = false;
-
 		/*
 		 * Wait till everyone sees ->aborted_gstate.  The
 		 * sequential waits for SRCUs aren't ideal.  If this ever
 		 * becomes a problem, we can add per-hw_ctx rcu_head and
 		 * wait in parallel.
 		 */
-		queue_for_each_hw_ctx(q, hctx, i) {
-			if (!hctx->nr_expired)
-				continue;
-
-			if (!(hctx->flags & BLK_MQ_F_BLOCKING))
-				has_rcu = true;
-			else
-				synchronize_srcu(hctx->srcu);
-
-			hctx->nr_expired = 0;
-		}
-		if (has_rcu)
-			synchronize_rcu();
+		blk_mq_timeout_sync_rcu(q);
 
 		/* terminate the ones we won */
 		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired, NULL);
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -51,7 +51,7 @@ struct blk_mq_hw_ctx {
 	unsigned int		queue_num;
 
 	atomic_t		nr_active;
-	unsigned int		nr_expired;
+	bool			need_sync_rcu;
 
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
