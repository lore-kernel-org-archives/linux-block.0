Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180510211829.GC4787@localhost.localdomain>
References: <20180426123956.26039-1-ming.lei@redhat.com> <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain> <20180428035015.GB5657@ming.t460p>
 <20180508153038.GA30842@localhost.localdomain> <CACVXFVO+CuYghN3wHyHV2cskPr2pqaKKyQqQC5Xze4vCvpb+jg@mail.gmail.com>
 <20180510210548.GB4787@localhost.localdomain> <CACVXFVNvsjNS0Oi15RnYQm643w-YkFZJT7eKJ+tX_qzGcnu=4A@mail.gmail.com>
 <20180510211829.GC4787@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 11 May 2018 06:03:59 +0800
Message-ID: <CACVXFVPcxHkuJXPGgebqJLb8wL=6svUvMwfiLhafNR_9XTi3Ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, May 11, 2018 at 5:18 AM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Fri, May 11, 2018 at 05:10:40AM +0800, Ming Lei wrote:
>> On Fri, May 11, 2018 at 5:05 AM, Keith Busch
>> <keith.busch@linux.intel.com> wrote:
>> > On Fri, May 11, 2018 at 04:52:11AM +0800, Ming Lei wrote:
>> >> Hi Keith,
>> >>
>> >> On Tue, May 8, 2018 at 11:30 PM, Keith Busch <keith.busch@intel.com> wrote:
>> >> > On Sat, Apr 28, 2018 at 11:50:17AM +0800, Ming Lei wrote:
>> >> >> This sync may be raced with one timed-out request, which may be handled
>> >> >> as BLK_EH_HANDLED or BLK_EH_RESET_TIMER, so the above sync queues can't
>> >> >> work reliably.
>> >> >
>> >> > Ming,
>> >> >
>> >> > As proposed, that scenario is impossible to encounter. Resetting the
>> >> > controller inline with the timeout reaps all the commands, and then
>> >> > sets the controller state to RESETTING. While blk-mq may not allow the
>> >> > driver to complete those requests, having the driver sync with the queues
>> >> > will hold the controller in the reset state until blk-mq is done with
>> >> > its timeout work; therefore, it is impossible for the NVMe driver to
>> >> > return "BLK_EH_RESET_TIMER", and all commands will be completed through
>> >> > nvme_timeout's BLK_EH_HANDLED exactly as desired.
>> >>
>> >> That isn't true for multiple namespace case,  each request queue has its
>> >> own timeout work, and all these timeout work can be triggered concurrently.
>> >
>> > The controller state is most certainly not per queue/namespace. It's
>> > global to the controller. Once the reset is triggered, nvme_timeout can
>> > only return EH_HANDLED.
>>
>> It is related with EH_HANDLED, please see the following case:
>>
>> 1) when req A from N1 is timed out, nvme_timeout() handles
>> it as EH_HANDLED: nvme_dev_disable() and reset is scheduled.
>>
>> 2) when req B from N2 is timed out, nvme_timeout() handles
>> it as EH_HANDLED, then nvme_dev_disable() is called exactly
>> when reset is in-progress, so queues become quiesced, and nothing
>> can move on in the resetting triggered by N1.
>
> Huh? The nvme_sync_queues ensures that doesn't happen. That was the
> whole point.

Sorry, forget to mention, it isn't enough to simply sync timeout inside reset().

Another tricky thing is about freeze & unfreeze, now freeze is done in
nvme_dev_disable(), and unfreeze is done in nvme_reset_work. That means
we have to make sure both are paired, otherwise queues may be kept as
freeze for ever.

This issue is covered by my V4 & V5 too.

thanks,
Ming Lei
