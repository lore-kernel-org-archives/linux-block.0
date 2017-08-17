Return-Path: <axboe@kernel.dk>
Subject: Re: [RFC PATCH] nvme: always return IRQ_HANDLED
To: Keith Busch <keith.busch@intel.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>
References: <06b85884-efb4-e419-4b31-3aa4751bb338@kernel.dk>
 <20170817201526.GA21397@localhost.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <60b6e2b7-86d1-d5c7-66af-e771d17384b8@kernel.dk>
Date: Thu, 17 Aug 2017 14:17:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170817201526.GA21397@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/17/2017 02:15 PM, Keith Busch wrote:
> On Thu, Aug 17, 2017 at 01:32:20PM -0600, Jens Axboe wrote:
>> We currently have an issue with nvme when polling is used. Just
>> ran some testing on 4.13-rc5, and it's trivial to trigger an IRQ
>> disable ala:
>>
>> [   52.412851] irq 77: nobody cared (try booting with the "irqpoll" option)
>> [   52.415310] irq 70: nobody cared (try booting with the "irqpoll" option)
>>
>> when running a few processes polling. The reason is pretty obvious - if
>> we're effective at polling, the triggered IRQ will never find any
>> events. If this happens enough times in a row, the kernel disables our
>> IRQ since we keep returning IRQ_NONE.
> 
> If you're seeing IRQ_NONE returned, the NVMe driver didn't poll any
> completions since the last time nvme_irq was called. The cqe_seen on
> polled compeletions is sticky until the IRQ handler is run, in which
> case it returns IRQ_HANDLED even when no completions were handled during
> that interrupt.
> 
> The only way it should be able to return IRQ_NONE is if no completions
> were observed (polled or otherwise) since the last time the IRQ handler
> was called.

The polling do not update the cqe_seen. So it's possible that every time
the IRQ handler does trigger, there are no entries found. Maybe a better
or simpler fix would be to have the polling set cqe_seen to true, and
leave the clearing to the interrupt handler as is done now.

>> Question is, what's the best way to solve this. Ideally we should not be
>> triggering an IRQ at all, but that's still not in mainline. Can we
>> safely just return IRQ_HANDLED always? That should work except for the
>> case where we happen to run into an IRQ flood where DO want to turn off
>> the nvme irq. For now, I think that's small price to pay, since the
>> current issue is much worse and leaves the device in a weird non-working
>> state where some queue interrupts are turned off.
> 
> My recommended way to get this handled is to enable interrupt coalescing
> and have controllers behave as the specification describes to suppress
> interrupts when polling is active. From section 5.21.1.8:
> 
>   Specifically, if the Completion Queue Head Doorbell register is being
>   updated that is associated with a particular interrupt vector, then
>   the controller has a positive indication that completion queue entries
>   are already being processed. In this case, the aggregation time and/or
>   the aggregation threshold may be reset/restarted upon the associated
>   register write. This may result in interrupts being delayed indefinitely
>   in certain workloads where the aggregation time or aggregation threshold
>   is non-zero.

That would indeed be much better, and not require is to fiddle with IRQ
less completion queues for more efficient polling. Of the test devices that
I do use, not all of them support coalescing, and of the ones that do, some
of them implement it in a pretty poor fashion.

-- 
Jens Axboe
