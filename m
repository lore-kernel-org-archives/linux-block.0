Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:38421 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757217AbdIHXym (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2017 19:54:42 -0400
Received: by mail-pg0-f47.google.com with SMTP id v66so7108449pgb.5
        for <linux-block@vger.kernel.org>; Fri, 08 Sep 2017 16:54:41 -0700 (PDT)
Date: Fri, 8 Sep 2017 16:54:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 05/14] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170908235439.GE13673@vader.DHCP.thefacebook.com>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170902151729.6162-6-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 02, 2017 at 11:17:20PM +0800, Ming Lei wrote:
> SCSI devices use host-wide tagset, and the shared
> driver tag space is often quite big. Meantime
> there is also queue depth for each lun(.cmd_per_lun),
> which is often small.
> 
> So lots of requests may stay in sw queue, and we
> always flush all belonging to same hw queue and
> dispatch them all to driver, unfortunately it is
> easy to cause queue busy because of the small
> per-lun queue depth. Once these requests are flushed
> out, they have to stay in hctx->dispatch, and no bio
> merge can participate into these requests, and
> sequential IO performance is hurted.
> 
> This patch improves dispatching from sw queue when
> there is per-request-queue queue depth by taking
> request one by one from sw queue, just like the way
> of IO scheduler.
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sched.c   | 61 +++++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/blk-mq.h |  2 ++
>  2 files changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index f69752961a34..735e432294ab 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -89,9 +89,9 @@ static bool blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
>  	return false;
>  }
>  
> -static void blk_mq_do_dispatch(struct request_queue *q,
> -			       struct elevator_queue *e,
> -			       struct blk_mq_hw_ctx *hctx)
> +static void blk_mq_do_dispatch_sched(struct request_queue *q,
> +				     struct elevator_queue *e,
> +				     struct blk_mq_hw_ctx *hctx)
>  {
>  	LIST_HEAD(rq_list);
>  
> @@ -105,6 +105,42 @@ static void blk_mq_do_dispatch(struct request_queue *q,
>  	} while (blk_mq_dispatch_rq_list(q, &rq_list));
>  }
>  
> +static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
> +					  struct blk_mq_ctx *ctx)
> +{
> +	unsigned idx = ctx->index_hw;
> +
> +	if (++idx == hctx->nr_ctx)
> +		idx = 0;
> +
> +	return hctx->ctxs[idx];
> +}
> +
> +static void blk_mq_do_dispatch_ctx(struct request_queue *q,
> +				   struct blk_mq_hw_ctx *hctx)
> +{
> +	LIST_HEAD(rq_list);
> +	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
> +	bool dispatched;
> +
> +	do {
> +		struct request *rq;
> +
> +		rq = blk_mq_dispatch_rq_from_ctx(hctx, ctx);
> +		if (!rq)
> +			break;
> +		list_add(&rq->queuelist, &rq_list);
> +
> +		/* round robin for fair dispatch */
> +		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);

Hm... this next ctx will get skipped if the dispatch on the previous ctx
fails, since we call blk_mq_next_ctx() again. Seems unfair. Maybe move
the blk_mq_next_ctx() from the if (!dispatched) below into the if (!rq)
above?

> +		dispatched = blk_mq_dispatch_rq_list(q, &rq_list);
> +	} while (dispatched);
> +
> +	if (!dispatched)
> +		WRITE_ONCE(hctx->dispatch_from, blk_mq_next_ctx(hctx, ctx));
> +}
> +
>  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct request_queue *q = hctx->queue;
> @@ -142,18 +178,31 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	if (!list_empty(&rq_list)) {
>  		blk_mq_sched_mark_restart_hctx(hctx);
>  		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> -	} else if (!has_sched_dispatch) {
> +	} else if (!has_sched_dispatch && !q->queue_depth) {
> +		/*
> +		 * If there is no per-request_queue depth, we
> +		 * flush all requests in this hw queue, otherwise
> +		 * pick up request one by one from sw queue for
> +		 * avoiding to mess up I/O merge when dispatch
> +		 * is busy, which can be triggered easily by
> +		 * per-request_queue queue depth
> +		 */
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
>  		blk_mq_dispatch_rq_list(q, &rq_list);
>  	}
>  
> +	if (!do_sched_dispatch)
> +		return;
> +
>  	/*
>  	 * We want to dispatch from the scheduler if we had no work left
>  	 * on the dispatch list, OR if we did have work but weren't able
>  	 * to make progress.
>  	 */
> -	if (do_sched_dispatch && has_sched_dispatch)
> -		blk_mq_do_dispatch(q, e, hctx);
> +	if (has_sched_dispatch)
> +		blk_mq_do_dispatch_sched(q, e, hctx);
> +	else
> +		blk_mq_do_dispatch_ctx(q, hctx);
>  }
>  
>  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 50c6485cb04f..7b7a366a97f3 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -30,6 +30,8 @@ struct blk_mq_hw_ctx {
>  
>  	struct sbitmap		ctx_map;
>  
> +	struct blk_mq_ctx	*dispatch_from;
> +
>  	struct blk_mq_ctx	**ctxs;
>  	unsigned int		nr_ctx;
>  
> -- 
> 2.9.5
> 
