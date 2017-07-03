Return-Path: <axboe@kernel.dk>
Subject: Re: NVMe induced NULL deref in bt_iter()
To: Max Gurtovoy <maxg@mellanox.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 sagig <sagi@grimberg.me>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c908ca45-92fe-50e8-1d61-cb24f9957473@kernel.dk>
Date: Mon, 3 Jul 2017 10:01:48 -0600
MIME-Version: 1.0
In-Reply-To: <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/02/2017 04:45 AM, Max Gurtovoy wrote:
> 
> 
> On 6/30/2017 8:26 PM, Jens Axboe wrote:
>> Hi Max,
> 
> Hi Jens,
> 
>>
>> I remembered you reporting this. I think this is a regression introduced
>> with the scheduling, since ->rqs[] isn't static anymore. ->static_rqs[]
>> is, but that's not indexable by the tag we find. So I think we need to
>> guard those with a NULL check. The actual requests themselves are
>> static, so we know the memory itself isn't going away. But if we race
>> with completion, we could find a NULL there, validly.
>>
>> Since you could reproduce it, can you try the below?
> 
> I still can repro the null deref with this patch applied.
> 
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index d0be72ccb091..b856b2827157 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -214,7 +214,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>  		bitnr += tags->nr_reserved_tags;
>>  	rq = tags->rqs[bitnr];
>>
>> -	if (rq->q == hctx->queue)
>> +	if (rq && rq->q == hctx->queue)
>>  		iter_data->fn(hctx, rq, iter_data->data, reserved);
>>  	return true;
>>  }
>> @@ -249,8 +249,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>  	if (!reserved)
>>  		bitnr += tags->nr_reserved_tags;
>>  	rq = tags->rqs[bitnr];
>> -
>> -	iter_data->fn(rq, iter_data->data, reserved);
>> +	if (rq)
>> +		iter_data->fn(rq, iter_data->data, reserved);
>>  	return true;
>>  }
> 
> see the attached file for dmesg output.
> 
> output of gdb:
> 
> (gdb) list *(blk_mq_flush_busy_ctxs+0x48)
> 0xffffffff8127b108 is in blk_mq_flush_busy_ctxs 
> (./include/linux/sbitmap.h:234).
> 229
> 230             for (i = 0; i < sb->map_nr; i++) {
> 231                     struct sbitmap_word *word = &sb->map[i];
> 232                     unsigned int off, nr;
> 233
> 234                     if (!word->word)
> 235                             continue;
> 236
> 237                     nr = 0;
> 238                     off = i << sb->shift;
> 
> 
> when I change the "if (!word->word)" to  "if (word && !word->word)"
> I can get null deref at "nr = find_next_bit(&word->word, word->depth, 
> nr);". Seems like somehow word becomes NULL.
> 
> Adding the linux-nvme guys too.
> Sagi has mentioned that this can be null only if we remove the tagset 
> while I/O is trying to get a tag and when killing the target we get into
> error recovery and periodic reconnects, which does _NOT_ include freeing
> the tagset, so this is probably the admin tagset.
> 
> Sagi,
> you've mention a patch for centrelizing the treatment of the admin 
> tagset to the nvme core. I think I missed this patch, so can you please 
> send a pointer to it and I'll check if it helps ?

Right, this is clearly a different issue and my first thought as well
was that it's a missing quiesce of the queue. We're iterating the tags
when they are being torn down.

Looks like Sagi's patch fixes the issue, so I'm considering this one
resolved.

-- 
Jens Axboe
