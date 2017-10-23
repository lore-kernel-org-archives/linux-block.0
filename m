Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH] blk-mq: Iterate also over sched_tags requests at
 blk_mq_tagset_iter()
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "israelr@mellanox.com" <israelr@mellanox.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme-bounces@lists.infradead.org"
 <linux-nvme-bounces@lists.infradead.org>
Cc: "hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
References: <1508680074-2417-1-git-send-email-israelr@mellanox.com>
 <1508740702.2634.4.camel@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <07f66b5f-2043-a4d8-4425-cedb62cac2c0@grimberg.me>
Date: Mon, 23 Oct 2017 10:52:10 +0300
MIME-Version: 1.0
In-Reply-To: <1508740702.2634.4.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> @@ -441,6 +442,8 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
>>   	if (!hctx->sched_tags)
>>   		return -ENOMEM;
>>   
>> +	set->sched_tags[hctx_idx] = hctx->sched_tags;
>> +
>>   	ret = blk_mq_alloc_rqs(set, hctx->sched_tags, hctx_idx, q->nr_requests);
>>   	if (ret)
>>   		blk_mq_sched_free_tags(set, hctx, hctx_idx);
> 
> Will this work as expected if a tag set is shared across multiple request queues?

Probably not.

>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index c81b40e..c290de0 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -322,6 +322,22 @@ int blk_mq_tagset_iter(struct blk_mq_tag_set *set, void *data,
>>   		}
>>   	}
>>   
>> +	for (i = 0; i < set->nr_hw_queues; i++) {
>> +		struct blk_mq_tags *sched_tags = set->sched_tags[i];
>> +
>> +		if (!sched_tags)
>> +			continue;
>> +
>> +		for (j = 0; j < sched_tags->nr_tags; j++) {
>> +			if (!sched_tags->static_rqs[j])
>> +				continue;
>> +
>> +			ret = fn(data, sched_tags->static_rqs[j]);
>> +			if (ret)
>> +				goto out;
>> +		}
>> +	}
> 
> If both a scheduler tag and a driver tag have been assigned to a request, can this cause
> blk_mq_tagset_iter() to call fn() twice for the same request?

It will, its not a big issue for reinit functionality, but it might if
used for something else. I don't think its a good idea to go down this
route.
