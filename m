Return-Path: <i@coly.li>
Subject: Re: [PATCH 18/19] bcache: silence static checker warning
To: bcache@lists.ewheeler.net, linux-block@vger.kernel.org
Cc: linux-bcache@vger.kernel.org, hch@infradead.org, axboe@kernel.dk,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20170629134510.GA32385@infradead.org>
 <1498855388-16990-1-git-send-email-bcache@lists.ewheeler.net>
 <1498855388-16990-18-git-send-email-bcache@lists.ewheeler.net>
From: Coly Li <i@coly.li>
Message-ID: <7aaea4a6-b097-6aae-31e9-7851a1016f38@coly.li>
Date: Thu, 13 Jul 2017 17:44:25 +0800
MIME-Version: 1.0
In-Reply-To: <1498855388-16990-18-git-send-email-bcache@lists.ewheeler.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2017/7/1 上午4:43, bcache@lists.ewheeler.net wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> In olden times, closure_return() used to have a hidden return built in.
> We removed the hidden return but forgot to add a new return here.  If
> "c" were NULL we would oops on the next line, but fortunately "c" is
> never NULL.  Let's just remove the if statement.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/md/bcache/super.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 24cb9b7..243391d 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1381,9 +1381,6 @@ static void cache_set_flush(struct closure *cl)
>  	struct btree *b;
>  	unsigned i;
>  
> -	if (!c)
> -		closure_return(cl);
> -
>  	bch_cache_accounting_destroy(&c->accounting);
>  
>  	kobject_put(&c->internal);
> 
Agree, cache_set_flush() is only called from a continue_at() in
__cache_set_unregister(). In this case, cl is always not NULL.

Reviewed-by: Coly Li <colyli@suse.de>

Thanks.

-- 
Coly Li
