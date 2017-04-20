Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-sched: add might_sleep() check for flush/fua
 insert
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <cd6d3a9a-8f6d-1cf8-6379-51de69544c1d@kernel.dk>
 <1492729028.2642.16.camel@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a31e70b9-0a9a-44bc-fefa-ac317b4e095b@kernel.dk>
Date: Thu, 20 Apr 2017 17:09:42 -0600
MIME-Version: 1.0
In-Reply-To: <1492729028.2642.16.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 04:57 PM, Bart Van Assche wrote:
> On Thu, 2017-04-20 at 16:45 -0600, Jens Axboe wrote:
>> If we're doing a flush/fua insert, insertion might block on getting
>> a driver tag, if can_block == true. Add a might_sleep check for that,
>> since we just had a bug like that. This will help us catch a similar
>> issue quicker in the future.
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 9e3c0f92851b..57aec8462e93 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -372,6 +372,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
>>  	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
>>  
>>  	if (rq->tag == -1 && op_is_flush(rq->cmd_flags)) {
>> +		might_sleep_if(can_block);
>>  		blk_mq_sched_insert_flush(hctx, rq, can_block);
>>  		return;
>>  	}
> 
> Hello Jens,
> 
> The above patch looks fine to me. But seeing that patch made me wonder
> whether it would be useful to move that might_sleep_if() call into
> blk_mq_get_driver_tag() such that if ever an additional call to
> blk_mq_get_driver_tag() is added that might sleep would also be covered?

Yes, that's not a bad suggestion. Below:

From: Jens Axboe <axboe@fb.com>
Subject: [PATCH] blk-mq: add might_sleep check to blk_mq_get_driver_tag()

If the caller passes in wait=true, it has to be able to block
for a driver tag. We just had a bug where flush insertion
would block on tag allocation, while we had preempt disabled.
Ensure that we catch cases like that earlier next time.

Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 992f09772f8a..dd6e5dd62804 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -866,6 +866,8 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 		.flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
 	};
 
+	might_sleep_if(wait);
+
 	if (rq->tag != -1)
 		goto done;
 

-- 
Jens Axboe
