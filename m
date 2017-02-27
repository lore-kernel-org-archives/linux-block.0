Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-mq-sched: Allocate sched reserved tags as
 specified in the original queue tagset
To: Omar Sandoval <osandov@osandov.com>, Sagi Grimberg <sagi@grimberg.me>
References: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
 <20170227154939.GA10715@vader>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4829b70c-53fd-f622-310e-0a30e4ede6fa@kernel.dk>
Date: Mon, 27 Feb 2017 08:53:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170227154939.GA10715@vader>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/27/2017 08:49 AM, Omar Sandoval wrote:
> On Mon, Feb 27, 2017 at 05:36:20PM +0200, Sagi Grimberg wrote:
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>  block/blk-mq-sched.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 98c7b061781e..46ca965fff5c 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -454,7 +454,8 @@ int blk_mq_sched_setup(struct request_queue *q)
>>  	 */
>>  	ret = 0;
>>  	queue_for_each_hw_ctx(q, hctx, i) {
>> -		hctx->sched_tags = blk_mq_alloc_rq_map(set, i, q->nr_requests, 0);
>> +		hctx->sched_tags = blk_mq_alloc_rq_map(set, i,
>> +				q->nr_requests, set->reserved_tags);
>>  		if (!hctx->sched_tags) {
>>  			ret = -ENOMEM;
>>  			break;
>> -- 
>> 2.7.4
> 
> Hm, this may fix the crash, but I'm not sure it'll work as intended.
> When we allocate the request, we'll get a reserved scheduler tag, but
> then when we go to dispatch the request and call
> blk_mq_get_driver_tag(), we'll be competing with all of the normal
> requests for a regular driver tag. So maybe on top of this we should add
> the BLK_MQ_REQ_RESERVED flag to the allocation attempt in
> blk_mq_get_driver_tag() if the scheduler tag is reserved? I'm hazy on
> what we expect from reserved tags, so feel free to call me crazy.

Yeah good point, we need to carry it through. Reserved tags exist
because drivers often need a request/tag for error handling. If all
tags currently are used up for regular IO that is stuck, you need
a reserved tag for error handling to guarantee progress.

So Sagi's patch does take it half the way there, but get_driver_tag
really needs to know about this as well, or we will just get stuck
there as well. Two solutions, I can think of:

1) Check the tag value in get_driver_tag, add BLK_MQ_REQ_RESERVED
   when allocating a driver tag if above X.
2) Add an RQF_SOMETHING_RESERVED. Add BLK_MQ_REQ_RESERVED in
   get_driver_tag if that is set.

Comments?

-- 
Jens Axboe
