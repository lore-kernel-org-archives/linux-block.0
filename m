Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbdHaEBl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 00:01:41 -0400
Date: Thu, 31 Aug 2017 12:01:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V3 06/14] blk-mq-sched: don't dequeue request until all
 in ->dispatch are flushed
Message-ID: <20170831040123.GE12246@ming.t460p>
References: <20170826163332.28971-1-ming.lei@redhat.com>
 <20170826163332.28971-7-ming.lei@redhat.com>
 <1504113058.2526.54.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504113058.2526.54.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 30, 2017 at 05:11:00PM +0000, Bart Van Assche wrote:
> On Sun, 2017-08-27 at 00:33 +0800, Ming Lei wrote:
> > During dispatching, we moved all requests from hctx->dispatch to
> > one temporary list, then dispatch them one by one from this list.
> > Unfortunately duirng this period, run queue from other contexts
>                 ^^^^^^
>                 during?

OK.

> > may think the queue is idle, then start to dequeue from sw/scheduler
> > queue and still try to dispatch because ->dispatch is empty. This way
> > hurts sequential I/O performance because requests are dequeued when
> > lld queue is busy.
> > [ ... ]
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 735e432294ab..4d7bea8c2594 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -146,7 +146,6 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	struct request_queue *q = hctx->queue;
> >  	struct elevator_queue *e = q->elevator;
> >  	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;
> > -	bool do_sched_dispatch = true;
> >  	LIST_HEAD(rq_list);
> >  
> >  	/* RCU or SRCU read lock is needed before checking quiesced flag */
> 
> Shouldn't blk_mq_sched_dispatch_requests() set BLK_MQ_S_DISPATCH_BUSY just after
> the following statement because this statement makes the dispatch list empty?

Actually that is what I did in V1.

I changed to this way because setting the BUSY flag here will increase
the race window a bit, for example, if one request is added to ->dispatch
just after it is flushed(), the check on the BUSY bit won't catch this
case. Then we can avoid to check both the bit and list_empty_careful(&hctx->dispatch)
in blk_mq_sched_dispatch_requests(), so code becomes simpler and more
readable if we set the flag simply from the beginning.

> 
> 			list_splice_init(&hctx->dispatch, &rq_list);
> 
> > @@ -177,8 +176,33 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	 */
> >  	if (!list_empty(&rq_list)) {
> >  		blk_mq_sched_mark_restart_hctx(hctx);
> > -		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> > -	} else if (!has_sched_dispatch && !q->queue_depth) {
> > +		blk_mq_dispatch_rq_list(q, &rq_list);
> > +
> > +		/*
> > +		 * We may clear DISPATCH_BUSY just after it
> > +		 * is set from another context, the only cost
> > +		 * is that one request is dequeued a bit early,
> > +		 * we can survive that. Given the window is
> > +		 * too small, no need to worry about performance
>                    ^^^
> The word "too" seems extraneous to me in this sentence.

Maybe 'extremely' is better, or just remove it?

> 
> >  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> > @@ -330,6 +353,7 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
> >  	 */
> >  	spin_lock(&hctx->lock);
> >  	list_add(&rq->queuelist, &hctx->dispatch);
> > +	set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
> >  	spin_unlock(&hctx->lock);
> >  	return true;
> >  }
> 
> Is it necessary to make blk_mq_sched_bypass_insert() set BLK_MQ_S_DISPATCH_BUSY?
> My understanding is that only code that makes the dispatch list empty should
> set BLK_MQ_S_DISPATCH_BUSY. However, blk_mq_sched_bypass_insert() adds an element
> to the dispatch list so that guarantees that that list is not empty.

I believe my above comment has explained it already.

> 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f063dd0f197f..6af56a71c1cd 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1140,6 +1140,11 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
> >  
> >  		spin_lock(&hctx->lock);
> >  		list_splice_init(list, &hctx->dispatch);
> > +		/*
> > +		 * DISPATCH_BUSY won't be cleared until all requests
> > +		 * in hctx->dispatch are dispatched successfully
> > +		 */
> > +		set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
> >  		spin_unlock(&hctx->lock);
> 
> Same comment here - since this code adds one or more requests to the dispatch list,
> is it really needed to set the DISPATCH_BUSY flag?

See same comment above, :-)

-- 
Ming
