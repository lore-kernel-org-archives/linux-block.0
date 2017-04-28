Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936287AbdD1CMr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 22:12:47 -0400
Date: Fri, 28 Apr 2017 10:12:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, osandov@fb.com, hch@lst.de,
        bart.vanassche@sandisk.com
Subject: Re: [PATCH 1/3] blk-mq: unify hctx delayed_run_work and run_work
Message-ID: <20170428021230.GB31518@ming.t460p>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
 <1491839696-24783-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491839696-24783-2-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 10, 2017 at 09:54:54AM -0600, Jens Axboe wrote:
> They serve the exact same purpose. Get rid of the non-delayed
> work variant, and just run it without delay for the normal case.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-core.c       |  2 +-
>  block/blk-mq.c         | 27 ++++++---------------------
>  include/linux/blk-mq.h |  3 +--
>  3 files changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 8654aa0cef6d..d58541e4dc7b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -269,7 +269,7 @@ void blk_sync_queue(struct request_queue *q)
>  		int i;
>  
>  		queue_for_each_hw_ctx(q, hctx, i) {
> -			cancel_work_sync(&hctx->run_work);
> +			cancel_delayed_work_sync(&hctx->run_work);
>  			cancel_delayed_work_sync(&hctx->delay_work);
>  		}
>  	} else {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e2ef7b460924..7afba6ab5a96 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1168,13 +1168,9 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
>  		put_cpu();
>  	}
>  
> -	if (msecs == 0)
> -		kblockd_schedule_work_on(blk_mq_hctx_next_cpu(hctx),
> -					 &hctx->run_work);
> -	else
> -		kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
> -						 &hctx->delayed_run_work,
> -						 msecs_to_jiffies(msecs));
> +	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
> +					 &hctx->run_work,
> +					 msecs_to_jiffies(msecs));
>  }
>  
>  void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
> @@ -1226,7 +1222,7 @@ EXPORT_SYMBOL(blk_mq_queue_stopped);
>  
>  void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
>  {
> -	cancel_work(&hctx->run_work);
> +	cancel_delayed_work(&hctx->run_work);
>  	cancel_delayed_work(&hctx->delay_work);
>  	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
>  }
> @@ -1284,17 +1280,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
>  {
>  	struct blk_mq_hw_ctx *hctx;
>  
> -	hctx = container_of(work, struct blk_mq_hw_ctx, run_work);
> -
> -	__blk_mq_run_hw_queue(hctx);
> -}
> -
> -static void blk_mq_delayed_run_work_fn(struct work_struct *work)
> -{
> -	struct blk_mq_hw_ctx *hctx;
> -
> -	hctx = container_of(work, struct blk_mq_hw_ctx, delayed_run_work.work);
> -
> +	hctx = container_of(work, struct blk_mq_hw_ctx, run_work.work);
>  	__blk_mq_run_hw_queue(hctx);
>  }
>  
> @@ -1899,8 +1885,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>  	if (node == NUMA_NO_NODE)
>  		node = hctx->numa_node = set->numa_node;
>  
> -	INIT_WORK(&hctx->run_work, blk_mq_run_work_fn);
> -	INIT_DELAYED_WORK(&hctx->delayed_run_work, blk_mq_delayed_run_work_fn);
> +	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
>  	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
>  	spin_lock_init(&hctx->lock);
>  	INIT_LIST_HEAD(&hctx->dispatch);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d75de612845d..2b4573a9ccf4 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -15,7 +15,7 @@ struct blk_mq_hw_ctx {
>  		unsigned long		state;		/* BLK_MQ_S_* flags */
>  	} ____cacheline_aligned_in_smp;
>  
> -	struct work_struct	run_work;
> +	struct delayed_work	run_work;
>  	cpumask_var_t		cpumask;
>  	int			next_cpu;
>  	int			next_cpu_batch;
> @@ -51,7 +51,6 @@ struct blk_mq_hw_ctx {
>  
>  	atomic_t		nr_active;
>  
> -	struct delayed_work	delayed_run_work;
>  	struct delayed_work	delay_work;
>  
>  	struct hlist_node	cpuhp_dead;
> -- 
> 2.7.4

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
