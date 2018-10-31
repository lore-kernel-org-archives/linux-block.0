Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 07/16] blk-mq: support multiple hctx maps
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-8-axboe@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1e523ea4-1134-c299-281d-0dad276825d2@grimberg.me>
Date: Tue, 30 Oct 2018 17:59:47 -0700
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-8-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 1821f448f7c4..8329017badc8 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -72,20 +72,37 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>    */
>   extern int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int);
>   
> -static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
> -						     unsigned int flags,
> -						     unsigned int cpu)
> +/*
> + * blk_mq_map_queue_type() - map (hctx_type,cpu) to hardware queue
> + * @q: request queue
> + * @hctx_type: the hctx type index
> + * @cpu: CPU
> + */
> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
> +							  unsigned int hctx_type,
> +							  unsigned int cpu)
>   {
>   	struct blk_mq_tag_set *set = q->tag_set;
>   
> -	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
> +	return q->queue_hw_ctx[set->map[hctx_type].mq_map[cpu]];
>   }
>   
> -static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
> -							  unsigned int hctx_type,
> -							  unsigned int cpu)
> +/*
> + * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
> + * @q: request queue
> + * @flags: request command flags
> + * @cpu: CPU
> + */
> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
> +						     unsigned int flags,
> +						     unsigned int cpu)
>   {
> -	return blk_mq_map_queue(q, hctx_type, cpu);
> +	int hctx_type = 0;
> +
> +	if (q->mq_ops->flags_to_type)
> +		hctx_type = q->mq_ops->flags_to_type(q, flags);

nitpick: I think that rq_flags_to_type is a bit more descriptive here.
just a personal opinion.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
