Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 10 May 2018 10:03:06 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, efault@gmx.de,
	paolo.valente@linaro.org
Subject: Re: [PATCH 7/9] bfq-iosched: update shallow depth to smallest one
 used
Message-ID: <20180510170306.GG30485@vader>
References: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
 <1525969467-12476-8-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525969467-12476-8-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 10:24:25AM -0600, Jens Axboe wrote:
> If our shallow depth is smaller than the wake batching of sbitmap,
> we can introduce hangs. Ensure that sbitmap knows how low we'll go.
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/bfq-iosched.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 10294124d597..b622e73a326a 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5081,10 +5081,13 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
>  
>  /*
>   * See the comments on bfq_limit_depth for the purpose of
> - * the depths set in the function.
> + * the depths set in the function. Return minimum shallow depth we'll use.
>   */
> -static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
> +static unsigned int bfq_update_depths(struct bfq_data *bfqd,
> +				      struct sbitmap_queue *bt)
>  {
> +	unsigned int i, j, min_shallow = UINT_MAX;
> +
>  	/*
>  	 * In-word depths if no bfq_queue is being weight-raised:
>  	 * leaving 25% of tags only for sync reads.
> @@ -5115,14 +5118,22 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>  	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
>  	/* no more than ~37% of tags for sync writes (~20% extra tags) */
>  	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
> +
> +	for (i = 0; i < 2; i++)
> +		for (j = 0; j < 2; j++)
> +			min_shallow = min(min_shallow, bfqd->word_depths[i][j]);
> +
> +	return min_shallow;
>  }
>  
>  static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
>  {
>  	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>  	struct blk_mq_tags *tags = hctx->sched_tags;
> +	unsigned int min_shallow;
>  
> -	bfq_update_depths(bfqd, &tags->bitmap_tags);
> +	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
> +	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
