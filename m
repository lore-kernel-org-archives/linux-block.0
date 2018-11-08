Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: provide a helper to check if a queue is busy
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20181108160609.27568-1-axboe@kernel.dk>
 <20181108160609.27568-4-axboe@kernel.dk>
 <1541694626.196084.220.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7d4e0553-93d8-6b71-0359-2e463e32e0cc@kernel.dk>
Date: Thu, 8 Nov 2018 09:32:21 -0700
MIME-Version: 1.0
In-Reply-To: <1541694626.196084.220.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 11/8/18 9:30 AM, Bart Van Assche wrote:
> On Thu, 2018-11-08 at 09:06 -0700, Jens Axboe wrote:
>> +static bool blk_mq_check_busy(struct blk_mq_hw_ctx *hctx, struct request *rq,
>> +			      void *priv, bool reserved)
>> +{
>> +	/*
>> +	 * If we find a request, we know the queue is busy. Return false
>> +	 * to stop the iteration.
>> +	 */
>> +	if (rq->q == hctx->queue) {
>> +		bool *busy = (bool *) priv;
> 
> I think the "(bool *)" cast can be left out. Anyway:

It can, I'll drop it.

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks

-- 
Jens Axboe
