Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdHXFxB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 01:53:01 -0400
Date: Thu, 24 Aug 2017 13:52:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 05/20] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170824055230.GE12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-6-ming.lei@redhat.com>
 <1503431751.2508.13.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503431751.2508.13.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 07:55:55PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > easy to cause queue busy becasue of the small
>                            ^^^^^^^
>                            because?
>  
> > -static void blk_mq_do_dispatch(struct request_queue *q,
> > -			       struct elevator_queue *e,
> > -			       struct blk_mq_hw_ctx *hctx)
> > +static inline void blk_mq_do_dispatch_sched(struct request_queue *q,
> > +					    struct elevator_queue *e,
> > +					    struct blk_mq_hw_ctx *hctx)
> >  {
> >  	LIST_HEAD(rq_list);
> 
> Why to declare this function "inline"? Are you sure that the compiler
> is not smart enough to decide on its own whether or not to inline this
> function?

OK.

> 
> > +static inline struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> > +						 struct blk_mq_ctx *ctx)
> > +{
> > +	unsigned idx = ctx->index_hw;
> > +
> > +	if (++idx == hctx->nr_ctx)
> > +		idx = 0;
> > +
> > +	return hctx->ctxs[idx];
> > +}
> > +
> > +static inline void blk_mq_do_dispatch_ctx(struct request_queue *q,
> > +					  struct blk_mq_hw_ctx *hctx)
> > +{
> > +	LIST_HEAD(rq_list);
> > +	struct blk_mq_ctx *ctx = NULL;
> > +
> > +	do {
> > +		struct request *rq;
> > +
> > +		rq = blk_mq_dispatch_rq_from_ctx(hctx, ctx);
> > +		if (!rq)
> > +			break;
> > +		list_add(&rq->queuelist, &rq_list);
> > +
> > +		/* round robin for fair dispatch */
> > +		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > +	} while (blk_mq_dispatch_rq_list(q, &rq_list));
> > +}
> 
> Please consider to move the blk_mq_next_ctx() functionality into
> blk_mq_dispatch_rq_from_ctx() as requested in a comment on a previous patch.

I believe this way is more clean and readable, otherwise
blk_mq_dispatch_rq_from_next_ctx() can be a bit ugly.

> 
> >  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  {
> >  	struct request_queue *q = hctx->queue;
> > @@ -142,18 +172,31 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> >  	if (!list_empty(&rq_list)) {
> >  		blk_mq_sched_mark_restart_hctx(hctx);
> >  		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> > -	} else if (!has_sched_dispatch) {
> > +	} else if (!has_sched_dispatch & !q->queue_depth) {
> 
> Please use "&&" instead of "&" to represent logical and.

Hamm, I remember that another one is fixed against V1, but
this one is missed.

> 
> Otherwise this patch looks fine to me.

Thanks.


-- 
Ming
