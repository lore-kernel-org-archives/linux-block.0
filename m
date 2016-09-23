Return-Path: <ming.lei@canonical.com>
MIME-Version: 1.0
In-Reply-To: <ef600cc3-f8cc-bacf-5538-9eb8d7e2c95a@fb.com>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-3-git-send-email-axboe@fb.com> <20160922145922.GB1800@infradead.org>
 <a4162d4e-dc64-0e76-6f0c-3ff12eb0231c@fb.com> <20160922151222.GA515@infradead.org>
 <ef600cc3-f8cc-bacf-5538-9eb8d7e2c95a@fb.com>
From: Ming Lei <ming.lei@canonical.com>
Date: Fri, 23 Sep 2016 09:43:53 +0800
Message-ID: <CACVXFVOE9XU0ubtBPaSZdZnfFHi6ce+A=UhpJ+acbx=x5EJEug@mail.gmail.com>
Subject: Re: [PATCH 2/2] blk-mq: add flag for drivers wanting blocking ->queue_rq()
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>, jbacik@fb.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 22, 2016 at 11:17 PM, Jens Axboe <axboe@fb.com> wrote:
> On 09/22/2016 09:12 AM, Christoph Hellwig wrote:
>>
>> On Thu, Sep 22, 2016 at 09:03:56AM -0600, Jens Axboe wrote:
>>>
>>> Having to grab a mutex, for instance. We invoke ->queue_rq() with
>>> preemption disabled, so I'd hope that would not be the case... What
>>> drivers block in ->queue_rq?
>>
>>
>> I though I had converted a lot of them to GFP_NOIO instead of GFP_ATOMIC
>> allocations, but I can't find any evidence of that.  Maybe it was just
>> my imagination, or an unsubmitted patch series.  Sorry for the
>> confusion.
>
>
> OK, that makes more sense. Pretty sure we would have had complaints!
>
>>> Loop was another case that was on my radar to get rid of the queue_work
>>> it currently has to do. Josef is currently testing the nbd driver using
>>> this approach, so we should get some numbers there too. If we have to,
>>> we can always bump up the concurrency to mimic more of the behavior of
>>> having multiple workers running on the hardware queue. I'd prefer to
>>> still do that in blk-mq, instead of having drivers reinventing their own
>>> work offload functionality.
>>
>>
>> There should be a lot of numbers in the list archives from the time
>> that Ming did the loop conversion, as I've been trying to steer him
>> that way, and he actually implemented and benchmarked it.
>>
>> We can't just increase the concurrency as a single work_struct item
>> can't be queued multiple times even on a high concurreny workqueue.
>
>
> But we could have more work items, if we had to. Even if loop isn't a
> drop-in replacement for this simpler approach, I think it'll work well
> enough for nbd. The 5% number from Josef is comparing to not having any
> offload at all, I suspect the number from just converting to queue_work
> in the driver would be similar.

5% might be a noise.

>From nbd's .queue_rq(), kthread_work should match its case because
one per-nbd mutex is required and all cmds sent to the nbd are serialized,
so using common work items may hurt performance caused by
unnecessary context switch.

thanks,
