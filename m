Return-Path: <jack@suse.cz>
Date: Thu, 9 Mar 2017 10:10:15 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Omar Sandoval <osandov@osandov.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] block: Allow bdi re-registration
Message-ID: <20170309091015.GE15874@quack2.suse.cz>
References: <20170308164834.14302-1-jack@suse.cz>
 <20170308164834.14302-2-jack@suse.cz>
 <20170308225542.GB21117@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170308225542.GB21117@htj.duckdns.org>
List-ID: <linux-block@vger.kernel.org>

On Wed 08-03-17 17:55:42, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 08, 2017 at 05:48:31PM +0100, Jan Kara wrote:
> > @@ -710,6 +710,11 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
> >  	 */
> >  	atomic_dec(&bdi->usage_cnt);
> >  	wait_event(cgwb_release_wait, !atomic_read(&bdi->usage_cnt));
> > +	/*
> > +	 * Grab back our reference so that we hold it when @bdi gets
> > +	 * re-registered.
> > +	 */
> > +	atomic_inc(&bdi->usage_cnt);
> 
> So, this is more re-initializing the ref to the initial state so that
> it can be re-used, right?  Maybe ATOMIC_INIT() is a better choice here
> just to clarify what's going on?

OK, I was somewhat undecided between these two option but you and James are
probably right that re-init is clearer.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
