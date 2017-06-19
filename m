Return-Path: <ming.lei@redhat.com>
Date: Mon, 19 Jun 2017 10:26:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v3 01/12] blk-mq: Reduce blk_mq_hw_ctx size
Message-ID: <20170619022631.GB11219@ming.t460p>
References: <20170608173355.25898-1-bart.vanassche@sandisk.com>
 <20170608173355.25898-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608173355.25898-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 08, 2017 at 10:33:44AM -0700, Bart Van Assche wrote:
> Since the srcu structure is rather large (184 bytes on an x86-64
> system with kernel debugging disabled), only allocate it if needed.
> 
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c         | 30 ++++++++++++++++++++++--------
>  include/linux/blk-mq.h |  5 +++--
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4e8b1bc87274..ef64a3ea4e83 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -172,7 +172,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (hctx->flags & BLK_MQ_F_BLOCKING)
> -			synchronize_srcu(&hctx->queue_rq_srcu);
> +			synchronize_srcu(hctx->queue_rq_srcu);
>  		else
>  			rcu = true;
>  	}
> @@ -1056,9 +1056,9 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  	} else {
>  		might_sleep();
>  
> -		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
> +		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
>  		blk_mq_sched_dispatch_requests(hctx);
> -		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
> +		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
>  	}
>  }
>  
> @@ -1460,9 +1460,9 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  
>  		might_sleep();
>  
> -		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
> +		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
>  		__blk_mq_try_issue_directly(hctx, rq, cookie, true);
> -		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
> +		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
>  	}
>  }
>  
> @@ -1806,7 +1806,7 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>  		set->ops->exit_hctx(hctx, hctx_idx);
>  
>  	if (hctx->flags & BLK_MQ_F_BLOCKING)
> -		cleanup_srcu_struct(&hctx->queue_rq_srcu);
> +		cleanup_srcu_struct(hctx->queue_rq_srcu);
>  
>  	blk_mq_remove_cpuhp(hctx);
>  	blk_free_flush_queue(hctx->fq);
> @@ -1879,7 +1879,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>  		goto free_fq;
>  
>  	if (hctx->flags & BLK_MQ_F_BLOCKING)
> -		init_srcu_struct(&hctx->queue_rq_srcu);
> +		init_srcu_struct(hctx->queue_rq_srcu);
>  
>  	blk_mq_debugfs_register_hctx(q, hctx);
>  
> @@ -2154,6 +2154,20 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
>  }
>  EXPORT_SYMBOL(blk_mq_init_queue);
>  
> +static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
> +{
> +	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
> +
> +	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, queue_rq_srcu),
> +			   __alignof__(struct blk_mq_hw_ctx)) !=
> +		     sizeof(struct blk_mq_hw_ctx));
> +
> +	if (tag_set->flags & BLK_MQ_F_BLOCKING)
> +		hw_ctx_size += sizeof(struct srcu_struct);
> +
> +	return hw_ctx_size;
> +}
> +
>  static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  						struct request_queue *q)
>  {
> @@ -2168,7 +2182,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  			continue;
>  
>  		node = blk_mq_hw_queue_to_node(q->mq_map, i);
> -		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
> +		hctxs[i] = kzalloc_node(blk_mq_hw_ctx_size(set),
>  					GFP_KERNEL, node);
>  		if (!hctxs[i])
>  			break;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index fcd641032f8d..c534ec64e214 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -39,8 +39,6 @@ struct blk_mq_hw_ctx {
>  	struct blk_mq_tags	*tags;
>  	struct blk_mq_tags	*sched_tags;
>  
> -	struct srcu_struct	queue_rq_srcu;
> -
>  	unsigned long		queued;
>  	unsigned long		run;
>  #define BLK_MQ_MAX_DISPATCH_ORDER	7
> @@ -62,6 +60,9 @@ struct blk_mq_hw_ctx {
>  	struct dentry		*debugfs_dir;
>  	struct dentry		*sched_debugfs_dir;
>  #endif
> +
> +	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
> +	struct srcu_struct	queue_rq_srcu[0];
>  };
>  
>  struct blk_mq_tag_set {
> -- 
> 2.12.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
