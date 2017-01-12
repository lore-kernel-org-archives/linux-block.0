Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:17769
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750730AbdALVpZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:45:25 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 08/10] blk-mq-sched: add framework for MQ capable IO
 schedulers
Date: Thu, 12 Jan 2017 21:45:16 +0000
Message-ID: <1484257502.2720.21.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
         <1484170803-9311-9-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-9-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:40 -0700, Jens Axboe wrote:
> @@ -451,11 +456,11 @@ void blk_insert_flush(struct request *rq)
>  	 * processed directly without going through flush machinery.  Queue
>  	 * for normal execution.
>  	 */
> -	if ((policy & REQ_FSEQ_DATA) &&
> -	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
> -		if (q->mq_ops) {
> -			blk_mq_insert_request(rq, false, true, false);
> -		} else
> +	if (((policy & REQ_FSEQ_DATA) &&
> +	     !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH)))) {
> +		if (q->mq_ops)
> +			blk_mq_sched_insert_request(rq, false, true, false);
> +		else
>  			list_add_tail(&rq->queuelist, &q->queue_head);
>  		return;
>  	}

Not that it really matters, but this change adds a pair of parentheses --
"if (e)" is changed into "if ((e))". Is this necessary?

> +void blk_mq_sched_free_hctx_data(struct request_queue *q,
> +				 void (*exit)(struct blk_mq_hw_ctx *))
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	int i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		if (exit)
> +			exit(hctx);
> +		kfree(hctx->sched_data);
> +		hctx->sched_data =3D NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
> +
> +int blk_mq_sched_init_hctx_data(struct request_queue *q, size_t size,
> +				int (*init)(struct blk_mq_hw_ctx *),
> +				void (*exit)(struct blk_mq_hw_ctx *))
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	int ret;
> +	int i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		hctx->sched_data =3D kmalloc_node(size, GFP_KERNEL, hctx->numa_node);
> +		if (!hctx->sched_data) {
> +			ret =3D -ENOMEM;
> +			goto error;
> +		}
> +
> +		if (init) {
> +			ret =3D init(hctx);
> +			if (ret) {
> +				/*
> +				 * We don't want to give exit() a partially
> +				 * initialized sched_data. init() must clean up
> +				 * if it fails.
> +				 */
> +				kfree(hctx->sched_data);
> +				hctx->sched_data =3D NULL;
> +				goto error;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +error:
> +	blk_mq_sched_free_hctx_data(q, exit);
> +	return ret;
> +}

If one of the init() calls by blk_mq_sched_init_hctx_data() fails then
blk_mq_sched_free_hctx_data() will call exit() even for hctx's for which
init() has not been called. How about changing "if (exit)" into "if (exit &=
&
hctx->sched_data)" such that exit() is only called for hctx's for which
init() has been called?

> +struct request *blk_mq_sched_get_request(struct request_queue *q,
> +					 struct bio *bio,
> +					 unsigned int op,
> +					 struct blk_mq_alloc_data *data)
> +{
> +	struct elevator_queue *e =3D q->elevator;
> +	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_ctx *ctx;
> +	struct request *rq;
> +
> +	blk_queue_enter_live(q);
> +	ctx =3D blk_mq_get_ctx(q);
> +	hctx =3D blk_mq_map_queue(q, ctx->cpu);
> +
> +	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
> +
> +	if (e) {
> +		data->flags |=3D BLK_MQ_REQ_INTERNAL;
> +		if (e->type->ops.mq.get_request)
> +			rq =3D e->type->ops.mq.get_request(q, op, data);
> +		else
> +			rq =3D __blk_mq_alloc_request(data, op);
> +	} else {
> +		rq =3D __blk_mq_alloc_request(data, op);
> +		if (rq) {
> +			rq->tag =3D rq->internal_tag;
> +			rq->internal_tag =3D -1;
> +		}
> +	}
> +
> +	if (rq) {
> +		rq->elv.icq =3D NULL;
> +		if (e && e->type->icq_cache)
> +			blk_mq_sched_assign_ioc(q, rq, bio);
> +		data->hctx->queued++;
> +		return rq;
> +	}
> +
> +	blk_queue_exit(q);
> +	return NULL;
> +}

The "rq->tag =3D rq->internal_tag; rq->internal_tag =3D -1;" occurs not onl=
y
here but also in blk_mq_alloc_request_hctx(). Has it been considered to mov=
e
that code into __blk_mq_alloc_request()?

@@ -223,14 +225,17 @@ struct request *__blk_mq_alloc_request(struct blk_mq_=
alloc_data *data,
> =20
>  	tag =3D blk_mq_get_tag(data);
>  	if (tag !=3D BLK_MQ_TAG_FAIL) {
> -		rq =3D data->hctx->tags->rqs[tag];
> +		struct blk_mq_tags *tags =3D blk_mq_tags_from_data(data);
> +
> +		rq =3D tags->rqs[tag];
> =20
>  		if (blk_mq_tag_busy(data->hctx)) {
>  			rq->rq_flags =3D RQF_MQ_INFLIGHT;
>  			atomic_inc(&data->hctx->nr_active);
>  		}
> =20
> -		rq->tag =3D tag;
> +		rq->tag =3D -1;
> +		rq->internal_tag =3D tag;
>  		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
>  		return rq;
>  	}

How about using the following code for tag assignment instead of "rq->tag =
=3D
-1; rq->internal_tag =3D tag"?

		if (data->flags & BLK_MQ_REQ_INTERNAL) {
			rq->tag =3D -1;
			rq->internal_tag =3D tag;
		} else {
			rq->tag =3D tag;
			rq->internal_tag =3D -1;
		}

> @@ -313,6 +313,9 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q, int rw,
>  		goto out_queue_exit;
>  	}
> =20
> +	rq->tag =3D rq->internal_tag;
> +	rq->internal_tag =3D -1;
> +
>  	return rq;
> =20
>  out_queue_exit:
> @@ -321,10 +324,10 @@ struct request *blk_mq_alloc_request_hctx(struct re=
quest_queue *q, int rw,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);

Should something like "WARN_ON_ONCE(flags & BLK_MQ_REQ_INTERNAL)" be added
at the start of this function to avoid that BLK_MQ_REQ_INTERNAL is passed i=
n
from outside the block layer?

Bart.=
