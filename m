Return-Path: <colyli@suse.de>
Subject: Re: [PATCH 6/6] bcache: use pr_info() to inform duplicated
 CACHE_SET_IO_DISABLE set
To: linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20180502144659.118628-1-colyli@suse.de>
 <20180502144659.118628-7-colyli@suse.de>
From: Coly Li <colyli@suse.de>
Message-ID: <50ef5639-0fa1-5823-9183-d4530cf40330@suse.de>
Date: Wed, 2 May 2018 23:01:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180502144659.118628-7-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/5/2 10:46 PM, Coly Li wrote:
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

Hi Jens,

> Fixes: a705642fd4ded ("bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()")

I just realize this is not upstream yet, and only in my private tree. so
I need to modify this patch in following way.

> Fixes: 771f393e8ffc9 ("bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags")
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 507755fcac5a..3dea06b41d43 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1394,7 +1394,7 @@ bool bch_cached_dev_error(struct cached_dev *dc)
>  	 */
>  	c = dc->disk.c;
>  	if (c && test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
> -		pr_warn("CACHE_SET_IO_DISABLE already set");
> +		pr_info("CACHE_SET_IO_DISABLE already set");
>  

This part will go directly into patch "bcache: set CACHE_SET_IO_DISABLE
in bch_cached_dev_error()".

>  	bcache_device_stop(&dc->disk);
>  	return true;
> @@ -1412,7 +1412,7 @@ bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...)
>  		return false;
>  
>  	if (test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
> -		pr_warn("CACHE_SET_IO_DISABLE already set");
> +		pr_info("CACHE_SET_IO_DISABLE already set");
>  
>  	/* XXX: we can be called from atomic context
>  	acquire_console_sem();
> 

And only this part should be in this patch.

I will send out a v3 patch set very soon.

Sorry for the noise.

Coly Li
