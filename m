Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V3 3/3] blk-mq: dequeue request one by one from sw queue iff hctx is busy
Date: Mon,  2 Jul 2018 17:36:00 +0800
Message-Id: <20180702093600.10315-4-ming.lei@redhat.com>
In-Reply-To: <20180702093600.10315-1-ming.lei@redhat.com>
References: <20180702093600.10315-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

It won't be efficient to dequeue request one by one from sw queue,
but we have to do that when queue is busy for better merge performance.

This patch takes EWMA to figure out if queue is busy, then only dequeue
request one by one from sw queue when queue is busy.

Fixes: b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |  9 +++++++++
 block/blk-mq-sched.c   | 11 ++---------
 block/blk-mq.c         | 30 +++++++++++++++++++++++++++++-
 include/linux/blk-mq.h |  3 ++-
 4 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1c4532e92938..dd87c274a6b8 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -637,6 +637,14 @@ static int hctx_active_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+
+	seq_printf(m, "%u\n", hctx->dispatch_busy);
+	return 0;
+}
+
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
 	__acquires(&ctx->lock)
 {
@@ -798,6 +806,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"queued", 0600, hctx_queued_show, hctx_queued_write},
 	{"run", 0600, hctx_run_show, hctx_run_write},
 	{"active", 0400, hctx_active_show},
+	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
 	{},
 };
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index f5745acc2d98..7856dc5db0eb 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -219,15 +219,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		}
 	} else if (has_sched_dispatch) {
 		blk_mq_do_dispatch_sched(hctx);
-	} else if (q->mq_ops->get_budget) {
-		/*
-		 * If we need to get budget before queuing request, we
-		 * dequeue request one by one from sw queue for avoiding
-		 * to mess up I/O merge when dispatch runs out of resource.
-		 *
-		 * TODO: get more budgets, and dequeue more requests in
-		 * one time.
-		 */
+	} else if (READ_ONCE(hctx->dispatch_busy)) {
+		/* dequeue request one by one from sw queue if queue is busy */
 		blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 174637d09923..22db9c897f84 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1073,6 +1073,31 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	return true;
 }
 
+/*
+ * Update dispatch busy with EWMA:
+ * - EWMA is one simple way to compute running average value
+ * - weight(7/8 and 1/8) is applied so that it can decrease exponentially
+ * - take 16 as current busy value for avoiding to get too small(0) result,
+ *   and this factor doesn't matter given EWMA decreases exponentially
+ */
+static void blk_mq_update_hctx_busy(struct blk_mq_hw_ctx *hctx, bool busy)
+{
+	const unsigned weight = 8;
+	unsigned int ewma;
+
+	if (hctx->queue->elevator)
+		return;
+
+	ewma = READ_ONCE(hctx->dispatch_busy);
+
+	ewma *= weight - 1;
+	if (busy)
+		ewma += 16;
+	ewma /= weight;
+
+	WRITE_ONCE(hctx->dispatch_busy, ewma);
+}
+
 #define BLK_MQ_RESOURCE_DELAY	3		/* ms units */
 
 /*
@@ -1209,8 +1234,11 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		else if (needs_restart && (ret == BLK_STS_RESOURCE))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
+		blk_mq_update_hctx_busy(hctx, true);
+
 		return false;
-	}
+	} else
+		blk_mq_update_hctx_busy(hctx, false);
 
 	/*
 	 * If the host/device is unable to accept more work, inform the
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb74222..399e0a610ea3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -35,9 +35,10 @@ struct blk_mq_hw_ctx {
 	struct sbitmap		ctx_map;
 
 	struct blk_mq_ctx	*dispatch_from;
+	unsigned int		dispatch_busy;
 
-	struct blk_mq_ctx	**ctxs;
 	unsigned int		nr_ctx;
+	struct blk_mq_ctx	**ctxs;
 
 	wait_queue_entry_t	dispatch_wait;
 	atomic_t		wait_index;
-- 
2.9.5
