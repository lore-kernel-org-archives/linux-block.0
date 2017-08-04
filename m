Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] blk-mq: provide internal in-flight variant
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-5-git-send-email-axboe@kernel.dk>
 <1501875785.2757.27.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c88964e8-f97d-b77a-6119-d80e05b4af22@kernel.dk>
Date: Fri, 4 Aug 2017 13:45:20 -0600
MIME-Version: 1.0
In-Reply-To: <1501875785.2757.27.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/04/2017 01:43 PM, Bart Van Assche wrote:
> On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
>> +static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>> +				  struct request *rq, void *priv,
>> +				  bool reserved)
>> +{
>> +	struct mq_inflight *mi = priv;
>> +
>> +	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
>> +		return;
>> +
>> +	/*
>> +	 * Count as inflight if it either matches the partition we asked
>> +	 * for, or if it's the root
>> +	 */
>> +	if (rq->part == mi->part || mi->part->partno)
>> +		mi->inflight[0]++;
>> +}
> 
> Hello Jens,
> 
> How to check for the root? Does partno == 0 or partno != 0 represent the
> root? Please note that I'm not familiar with the partition code.

if partno != 0, it's a partition. So for that, account for root too. I
guess the comment could be better...

-- 
Jens Axboe
