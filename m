Return-Path: <zhangweiping@didichuxing.com>
Date: Wed, 23 Aug 2017 23:25:15 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block, bfq: fix error handle in bfq_init
Message-ID: <20170823152515.GA9294@localhost.didichuxing.com>
References: <20170818163714.GA40576@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170818163714.GA40576@localhost.didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

On Sat, Aug 19, 2017 at 12:37:20AM +0800, weiping zhang wrote:
> if elv_register fail, bfq_pool should be free.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  block/bfq-iosched.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 436b6ca..bdb072f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5048,10 +5048,12 @@ static int __init bfq_init(void)
>  
>  	ret = elv_register(&iosched_bfq_mq);
>  	if (ret)
> -		goto err_pol_unreg;
> +		goto slab_kill;
>  
>  	return 0;
>  
> +slab_kill:
> +	bfq_slab_kill();
>  err_pol_unreg:
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
>  	blkcg_policy_unregister(&blkcg_policy_bfq);
> -- 
> 2.9.4
> 
Hi Paolo, Jens,

could you give some comments for this patch ?

Thanks
