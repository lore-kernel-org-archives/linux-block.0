Return-Path: <riteshh@codeaurora.org>
Subject: Re: [PATCH 2/7] blk-mq: abstract out blk_mq_dispatch_rq_list() helper
To: Jens Axboe <axboe@fb.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-3-git-send-email-axboe@fb.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Ritesh Harjani <riteshh@codeaurora.org>
Message-ID: <fbf10c2c-b7c0-186e-debb-2905c30af2af@codeaurora.org>
Date: Tue, 13 Dec 2016 14:48:24 +0530
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-3-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

Minor comments.

On 12/9/2016 1:43 AM, Jens Axboe wrote:
> Takes a list of requests, and dispatches it. Moves any residual
> requests to the dispatch list.
>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq.c | 85 ++++++++++++++++++++++++++++++++--------------------------
>  block/blk-mq.h |  1 +
>  2 files changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b216746be9d3..abbf7cca4d0d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -821,41 +821,13 @@ static inline unsigned int queued_to_index(unsigned int queued)
>  	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
>  }
>
> -/*
> - * Run this hardware queue, pulling any software queues mapped to it in.
> - * Note that this function currently has various problems around ordering
> - * of IO. In particular, we'd like FIFO behaviour on handling existing
> - * items on the hctx->dispatch list. Ignore that for now.
> - */
> -static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
> +bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
>  {
>  	struct request_queue *q = hctx->queue;
>  	struct request *rq;
> -	LIST_HEAD(rq_list);
>  	LIST_HEAD(driver_list);
>  	struct list_head *dptr;
> -	int queued;
> -
> -	if (unlikely(blk_mq_hctx_stopped(hctx)))
> -		return;
> -
> -	hctx->run++;
> -
> -	/*
> -	 * Touch any software queue that has pending entries.
> -	 */
> -	flush_busy_ctxs(hctx, &rq_list);
> -
> -	/*
> -	 * If we have previous entries on our dispatch list, grab them
> -	 * and stuff them at the front for more fair dispatch.
> -	 */
> -	if (!list_empty_careful(&hctx->dispatch)) {
> -		spin_lock(&hctx->lock);
> -		if (!list_empty(&hctx->dispatch))
> -			list_splice_init(&hctx->dispatch, &rq_list);
> -		spin_unlock(&hctx->lock);
> -	}
> +	int queued, ret = BLK_MQ_RQ_QUEUE_OK;
>
>  	/*
>  	 * Start off with dptr being NULL, so we start the first request
> @@ -867,16 +839,15 @@ static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
>  	 * Now process all the entries, sending them to the driver.
>  	 */
>  	queued = 0;
> -	while (!list_empty(&rq_list)) {
> +	while (!list_empty(list)) {
>  		struct blk_mq_queue_data bd;
> -		int ret;
>
> -		rq = list_first_entry(&rq_list, struct request, queuelist);
> +		rq = list_first_entry(list, struct request, queuelist);
>  		list_del_init(&rq->queuelist);
>
>  		bd.rq = rq;
>  		bd.list = dptr;
> -		bd.last = list_empty(&rq_list);
> +		bd.last = list_empty(list);
>
>  		ret = q->mq_ops->queue_rq(hctx, &bd);
>  		switch (ret) {
> @@ -884,7 +855,7 @@ static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
>  			queued++;
>  			break;
>  		case BLK_MQ_RQ_QUEUE_BUSY:
> -			list_add(&rq->queuelist, &rq_list);
> +			list_add(&rq->queuelist, list);
>  			__blk_mq_requeue_request(rq);
>  			break;
>  		default:
> @@ -902,7 +873,7 @@ static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
>  		 * We've done the first request. If we have more than 1
>  		 * left in the list, set dptr to defer issue.
>  		 */
> -		if (!dptr && rq_list.next != rq_list.prev)
> +		if (!dptr && list->next != list->prev)
>  			dptr = &driver_list;
>  	}
>
> @@ -912,10 +883,11 @@ static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
>  	 * Any items that need requeuing? Stuff them into hctx->dispatch,
>  	 * that is where we will continue on next queue run.
>  	 */
> -	if (!list_empty(&rq_list)) {
> +	if (!list_empty(list)) {
>  		spin_lock(&hctx->lock);
> -		list_splice(&rq_list, &hctx->dispatch);
> +		list_splice(list, &hctx->dispatch);
>  		spin_unlock(&hctx->lock);
> +
>  		/*
>  		 * the queue is expected stopped with BLK_MQ_RQ_QUEUE_BUSY, but
>  		 * it's possible the queue is stopped and restarted again
> @@ -927,6 +899,43 @@ static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
>  		 **/
>  		blk_mq_run_hw_queue(hctx, true);
>  	}
> +
> +	return ret != BLK_MQ_RQ_QUEUE_BUSY;
> +}
> +
> +/*
> + * Run this hardware queue, pulling any software queues mapped to it in.
> + * Note that this function currently has various problems around ordering
> + * of IO. In particular, we'd like FIFO behaviour on handling existing
> + * items on the hctx->dispatch list. Ignore that for now.
> + */
> +static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
> +{
> +	LIST_HEAD(rq_list);
> +	LIST_HEAD(driver_list);
driver_list is not required. since not used in this function anymore.
> +
> +	if (unlikely(blk_mq_hctx_stopped(hctx)))
> +		return;
> +
> +	hctx->run++;
> +
> +	/*
> +	 * Touch any software queue that has pending entries.
> +	 */
> +	flush_busy_ctxs(hctx, &rq_list);
> +
> +	/*
> +	 * If we have previous entries on our dispatch list, grab them
> +	 * and stuff them at the front for more fair dispatch.
> +	 */
> +	if (!list_empty_careful(&hctx->dispatch)) {
> +		spin_lock(&hctx->lock);
> +		if (!list_empty(&hctx->dispatch))
list_splice_init already checks for list_empty. So this may be 
redundant. Please check.
> +			list_splice_init(&hctx->dispatch, &rq_list);
> +		spin_unlock(&hctx->lock);
> +	}
> +
> +	blk_mq_dispatch_rq_list(hctx, &rq_list);
>  }
>
>  static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index b444370ae05b..3a54dd32a6fc 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -31,6 +31,7 @@ void blk_mq_freeze_queue(struct request_queue *q);
>  void blk_mq_free_queue(struct request_queue *q);
>  int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
>  void blk_mq_wake_waiters(struct request_queue *q);
> +bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *, struct list_head *);
>
>  /*
>   * CPU hotplug helpers
>
