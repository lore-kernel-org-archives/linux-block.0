Return-Path: <ming.lei@redhat.com>
Date: Sat, 14 Apr 2018 08:06:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
Message-ID: <20180414000623.GA4198@ming.t460p>
References: <20180410210157.30477-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410210157.30477-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 03:01:57PM -0600, Bart Van Assche wrote:
> The blk-mq timeout handling code ignores completions that occur after
> blk_mq_check_expired() has been called and before blk_mq_rq_timed_out()
> has reset rq->aborted_gstate. If a block driver timeout handler always
> returns BLK_EH_RESET_TIMER then the result will be that the request
> never terminates.

We should fix this issue in block layer because:

1) when normal completion is done after rq's state is updated
to COMPLETE during timeout handling, this patch still follows previous
behaviour to reset timer, instead of complete this request immediately.

2) if driver's .timeout() deals with this situation by returning
RESET_TIMER at the first time, it can be very possible to deal with
this situation as RESET_TIMER in next timeout, because both hw and sw state
wrt. this request isn't changed compared with 1st .timeout.
So it is very possible for this request to not be completed for ever.

3) normal completion may be done just after returning from .timeout(),
so this issue may not be avoided by fixing driver

And the simple approach in the following link can fix the issue
without introducing any cost in fast path:

https://marc.info/?l=linux-block&m=152353441722852&w=2

> 
> Since the request state can be updated from two different contexts,
> namely regular completion and request timeout, this race cannot be
> fixed with RCU synchronization only. Fix this race as follows:
> - Use the deadline instead of the request generation to detect whether
>   or not a request timer fired after reinitialization of a request.
> - Store the request state in the lowest two bits of the deadline instead
>   of the lowest two bits of 'gstate'.
> - Rename MQ_RQ_STATE_MASK into RQ_STATE_MASK and change it from an
>   enumeration member into a #define such that its type can be changed
>   into unsigned long. That allows to write & ~RQ_STATE_MASK instead of
>   ~(unsigned long)RQ_STATE_MASK.
> - Remove all request member variables that became superfluous due to
>   this change: gstate, aborted_gstate, gstate_seq and aborted_gstate_sync.
> - Remove the request state information that became superfluous due to this
>   patch, namely RQF_MQ_TIMEOUT_EXPIRED.
> - Remove the hctx member that became superfluous due to these changes,
>   namely nr_expired.
> - Remove the code that became superfluous due to this change, namely
>   the RCU lock and unlock statements in blk_mq_complete_request() and
>   also the synchronize_rcu() call in the timeout handler.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Israel Rukshin <israelr@mellanox.com>,
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Cc: <stable@vger.kernel.org> # v4.16
> ---
> 
> Changes compared to v4:
> - Addressed multiple review comments from Christoph. The most important are
>   that atomic_long_cmpxchg() has been changed into cmpxchg() and also that
>   there is now a nice and clean split between the legacy and blk-mq versions
>   of blk_add_timer().
> - Changed the patch name and modified the patch description because there is
>   disagreement about whether or not the v4.16 blk-mq core can complete a
>   single request twice. Kept the "Cc: stable" tag because of
>   https://bugzilla.kernel.org/show_bug.cgi?id=199077.
> 
> Changes compared to v3 (see also https://www.mail-archive.com/linux-block@vger.kernel.org/msg20073.html):
> - Removed the spinlock again that was introduced to protect the request state.
>   v4 uses atomic_long_cmpxchg() instead.
> - Split __deadline into two variables - one for the legacy block layer and one
>   for blk-mq.
> 
> Changes compared to v2 (https://www.mail-archive.com/linux-block@vger.kernel.org/msg18338.html):
> - Rebased and retested on top of kernel v4.16.
> 
> Changes compared to v1 (https://www.mail-archive.com/linux-block@vger.kernel.org/msg18089.html):
> - Removed the gstate and aborted_gstate members of struct request and used
>   the __deadline member to encode both the generation and state information.
> 
>  block/blk-core.c       |   2 -
>  block/blk-mq-debugfs.c |   1 -
>  block/blk-mq.c         | 174 +++++--------------------------------------------
>  block/blk-mq.h         |  65 ++++++++++--------
>  block/blk-timeout.c    |  89 ++++++++++++++-----------
>  block/blk.h            |  13 ++--
>  include/linux/blk-mq.h |   1 -
>  include/linux/blkdev.h |  30 ++-------
>  8 files changed, 118 insertions(+), 257 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 8625ec929fe5..181b1a688a5b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -200,8 +200,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>  	rq->start_time = jiffies;
>  	set_start_time_ns(rq);
>  	rq->part = NULL;
> -	seqcount_init(&rq->gstate_seq);
> -	u64_stats_init(&rq->aborted_gstate_sync);
>  }
>  EXPORT_SYMBOL(blk_rq_init);
>  
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 6f72413b6cab..80c7c585769f 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -345,7 +345,6 @@ static const char *const rqf_name[] = {
>  	RQF_NAME(STATS),
>  	RQF_NAME(SPECIAL_PAYLOAD),
>  	RQF_NAME(ZONE_WRITE_LOCKED),
> -	RQF_NAME(MQ_TIMEOUT_EXPIRED),
>  	RQF_NAME(MQ_POLL_SLEPT),
>  };
>  #undef RQF_NAME
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7816d28b7219..0680977d6d98 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -305,7 +305,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	rq->special = NULL;
>  	/* tag was already set */
>  	rq->extra_len = 0;
> -	rq->__deadline = 0;
>  
>  	INIT_LIST_HEAD(&rq->timeout_list);
>  	rq->timeout = 0;
> @@ -481,7 +480,8 @@ void blk_mq_free_request(struct request *rq)
>  	if (blk_rq_rl(rq))
>  		blk_put_rl(blk_rq_rl(rq));
>  
> -	blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
> +	if (!blk_mq_change_rq_state(rq, blk_mq_rq_state(rq), MQ_RQ_IDLE))
> +		WARN_ON_ONCE(true);
>  	if (rq->tag != -1)
>  		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
>  	if (sched_tag != -1)
> @@ -527,8 +527,7 @@ static void __blk_mq_complete_request(struct request *rq)
>  	bool shared = false;
>  	int cpu;
>  
> -	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT);
> -	blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE);
> +	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
>  
>  	if (rq->internal_tag != -1)
>  		blk_mq_sched_completed_request(rq);
> @@ -577,36 +576,6 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
>  		*srcu_idx = srcu_read_lock(hctx->srcu);
>  }
>  
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
> @@ -618,27 +587,12 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
>  void blk_mq_complete_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
> -	int srcu_idx;
>  
>  	if (unlikely(blk_should_fake_timeout(q)))
>  		return;
>  
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
> +	if (blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE))
>  		__blk_mq_complete_request(rq);
> -	hctx_unlock(hctx, srcu_idx);
>  }
>  EXPORT_SYMBOL(blk_mq_complete_request);
>  
> @@ -662,27 +616,7 @@ void blk_mq_start_request(struct request *rq)
>  		wbt_issue(q->rq_wb, &rq->issue_stat);
>  	}
>  
> -	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
> -
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
> -	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
> -	blk_add_timer(rq);
> -
> -	write_seqcount_end(&rq->gstate_seq);
> -	preempt_enable();
> +	blk_mq_add_timer(rq, MQ_RQ_IDLE, MQ_RQ_IN_FLIGHT);
>  
>  	if (q->dma_drain_size && blk_rq_bytes(rq)) {
>  		/*
> @@ -695,22 +629,19 @@ void blk_mq_start_request(struct request *rq)
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
> +	enum mq_rq_state old_state = blk_mq_rq_state(rq);
>  
>  	blk_mq_put_driver_tag(rq);
>  
>  	trace_block_rq_requeue(q, rq);
>  	wbt_requeue(q->rq_wb, &rq->issue_stat);
>  
> -	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
> -		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
> +	if (old_state != MQ_RQ_IDLE) {
> +		if (!blk_mq_change_rq_state(rq, old_state, MQ_RQ_IDLE))
> +			WARN_ON_ONCE(true);
>  		if (q->dma_drain_size && blk_rq_bytes(rq))
>  			rq->nr_phys_segments--;
>  	}
> @@ -811,7 +742,6 @@ EXPORT_SYMBOL(blk_mq_tag_to_rq);
>  struct blk_mq_timeout_data {
>  	unsigned long next;
>  	unsigned int next_set;
> -	unsigned int nr_expired;
>  };
>  
>  static void blk_mq_rq_timed_out(struct request *req, bool reserved)
> @@ -819,8 +749,6 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  	const struct blk_mq_ops *ops = req->q->mq_ops;
>  	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
>  
> -	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
> -
>  	if (ops->timeout)
>  		ret = ops->timeout(req, reserved);
>  
> @@ -829,13 +757,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  		__blk_mq_complete_request(req);
>  		break;
>  	case BLK_EH_RESET_TIMER:
> -		/*
> -		 * As nothing prevents from completion happening while
> -		 * ->aborted_gstate is set, this may lead to ignored
> -		 * completions and further spurious timeouts.
> -		 */
> -		blk_mq_rq_update_aborted_gstate(req, 0);
> -		blk_add_timer(req);
> +		blk_mq_add_timer(req, MQ_RQ_COMPLETE, MQ_RQ_IN_FLIGHT);

Normal completion may have been done during handling this timeout, and
this request should have been dealt with by EH_HANDLED here, otherwise
it may never be completed.

Thanks,
Ming
