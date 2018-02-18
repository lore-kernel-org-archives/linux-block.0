Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 18 Feb 2018 05:11:44 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180218131144.GX695913@devbig577.frc2.facebook.com>
References: <1518024428.2870.35.camel@wdc.com>
 <20180207173531.GC695913@devbig577.frc2.facebook.com>
 <1518027251.2870.53.camel@wdc.com>
 <20180207200724.GD695913@devbig577.frc2.facebook.com>
 <1518047297.2870.80.camel@wdc.com>
 <1518052193.2870.90.camel@wdc.com>
 <20180208153940.GM695913@devbig577.frc2.facebook.com>
 <1518107501.3611.19.camel@wdc.com>
 <20180213212044.GS695913@devbig577.frc2.facebook.com>
 <1518627534.3147.6.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518627534.3147.6.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Wed, Feb 14, 2018 at 04:58:56PM +0000, Bart Van Assche wrote:
> With this patch applied the tests I ran so far pass.

Ah, great to hear.  Thanks a lot for testing.  Can you please verify
the following?  It's the same approach but with RCU sync batching.

Thanks.

Index: work/block/blk-mq.c
===================================================================
--- work.orig/block/blk-mq.c
+++ work/block/blk-mq.c
@@ -816,7 +816,8 @@ struct blk_mq_timeout_data {
 	unsigned int nr_expired;
 };
 
-static void blk_mq_rq_timed_out(struct request *req, bool reserved)
+static void blk_mq_rq_timed_out(struct blk_mq_hw_ctx *hctx, struct request *req,
+				int *nr_resets, bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
@@ -831,13 +832,10 @@ static void blk_mq_rq_timed_out(struct r
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
@@ -874,13 +872,34 @@ static void blk_mq_check_expired(struct
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
@@ -893,7 +912,25 @@ static void blk_mq_terminate_expired(str
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
+	 * there's no memory barrier around ->aborted_gstate.  Let
+	 * blk_add_timer() clear it later.
+	 *
+	 * As nothing prevents from completion happening while
+	 * ->aborted_gstate is set, this may lead to ignored completions
+	 * and further spurious timeouts.
+	 */
+	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
+		blk_mq_rq_update_aborted_gstate(rq, 0);
 }
 
 static void blk_mq_timeout_work(struct work_struct *work)
@@ -928,7 +965,7 @@ static void blk_mq_timeout_work(struct w
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
 	if (data.nr_expired) {
-		bool has_rcu = false;
+		int nr_resets = 0;
 
 		/*
 		 * Wait till everyone sees ->aborted_gstate.  The
@@ -936,22 +973,22 @@ static void blk_mq_timeout_work(struct w
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
Index: work/include/linux/blk-mq.h
===================================================================
--- work.orig/include/linux/blk-mq.h
+++ work/include/linux/blk-mq.h
@@ -51,7 +51,7 @@ struct blk_mq_hw_ctx {
 	unsigned int		queue_num;
 
 	atomic_t		nr_active;
-	unsigned int		nr_expired;
+	bool			need_sync_rcu;
 
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
Index: work/block/blk-timeout.c
===================================================================
--- work.orig/block/blk-timeout.c
+++ work/block/blk-timeout.c
@@ -216,7 +216,7 @@ void blk_add_timer(struct request *req)
 		req->timeout = q->rq_timeout;
 
 	blk_rq_set_deadline(req, jiffies + req->timeout);
-	req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
+	req->rq_flags &= ~(RQF_MQ_TIMEOUT_EXPIRED | RQF_MQ_TIMEOUT_RESET);
 
 	/*
 	 * Only the non-mq case needs to add the request to a protected list.
Index: work/include/linux/blkdev.h
===================================================================
--- work.orig/include/linux/blkdev.h
+++ work/include/linux/blkdev.h
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
