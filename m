Return-Path: <prvs=80731d7bfe=axboe@fb.com>
Subject: Re: [PATCH 2/2] blk-mq: add flag for drivers wanting blocking
 ->queue_rq()
To: Christoph Hellwig <hch@infradead.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-3-git-send-email-axboe@fb.com>
 <20160922145922.GB1800@infradead.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <jbacik@fb.com>,
        "Ming
 Lei" <ming.lei@canonical.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <a4162d4e-dc64-0e76-6f0c-3ff12eb0231c@fb.com>
Date: Thu, 22 Sep 2016 09:03:56 -0600
MIME-Version: 1.0
In-Reply-To: <20160922145922.GB1800@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/22/2016 08:59 AM, Christoph Hellwig wrote:
> On Thu, Sep 22, 2016 at 08:53:00AM -0600, Jens Axboe wrote:
>> If a driver sets BLK_MQ_F_BLOCKING, it is allowed to block in its
>> ->queue_rq() handler. For that case, blk-mq ensures that we always
>> calls it from a safe context.
>
> First can you provide a more useful defintion of blocking?  Lots of current
> drivers will already block in ->queue_rq, mostly to allocate memory.

Having to grab a mutex, for instance. We invoke ->queue_rq() with
preemption disabled, so I'd hope that would not be the case... What
drivers block in ->queue_rq?

> Second we looked at something similar a few times ago, mosty notably
> when converting loop and rbd, and came to the conclusion that
> performance sucks when we only have that single per-hctx work struct
> for a busy device.  I think Ming has done a lot of the benchmarking,
> so I've added him to Cc.

Loop was another case that was on my radar to get rid of the queue_work
it currently has to do. Josef is currently testing the nbd driver using
this approach, so we should get some numbers there too. If we have to,
we can always bump up the concurrency to mimic more of the behavior of
having multiple workers running on the hardware queue. I'd prefer to
still do that in blk-mq, instead of having drivers reinventing their own
work offload functionality.

-- 
Jens Axboe
