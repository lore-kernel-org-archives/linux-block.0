Return-Path: <ming.lei@redhat.com>
Date: Fri, 23 Feb 2018 23:07:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	broonie@kernel.org, linus.walleij@linaro.org,
	bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
	alban.browaeys@gmail.com, ivan@ludios.org,
	169364@studenti.unimore.it, holger@applied-asynchrony.com,
	efault@gmx.de, Serena Ziviani <ziviani.serena@gmail.com>
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
Message-ID: <20180223150705.GB30079@ming.t460p>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180207211920.6343-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi Paolo,

On Wed, Feb 07, 2018 at 10:19:20PM +0100, Paolo Valente wrote:
> Commit 'a6a252e64914 ("blk-mq-sched: decide how to handle flush rq via
> RQF_FLUSH_SEQ")' makes all non-flush re-prepared requests for a device
> be re-inserted into the active I/O scheduler for that device. As a

No, this behaviour isn't related with commit a6a252e64914, and
it has been there since blk_mq_requeue_request() is introduced.

And you can see blk_mq_requeue_request() is called by lots of drivers,
especially it is often used in error handler, see SCSI's example.

> consequence, I/O schedulers may get the same request inserted again,
> even several times, without a finish_request invoked on that request
> before each re-insertion.
> 
> This fact is the cause of the failure reported in [1]. For an I/O
> scheduler, every re-insertion of the same re-prepared request is
> equivalent to the insertion of a new request. For schedulers like
> mq-deadline or kyber, this fact causes no harm. In contrast, it
> confuses a stateful scheduler like BFQ, which keeps state for an I/O
> request, until the finish_request hook is invoked on the request. In
> particular, BFQ may get stuck, waiting forever for the number of
> request dispatches, of the same request, to be balanced by an equal
> number of request completions (while there will be one completion for
> that request). In this state, BFQ may refuse to serve I/O requests
> from other bfq_queues. The hang reported in [1] then follows.
> 
> However, the above re-prepared requests undergo a requeue, thus the
> requeue_request hook of the active elevator is invoked for these
> requests, if set. This commit then addresses the above issue by
> properly implementing the hook requeue_request in BFQ.
> 
> [1] https://marc.info/?l=linux-block&m=151211117608676
> 
> Reported-by: Ivan Kozik <ivan@ludios.org>
> Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
> Tested-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Serena Ziviani <ziviani.serena@gmail.com>
> ---
> V2: contains fix to bug reported in [2]
> V3: implements the improvement suggested in [3]
> 
> [2] https://lkml.org/lkml/2018/2/5/599
> [3] https://lkml.org/lkml/2018/2/7/532
> 
>  block/bfq-iosched.c | 107 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 82 insertions(+), 25 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 47e6ec7427c4..aeca22d91101 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -3823,24 +3823,26 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  		}
> 
>  		/*
> -		 * We exploit the bfq_finish_request hook to decrement
> -		 * rq_in_driver, but bfq_finish_request will not be
> -		 * invoked on this request. So, to avoid unbalance,
> -		 * just start this request, without incrementing
> -		 * rq_in_driver. As a negative consequence,
> -		 * rq_in_driver is deceptively lower than it should be
> -		 * while this request is in service. This may cause
> -		 * bfq_schedule_dispatch to be invoked uselessly.
> +		 * We exploit the bfq_finish_requeue_request hook to
> +		 * decrement rq_in_driver, but
> +		 * bfq_finish_requeue_request will not be invoked on
> +		 * this request. So, to avoid unbalance, just start
> +		 * this request, without incrementing rq_in_driver. As
> +		 * a negative consequence, rq_in_driver is deceptively
> +		 * lower than it should be while this request is in
> +		 * service. This may cause bfq_schedule_dispatch to be
> +		 * invoked uselessly.
>  		 *
>  		 * As for implementing an exact solution, the
> -		 * bfq_finish_request hook, if defined, is probably
> -		 * invoked also on this request. So, by exploiting
> -		 * this hook, we could 1) increment rq_in_driver here,
> -		 * and 2) decrement it in bfq_finish_request. Such a
> -		 * solution would let the value of the counter be
> -		 * always accurate, but it would entail using an extra
> -		 * interface function. This cost seems higher than the
> -		 * benefit, being the frequency of non-elevator-private
> +		 * bfq_finish_requeue_request hook, if defined, is
> +		 * probably invoked also on this request. So, by
> +		 * exploiting this hook, we could 1) increment
> +		 * rq_in_driver here, and 2) decrement it in
> +		 * bfq_finish_requeue_request. Such a solution would
> +		 * let the value of the counter be always accurate,
> +		 * but it would entail using an extra interface
> +		 * function. This cost seems higher than the benefit,
> +		 * being the frequency of non-elevator-private
>  		 * requests very low.
>  		 */
>  		goto start_rq;
> @@ -4515,6 +4517,8 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
>  					   unsigned int cmd_flags) {}
>  #endif
> 
> +static void bfq_prepare_request(struct request *rq, struct bio *bio);
> +
>  static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  			       bool at_head)
>  {
> @@ -4541,6 +4545,18 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		else
>  			list_add_tail(&rq->queuelist, &bfqd->dispatch);
>  	} else {
> +		if (WARN_ON_ONCE(!bfqq)) {
> +			/*
> +			 * This should never happen. Most likely rq is
> +			 * a requeued regular request, being
> +			 * re-inserted without being first
> +			 * re-prepared. Do a prepare, to avoid
> +			 * failure.
> +			 */
> +			bfq_prepare_request(rq, rq->bio);
> +			bfqq = RQ_BFQQ(rq);
> +		}
> +
>  		idle_timer_disabled = __bfq_insert_request(bfqd, rq);
>  		/*
>  		 * Update bfqq, because, if a queue merge has occurred
> @@ -4697,22 +4713,44 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
>  		bfq_schedule_dispatch(bfqd);
>  }
> 
> -static void bfq_finish_request_body(struct bfq_queue *bfqq)
> +static void bfq_finish_requeue_request_body(struct bfq_queue *bfqq)
>  {
>  	bfqq->allocated--;
> 
>  	bfq_put_queue(bfqq);
>  }
> 
> -static void bfq_finish_request(struct request *rq)
> +/*
> + * Handle either a requeue or a finish for rq. The things to do are
> + * the same in both cases: all references to rq are to be dropped. In
> + * particular, rq is considered completed from the point of view of
> + * the scheduler.
> + */
> +static void bfq_finish_requeue_request(struct request *rq)
>  {
> -	struct bfq_queue *bfqq;
> +	struct bfq_queue *bfqq = RQ_BFQQ(rq);
>  	struct bfq_data *bfqd;
> 
> -	if (!rq->elv.icq)
> +	/*
> +	 * Requeue and finish hooks are invoked in blk-mq without
> +	 * checking whether the involved request is actually still
> +	 * referenced in the scheduler. To handle this fact, the
> +	 * following two checks make this function exit in case of
> +	 * spurious invocations, for which there is nothing to do.
> +	 *
> +	 * First, check whether rq has nothing to do with an elevator.
> +	 */
> +	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
> +		return;
> +
> +	/*
> +	 * rq either is not associated with any icq, or is an already
> +	 * requeued request that has not (yet) been re-inserted into
> +	 * a bfq_queue.
> +	 */
> +	if (!rq->elv.icq || !bfqq)
>  		return;
> 
> -	bfqq = RQ_BFQQ(rq);
>  	bfqd = bfqq->bfqd;
> 
>  	if (rq->rq_flags & RQF_STARTED)
> @@ -4727,13 +4765,14 @@ static void bfq_finish_request(struct request *rq)
>  		spin_lock_irqsave(&bfqd->lock, flags);
> 
>  		bfq_completed_request(bfqq, bfqd);
> -		bfq_finish_request_body(bfqq);
> +		bfq_finish_requeue_request_body(bfqq);
> 
>  		spin_unlock_irqrestore(&bfqd->lock, flags);
>  	} else {
>  		/*
>  		 * Request rq may be still/already in the scheduler,
> -		 * in which case we need to remove it. And we cannot
> +		 * in which case we need to remove it (this should
> +		 * never happen in case of requeue). And we cannot
>  		 * defer such a check and removal, to avoid
>  		 * inconsistencies in the time interval from the end
>  		 * of this function to the start of the deferred work.
> @@ -4748,9 +4787,26 @@ static void bfq_finish_request(struct request *rq)
>  			bfqg_stats_update_io_remove(bfqq_group(bfqq),
>  						    rq->cmd_flags);
>  		}
> -		bfq_finish_request_body(bfqq);
> +		bfq_finish_requeue_request_body(bfqq);
>  	}
> 
> +	/*
> +	 * Reset private fields. In case of a requeue, this allows
> +	 * this function to correctly do nothing if it is spuriously
> +	 * invoked again on this same request (see the check at the
> +	 * beginning of the function). Probably, a better general
> +	 * design would be to prevent blk-mq from invoking the requeue
> +	 * or finish hooks of an elevator, for a request that is not
> +	 * referred by that elevator.
> +	 *
> +	 * Resetting the following fields would break the
> +	 * request-insertion logic if rq is re-inserted into a bfq
> +	 * internal queue, without a re-preparation. Here we assume
> +	 * that re-insertions of requeued requests, without
> +	 * re-preparation, can happen only for pass_through or at_head
> +	 * requests (which are not re-inserted into bfq internal
> +	 * queues).
> +	 */
>  	rq->elv.priv[0] = NULL;
>  	rq->elv.priv[1] = NULL;
>  }
> @@ -5426,7 +5482,8 @@ static struct elevator_type iosched_bfq_mq = {
>  	.ops.mq = {
>  		.limit_depth		= bfq_limit_depth,
>  		.prepare_request	= bfq_prepare_request,
> -		.finish_request		= bfq_finish_request,
> +		.requeue_request        = bfq_finish_requeue_request,
> +		.finish_request		= bfq_finish_requeue_request,
>  		.exit_icq		= bfq_exit_icq,
>  		.insert_requests	= bfq_insert_requests,
>  		.dispatch_request	= bfq_dispatch_request,

This way may not be correct since blk_mq_sched_requeue_request() can be
called for one request which won't enter io scheduler.

__blk_mq_requeue_request() is called for two cases:

	- one is that the requeued request is added to hctx->dispatch, such
	as blk_mq_dispatch_rq_list()
	- another case is that the request is requeued to io scheduler, such as
	blk_mq_requeue_request().

For the 1st case, blk_mq_sched_requeue_request() shouldn't be called
since it is nothing to do with scheduler, seems we only need to do that
for 2nd case.

So looks we need the following patch:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 23de7fd8099a..a216f3c3c3ce 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -712,7 +714,6 @@ static void __blk_mq_requeue_request(struct request *rq)
 
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, &rq->issue_stat);
-	blk_mq_sched_requeue_request(rq);
 
 	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
 		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
@@ -725,6 +726,9 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 {
 	__blk_mq_requeue_request(rq);
 
+	/* this request will be re-inserted to io scheduler queue */
+	blk_mq_sched_requeue_request(rq);
+
 	BUG_ON(blk_queued_rq(rq));
 	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
 }


Thanks,
Ming
