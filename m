Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-mq-sched: Allocate sched reserved tags as
 specified in the original queue tagset
To: Omar Sandoval <osandov@osandov.com>
References: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
 <20170227154939.GA10715@vader>
 <4829b70c-53fd-f622-310e-0a30e4ede6fa@kernel.dk>
 <eb51d324-62df-629e-8a7b-fea50ef7543e@grimberg.me>
 <353bb44b-7180-7a78-47f5-2ebf03b714bc@kernel.dk>
 <20170227162520.GC10715@vader>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c80fb68a-8031-b5b2-7403-307475bf8352@kernel.dk>
Date: Mon, 27 Feb 2017 09:27:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170227162520.GC10715@vader>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/27/2017 09:25 AM, Omar Sandoval wrote:
> On Mon, Feb 27, 2017 at 09:15:27AM -0700, Jens Axboe wrote:
>> On 02/27/2017 09:10 AM, Sagi Grimberg wrote:
>>>
>>>>> Hm, this may fix the crash, but I'm not sure it'll work as intended.
>>>>> When we allocate the request, we'll get a reserved scheduler tag, but
>>>>> then when we go to dispatch the request and call
>>>>> blk_mq_get_driver_tag(), we'll be competing with all of the normal
>>>>> requests for a regular driver tag. So maybe on top of this we should add
>>>>> the BLK_MQ_REQ_RESERVED flag to the allocation attempt in
>>>>> blk_mq_get_driver_tag() if the scheduler tag is reserved? I'm hazy on
>>>>> what we expect from reserved tags, so feel free to call me crazy.
>>>>
>>>> Yeah good point, we need to carry it through. Reserved tags exist
>>>> because drivers often need a request/tag for error handling. If all
>>>> tags currently are used up for regular IO that is stuck, you need
>>>> a reserved tag for error handling to guarantee progress.
>>>>
>>>> So Sagi's patch does take it half the way there, but get_driver_tag
>>>> really needs to know about this as well, or we will just get stuck
>>>> there as well. Two solutions, I can think of:
>>>>
>>>> 1) Check the tag value in get_driver_tag, add BLK_MQ_REQ_RESERVED
>>>>    when allocating a driver tag if above X.
>>>> 2) Add an RQF_SOMETHING_RESERVED. Add BLK_MQ_REQ_RESERVED in
>>>>    get_driver_tag if that is set.
>>>>
>>>> Comments?
>>>
>>> Can't we just not go through the scheduler for reserved tags? Obviously
>>> there is no point in scheduling them...
>>
>> Right, that would be possible. But I'd rather not treat any requests
>> differently, it's a huge pain in the ass that flush request currently
>> insert with a driver tag already allocated. So it's not because
>> scheduling will add anything at all, it's more that I'd like to move
>> flush requests to use regular inserts as well and not deal with some
>> request being "special" in any way.
>>
>> The below should hopefully work. Totally untested...
> 
> I like your variant if it works for Sagi. My only complaint (which was
> already there) is that the BUG_ON(tag >= tags->nr_reserved_tags) in
> blk_mq_put_tag() looks kind of silly since we just checked that exact
> same condition.

Yeah, that check is nonsensical. Let's kill it.

-- 
Jens Axboe
