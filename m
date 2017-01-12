Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60126 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750797AbdALWA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 17:00:59 -0500
Date: Thu, 12 Jan 2017 14:59:22 -0700
From: Jens Axboe <axboe@fb.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 08/10] blk-mq-sched: add framework for MQ capable IO
 schedulers
Message-ID: <20170112215922.GB25197@kernel.dk>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-9-git-send-email-axboe@fb.com>
 <1484257502.2720.21.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1484257502.2720.21.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 12 2017, Bart Van Assche wrote:
> On Wed, 2017-01-11 at 14:40 -0700, Jens Axboe wrote:
> > @@ -451,11 +456,11 @@ void blk_insert_flush(struct request *rq)
> >  	 * processed directly without going through flush machinery.  Queue
> >  	 * for normal execution.
> >  	 */
> > -	if ((policy & REQ_FSEQ_DATA) &&
> > -	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
> > -		if (q->mq_ops) {
> > -			blk_mq_insert_request(rq, false, true, false);
> > -		} else
> > +	if (((policy & REQ_FSEQ_DATA) &&
> > +	     !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH)))) {
> > +		if (q->mq_ops)
> > +			blk_mq_sched_insert_request(rq, false, true, false);
> > +		else
> >  			list_add_tail(&rq->queuelist, &q->queue_head);
> >  		return;
> >  	}
> 
> Not that it really matters, but this change adds a pair of parentheses --
> "if (e)" is changed into "if ((e))". Is this necessary?

I fixed that up earlier today, as I noticed the same. So that's gone in
the current -git tree.

> > +void blk_mq_sched_free_hctx_data(struct request_queue *q,
> > +				 void (*exit)(struct blk_mq_hw_ctx *))
> > +{
> > +	struct blk_mq_hw_ctx *hctx;
> > +	int i;
> > +
> > +	queue_for_each_hw_ctx(q, hctx, i) {
> > +		if (exit)
> > +			exit(hctx);
> > +		kfree(hctx->sched_data);
> > +		hctx->sched_data = NULL;
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
> > +
> > +int blk_mq_sched_init_hctx_data(struct request_queue *q, size_t size,
> > +				int (*init)(struct blk_mq_hw_ctx *),
> > +				void (*exit)(struct blk_mq_hw_ctx *))
> > +{
> > +	struct blk_mq_hw_ctx *hctx;
> > +	int ret;
> > +	int i;
> > +
> > +	queue_for_each_hw_ctx(q, hctx, i) {
> > +		hctx->sched_data = kmalloc_node(size, GFP_KERNEL, hctx->numa_node);
> > +		if (!hctx->sched_data) {
> > +			ret = -ENOMEM;
> > +			goto error;
> > +		}
> > +
> > +		if (init) {
> > +			ret = init(hctx);
> > +			if (ret) {
> > +				/*
> > +				 * We don't want to give exit() a partially
> > +				 * initialized sched_data. init() must clean up
> > +				 * if it fails.
> > +				 */
> > +				kfree(hctx->sched_data);
> > +				hctx->sched_data = NULL;
> > +				goto error;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +error:
> > +	blk_mq_sched_free_hctx_data(q, exit);
> > +	return ret;
> > +}
> 
> If one of the init() calls by blk_mq_sched_init_hctx_data() fails then
> blk_mq_sched_free_hctx_data() will call exit() even for hctx's for which
> init() has not been called. How about changing "if (exit)" into "if (exit &&
> hctx->sched_data)" such that exit() is only called for hctx's for which
> init() has been called?

Good point, I'll make that change to the exit function.

> > +struct request *blk_mq_sched_get_request(struct request_queue *q,
> > +					 struct bio *bio,
> > +					 unsigned int op,
> > +					 struct blk_mq_alloc_data *data)
> > +{
> > +	struct elevator_queue *e = q->elevator;
> > +	struct blk_mq_hw_ctx *hctx;
> > +	struct blk_mq_ctx *ctx;
> > +	struct request *rq;
> > +
> > +	blk_queue_enter_live(q);
> > +	ctx = blk_mq_get_ctx(q);
> > +	hctx = blk_mq_map_queue(q, ctx->cpu);
> > +
> > +	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
> > +
> > +	if (e) {
> > +		data->flags |= BLK_MQ_REQ_INTERNAL;
> > +		if (e->type->ops.mq.get_request)
> > +			rq = e->type->ops.mq.get_request(q, op, data);
> > +		else
> > +			rq = __blk_mq_alloc_request(data, op);
> > +	} else {
> > +		rq = __blk_mq_alloc_request(data, op);
> > +		if (rq) {
> > +			rq->tag = rq->internal_tag;
> > +			rq->internal_tag = -1;
> > +		}
> > +	}
> > +
> > +	if (rq) {
> > +		rq->elv.icq = NULL;
> > +		if (e && e->type->icq_cache)
> > +			blk_mq_sched_assign_ioc(q, rq, bio);
> > +		data->hctx->queued++;
> > +		return rq;
> > +	}
> > +
> > +	blk_queue_exit(q);
> > +	return NULL;
> > +}
> 
> The "rq->tag = rq->internal_tag; rq->internal_tag = -1;" occurs not only
> here but also in blk_mq_alloc_request_hctx(). Has it been considered to move
> that code into __blk_mq_alloc_request()?

Yes, it's in two locations. I wanted to keep it out of
__blk_mq_alloc_request(), so we can still use that for normal tag
allocations. But maybe it's better for __blk_mq_alloc_request() to just
do:

        if (flags & BLK_MQ_REQ_INTERNAL) {
                rq->tag = -1;
                rq->internal_tag = tag;
        } else {
                rq->tag = tag;
                rq->internal_tag = -1;
        }

and handle it directly in there. What do you think?

> @@ -223,14 +225,17 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
> >  
> >  	tag = blk_mq_get_tag(data);
> >  	if (tag != BLK_MQ_TAG_FAIL) {
> > -		rq = data->hctx->tags->rqs[tag];
> > +		struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
> > +
> > +		rq = tags->rqs[tag];
> >  
> >  		if (blk_mq_tag_busy(data->hctx)) {
> >  			rq->rq_flags = RQF_MQ_INFLIGHT;
> >  			atomic_inc(&data->hctx->nr_active);
> >  		}
> >  
> > -		rq->tag = tag;
> > +		rq->tag = -1;
> > +		rq->internal_tag = tag;
> >  		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
> >  		return rq;
> >  	}
> 
> How about using the following code for tag assignment instead of "rq->tag =
> -1; rq->internal_tag = tag"?
> 
> 		if (data->flags & BLK_MQ_REQ_INTERNAL) {
> 			rq->tag = -1;
> 			rq->internal_tag = tag;
> 		} else {
> 			rq->tag = tag;
> 			rq->internal_tag = -1;
> 		}

Hah, nevermind, I should have read further. I guess we agree, I'll make
that change.

> > @@ -313,6 +313,9 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
> >  		goto out_queue_exit;
> >  	}
> >  
> > +	rq->tag = rq->internal_tag;
> > +	rq->internal_tag = -1;
> > +
> >  	return rq;
> >  
> >  out_queue_exit:
> > @@ -321,10 +324,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
> >  }
> >  EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
> 
> Should something like "WARN_ON_ONCE(flags & BLK_MQ_REQ_INTERNAL)" be added
> at the start of this function to avoid that BLK_MQ_REQ_INTERNAL is passed in
> from outside the block layer?

Yes, seems like a prudent safety check. I'll add it, thanks.

-- 
Jens Axboe

