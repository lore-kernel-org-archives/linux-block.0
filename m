Return-Path: <jack@suse.cz>
Date: Tue, 8 Nov 2016 14:39:30 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH 7/8] blk-wbt: add general throttling mechanism
Message-ID: <20161108133930.GQ32353@quack2.suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-8-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034531-28559-8-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue 01-11-16 15:08:50, Jens Axboe wrote:
> We can hook this up to the block layer, to help throttle buffered
> writes.
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

Just one serious question and one nit below:

> +void __wbt_done(struct rq_wb *rwb, enum wbt_flags wb_acct)
> +{
> +	struct rq_wait *rqw;
> +	int inflight, limit;
> +
> +	if (!(wb_acct & WBT_TRACKED))
> +		return;
> +
> +	rqw = get_rq_wait(rwb, wb_acct & WBT_KSWAPD);
> +	inflight = atomic_dec_return(&rqw->inflight);
> +
> +	/*
> +	 * wbt got disabled with IO in flight. Wake up any potential
> +	 * waiters, we don't have to do more than that.
> +	 */
> +	if (unlikely(!rwb_enabled(rwb))) {
> +		rwb_wake_all(rwb);
> +		return;
> +	}
> +
> +	/*
> +	 * If the device does write back caching, drop further down
> +	 * before we wake people up.
> +	 */
> +	if (rwb->wc && !wb_recent_wait(rwb))
> +		limit = 0;
> +	else
> +		limit = rwb->wb_normal;

So for devices with write cache, you will completely drain the device
before waking anybody waiting to issue new requests. Isn't it too strict?
In particular may_queue() will allow new writers to issue new writes once
we drop below the limit so it can happen that some processes will be
effectively starved waiting in may_queue?

> +static void wb_timer_fn(unsigned long data)
> +{
> +	struct rq_wb *rwb = (struct rq_wb *) data;
> +	unsigned int inflight = wbt_inflight(rwb);
> +	int status;
> +
> +	status = latency_exceeded(rwb);
> +
> +	trace_wbt_timer(rwb->bdi, status, rwb->scale_step, inflight);
> +
> +	/*
> +	 * If we exceeded the latency target, step down. If we did not,
> +	 * step one level up. If we don't know enough to say either exceeded
> +	 * or ok, then don't do anything.
> +	 */
> +	switch (status) {
> +	case LAT_EXCEEDED:
> +		scale_down(rwb, true);
> +		break;
> +	case LAT_OK:
> +		scale_up(rwb);
> +		break;
> +	case LAT_UNKNOWN_WRITES:
> +		scale_up(rwb);
> +		break;
> +	case LAT_UNKNOWN:
> +		if (++rwb->unknown_cnt < RWB_UNKNOWN_BUMP)
> +			break;
> +		/*
> +		 * We get here for two reasons:
> +		 *
> +		 * 1) We previously scaled reduced depth, and we currently
> +		 *    don't have a valid read/write sample. For that case,
> +		 *    slowly return to center state (step == 0).
> +		 * 2) We started a the center step, but don't have a valid
> +		 *    read/write sample, but we do have writes going on.
> +		 *    Allow step to go negative, to increase write perf.
> +		 */

I think part 2) of the comment now belongs to LAT_UNKNOWN_WRITES label.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
