Return-Path: <keith.busch@intel.com>
Date: Wed, 23 May 2018 08:02:32 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180523140231.GA9028@localhost.localdomain>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522162515.20650-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 09:25:15AM -0700, Bart Van Assche wrote:
> +static bool blk_mq_change_rq_state(struct request *rq,
> +				   enum mq_rq_state old_state,
> +				   enum mq_rq_state new_state)
> +{
> +	union blk_generation_and_state gstate = READ_ONCE(rq->gstate);
> +	union blk_generation_and_state old_val = gstate;
> +	union blk_generation_and_state new_val = gstate;
> +
> +	old_val.state = old_state;
> +	new_val.state = new_state;
> +	if (new_state == MQ_RQ_IN_FLIGHT)
> +		new_val.generation++;
> +	/*
> +	 * For transitions from state in-flight to another state cmpxchg()
> +	 * must be used. For other state transitions it is safe to use
> +	 * WRITE_ONCE().
> +	 */
> +	if (old_state != MQ_RQ_IN_FLIGHT) {
> +		WRITE_ONCE(rq->gstate.val, new_val.val);
> +		return true;
> +	}
> +	return blk_mq_set_rq_state(rq, old_val, new_val);
> +}

<snip>

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
> -		__blk_mq_complete_request(rq);
> -	hctx_unlock(hctx, srcu_idx);
> +	/* The loop is for the unlikely case of a race with the timeout code. */
> +	while (true) {
> +		if (blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT,
> +					   MQ_RQ_COMPLETE)) {
> +			__blk_mq_complete_request(rq);
> +			break;
> +		}
> +		if (blk_mq_change_rq_state(rq, MQ_RQ_TIMED_OUT, MQ_RQ_COMPLETE))
> +			break;
> +	}
>  }

Looks like the cmpxchg is also needed if old_state is MQ_RQ_TIMED_OUT,
otherwise its guaranteed to return 'true' and there's no point to the
loop and 'if' check.
