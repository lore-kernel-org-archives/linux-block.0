Return-Path: <ming.lei@redhat.com>
Date: Tue, 22 May 2018 10:27:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [RFC PATCH 1/3] blk-mq: Reference count request usage
Message-ID: <20180522022710.GB20430@ming.t460p>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521231131.6685-2-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 05:11:29PM -0600, Keith Busch wrote:
> This patch adds a struct kref to struct request so that request users
> can be sure they're operating on the same request without it changing
> while they're processing it. The request's tag won't be released for
> reuse until the last user is done with it.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/blk-mq.c         | 30 +++++++++++++++++++++++-------
>  include/linux/blkdev.h |  2 ++
>  2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4cbfd784e837..8b370ed75605 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -332,6 +332,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  #endif
>  
>  	data->ctx->rq_dispatched[op_is_sync(op)]++;
> +	kref_init(&rq->ref);
>  	return rq;
>  }
>  
> @@ -465,13 +466,33 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
>  
> +static void blk_mq_exit_request(struct kref *ref)
> +{
> +	struct request *rq = container_of(ref, struct request, ref);
> +	struct request_queue *q = rq->q;
> +	struct blk_mq_ctx *ctx = rq->mq_ctx;
> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
> +	const int sched_tag = rq->internal_tag;
> +
> +	if (rq->tag != -1)
> +		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
> +	if (sched_tag != -1)
> +		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
> +	blk_mq_sched_restart(hctx);
> +	blk_queue_exit(q);
> +}
> +
> +static void blk_mq_put_request(struct request *rq)
> +{
> +       kref_put(&rq->ref, blk_mq_exit_request);
> +}
> +
>  void blk_mq_free_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
>  	struct elevator_queue *e = q->elevator;
>  	struct blk_mq_ctx *ctx = rq->mq_ctx;
>  	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
> -	const int sched_tag = rq->internal_tag;
>  
>  	if (rq->rq_flags & RQF_ELVPRIV) {
>  		if (e && e->type->ops.mq.finish_request)
> @@ -495,12 +516,7 @@ void blk_mq_free_request(struct request *rq)
>  		blk_put_rl(blk_rq_rl(rq));
>  
>  	blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
> -	if (rq->tag != -1)
> -		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
> -	if (sched_tag != -1)
> -		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
> -	blk_mq_sched_restart(hctx);
> -	blk_queue_exit(q);
> +	blk_mq_put_request(rq);

Both the above line(atomic_try_cmpxchg_release is implied) and kref_init()
in blk_mq_rq_ctx_init() are run from fast path, and may introduce some cost,
you may have to run some benchmark to show if there is effect.

Also given the cost isn't free, could you describe a bit in comment log
what we can get with the cost?

Thanks,
Ming
