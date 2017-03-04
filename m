Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 4 Mar 2017 11:23:03 -0800
From: Tejun Heo <tj@kernel.org>
To: Tahsin Erdogan <tahsin@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] blkcg: allocate struct blkcg_gq outside request queue
 spinlock
Message-ID: <20170304192303.GA29316@wtj.duckdns.org>
References: <20170303192325.GB22962@wtj.duckdns.org>
 <20170304014005.23773-1-tahsin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170304014005.23773-1-tahsin@google.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Tahsin.

Generally looks good.  Please see below.

> @@ -184,24 +185,48 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
> +	if (unlikely(!wb_congested)) {
>  		ret = -ENOMEM;
>  		goto err_put_css;
> +	} else if (unlikely(!blkg)) {
> +		ret = -ENOMEM;
> +		goto err_put_congested;
>  	}

I'm not sure this error handling logic is correct.  We can have any
combo of alloc failure here, right?

> @@ -694,9 +695,20 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
>  	blkg = blkg_lookup(blkcg, q);
>  	if (unlikely(!blkg)) {
>  		spin_lock_irq(q->queue_lock);
> -		blkg = blkg_lookup_create(blkcg, q);
> -		if (IS_ERR(blkg))
> -			blkg = NULL;
> +
> +		/*
> +		 * This could be the first entry point of blkcg implementation
> +		 * and we shouldn't allow anything to go through for a bypassing
> +		 * queue.
> +		 */
> +		if (likely(!blk_queue_bypass(q))) {
> +			blkg = blkg_lookup_create(blkcg, q,
> +						  GFP_NOWAIT | __GFP_NOWARN,
> +						  NULL);
> +			if (IS_ERR(blkg))
> +				blkg = NULL;
> +		}

Heh, this seems a bit too fragile.  I get that this covers both call
paths into lookup_create which needs the checking, but it seems a bit
too nasty to do it this way.  Would it be ugly if we factor out both
policy enabled and bypass tests into a helper and have inner
__blkg_lookup_create() which skips it?  We can call the same helper
from blkg_create() when @pol.  Sorry that this is involving so much
bikeshedding.

Thanks!

-- 
tejun
