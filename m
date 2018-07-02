Return-Path: <lars.ellenberg@linbit.com>
Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 2 Jul 2018 13:27:21 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [PATCH] drbd: fix access after free
Message-ID: <20180702112703.GA10994@soda.linbit>
References: <20180625093952.20220-1-lars.ellenberg@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180625093952.20220-1-lars.ellenberg@linbit.com>
List-ID: <linux-block@vger.kernel.org>

Jens, I had hoped you'd apply this "oneliner" into 4.18 already?
Did you miss it?

Cheers,

	Lars


On Mon, Jun 25, 2018 at 11:39:52AM +0200, Lars Ellenberg wrote:
>   	bio_put(req->private_bio);
>  -	req->private_bio = ERR_PTR(error);
>  +	req->private_bio = ERR_PTR(bio->bi_error);
> 
> Which introduces an access after free,
> because it was non obvious that req->private_bio == bio.

>   	bio_put(req->private_bio);
>   	req->private_bio = ERR_PTR(blk_status_to_errno(bio->bi_status));

> Should also go into stable since 4.3, with the trivial change around 4.13.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4246a0b63bd8 block: add a bi_error field to struct bio
> Reported-by: Sarah Newman <srn@prgmr.com>
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---
>  drivers/block/drbd/drbd_worker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
> index 1476cb3439f4..5e793dd7adfb 100644
> --- a/drivers/block/drbd/drbd_worker.c
> +++ b/drivers/block/drbd/drbd_worker.c
> @@ -282,8 +282,8 @@ void drbd_request_endio(struct bio *bio)
>  		what = COMPLETED_OK;
>  	}
>  
> -	bio_put(req->private_bio);
>  	req->private_bio = ERR_PTR(blk_status_to_errno(bio->bi_status));
> +	bio_put(bio);
>  
>  	/* not req_mod(), we need irqsave here! */
>  	spin_lock_irqsave(&device->resource->req_lock, flags);
> -- 
> 2.17.1
