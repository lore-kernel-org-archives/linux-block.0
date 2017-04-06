Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdDFIXx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 04:23:53 -0400
Date: Thu, 6 Apr 2017 16:23:42 +0800
From: Ming Lei <minlei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 1/8] blk-mq: use the right hctx when getting a driver
 tag fails
Message-ID: <20170406082330.GA3863@ming.t460p>
References: <cover.1491418411.git.osandov@fb.com>
 <d1b5da71a5cba1f17d4eaafb207547a4651f81a9.1491418411.git.osandov@fb.com>
 <20170406043108.GA29955@ming.t460p>
 <20170406075751.GA15461@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406075751.GA15461@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 06, 2017 at 12:57:51AM -0700, Omar Sandoval wrote:
> On Thu, Apr 06, 2017 at 12:31:18PM +0800, Ming Lei wrote:
> > On Wed, Apr 05, 2017 at 12:01:29PM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > While dispatching requests, if we fail to get a driver tag, we mark the
> > > hardware queue as waiting for a tag and put the requests on a
> > > hctx->dispatch list to be run later when a driver tag is freed. However,
> > > blk_mq_dispatch_rq_list() may dispatch requests from multiple hardware
> > > queues if using a single-queue scheduler with a multiqueue device. If
> > 
> > It can't perform well by using a SQ scheduler on a MQ device, so just be
> > curious why someone wants to do that in this way,:-)
> 
> I don't know why anyone would want to, but it has to work :) The only
> reason we noticed this is because when the NBD device is created, it
> only has a single queue, so we automatically assign mq-deadline to it.
> Later, we update the number of queues, but it's still using mq-deadline.
> 
> > I guess you mean that ops.mq.dispatch_request() may dispatch requests
> > from other hardware queues in blk_mq_sched_dispatch_requests() instead
> > of current hctx.
> 
> Yup, that's right. It's weird, and I talked to Jens about just forcing
> the MQ device into an SQ mode when using an SQ scheduler, but this way
> works fine more or less.

Or just switch the elevator to the MQ default one when the device becomes
MQ? Or let mq-deadline's .dispatch_request() just return reqs in current
hctx?

> 
> > If that is true, it looks like a issue in usage of I/O scheduler, since
> > the mq-deadline scheduler just queues requests in one per-request_queue
> > linked list, for MQ device, the scheduler queue should have been per-hctx.
> 
> That's an option, but that's a different scheduling policy. Again, I
> agree that it's strange, but it's reasonable behavior.

IMO, the current mq-deadline isn't good/ready for MQ device, and it
doesn't make sense to use it for MQ.

> 
> > > blk_mq_get_driver_tag() fails, it doesn't update the hardware queue we
> > > are processing. This means we end up using the hardware queue of the
> > > previous request, which may or may not be the same as that of the
> > > current request. If it isn't, the wrong hardware queue will end up
> > > waiting for a tag, and the requests will be on the wrong dispatch list,
> > > leading to a hang.
> > > 
> > > The fix is twofold:
> > > 
> > > 1. Make sure we save which hardware queue we were trying to get a
> > >    request for in blk_mq_get_driver_tag() regardless of whether it
> > >    succeeds or not.
> > 
> > It shouldn't have be needed, once rq->mq_ctx is set, the hctx should been
> > fixed already, that means we can just pass the hctx to blk_mq_get_driver_tag().
> 
> We still need to do the blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) step to
> get the hctx. We could do that at every callsite of
> blk_mq_get_driver_tag(), but this way it's just factored into
> blk_mq_get_driver_tag().

We can just use the hctx passed to blk_mq_dispatch_rq_list().

> 
> Thanks!
> 
> > > 2. Make blk_mq_dispatch_rq_list() take a request_queue instead of a
> > >    blk_mq_hw_queue to make it clear that it must handle multiple
> > >    hardware queues, since I've already messed this up on a couple of
> > >    occasions.

The 2nd part makes code less readable too, and it should have been
enough to pass 'hctx' into blk_mq_dispatch_rq_list() if we make
sure that ops.mq.dispatch_request() only returns requests from current hw
queue, since we have passed 'hctx' to elevator already.


Thanks,
Ming
