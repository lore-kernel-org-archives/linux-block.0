Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 07/16] blk-mq: support multiple hctx maps
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-8-axboe@kernel.dk>
 <1e523ea4-1134-c299-281d-0dad276825d2@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4164e35e-1361-7ea1-f2c1-f9eea7030df9@kernel.dk>
Date: Wed, 31 Oct 2018 08:23:09 -0600
MIME-Version: 1.0
In-Reply-To: <1e523ea4-1134-c299-281d-0dad276825d2@grimberg.me>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 6:59 PM, Sagi Grimberg wrote:
>> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>> +						     unsigned int flags,
>> +						     unsigned int cpu)
>>   {
>> -	return blk_mq_map_queue(q, hctx_type, cpu);
>> +	int hctx_type = 0;
>> +
>> +	if (q->mq_ops->flags_to_type)
>> +		hctx_type = q->mq_ops->flags_to_type(q, flags);
> 
> nitpick: I think that rq_flags_to_type is a bit more descriptive here.
> just a personal opinion.

Sure, I can make that change.

-- 
Jens Axboe
