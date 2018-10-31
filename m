Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/16] blk-mq: allow software queue to map to multiple
 hardware queues
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-6-axboe@kernel.dk>
 <f5bff9c7-2c94-8988-cf76-318fa0808cf0@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <95e50d97-7cb3-7632-6e3f-b75ce32153ff@kernel.dk>
Date: Wed, 31 Oct 2018 08:19:10 -0600
MIME-Version: 1.0
In-Reply-To: <f5bff9c7-2c94-8988-cf76-318fa0808cf0@grimberg.me>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 6:49 PM, Sagi Grimberg wrote:
> 
> 
>> @@ -2342,10 +2346,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>>   
>>   		ctx = per_cpu_ptr(q->queue_ctx, i);
>>   		hctx = blk_mq_map_queue_type(q, 0, i);
>> -
>> +		hctx->type = 0;
>>   		cpumask_set_cpu(i, hctx->cpumask);
>> -		ctx->index_hw = hctx->nr_ctx;
>> +		ctx->index_hw[hctx->type] = hctx->nr_ctx;
>>   		hctx->ctxs[hctx->nr_ctx++] = ctx;
>> +
>> +		/*
>> +		 * If the nr_ctx type overflows, we have exceeded the
>> +		 * amount of sw queues we can support.
>> +		 */
>> +		BUG_ON(!hctx->nr_ctx);
> 
> Was this added because nr_ctx became short? What was the motivation
> for that? save space? structure alignment?

Right, I made it smaller to not take up more space after this change.
And since it is now smaller, adding a check for wrap seemed like
a good idea.

> Perhaps this should be mentioned in the change log (as it contradicts
> that no functional changes exist in this patch). Or, if this can happen
> even when 32bit nr_ctx, it should be a separate small patch?

Could happen for any type, but more likely now of course. I'll
mention this in the changelog.

-- 
Jens Axboe
