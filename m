Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754454AbdHYKTz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 06:19:55 -0400
Date: Fri, 25 Aug 2017 18:19:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V2 06/20] blk-mq-sched: don't dequeue request until all
 in ->dispatch are flushed
Message-ID: <20170825101944.GA13872@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-7-ming.lei@redhat.com>
 <20170823195648.GA15083@kernel.dk>
 <20170824063835.GH12966@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170824063835.GH12966@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 24, 2017 at 02:38:36PM +0800, Ming Lei wrote:
> On Wed, Aug 23, 2017 at 01:56:50PM -0600, Jens Axboe wrote:
> > On Sat, Aug 05 2017, Ming Lei wrote:
> > > During dispatching, we moved all requests from hctx->dispatch to
> > > one temporary list, then dispatch them one by one from this list.
> > > Unfortunately duirng this period, run queue from other contexts
> > > may think the queue is idle, then start to dequeue from sw/scheduler
> > > queue and still try to dispatch because ->dispatch is empty. This way
> > > hurts sequential I/O performance because requests are dequeued when
> > > lld queue is busy.
> > > 
> > > This patch introduces the state of BLK_MQ_S_DISPATCH_BUSY to
> > > make sure that request isn't dequeued until ->dispatch is
> > > flushed.
> > 
> > I don't like how this patch introduces a bunch of locked setting of a
> > flag under the hctx lock. Especially since I think we can easily avoid
> > it.
> 
> Actually the lock isn't needed for setting the flag, will move it out
> in V3.

My fault, looks we can't move it out of the lock, because the new
added rqs can be flushed with the bit cleared together just
between adding list to ->dispatch and setting BLK_MQ_S_DISPATCH_BUSY,
then the bit is never cleared and I/O hang is caused.

> 
> > 
> > > -	} else if (!has_sched_dispatch & !q->queue_depth) {
> > > +		blk_mq_dispatch_rq_list(q, &rq_list);
> > > +
> > > +		/*
> > > +		 * We may clear DISPATCH_BUSY just after it
> > > +		 * is set from another context, the only cost
> > > +		 * is that one request is dequeued a bit early,
> > > +		 * we can survive that. Given the window is
> > > +		 * too small, no need to worry about performance
> > > +		 * effect.
> > > +		 */
> > > +		if (list_empty_careful(&hctx->dispatch))
> > > +			clear_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
> > 
> > This is basically the only place where we modify it without holding the
> > hctx lock. Can we move it into blk_mq_dispatch_rq_list()? The list is
> 
> The problem is that blk_mq_dispatch_rq_list() don't know if it is
> handling requests from hctx->dispatch or sw/scheduler queue. We only
> need to clear the bit after hctx->dispatch is flushed. So the clearing
> can't be moved into blk_mq_dispatch_rq_list().
> 
> > generally empty, unless for the case where we splice residuals back. If
> > we splice them back, we grab the lock anyway.
> > 
> > The other places it's set under the hctx lock, yet we end up using an
> > atomic operation to do it.

In theory, it is better to hold the lock to clear the bit, but
with cost of one extra lock acquiring no matter moving it to
blk_mq_dispatch_rq_list() or not.

We can move clear_bit() into blk_mq_dispatch_rq_list() and
pass one parameter to indicate if it is handling requests
from ->dispatch or not, the following code is needed at
the end of blk_mq_dispatch_rq_list():

	if (list_empty(list)) {
		if (rq_from_dispatch_list) {
			spin_lock(&hctx->lock);
			if (list_empty_careful(&hctx->dispatch))
				clear_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
			spin_unlock(&hctx->lock);
		}
	}

If we clear the bit lockless, the BUSY bit may be cleared early, then
dequeue early, that is what we can accept because the race window is
so small.

-- 
Ming
