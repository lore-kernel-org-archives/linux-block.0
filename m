Subject: Re: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Bart Van Assche <bart.vanassche@sandisk.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-6-git-send-email-axboe@fb.com>
 <69c1261a-1a21-7347-c753-0bcb9a2ab65e@sandisk.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <e4928ada-c1f5-32a0-bbc4-3a1f3c83dde9@fb.com>
Date: Tue, 13 Dec 2016 08:14:46 -0700
MIME-Version: 1.0
In-Reply-To: <69c1261a-1a21-7347-c753-0bcb9a2ab65e@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/13/2016 06:56 AM, Bart Van Assche wrote:
> On 12/08/2016 09:13 PM, Jens Axboe wrote:
>> +/*
>> + * Empty set
>> + */
>> +static struct blk_mq_ops mq_sched_tag_ops = {
>> +	.queue_rq	= NULL,
>> +};
> 
> Hello Jens,
> 
> Would "static struct blk_mq_ops mq_sched_tag_ops;" have been sufficient? 
> Can this data structure be declared 'const' if the blk_mq_ops pointers 
> in struct blk_mq_tag_set and struct request_queue are also declared const?

Yes, the static should be enough to ensure that it's all zeroes. I did
have this as const, but then realized I'd have to change a few other
places too. I'll make that change, hopefully it'll just work out.

>> +struct request *blk_mq_sched_alloc_shadow_request(struct request_queue *q,
>> +						  struct blk_mq_alloc_data *data,
>> +						  struct blk_mq_tags *tags,
>> +						  atomic_t *wait_index)
>> +{
> 
> Using the word "shadow" in the function name suggests to me that there 
> is a shadow request for every request and a request for every shadow 
> request. However, my understanding from the code is that there can be 
> requests without shadow requests (for e.g. a flush) and shadow requests 
> without requests. Shouldn't the name of this function reflect that, e.g. 
> by using "sched" or "elv" in the function name instead of "shadow"?

Shadow might not be the best name. Most do have shadows though, it's
only the rare exception like the flush, that you mention. I'll see if I
can come up with a better name.

>> +struct request *
>> +blk_mq_sched_request_from_shadow(struct blk_mq_hw_ctx *hctx,
>> +				 struct request *(*get_sched_rq)(struct blk_mq_hw_ctx *))
> 
> This function dequeues a request from the I/O scheduler queue, allocates 
> a request, copies the relevant request structure members into that 
> request and makes the request refer to the shadow request. Isn't the 
> request dispatching more important than associating the request with the 
> shadow request? If so, how about making the function name reflect that?

Sure, I can update the naming. Will need to anyway, if we get rid of the
shadow naming.

>> +{
>> +	struct blk_mq_alloc_data data;
>> +	struct request *sched_rq, *rq;
>> +
>> +	data.q = hctx->queue;
>> +	data.flags = BLK_MQ_REQ_NOWAIT;
>> +	data.ctx = blk_mq_get_ctx(hctx->queue);
>> +	data.hctx = hctx;
>> +
>> +	rq = __blk_mq_alloc_request(&data, 0);
>> +	blk_mq_put_ctx(data.ctx);
>> +
>> +	if (!rq) {
>> +		blk_mq_stop_hw_queue(hctx);
>> +		return NULL;
>> +	}
>> +
>> +	sched_rq = get_sched_rq(hctx);
>> +
>> +	if (!sched_rq) {
>> +		blk_queue_enter_live(hctx->queue);
>> +		__blk_mq_free_request(hctx, data.ctx, rq);
>> +		return NULL;
>> +	}
> 
> The mq deadline scheduler calls this function with get_sched_rq == 
> __dd_dispatch_request. If __blk_mq_alloc_request() fails, shouldn't the 
> request that was removed from the scheduler queue be pushed back onto 
> that queue? Additionally, are you sure it's necessary to call 
> blk_queue_enter_live() from the error path?

If __blk_mq_alloc_request() fails, we haven't pulled a request from the
scheduler yet. The extra ref is needed because __blk_mq_alloc_request()
doesn't get a ref on the request, however __blk_mq_free_request() does
put one.

-- 
Jens Axboe
