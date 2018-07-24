Return-Path: <sergey.senozhatsky.work@gmail.com>
Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Tue, 24 Jul 2018 11:52:28 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: minchan@kernel.org, ngupta@vflare.org,
	sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] block: zram: Replace GFP_ATOMIC with GFP_KERNEL
Message-ID: <20180724025228.GA558@jagdpanzerIV>
References: <20180723141304.3300-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180723141304.3300-1-baijiaju1990@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On (07/23/18 22:13), Jia-Ju Bai wrote:
> read_from_bdev_async() and write_to_bdev() are never called in atomic
> context. They call bio_alloc() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.

[..]

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 0f3fadd71230..b958ed0b8c35 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -450,7 +450,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>  {
>  	struct bio *bio;
>  
> -	bio = bio_alloc(GFP_ATOMIC, 1);
> +	bio = bio_alloc(GFP_KERNEL, 1);
>  	if (!bio)
>  		return -ENOMEM;
>  
> @@ -538,7 +538,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
>  	struct bio *bio;
>  	unsigned long entry;
>  
> -	bio = bio_alloc(GFP_ATOMIC, 1);
> +	bio = bio_alloc(GFP_KERNEL, 1);
>  	if (!bio)
>  		return -ENOMEM;

I think the intent here is different and is not related to atomic
contexts.

Consider the following
  OMM -> swapout -> __zram_bvec_write() -> write_to_bdev() -> bio_alloc(GFP_KERNEL) -> [OOM?]

So maybe we can do a bit better than GFP_ATOMIC (NOIO, etc.), but in general,
I believe, we can't use GFP_KERNEL [at least in write_to_bdev()].

	-ss
