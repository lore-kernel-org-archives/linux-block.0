Return-Path: <ming.lei@redhat.com>
Date: Tue, 16 Oct 2018 08:58:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: provider helper for setting up an SQ queue and
 tag set
Message-ID: <20181016005852.GA5345@ming.t460p>
References: <bbbcb203-c2e4-7735-1295-97f21e93fb0a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bbbcb203-c2e4-7735-1295-97f21e93fb0a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 15, 2018 at 09:34:36AM -0600, Jens Axboe wrote:
> This pattern is repeated throughout all the blk-mq conversions.
> Provide a basic helper to get it done.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c         | 33 +++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  4 ++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c2ecd64a2403..dcf10e39995a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2507,6 +2507,39 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
>  }
>  EXPORT_SYMBOL(blk_mq_init_queue);
>  
> +/*
> + * Helper for setting up a queue with mq ops, given queue depth, and
> + * the passed in mq ops flags.
> + */
> +struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
> +					   const struct blk_mq_ops *ops,
> +					   unsigned int queue_depth,
> +					   unsigned int set_flags)
> +{
> +	struct request_queue *q;
> +	int ret;
> +
> +	memset(set, 0, sizeof(*set));
> +	set->ops = ops;
> +	set->nr_hw_queues = 1;
> +	set->queue_depth = queue_depth;
> +	set->numa_node = NUMA_NO_NODE;
> +	set->flags = set_flags;
> +
> +	ret = blk_mq_alloc_tag_set(set);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	q = blk_mq_init_queue(set);
> +	if (IS_ERR(q)) {
> +		blk_mq_free_tag_set(set);
> +		return q;
> +	}
> +
> +	return q;
> +}
> +EXPORT_SYMBOL(blk_mq_init_sq_queue);
> +
>  static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
>  {
>  	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 1da59c16f637..2286dc12c6bc 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -203,6 +203,10 @@ enum {
>  struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
>  struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  						  struct request_queue *q);
> +struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
> +						const struct blk_mq_ops *ops,
> +						unsigned int queue_depth,
> +						unsigned int set_flags);
>  int blk_mq_register_dev(struct device *, struct request_queue *);
>  void blk_mq_unregister_dev(struct device *, struct request_queue *);
>  
> -- 
> 2.17.1
> 
> -- 
> Jens Axboe
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
