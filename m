Return-Path: <stern+5b5b8f2e@rowland.harvard.edu>
Date: Fri, 13 Jul 2018 16:27:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Jens Axboe <axboe@kernel.dk>
cc: Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
    linux-block <linux-block@vger.kernel.org>,
    "Rafael J. Wysocki" <rjw@rjwysocki.net>,
    Linux PM List <linux-pm@vger.kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
    "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
    "Martin K. Petersen" <martin.petersen@oracle.com>,
    Linux SCSI List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH RFC 3/4] blk-mq: prepare for supporting runtime PM
In-Reply-To: <3a143e61-ea80-a998-b38d-b57d88d5de3c@kernel.dk>
Message-ID: <Pine.LNX.4.44L0.1807131618160.10216-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 13 Jul 2018, Jens Axboe wrote:

> >>> Any idea for avoiding the race without using sync like seqlock or others?
> >>
> >> I just don't want anything like this in the hot path. Why can't we
> >> handle this similarly to how we handle request timeouts? It'll
> >> potentially delay the suspend by a few seconds, but surely that can't be
> >> a big deal. I don't see why we need to track this on a per-request
> >> basis.
> > 
> > For legacy path, there is the queue lock, so no the race mentioned.
> > 
> > I guess you mean why we can't use RCU style to deal with this issue, so
> > we don't introduce cost in fast path, but the problem is that IO has
> > to be submitted to one active hardware, that is one invariant of runtime
> > PM.
> > 
> > So RCU/SRCU won't fix this issue because the rcu_read_lock sync nothing,
> > and we have to make sure that hardware is ready before dispatching IO to
> > hardware/driver. That is why I think sort of sync is required in IO path.
> 
> That's not what I meant at all. As I wrote above, I don't want it in the
> hot path at all, and certainly not as a per-request thing. We already
> have a timer on blk-mq that runs while requests are pending, by
> definition the last time that timer triggers, the device is idle. If you
> need to do heavier lifting to ensure we only runtime suspend at that
> point, then THAT'S the place to do it, not adding extra code per
> request. I don't care how cheap the perceived locking is, it's still
> extra code and checks for each and every request. That is what I am
> objecting to.

The problem occurs on the opposite side: when a new request is added,
we don't want it to race with a just-started suspend transition.  Can
you suggest a way to prevent this without adding any overhead to the
hot path?

For that matter, we also have the issue of checking whether the device
is already suspended when a request is added; in that case we have to
resume the device before issuing the request.  I'm not aware of any way
to avoid performing this check in the hot path.

Is there already some synchronization in place for plugging or stopping 
a request queue?  If there is, could the runtime-PM code make use of 
it?  We might need to add a state in which a queue is blocked for 
normal requests but allows PM-related request to run.

Alan Stern
