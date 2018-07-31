Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] blk-mq: clean up the hctx restart
Date: Tue, 31 Jul 2018 12:02:15 +0800
Message-Id: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Currently, we will always set SCHED_RESTART whenever there are
requests in hctx->dispatch, then when request is completed and
freed the hctx queues will be restarted to avoid IO hang. This
is unnecessary most of time. Especially when there are lots of
LUNs attached to one host, the RR restart loop could be very
expensive.

Requests will be queued on hctx dispath list due to:
 - flush and cpu hotplug cases
 - no driver tag w/ io scheduler
 - LLDD returns BLK_STS_RESOURCE/BLK_STS_DEV_RESOURCE
 - no driver budget
We needn't care about the 1st case, it is normal insert.
Regarding the 2nd case, if tags are shared, the sbitmap_queue
wakeup hook will work and hctx_may_queue will avoid starvation of
other ones, otherwise, hctx restart is employed, but it is done
by blk_mq_mark_tag_wait. We need hctx restart for the 3rd and 4th
case to rerun the hctx queue when some LLDD limits are lifted due
to in-flight requests are completed.

So we remove the blk_mq_sched_mark_restart_hctx from
blk_mq_sched_dispatch_requests and only use it when LLDD returns
BLK_STS_DEV_RESOURCE and no driver budget. In addition, there some
race conditions fixed in this patch. More details please refer to
comment of blk_mq_dispatch_rq_list.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Roman Pen <roman.penyaev@profitbricks.com>
---
 block/blk-mq-sched.c |  7 ++---
 block/blk-mq-sched.h |  1 +
 block/blk-mq.c       | 82 +++++++++++++++++++++++++++++++---------------------
 3 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 56c493c..3270ad0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -54,7 +54,7 @@ void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio)
  * Mark a hardware queue as needing a restart. For shared queues, maintain
  * a count of how many hardware queues are marked for restart.
  */
-static void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
+void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
 		return;
@@ -202,15 +202,13 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * we only ever dispatch a fraction of the requests available because
 	 * of low device queue depth. Once we pull requests out of the IO
 	 * scheduler, we can no longer merge or sort them. So it's best to
-	 * leave them there for as long as we can. Mark the hw queue as
-	 * needing a restart in that case.
+	 * leave them there for as long as we can.
 	 *
 	 * We want to dispatch from the scheduler if there was nothing
 	 * on the dispatch list or we were able to dispatch from the
 	 * dispatch list.
 	 */
 	if (!list_empty(&rq_list)) {
-		blk_mq_sched_mark_restart_hctx(hctx);
 		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
 			if (has_sched_dispatch)
 				blk_mq_do_dispatch_sched(hctx);
@@ -417,7 +415,6 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *const hctx)
 		 */
 		if (!atomic_read(&queue->shared_hctx_restart))
 			return;
-
 		rcu_read_lock();
 		list_for_each_entry_rcu_rr(q, queue, &set->tag_list,
 					   tag_set_list) {
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0cb8f93..650cbfc 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -32,6 +32,7 @@ int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 			   unsigned int hctx_idx);
 void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 			    unsigned int hctx_idx);
+void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 45df734..b47627a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1086,6 +1086,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	bool marked = false;
 
 	if (list_empty(list))
 		return false;
@@ -1096,6 +1097,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	 * Now process all the entries, sending them to the driver.
 	 */
 	errors = queued = 0;
+retry:
 	do {
 		struct blk_mq_queue_data bd;
 
@@ -1115,12 +1117,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			 */
 			if (!blk_mq_mark_tag_wait(&hctx, rq)) {
 				blk_mq_put_dispatch_budget(hctx);
-				/*
-				 * For non-shared tags, the RESTART check
-				 * will suffice.
-				 */
-				if (hctx->flags & BLK_MQ_F_TAG_SHARED)
-					no_tag = true;
+				no_tag = true;
 				break;
 			}
 		}
@@ -1172,42 +1169,61 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	 * that is where we will continue on next queue run.
 	 */
 	if (!list_empty(list)) {
-		bool needs_restart;
+		bool run_queue = false;
+
+		if (!no_tag && (ret != BLK_STS_RESOURCE) && !marked) {
+			blk_mq_sched_mark_restart_hctx(hctx);
+			marked = true;
+			/*
+			 * .queue_rq will put the budget, so we need to get it again.
+			 */
+			got_budget = false;
+			goto retry;
+		}
 
 		spin_lock(&hctx->lock);
 		list_splice_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
 
 		/*
-		 * If SCHED_RESTART was set by the caller of this function and
-		 * it is no longer set that means that it was cleared by another
-		 * thread and hence that a queue rerun is needed.
+		 * The reason for why we reach here could be:
+		 *  - No driver tag
+		 *    For the shared-tags case, the tag wakeup hook will work
+		 *    and hctx_may_queue will avoid starvation of other ones.
+		 *    For the non-shared-tags case, hctx restart is employed.
 		 *
-		 * If 'no_tag' is set, that means that we failed getting
-		 * a driver tag with an I/O scheduler attached. If our dispatch
-		 * waitqueue is no longer active, ensure that we run the queue
-		 * AFTER adding our entries back to the list.
+		 *    Because reqs have not been queued to hctx->dispatch list
+		 *    when blk_mq_mark_tag_wait, both of two conditions will be
+		 *    triggered w/ an empty hctx->dispatch and do nothing finally.
+		 *    So recheck them here and rerun the queue if needed.
 		 *
-		 * If no I/O scheduler has been configured it is possible that
-		 * the hardware queue got stopped and restarted before requests
-		 * were pushed back onto the dispatch list. Rerun the queue to
-		 * avoid starvation. Notes:
-		 * - blk_mq_run_hw_queue() checks whether or not a queue has
-		 *   been stopped before rerunning a queue.
-		 * - Some but not all block drivers stop a queue before
-		 *   returning BLK_STS_RESOURCE. Two exceptions are scsi-mq
-		 *   and dm-rq.
-		 *
-		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
-		 * bit is set, run queue after a delay to avoid IO stalls
-		 * that could otherwise occur if the queue is idle.
+		 *  - BLK_STS_DEV_RESOURCE/no budget
+		 *    Employ the hctx restart mechanism to restart the queue.
+		 *    The LLDD resources could be released:
+		 *     - before mark SCHED_RESTART. We retry to dispatch to fix
+		 *       this case.
+		 *     - after mark SCHED_RESTART before queue requests on
+		 *       hctx->dispatch. we recheck the SCHED_RESTART, if not there,
+		 *       rerun the hctx.
+		 *  - BLK_STS_RESOURCE
+		 *    Run queue after a delay to avoid IO stalls.
+		 *    More details please refer to comment of BLK_STS_DEV_RESOURCE.
 		 */
-		needs_restart = blk_mq_sched_needs_restart(hctx);
-		if (!needs_restart ||
-		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
-			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE))
-			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
+
+		if (no_tag) {
+			if (hctx->flags & BLK_MQ_F_TAG_SHARED)
+				run_queue = list_empty_careful(&hctx->dispatch_wait.entry);
+			else
+				run_queue = !blk_mq_sched_needs_restart(hctx);
+			if (run_queue)
+				blk_mq_run_hw_queue(hctx, true);
+		} else if (ret == BLK_STS_RESOURCE){
+			if (blk_mq_sched_needs_restart(hctx))
+				blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
+		} else {
+			if (!blk_mq_sched_needs_restart(hctx))
+				blk_mq_run_hw_queue(hctx, true);
+		}
 
 		return false;
 	}
-- 
2.7.4
