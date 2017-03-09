Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <00989e26-cdb9-48d7-2e46-ae6ef66e59a7@intel.com>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-7-linus.walleij@linaro.org> <00989e26-cdb9-48d7-2e46-ae6ef66e59a7@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Mar 2017 23:49:19 +0100
Message-ID: <CACRpkdYOyEs8vxmPt1kGiKJrw8+16DyD8Nn=ke6mgxPaCQynCw@mail.gmail.com>
Subject: Re: [PATCH 06/16] mmc: core: replace waitqueue with worker
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 22, 2017 at 2:29 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/02/17 17:33, Linus Walleij wrote:
>> The waitqueue in the host context is there to signal back from
>> mmc_request_done() through mmc_wait_data_done() that the hardware
>> is done with a command, and when the wait is over, the core
>> will typically submit the next asynchronous request that is pending
>> just waiting for the hardware to be available.
>>
>> This is in the way for letting the mmc_request_done() trigger the
>> report up to the block layer that a block request is finished.
>>
>> Re-jig this as a first step, remvoving the waitqueue and introducing
>> a work that will run after a completed asynchronous request,
>> finalizing that request, including retransmissions, and eventually
>> reporting back with a completion and a status code to the
>> asynchronous issue method.
>>
>> This had the upside that we can remove the MMC_BLK_NEW_REQUEST
>> status code and the "new_request" state in the request queue
>> that is only there to make the state machine spin out
>> the first time we send a request.
>>
>> Introduce a workqueue in the host for handling just this, and
>> then a work and completion in the asynchronous request to deal
>> with this mechanism.
>>
>> This is a central change that let us do many other changes since
>> we have broken the submit and complete code paths in two, and we
>> can potentially remove the NULL flushing of the asynchronous
>> pipeline and report block requests as finished directly from
>> the worker.
>
> This needs more thought.  The completion should go straight to the mmc block
> driver from the ->done() callback.  And from there straight back to the
> block layer if recovery is not needed.  We want to stop using
> mmc_start_areq() altogether because we never want to wait - we always want
> to issue (if possible) and return.

I don't quite follow this. Isn't what you request exactly what
patch 15/16 "mmc: queue: issue requests in massive parallel"
is doing?

The whole patch series leads up to that.

> The core API to use is __mmc_start_req() but the block driver should
> populate mrq->done with its own handler. i.e. change __mmc_start_req()
>
> -       mrq->done = mmc_wait_done;
> +       if (!mrq->done)
> +               mrq->done = mmc_wait_done;
>
> mrq->done() would complete the request (e.g. via blk_complete_request()) if
> it has no errors (and doesn't need polling), and wake up the queue thread to
> finish up everything else and start the next request.

I think this is what it does at the end of the patch series, patch 15/16.
I have to split it somehow...

> For the blk-mq port, the queue thread should also be retained, partly
> because it solves some synchronization problems, but mostly because, at this
> stage, we anyway don't have solutions for all the different ways the driver
> can block.
> (as listed here https://marc.info/?l=linux-mmc&m=148336571720463&w=2 )

Essentially I take out that thread and replace it with this one worker
introduced in this very patch. I agree the driver can block in many ways
and that is why I need to have it running in process context, and this
is what the worker introduced here provides.

Maybe I'm getting something backwards, sorry then :/

Yours,
Linus Walleij
