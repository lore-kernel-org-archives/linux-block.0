Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/4] blk-mq: enable checking two part inflight counts at
 the same time
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
 <1501790516-6924-5-git-send-email-axboe@kernel.dk>
 <1501795764.2922.26.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4c3436cd-d377-4161-2e1a-74b51b1ab8ec@kernel.dk>
Date: Thu, 3 Aug 2017 16:38:37 -0600
MIME-Version: 1.0
In-Reply-To: <1501795764.2922.26.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/03/2017 03:29 PM, Bart Van Assche wrote:
> On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
>>  static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>> @@ -97,17 +98,25 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>>  {
>>  	struct mq_inflight *mi = priv;
>>  
>> -	if (rq->part == mi->part)
>> -		mi->inflight++;
>> +	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
>> +		return;
> 
> Should the REQ_ATOM_STARTED test perhaps have been introduced in patch 3/4
> instead of in this patch?

It should, moved.

>> +	if (rq->part == mi->part1) {
>> +		mi->inflight[0]++;
>> +		if (mi->part1->partno &&
>> +		    &part_to_disk(mi->part1)->part0 == mi->part2)
>> +			mi->inflight[1]++;
>> +	} else if (rq->part == mi->part2)
>> +		mi->inflight[1]++;
>>  }
> 
> So mi->part2 may represent part0 but mi->part1 not? Does that deserve a comment?
> 
> Additionally, shouldn't the mi->part2 == part0 test be moved out of the if-statement
> such that all requests are counted for part0 instead of storing the same count in
> inflight[0] and inflight[1] if mi->part2 == part0?

I think I'll just clean up the whole thing and get rid of part1/part2. The two
can only exist together, if part1 is a partition. So will be easier to just
unconditionally sum part+root, if part is a partition. Then we only need to
pass in 'part', not part1/2.

>> -unsigned int blk_mq_in_flight(struct request_queue *q,
>> -			       struct hd_struct *part)
>> +void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part1,
>> +		      struct hd_struct *part2, unsigned int *inflight)
>>  {
> 
> Should inflight be declared as an array to make it clear that it is a pointer to
> an array with two elements?

Sure, I can do that.

-- 
Jens Axboe
