Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:43835 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdIMRcX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2017 13:32:23 -0400
Received: by mail-pf0-f175.google.com with SMTP id y29so1300777pff.0
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2017 10:32:22 -0700 (PDT)
Date: Wed, 13 Sep 2017 10:32:16 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 05/14] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170913173216.GA30473@vader>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-6-ming.lei@redhat.com>
 <20170908235439.GE13673@vader.DHCP.thefacebook.com>
 <20170910044513.GA11628@ming.t460p>
 <20170910173833.GB2579@vader>
 <20170911041308.GC27079@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911041308.GC27079@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 11, 2017 at 12:13:09PM +0800, Ming Lei wrote:
> On Sun, Sep 10, 2017 at 10:38:33AM -0700, Omar Sandoval wrote:
> > On Sun, Sep 10, 2017 at 12:45:15PM +0800, Ming Lei wrote:
> > > On Fri, Sep 08, 2017 at 04:54:39PM -0700, Omar Sandoval wrote:
> > > > On Sat, Sep 02, 2017 at 11:17:20PM +0800, Ming Lei wrote:
> > > > > SCSI devices use host-wide tagset, and the shared
> > > > > driver tag space is often quite big. Meantime
> > > > > there is also queue depth for each lun(.cmd_per_lun),
> > > > > which is often small.
> > > > > 
> > > > > So lots of requests may stay in sw queue, and we
> > > > > always flush all belonging to same hw queue and
> > > > > dispatch them all to driver, unfortunately it is
> > > > > easy to cause queue busy because of the small
> > > > > per-lun queue depth. Once these requests are flushed
> > > > > out, they have to stay in hctx->dispatch, and no bio
> > > > > merge can participate into these requests, and
> > > > > sequential IO performance is hurted.
> > > > > 
> > > > > This patch improves dispatching from sw queue when
> > > > > there is per-request-queue queue depth by taking
> > > > > request one by one from sw queue, just like the way
> > > > > of IO scheduler.
> > > > > 
> > > > > Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  block/blk-mq-sched.c   | 61 +++++++++++++++++++++++++++++++++++++++++++++-----
> > > > >  include/linux/blk-mq.h |  2 ++
> > > > >  2 files changed, 57 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > index f69752961a34..735e432294ab 100644
> > > > > --- a/block/blk-mq-sched.c
> > > > > +++ b/block/blk-mq-sched.c
> > > > > @@ -89,9 +89,9 @@ static bool blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
> > > > >  	return false;
> > > > >  }
> > > > >  
> > > > > -static void blk_mq_do_dispatch(struct request_queue *q,
> > > > > -			       struct elevator_queue *e,
> > > > > -			       struct blk_mq_hw_ctx *hctx)
> > > > > +static void blk_mq_do_dispatch_sched(struct request_queue *q,
> > > > > +				     struct elevator_queue *e,
> > > > > +				     struct blk_mq_hw_ctx *hctx)
> > > > >  {
> > > > >  	LIST_HEAD(rq_list);
> > > > >  
> > > > > @@ -105,6 +105,42 @@ static void blk_mq_do_dispatch(struct request_queue *q,
> > > > >  	} while (blk_mq_dispatch_rq_list(q, &rq_list));
> > > > >  }
> > > > >  
> > > > > +static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > > > > +					  struct blk_mq_ctx *ctx)
> > > > > +{
> > > > > +	unsigned idx = ctx->index_hw;
> > > > > +
> > > > > +	if (++idx == hctx->nr_ctx)
> > > > > +		idx = 0;
> > > > > +
> > > > > +	return hctx->ctxs[idx];
> > > > > +}
> > > > > +
> > > > > +static void blk_mq_do_dispatch_ctx(struct request_queue *q,
> > > > > +				   struct blk_mq_hw_ctx *hctx)
> > > > > +{
> > > > > +	LIST_HEAD(rq_list);
> > > > > +	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> > > > > +	bool dispatched;
> > > > > +
> > > > > +	do {
> > > > > +		struct request *rq;
> > > > > +
> > > > > +		rq = blk_mq_dispatch_rq_from_ctx(hctx, ctx);
> > > > > +		if (!rq)
> > > > > +			break;
> > > > > +		list_add(&rq->queuelist, &rq_list);
> > > > > +
> > > > > +		/* round robin for fair dispatch */
> > > > > +		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > > > 
> > > > Hm... this next ctx will get skipped if the dispatch on the previous ctx
> > > > fails, since we call blk_mq_next_ctx() again. Seems unfair. Maybe move
> > > > the blk_mq_next_ctx() from the if (!dispatched) below into the if (!rq)
> > > > above?
> > > 
> > > In case of if (!rq), that means there isn't any request in all ctxs
> > > belonging to this hctx, so it is reasonable to start the dispatch from
> > > any one of these ctxs next time, include the next one.
> > 
> > Yep, that case is okay.
> > 
> > > If dispatch fails on previous ctx, the rq from that ctx will be
> > > put into ->dispatch, so it is fair to start dispatch from next ctx
> > > next time too.
> > 
> > I'm talking about this case
> > 
> > 	LIST_HEAD(rq_list);
> > 	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> > 	bool dispatched;
> >  
> > 	/*
> > 	 * Let's say that ctxs 0, 1, and 2 all have requests pending and
> > 	 * hctx->dispatch_from was ctx0, so ctx is ctx0 when we start.
> > 	 */
> > 	do {
> > 		struct request *rq;
> >  
> > 		rq = blk_mq_dispatch_rq_from_ctx(hctx, ctx);
> > 		if (!rq)
> > 			break;
> > 		list_add(&rq->queuelist, &rq_list);
> > 
> > 		/* Now rq is a request from ctx0 */
> > 
> > 		/* round robin for fair dispatch */
> > 		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > 		/* Now ctx is ctx1. */
> >  
> > 		dispatched = blk_mq_dispatch_rq_list(q, &rq_list);
> > 
> > 		/* If we couldn't dispatch, we break here. */
> > 	} while (dispatched);
> >  
> > 	if (!dispatched)
> > 		/*
> > 		 * Now we set hctx->dispatch_from to ctx2, so we've
> > 		 * skipped over ctx1.
> > 		 */
> > 		WRITE_ONCE(hctx->dispatch_from, blk_mq_next_ctx(hctx, ctx));
> 
> Good catch, looks it can be fixed by simply changing the above line
> into following:
> 
>  		WRITE_ONCE(hctx->dispatch_from, ctx);

Yeah that'll do it. Once you fix that you can add

Reviewed-by: Omar Sandoval <osandov@fb.com>
