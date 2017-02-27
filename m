Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-mq-sched: Allocate sched reserved tags as
 specified in the original queue tagset
To: Omar Sandoval <osandov@osandov.com>, Sagi Grimberg <sagi@grimberg.me>
References: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
 <20170227154939.GA10715@vader>
 <4829b70c-53fd-f622-310e-0a30e4ede6fa@kernel.dk>
 <eb51d324-62df-629e-8a7b-fea50ef7543e@grimberg.me>
 <20170227161452.GB10715@vader>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a4c227b0-2a7f-17e9-75d2-09e0b89bdcc0@kernel.dk>
Date: Mon, 27 Feb 2017 09:17:33 -0700
MIME-Version: 1.0
In-Reply-To: <20170227161452.GB10715@vader>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/27/2017 09:14 AM, Omar Sandoval wrote:
> On Mon, Feb 27, 2017 at 06:10:01PM +0200, Sagi Grimberg wrote:
>>
>>>> Hm, this may fix the crash, but I'm not sure it'll work as intended.
>>>> When we allocate the request, we'll get a reserved scheduler tag, but
>>>> then when we go to dispatch the request and call
>>>> blk_mq_get_driver_tag(), we'll be competing with all of the normal
>>>> requests for a regular driver tag. So maybe on top of this we should add
>>>> the BLK_MQ_REQ_RESERVED flag to the allocation attempt in
>>>> blk_mq_get_driver_tag() if the scheduler tag is reserved? I'm hazy on
>>>> what we expect from reserved tags, so feel free to call me crazy.
>>>
>>> Yeah good point, we need to carry it through. Reserved tags exist
>>> because drivers often need a request/tag for error handling. If all
>>> tags currently are used up for regular IO that is stuck, you need
>>> a reserved tag for error handling to guarantee progress.
>>>
>>> So Sagi's patch does take it half the way there, but get_driver_tag
>>> really needs to know about this as well, or we will just get stuck
>>> there as well. Two solutions, I can think of:
>>>
>>> 1) Check the tag value in get_driver_tag, add BLK_MQ_REQ_RESERVED
>>>    when allocating a driver tag if above X.
>>> 2) Add an RQF_SOMETHING_RESERVED. Add BLK_MQ_REQ_RESERVED in
>>>    get_driver_tag if that is set.
>>>
>>> Comments?
> 
> Option 1 looks simple enough that I don't think it warrants a new
> request flag (compile tested only):
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9e6b064e5339..87590f7d4f80 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -852,6 +852,9 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>  		return true;
>  	}
>  
> +	if (rq->internal_tag < data.hctx->sched_tags->nr_reserved_tags)
> +		data.flags |= BLK_MQ_REQ_RESERVED;
> +
>  	rq->tag = blk_mq_get_tag(&data);
>  	if (rq->tag >= 0) {
>  		if (blk_mq_tag_busy(data.hctx)) {

Agree, that's identical to what I just sent out as well, functionally.

>> Can't we just not go through the scheduler for reserved tags? Obviously
>> there is no point in scheduling them...
> 
> That sounds nice, since I'd be worried about the scheduler also needing
> to be aware of the reserved status lest it also get the reserved request
> stuck behind some normal requests. But, we special case flush in this
> way, and it has been a huge pain.

The caller better be using head insertion for this, in case we already
have requests in the queue. But that's no different than the current
logic.

So I think it should work fine.

-- 
Jens Axboe
