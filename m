Return-Path: <hare@suse.de>
Subject: Re: [PATCH 6/6] bcache: use pr_info() to inform duplicated
 CACHE_SET_IO_DISABLE set
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20180502144659.118628-1-colyli@suse.de>
 <20180502144659.118628-7-colyli@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3e60582e-0bc7-44d3-25da-2907d539a6dd@suse.de>
Date: Thu, 3 May 2018 07:56:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180502144659.118628-7-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/02/2018 04:46 PM, Coly Li wrote:
> It is possible that multiple I/O requests hits on failed cache device or
> backing device, therefore it is quite common that CACHE_SET_IO_DISABLE is
> set already when a task tries to set the bit from bch_cached_dev_error()
> or bch_cache_set_error(). Currently the message "CACHE_SET_IO_DISABLE
> already set" is printed by pr_warn(), which might mislead users to think
> a serious fault happens in source code.
> 
> This patch uses pr_info() to print the information in such situations,
> avoid extra worries. This information is helpful to understand bcache
> behavior in cache device failures, so I still keep them in source code.
> 
> Fixes: a705642fd4ded ("bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()")
> Fixes: 771f393e8ffc9 ("bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags")
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 507755fcac5a..3dea06b41d43 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1394,7 +1394,7 @@ bool bch_cached_dev_error(struct cached_dev *dc)
>   	 */
>   	c = dc->disk.c;
>   	if (c && test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
> -		pr_warn("CACHE_SET_IO_DISABLE already set");
> +		pr_info("CACHE_SET_IO_DISABLE already set");
>   
>   	bcache_device_stop(&dc->disk);
>   	return true;
> @@ -1412,7 +1412,7 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
>   		return false;
>   
>   	if (test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
> -		pr_warn("CACHE_SET_IO_DISABLE already set");
> +		pr_info("CACHE_SET_IO_DISABLE already set");
>   
>   	/* XXX: we can be called from atomic context
>   	acquire_console_sem();
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
