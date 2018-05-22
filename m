Return-Path: <ming.lei@redhat.com>
Date: Tue, 22 May 2018 10:49:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180522024910.GD20430@ming.t460p>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521231131.6685-4-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 05:11:31PM -0600, Keith Busch wrote:
> This patch simplifies the timeout handling by relying on the request
> reference counting to ensure the iterator is operating on an inflight

The reference counting isn't free, what is the real benefit in this way?

> and truly timed out request. Since the reference counting prevents the
> tag from being reallocated, the block layer no longer needs to prevent
> drivers from completing their requests while the timeout handler is
> operating on it: a driver completing a request is allowed to proceed to
> the next state without additional syncronization with the block layer.

This might cause trouble for drivers, since the previous behaviour
is that one request is only completed from one path, and now you change
the behaviour.

> 
> This also removes any need for generation sequence numbers since the
> request lifetime is prevented from being reallocated as a new sequence
> while timeout handling is operating on it.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/blk-core.c       |   6 --
>  block/blk-mq-debugfs.c |   1 -
>  block/blk-mq.c         | 259 ++++++++++---------------------------------------
>  block/blk-mq.h         |  20 +---
>  block/blk-timeout.c    |   1 -
>  include/linux/blkdev.h |  26 +----
>  6 files changed, 58 insertions(+), 255 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 43370faee935..cee03cad99f2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -198,12 +198,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>  	rq->internal_tag = -1;
>  	rq->start_time_ns = ktime_get_ns();
>  	rq->part = NULL;
> -	seqcount_init(&rq->gstate_seq);
> -	u64_stats_init(&rq->aborted_gstate_sync);
> -	/*
> -	 * See comment of blk_mq_init_request
> -	 */
> -	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
>  }
>  EXPORT_SYMBOL(blk_rq_init);
>  
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 3080e18cb859..ffa622366922 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -344,7 +344,6 @@ static const char *const rqf_name[] = {
>  	RQF_NAME(STATS),
>  	RQF_NAME(SPECIAL_PAYLOAD),
>  	RQF_NAME(ZONE_WRITE_LOCKED),
> -	RQF_NAME(MQ_TIMEOUT_EXPIRED),
>  	RQF_NAME(MQ_POLL_SLEPT),
>  };
>  #undef RQF_NAME
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 66e5c768803f..4858876fd364 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -589,56 +589,6 @@ static void __blk_mq_complete_request(struct request *rq)
>  	put_cpu();
>  }
>  
> -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> -	__releases(hctx->srcu)
> -{
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> -		rcu_read_unlock();
> -	else
> -		srcu_read_unlock(hctx->srcu, srcu_idx);
> -}
> -
> -static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
> -	__acquires(hctx->srcu)
> -{
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		/* shut up gcc false positive */
> -		*srcu_idx = 0;
> -		rcu_read_lock();
> -	} else
> -		*srcu_idx = srcu_read_lock(hctx->srcu);
> -}
> -
> -static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
> -{
> -	unsigned long flags;
> -
> -	/*
> -	 * blk_mq_rq_aborted_gstate() is used from the completion path and
> -	 * can thus be called from irq context.  u64_stats_fetch in the
> -	 * middle of update on the same CPU leads to lockup.  Disable irq
> -	 * while updating.
> -	 */
> -	local_irq_save(flags);
> -	u64_stats_update_begin(&rq->aborted_gstate_sync);
> -	rq->aborted_gstate = gstate;
> -	u64_stats_update_end(&rq->aborted_gstate_sync);
> -	local_irq_restore(flags);
> -}
> -
> -static u64 blk_mq_rq_aborted_gstate(struct request *rq)
> -{
> -	unsigned int start;
> -	u64 aborted_gstate;
> -
> -	do {
> -		start = u64_stats_fetch_begin(&rq->aborted_gstate_sync);
> -		aborted_gstate = rq->aborted_gstate;
> -	} while (u64_stats_fetch_retry(&rq->aborted_gstate_sync, start));
> -
> -	return aborted_gstate;
> -}
> -
>  /**
>   * blk_mq_complete_request - end I/O on a request
>   * @rq:		the request being processed
> @@ -650,27 +600,10 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
>  void blk_mq_complete_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
> -	int srcu_idx;
>  
>  	if (unlikely(blk_should_fake_timeout(q)))
>  		return;
> -
> -	/*
> -	 * If @rq->aborted_gstate equals the current instance, timeout is
> -	 * claiming @rq and we lost.  This is synchronized through
> -	 * hctx_lock().  See blk_mq_timeout_work() for details.
> -	 *
> -	 * Completion path never blocks and we can directly use RCU here
> -	 * instead of hctx_lock() which can be either RCU or SRCU.
> -	 * However, that would complicate paths which want to synchronize
> -	 * against us.  Let stay in sync with the issue path so that
> -	 * hctx_lock() covers both issue and completion paths.
> -	 */
> -	hctx_lock(hctx, &srcu_idx);
> -	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
> -		__blk_mq_complete_request(rq);
> -	hctx_unlock(hctx, srcu_idx);
> +	__blk_mq_complete_request(rq);
>  }
>  EXPORT_SYMBOL(blk_mq_complete_request);
>  
> @@ -699,26 +632,9 @@ void blk_mq_start_request(struct request *rq)
>  
>  	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
>  
> -	/*
> -	 * Mark @rq in-flight which also advances the generation number,
> -	 * and register for timeout.  Protect with a seqcount to allow the
> -	 * timeout path to read both @rq->gstate and @rq->deadline
> -	 * coherently.
> -	 *
> -	 * This is the only place where a request is marked in-flight.  If
> -	 * the timeout path reads an in-flight @rq->gstate, the
> -	 * @rq->deadline it reads together under @rq->gstate_seq is
> -	 * guaranteed to be the matching one.
> -	 */
> -	preempt_disable();
> -	write_seqcount_begin(&rq->gstate_seq);
> -
>  	blk_add_timer(rq);
>  	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
>  
> -	write_seqcount_end(&rq->gstate_seq);
> -	preempt_enable();
> -
>  	if (q->dma_drain_size && blk_rq_bytes(rq)) {
>  		/*
>  		 * Make sure space for the drain appears.  We know we can do
> @@ -730,11 +646,6 @@ void blk_mq_start_request(struct request *rq)
>  }
>  EXPORT_SYMBOL(blk_mq_start_request);
>  
> -/*
> - * When we reach here because queue is busy, it's safe to change the state
> - * to IDLE without checking @rq->aborted_gstate because we should still be
> - * holding the RCU read lock and thus protected against timeout.
> - */
>  static void __blk_mq_requeue_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> @@ -843,33 +754,24 @@ struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
>  }
>  EXPORT_SYMBOL(blk_mq_tag_to_rq);
>  
> -struct blk_mq_timeout_data {
> -	unsigned long next;
> -	unsigned int next_set;
> -	unsigned int nr_expired;
> -};
> -
>  static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  {
>  	const struct blk_mq_ops *ops = req->q->mq_ops;
>  	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
>  
> -	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
> -
>  	if (ops->timeout)
>  		ret = ops->timeout(req, reserved);
>  
>  	switch (ret) {
>  	case BLK_EH_HANDLED:
> -		__blk_mq_complete_request(req);
> -		break;
> -	case BLK_EH_RESET_TIMER:
>  		/*
> -		 * As nothing prevents from completion happening while
> -		 * ->aborted_gstate is set, this may lead to ignored
> -		 * completions and further spurious timeouts.
> +		 * If the request is still in flight, the driver is requesting
> +		 * blk-mq complete it.
>  		 */
> -		blk_mq_rq_update_aborted_gstate(req, 0);
> +		if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT)
> +			__blk_mq_complete_request(req);
> +		break;
> +	case BLK_EH_RESET_TIMER:
>  		blk_add_timer(req);
>  		break;
>  	case BLK_EH_NOT_HANDLED:
> @@ -880,64 +782,64 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  	}
>  }
>  
> -static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
> -		struct request *rq, void *priv, bool reserved)
> +static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
>  {
> -	struct blk_mq_timeout_data *data = priv;
> -	unsigned long gstate, deadline;
> -	int start;
> +	unsigned long deadline;
>  
> -	might_sleep();
> -
> -	if (rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED)
> -		return;
> +	if (blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
> +		return false;
>  
> -	/* read coherent snapshots of @rq->state_gen and @rq->deadline */
> -	while (true) {
> -		start = read_seqcount_begin(&rq->gstate_seq);
> -		gstate = READ_ONCE(rq->gstate);
> -		deadline = blk_rq_deadline(rq);
> -		if (!read_seqcount_retry(&rq->gstate_seq, start))
> -			break;
> -		cond_resched();
> -	}
> +	deadline = blk_rq_deadline(rq);
> +	if (time_after_eq(jiffies, deadline))
> +		return true;
>  
> -	/* if in-flight && overdue, mark for abortion */
> -	if ((gstate & MQ_RQ_STATE_MASK) == MQ_RQ_IN_FLIGHT &&
> -	    time_after_eq(jiffies, deadline)) {
> -		blk_mq_rq_update_aborted_gstate(rq, gstate);
> -		data->nr_expired++;
> -		hctx->nr_expired++;
> -	} else if (!data->next_set || time_after(data->next, deadline)) {
> -		data->next = deadline;
> -		data->next_set = 1;
> -	}
> +	if (*next == 0)
> +		*next = deadline;
> +	else if (time_after(*next, deadline))
> +		*next = deadline;
> +	return false;
>  }
>  
> -static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
> +static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>  		struct request *rq, void *priv, bool reserved)
>  {
> +	unsigned long *next = priv;
> +
>  	/*
> -	 * We marked @rq->aborted_gstate and waited for RCU.  If there were
> -	 * completions that we lost to, they would have finished and
> -	 * updated @rq->gstate by now; otherwise, the completion path is
> -	 * now guaranteed to see @rq->aborted_gstate and yield.  If
> -	 * @rq->aborted_gstate still matches @rq->gstate, @rq is ours.
> +	 * Just do a quick check if it is expired before locking the request in
> +	 * so we're not unnecessarilly synchronizing across CPUs.
>  	 */
> -	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
> -	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
> +	if (!blk_mq_req_expired(rq, next))
> +		return;
> +
> +	/*
> +	 * We have reason to believe the request may be expired. Take a
> +	 * reference on the request to lock this request lifetime into its
> +	 * currently allocated context to prevent it from being reallocated in
> +	 * the event the completion by-passes this timeout handler.
> +	 * 
> +	 * If the reference was already released, then the driver beat the
> +	 * timeout handler to posting a natural completion.
> +	 */
> +	if (!kref_get_unless_zero(&rq->ref))
> +		return;

If this request is just completed in normal path and its state isn't
updated yet, timeout will hold the request, and may complete this
request again, then this req can be completed two times.

Thanks,
Ming
