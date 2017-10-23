Return-Path: <maxg@mellanox.com>
Subject: Re: [PATCH] blk-mq: Iterate also over sched_tags requests at
 blk_mq_tagset_iter()
To: Sagi Grimberg <sagi@grimberg.me>, Bart Van Assche
	<Bart.VanAssche@wdc.com>, "israelr@mellanox.com" <israelr@mellanox.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme-bounces@lists.infradead.org"
	<linux-nvme-bounces@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
References: <1508680074-2417-1-git-send-email-israelr@mellanox.com>
 <1508740702.2634.4.camel@wdc.com>
 <07f66b5f-2043-a4d8-4425-cedb62cac2c0@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <d30d636c-7961-7b74-7ff1-d1b834995cf5@mellanox.com>
Date: Mon, 23 Oct 2017 12:31:48 +0300
MIME-Version: 1.0
In-Reply-To: <07f66b5f-2043-a4d8-4425-cedb62cac2c0@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>


>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index c81b40e..c290de0 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -322,6 +322,22 @@ int blk_mq_tagset_iter(struct blk_mq_tag_set 
>>> *set, void *data,
>>>           }
>>>       }
>>> +    for (i = 0; i < set->nr_hw_queues; i++) {
>>> +        struct blk_mq_tags *sched_tags = set->sched_tags[i];
>>> +
>>> +        if (!sched_tags)
>>> +            continue;
>>> +
>>> +        for (j = 0; j < sched_tags->nr_tags; j++) {
>>> +            if (!sched_tags->static_rqs[j])
>>> +                continue;
>>> +
>>> +            ret = fn(data, sched_tags->static_rqs[j]);
>>> +            if (ret)
>>> +                goto out;
>>> +        }
>>> +    }
>>
>> If both a scheduler tag and a driver tag have been assigned to a 
>> request, can this cause
>> blk_mq_tagset_iter() to call fn() twice for the same request?
> 
> It will, its not a big issue for reinit functionality, but it might if
> used for something else. I don't think its a good idea to go down this
> route.

Don't you think sched_tags should be part of the tagset (as driver tags) ?
if so, blk_mq_tagset_iter should call fn() on both scheduler and driver 
tags. Otherwise, let's call it blk_mq_tags_iter instead and pass struct 
blk_mq_tags *.

The private case of fn() == reinit() for NVMEoF RDMA can be solved by mr 
pool but maybe we should look on the general case too.
In either way, currently we can't use a scheduler for NVMEoF RDMA 
because of that issue.
