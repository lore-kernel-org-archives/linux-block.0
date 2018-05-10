Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 10 May 2018 10:03:34 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, efault@gmx.de,
	paolo.valente@linaro.org
Subject: Re: [PATCH 8/9] kyber-iosched: update shallow depth when setting up
 hardware queue
Message-ID: <20180510170334.GH30485@vader>
References: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
 <1525969467-12476-9-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525969467-12476-9-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 10:24:26AM -0600, Jens Axboe wrote:
> We don't expect the async depth to be smaller than the wake batch
> count for sbitmap, but just in case, inform sbitmap of what shallow
> depth kyber may use.
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/kyber-iosched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index 564967fafe5f..5b33dc394cc7 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -378,6 +378,7 @@ static void kyber_exit_sched(struct elevator_queue *e)
>  
>  static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  {
> +	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
>  	struct kyber_hctx_data *khd;
>  	int i;
>  
> @@ -400,6 +401,8 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  	khd->batching = 0;
>  
>  	hctx->sched_data = khd;
> +	sbitmap_queue_min_shallow_depth(&hctx->sched_tags->bitmap_tags,
> +					kqd->async_depth);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
