Return-Path: <msnitzer@redhat.com>
Date: Sun, 14 Jan 2018 12:43:56 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: blk-mq: don't clear RQF_MQ_INFLIGHT in blk_mq_rq_ctx_init()
Message-ID: <20180114174356.GA18275@redhat.com>
References: <20180113174915.19404-1-ming.lei@redhat.com>
 <5fd4a57e-cc9a-e3da-fe3b-1db2460423f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5fd4a57e-cc9a-e3da-fe3b-1db2460423f8@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jan 14 2018 at 12:38pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 1/13/18 10:49 AM, Ming Lei wrote:
> > In case of no IO scheduler, RQF_MQ_INFLIGHT is set in blk_mq_rq_ctx_init(),
> > but 7c3fb70f0341 clears it mistakenly, so fix it.
> 
> Oops yeah, that's my bad. However, I think the below fix is cleaner
> and avoids a conditional.
> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b3b2003b7429..c8f62e6be6b6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -269,13 +269,14 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  {
>  	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
>  	struct request *rq = tags->static_rqs[tag];
> +	req_flags_t rq_flags = 0;
>  
>  	if (data->flags & BLK_MQ_REQ_INTERNAL) {
>  		rq->tag = -1;
>  		rq->internal_tag = tag;
>  	} else {
>  		if (blk_mq_tag_busy(data->hctx)) {
> -			rq->rq_flags = RQF_MQ_INFLIGHT;
> +			rq_flags = RQF_MQ_INFLIGHT;
>  			atomic_inc(&data->hctx->nr_active);
>  		}
>  		rq->tag = tag;
> @@ -286,7 +287,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	/* csd/requeue_work/fifo_time is initialized before use */
>  	rq->q = data->q;
>  	rq->mq_ctx = data->ctx;
> -	rq->rq_flags = 0;
> +	rq->rq_flags = rq_flags;
>  	rq->cpu = -1;
>  	rq->cmd_flags = op;
>  	if (data->flags & BLK_MQ_REQ_PREEMPT)

Yeap, looks good.

Reviewed-by:  Mike Snitzer <snitzer@redhat.com>

Defintely need this fix, without it all my dm-mpath testing hangs

Thanks,
Mike
