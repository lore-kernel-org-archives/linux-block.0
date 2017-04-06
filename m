Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33310 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756675AbdDFH6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 03:58:47 -0400
Received: by mail-pg0-f47.google.com with SMTP id x125so28925986pgb.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2017 00:58:47 -0700 (PDT)
Date: Thu, 6 Apr 2017 00:57:51 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <minlei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 1/8] blk-mq: use the right hctx when getting a driver
 tag fails
Message-ID: <20170406075751.GA15461@vader>
References: <cover.1491418411.git.osandov@fb.com>
 <d1b5da71a5cba1f17d4eaafb207547a4651f81a9.1491418411.git.osandov@fb.com>
 <20170406043108.GA29955@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406043108.GA29955@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 06, 2017 at 12:31:18PM +0800, Ming Lei wrote:
> On Wed, Apr 05, 2017 at 12:01:29PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > While dispatching requests, if we fail to get a driver tag, we mark the
> > hardware queue as waiting for a tag and put the requests on a
> > hctx->dispatch list to be run later when a driver tag is freed. However,
> > blk_mq_dispatch_rq_list() may dispatch requests from multiple hardware
> > queues if using a single-queue scheduler with a multiqueue device. If
> 
> It can't perform well by using a SQ scheduler on a MQ device, so just be
> curious why someone wants to do that in this way,:-)

I don't know why anyone would want to, but it has to work :) The only
reason we noticed this is because when the NBD device is created, it
only has a single queue, so we automatically assign mq-deadline to it.
Later, we update the number of queues, but it's still using mq-deadline.

> I guess you mean that ops.mq.dispatch_request() may dispatch requests
> from other hardware queues in blk_mq_sched_dispatch_requests() instead
> of current hctx.

Yup, that's right. It's weird, and I talked to Jens about just forcing
the MQ device into an SQ mode when using an SQ scheduler, but this way
works fine more or less.

> If that is true, it looks like a issue in usage of I/O scheduler, since
> the mq-deadline scheduler just queues requests in one per-request_queue
> linked list, for MQ device, the scheduler queue should have been per-hctx.

That's an option, but that's a different scheduling policy. Again, I
agree that it's strange, but it's reasonable behavior.

> > blk_mq_get_driver_tag() fails, it doesn't update the hardware queue we
> > are processing. This means we end up using the hardware queue of the
> > previous request, which may or may not be the same as that of the
> > current request. If it isn't, the wrong hardware queue will end up
> > waiting for a tag, and the requests will be on the wrong dispatch list,
> > leading to a hang.
> > 
> > The fix is twofold:
> > 
> > 1. Make sure we save which hardware queue we were trying to get a
> >    request for in blk_mq_get_driver_tag() regardless of whether it
> >    succeeds or not.
> 
> It shouldn't have be needed, once rq->mq_ctx is set, the hctx should been
> fixed already, that means we can just pass the hctx to blk_mq_get_driver_tag().

We still need to do the blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) step to
get the hctx. We could do that at every callsite of
blk_mq_get_driver_tag(), but this way it's just factored into
blk_mq_get_driver_tag().

Thanks!

> > 2. Make blk_mq_dispatch_rq_list() take a request_queue instead of a
> >    blk_mq_hw_queue to make it clear that it must handle multiple
> >    hardware queues, since I've already messed this up on a couple of
> >    occasions.
> > 
> > This didn't appear in testing with nvme and mq-deadline because nvme has
> > more driver tags than the default number of scheduler tags. However,
> > with the blk_mq_update_nr_hw_queues() fix, it showed up with nbd.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
