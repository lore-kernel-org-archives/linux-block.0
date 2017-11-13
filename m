Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 13 Nov 2017 12:03:38 -0800
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, Kernel-team@fb.com,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] block-throttle: avoid double charge
Message-ID: <20171113200338.GK983427@devbig577.frc2.facebook.com>
References: <aac85300238aec9e310b5092260a6ec6e6f02e04.1507918159.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aac85300238aec9e310b5092260a6ec6e6f02e04.1507918159.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Shaohua.

On Fri, Oct 13, 2017 at 11:10:29AM -0700, Shaohua Li wrote:
> If a bio is throttled and splitted after throttling, the bio could be
> resubmited and enters the throttling again. This will cause part of the
> bio is charged multiple times. If the cgroup has an IO limit, the double
> charge will significantly harm the performance. The bio split becomes
> quite common after arbitrary bio size change.

Missed the patch previously.  Sorry about that.

> Some sort of this patch probably should go into stable since v4.2

Seriously.

> @@ -2130,9 +2130,15 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>  
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  
> -	/* see throtl_charge_bio() */
> -	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
> +	/*
> +	 * see throtl_charge_bio() for BIO_THROTTLED. If a bio is throttled
> +	 * against a disk but remapped to other disk, we should throttle it
> +	 * again
> +	 */
> +	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw] ||
> +	    (bio->bi_throttled_disk && bio->bi_throttled_disk == bio->bi_disk))
>  		goto out;
> +	bio->bi_throttled_disk = NULL;

So, one question I have is whether we need both BIO_THROTTLED and
bi_throttled_disk.  Can't we replace BIO_THROTTLED w/
bi_throttled_disk?

Thanks.

-- 
tejun
