Return-Path: <ming.lei@redhat.com>
Date: Sat, 29 Sep 2018 10:49:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, keith.busch@linux.intel.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: adjust debugfs and sysfs register when
 updating nr_hw_queues
Message-ID: <20180929024902.GA27170@ming.t460p>
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
 <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 27, 2018 at 06:43:03PM +0800, Jianchao Wang wrote:
> blk-mq debugfs and sysfs entries need to be removed before updating
> queue map, otherwise, we get get wrong result there. This patch fixes
> it and remove the redundant debugfs and sysfs register/unregister
> operations during __blk_mq_update_nr_hw_queues.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 39 ++++++++++++---------------------------
>  1 file changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 85a1c1a..6356455 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2137,8 +2137,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>  		struct blk_mq_tag_set *set,
>  		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  {
> -	blk_mq_debugfs_unregister_hctx(hctx);
> -
>  	if (blk_mq_hw_queue_mapped(hctx))
>  		blk_mq_tag_idle(hctx);
>  
> @@ -2165,6 +2163,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (i == nr_queue)
>  			break;
> +		blk_mq_debugfs_unregister_hctx(hctx);
>  		blk_mq_exit_hctx(q, set, hctx, i);
>  	}
>  }
> @@ -2222,8 +2221,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
>  	if (hctx->flags & BLK_MQ_F_BLOCKING)
>  		init_srcu_struct(hctx->srcu);
>  
> -	blk_mq_debugfs_register_hctx(q, hctx);
> -
>  	return 0;
>  
>   free_fq:
> @@ -2512,8 +2509,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  	int i, j;
>  	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
>  
> -	blk_mq_sysfs_unregister(q);
> -
>  	/* protect against switching io scheduler  */
>  	mutex_lock(&q->sysfs_lock);
>  	for (i = 0; i < set->nr_hw_queues; i++) {
> @@ -2561,7 +2556,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  	}
>  	q->nr_hw_queues = i;
>  	mutex_unlock(&q->sysfs_lock);
> -	blk_mq_sysfs_register(q);
>  }
>  
>  struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> @@ -2659,25 +2653,6 @@ void blk_mq_free_queue(struct request_queue *q)
>  	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
>  }

Looks both blk_mq_sysfs_register() and blk_mq_debugfs_register_hctx()
are removed from the path of blk_mq_init_allocated_queue(), so where are
the two registered for a freshly new queue?

Thanks,
Ming
