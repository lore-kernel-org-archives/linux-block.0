Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 1/2] blk-mq-sched: Allocate sched reserved tags as
 specified in the original queue tagset
To: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@osandov.com>
References: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
 <20170227154939.GA10715@vader>
 <4829b70c-53fd-f622-310e-0a30e4ede6fa@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eb51d324-62df-629e-8a7b-fea50ef7543e@grimberg.me>
Date: Mon, 27 Feb 2017 18:10:01 +0200
MIME-Version: 1.0
In-Reply-To: <4829b70c-53fd-f622-310e-0a30e4ede6fa@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> Hm, this may fix the crash, but I'm not sure it'll work as intended.
>> When we allocate the request, we'll get a reserved scheduler tag, but
>> then when we go to dispatch the request and call
>> blk_mq_get_driver_tag(), we'll be competing with all of the normal
>> requests for a regular driver tag. So maybe on top of this we should add
>> the BLK_MQ_REQ_RESERVED flag to the allocation attempt in
>> blk_mq_get_driver_tag() if the scheduler tag is reserved? I'm hazy on
>> what we expect from reserved tags, so feel free to call me crazy.
>
> Yeah good point, we need to carry it through. Reserved tags exist
> because drivers often need a request/tag for error handling. If all
> tags currently are used up for regular IO that is stuck, you need
> a reserved tag for error handling to guarantee progress.
>
> So Sagi's patch does take it half the way there, but get_driver_tag
> really needs to know about this as well, or we will just get stuck
> there as well. Two solutions, I can think of:
>
> 1) Check the tag value in get_driver_tag, add BLK_MQ_REQ_RESERVED
>    when allocating a driver tag if above X.
> 2) Add an RQF_SOMETHING_RESERVED. Add BLK_MQ_REQ_RESERVED in
>    get_driver_tag if that is set.
>
> Comments?

Can't we just not go through the scheduler for reserved tags? Obviously
there is no point in scheduling them...
