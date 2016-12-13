Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-6-git-send-email-axboe@fb.com>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <69c1261a-1a21-7347-c753-0bcb9a2ab65e@sandisk.com>
Date: Tue, 13 Dec 2016 14:56:56 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-6-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> +/*
> + * Empty set
> + */
> +static struct blk_mq_ops mq_sched_tag_ops = {
> +	.queue_rq	= NULL,
> +};

Hello Jens,

Would "static struct blk_mq_ops mq_sched_tag_ops;" have been sufficient? 
Can this data structure be declared 'const' if the blk_mq_ops pointers 
in struct blk_mq_tag_set and struct request_queue are also declared const?

> +struct request *blk_mq_sched_alloc_shadow_request(struct request_queue *q,
> +						  struct blk_mq_alloc_data *data,
> +						  struct blk_mq_tags *tags,
> +						  atomic_t *wait_index)
> +{

Using the word "shadow" in the function name suggests to me that there 
is a shadow request for every request and a request for every shadow 
request. However, my understanding from the code is that there can be 
requests without shadow requests (for e.g. a flush) and shadow requests 
without requests. Shouldn't the name of this function reflect that, e.g. 
by using "sched" or "elv" in the function name instead of "shadow"?

> +struct request *
> +blk_mq_sched_request_from_shadow(struct blk_mq_hw_ctx *hctx,
> +				 struct request *(*get_sched_rq)(struct blk_mq_hw_ctx *))

This function dequeues a request from the I/O scheduler queue, allocates 
a request, copies the relevant request structure members into that 
request and makes the request refer to the shadow request. Isn't the 
request dispatching more important than associating the request with the 
shadow request? If so, how about making the function name reflect that?

> +{
> +	struct blk_mq_alloc_data data;
> +	struct request *sched_rq, *rq;
> +
> +	data.q = hctx->queue;
> +	data.flags = BLK_MQ_REQ_NOWAIT;
> +	data.ctx = blk_mq_get_ctx(hctx->queue);
> +	data.hctx = hctx;
> +
> +	rq = __blk_mq_alloc_request(&data, 0);
> +	blk_mq_put_ctx(data.ctx);
> +
> +	if (!rq) {
> +		blk_mq_stop_hw_queue(hctx);
> +		return NULL;
> +	}
> +
> +	sched_rq = get_sched_rq(hctx);
> +
> +	if (!sched_rq) {
> +		blk_queue_enter_live(hctx->queue);
> +		__blk_mq_free_request(hctx, data.ctx, rq);
> +		return NULL;
> +	}

The mq deadline scheduler calls this function with get_sched_rq == 
__dd_dispatch_request. If __blk_mq_alloc_request() fails, shouldn't the 
request that was removed from the scheduler queue be pushed back onto 
that queue? Additionally, are you sure it's necessary to call 
blk_queue_enter_live() from the error path?

Bart.
