Return-Path: <ming.lei@redhat.com>
Date: Tue, 29 Aug 2017 17:35:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 1/2] block/loop: set hw_sectors
Message-ID: <20170829093543.GA32439@ming.t460p>
References: <cover.1503602376.git.shli@fb.com>
 <92dafefc8c0b64eaaf51298734ebe4aa7d880046.1503602376.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92dafefc8c0b64eaaf51298734ebe4aa7d880046.1503602376.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 24, 2017 at 12:24:52PM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> Loop can handle any size of request. Limiting it to 255 sectors just
> burns the CPU for bio split and request merge for underlayer disk and
> also cause bad fs block allocation in directio mode.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index b55a1f8..428da07 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1799,6 +1799,7 @@ static int loop_add(struct loop_device **l, int i)
>  	}
>  	lo->lo_queue->queuedata = lo;
>  
> +	blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
>  	/*
>  	 * It doesn't make sense to enable merge because the I/O
>  	 * submitted to backing file is handled page by page.
> -- 
> 2.9.5
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
