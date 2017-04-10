Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] blk-mq: unify hctx delay_work and run_work
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
 <1491839696-24783-4-git-send-email-axboe@fb.com>
 <1491841316.4199.12.camel@sandisk.com>
 <54caf130-6a6c-ca81-1b58-dd413079fcf2@fb.com>
Cc: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5f5922d6-d51a-c5e4-33d3-b2aef807b1e6@kernel.dk>
Date: Mon, 10 Apr 2017 11:23:04 -0600
MIME-Version: 1.0
In-Reply-To: <54caf130-6a6c-ca81-1b58-dd413079fcf2@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/10/2017 10:53 AM, Jens Axboe wrote:
> On 04/10/2017 10:21 AM, Bart Van Assche wrote:
>> On Mon, 2017-04-10 at 09:54 -0600, Jens Axboe wrote:
>>> @@ -1281,27 +1280,39 @@ static void blk_mq_run_work_fn(struct work_struct *work)
>>>  	struct blk_mq_hw_ctx *hctx;
>>>  
>>>  	hctx = container_of(work, struct blk_mq_hw_ctx, run_work.work);
>>> -	__blk_mq_run_hw_queue(hctx);
>>> -}
>>>  
>>> -static void blk_mq_delay_work_fn(struct work_struct *work)
>>> -{
>>> -	struct blk_mq_hw_ctx *hctx;
>>> +	/*
>>> +	 * If we are stopped, don't run the queue. The exception is if
>>> +	 * BLK_MQ_S_START_ON_RUN is set. For that case, we auto-clear
>>> +	 * the STOPPED bit and run it.
>>> +	 */
>>> +	if (test_bit(BLK_MQ_S_STOPPED, &hctx->state)) {
>>> +		if (!test_bit(BLK_MQ_S_START_ON_RUN, &hctx->state))
>>> +			return;
>>>  
>>> -	hctx = container_of(work, struct blk_mq_hw_ctx, delay_work.work);
>>> +		clear_bit(BLK_MQ_S_START_ON_RUN, &hctx->state);
>>> +		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
>>> +	}
>>>  
>>> -	if (test_and_clear_bit(BLK_MQ_S_STOPPED, &hctx->state))
>>> -		__blk_mq_run_hw_queue(hctx);
>>> +	__blk_mq_run_hw_queue(hctx);
>>>  }
>>>  
>>> +
>>>  void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
>>>  {
>>>  	if (unlikely(!blk_mq_hw_queue_mapped(hctx)))
>>>  		return;
>>>  
>>> +	/*
>>> +	 * Stop the hw queue, then modify currently delayed work.
>>> +	 * This should prevent us from running the queue prematurely.
>>> +	 * Mark the queue as auto-clearing STOPPED when it runs.
>>> +	 */
>>>  	blk_mq_stop_hw_queue(hctx);
>>> -	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
>>> -			&hctx->delay_work, msecs_to_jiffies(msecs));
>>> +	set_bit(BLK_MQ_S_START_ON_RUN, &hctx->state);
>>> +	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
>>> +					&hctx->run_work,
>>> +					msecs_to_jiffies(msecs));
>>>  }
>>>  EXPORT_SYMBOL(blk_mq_delay_queue);
>>
>> Hello Jens,
>>
>> Is it possible for a block driver to call blk_mq_delay_queue() while
>> blk_mq_delay_work_fn() is running? Can that result in BLK_MQ_S_STOPPED
>> and BLK_MQ_S_START_ON_RUN being checked by blk_mq_delay_work_fn() after
>> blk_mq_delay_queue() has set BLK_MQ_S_STOPPED and before it has set
>> BLK_MQ_S_START_ON_RUN?
> 
> Yeah, I don't think it's bullet proof. I just looked at the in-kernel
> users, and there's just one, nvme/fc.c. And it looks really buggy,
> since it manually stops _all_ queues, then delays the one hw queue.
> So we'll end up with potentially a bunch of stopped queues, and only
> one getting restarted.
> 
> I think for blk_mq_delay_queue(), what we really care about is "this
> queue has to run again sometime in the future". If that happens
> much sooner than asked for, that's OK, the caller will just delay
> again if it needs it. For most cases, we'll be close.
> 
> Obviously we can't have ordering issues and end up in a bad state,
> we have to prevent that.
> 
> I'll fiddle with this a bit more.

Spent a bit of time looking at the workqueue code. Looks like we're
guaranteed that we'll have at least one run of the handler after
calling kblockd_mod_delayed_work_on(). If the handler is currently
running, the we will sucessfully queue a new invocation. That's the
troublesome case. If it's not currently running, we just push the run
sometime into the future. In both cases, we know it'll run _after_
setting BLK_MQ_S_START_ON_RUN, which is the important part.

Hence I think the patch is fine as-is. Let me know if you disagree!

-- 
Jens Axboe
