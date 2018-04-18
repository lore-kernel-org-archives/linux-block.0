Return-Path: <ming.lei@redhat.com>
Date: Thu, 19 Apr 2018 00:46:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Bart Van Assche <bart.vanassche@wdc.com>,
	Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH V4 0/2] blk-mq: fix race between completion and
 BLK_EH_RESET_TIMER
Message-ID: <20180418164629.GB22533@ming.t460p>
References: <20180415154357.19788-1-ming.lei@redhat.com>
 <4563853.Bq5iVV2DL3@merkaba>
 <20180416004508.GA20345@ming.t460p>
 <4122070.FIbsgdqFrb@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4122070.FIbsgdqFrb@merkaba>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 16, 2018 at 03:12:30PM +0200, Martin Steigerwald wrote:
> Ming Lei - 16.04.18, 02:45:
> > On Sun, Apr 15, 2018 at 06:31:44PM +0200, Martin Steigerwald wrote:
> > > Hi Ming.
> > > 
> > > Ming Lei - 15.04.18, 17:43:
> > > > Hi Jens,
> > > > 
> > > > This two patches fixes the recently discussed race between
> > > > completion
> > > > and BLK_EH_RESET_TIMER.
> > > > 
> > > > Israel & Martin, this one is a simpler fix on this issue and can
> > > > cover the potencial hang of MQ_RQ_COMPLETE_IN_TIMEOUT request,
> > > > could
> > > > you test V4 and see if your issue can be fixed?
> > > 
> > > In replacement of all the three other patches I applied?
> > > 
> > > - '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a
> > > request.mbox'
> > > 
> > > - '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair
> > > into rcu_read_{lock,unlock}().mbox'
> > > 
> > > - '[PATCH v4] blk-mq_Fix race conditions in request timeout
> > > handling.mbox'
> > 
> > You only need to replace the above one '[PATCH v4] blk-mq_Fix race
> > conditions in request timeout' with V4 in this thread.
> 
> Ming, a 4.16.2 with the patches:
> 
> '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a 
> request.mbox'
> '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into 
> rcu_read_{lock,unlock}().mbox'
> '[PATCH V4 1_2] blk-mq_set RQF_MQ_TIMEOUT_EXPIRED when the rq'\''s 
> timeout isn'\''t handled.mbox'
> '[PATCH V4 2_2] blk-mq_fix race between complete and 
> BLK_EH_RESET_TIMER.mbox'
> 
> hung on boot 3 out of 4 times.
> 
> See
> 
> [Possible REGRESSION, 4.16-rc4] Error updating SMART data during runtime 
> and boot failures with blk_mq_terminate_expired in backtrace
> https://bugzilla.kernel.org/show_bug.cgi?id=199077#c13
> 
> I tried to add your mail address to Cc of the bug report, but Bugzilla 
> did not know it.
> 
> Fortunately it booted on the fourth attempt, cause I forgot my GRUB 
> password.
> 
> Reverting back to previous 4.16.1 kernel with patches from Bart.
> 
> > > These patches worked reliably so far both for the hang on boot and
> > > error reading SMART data.
> > 
> > And you may see the reason in the following thread:
> > 
> > https://marc.info/?l=linux-block&m=152366441625786&w=2
> 
> So requests could never be completed?

Yes.

I guess Jianchao's patch("[PATCH] blk-mq: start request gstate with gen 1")
may work for your issue because you are using blk_abort_request().

If it doesn't, please try the following V5 together the other two, and V5
fixes one big issue, in which the new rq state shouldn't be introduced,
otherwise timeout is broken easily.

I have tested V5 by running blktests(block/011), in which both these
code paths are covered: EH_HANDLED, EH_RESET_TIMER, and normal
completion during timeout, and the patch V5 works as expected.

--

>From e81da316a953db999d155d08143fd5722b44e79e Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 12 Apr 2018 04:23:09 +0800
Subject: [PATCH] blk-mq: fix race between complete and BLK_EH_RESET_TIMER

The normal request completion can be done before or during handling
BLK_EH_RESET_TIMER, and this race may cause the request to never
be completed since driver's .timeout() may always return
BLK_EH_RESET_TIMER.

This issue can't be fixed completely by driver, since the normal
completion can be done between returning .timeout() and handling
BLK_EH_RESET_TIMER.

This patch fixes the race by introducing rq state of MQ_RQ_COMPLETE_IN_RESET,
and reading/writing rq's state by holding queue lock, which can be
per-request actually, but just not necessary to introduce one lock for
so unusual event.

Also handle the timeout requests in two steps:

1) in 1st step, call .timeout(), and reset timer for BLK_EH_RESET_TIMER

2) in 2nd step, sync with normal completion path by holding queue lock
for avoiding race between BLK_EH_RESET_TIMER and normal completion.

Another change is that one request is always handled as time-out
exclusively in this patch with help of queue lock.

Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Israel Rukshin <israelr@mellanox.com>,
Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: stable@vger.kernel.org
Cc: Martin Steigerwald <Martin@Lichtvoll.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 139 +++++++++++++++++++++++++++++++++++++++----------
 include/linux/blkdev.h |  13 +++++
 2 files changed, 125 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0dc9e341c2a7..b70b00910b41 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -630,10 +630,27 @@ void blk_mq_complete_request(struct request *rq)
 	 * However, that would complicate paths which want to synchronize
 	 * against us.  Let stay in sync with the issue path so that
 	 * hctx_lock() covers both issue and completion paths.
+	 *
+	 * Cover complete vs BLK_EH_RESET_TIMER race in slow path with
+	 * holding queue lock.
 	 */
 	hctx_lock(hctx, &srcu_idx);
 	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
 		__blk_mq_complete_request(rq);
+	else {
+		unsigned long flags;
+		bool need_complete = false;
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		if (!blk_mq_rq_aborted_gstate(rq))
+			need_complete = true;
+		else
+			rq->rq_flags |= RQF_MQ_COMPLETE_IN_EH;
+		spin_unlock_irqrestore(q->queue_lock, flags);
+
+		if (need_complete)
+			__blk_mq_complete_request(rq);
+	}
 	hctx_unlock(hctx, srcu_idx);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
@@ -810,28 +827,50 @@ struct blk_mq_timeout_data {
 	unsigned int nr_expired;
 };
 
-static void blk_mq_rq_timed_out(struct request *req, bool reserved)
+static void blk_mq_rq_pre_timed_out(struct request *req, bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
 
-	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
-
 	if (ops->timeout)
 		ret = ops->timeout(req, reserved);
 
+	if (ret == BLK_EH_RESET_TIMER)
+		blk_add_timer(req);
+	req->eh_data.ret = ret;
+}
+
+static void blk_mq_rq_timed_out(struct request *req)
+{
+	enum blk_eh_timer_return ret = req->eh_data.ret;
+
 	switch (ret) {
 	case BLK_EH_HANDLED:
+		spin_lock_irq(req->q->queue_lock);
+ complete_rq:
+		if (req->rq_flags & RQF_MQ_COMPLETE_IN_EH)
+			req->rq_flags &= ~RQF_MQ_COMPLETE_IN_EH;
+		spin_unlock_irq(req->q->queue_lock);
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
 		/*
-		 * As nothing prevents from completion happening while
-		 * ->aborted_gstate is set, this may lead to ignored
-		 * completions and further spurious timeouts.
+		 * The normal completion may happen during handling the
+		 * timeout, or even after returning from .timeout(), so
+		 * once the request has been completed, we can't reset
+		 * timer any more since this request may be handled as
+		 * BLK_EH_RESET_TIMER in next timeout handling too, and
+		 * it has to be completed in this situation.
+		 *
+		 * Holding the queue lock to cover read/write rq's
+		 * aborted_gstate and normal state, so the race can be
+		 * avoided completely.
 		 */
+		spin_lock_irq(req->q->queue_lock);
+		if (req->rq_flags & RQF_MQ_COMPLETE_IN_EH)
+			goto complete_rq;
 		blk_mq_rq_update_aborted_gstate(req, 0);
-		blk_add_timer(req);
+		spin_unlock_irq(req->q->queue_lock);
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
@@ -847,10 +886,15 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	struct blk_mq_timeout_data *data = priv;
 	unsigned long gstate, deadline;
 	int start;
+	bool expired;
 
 	might_sleep();
 
-	if (rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED)
+	spin_lock_irq(rq->q->queue_lock);
+	expired = rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED;
+	spin_unlock_irq(rq->q->queue_lock);
+
+	if (expired)
 		return;
 
 	/* read coherent snapshots of @rq->state_gen and @rq->deadline */
@@ -875,19 +919,53 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	}
 }
 
-static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
+static void blk_mq_prepare_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
+	struct list_head *list = priv;
 	/*
 	 * We marked @rq->aborted_gstate and waited for RCU.  If there were
 	 * completions that we lost to, they would have finished and
 	 * updated @rq->gstate by now; otherwise, the completion path is
 	 * now guaranteed to see @rq->aborted_gstate and yield.  If
 	 * @rq->aborted_gstate still matches @rq->gstate, @rq is ours.
+	 *
+	 * One request is always handled as time-out exclusively with
+	 * queue lock.
 	 */
+	spin_lock_irq(rq->q->queue_lock);
 	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
-	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
-		blk_mq_rq_timed_out(rq, reserved);
+	    READ_ONCE(rq->gstate) == rq->aborted_gstate) {
+		rq->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
+		spin_unlock_irq(rq->q->queue_lock);
+
+		blk_mq_rq_pre_timed_out(rq, reserved);
+		list_add_tail(&rq->eh_data.node, list);
+	} else
+		spin_unlock_irq(rq->q->queue_lock);
+}
+
+static void blk_mq_timeout_synchronize_rcu(struct request_queue *q,
+		bool reset_expired)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+	bool has_rcu = false;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (!hctx->nr_expired)
+			continue;
+
+		if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+			has_rcu = true;
+		else
+			synchronize_srcu(hctx->srcu);
+
+		if (reset_expired)
+			hctx->nr_expired = 0;
+	}
+	if (has_rcu)
+		synchronize_rcu();
 }
 
 static void blk_mq_timeout_work(struct work_struct *work)
@@ -899,8 +977,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		.next_set	= 0,
 		.nr_expired	= 0,
 	};
-	struct blk_mq_hw_ctx *hctx;
-	int i;
 
 	/* A deadlock might occur if a request is stuck requiring a
 	 * timeout at the same time a queue freeze is waiting
@@ -922,7 +998,8 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
 	if (data.nr_expired) {
-		bool has_rcu = false;
+		struct request *rq;
+		LIST_HEAD(rq_list);
 
 		/*
 		 * Wait till everyone sees ->aborted_gstate.  The
@@ -930,28 +1007,36 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		 * becomes a problem, we can add per-hw_ctx rcu_head and
 		 * wait in parallel.
 		 */
-		queue_for_each_hw_ctx(q, hctx, i) {
-			if (!hctx->nr_expired)
-				continue;
+		blk_mq_timeout_synchronize_rcu(q, false);
 
-			if (!(hctx->flags & BLK_MQ_F_BLOCKING))
-				has_rcu = true;
-			else
-				synchronize_srcu(hctx->srcu);
+		/* call .timeout() for timed-out requests */
+		blk_mq_queue_tag_busy_iter(q, blk_mq_prepare_expired, &rq_list);
 
-			hctx->nr_expired = 0;
-		}
-		if (has_rcu)
-			synchronize_rcu();
+		/*
+		 * If .timeout returns BLK_EH_HANDLED, wait till current
+		 * completion is done, for avoiding to update state on
+		 * completed request.
+		 *
+		 * If .timeout returns BLK_EH_RESET_TIMER, wait till
+		 * blk_add_timer() is commited before completing this rq.
+		 */
+		blk_mq_timeout_synchronize_rcu(q, true);
 
-		/* terminate the ones we won */
-		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired, NULL);
+		/* terminate timed-out requests */
+		while (!list_empty(&rq_list)) {
+			rq = list_entry(rq_list.next, struct request, eh_data.node);
+			list_del_init(&rq->eh_data.node);
+			blk_mq_rq_timed_out(rq);
+		}
 	}
 
 	if (data.next_set) {
 		data.next = blk_rq_timeout(round_jiffies_up(data.next));
 		mod_timer(&q->timeout, data.next);
 	} else {
+		struct blk_mq_hw_ctx *hctx;
+		int i;
+
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If
 		 * we end up here it means that no requests are pending and
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9af3e0f430bc..704d54ce7702 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -129,11 +129,18 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_TIMEOUT_EXPIRED	((__force req_flags_t)(1 << 20))
 /* already slept for hybrid poll */
 #define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 21))
+/* already slept for hybrid poll */
+#define RQF_MQ_COMPLETE_IN_EH	((__force req_flags_t)(1 << 22))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
 	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
 
+struct req_eh_data {
+	int ret;
+	struct list_head node;
+};
+
 /*
  * Try to put the fields that are referenced together in the same cacheline.
  *
@@ -252,8 +259,14 @@ struct request {
 	struct list_head timeout_list;
 
 	union {
+		/* used after completion */
 		struct __call_single_data csd;
+
+		/* used in io scheduler, before dispatch */
 		u64 fifo_time;
+
+		/* used after dispatch and before completion */
+		struct req_eh_data eh_data;
 	};
 
 	/*
-- 
2.9.5

-- 
Ming
