Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v5] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 stable@vger.kernel.org
References: <20180410210157.30477-1-bart.vanassche@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <255b84ff-3fe5-1269-70a8-3ab5cc89c1ef@grimberg.me>
Date: Wed, 11 Apr 2018 16:19:18 +0300
MIME-Version: 1.0
In-Reply-To: <20180410210157.30477-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>   static void __blk_mq_requeue_request(struct request *rq)
>   {
>   	struct request_queue *q = rq->q;
> +	enum mq_rq_state old_state = blk_mq_rq_state(rq);
>   
>   	blk_mq_put_driver_tag(rq);
>   
>   	trace_block_rq_requeue(q, rq);
>   	wbt_requeue(q->rq_wb, &rq->issue_stat);
>   
> -	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
> -		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
> +	if (old_state != MQ_RQ_IDLE) {
> +		if (!blk_mq_change_rq_state(rq, old_state, MQ_RQ_IDLE))
> +			WARN_ON_ONCE(true);
>   		if (q->dma_drain_size && blk_rq_bytes(rq))
>   			rq->nr_phys_segments--;
>   	}

Can you explain why was old_state kept as a local variable?

> +static inline bool blk_mq_change_rq_state(struct request *rq,
> +					  enum mq_rq_state old_state,
> +					  enum mq_rq_state new_state)
>   {
> -	u64 old_val = READ_ONCE(rq->gstate);
> -	u64 new_val = (old_val & ~MQ_RQ_STATE_MASK) | state;
> -
> -	if (state == MQ_RQ_IN_FLIGHT) {
> -		WARN_ON_ONCE((old_val & MQ_RQ_STATE_MASK) != MQ_RQ_IDLE);
> -		new_val += MQ_RQ_GEN_INC;
> -	}
> +	unsigned long old_val = (READ_ONCE(rq->__deadline) & ~RQ_STATE_MASK) |
> +				old_state;
> +	unsigned long new_val = (old_val & ~RQ_STATE_MASK) | new_state;
>   
> -	/* avoid exposing interim values */
> -	WRITE_ONCE(rq->gstate, new_val);
> +	return cmpxchg(&rq->__deadline, old_val, new_val) == old_val;
>   }

Can you explain why this takes the old_state of the request?

Otherwise this looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
