Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block, bfq: remove batches of confusing ifdefs
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
 lucmiccio@gmail.com, bfq-iosched@googlegroups.com
References: <20171128093734.1918-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5892a41d-4677-937a-a56e-5d4554724dd6@kernel.dk>
Date: Thu, 30 Nov 2017 14:21:45 -0700
MIME-Version: 1.0
In-Reply-To: <20171128093734.1918-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/28/2017 02:37 AM, Paolo Valente wrote:
> Commit a33801e8b473 ("block, bfq: move debug blkio stats behind
> CONFIG_DEBUG_BLK_CGROUP") introduced two batches of confusing ifdefs:
> one reported in [1], plus a similar one in another function. This
> commit removes both batches, in the way suggested in [1].

Some comments below.

> +static inline void bfq_update_dispatch_stats(struct request *rq,
> +					     spinlock_t *queue_lock,
> +					     struct bfq_queue *in_serv_queue,
> +					     bool idle_timer_disabled)
> +{

Don't pass in the queue lock. The normal convention is to pass in the
queue, thus making this:

static void bfq_update_dispatch_stats(struct request_queue *q,
				      struct request *rq,
				      struct bfq_queue *in_serv_queue,
				      bool idle_timer_disabled)

which also gets rid of the inline. In general, never inline anything.
The compiler should figure it out for you. This function is way too big
to inline, plus the cost of what it's doing completely dwarfes function
call overhead.


>
> +	struct bfq_queue *bfqq = rq ? RQ_BFQQ(rq) : NULL;
>  
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
> -	bfqq = rq ? RQ_BFQQ(rq) : NULL;
>  	if (!idle_timer_disabled && !bfqq)
> -		return rq;
> +		return;
>  
>  	/*
>  	 * rq and bfqq are guaranteed to exist until this function
> @@ -3732,7 +3713,7 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	 * In addition, the following queue lock guarantees that
>  	 * bfqq_group(bfqq) exists as well.
>  	 */
> -	spin_lock_irq(hctx->queue->queue_lock);
> +	spin_lock_irq(queue_lock);
>  	if (idle_timer_disabled)
>  		/*
>  		 * Since the idle timer has been disabled,
> @@ -3751,9 +3732,37 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  		bfqg_stats_set_start_empty_time(bfqg);
>  		bfqg_stats_update_io_remove(bfqg, rq->cmd_flags);
>  	}
> -	spin_unlock_irq(hctx->queue->queue_lock);
> +	spin_unlock_irq(queue_lock);
> +}
> +#else
> +static inline void bfq_update_dispatch_stats(struct request *rq,
> +					     spinlock_t *queue_lock,
> +					     struct bfq_queue *in_serv_queue,
> +					     bool idle_timer_disabled) {}
>  #endif
>  
> +static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
> +	struct request *rq;
> +	struct bfq_queue *in_serv_queue;
> +	bool waiting_rq, idle_timer_disabled;
> +
> +	spin_lock_irq(&bfqd->lock);
> +
> +	in_serv_queue = bfqd->in_service_queue;
> +	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
> +
> +	rq = __bfq_dispatch_request(hctx);
> +
> +	idle_timer_disabled =
> +		waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
> +
> +	spin_unlock_irq(&bfqd->lock);
> +
> +	bfq_update_dispatch_stats(rq, hctx->queue->queue_lock, in_serv_queue,
> +				  idle_timer_disabled);
> +
>  	return rq;
>  }
>  
> @@ -4276,16 +4285,46 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
>  	return idle_timer_disabled;
>  }
>  
> +#if defined(CONFIG_BFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
> +static inline void bfq_update_insert_stats(struct bfq_queue *bfqq,
> +					   spinlock_t *queue_lock,
> +					   bool idle_timer_disabled,
> +					   unsigned int cmd_flags)
> +{
> +	if (!bfqq)
> +		return;
> +
> +	/*
> +	 * bfqq still exists, because it can disappear only after
> +	 * either it is merged with another queue, or the process it
> +	 * is associated with exits. But both actions must be taken by
> +	 * the same process currently executing this flow of
> +	 * instructions.
> +	 *
> +	 * In addition, the following queue lock guarantees that
> +	 * bfqq_group(bfqq) exists as well.
> +	 */
> +	spin_lock_irq(queue_lock);
> +	bfqg_stats_update_io_add(bfqq_group(bfqq), bfqq, cmd_flags);
> +	if (idle_timer_disabled)
> +		bfqg_stats_update_idle_time(bfqq_group(bfqq));
> +	spin_unlock_irq(queue_lock);
> +}
> +#else
> +static inline void bfq_update_insert_stats(struct bfq_queue *bfqq,
> +					   spinlock_t *queue_lock,
> +					   bool idle_timer_disabled,
> +					   unsigned int cmd_flags) {}
> +#endif

Ditto here, kill the inlines.

In general though, good improvement.
 

-- 
Jens Axboe
