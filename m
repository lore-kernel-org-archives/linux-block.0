Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:52295 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdISTLH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 15:11:07 -0400
Received: by mail-pf0-f174.google.com with SMTP id p87so291063pfj.9
        for <linux-block@vger.kernel.org>; Tue, 19 Sep 2017 12:11:07 -0700 (PDT)
Date: Tue, 19 Sep 2017 12:11:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 06/14] blk-mq-sched: don't dequeue request until all
 in ->dispatch are flushed
Message-ID: <20170919191105.GA31219@vader.DHCP.thefacebook.com>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170902151729.6162-7-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 02, 2017 at 11:17:21PM +0800, Ming Lei wrote:
> During dispatching, we moved all requests from hctx->dispatch to
> one temporary list, then dispatch them one by one from this list.
> Unfortunately during this period, run queue from other contexts
> may think the queue is idle, then start to dequeue from sw/scheduler
> queue and still try to dispatch because ->dispatch is empty. This way
> hurts sequential I/O performance because requests are dequeued when
> lld queue is busy.
> 
> This patch introduces the state of BLK_MQ_S_DISPATCH_BUSY to
> make sure that request isn't dequeued until ->dispatch is
> flushed.
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Neat. I did something similar when I first started on I/O scheduling for
blk-mq, but I completely serialized dispatch so only one CPU would be
dispatching a given hctx at a time. I ended up ditching it because it
was actually a performance regression on artificial null-blk tests with
many CPUs and 1 hctx, and it was also really hard to get right without
deadlocks. Yours still allows concurrent dispatch from multiple CPUs, so
you probably wouldn't have those same issues, but I don't like how
handwavy this is about races on the DISPATCH_BUSY bit, and how the
handling of that bit is spread around everywhere. I'm not totally
opposed to taking this as is, but what do you think about serializing
the dispatch per hctx completely?

> ---
>  block/blk-mq-debugfs.c |  1 +
>  block/blk-mq-sched.c   | 58 +++++++++++++++++++++++++++++++++++---------------
>  block/blk-mq.c         |  6 ++++++
>  include/linux/blk-mq.h |  1 +
>  4 files changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 980e73095643..7a27f262c96a 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -182,6 +182,7 @@ static const char *const hctx_state_name[] = {
>  	HCTX_STATE_NAME(SCHED_RESTART),
>  	HCTX_STATE_NAME(TAG_WAITING),
>  	HCTX_STATE_NAME(START_ON_RUN),
> +	HCTX_STATE_NAME(DISPATCH_BUSY),
>  };
>  #undef HCTX_STATE_NAME
>  
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 735e432294ab..97e7a4fe3a32 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -146,7 +146,6 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	struct request_queue *q = hctx->queue;
>  	struct elevator_queue *e = q->elevator;
>  	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;
> -	bool do_sched_dispatch = true;
>  	LIST_HEAD(rq_list);
>  
>  	/* RCU or SRCU read lock is needed before checking quiesced flag */
> @@ -177,8 +176,33 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	 */
>  	if (!list_empty(&rq_list)) {
>  		blk_mq_sched_mark_restart_hctx(hctx);
> -		do_sched_dispatch = blk_mq_dispatch_rq_list(q, &rq_list);
> -	} else if (!has_sched_dispatch && !q->queue_depth) {
> +		blk_mq_dispatch_rq_list(q, &rq_list);
> +
> +		/*
> +		 * We may clear DISPATCH_BUSY just after it
> +		 * is set from another context, the only cost
> +		 * is that one request is dequeued a bit early,
> +		 * we can survive that. Given the window is
> +		 * small enough, no need to worry about performance
> +		 * effect.
> +		 */
> +		if (list_empty_careful(&hctx->dispatch))
> +			clear_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
> +	}
> +
> +	/*
> +	 * If DISPATCH_BUSY is set, that means hw queue is busy
> +	 * and requests in the list of hctx->dispatch need to
> +	 * be flushed first, so return early.
> +	 *
> +	 * Wherever DISPATCH_BUSY is set, blk_mq_run_hw_queue()
> +	 * will be run to try to make progress, so it is always
> +	 * safe to check the state here.
> +	 */
> +	if (test_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state))
> +		return;
> +
> +	if (!has_sched_dispatch) {
>  		/*
>  		 * If there is no per-request_queue depth, we
>  		 * flush all requests in this hw queue, otherwise
> @@ -187,22 +211,21 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  		 * is busy, which can be triggered easily by
>  		 * per-request_queue queue depth
>  		 */
> -		blk_mq_flush_busy_ctxs(hctx, &rq_list);
> -		blk_mq_dispatch_rq_list(q, &rq_list);
> -	}
> -
> -	if (!do_sched_dispatch)
> -		return;
> +		if (!q->queue_depth) {
> +			blk_mq_flush_busy_ctxs(hctx, &rq_list);
> +			blk_mq_dispatch_rq_list(q, &rq_list);
> +		} else {
> +			blk_mq_do_dispatch_ctx(q, hctx);
> +		}
> +	} else {
>  
> -	/*
> -	 * We want to dispatch from the scheduler if we had no work left
> -	 * on the dispatch list, OR if we did have work but weren't able
> -	 * to make progress.
> -	 */
> -	if (has_sched_dispatch)
> +		/*
> +		 * We want to dispatch from the scheduler if we had no work left
> +		 * on the dispatch list, OR if we did have work but weren't able
> +		 * to make progress.
> +		 */
>  		blk_mq_do_dispatch_sched(q, e, hctx);
> -	else
> -		blk_mq_do_dispatch_ctx(q, hctx);
> +	}
>  }
>  
>  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> @@ -330,6 +353,7 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
>  	 */
>  	spin_lock(&hctx->lock);
>  	list_add(&rq->queuelist, &hctx->dispatch);
> +	set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
>  	spin_unlock(&hctx->lock);
>  	return true;
>  }
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f063dd0f197f..6af56a71c1cd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1140,6 +1140,11 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
>  
>  		spin_lock(&hctx->lock);
>  		list_splice_init(list, &hctx->dispatch);
> +		/*
> +		 * DISPATCH_BUSY won't be cleared until all requests
> +		 * in hctx->dispatch are dispatched successfully
> +		 */
> +		set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
>  		spin_unlock(&hctx->lock);
>  
>  		/*
> @@ -1927,6 +1932,7 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  
>  	spin_lock(&hctx->lock);
>  	list_splice_tail_init(&tmp, &hctx->dispatch);
> +	set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
>  	spin_unlock(&hctx->lock);
>  
>  	blk_mq_run_hw_queue(hctx, true);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 7b7a366a97f3..13f6c25fa461 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -172,6 +172,7 @@ enum {
>  	BLK_MQ_S_SCHED_RESTART	= 2,
>  	BLK_MQ_S_TAG_WAITING	= 3,
>  	BLK_MQ_S_START_ON_RUN	= 4,
> +	BLK_MQ_S_DISPATCH_BUSY	= 5,
>  
>  	BLK_MQ_MAX_DEPTH	= 10240,
>  
> -- 
> 2.9.5
> 
