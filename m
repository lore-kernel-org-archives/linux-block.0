Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] queue stall with blk-mq-sched
To: Hannes Reinecke <hare@suse.de>
References: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
 <762cb508-1de0-93e2-5643-3fe946428eb5@fb.com>
 <8abc2430-e1fd-bece-ad52-c6d1d482c1e0@suse.de>
 <1663de5d-cdf7-a6ed-7539-c7d1f5e98f6c@fb.com>
 <717c595a-a3a6-0508-b537-8cf9e273271e@kernel.dk>
 <8178340b-dd64-c02d-0ef2-97ad5f928dc8@suse.de>
 <2b40b443-3bd6-717a-11ba-043886780adf@suse.de>
 <6035003f-029c-6cff-c35f-4e90496cab50@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <be2e5182-9cd8-5fea-77ac-4efd64e869ff@kernel.dk>
Date: Wed, 25 Jan 2017 08:52:52 -0700
MIME-Version: 1.0
In-Reply-To: <6035003f-029c-6cff-c35f-4e90496cab50@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/25/2017 04:10 AM, Hannes Reinecke wrote:
> On 01/25/2017 09:07 AM, Hannes Reinecke wrote:
>> On 01/25/2017 08:39 AM, Hannes Reinecke wrote:
>>> On 01/24/2017 11:06 PM, Jens Axboe wrote:
>>>> On 01/24/2017 12:55 PM, Jens Axboe wrote:
>>>>> Try this patch. We only want to bump it for the driver tags, not the
>>>>> scheduler side.
>>>>
>>>> More complete version, this one actually tested. I think this should fix
>>>> your issue, let me know.
>>>>
>>> Nearly there.
>>> The initial stall is gone, but the test got hung at the 'stonewall'
>>> sequence again:
>>>
>>> [global]
>>> bs=4k
>>> ioengine=libaio
>>> iodepth=256
>>> size=4g
>>> direct=1
>>> runtime=60
>>> # directory=/mnt
>>> numjobs=32
>>> group_reporting
>>> cpus_allowed_policy=split
>>> filename=/dev/md127
>>>
>>> [seq-read]
>>> rw=read
>>> -> stonewall
>>>
>>> [rand-read]
>>> rw=randread
>>> stonewall
>>>
>>> Restarting all queues made the fio job continue.
>>> There were 4 queues with state 'restart', and one queue with state 'active'.
>>> So we're missing a queue run somewhere.
>>>
>> I've found the queue stalls are gone with this patch:
>>
>> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
>> index 6b465bc..de5db6c 100644
>> --- a/block/blk-mq-sched.h
>> +++ b/block/blk-mq-sched.h
>> @@ -113,6 +113,15 @@ static inline void blk_mq_sched_put_rq_priv(struct
>> request_queue *q,
>>  }
>>
>>  static inline void
>> +blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>> +{
>> +       if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
>> +               clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
>> +               blk_mq_run_hw_queue(hctx, true);
>> +       }
>> +}
>> +
>> +static inline void
>>  blk_mq_sched_completed_request(struct blk_mq_hw_ctx *hctx, struct
>> request *rq)
>>  {
>>         struct elevator_queue *e = hctx->queue->elevator;
>> @@ -123,11 +132,6 @@ static inline void blk_mq_sched_put_rq_priv(struct
>> request_queue *q,
>>         BUG_ON(rq->internal_tag == -1);
>>
>>         blk_mq_put_tag(hctx, hctx->sched_tags, rq->mq_ctx,
>> rq->internal_tag);
>> -
>> -       if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
>> -               clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
>> -               blk_mq_run_hw_queue(hctx, true);
>> -       }
>>  }
>>
>>  static inline void blk_mq_sched_started_request(struct request *rq)
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e872555..63799ad 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -345,6 +345,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx
>> *hctx, struct blk_mq_ctx *ctx,
>>                 blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
>>         if (sched_tag != -1)
>>                 blk_mq_sched_completed_request(hctx, rq);
>> +       blk_mq_sched_restart(hctx);
>>         blk_queue_exit(q);
>>  }
>>
> Bah.
> 
> Not quite. I'm still seeing some queues with state 'restart'.
> 
> I've found that I need another patch on top of that:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e872555..edcbb44 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -753,8 +754,10 @@ static void blk_mq_timeout_work(struct work_struct
> *work)
> 
>                 queue_for_each_hw_ctx(q, hctx, i) {
>                         /* the hctx may be unmapped, so check it here */
> -                       if (blk_mq_hw_queue_mapped(hctx))
> +                       if (blk_mq_hw_queue_mapped(hctx)) {
>                                 blk_mq_tag_idle(hctx);
> +                               blk_mq_sched_restart(hctx);
> +                       }
>                 }
>         }
>         blk_queue_exit(q);
> 
> 
> Reasoning is that in blk_mq_get_tag() we might end up scheduling the
> request on another hctx, but the original hctx might still have the
> SCHED_RESTART bit set.
> Which will never cleared as we complete the request on a different hctx,
> so anything we do on the end_request side won't do us any good.

I think you are right, it'll potentially trigger with shared tags and
multiple hardware queues. I'll debug this today and come up with a
decent fix.

I committed the previous patch, fwiw.

-- 
Jens Axboe
