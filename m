Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 02/16] blk-mq: abstract out queue map
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-3-axboe@kernel.dk>
 <725b4d35-2390-58d9-4041-0bac6de6cd77@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cc5771b1-5ca9-8463-f575-9f5f9cad4fe3@kernel.dk>
Date: Wed, 31 Oct 2018 08:17:43 -0600
MIME-Version: 1.0
In-Reply-To: <725b4d35-2390-58d9-4041-0bac6de6cd77@grimberg.me>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 6:31 PM, Sagi Grimberg wrote:
> 
>> @@ -41,12 +41,12 @@ int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
>>   			goto fallback;
>>   
>>   		for_each_cpu(cpu, mask)
>> -			set->mq_map[cpu] = queue;
>> +			set->map[0].mq_map[cpu] = queue;
> 
> Any reason not to change the signature like the other mappers?

No particular reason, outside of not wanting to touch more than
I had to.

-- 
Jens Axboe
