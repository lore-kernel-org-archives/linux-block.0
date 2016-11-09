Return-Path: <jack@suse.cz>
Date: Wed, 9 Nov 2016 09:40:34 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	hch@lst.de
Subject: Re: [PATCH 7/8] blk-wbt: add general throttling mechanism
Message-ID: <20161109084034.GY32353@quack2.suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-8-git-send-email-axboe@fb.com>
 <20161108133930.GQ32353@quack2.suse.cz>
 <20161108154109.GA2834@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161108154109.GA2834@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue 08-11-16 08:41:09, Jens Axboe wrote:
> On Tue, Nov 08 2016, Jan Kara wrote:
> > On Tue 01-11-16 15:08:50, Jens Axboe wrote:
> > > We can hook this up to the block layer, to help throttle buffered
> > > writes.
> > > 
> > > wbt registers a few trace points that can be used to track what is
> > > happening in the system:
> > > 
> > > wbt_lat: 259:0: latency 2446318
> > > wbt_stat: 259:0: rmean=2446318, rmin=2446318, rmax=2446318, rsamples=1,
> > >                wmean=518866, wmin=15522, wmax=5330353, wsamples=57
> > > wbt_step: 259:0: step down: step=1, window=72727272, background=8, normal=16, max=32
> > > 
> > > This shows a sync issue event (wbt_lat) that exceeded it's time. wbt_stat
> > > dumps the current read/write stats for that window, and wbt_step shows a
> > > step down event where we now scale back writes. Each trace includes the
> > > device, 259:0 in this case.
> > 
> > Just one serious question and one nit below:
> > 
> > > +void __wbt_done(struct rq_wb *rwb, enum wbt_flags wb_acct)
> > > +{
> > > +	struct rq_wait *rqw;
> > > +	int inflight, limit;
> > > +
> > > +	if (!(wb_acct & WBT_TRACKED))
> > > +		return;
> > > +
> > > +	rqw = get_rq_wait(rwb, wb_acct & WBT_KSWAPD);
> > > +	inflight = atomic_dec_return(&rqw->inflight);
> > > +
> > > +	/*
> > > +	 * wbt got disabled with IO in flight. Wake up any potential
> > > +	 * waiters, we don't have to do more than that.
> > > +	 */
> > > +	if (unlikely(!rwb_enabled(rwb))) {
> > > +		rwb_wake_all(rwb);
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * If the device does write back caching, drop further down
> > > +	 * before we wake people up.
> > > +	 */
> > > +	if (rwb->wc && !wb_recent_wait(rwb))
> > > +		limit = 0;
> > > +	else
> > > +		limit = rwb->wb_normal;
> > 
> > So for devices with write cache, you will completely drain the device
> > before waking anybody waiting to issue new requests. Isn't it too strict?
> > In particular may_queue() will allow new writers to issue new writes once
> > we drop below the limit so it can happen that some processes will be
> > effectively starved waiting in may_queue?
> 
> It is strict, and perhaps too strict. In testing, it's the only method
> that's proven to keep the writeback caching devices in check. It will
> round robin the writers, if we have more, which isn't necessarily a bad
> thing. Each will get to do a burst of depth writes, then wait for a new
> one.

Well, I'm more concerned about a situation where one writer does a bursty
write and blocks sleeping in may_queue(). Another writer produces a steady
flow of write requests so that never causes the write queue to completely
drain but that writer also never blocks in may_queue() when it starts
queueing after write queue has somewhat drained because it never submits
many requests in parallel. In such case the first writer would get starved
AFAIU.

Also I'm not sure why such logic for devices with writeback cache is
needed. Sure the disk is fast to accept writes but if that causes long read
latencies, we should scale down the writeback limits so that we eventually
end up submitting only one write request anyway - effectively the same
thing as limit=0 - won't we?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
