Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180508153038.GA30842@localhost.localdomain>
References: <20180426123956.26039-1-ming.lei@redhat.com> <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain> <20180428035015.GB5657@ming.t460p>
 <20180508153038.GA30842@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 11 May 2018 04:52:11 +0800
Message-ID: <CACVXFVO+CuYghN3wHyHV2cskPr2pqaKKyQqQC5Xze4vCvpb+jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
To: Keith Busch <keith.busch@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>,
	linux-block <linux-block@vger.kernel.org>, Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Keith,

On Tue, May 8, 2018 at 11:30 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Sat, Apr 28, 2018 at 11:50:17AM +0800, Ming Lei wrote:
>> This sync may be raced with one timed-out request, which may be handled
>> as BLK_EH_HANDLED or BLK_EH_RESET_TIMER, so the above sync queues can't
>> work reliably.
>
> Ming,
>
> As proposed, that scenario is impossible to encounter. Resetting the
> controller inline with the timeout reaps all the commands, and then
> sets the controller state to RESETTING. While blk-mq may not allow the
> driver to complete those requests, having the driver sync with the queues
> will hold the controller in the reset state until blk-mq is done with
> its timeout work; therefore, it is impossible for the NVMe driver to
> return "BLK_EH_RESET_TIMER", and all commands will be completed through
> nvme_timeout's BLK_EH_HANDLED exactly as desired.

That isn't true for multiple namespace case,  each request queue has its
own timeout work, and all these timeout work can be triggered concurrently.

>
> Could you please recheck my suggestion? The alternatives proposed are
> far too risky for a 4.17 consideration, and I'm hoping we can stabilize
> this behavior in the current release if possible.

Bart's rework on timeout won't cover the case of multiple namespace, so
we have to sync timeout inside driver.

The approach taken in my V4 has been simpler, could you take a look at it?

Thanks,
Ming Lei
