Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] blk-mq: reimplement timeout handling
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org,
 kernel-team@fb.com, osandov@fb.com, linux-block@vger.kernel.org, hch@lst.de
References: <20171212190134.535941-1-tj@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b00aeb8b-5a5d-f37a-b593-408f22a1de67@kernel.dk>
Date: Tue, 12 Dec 2017 13:23:01 -0700
MIME-Version: 1.0
In-Reply-To: <20171212190134.535941-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/12/2017 12:01 PM, Tejun Heo wrote:
> Changes from the last version[1]
> 
> - BLK_EH_RESET_TIMER handling fixed.
> 
> - s/request->gstate_seqc/request->gstate_seq/
> 
> - READ_ONCE() added to blk_mq_rq_udpate_state().
> 
> - Removed left over blk_clear_rq_complete() invocation from
>   blk_mq_rq_timed_out().
> 
> Currently, blk-mq timeout path synchronizes against the usual
> issue/completion path using a complex scheme involving atomic
> bitflags, REQ_ATOM_*, memory barriers and subtle memory coherence
> rules.  Unfortunatley, it contains quite a few holes.
> 
> It's pretty easy to make blk_mq_check_expired() terminate a later
> instance of a request.  If we induce 5 sec delay before
> time_after_eq() test in blk_mq_check_expired(), shorten the timeout to
> 2s, and issue back-to-back large IOs, blk-mq starts timing out
> requests spuriously pretty quickly.  Nothing actually timed out.  It
> just made the call on a recycle instance of a request and then
> terminated a later instance long after the original instance finished.
> The scenario isn't theoretical either.
> 
> This patchset replaces the broken synchronization mechanism with a RCU
> and generation number based one.  Please read the patch description of
> the second path for more details.

I like this a lot, it's a lot less fragile and more intuitive/readable
than what we have now. And apparently less error prone... I'll do
some testing with this.

BTW, since youadd a few more BLK_MQ_F_BLOCKING checks, I think something
like the below would be a good cleanup on top of this.


From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: move hctx lock/unlock into a helper

Move the RCU vs SRCU logic into lock/unlock helpers, which makes
the actual functional bits within the locked region much easier
to read.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 663069dca4d6..dec3d1bb0559 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -572,6 +572,22 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
 	return aborted_gstate;
 }
 
+static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
+{
+	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+		rcu_read_unlock();
+	else
+		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
+}
+
+static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
+{
+	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+		rcu_read_lock();
+	else
+		*srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
+}
+
 /**
  * blk_mq_complete_request - end I/O on a request
  * @rq:		the request being processed
@@ -594,17 +610,10 @@ void blk_mq_complete_request(struct request *rq)
 	 * claiming @rq and we lost.  This is synchronized through RCU.
 	 * See blk_mq_timeout_work() for details.
 	 */
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		rcu_read_lock();
-		if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
-			__blk_mq_complete_request(rq);
-		rcu_read_unlock();
-	} else {
-		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
-		if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
-			__blk_mq_complete_request(rq);
-		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
-	}
+	hctx_lock(hctx, &srcu_idx);
+	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
+		__blk_mq_complete_request(rq);
+	hctx_unlock(hctx, srcu_idx);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
@@ -1243,17 +1252,11 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		rcu_read_lock();
-		blk_mq_sched_dispatch_requests(hctx);
-		rcu_read_unlock();
-	} else {
-		might_sleep();
+	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
-		blk_mq_sched_dispatch_requests(hctx);
-		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
-	}
+	hctx_lock(hctx, &srcu_idx);
+	blk_mq_sched_dispatch_requests(hctx);
+	hctx_unlock(hctx, srcu_idx);
 }
 
 /*
@@ -1624,7 +1627,7 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 
 static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 					struct request *rq,
-					blk_qc_t *cookie, bool may_sleep)
+					blk_qc_t *cookie)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
@@ -1674,25 +1677,20 @@ static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	}
 
 insert:
-	blk_mq_sched_insert_request(rq, false, run_queue, false, may_sleep);
+	blk_mq_sched_insert_request(rq, false, run_queue, false,
+					hctx->flags & BLK_MQ_F_BLOCKING);
 }
 
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, blk_qc_t *cookie)
 {
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		rcu_read_lock();
-		__blk_mq_try_issue_directly(hctx, rq, cookie, false);
-		rcu_read_unlock();
-	} else {
-		unsigned int srcu_idx;
+	int srcu_idx;
 
-		might_sleep();
+	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
-		__blk_mq_try_issue_directly(hctx, rq, cookie, true);
-		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
-	}
+	hctx_lock(hctx, &srcu_idx);
+	__blk_mq_try_issue_directly(hctx, rq, cookie);
+	hctx_unlock(hctx, srcu_idx);
 }
 
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)

-- 
Jens Axboe
