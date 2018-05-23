Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 23 May 2018 10:48:23 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V2] blk-mq: avoid to starve tag allocation after
 allocation process migrates
Message-ID: <20180523174823.GC12533@vader>
References: <20180519074406.6045-1-ming.lei@redhat.com>
 <7a4499e8-60bb-892a-91cf-f2d2c4be74b7@kernel.dk>
 <20180523093225.GA32067@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523093225.GA32067@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 23, 2018 at 05:32:31PM +0800, Ming Lei wrote:
> On Tue, May 22, 2018 at 09:59:17PM -0600, Jens Axboe wrote:
> > On 5/19/18 1:44 AM, Ming Lei wrote:
> > > When the allocation process is scheduled back and the mapped hw queue is
> > > changed, do one extra wake up on orignal queue for compensating wake up
> > > miss, so other allocations on the orignal queue won't be starved.
> > > 
> > > This patch fixes one request allocation hang issue, which can be
> > > triggered easily in case of very low nr_request.
> > 
> > Trying to think of better ways we can fix this, but I don't see
> > any right now. Getting rid of the wake_up_nr() kills us on tons
> > of tasks waiting. 
> 
> I am not sure if I understand your point, but this issue isn't related
> with wake_up_nr() actually, and it can be reproduced after reverting
> 4e5dff41be7b5201c1c47c (blk-mq: improve heavily contended tag case).
> 
> All tasks in current sbq_wait_state may be scheduled to other CPUs, and
> there may still be tasks waiting for allocation from this sbitmap_queue,
> and the root cause is about cross-queue allocation, as you said,
> there are too many queues, :-)

I don't follow. Your description of the problem was that we have two
waiters and only wake up one, which doesn't in turn allocate and free a
tag and wake up the second waiter. Changing it back to wake_up_nr()
eliminates that problem. And if waking up everything doesn't fix it, how
does your fix of waking up a few extra tasks fix it?
