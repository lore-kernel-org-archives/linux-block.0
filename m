Return-Path: <ming.lei@redhat.com>
Date: Tue, 1 May 2018 07:14:25 +0800
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
Message-ID: <20180430231417.GA25014@ming.t460p>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain>
 <20180428035015.GB5657@ming.t460p>
 <20180428133514.GB5938@localhost.localdomain>
 <CACVXFVMfvLLt7h58W-ifJKbC-s_1oDhCJEx4AqD6wJ+w2AjnYg@mail.gmail.com>
 <20180430195217.GD5938@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180430195217.GD5938@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 30, 2018 at 01:52:17PM -0600, Keith Busch wrote:
> On Sun, Apr 29, 2018 at 05:39:52AM +0800, Ming Lei wrote:
> > On Sat, Apr 28, 2018 at 9:35 PM, Keith Busch
> > <keith.busch@linux.intel.com> wrote:
> > > On Sat, Apr 28, 2018 at 11:50:17AM +0800, Ming Lei wrote:
> > >> > I understand how the problems are happening a bit better now. It used
> > >> > to be that blk-mq would lock an expired command one at a time, so when
> > >> > we had a batch of IO timeouts, the driver was able to complete all of
> > >> > them inside a single IO timeout handler.
> > >> >
> > >> > That's not the case anymore, so the driver is called for every IO
> > >> > timeout even though if it reaped all the commands at once.
> > >>
> > >> Actually there isn't the case before, even for legacy path, one .timeout()
> > >> handles one request only.
> > >
> > > That's not quite what I was talking about.
> > >
> > > Before, only the command that was about to be sent to the driver's
> > > .timeout() was marked completed. The driver could (and did) compete
> > > other timed out commands in a single .timeout(), and the tag would
> > > clear, so we could hanlde all timeouts in a single .timeout().
> > >
> > > Now, blk-mq marks all timed out commands as aborted prior to calling
> > > the driver's .timeout(). If the driver completes any of those commands,
> > > the tag does not clear, so the driver's .timeout() just gets to be called
> > > again for commands it already reaped.
> > 
> > That won't happen because new timeout model will mark aborted on timed-out
> > request first, then run synchronize_rcu() before making these requests
> > really expired, and now rcu lock is held in normal completion
> > handler(blk_mq_complete_request).
> > 
> > Yes, Bart is working towards that way, but there is still the same race
> > between timeout handler(nvme_dev_disable()) and reset_work(), and nothing
> > changes wrt. the timeout model:
> 
> Yeah, the driver makes sure there are no possible outstanding commands at
> the end of nvme_dev_disable. This should mean there's no timeout handler
> running because there's no possible commands for that handler. But that's
> not really the case anymore, so we had been inadvertently depending on
> that behavior.

I guess we may not depend on that behavior, because the timeout work
is per-request-queue(namespace), and timeout from all namespace/admin
queue may happen at the same time, meantime the .timeout() may be run
at different timing because of scheduling delay, and one of them may
cause nvme_dev_disable() to be called during resetting, not mention the
case of timeout triggered by reset_work().

That means we may have to drain timeout too even though Bart's patch is merged.

In short, there are several issues wrt. NVMe recovery:

1) timeout may be triggered in reset_work() by draining IO in
wait_freeze()

2) timeout still may be triggered by other queue, and nvme_dev_disable()
may be called during resetting which is scheduled by other queue's timeout

In both 1) and 2), queues can be quiesced and wait_freeze() in reset_work()
may never complete, then controller can't be recovered at all.

3) race related with start_freeze & unfreeze()


And it may be fixed by changing the model into the following two parts:

1) recovering controller:
- freeze queues
- nvme_dev_disable()
- resetting & setting up queues

2) post-reset or post-recovery
- wait for freezing & unfreezing

And make sure the #1 can always go on for recovering controller even
though that #2 is blocked by timeout.

If freezing can be removed, the #2 may not be necessary, but it may
cause more requests to be handled during recovering hardware, so it
is still reasonable to keep freezing as before.

> 
> > - reset may take a while to complete because of nvme_wait_freeze(), and
> > timeout can happen during resetting, then reset may hang forever. Even
> > without nvme_wait_freeze(), it is possible for timeout to happen during
> > reset work too in theory.
> >
> > Actually for non-shutdown, it isn't necessary to freeze queue at all, and it
> > is enough to just quiesce queues to make hardware happy for recovery,
> > that has been part of my V2 patchset.
> 
> When we freeze, we prevent IOs from entering contexts that may not be
> valid on the other side of the reset. It's not very common for the
> context count to change, but it can happen.
> 
> Anyway, will take a look at your series and catch up on the notes from
> you and Jianchao.

The V2 has been posted out, and freeze isn't removed, but moved to
post-reset.

The main approach should be fine in V2, but there are still issues
(the change may break the reset from other context, such as pci reset;
freezing caused by update_nr_hw_queues) in V2, and the implementation can
be simpler by partitioning the reset work into two parts simply.

I am working on V3, but any comments are welcome on V2, especially about
the taken approach.

Thanks,
Ming
