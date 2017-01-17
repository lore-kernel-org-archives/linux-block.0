Subject: Re: [PATCH 6/8] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-7-git-send-email-axboe@fb.com>
 <9936D33B-AE98-46DF-B1DA-D54142A338FD@linaro.org>
 <A117E4ED-1D8B-452F-9EF3-44E7714B5C75@linaro.org>
 <8d900827-3569-b695-86d6-3cfe27884d6a@fb.com>
 <91E04322-8248-48E6-A4F6-FD4914A31BFF@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <1854448c-a7bb-e9a9-cfda-5c301429b301@fb.com>
Date: Tue, 17 Jan 2017 04:38:40 -0800
MIME-Version: 1.0
In-Reply-To: <91E04322-8248-48E6-A4F6-FD4914A31BFF@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/17/2017 02:13 AM, Paolo Valente wrote:
> 
>> Il giorno 17 gen 2017, alle ore 03:47, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> On 12/22/2016 04:13 AM, Paolo Valente wrote:
>>>
>>>> Il giorno 22 dic 2016, alle ore 10:59, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>>>
>>>>>
>>>>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
>>>>>
>>>>> This adds a set of hooks that intercepts the blk-mq path of
>>>>> allocating/inserting/issuing/completing requests, allowing
>>>>> us to develop a scheduler within that framework.
>>>>>
>>>>> We reuse the existing elevator scheduler API on the registration
>>>>> side, but augment that with the scheduler flagging support for
>>>>> the blk-mq interfce, and with a separate set of ops hooks for MQ
>>>>> devices.
>>>>>
>>>>> Schedulers can opt in to using shadow requests. Shadow requests
>>>>> are internal requests that the scheduler uses for for the allocate
>>>>> and insert part, which are then mapped to a real driver request
>>>>> at dispatch time. This is needed to separate the device queue depth
>>>>> from the pool of requests that the scheduler has to work with.
>>>>>
>>>>> Signed-off-by: Jens Axboe <axboe@fb.com>
>>>>>
>>>> ...
>>>>
>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>>>> new file mode 100644
>>>>> index 000000000000..b7e1839d4785
>>>>> --- /dev/null
>>>>> +++ b/block/blk-mq-sched.c
>>>>
>>>>> ...
>>>>> +static inline bool
>>>>> +blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
>>>>> +			 struct bio *bio)
>>>>> +{
>>>>> +	struct elevator_queue *e = q->elevator;
>>>>> +
>>>>> +	if (e && e->type->ops.mq.allow_merge)
>>>>> +		return e->type->ops.mq.allow_merge(q, rq, bio);
>>>>> +
>>>>> +	return true;
>>>>> +}
>>>>> +
>>>>
>>>> Something does not seem to add up here:
>>>> e->type->ops.mq.allow_merge may be called only in
>>>> blk_mq_sched_allow_merge, which, in its turn, may be called only in
>>>> blk_mq_attempt_merge, which, finally, may be called only in
>>>> blk_mq_merge_queue_io.  Yet the latter may be called only if there is
>>>> no elevator (line 1399 and 1507 in blk-mq.c).
>>>>
>>>> Therefore, e->type->ops.mq.allow_merge can never be called, both if
>>>> there is and if there is not an elevator.  Be patient if I'm missing
>>>> something huge, but I thought it was worth reporting this.
>>>>
>>>
>>> Just another detail: if e->type->ops.mq.allow_merge does get invoked
>>> from the above path, then it is invoked of course without the
>>> scheduler lock held.  In contrast, if this function gets invoked
>>> from dd_bio_merge, then the scheduler lock is held.
>>
>> But the scheduler controls that itself. So it'd be perfectly fine to
>> have a locked and unlocked variant. The way that's typically done is to
>> have function() grabbing the lock, and __function() is invoked with the
>> lock held.
>>
>>> To handle this opposite alternatives, I don't know whether checking if
>>> the lock is held (and possibly taking it) from inside
>>> e->type->ops.mq.allow_merge is a good solution.  In any case, before
>>> possibly trying it, I will wait for some feedback on the main problem,
>>> i.e., on the fact that e->type->ops.mq.allow_merge
>>> seems unreachable in the above path.
>>
>> Checking if a lock is held is NEVER a good idea, as it leads to both bad
>> and incorrect code. If you just check if a lock is held when being
>> called, you don't necessarily know if it was the caller that grabbed it
>> or it just happens to be held by someone else for unrelated reasons.
>>
>>
> 
> Thanks a lot for this and the above explanations.  Unfortunately, I
> still see the problem.  To hopefully make you waste less time, I have
> reported the problematic paths explicitly, so that you can quickly
> point me to my mistake.
> 
> The problem is caused by the existence of at least the following two
> alternative paths to e->type->ops.mq.allow_merge.
> 
> 1.  In mq-deadline.c (line 374): spin_lock(&dd->lock);
> blk_mq_sched_try_merge -> elv_merge -> elv_bio_merge_ok ->
> elv_iosched_allow_bio_merge -> e->type->ops.mq.allow_merge
> 
> 2. In blk-core.c (line 1660): spin_lock_irq(q->queue_lock);
> elv_merge -> elv_bio_merge_ok ->
> elv_iosched_allow_bio_merge -> e->type->ops.mq.allow_merge
> 
> In the first path, the scheduler lock is held, while in the second
> path, it is not.  This does not cause problems with mq-deadline,
> because the latter just has no allow_merge function.  Yet it does
> cause problems with the allow_merge implementation of bfq.  There was
> no issue in blk, as only the global queue lock was used.
> 
> Where am I wrong?

#2 can never happen for blk-mq, it's the old IO path. blk-mq is never
invoked with ->queue_lock held.

-- 
Jens Axboe
