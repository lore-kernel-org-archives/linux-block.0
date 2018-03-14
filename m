Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 14 Mar 2018 07:09:01 -0700
From: Tejun Heo <tj@kernel.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5] blk-throttle: fix race between
 blkcg_bio_issue_check() and cgroup_rmdir()
Message-ID: <20180314140901.GV2943022@devbig577.frc2.facebook.com>
References: <5c99ef07-1133-a45a-9a09-7c29e8139f5b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c99ef07-1133-a45a-9a09-7c29e8139f5b@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Mar 14, 2018 at 02:18:04PM +0800, Joseph Qi wrote:
> Fixes: ae1188963611 ("blkcg: consolidate blkg creation in blkcg_bio_issue_check()")
> Reported-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> Cc: stable@vger.kernel.org #4.3+

I'm a bit nervous about tagging it for -stable.  Given the low rate of
this actually occurring, I'm not sure the benefits outweigh the risks.
Let's at least cook it for a couple releases before sending it to
-stable.

> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index 69bea82..dccd102 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -88,6 +88,7 @@ struct blkg_policy_data {
>  	/* the blkg and policy id this per-policy data belongs to */
>  	struct blkcg_gq			*blkg;
>  	int				plid;
> +	bool				offlined;
>  };

This is pure bike-shedding but offlined reads kinda weird to me, maybe
just offline would read better?  Other than that,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks a lot for seeing this through.

-- 
tejun
