Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <e3887ef8-cd5d-ebda-35c4-01b2ea064afc@intel.com>
References: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
 <1494506343-28572-4-git-send-email-ulf.hansson@linaro.org>
 <f583aa94-578c-493d-f863-2fcc67e5d848@intel.com> <CAPDyKFqmvksL=bLR0FOfR=Q7B4TNa6oy0XZwFvkoT7nxLW4JBQ@mail.gmail.com>
 <e3887ef8-cd5d-ebda-35c4-01b2ea064afc@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 May 2017 16:32:52 +0200
Message-ID: <CAPDyKFperzkkh2wDyh3=G1-357CZvYvaRtHv3Wp4QVXXfutBhA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mmc: core: Allow mmc block device to re-claim the host
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 16 May 2017 at 15:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 15/05/17 17:05, Ulf Hansson wrote:
>> On 12 May 2017 at 10:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 11/05/17 15:39, Ulf Hansson wrote:
>>>> The current mmc block device implementation is tricky when it comes to
>>>> claim and release of the host, while processing I/O requests. In principle
>>>> we need to claim the host at the first request entering the queue and then
>>>> we need to release the host, as soon as the queue becomes empty. This
>>>> complexity relates to the asynchronous request mechanism that the mmc block
>>>> device driver implements.
>>>>
>>>> For the legacy block interface that we currently implements, the above
>>>> issue can be addressed, as we can find out when the queue really becomes
>>>> empty.
>>>>
>>>> However, to find out whether the queue is empty, isn't really an applicable
>>>> method when using the new blk-mq interface, as requests are instead pushed
>>>> to us via the struct struct blk_mq_ops and its function pointers.
>>>
>>> That is not entirely true.  We can pull requests by running the queue i.e.
>>> blk_mq_run_hw_queues(q, false), returning BLK_MQ_RQ_QUEUE_BUSY and stopping
>>> / starting the queue as needed.
>>
>> I am not sure how that would work. It doesn't sound very effective to
>> me, but I may be wrong.
>
> The queue depth is not the arbiter of whether we can issue a request.  That
> means there will certainly be times when we have to return
> BLK_MQ_RQ_QUEUE_BUSY from ->queue_rq() and perhaps stop the queue as well.
>
> We could start with ->queue_rq() feeding every request to the existing
> thread and work towards having it submit requests immediately when possible.
>  Currently mmc core cannot submit mmc_requests without waiting, but the
> command queue implementation can for read/write requests when the host
> controller and card are runtime resumed and the card is switched to the
> correct internal partition (and we are not currently discarding flushing or
> recovering), so it might be simpler to start with cmdq ;-)

In the end I guess the only thing to do is to compare the patchsets to
see how the result would look like. :-)

My current observation is that our current implementation of the mmc
block device and corresponding mmc queue, is still rather messy, even
if you and Linus recently has worked hard to improve the situation.

Moreover it looks quite different compared to other block device
drivers and in the way of striving to make it more robust and
maintainable, that's not good.

Therefore, I am not really comfortable with replacing one mmc hack for
block device management with yet another, as that seems to be what
your approach would do - unless I am mistaken of course.

Instead I would like us to move into a more generic blk device
approach. Whatever that means. :-)

>
>>
>>>
>>> But, as I have written before, we could start with the most trivial
>>> implementation.  ->queue_rq() puts the requests in a list and then the
>>> thread removes them from the list.
>>
>> That would work...
>>
>>>
>>> That would be a good start because it would avoid having to deal with other
>>> issues at the same time.
>>
>> ...however this doesn't seem like a step in the direction we want to
>> take when porting to blkmq.
>>
>> There will be an extra context switch for each an every request, won't there?
>
> No, for synchronous requests, it would be the same as now. ->queue_rq()
> would be called in the context of the submitter and would wake the thread
> just like ->request_fn() does now.

You are right!

However, in my comparison I was thinking of how it *can* work if we
were able to submit/prepare request in the context of the caller.

>
>>
>> My point is, to be able to convert to blkmq, we must also avoid
>> performance regression - at leas as long as possible.
>
> It would still be better to start simple, and measure the performance, than
> to guess where the bottlenecks are.

Yes, starting simple is always good!

Although, even if simple, we need to stop adding more mmc specific
hacks into the mmc block device layer.

[...]

Kind regards
Uffe
