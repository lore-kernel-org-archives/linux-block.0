Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blkcg: add sanity check for blkcg policy operations
To: jthumshirn@suse.de, linux-block@vger.kernel.org
References: <20171011094619.GA37417@localhost.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3397954d-e59d-09d5-7aab-cb5f5ac4ce63@kernel.dk>
Date: Wed, 11 Oct 2017 10:51:32 -0600
MIME-Version: 1.0
In-Reply-To: <20171011094619.GA37417@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/11/2017 03:46 AM, weiping zhang wrote:
> blkcg policy should keep cpd/pd's alloc_fn and free_fn in pairs,
> otherwise policy would register fail.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  block/blk-cgroup.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index e7ec676..67b01c5 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1419,6 +1419,16 @@ int blkcg_policy_register(struct blkcg_policy *pol)
>  	if (i >= BLKCG_MAX_POLS)
>  		goto err_unlock;
>  
> +	/* Make sure cpd_alloc_fn and cpd_free_fn in pairs */
> +	if ((pol->cpd_alloc_fn && !pol->cpd_free_fn) ||
> +		(!pol->cpd_alloc_fn && pol->cpd_free_fn))
> +		goto err_unlock;

This might be cleaner (and more readable) as:

        if (!pol->cpd_alloc_fn ^ !pol->cpd_free_fn)
                goto err_unlock;

Ditto for the pd part.

-- 
Jens Axboe
