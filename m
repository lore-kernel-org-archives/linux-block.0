Return-Path: <bcache@lists.ewheeler.net>
Date: Thu, 18 Aug 2016 17:41:04 -0700 (PDT)
From: Eric Wheeler <bcache@lists.ewheeler.net>
To: Kent Overstreet <kent.overstreet@gmail.com>
cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@canonical.com>,
    Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org,
    Sebastian Roesner <sroesner-kernelorg@roesner-online.de>,
    "4.3+" <stable@vger.kernel.org>, Shaohua Li <shli@fb.com>,
    Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: make sure big bio is splitted into at most
 256 bvecs
In-Reply-To: <20160815191253.cxbjui3mymrkpkz6@kmo-pixel>
Message-ID: <alpine.LRH.2.11.1608181733110.10662@mail.ewheeler.net>
References: <1471273882-3938-1-git-send-email-ming.lei@canonical.com> <20160815182328.GA13886@infradead.org> <20160815191253.cxbjui3mymrkpkz6@kmo-pixel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

> On Mon, Aug 15, 2016 at 11:23:28AM -0700, Christoph Hellwig wrote:
> > On Mon, Aug 15, 2016 at 11:11:22PM +0800, Ming Lei wrote:
> > > After arbitrary bio size is supported, the incoming bio may
> > > be very big. We have to split the bio into small bios so that
> > > each holds at most BIO_MAX_PAGES bvecs for safety reason, such
> > > as bio_clone().
> > 
> > I still think working around a rough driver submitting too large
> > I/O is a bad thing until we've done a full audit of all consuming
> > bios through ->make_request, and we've enabled it for the common
> > path as well.
> 
> bcache originally had workaround code to split too-large bios when it 
> first went upstream - that was dropped only after the patches to make 
> generic_make_request() handle arbitrary size bios went in. So to do what 
> you're suggesting would mean reverting that bcache patch and bringing 
> that code back, which from my perspective would be a step in the wrong 
> direction. I just want to get this over and done with.
> 
> > 
> > >  	bool do_split = true;
> > >  	struct bio *new = NULL;
> > >  	const unsigned max_sectors = get_max_io_size(q, bio);
> > > +	unsigned bvecs = 0;
> > > +
> > > +	*no_merge = true;
> > >  
> > >  	bio_for_each_segment(bv, bio, iter) {
> > >  		/*
> > > +		 * With arbitrary bio size, the incoming bio may be very
> > > +		 * big. We have to split the bio into small bios so that
> > > +		 * each holds at most BIO_MAX_PAGES bvecs because
> > > +		 * bio_clone() can fail to allocate big bvecs.
> > > +		 *
> > > +		 * It should have been better to apply the limit per
> > > +		 * request queue in which bio_clone() is involved,
> > > +		 * instead of globally. The biggest blocker is
> > > +		 * bio_clone() in bio bounce.
> > > +		 *
> > > +		 * If bio is splitted by this reason, we should allow
> > > +		 * to continue bios merging.
> > > +		 *
> > > +		 * TODO: deal with bio bounce's bio_clone() gracefully
> > > +		 * and convert the global limit into per-queue limit.
> > > +		 */
> > > +		if (bvecs++ >= BIO_MAX_PAGES) {
> > > +			*no_merge = false;
> > > +			goto split;
> > > +		}
> > 
> > That being said this simple if check here is simple enough that it's
> > probably fine.  But I see no need to uglify the whole code path
> > with that no_merge flag.  Please drop if for now, and if we start
> > caring for this path in common code we should just move the
> > REQ_NOMERGE setting into the actual blk_bio_*_split helpers.
> 
> Agreed about the no_merge thing.

By removing `no_merge` this patch should cherry-peck into stable v4.3+ 
without merge issues by avoiding bi_rw refactor interference, too.

Ming, can you send out a V4 without `no_merge` ?

--
Eric Wheeler
