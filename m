Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, oleg@redhat.com,
        peterz@infradead.org, kernel-team@fb.com, osandov@fb.com,
        linux-block@vger.kernel.org, hch@lst.de
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <83fa38dc-ce9c-054a-43e9-38b339e5fb27@oracle.com>
Date: Wed, 13 Dec 2017 13:07:30 +0800
MIME-Version: 1.0
In-Reply-To: <20171212190134.535941-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Tejun

On 12/13/2017 03:01 AM, Tejun Heo wrote:
> Currently, blk-mq timeout path synchronizes against the usual
> issue/completion path using a complex scheme involving atomic
> bitflags, REQ_ATOM_*, memory barriers and subtle memory coherence
> rules.  Unfortunatley, it contains quite a few holes.
> 
> There's a complex dancing around REQ_ATOM_STARTED and
> REQ_ATOM_COMPLETE between issue/completion and timeout paths; however,
> they don't have a synchronization point across request recycle
> instances and it isn't clear what the barriers add.
> blk_mq_check_expired() can easily read STARTED from N-2'th iteration,
> deadline from N-1'th, blk_mark_rq_complete() against Nth instance.
> 
> In fact, it's pretty easy to make blk_mq_check_expired() terminate a
> later instance of a request.  If we induce 5 sec delay before
> time_after_eq() test in blk_mq_check_expired(), shorten the timeout to
> 2s, and issue back-to-back large IOs, blk-mq starts timing out
> requests spuriously pretty quickly.  Nothing actually timed out.  It
> just made the call on a recycle instance of a request and then
> terminated a later instance long after the original instance finished.
> The scenario isn't theoretical either.
> 
> This patch replaces the broken synchronization mechanism with a RCU
> and generation number based one.
> 
> 1. Each request has a u64 generation + state value, which can be
>    updated only by the request owner.  Whenever a request becomes
>    in-flight, the generation number gets bumped up too.  This provides
>    the basis for the timeout path to distinguish different recycle
>    instances of the request.
> 
>    Also, marking a request in-flight and setting its deadline are
>    protected with a seqcount so that the timeout path can fetch both
>    values coherently.
> 
> 2. The timeout path fetches the generation, state and deadline.  If
>    the verdict is timeout, it records the generation into a dedicated
>    request abortion field and does RCU wait.
> 
> 3. The completion path is also protected by RCU (from the previous
>    patch) and checks whether the current generation number and state
>    match the abortion field.  If so, it skips completion.
> 
> 4. The timeout path, after RCU wait, scans requests again and
>    terminates the ones whose generation and state still match the ones
>    requested for abortion.
> 
>    By now, the timeout path knows that either the generation number
>    and state changed if it lost the race or the completion will yield
>    to it and can safely timeout the request.
> 
> While it's more lines of code, it's conceptually simpler, doesn't
> depend on direct use of subtle memory ordering or coherence, and
> hopefully doesn't terminate the wrong instance.
> 
> While this change makes REQ_ATOM_COMPLETE synchornization unnecessary
> between issue/complete and timeout paths, REQ_ATOM_COMPLETE isn't
> removed yet as it's still used in other places.  Future patches will
> move all state tracking to the new mechanism and remove all bitops in
> the hot paths.
> 
> v2: - Fixed BLK_EH_RESET_TIMER handling as pointed out by Jianchao.
>     - s/request->gstate_seqc/request->gstate_seq/ as suggested by Peter.
>     - READ_ONCE() added in blk_mq_rq_update_state() as suggested by Peter.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
> ---
>  block/blk-core.c       |   2 +
>  block/blk-mq.c         | 206 +++++++++++++++++++++++++++++++------------------
>  block/blk-mq.h         |  45 +++++++++++
>  block/blk-timeout.c    |   2 +-
>  block/blk.h            |   6 --
>  include/linux/blk-mq.h |   1 +
>  include/linux/blkdev.h |  23 ++++++
>  7 files changed, 204 insertions(+), 81 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b888175..6034623 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -126,6 +126,8 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
>  	rq->start_time = jiffies;
>  	set_start_time_ns(rq);
>  	rq->part = NULL;
> +	seqcount_init(&rq->gstate_seq);
> +	u64_stats_init(&rq->aborted_gstate_sync);
>  }
>  EXPORT_SYMBOL(blk_rq_init);
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index acf4fbb..b4e733b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -530,6 +530,9 @@ static void __blk_mq_complete_request(struct request *rq)
>  	bool shared = false;
>  	int cpu;
>  
> +	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT);
> +	blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
> +
>  	if (rq->internal_tag != -1)
>  		blk_mq_sched_completed_request(rq);
>  	if (rq->rq_flags & RQF_STATS) {
> @@ -557,6 +560,19 @@ static void __blk_mq_complete_request(struct request *rq)
>  	put_cpu();
>  }
>  
> +static u64 blk_mq_rq_aborted_gstate(struct request *rq)
> +{
> +	unsigned int start;
> +	u64 aborted_gstate;
> +
> +	do {
> +		start = u64_stats_fetch_begin(&rq->aborted_gstate_sync);
> +		aborted_gstate = rq->aborted_gstate;
> +	} while (u64_stats_fetch_retry(&rq->aborted_gstate_sync, start));
> +
> +	return aborted_gstate;
> +}
> +
>  /**
>   * blk_mq_complete_request - end I/O on a request
>   * @rq:		the request being processed
> @@ -574,14 +590,21 @@ void blk_mq_complete_request(struct request *rq)
>  	if (unlikely(blk_should_fake_timeout(q)))
>  		return;
>  
> +	/*
> +	 * If @rq->aborted_gstate equals the current instance, timeout is
> +	 * claiming @rq and we lost.  This is synchronized through RCU.
> +	 * See blk_mq_timeout_work() for details.
> +	 */
>  	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
>  		rcu_read_lock();
> -		if (!blk_mark_rq_complete(rq))
> +		if (blk_mq_rq_aborted_gstate(rq) != rq->gstate &&
> +		    !blk_mark_rq_complete(rq))
>  			__blk_mq_complete_request(rq);
>  		rcu_read_unlock();
>  	} else {
>  		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
> -		if (!blk_mark_rq_complete(rq))
> +		if (blk_mq_rq_aborted_gstate(rq) != rq->gstate &&
> +		    !blk_mark_rq_complete(rq))
>  			__blk_mq_complete_request(rq);
>  		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
>  	}
> @@ -608,34 +631,28 @@ void blk_mq_start_request(struct request *rq)
>  		wbt_issue(q->rq_wb, &rq->issue_stat);
>  	}
>  
> -	blk_add_timer(rq);
> -
> +	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
>  	WARN_ON_ONCE(test_bit(REQ_ATOM_STARTED, &rq->atomic_flags));
>  
>  	/*
> -	 * Mark us as started and clear complete. Complete might have been
> -	 * set if requeue raced with timeout, which then marked it as
> -	 * complete. So be sure to clear complete again when we start
> -	 * the request, otherwise we'll ignore the completion event.
> +	 * Mark @rq in-flight which also advances the generation number,
> +	 * and register for timeout.  Protect with a seqcount to allow the
> +	 * timeout path to read both @rq->gstate and @rq->deadline
> +	 * coherently.
>  	 *
> -	 * Ensure that ->deadline is visible before we set STARTED, such that
> -	 * blk_mq_check_expired() is guaranteed to observe our ->deadline when
> -	 * it observes STARTED.
> +	 * This is the only place where a request is marked in-flight.  If
> +	 * the timeout path reads an in-flight @rq->gstate, the
> +	 * @rq->deadline it reads together under @rq->gstate_seq is
> +	 * guaranteed to be the matching one.
>  	 */
> -	smp_wmb();
> +	write_seqcount_begin(&rq->gstate_seq);
> +	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
> +	blk_add_timer(rq);
> +	write_seqcount_end(&rq->gstate_seq);
> +
>  	set_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
> -	if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags)) {
> -		/*
> -		 * Coherence order guarantees these consecutive stores to a
> -		 * single variable propagate in the specified order. Thus the
> -		 * clear_bit() is ordered _after_ the set bit. See
> -		 * blk_mq_check_expired().
> -		 *
> -		 * (the bits must be part of the same byte for this to be
> -		 * true).
> -		 */
> +	if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
>  		clear_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
> -	}
>  
>  	if (q->dma_drain_size && blk_rq_bytes(rq)) {
>  		/*
> @@ -668,6 +685,7 @@ static void __blk_mq_requeue_request(struct request *rq)
>  	blk_mq_sched_requeue_request(rq);
>  
>  	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
> +		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
>  		if (q->dma_drain_size && blk_rq_bytes(rq))
>  			rq->nr_phys_segments--;
>  	}
> @@ -765,6 +783,7 @@ EXPORT_SYMBOL(blk_mq_tag_to_rq);
>  struct blk_mq_timeout_data {
>  	unsigned long next;
>  	unsigned int next_set;
> +	unsigned int nr_expired;
>  };
>  
>  void blk_mq_rq_timed_out(struct request *req, bool reserved)
> @@ -792,6 +811,14 @@ void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  		__blk_mq_complete_request(req);
>  		break;
>  	case BLK_EH_RESET_TIMER:
> +		/*
> +		 * As nothing prevents from completion happening while
> +		 * ->aborted_gstate is set, this may lead to ignored
> +		 * completions and further spurious timeouts.
> +		 */
> +		u64_stats_update_begin(&req->aborted_gstate_sync);
> +		req->aborted_gstate = 0;
> +		u64_stats_update_end(&req->aborted_gstate_sync);
>  		blk_add_timer(req);
>  		blk_clear_rq_complete(req);
Test ok with NVMe

Thanks
Jianchao
