Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 5/6] blk-mq: enable checking two part inflight counts at
 the same time
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-6-git-send-email-axboe@kernel.dk>
 <1501875874.2757.28.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <305d965b-ab49-6a5f-9e6f-13fdcbfb87e3@kernel.dk>
Date: Fri, 4 Aug 2017 13:56:57 -0600
MIME-Version: 1.0
In-Reply-To: <1501875874.2757.28.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/04/2017 01:44 PM, Bart Van Assche wrote:
> On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
>> @@ -98,11 +98,13 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>>  		return;
>>  
>>  	/*
>> -	 * Count as inflight if it either matches the partition we asked
>> -	 * for, or if it's the root
>> +	 * Count as inflight if it matches the partition, count separately
>> +	 * (but all) if we got asked for the root
>>  	 */
>> -	if (rq->part == mi->part || mi->part->partno)
>> +	if (rq->part == mi->part)
>>  		mi->inflight[0]++;
>> +	if (mi->part->partno)
>> +		mi->inflight[1]++;
>>  }
> 
> Hello Jens,
> 
> Same question here: should "if (mi->part->partno)" perhaps be changed into
> "if (mi->part->partno == 0)"?

It should be correct as-is.

-- 
Jens Axboe
