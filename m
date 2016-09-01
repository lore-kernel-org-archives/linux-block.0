Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 1 Sep 2016 11:05:23 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] wbt: add general throttling mechanism
Message-ID: <20160901180523.GA3280@vader.DHCP.thefacebook.com>
References: <1472663151-18560-1-git-send-email-axboe@fb.com>
 <1472663151-18560-8-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472663151-18560-8-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 31, 2016 at 11:05:50AM -0600, Jens Axboe wrote:
> We can hook this up to the block layer, to help throttle buffered
> writes. Or NFS can tap into it, to accomplish the same.
> 
> wbt registers a few trace points that can be used to track what is
> happening in the system:
> 
> wbt_lat: 259:0: latency 2446318
> wbt_stat: 259:0: rmean=2446318, rmin=2446318, rmax=2446318, rsamples=1,
>                wmean=518866, wmin=15522, wmax=5330353, wsamples=57
> wbt_step: 259:0: step down: step=1, window=72727272, background=8, normal=16, max=32
> 
> This shows a sync issue event (wbt_lat) that exceeded it's time. wbt_stat
> dumps the current read/write stats for that window, and wbt_step shows a
> step down event where we now scale back writes. Each trace includes the
> device, 259:0 in this case.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  include/linux/wbt.h        | 118 +++++++++
>  include/trace/events/wbt.h | 122 ++++++++++
>  lib/Kconfig                |   4 +
>  lib/Makefile               |   1 +
>  lib/wbt.c                  | 587 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 832 insertions(+)
>  create mode 100644 include/linux/wbt.h
>  create mode 100644 include/trace/events/wbt.h
>  create mode 100644 lib/wbt.c
> 

[snip]

> diff --git a/lib/Kconfig b/lib/Kconfig
> index d79909dc01ec..5a65a1f91889 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -550,4 +550,8 @@ config STACKDEPOT
>  	bool
>  	select STACKTRACE
>  
> +config WBT
> +	bool
> +	select SCALE_BITMAP

Looks like this snuck in from your experiments to get this to work on
top of scale_bitmap?

[snip]

> +void __wbt_done(struct rq_wb *rwb)
> +{
> +	int inflight, limit;
> +
> +	inflight = atomic_dec_return(&rwb->inflight);
> +
> +	/*
> +	 * wbt got disabled with IO in flight. Wake up any potential
> +	 * waiters, we don't have to do more than that.
> +	 */
> +	if (unlikely(!rwb_enabled(rwb))) {
> +		wake_up_all(&rwb->wait);
> +		return;
> +	}
> +
> +	/*
> +	 * If the device does write back caching, drop further down
> +	 * before we wake people up.
> +	 */
> +	if (rwb->wc && !atomic_read(&rwb->bdi->wb.dirty_sleeping))
> +		limit = 0;
> +	else
> +		limit = rwb->wb_normal;
> +
> +	/*
> +	 * Don't wake anyone up if we are above the normal limit.
> +	 */
> +	if (inflight && inflight >= limit)
> +		return;
> +
> +	if (waitqueue_active(&rwb->wait)) {
> +		int diff = limit - inflight;
> +
> +		if (!inflight || diff >= rwb->wb_background / 2)
> +			wake_up_nr(&rwb->wait, 1);

wake_up(&rwb->wait)?

-- 
Omar
