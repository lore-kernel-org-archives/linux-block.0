Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <3fc89f9f-fbcf-113d-3644-b6c9dae003f0@intel.com>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-7-linus.walleij@linaro.org> <00989e26-cdb9-48d7-2e46-ae6ef66e59a7@intel.com>
 <CACRpkdYOyEs8vxmPt1kGiKJrw8+16DyD8Nn=ke6mgxPaCQynCw@mail.gmail.com> <3fc89f9f-fbcf-113d-3644-b6c9dae003f0@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Mar 2017 09:46:32 +0200
Message-ID: <CACRpkdbFqKmmk6Y1WqsDz24CSwwxH_xKfoJs+PsMndT-CjY1zg@mail.gmail.com>
Subject: Re: [PATCH 06/16] mmc: core: replace waitqueue with worker
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 10, 2017 at 3:21 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 10/03/17 00:49, Linus Walleij wrote:
>> On Wed, Feb 22, 2017 at 2:29 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 09/02/17 17:33, Linus Walleij wrote:

>>>> This is a central change that let us do many other changes since
>>>> we have broken the submit and complete code paths in two, and we
>>>> can potentially remove the NULL flushing of the asynchronous
>>>> pipeline and report block requests as finished directly from
>>>> the worker.
>>>
>>> This needs more thought.  The completion should go straight to the mmc block
>>> driver from the ->done() callback.  And from there straight back to the
>>> block layer if recovery is not needed.  We want to stop using
>>> mmc_start_areq() altogether because we never want to wait - we always want
>>> to issue (if possible) and return.
>>
>> I don't quite follow this. Isn't what you request exactly what
>> patch 15/16 "mmc: queue: issue requests in massive parallel"
>> is doing?
>
> There is the latency for the worker that runs mmc_finalize_areq() and then
> another latency to wake up the worker that is running mmc_start_areq().
> That is 2 wake-ups instead of 1.

That is correct (though the measured effect is small).

However when we switch to MQ it must happen like this due to its asynchronous
nature of issuing requests to us.

Then we have MQ's submission thread coming in from one en and our worker
to manage retries and errors on the other side. We obviously cannot do
the retries and resends in MQs context as it blocks subsequent requests.

> As a side note, ideally we would be able to issue the next request from the
> interrupt or soft interrupt context of the completion (i.e. 0 wake-ups
> between requests), but we would probably have to look at the host API to
> support that.

I looked at that and couldn't find a good way to get to that point.

Mainly because of mmc_start_bkops() that may
arbitrarily fire after every command and start new requests to the
card, and that of course require a process context to happen. Then there
is the retune thing that I do not fully understand how it schedules, but
it might be fine since I'm under the impression that it is done at the
start of the next request if need be. Maybe both can be overcome by
quick checks in IRQ context and then this can be done. (I'm not smart enough
to see that yet, sorry.)

However since we activate the blocking context in MQ I don't know
if it can even deal with having requests completed in interrupt context
so that the next thing that happens after completing the request and
returning from the interrupt is that the block layer thread gets scheduled
(unless something more important is going on), I guess it is possible?
It looks like it could be really efficient.

>>> For the blk-mq port, the queue thread should also be retained, partly
>>> because it solves some synchronization problems, but mostly because, at this
>>> stage, we anyway don't have solutions for all the different ways the driver
>>> can block.
>>> (as listed here https://marc.info/?l=linux-mmc&m=148336571720463&w=2 )
>>
>> Essentially I take out that thread and replace it with this one worker
>> introduced in this very patch. I agree the driver can block in many ways
>> and that is why I need to have it running in process context, and this
>> is what the worker introduced here provides.
>
> The last time I looked at the blk-mq I/O scheduler code, it pulled up to
> qdepth requests from the I/O scheduler and left them on a local list while
> running ->queue_rq().  That means blocking in ->queue_rq() leaves some
> number of requests in limbo (not issued but also not in the I/O scheduler)
> for that time.

I think Jens provided a patch for this bug (don't see the patch
upstream though).

Yours,
Linus Walleij
