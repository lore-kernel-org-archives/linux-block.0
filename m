Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 26 Jun 2018 14:11:31 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Andrew Jones <drjones@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] blk-mq: cleanup blk_mq_get_driver_tag()
Message-ID: <20180626211131.GH1218@vader>
References: <20180625113149.29449-1-ming.lei@redhat.com>
 <20180625113149.29449-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180625113149.29449-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 25, 2018 at 07:31:45PM +0800, Ming Lei wrote:
> We never pass 'wait' as true to blk_mq_get_driver_tag(), then won't
> get new hctx passed out.
> 
> So cleanup the usage and remove the two extra parameters.

Might be worth mentioning that the last use went away in 0c2a6fe4dc3e
("blk-mq: don't special case flush inserts for blk-mq-sched").

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 19 +++++++------------
>  block/blk-mq.h |  3 +--
>  2 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b429d515b568..62e153eb720c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -964,17 +964,14 @@ static inline unsigned int queued_to_index(unsigned int queued)
>  	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
>  }
>  
> -bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
> -			   bool wait)
> +bool blk_mq_get_driver_tag(struct request *rq)
>  {
>  	struct blk_mq_alloc_data data = {
>  		.q = rq->q,
>  		.hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu),
> -		.flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
> +		.flags = BLK_MQ_REQ_NOWAIT,
>  	};
>  
> -	might_sleep_if(wait);
> -
>  	if (rq->tag != -1)
>  		goto done;
>  
> @@ -991,8 +988,6 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>  	}
>  
>  done:
> -	if (hctx)
> -		*hctx = data.hctx;
>  	return rq->tag != -1;
>  }
>  
> @@ -1034,7 +1029,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
>  		 * Don't clear RESTART here, someone else could have set it.
>  		 * At most this will cost an extra queue run.
>  		 */
> -		return blk_mq_get_driver_tag(rq, hctx, false);
> +		return blk_mq_get_driver_tag(rq);
>  	}
>  
>  	wait = &this_hctx->dispatch_wait;
> @@ -1055,7 +1050,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
>  	 * allocation failure and adding the hardware queue to the wait
>  	 * queue.
>  	 */
> -	ret = blk_mq_get_driver_tag(rq, hctx, false);
> +	ret = blk_mq_get_driver_tag(rq);
>  	if (!ret) {
>  		spin_unlock(&this_hctx->lock);
>  		return false;
> @@ -1102,7 +1097,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
>  			break;
>  
> -		if (!blk_mq_get_driver_tag(rq, NULL, false)) {
> +		if (!blk_mq_get_driver_tag(rq)) {
>  			/*
>  			 * The initial allocation attempt failed, so we need to
>  			 * rerun the hardware queue when a tag is freed. The
> @@ -1134,7 +1129,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  			bd.last = true;
>  		else {
>  			nxt = list_first_entry(list, struct request, queuelist);
> -			bd.last = !blk_mq_get_driver_tag(nxt, NULL, false);
> +			bd.last = !blk_mq_get_driver_tag(nxt);
>  		}
>  
>  		ret = q->mq_ops->queue_rq(hctx, &bd);
> @@ -1688,7 +1683,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	if (!blk_mq_get_dispatch_budget(hctx))
>  		goto insert;
>  
> -	if (!blk_mq_get_driver_tag(rq, NULL, false)) {
> +	if (!blk_mq_get_driver_tag(rq)) {
>  		blk_mq_put_dispatch_budget(hctx);
>  		goto insert;
>  	}
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 89231e439b2f..23659f41bf2c 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -36,8 +36,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
>  void blk_mq_wake_waiters(struct request_queue *q);
>  bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *, bool);
>  void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
> -bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
> -				bool wait);
> +bool blk_mq_get_driver_tag(struct request *rq);
>  struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
>  					struct blk_mq_ctx *start);
>  
> -- 
> 2.9.5
> 
