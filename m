Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 30 May 2018 09:40:39 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 12/13] block: introduce blk-iolatency io controller
Message-ID: <20180530164039.GP1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-13-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529211724.4531-13-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

Just interface nits.

On Tue, May 29, 2018 at 05:17:23PM -0400, Josef Bacik wrote:
...
> +static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
> +				size_t size)
> +{
> +	struct iolatency_grp *iolat = pd_to_lat(pd);
> +	struct blkcg_gq *blkg = pd_to_blkg(pd);
> +	unsigned use_delay = atomic_read(&blkg->use_delay);
> +
> +	if (!iolat->min_lat_nsec)
> +		return 0;
> +
> +	return snprintf(buf, size,
> +			" depth=%u delay=%llu use_delay=%u total_lat_avg=%llu",
> +			iolat->rq_depth.max_depth,

Can we please use "max" as depth value when there is no restriction?

> +			(unsigned long long)(use_delay ?
> +				atomic64_read(&blkg->delay_nsec) /
> +				NSEC_PER_USEC : 0),
> +			use_delay,
> +			(unsigned long long)iolat->total_lat_avg /
> +			NSEC_PER_USEC);

and "avg_lat".

I'm a bit worried about exposing anything other than avg_lat given
that they're inherently implementation details.  I think it might be a
good idea to gate them behind a kernel boot param (which hopefully can
be turned on/off while the system is running).

Thanks.

-- 
tejun
