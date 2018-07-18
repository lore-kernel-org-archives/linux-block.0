Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Block <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCH] blk-mq: move timeout handling from queue to tagset
Date: Wed, 18 Jul 2018 11:00:18 -0600
Message-Id: <20180718170018.31395-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This patch removes the per-request_queue timeout handling and uses the
tagset instead. This simplifies the timeout handling since a shared tag
set can handle all timed out requests in a single work queue rather than
iterate the same set in different work for all the users of that set.

The long term objective of this is to aid blk-mq drivers with shared
tagsets. These drivers typically want their timeout error handling to be
single threaded, and this patch provides that context so they wouldn't
need to sync with other request queues requiring the same error handling.

Timeout handling per-queue was a bit racy with completions anyway:
a tag active for one request_queue while iterating could be freed
and reallocated to a different request_queue, so a queue's timeout
handler may be operating on a request allocated to a different queue.
Though no real harm was done with how the callbacks used those requests,
this patch fixes that race.

And since the timeout code takes a reference on requests, the request
can never exit the queue while timeout code is considering. We no
longer need to enter each request_queue in the timeout work so this
patch removes that unnecessary code.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-core.c       |  5 ++---
 block/blk-mq.c         | 45 ++++++++++++++++++++-------------------------
 block/blk-timeout.c    | 16 ++++++++++------
 include/linux/blk-mq.h |  2 ++
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f84a9b7b6f5a..9cf7ff6baba0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -404,9 +404,6 @@ EXPORT_SYMBOL(blk_stop_queue);
  */
 void blk_sync_queue(struct request_queue *q)
 {
-	del_timer_sync(&q->timeout);
-	cancel_work_sync(&q->timeout_work);
-
 	if (q->mq_ops) {
 		struct blk_mq_hw_ctx *hctx;
 		int i;
@@ -415,6 +412,8 @@ void blk_sync_queue(struct request_queue *q)
 		queue_for_each_hw_ctx(q, hctx, i)
 			cancel_delayed_work_sync(&hctx->run_work);
 	} else {
+		del_timer_sync(&q->timeout);
+		cancel_work_sync(&q->timeout_work);
 		cancel_delayed_work_sync(&q->delay_work);
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 95919268564b..22326612a5d3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -804,8 +804,7 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	return false;
 }
 
-static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, void *priv, bool reserved)
+static void blk_mq_check_expired(struct request *rq, void *priv, bool reserved)
 {
 	unsigned long *next = priv;
 
@@ -842,33 +841,21 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 
 static void blk_mq_timeout_work(struct work_struct *work)
 {
-	struct request_queue *q =
-		container_of(work, struct request_queue, timeout_work);
+	struct blk_mq_tag_set *set =
+		container_of(work, struct blk_mq_tag_set, timeout_work);
+	struct request_queue *q;
 	unsigned long next = 0;
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	/* A deadlock might occur if a request is stuck requiring a
-	 * timeout at the same time a queue freeze is waiting
-	 * completion, since the timeout code would not be able to
-	 * acquire the queue reference here.
-	 *
-	 * That's why we don't use blk_queue_enter here; instead, we use
-	 * percpu_ref_tryget directly, because we need to be able to
-	 * obtain a reference even in the short window between the queue
-	 * starting to freeze, by dropping the first reference in
-	 * blk_freeze_queue_start, and the moment the last request is
-	 * consumed, marked by the instant q_usage_counter reaches
-	 * zero.
-	 */
-	if (!percpu_ref_tryget(&q->q_usage_counter))
-		return;
-
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	blk_mq_tagset_busy_iter(set, blk_mq_check_expired, &next);
 
 	if (next != 0) {
-		mod_timer(&q->timeout, next);
-	} else {
+		mod_timer(&set->timer, next);
+		return;
+	}
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If
 		 * we end up here it means that no requests are pending and
@@ -881,7 +868,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
 				blk_mq_tag_idle(hctx);
 		}
 	}
-	blk_queue_exit(q);
 }
 
 struct flush_busy_ctx_data {
@@ -2548,7 +2534,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
-	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
 	q->nr_queues = nr_cpu_ids;
@@ -2710,6 +2695,13 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		return blk_mq_map_queues(set);
 }
 
+static void blk_mq_timed_out_timer(struct timer_list *t)
+{
+	struct blk_mq_tag_set *set = from_timer(set, t, timer);
+
+	kblockd_schedule_work(&set->timeout_work);
+}
+
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
@@ -2778,6 +2770,9 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
 
+	timer_setup(&set->timer, blk_mq_timed_out_timer, 0);
+	INIT_WORK(&set->timeout_work, blk_mq_timeout_work);
+
 	return 0;
 
 out_free_mq_map:
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index f2cfd56e1606..fe26aa5305c9 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -193,9 +193,13 @@ void blk_add_timer(struct request *req)
 {
 	struct request_queue *q = req->q;
 	unsigned long expiry;
+	struct timer_list *timer;
 
-	if (!q->mq_ops)
+	if (!q->mq_ops) {
 		lockdep_assert_held(q->queue_lock);
+		timer = &q->timeout;
+	} else
+		timer = &q->tag_set->timer;
 
 	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
 	if (!q->mq_ops && !q->rq_timed_out_fn)
@@ -227,9 +231,9 @@ void blk_add_timer(struct request *req)
 	 */
 	expiry = blk_rq_timeout(round_jiffies_up(blk_rq_deadline(req)));
 
-	if (!timer_pending(&q->timeout) ||
-	    time_before(expiry, q->timeout.expires)) {
-		unsigned long diff = q->timeout.expires - expiry;
+	if (!timer_pending(timer) ||
+	    time_before(expiry, timer->expires)) {
+		unsigned long diff = timer->expires - expiry;
 
 		/*
 		 * Due to added timer slack to group timers, the timer
@@ -238,8 +242,8 @@ void blk_add_timer(struct request *req)
 		 * modifying the timer because expires for value X
 		 * will be X + something.
 		 */
-		if (!timer_pending(&q->timeout) || (diff >= HZ / 2))
-			mod_timer(&q->timeout, expiry);
+		if (!timer_pending(timer) || (diff >= HZ / 2))
+			mod_timer(timer, expiry);
 	}
 
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb74222..9b0fd11ce89a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -86,6 +86,8 @@ struct blk_mq_tag_set {
 
 	struct blk_mq_tags	**tags;
 
+	struct timer_list	timer;
+	struct work_struct	timeout_work;
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
 };
-- 
2.14.4
