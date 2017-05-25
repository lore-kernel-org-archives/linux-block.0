Subject: Re: [PATCH 0/7] blk-mq: fix queue quiescing
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20170525042131.13172-1-ming.lei@redhat.com>
 <1495689892.3045.2.camel@sandisk.com> <20170525090917.GB15737@ming.t460p>
 <1495733047.2615.1.camel@sandisk.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <cdfae246-d65e-fc49-69ec-dffe63832605@fb.com>
Date: Thu, 25 May 2017 11:42:59 -0600
MIME-Version: 1.0
In-Reply-To: <1495733047.2615.1.camel@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/25/2017 11:24 AM, Bart Van Assche wrote:
> On Thu, 2017-05-25 at 17:09 +0800, Ming Lei wrote:
>> Another big issue is that 'srcu_struct' is very big, which shouldn't
>> be embedded into hctx, since we only have one real user of
>> BLK_MQ_F_BLOCKING.
>>
>> So I will fix that too.
> 
> Hello Ming,
> 
> Is something like the (untested) patch below perhaps what you had in mind?
> 
> Subject: [PATCH] blk-mq: Reduce blk_mq_hw_ctx size
> 
> Since the srcu structure is rather large (184 bytes on an x86-64
> system), only allocate it if needed.
> 
> Reported-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c         | 13 ++++++++++++-
>  include/linux/blk-mq.h |  5 +++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1e330de4e3c5..15b7d4077638 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2233,6 +2233,17 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
>  }
>  EXPORT_SYMBOL(blk_mq_init_queue);
>  
> +static int blk_mq_hw_ctx_size(struct request_queue *q)
> +{
> +	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, queue_rq_srcu) +
> +		sizeof(((struct blk_mq_hw_ctx *)NULL)->queue_rq_srcu), 64) !=
> +		sizeof(struct blk_mq_hw_ctx));
> +
> +	return q->tag_set->flags & BLK_MQ_F_BLOCKING ?
> +		sizeof(struct blk_mq_hw_ctx) :
> +		offsetof(struct blk_mq_hw_ctx, queue_rq_srcu);
> +}
> +
>  static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  						struct request_queue *q)
>  {
> @@ -2247,7 +2258,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  			continue;
>  
>  		node = blk_mq_hw_queue_to_node(q->mq_map, i);
> -		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
> +		hctxs[i] = kzalloc_node(blk_mq_hw_ctx_size(q),
>  					GFP_KERNEL, node);
>  		if (!hctxs[i])
>  			break;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index c0d59330b5e0..8467e1f83524 100644
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
> +	struct srcu_struct	queue_rq_srcu;
>  };

Why not make it

	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
	struct srcu_struct	queue_rq_srcu[0];

and fixup blk_mq_hw_ctx_size()

static int blk_mq_hw_ctx_size(struct request_queue *q)
{
	int size = sizeof(struct blk_mq_hw_ctx);

	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
		size += sizeof(struct srcu_struct);

	return size;
}

I think that'd be cleaner. Keep the end-of-struct checking, just to be
on the safe side.

Neither one is super pretty though, and still doesn't fix the fact that
the srcu_struct is _half_ the blk_mq_hw_ctx in total.

-- 
Jens Axboe
