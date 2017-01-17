Return-Path: <prvs=2190b29283=axboe@fb.com>
Subject: Re: [PATCH 6/8] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-7-git-send-email-axboe@fb.com>
 <9936D33B-AE98-46DF-B1DA-D54142A338FD@linaro.org>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Linux-Kernal
	<linux-kernel@vger.kernel.org>, <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <c36a39ee-d0af-017e-590a-bf5d5ede065c@fb.com>
Date: Mon, 16 Jan 2017 18:47:22 -0800
MIME-Version: 1.0
In-Reply-To: <9936D33B-AE98-46DF-B1DA-D54142A338FD@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 12/22/2016 02:59 AM, Paolo Valente wrote:
> 
>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> This adds a set of hooks that intercepts the blk-mq path of
>> allocating/inserting/issuing/completing requests, allowing
>> us to develop a scheduler within that framework.
>>
>> We reuse the existing elevator scheduler API on the registration
>> side, but augment that with the scheduler flagging support for
>> the blk-mq interfce, and with a separate set of ops hooks for MQ
>> devices.
>>
>> Schedulers can opt in to using shadow requests. Shadow requests
>> are internal requests that the scheduler uses for for the allocate
>> and insert part, which are then mapped to a real driver request
>> at dispatch time. This is needed to separate the device queue depth
>> from the pool of requests that the scheduler has to work with.
>>
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>>
> ...
> 
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> new file mode 100644
>> index 000000000000..b7e1839d4785
>> --- /dev/null
>> +++ b/block/blk-mq-sched.c
> 
>> ...
>> +static inline bool
>> +blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
>> +			 struct bio *bio)
>> +{
>> +	struct elevator_queue *e = q->elevator;
>> +
>> +	if (e && e->type->ops.mq.allow_merge)
>> +		return e->type->ops.mq.allow_merge(q, rq, bio);
>> +
>> +	return true;
>> +}
>> +
> 
> Something does not seem to add up here:
> e->type->ops.mq.allow_merge may be called only in
> blk_mq_sched_allow_merge, which, in its turn, may be called only in
> blk_mq_attempt_merge, which, finally, may be called only in
> blk_mq_merge_queue_io.  Yet the latter may be called only if there is
> no elevator (line 1399 and 1507 in blk-mq.c).
> 
> Therefore, e->type->ops.mq.allow_merge can never be called, both if
> there is and if there is not an elevator.  Be patient if I'm missing
> something huge, but I thought it was worth reporting this.

I went through the current branch, and it seems mostly fine. There was
a double call to allow_merge() that I killed in the plug path, and one
set missing in blk_mq_sched_try_merge(). The rest looks OK.

-- 
Jens Axboe
