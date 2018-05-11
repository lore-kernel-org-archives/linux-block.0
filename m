Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180510210548.GB4787@localhost.localdomain>
References: <20180426123956.26039-1-ming.lei@redhat.com> <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain> <20180428035015.GB5657@ming.t460p>
 <20180508153038.GA30842@localhost.localdomain> <CACVXFVO+CuYghN3wHyHV2cskPr2pqaKKyQqQC5Xze4vCvpb+jg@mail.gmail.com>
 <20180510210548.GB4787@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 11 May 2018 10:10:36 +0800
Message-ID: <CACVXFVPwMT9utux3+h0JokdRvE15KB0+GJgN_Y79odJ=5674-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>,
	Ming Lei <ming.lei@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, May 11, 2018 at 5:05 AM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Fri, May 11, 2018 at 04:52:11AM +0800, Ming Lei wrote:
>> Hi Keith,
>>
>> On Tue, May 8, 2018 at 11:30 PM, Keith Busch <keith.busch@intel.com> wrote:
>> > On Sat, Apr 28, 2018 at 11:50:17AM +0800, Ming Lei wrote:
>> >> This sync may be raced with one timed-out request, which may be handled
>> >> as BLK_EH_HANDLED or BLK_EH_RESET_TIMER, so the above sync queues can't
>> >> work reliably.
>> >
>> > Ming,
>> >
>> > As proposed, that scenario is impossible to encounter. Resetting the
>> > controller inline with the timeout reaps all the commands, and then
>> > sets the controller state to RESETTING. While blk-mq may not allow the
>> > driver to complete those requests, having the driver sync with the queues
>> > will hold the controller in the reset state until blk-mq is done with
>> > its timeout work; therefore, it is impossible for the NVMe driver to
>> > return "BLK_EH_RESET_TIMER", and all commands will be completed through
>> > nvme_timeout's BLK_EH_HANDLED exactly as desired.
>>
>> That isn't true for multiple namespace case,  each request queue has its
>> own timeout work, and all these timeout work can be triggered concurrently.
>
> The controller state is most certainly not per queue/namespace. It's
> global to the controller. Once the reset is triggered, nvme_timeout can
> only return EH_HANDLED.

One exception is PCI error recovery, in which EH_RESET_TIMER still
may be returned any time.

Also the two timeout can happen at the same time from more than one
NS, just before resetting is started(before updating to NVME_CTRL_RESETTING).

OR one timeout is from admin queue, another one is from NS, both happen
at the same time, still before updating to NVME_CTRL_RESETTING.

In above two situations, one timeout can be handled as EH_HANDLED, and
another can be handled as EH_RESET_TIMER.

So it isn't enough to drain timeout by blk_sync_queue() simply.


Thanks,
Ming Lei
