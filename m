Return-Path: <prvs=1162d78414=axboe@fb.com>
Subject: Re: [PATCH 6/8] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-7-git-send-email-axboe@fb.com>
 <4A1753A0-121C-4A01-8821-6CDD99C98896@linaro.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <24dc9b88-f846-f6e2-0568-f5b612575651@fb.com>
Date: Tue, 20 Dec 2016 08:45:16 -0700
MIME-Version: 1.0
In-Reply-To: <4A1753A0-121C-4A01-8821-6CDD99C98896@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 12/20/2016 04:55 AM, Paolo Valente wrote:
>> +struct request *blk_mq_sched_get_request(struct request_queue *q,
>> +					 struct bio *bio,
>> +					 unsigned int op,
>> +					 struct blk_mq_alloc_data *data)
>> +{
>> +	struct elevator_queue *e = q->elevator;
>> +	struct blk_mq_hw_ctx *hctx;
>> +	struct blk_mq_ctx *ctx;
>> +	struct request *rq;
>> +
>> +	blk_queue_enter_live(q);
>> +	ctx = blk_mq_get_ctx(q);
>> +	hctx = blk_mq_map_queue(q, ctx->cpu);
>> +
>> +	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
>> +
>> +	if (e && e->type->ops.mq.get_request)
>> +		rq = e->type->ops.mq.get_request(q, op, data);
> 
> bio is not passed to the scheduler here.  Yet bfq uses bio to get the
> blkcg (invoking bio_blkcg).  I'm not finding any workaround.

One important note here - what I'm posting is a work in progress, it's
by no means set in stone. So when you find missing items like this, feel
free to fix them up and send a patch. I will then fold in that patch. Or
if you don't feel comfortable fixing it up, let me know, and I'll fix it
up next time I touch it.

>> +	else
>> +		rq = __blk_mq_alloc_request(data, op);
>> +
>> +	if (rq) {
>> +		rq->elv.icq = NULL;
>> +		if (e && e->type->icq_cache)
>> +			blk_mq_sched_assign_ioc(q, rq, bio);
> 
> bfq needs rq->elv.icq to be consistent in bfq_get_request, but the
> needed initialization seems to occur only after mq.get_request is
> invoked.
> 
> Note: to minimize latency, I'm reporting immediately each problem that
> apparently cannot be solved by just modifying bfq.  But, if the
> resulting higher number of micro-emails is annoying for you, I can
> buffer my questions, and send you cumulative emails less frequently.

That's perfectly fine, I prefer knowing earlier rather than later. But
do also remember that it's fine to send a patch to fix those things up,
you don't have to wait for me.

-- 
Jens Axboe
