Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: only alloc hctx point as many as nr_hw_queues
To: linux-block@vger.kernel.org
References: <20170713161020.GA10325@bogon.didichuxing.com>
 <e03b2bfa-15d3-3d27-15cf-07e65882fc25@kernel.dk>
 <20170713163015.GA10602@bogon.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Cc: weiping <zhangweiping@didichuxing.com>
Message-ID: <6e472c5c-5461-ccc4-1a50-042a2343a3e7@kernel.dk>
Date: Thu, 13 Jul 2017 10:38:40 -0600
MIME-Version: 1.0
In-Reply-To: <20170713163015.GA10602@bogon.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/13/2017 10:30 AM, weiping zhang wrote:
> On Thu, Jul 13, 2017 at 10:14:31AM -0600, Jens Axboe wrote:
>> On 07/13/2017 10:10 AM, weiping zhang wrote:
>>> one hw queue only has one hctx, reduce it's number same as nr_hw_queues.
>>
>> What happens if a device registers with eg 4 hw queues, then later
>> calls blk_mq_update_nr_hw_queues()?
>>
> 
> your means, 10 cpu, and  device has 10 hw queues, but  only register 4,
> and then update it to 10, no place store new hctx. Am i understanding
> right ? if yes, could you tell me why driver do that ? thanks.

It doesn't matter why the driver would do that, the fact is that this is
a feature we support and it's a part of the API. NBD uses it, for
instance. Your patch breaks it, for saving a bit of memory. So I will
not include it.

-- 
Jens Axboe
