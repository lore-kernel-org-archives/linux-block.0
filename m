Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] blk-mq-tag: check for NULL rq when iterating tags
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-2-git-send-email-axboe@kernel.dk>
 <1501875276.2757.23.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <323e6c5d-794c-7775-acae-241603a22d4e@kernel.dk>
Date: Fri, 4 Aug 2017 13:35:35 -0600
MIME-Version: 1.0
In-Reply-To: <1501875276.2757.23.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/04/2017 01:34 PM, Bart Van Assche wrote:
> On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
>> Since we introduced blk-mq-sched, the tags->rqs[] array has been
>> dynamically assigned. So we need to check for NULL when iterating,
>> since there's a window of time where the bit is set, but we haven't
>> dynamically assigned the tags->rqs[] array position yet.
>>
>> This is perfectly safe, since the memory backing of the request is
>> never going away while the device is alive.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq-tag.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index d0be72ccb091..b856b2827157 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -214,7 +214,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>  		bitnr += tags->nr_reserved_tags;
>>  	rq = tags->rqs[bitnr];
>>  
>> -	if (rq->q == hctx->queue)
>> +	if (rq && rq->q == hctx->queue)
>>  		iter_data->fn(hctx, rq, iter_data->data, reserved);
>>  	return true;
>>  }
>> @@ -249,8 +249,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>  	if (!reserved)
>>  		bitnr += tags->nr_reserved_tags;
>>  	rq = tags->rqs[bitnr];
>> -
>> -	iter_data->fn(rq, iter_data->data, reserved);
>> +	if (rq)
>> +		iter_data->fn(rq, iter_data->data, reserved);
>>  	return true;
>>  }
> 
> Hello Jens,
> 
> Should it have been mentioned in the patch description or in a comment that
> these functions can read tags->rqs[] after the corresponding bit has been set
> in the bitmap but before the tags->rqs[] pointer is updated?

I'll add a comment to that effect.

-- 
Jens Axboe
