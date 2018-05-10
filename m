Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 10 May 2018 09:59:48 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, efault@gmx.de,
	paolo.valente@linaro.org
Subject: Re: [PATCH 2/9] bfq-iosched: don't worry about reserved tags in
 limit_depth
Message-ID: <20180510165948.GB30485@vader>
References: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
 <1525969467-12476-3-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525969467-12476-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 10:24:20AM -0600, Jens Axboe wrote:
> Reserved tags are used for error handling, we don't need to
> care about them for regular IO. The core won't call us for these
> anyway.
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/bfq-iosched.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index eefd8a4bc936..db38e88a5670 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -542,14 +542,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
>  	if (op_is_sync(op) && !op_is_write(op))
>  		return;
>  
> -	if (data->flags & BLK_MQ_REQ_RESERVED) {
> -		if (unlikely(!tags->nr_reserved_tags)) {
> -			WARN_ON_ONCE(1);
> -			return;
> -		}
> -		bt = &tags->breserved_tags;
> -	} else
> -		bt = &tags->bitmap_tags;
> +	bt = &tags->bitmap_tags;
>  
>  	if (unlikely(bfqd->sb_shift != bt->sb.shift))
>  		bfq_update_depths(bfqd, bt);
> -- 
> 2.7.4
> 
