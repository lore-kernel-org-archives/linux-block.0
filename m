Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 10 May 2018 09:59:31 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, efault@gmx.de,
	paolo.valente@linaro.org
Subject: Re: [PATCH 1/9] blk-mq: don't call into depth limiting for reserved
 tags
Message-ID: <20180510165931.GA30485@vader>
References: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
 <1525969467-12476-2-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525969467-12476-2-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 10:24:19AM -0600, Jens Axboe wrote:
> It's not useful, they are internal and/or error handling recovery
> commands.
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4e9d83594cca..64630caaf27e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -360,9 +360,11 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>  
>  		/*
>  		 * Flush requests are special and go directly to the
> -		 * dispatch list.
> +		 * dispatch list. Don't include reserved tags in the
> +		 * limiting, as it isn't useful.
>  		 */
> -		if (!op_is_flush(op) && e->type->ops.mq.limit_depth)
> +		if (!op_is_flush(op) && e->type->ops.mq.limit_depth &&
> +		    !(data->flags & BLK_MQ_REQ_RESERVED))
>  			e->type->ops.mq.limit_depth(op, data);
>  	}
>  
> -- 
> 2.7.4
> 
