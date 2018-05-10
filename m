Return-Path: <ming.lei@redhat.com>
Date: Fri, 11 May 2018 05:24:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
Message-ID: <20180510212444.GC3515@ming.t460p>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain>
 <20180428035015.GB5657@ming.t460p>
 <20180508153038.GA30842@localhost.localdomain>
 <CACVXFVO+CuYghN3wHyHV2cskPr2pqaKKyQqQC5Xze4vCvpb+jg@mail.gmail.com>
 <20180510210548.GB4787@localhost.localdomain>
 <CACVXFVNvsjNS0Oi15RnYQm643w-YkFZJT7eKJ+tX_qzGcnu=4A@mail.gmail.com>
 <20180510211829.GC4787@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180510211829.GC4787@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 03:18:29PM -0600, Keith Busch wrote:
> On Fri, May 11, 2018 at 05:10:40AM +0800, Ming Lei wrote:
> > On Fri, May 11, 2018 at 5:05 AM, Keith Busch
> > <keith.busch@linux.intel.com> wrote:
> > > On Fri, May 11, 2018 at 04:52:11AM +0800, Ming Lei wrote:
> > >> Hi Keith,
> > >>
> > >> On Tue, May 8, 2018 at 11:30 PM, Keith Busch <keith.busch@intel.com> wrote:
> > >> > On Sat, Apr 28, 2018 at 11:50:17AM +0800, Ming Lei wrote:
> > >> >> This sync may be raced with one timed-out request, which may be handled
> > >> >> as BLK_EH_HANDLED or BLK_EH_RESET_TIMER, so the above sync queues can't
> > >> >> work reliably.
> > >> >
> > >> > Ming,
> > >> >
> > >> > As proposed, that scenario is impossible to encounter. Resetting the
> > >> > controller inline with the timeout reaps all the commands, and then
> > >> > sets the controller state to RESETTING. While blk-mq may not allow the
> > >> > driver to complete those requests, having the driver sync with the queues
> > >> > will hold the controller in the reset state until blk-mq is done with
> > >> > its timeout work; therefore, it is impossible for the NVMe driver to
> > >> > return "BLK_EH_RESET_TIMER", and all commands will be completed through
> > >> > nvme_timeout's BLK_EH_HANDLED exactly as desired.
> > >>
> > >> That isn't true for multiple namespace case,  each request queue has its
> > >> own timeout work, and all these timeout work can be triggered concurrently.
> > >
> > > The controller state is most certainly not per queue/namespace. It's
> > > global to the controller. Once the reset is triggered, nvme_timeout can
> > > only return EH_HANDLED.
> > 
> > It is related with EH_HANDLED, please see the following case:
> > 
> > 1) when req A from N1 is timed out, nvme_timeout() handles
> > it as EH_HANDLED: nvme_dev_disable() and reset is scheduled.
> > 
> > 2) when req B from N2 is timed out, nvme_timeout() handles
> > it as EH_HANDLED, then nvme_dev_disable() is called exactly
> > when reset is in-progress, so queues become quiesced, and nothing
> > can move on in the resetting triggered by N1.
> 
> Huh? The nvme_sync_queues ensures that doesn't happen. That was the
> whole point.

Could you share me the link?

Firstly, the previous nvme_sync_queues() won't work reliably, so this
patch introduces blk_unquiesce_timeout() and blk_quiesce_timeout() for
this purpose.

Secondly, I remembered that you only call nvme_sync_queues() at the
entry of nvme_reset_work(), but timeout(either admin or normal IO)
can happen again during resetting, that is another race addressed by
this patchset, but can't cover by your proposal.

Thanks,
Ming
