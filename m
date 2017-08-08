Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 5/6] blk-mq: enable checking two part inflight counts at
 the same time
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, brking@linux.vnet.ibm.com,
 bart.vanassche@wdc.com
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-6-git-send-email-axboe@kernel.dk>
 <20170808224800.GG4072@vader.DHCP.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78566b09-d53c-811e-4bd5-c15cdea2e50a@kernel.dk>
Date: Tue, 8 Aug 2017 17:47:15 -0600
MIME-Version: 1.0
In-Reply-To: <20170808224800.GG4072@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/08/2017 04:48 PM, Omar Sandoval wrote:
> On Fri, Aug 04, 2017 at 09:04:21AM -0600, Jens Axboe wrote:
>> Modify blk_mq_in_flight() to count both a partition and root at
>> the same time. Then we only have to call it once, instead of
>> potentially looping the tags twice.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> One comment below.
> 
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> [snip]
> 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index fe1aa1f5f069..410ed246bc9b 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
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
> 
> Similar concern as with patch 3, why special case the part0 case below?

Not sure I follow, both are initialized for this case. Or do you mean
the increment? The comment isn't great, I should update that. Basically
we want to increment [1] if this is a partition, and increment [0] if it
matches the one that was asked for.

-- 
Jens Axboe
