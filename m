Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: only run the hardware queue if IO is pending
To: Omar Sandoval <osandov@osandov.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b1c29434-929d-a8aa-7181-b0b90607ede1@kernel.dk>
 <20171110222825.GB5449@vader.DHCP.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <21e778e1-cd04-c503-3384-d6569efb30c1@kernel.dk>
Date: Fri, 10 Nov 2017 15:31:43 -0700
MIME-Version: 1.0
In-Reply-To: <20171110222825.GB5449@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/10/2017 03:28 PM, Omar Sandoval wrote:
> On Fri, Nov 10, 2017 at 09:12:18AM -0700, Jens Axboe wrote:
>> Currently we are inconsistent in when we decide to run the queue. Using
>> blk_mq_run_hw_queues() we check if the hctx has pending IO before
>> running it, but we don't do that from the individual queue run function,
>> blk_mq_run_hw_queue(). This results in a lot of extra and pointless
>> queue runs, potentially, on flush requests and (much worse) on tag
>> starvation situations. This is observable just looking at the top
>> output, with lots of kworkers active. For the !async runs, it just adds
>> to the CPU overhead of blk-mq.
>>
>> Move the has-pending check into the run function instead of having
>> callers do it.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 6f4bdb8209f7..c117bd8fd1f6 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -81,12 +81,7 @@ static bool blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
>>  	} else
>>  		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
>>  
>> -	if (blk_mq_hctx_has_pending(hctx)) {
>> -		blk_mq_run_hw_queue(hctx, true);
>> -		return true;
>> -	}
>> -
>> -	return false;
>> +	return blk_mq_run_hw_queue(hctx, true);
>>  }
>>  
>>  /*
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index bfe24a5b62a3..a2a4271f5ab8 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -61,10 +61,10 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
>>  /*
>>   * Check if any of the ctx's have pending work in this hardware queue
>>   */
>> -bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
>> +static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
>>  {
>> -	return sbitmap_any_bit_set(&hctx->ctx_map) ||
>> -			!list_empty_careful(&hctx->dispatch) ||
>> +	return !list_empty_careful(&hctx->dispatch) ||
>> +		sbitmap_any_bit_set(&hctx->ctx_map) ||
>>  			blk_mq_sched_has_work(hctx);
>>  }
>>  
>> @@ -1253,9 +1253,14 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
>>  }
>>  EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>>  
>> -void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>> +bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>>  {
>> -	__blk_mq_delay_run_hw_queue(hctx, async, 0);
>> +	if (blk_mq_hctx_has_pending(hctx)) {
>> +		__blk_mq_delay_run_hw_queue(hctx, async, 0);
>> +		return true;
>> +	}
>> +
>> +	return false;
>>  }
>>  EXPORT_SYMBOL(blk_mq_run_hw_queue);
>>  
>> @@ -1265,8 +1270,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
>>  	int i;
>>  
>>  	queue_for_each_hw_ctx(q, hctx, i) {
>> -		if (!blk_mq_hctx_has_pending(hctx) ||
>> -		    blk_mq_hctx_stopped(hctx))
>> +		if (blk_mq_hctx_stopped(hctx))
>>  			continue;
>>  
>>  		blk_mq_run_hw_queue(hctx, async);
> 
> Minor cosmetic point, I find this double-negative thing confusing,
> how about:
> 
> 	queue_for_each_hw_ctx(q, hctx, i) {
> 		if (!blk_mq_hctx_stopped(hctx))
> 			blk_mq_run_hw_queue(hctx, async);

Really? It's an easier read for me - if stopped, continue. Then run after that.
!stopped seems like more of a double negative :-)

> Other than that,
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>

Thanks for the review!

-- 
Jens Axboe
