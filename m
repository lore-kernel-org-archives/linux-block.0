Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-6-git-send-email-axboe@fb.com>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <d013a3c6-39d8-725a-6752-6a02b5284242@sandisk.com>
Date: Tue, 13 Dec 2016 15:29:18 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-6-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> +static inline void blk_mq_sched_put_request(struct request *rq)
> +{
> +	struct request_queue *q = rq->q;
> +	struct elevator_queue *e = q->elevator;
> +
> +	if (e && e->type->mq_ops.put_request)
> +		e->type->mq_ops.put_request(rq);
> +	else
> +		blk_mq_free_request(rq);
> +}

blk_mq_free_request() always triggers a call of blk_queue_exit(). 
dd_put_request() only triggers a call of blk_queue_exit() if it is not a 
shadow request. Is that on purpose?

> +static inline struct request *
> +blk_mq_sched_get_request(struct request_queue *q, unsigned int op,
> +			 struct blk_mq_alloc_data *data)
> +{
> +	struct elevator_queue *e = q->elevator;
> +	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_ctx *ctx;
> +	struct request *rq;
> +
> +	blk_queue_enter_live(q);
> +	ctx = blk_mq_get_ctx(q);
> +	hctx = blk_mq_map_queue(q, ctx->cpu);
> +
> +	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
> +
> +	if (e && e->type->mq_ops.get_request)
> +		rq = e->type->mq_ops.get_request(q, op, data);
> +	else
> +		rq = __blk_mq_alloc_request(data, op);
> +
> +	if (rq)
> +		data->hctx->queued++;
> +
> +	return rq;
> +
> +}

Some but not all callers of blk_mq_sched_get_request() call 
blk_queue_exit() if this function returns NULL. Please consider to move 
the blk_queue_exit() call from the blk_mq_alloc_request() error path 
into this function. I think that will make it a lot easier to verify 
whether or not the blk_queue_enter() / blk_queue_exit() calls are 
balanced properly.

Additionally, since blk_queue_enter() / blk_queue_exit() calls by 
blk_mq_sched_get_request() and blk_mq_sched_put_request() must be 
balanced and since the latter function only calls blk_queue_exit() for 
non-shadow requests, shouldn't blk_mq_sched_get_request() call 
blk_queue_enter_live() only if __blk_mq_alloc_request() is called?

Thanks,

Bart.
