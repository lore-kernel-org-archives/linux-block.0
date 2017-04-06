Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755715AbdDFEba (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 00:31:30 -0400
Date: Thu, 6 Apr 2017 12:31:18 +0800
From: Ming Lei <minlei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 1/8] blk-mq: use the right hctx when getting a driver
 tag fails
Message-ID: <20170406043108.GA29955@ming.t460p>
References: <cover.1491418411.git.osandov@fb.com>
 <d1b5da71a5cba1f17d4eaafb207547a4651f81a9.1491418411.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d1b5da71a5cba1f17d4eaafb207547a4651f81a9.1491418411.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 05, 2017 at 12:01:29PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> While dispatching requests, if we fail to get a driver tag, we mark the
> hardware queue as waiting for a tag and put the requests on a
> hctx->dispatch list to be run later when a driver tag is freed. However,
> blk_mq_dispatch_rq_list() may dispatch requests from multiple hardware
> queues if using a single-queue scheduler with a multiqueue device. If

It can't perform well by using a SQ scheduler on a MQ device, so just be
curious why someone wants to do that in this way,:-)

I guess you mean that ops.mq.dispatch_request() may dispatch requests
from other hardware queues in blk_mq_sched_dispatch_requests() instead
of current hctx.

If that is true, it looks like a issue in usage of I/O scheduler, since
the mq-deadline scheduler just queues requests in one per-request_queue
linked list, for MQ device, the scheduler queue should have been per-hctx.

> blk_mq_get_driver_tag() fails, it doesn't update the hardware queue we
> are processing. This means we end up using the hardware queue of the
> previous request, which may or may not be the same as that of the
> current request. If it isn't, the wrong hardware queue will end up
> waiting for a tag, and the requests will be on the wrong dispatch list,
> leading to a hang.
> 
> The fix is twofold:
> 
> 1. Make sure we save which hardware queue we were trying to get a
>    request for in blk_mq_get_driver_tag() regardless of whether it
>    succeeds or not.

It shouldn't have be needed, once rq->mq_ctx is set, the hctx should been
fixed already, that means we can just pass the hctx to blk_mq_get_driver_tag().

> 2. Make blk_mq_dispatch_rq_list() take a request_queue instead of a
>    blk_mq_hw_queue to make it clear that it must handle multiple
>    hardware queues, since I've already messed this up on a couple of
>    occasions.
> 
> This didn't appear in testing with nvme and mq-deadline because nvme has
> more driver tags than the default number of scheduler tags. However,
> with the blk_mq_update_nr_hw_queues() fix, it showed up with nbd.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-sched.c |  9 +++++----
>  block/blk-mq.c       | 25 +++++++++++++------------
>  block/blk-mq.h       |  2 +-
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 09af8ff18719..fc00f00898d3 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -171,7 +171,8 @@ void blk_mq_sched_put_request(struct request *rq)
>  
>  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  {
> -	struct elevator_queue *e = hctx->queue->elevator;
> +	struct request_queue *q = hctx->queue;
> +	struct elevator_queue *e = q->elevator;
>  	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;
>  	bool did_work = false;
>  	LIST_HEAD(rq_list);
> @@ -203,10 +204,10 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	 */
>  	if (!list_empty(&rq_list)) {
>  		blk_mq_sched_mark_restart_hctx(hctx);
> -		did_work = blk_mq_dispatch_rq_list(hctx, &rq_list);
> +		did_work = blk_mq_dispatch_rq_list(q, &rq_list);
>  	} else if (!has_sched_dispatch) {
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
> -		blk_mq_dispatch_rq_list(hctx, &rq_list);
> +		blk_mq_dispatch_rq_list(q, &rq_list);
>  	}
>  
>  	/*
> @@ -222,7 +223,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  			if (!rq)
>  				break;
>  			list_add(&rq->queuelist, &rq_list);
> -		} while (blk_mq_dispatch_rq_list(hctx, &rq_list));
> +		} while (blk_mq_dispatch_rq_list(q, &rq_list));
>  	}
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f7cd3208bcdf..09cff6d1ba76 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -863,12 +863,8 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>  		.flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
>  	};
>  
> -	if (rq->tag != -1) {
> -done:
> -		if (hctx)
> -			*hctx = data.hctx;
> -		return true;
> -	}
> +	if (rq->tag != -1)
> +		goto done;
>  
>  	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
>  		data.flags |= BLK_MQ_REQ_RESERVED;
> @@ -880,10 +876,12 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>  			atomic_inc(&data.hctx->nr_active);
>  		}
>  		data.hctx->tags->rqs[rq->tag] = rq;
> -		goto done;
>  	}
>  
> -	return false;
> +done:
> +	if (hctx)
> +		*hctx = data.hctx;
> +	return rq->tag != -1;
>  }
>  
>  static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
> @@ -980,17 +978,20 @@ static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
>  	return true;
>  }
>  
> -bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
> +bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
>  {
> -	struct request_queue *q = hctx->queue;
> +	struct blk_mq_hw_ctx *hctx;
>  	struct request *rq;
>  	int errors, queued, ret = BLK_MQ_RQ_QUEUE_OK;
>  
> +	if (list_empty(list))
> +		return false;
> +
>  	/*
>  	 * Now process all the entries, sending them to the driver.
>  	 */
>  	errors = queued = 0;
> -	while (!list_empty(list)) {
> +	do {
>  		struct blk_mq_queue_data bd;
>  
>  		rq = list_first_entry(list, struct request, queuelist);
> @@ -1053,7 +1054,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
>  
>  		if (ret == BLK_MQ_RQ_QUEUE_BUSY)
>  			break;
> -	}
> +	} while (!list_empty(list));
>  
>  	hctx->dispatched[queued_to_index(queued)]++;
>  
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 8d49c06fc520..7e6f2e467696 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -30,7 +30,7 @@ void blk_mq_freeze_queue(struct request_queue *q);
>  void blk_mq_free_queue(struct request_queue *q);
>  int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
>  void blk_mq_wake_waiters(struct request_queue *q);
> -bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *, struct list_head *);
> +bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *);
>  void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
>  bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
>  bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
> -- 
> 2.12.2
> 

-- 
Ming
