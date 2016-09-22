Return-Path: <prvs=80731d7bfe=axboe@fb.com>
Subject: Re: [PATCH 2/2] blk-mq: add flag for drivers wanting blocking
 ->queue_rq()
To: Christoph Hellwig <hch@infradead.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-3-git-send-email-axboe@fb.com>
 <20160922145922.GB1800@infradead.org>
 <a4162d4e-dc64-0e76-6f0c-3ff12eb0231c@fb.com>
 <20160922151222.GA515@infradead.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <jbacik@fb.com>,
        "Ming
 Lei" <ming.lei@canonical.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <ef600cc3-f8cc-bacf-5538-9eb8d7e2c95a@fb.com>
Date: Thu, 22 Sep 2016 09:17:52 -0600
MIME-Version: 1.0
In-Reply-To: <20160922151222.GA515@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/22/2016 09:12 AM, Christoph Hellwig wrote:
> On Thu, Sep 22, 2016 at 09:03:56AM -0600, Jens Axboe wrote:
>> Having to grab a mutex, for instance. We invoke ->queue_rq() with
>> preemption disabled, so I'd hope that would not be the case... What
>> drivers block in ->queue_rq?
>
> I though I had converted a lot of them to GFP_NOIO instead of GFP_ATOMIC
> allocations, but I can't find any evidence of that.  Maybe it was just
> my imagination, or an unsubmitted patch series.  Sorry for the
> confusion.

OK, that makes more sense. Pretty sure we would have had complaints!

>> Loop was another case that was on my radar to get rid of the queue_work
>> it currently has to do. Josef is currently testing the nbd driver using
>> this approach, so we should get some numbers there too. If we have to,
>> we can always bump up the concurrency to mimic more of the behavior of
>> having multiple workers running on the hardware queue. I'd prefer to
>> still do that in blk-mq, instead of having drivers reinventing their own
>> work offload functionality.
>
> There should be a lot of numbers in the list archives from the time
> that Ming did the loop conversion, as I've been trying to steer him
> that way, and he actually implemented and benchmarked it.
>
> We can't just increase the concurrency as a single work_struct item
> can't be queued multiple times even on a high concurreny workqueue.

But we could have more work items, if we had to. Even if loop isn't a
drop-in replacement for this simpler approach, I think it'll work well
enough for nbd. The 5% number from Josef is comparing to not having any
offload at all, I suspect the number from just converting to queue_work
in the driver would be similar.

-- 
Jens Axboe
