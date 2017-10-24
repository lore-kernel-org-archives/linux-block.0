Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdJXKEa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2017 06:04:30 -0400
Date: Tue, 24 Oct 2017 18:04:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 1/1] [RFC] blk-mq: fix queue stalling on shared hctx
 restart
Message-ID: <20171024100413.GB25654@ming.t460p>
References: <20171018102206.26020-1-roman.penyaev@profitbricks.com>
 <20171020133943.GA31275@ming.t460p>
 <CAJrWOzBKTAsCrrg7nGp95ShDdZybKq6tGH9yA33GqwMXvfokCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJrWOzBKTAsCrrg7nGp95ShDdZybKq6tGH9yA33GqwMXvfokCg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 23, 2017 at 06:12:29PM +0200, Roman Penyaev wrote:
> Hi Ming,
> 
> On Fri, Oct 20, 2017 at 3:39 PM, Ming Lei <ming.lei@redhat.com> wrote:
> > On Wed, Oct 18, 2017 at 12:22:06PM +0200, Roman Pen wrote:
> >> Hi all,
> >>
> >> the patch below fixes queue stalling when shared hctx marked for restart
> >> (BLK_MQ_S_SCHED_RESTART bit) but q->shared_hctx_restart stays zero.  The
> >> root cause is that hctxs are shared between queues, but 'shared_hctx_restart'
> >> belongs to the particular queue, which in fact may not need to be restarted,
> >> thus we return from blk_mq_sched_restart() and leave shared hctx of another
> >> queue never restarted.
> >>
> >> The fix is to make shared_hctx_restart counter belong not to the queue, but
> >> to tags, thereby counter will reflect real number of shared hctx needed to
> >> be restarted.
> >>
> >> During tests 1 hctx (set->nr_hw_queues) was used and all stalled requests
> >> were noticed in dd->fifo_list of mq-deadline scheduler.
> >>
> >> Seeming possible sequence of events:
> >>
> >> 1. Request A of queue A is inserted into dd->fifo_list of the scheduler.
> >>
> >> 2. Request B of queue A bypasses scheduler and goes directly to
> >>    hctx->dispatch.
> >>
> >> 3. Request C of queue B is inserted.
> >>
> >> 4. blk_mq_sched_dispatch_requests() is invoked, since hctx->dispatch is not
> >>    empty (request B is in the list) hctx is only marked for for next restart
> >>    and request A is left in a list (see comment "So it's best to leave them
> >>    there for as long as we can. Mark the hw queue as needing a restart in
> >>    that case." in blk-mq-sched.c)
> >>
> >> 5. Eventually request B is completed/freed and blk_mq_sched_restart() is
> >>    called, but by chance hctx from queue B is chosen for restart and request C
> >>    gets a chance to be dispatched.
> >>
> >> 6. Eventually request C is completed/freed and blk_mq_sched_restart() is
> >>    called, but shared_hctx_restart for queue B is zero and we return without
> >>    attempt to restart hctx from queue A, thus request A is stuck forever.
> >>
> >> But stalling queue is not the only one problem with blk_mq_sched_restart().
> >> My tests show that those loops thru all queues and hctxs can be very costly,
> >> even with shared_hctx_restart counter, which aims to fix performance issue.
> >> For my tests I create 128 devices with 64 hctx each, which share same tags
> >> set.
> >
> > Hi Roman,
> >
> > I also find the performance issue with RESTART for TAG_SHARED.
> >
> > But from my analysis, RESTART isn't needed for TAG_SHARED
> > because SCSI-MQ has handled the RESTART by itself already, so
> > could you test the patch in following link posted days ago to
> > see if it fixes your issue?
> 
> I can say without any testing: it fixes all the issues :) You've
> reverted
> 
>    8e8320c9315c ("blk-mq: fix performance regression with shared tags")
>    6d8c6c0f97ad ("blk-mq: Restart a single queue if tag sets are shared")
> 
> with one major difference: you do not handle shared tags in a special
> way and restart only requested hctx, instead of iterating over all hctxs
> in a queue.

Hi Roman,

Yeah, that is unnecessary as I explained in detail in the commit log and
introduces lots of overhead, and I can see IOPS is improved by 20%~30% in
my SCSI_DEBUG test(only 8 luns) by removing the blk-mq restart for TAG_SHARED.

Also it isn't needed for BLK_STS_RESOURCE returned from .get_budget().

I will post out V3 soon. 

> 
> Firstly I have to say that queue stalling issue(#1) and performance
> issue(#2) were observed on our in-house rdma driver IBNBD:
> https://lwn.net/Articles/718181/ and I've never tried to reproduce
> them on SCSI-MQ.

OK, got it, then you can handle it in SCSI-MQ's way since this way
is used by non-MQ for long time. Or you need to do nothing if your
driver is SCSI based.

> 
> Then your patch brakes RR restarts, which were introduced by this commit
> 6d8c6c0f97ad ("blk-mq: Restart a single queue if tag sets are shared").
> Seems basic idea of that patch is nice, but because of possible big
> amount of queues and hctxs patch requires reimplementation.  Eventually
> you should get fast hctx restart but in RR fashion. According to my
> understanding that does not contradict with your patch.

Firstly this way has been run/verified for long time in non-mq, and no one
complained it before.

Secondly please see scsi_target_queue_ready() and scsi_host_queue_ready(),
the sdev is added into the 'starved_list' in FIFO style, which is still fair.

So I don't think it is an issue to remove the RR restarts.

Thanks,
Ming
