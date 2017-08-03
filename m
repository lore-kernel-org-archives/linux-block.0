Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] blk-mq-tag: check for NULL rq when iterating tags
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
 <1501790516-6924-2-git-send-email-axboe@kernel.dk>
 <1501792140.2922.14.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <549d568a-b32a-5d6c-7788-3f26a2ce58a2@kernel.dk>
Date: Thu, 3 Aug 2017 14:35:26 -0600
MIME-Version: 1.0
In-Reply-To: <1501792140.2922.14.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/03/2017 02:29 PM, Bart Van Assche wrote:
> On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
>> Since we introduced blk-mq-sched, the tags->rqs[] array has been
>> dynamically assigned. So we need to check for NULL when iterating,
>> since we could be racing with completion.
>>
>> This is perfectly safe, since the memory backing of the request is
>> never going away while the device is alive. Only the pointer in
>> ->rqs[] may be reset.
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
> I agree with what you wrote in the description of this patch. However, since
> I have not yet found the code that clears tags->rqs[], would it be possible
> to show me that code?

Since it's been a month since I wrote this code, I went and looked too.
My memory was that we set/clear it dynamically since we added
scheduling, but looks like we don't clear it. The race is still valid
for when someone runs a tag check in parallel with someone allocating a
tag, since there's a window of time where the tag bit is set, but
->rqs[tag] isn't set yet. That's probably the race I hit, not the
completion race mentioned in the change log.

-- 
Jens Axboe
