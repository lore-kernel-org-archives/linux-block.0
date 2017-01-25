Return-Path: <hare@suse.de>
Subject: Re: [PATCH] queue stall with blk-mq-sched
To: Jens Axboe <axboe@kernel.dk>
References: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
 <762cb508-1de0-93e2-5643-3fe946428eb5@fb.com>
 <8abc2430-e1fd-bece-ad52-c6d1d482c1e0@suse.de>
 <1663de5d-cdf7-a6ed-7539-c7d1f5e98f6c@fb.com>
 <717c595a-a3a6-0508-b537-8cf9e273271e@kernel.dk>
 <8178340b-dd64-c02d-0ef2-97ad5f928dc8@suse.de>
 <2b40b443-3bd6-717a-11ba-043886780adf@suse.de>
 <6035003f-029c-6cff-c35f-4e90496cab50@suse.de>
 <be2e5182-9cd8-5fea-77ac-4efd64e869ff@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57539c5d-be3b-ab26-c6d4-a7ff554ded8b@suse.de>
Date: Wed, 25 Jan 2017 17:57:21 +0100
MIME-Version: 1.0
In-Reply-To: <be2e5182-9cd8-5fea-77ac-4efd64e869ff@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 01/25/2017 04:52 PM, Jens Axboe wrote:
> On 01/25/2017 04:10 AM, Hannes Reinecke wrote:
[ .. ]
>> Bah.
>>
>> Not quite. I'm still seeing some queues with state 'restart'.
>>
>> I've found that I need another patch on top of that:
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e872555..edcbb44 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -753,8 +754,10 @@ static void blk_mq_timeout_work(struct work_struct
>> *work)
>>
>>                 queue_for_each_hw_ctx(q, hctx, i) {
>>                         /* the hctx may be unmapped, so check it here */
>> -                       if (blk_mq_hw_queue_mapped(hctx))
>> +                       if (blk_mq_hw_queue_mapped(hctx)) {
>>                                 blk_mq_tag_idle(hctx);
>> +                               blk_mq_sched_restart(hctx);
>> +                       }
>>                 }
>>         }
>>         blk_queue_exit(q);
>>
>>
>> Reasoning is that in blk_mq_get_tag() we might end up scheduling the
>> request on another hctx, but the original hctx might still have the
>> SCHED_RESTART bit set.
>> Which will never cleared as we complete the request on a different hctx,
>> so anything we do on the end_request side won't do us any good.
>
> I think you are right, it'll potentially trigger with shared tags and
> multiple hardware queues. I'll debug this today and come up with a
> decent fix.
>
> I committed the previous patch, fwiw.
>
THX.

The above patch _does_ help in the sense that my testcase now completes 
without stalls. And I even get a decent performance with the mq-sched 
fixes: 82k IOPs sequential read with mq-deadline as compared to 44k IOPs 
when running without I/O scheduling.
Still some way off from the 132k IOPs I'm getting with CFQ, but we're 
getting there.

However, I do get a noticeable stall during the stonewall sequence 
before the timeout handler kicks in, so the must be a better way for 
handling this.

But nevertheless, thanks for all your work here.
Very much appreciated.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
