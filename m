Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751875AbdHGXRx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Aug 2017 19:17:53 -0400
Date: Tue, 8 Aug 2017 07:17:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH V2 00/20] blk-mq-sched: improve SCSI-MQ performance
Message-ID: <20170807231732.GB30140@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <df64b15d-a443-553c-a3c6-d834320648fd@redhat.com>
 <CAFfF4qv3W6D-j8BSSZbwPLqhd_mmwk8CZQe7dSqud8cMMd2yPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFfF4qv3W6D-j8BSSZbwPLqhd_mmwk8CZQe7dSqud8cMMd2yPg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 07, 2017 at 06:06:11PM -0400, Laurence Oberman wrote:
> On Mon, Aug 7, 2017 at 8:48 AM, Laurence Oberman <loberman@redhat.com>
> wrote:
> 
> >
> >
> > On 08/05/2017 02:56 AM, Ming Lei wrote:
> >
> >> In Red Hat internal storage test wrt. blk-mq scheduler, we
> >> found that I/O performance is much bad with mq-deadline, especially
> >> about sequential I/O on some multi-queue SCSI devcies(lpfc, qla2xxx,
> >> SRP...)
> >>
> >> Turns out one big issue causes the performance regression: requests
> >> are still dequeued from sw queue/scheduler queue even when ldd's
> >> queue is busy, so I/O merge becomes quite difficult to make, then
> >> sequential IO degrades a lot.
> >>
> >> The 1st five patches improve this situation, and brings back
> >> some performance loss.
> >>
> >> But looks they are still not enough. It is caused by
> >> the shared queue depth among all hw queues. For SCSI devices,
> >> .cmd_per_lun defines the max number of pending I/O on one
> >> request queue, which is per-request_queue depth. So during
> >> dispatch, if one hctx is too busy to move on, all hctxs can't
> >> dispatch too because of the per-request_queue depth.
> >>
> >> Patch 6 ~ 14 use per-request_queue dispatch list to avoid
> >> to dequeue requests from sw/scheduler queue when lld queue
> >> is busy.
> >>
> >> Patch 15 ~20 improve bio merge via hash table in sw queue,
> >> which makes bio merge more efficient than current approch
> >> in which only the last 8 requests are checked. Since patch
> >> 6~14 converts to the scheduler way of dequeuing one request
> >> from sw queue one time for SCSI device, and the times of
> >> acquring ctx->lock is increased, and merging bio via hash
> >> table decreases holding time of ctx->lock and should eliminate
> >> effect from patch 14.
> >>
> >> With this changes, SCSI-MQ sequential I/O performance is
> >> improved much, for lpfc, it is basically brought back
> >> compared with block legacy path[1], especially mq-deadline
> >> is improved by > X10 [1] on lpfc and by > 3X on SCSI SRP,
> >> For mq-none it is improved by 10% on lpfc, and write is
> >> improved by > 10% on SRP too.
> >>
> >> Also Bart worried that this patchset may affect SRP, so provide
> >> test data on SCSI SRP this time:
> >>
> >> - fio(libaio, bs:4k, dio, queue_depth:64, 64 jobs)
> >> - system(16 cores, dual sockets, mem: 96G)
> >>
> >>                |v4.13-rc3     |v4.13-rc3     | v4.13-rc3+patches |
> >>                |blk-legacy dd |blk-mq none   | blk-mq none  |
> >> -----------------------------------------------------------|
> >> read     :iops|         587K |         526K |         537K |
> >> randread :iops|         115K |         140K |         139K |
> >> write    :iops|         596K |         519K |         602K |
> >> randwrite:iops|         103K |         122K |         120K |
> >>
> >>
> >>                |v4.13-rc3     |v4.13-rc3     | v4.13-rc3+patches
> >>                |blk-legacy dd |blk-mq dd     | blk-mq dd    |
> >> ------------------------------------------------------------
> >> read     :iops|         587K |         155K |         522K |
> >> randread :iops|         115K |         140K |         141K |
> >> write    :iops|         596K |         135K |         587K |
> >> randwrite:iops|         103K |         120K |         118K |
> >>
> >> V2:
> >>         - dequeue request from sw queues in round roubin's style
> >>         as suggested by Bart, and introduces one helper in sbitmap
> >>         for this purpose
> >>         - improve bio merge via hash table from sw queue
> >>         - add comments about using DISPATCH_BUSY state in lockless way,
> >>         simplifying handling on busy state,
> >>         - hold ctx->lock when clearing ctx busy bit as suggested
> >>         by Bart
> >>
> >>
> >> [1] http://marc.info/?l=linux-block&m=150151989915776&w=2
> >>
> >> Ming Lei (20):
> >>    blk-mq-sched: fix scheduler bad performance
> >>    sbitmap: introduce __sbitmap_for_each_set()
> >>    blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
> >>    blk-mq-sched: move actual dispatching into one helper
> >>    blk-mq-sched: improve dispatching from sw queue
> >>    blk-mq-sched: don't dequeue request until all in ->dispatch are
> >>      flushed
> >>    blk-mq-sched: introduce blk_mq_sched_queue_depth()
> >>    blk-mq-sched: use q->queue_depth as hint for q->nr_requests
> >>    blk-mq: introduce BLK_MQ_F_SHARED_DEPTH
> >>    blk-mq-sched: introduce helpers for query, change busy state
> >>    blk-mq: introduce helpers for operating ->dispatch list
> >>    blk-mq: introduce pointers to dispatch lock & list
> >>    blk-mq: pass 'request_queue *' to several helpers of operating BUSY
> >>    blk-mq-sched: improve IO scheduling on SCSI devcie
> >>    block: introduce rqhash helpers
> >>    block: move actual bio merge code into __elv_merge
> >>    block: add check on elevator for supporting bio merge via hashtable
> >>      from blk-mq sw queue
> >>    block: introduce .last_merge and .hash to blk_mq_ctx
> >>    blk-mq-sched: refactor blk_mq_sched_try_merge()
> >>    blk-mq: improve bio merge from blk-mq sw queue
> >>
> >>   block/blk-mq-debugfs.c  |  12 ++--
> >>   block/blk-mq-sched.c    | 187 +++++++++++++++++++++++++++++-
> >> ------------------
> >>   block/blk-mq-sched.h    |  23 ++++++
> >>   block/blk-mq.c          | 133 +++++++++++++++++++++++++++++++---
> >>   block/blk-mq.h          |  73 +++++++++++++++++++
> >>   block/blk-settings.c    |   2 +
> >>   block/blk.h             |  55 ++++++++++++++
> >>   block/elevator.c        |  93 ++++++++++++++----------
> >>   include/linux/blk-mq.h  |   5 ++
> >>   include/linux/blkdev.h  |   5 ++
> >>   include/linux/sbitmap.h |  54 ++++++++++----
> >>   11 files changed, 504 insertions(+), 138 deletions(-)
> >>
> >>
> > Hello
> >
> > I tested this series using Ming's tests as well as my own set of tests
> > typically run against changes to upstream code in my SRP test-bed.
> > My tests also include very large sequential buffered and un-buffered I/O.
> >
> > This series seems to be fine for me. I did uncover another issue that is
> > unrelated to these patches and also exists in 4.13-RC3 generic that I am
> > still debugging.
> >
> > For what its worth:
> > Tested-by: Laurence Oberman <loberman@redhat.com>
> >
> >
> Hello
> 
> I need to retract my Tested-by:
> 
> While its valid that the patches do not introduce performance regressions,
> they seem to cause a hard lockup when the [mq-deadline] scheduler is
> enabled so I am not confident with a passing result here.
> 
> This is specific to large buffered I/O writes (4MB) At least that is my
> current test.
> 
> I did not wait long enough for the issue to show when I first sent the pass
> (Tested-by) message because I know my test platform so well I thought I had
> given it enough time to validate the patches for performance regressions.
> 
> I dont know if the failing clone in blk_get_request() is a direct a
> catalyst for the hard lockup but what I do know is with the stock upstream
> 4.13-RC3 I only see them when I am set to [none] and stock upstream never
> seems to see the hard lockup.

That might be triggered when the IOPS is much higher.

> 
> With [mq-deadline] enabled on stock I dont see them at all and it behaves.
> 
> Now with Ming's patches if we enable [mq-deadline] we DO see the clone
> failures

That should be easy to explain since this patchset improves IOPS by > 3X
on SRP in case of mq-deadline, and request allocation(GFP_ATOMIC) failure
can be triggered much easier.

> and the hard lockup so we have opposit behaviour with the
> scheduler choice and we have the hard lockup.

IMO, it is hard to say scheduler choice is related with this hard
lockup, since I/O scheduler only works in I/O submission path and
you still can trigger the issue with mq-none no matter if this
patchset is applied or not.

Today I still have some time, if you may provide me exact
reproduction steps, I am happy to take a look at it.

> On Ming's kernel with [none] we are well behaved and that was my original
> focus, testing on [none] and hence my Tested-by: pass.

OK, that is still a positive feedback, thanks for your test!


--
Ming
