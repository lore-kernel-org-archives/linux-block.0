Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 2 Apr 2018 12:01:20 -0700
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] blk-mq: Fix request handover from timeout path to normal
 execution
Message-ID: <20180402190120.GD388343@devbig577.frc2.facebook.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180402190053.GC388343@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

When a request is handed over from normal execution to timeout, we
synchronize using ->aborted_gstate and RCU grace periods; however,
when a request is being returned from timeout handling to normal
execution for BLK_EH_RESET_TIMER, we were skipping the same
synchronization.

This means that it theoretically is possible for a returned request's
completion and recycling compete against the reordered and delayed
writes from timeout path.

This patch adds an equivalent synchronization when a request is
returned from timeout path to normal completion path.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>
---
 block/blk-mq.c         |   49 ++++++++++++++++++++++++++++++++++++++++---------
 block/blk-timeout.c    |    2 +-
 include/linux/blkdev.h |    4 +++-
 3 files changed, 44 insertions(+), 11 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -818,7 +818,8 @@ struct blk_mq_timeout_data {
 	unsigned int nr_expired;
 };
 
-static void blk_mq_rq_timed_out(struct request *req, bool reserved)
+static void blk_mq_rq_timed_out(struct blk_mq_hw_ctx *hctx, struct request *req,
+				int *nr_resets, bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
@@ -833,13 +834,10 @@ static void blk_mq_rq_timed_out(struct r
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
-		/*
-		 * As nothing prevents from completion happening while
-		 * ->aborted_gstate is set, this may lead to ignored
-		 * completions and further spurious timeouts.
-		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
 		blk_add_timer(req);
+		req->rq_flags |= RQF_MQ_TIMEOUT_RESET;
+		(*nr_resets)++;
+		hctx->need_sync_rcu = true;
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
@@ -916,7 +914,26 @@ static void blk_mq_terminate_expired(str
 	 */
 	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
 	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
-		blk_mq_rq_timed_out(rq, reserved);
+		blk_mq_rq_timed_out(hctx, rq, priv, reserved);
+}
+
+static void blk_mq_finish_timeout_reset(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	/*
+	 * @rq's timer reset has gone through rcu synchronization and is
+	 * visible now.  Allow normal completions again by resetting
+	 * ->aborted_gstate.  Don't clear RQF_MQ_TIMEOUT_RESET here as
+	 * there's no memory ordering around ->aborted_gstate making it the
+	 * only field safe to update.  Let blk_add_timer() clear it later
+	 * when the request is recycled or times out again.
+	 *
+	 * As nothing prevents from completion happening while
+	 * ->aborted_gstate is set, this may lead to ignored completions
+	 * and further spurious timeouts.
+	 */
+	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
+		blk_mq_rq_update_aborted_gstate(rq, 0);
 }
 
 static void blk_mq_timeout_work(struct work_struct *work)
@@ -951,6 +968,8 @@ static void blk_mq_timeout_work(struct w
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
 	if (data.nr_expired) {
+		int nr_resets = 0;
+
 		/*
 		 * Wait till everyone sees ->aborted_gstate.  The
 		 * sequential waits for SRCUs aren't ideal.  If this ever
@@ -960,7 +979,19 @@ static void blk_mq_timeout_work(struct w
 		blk_mq_timeout_sync_rcu(q);
 
 		/* terminate the ones we won */
-		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired, NULL);
+		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired,
+					   &nr_resets);
+
+		/*
+		 * For BLK_EH_RESET_TIMER, release the requests after
+		 * blk_add_timer() from above is visible to avoid timer
+		 * reset racing against recycling.
+		 */
+		if (nr_resets) {
+			blk_mq_timeout_sync_rcu(q);
+			blk_mq_queue_tag_busy_iter(q,
+					blk_mq_finish_timeout_reset, NULL);
+		}
 	}
 
 	if (data.next_set) {
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -216,7 +216,7 @@ void blk_add_timer(struct request *req)
 		req->timeout = q->rq_timeout;
 
 	blk_rq_set_deadline(req, jiffies + req->timeout);
-	req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
+	req->rq_flags &= ~(RQF_MQ_TIMEOUT_EXPIRED | RQF_MQ_TIMEOUT_RESET);
 
 	/*
 	 * Only the non-mq case needs to add the request to a protected list.
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -127,8 +127,10 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
 /* timeout is expired */
 #define RQF_MQ_TIMEOUT_EXPIRED	((__force req_flags_t)(1 << 20))
+/* timeout is expired */
+#define RQF_MQ_TIMEOUT_RESET	((__force req_flags_t)(1 << 21))
 /* already slept for hybrid poll */
-#define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 21))
+#define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 22))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
