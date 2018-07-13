Return-Path: <ming.lei@redhat.com>
Date: Sat, 14 Jul 2018 06:47:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <tom.leiming@gmail.com>,
	linux-block <linux-block@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM List <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH RFC 3/4] blk-mq: prepare for supporting runtime PM
Message-ID: <20180713224653.GA6589@ming.t460p>
References: <Pine.LNX.4.44L0.1807131618160.10216-100000@netrider.rowland.org>
 <2b92c400-b299-d2d8-5c7b-94614179522c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2b92c400-b299-d2d8-5c7b-94614179522c@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 13, 2018 at 02:39:15PM -0600, Jens Axboe wrote:
> On 7/13/18 2:27 PM, Alan Stern wrote:
> > On Fri, 13 Jul 2018, Jens Axboe wrote:
> > 
> >>>>> Any idea for avoiding the race without using sync like seqlock or others?
> >>>>
> >>>> I just don't want anything like this in the hot path. Why can't we
> >>>> handle this similarly to how we handle request timeouts? It'll
> >>>> potentially delay the suspend by a few seconds, but surely that can't be
> >>>> a big deal. I don't see why we need to track this on a per-request
> >>>> basis.
> >>>
> >>> For legacy path, there is the queue lock, so no the race mentioned.
> >>>
> >>> I guess you mean why we can't use RCU style to deal with this issue, so
> >>> we don't introduce cost in fast path, but the problem is that IO has
> >>> to be submitted to one active hardware, that is one invariant of runtime
> >>> PM.
> >>>
> >>> So RCU/SRCU won't fix this issue because the rcu_read_lock sync nothing,
> >>> and we have to make sure that hardware is ready before dispatching IO to
> >>> hardware/driver. That is why I think sort of sync is required in IO path.
> >>
> >> That's not what I meant at all. As I wrote above, I don't want it in the
> >> hot path at all, and certainly not as a per-request thing. We already
> >> have a timer on blk-mq that runs while requests are pending, by
> >> definition the last time that timer triggers, the device is idle. If you
> >> need to do heavier lifting to ensure we only runtime suspend at that
> >> point, then THAT'S the place to do it, not adding extra code per
> >> request. I don't care how cheap the perceived locking is, it's still
> >> extra code and checks for each and every request. That is what I am
> >> objecting to.
> > 
> > The problem occurs on the opposite side: when a new request is added,
> > we don't want it to race with a just-started suspend transition.  Can
> > you suggest a way to prevent this without adding any overhead to the
> > hot path?
> > 
> > For that matter, we also have the issue of checking whether the device
> > is already suspended when a request is added; in that case we have to
> > resume the device before issuing the request.  I'm not aware of any way
> > to avoid performing this check in the hot path.
> 
> The issue is on both sides, of course. The problem, to me, appears to be
> attempting to retrofit the old pre-suspend checking to blk-mq, where it
> could be done a lot more optimally by having the suspend side be driven
> by the timeout timer, and

Timeout timer won't be one accepted way from user view since the default
timeout is 30s, but autosuspend delay may be just several seconds, but
that isn't the current problem.

Now the problem isn't in suspend side, I did think about this way.
The issue is that we could enter suspending when queue isn't idle, like
there are only RQF_PM requests pended.

> resume could be driven by first request entering on an idle queue.

The 1st request may be RQF_PM request.

> 
> Doing a per-request inc/dec type of tracking with synchronization is the
> easy approach/lazy approach, but it's also woefully inefficient. Any
> sort of per-queue tracking for blk-mq is not a great idea.
> 
> > Is there already some synchronization in place for plugging or stopping 
> > a request queue?  If there is, could the runtime-PM code make use of 
> > it?  We might need to add a state in which a queue is blocked for 
> > normal requests but allows PM-related request to run.
> 
> Sure, blk-mq has a plethora of helpers for that, since we use it in
> other places as well. And it might not be a bad idea to extend that to
> cover this case as well. See blk_queue_enter() and the queue freeze and
> queuescing. This is already per-request overhead we're paying.

Before entering runtime suspend, there can't be any normal in-flight IO, so
quiesce won't work since quiesce only prevents new dispatching and doesn't
drain queue.

Freeze might work, but blk_queue_enter() will becomes a bit complicated:

1) queue freeze can be done before runtime suspending

2) when any new IO comes, the queue has to be unfrozen.

3) when any RQF_PM request comes, the queue has to be kept in freezing,
and allows this request to be crossed.

I will think about this approach further and see if it can be done in
easy way.


Thanks,
Ming
