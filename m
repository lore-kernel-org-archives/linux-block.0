Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/16] blk-mq: pass in request/bio flags to queue mapping
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-5-axboe@kernel.dk>
 <50a9c2d1-abc5-b04f-1f95-878f216a47b1@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c688cb45-eb14-c857-e90a-da6fd93f81b7@kernel.dk>
Date: Wed, 31 Oct 2018 08:18:18 -0600
MIME-Version: 1.0
In-Reply-To: <50a9c2d1-abc5-b04f-1f95-878f216a47b1@grimberg.me>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 6:37 PM, Sagi Grimberg wrote:
> 
>>   static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>> +						     unsigned int flags,
>>   						     unsigned int cpu)
>>   {
>>   	struct blk_mq_tag_set *set = q->tag_set;
>> @@ -84,7 +85,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
>>   							  unsigned int hctx_type,
>>   							  unsigned int cpu)
>>   {
>> -	return blk_mq_map_queue(q, cpu);
>> +	return blk_mq_map_queue(q, hctx_type, cpu);
>>   }
> 
> Haven't read through the rest of the patch set, but it looks a bit
> strange that a type enumeration is being passed on as flags field.

It's impossible to get it 100% right at this point, which is why
it looks a bit odd. If you read on, it'll make sense.

-- 
Jens Axboe
