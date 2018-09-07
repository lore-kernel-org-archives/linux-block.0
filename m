Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 7 Sep 2018 10:27:30 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] blkcg: convert blkg_lookup_create to find closest
 blkg
Message-ID: <20180907172730.GB1100574@devbig004.ftw2.facebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-4-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906211045.29055-4-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Sep 06, 2018 at 05:10:36PM -0400, Dennis Zhou wrote:
> @@ -2021,9 +2021,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
>  {
>  	if (unlikely(bio->bi_blkg))
>  		return -EBUSY;
> +	bio->bi_blkg = blkg_try_get_closest(blkg);
>  	return 0;

It prolly would be a good idea to point out that the associated blkg
might not be the same one passed in.  Maybe this gets cleared up later
in the series?

> @@ -298,14 +297,23 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
>  	while (true) {
>  		struct blkcg *pos = blkcg;
>  		struct blkcg *parent = blkcg_parent(blkcg);
> -
> -		while (parent && !__blkg_lookup(parent, q, false)) {
> +		struct blkcg_gq *ret_blkg = NULL;
> +
> +		while (parent) {
> +			blkg = __blkg_lookup(parent, q, false);
> +			if (blkg) {
> +				/* remember closest blkg */
> +				ret_blkg = blkg;
> +				break;
> +			}
>  			pos = parent;
>  			parent = blkcg_parent(parent);
>  		}
>  
>  		blkg = blkg_create(pos, q, NULL);
> -		if (pos == blkcg || IS_ERR(blkg))
> +		if (IS_ERR(blkg))
> +			return ret_blkg ?: q->root_blkg;

Why not ret_blkg here?

Thanks.

-- 
tejun
