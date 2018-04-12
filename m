Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Apr 2018 06:35:29 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Israel Rukshin <israelr@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180412133529.GU793541@devbig577.frc2.facebook.com>
References: <20180410153812.GA3219@ming.t460p>
 <20180410154043.GP3126663@devbig577.frc2.facebook.com>
 <20180410213323.GC793541@devbig577.frc2.facebook.com>
 <d88becef654cde4b5382c1ebddb0aeba963c0578.camel@wdc.com>
 <20180410215456.GD793541@devbig577.frc2.facebook.com>
 <7a586854-33a5-fe3b-6d94-24d305696126@grimberg.me>
 <0da96ded-7bfc-e6a8-428c-1ce1e3db0378@mellanox.com>
 <20180411170733.GM793541@devbig577.frc2.facebook.com>
 <20180411213146.GS793541@devbig577.frc2.facebook.com>
 <0644e6d5-d6a9-420b-b465-4f6ce4466ca5@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0644e6d5-d6a9-420b-b465-4f6ce4466ca5@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Israel.

On Thu, Apr 12, 2018 at 11:59:11AM +0300, Israel Rukshin wrote:
> On 4/12/2018 12:31 AM, tj@kernel.org wrote:
> >Hey, again.
> >
> >On Wed, Apr 11, 2018 at 10:07:33AM -0700, tj@kernel.org wrote:
> >>Hello, Israel.
> >>
> >>On Wed, Apr 11, 2018 at 07:16:14PM +0300, Israel Rukshin wrote:
> >>>>Just noticed this one, this looks interesting to me as well. Israel,
> >>>>can you run your test with this patch?
> >>>Yes, I just did and it looks good.
> >>Awesome.
> >Just to be sure, you tested the combined patch and saw the XXX debug
> >messages, right?
> 
> I am not sure I understand.
> What is the combined patch?
> What are the debug messages that I need to see?

There are total of three patches and I posted the combined patch + a
debug message in another post.  Can you please test the following
patch?  It'll print out something like the following (possibly many of
them).

 XXX blk_mq_timeout_reset_cleanup(): executed %d missed completions

Thanks.

Index: work/block/blk-mq.c
===================================================================
--- work.orig/block/blk-mq.c
+++ work/block/blk-mq.c
@@ -642,6 +642,8 @@ void blk_mq_complete_request(struct requ
 	hctx_lock(hctx, &srcu_idx);
 	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
 		__blk_mq_complete_request(rq);
+	else
+		rq->missed_completion = true;
 	hctx_unlock(hctx, srcu_idx);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
@@ -684,6 +686,7 @@ void blk_mq_start_request(struct request
 
 	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
 	blk_add_timer(rq);
+	rq->missed_completion = false;
 
 	write_seqcount_end(&rq->gstate_seq);
 	preempt_enable();
@@ -818,7 +821,8 @@ struct blk_mq_timeout_data {
 	unsigned int nr_expired;
 };
 
-static void blk_mq_rq_timed_out(struct request *req, bool reserved)
+static void blk_mq_rq_timed_out(struct blk_mq_hw_ctx *hctx, struct request *req,
+				int *nr_resets, bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
@@ -833,13 +837,10 @@ static void blk_mq_rq_timed_out(struct r
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
@@ -876,13 +877,35 @@ static void blk_mq_check_expired(struct
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
 
+static void blk_mq_timeout_sync_rcu(struct request_queue *q, bool clear)
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
+		if (clear)
+			hctx->need_sync_rcu = false;
+	}
+	if (has_rcu)
+		synchronize_rcu();
+}
+
 static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
@@ -895,7 +918,45 @@ static void blk_mq_terminate_expired(str
 	 */
 	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
 	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
-		blk_mq_rq_timed_out(rq, reserved);
+		blk_mq_rq_timed_out(hctx, rq, priv, reserved);
+}
+
+static void blk_mq_timeout_reset_return(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	/*
+	 * @rq's timer reset has gone through rcu synchronization and is
+	 * visible now.  Allow normal completions again by resetting
+	 * ->aborted_gstate.  Don't clear RQF_MQ_TIMEOUT_RESET here as
+	 * blk_mq_timeout_reset_cleanup() needs it again and there's no
+	 * memory ordering around ->aborted_gstate making it the only field
+	 * safe to update.  Let blk_add_timer() clear it later when the
+	 * request is recycled or times out again.
+	 */
+	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
+		blk_mq_rq_update_aborted_gstate(rq, 0);
+}
+
+static void blk_mq_timeout_reset_cleanup(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	int cnt = 0;
+
+	/*
+	 * @rq is now fully returned to the normal path.  If normal
+	 * completion raced timeout handling, execute the missed completion
+	 * here.  This is safe because 1. ->missed_completion can no longer
+	 * be asserted because nothing is timing out right now and 2. if
+	 * ->missed_completion is set, @rq is safe from recycling because
+	 * nobody could have completed it.
+	 */
+	if ((rq->rq_flags & RQF_MQ_TIMEOUT_RESET) && rq->missed_completion) {
+		blk_mq_complete_request(rq);
+		cnt++;
+	}
+
+	printk("XXX blk_mq_timeout_reset_cleanup(): executed %d missed completions\n",
+	       cnt);
 }
 
 static void blk_mq_timeout_work(struct work_struct *work)
@@ -930,7 +991,7 @@ static void blk_mq_timeout_work(struct w
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
 	if (data.nr_expired) {
-		bool has_rcu = false;
+		int nr_resets = 0;
 
 		/*
 		 * Wait till everyone sees ->aborted_gstate.  The
@@ -938,22 +999,25 @@ static void blk_mq_timeout_work(struct w
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
+		blk_mq_timeout_sync_rcu(q, true);
 
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
+			blk_mq_timeout_sync_rcu(q, false);
+			blk_mq_queue_tag_busy_iter(q,
+					blk_mq_timeout_reset_return, NULL);
+			blk_mq_timeout_sync_rcu(q, true);
+			blk_mq_queue_tag_busy_iter(q,
+					blk_mq_timeout_reset_cleanup, NULL);
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
@@ -225,6 +227,8 @@ struct request {
 
 	unsigned int extra_len;	/* length of alignment and padding */
 
+	bool missed_completion;
+
 	/*
 	 * On blk-mq, the lower bits of ->gstate (generation number and
 	 * state) carry the MQ_RQ_* state value and the upper bits the
