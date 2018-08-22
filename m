Return-Path: <mwilck@suse.com>
Message-ID: <2e2a6a0854156a33b1866c02f2ac5c455216efac.camel@suse.com>
Subject: Re: [PATCH v5 3/3] block: bio_iov_iter_get_pages: pin more pages
 for multi-segment IOs
From: Martin Wilck <mwilck@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, Johannes Thumshirn
 <jthumshirn@suse.de>, Kent Overstreet <kent.overstreet@gmail.com>,
 linux-block@vger.kernel.org
Date: Wed, 22 Aug 2018 10:02:49 +0200
In-Reply-To: <20180730123715.GC6972@ming.t460p>
References: <20180725211509.13592-1-mwilck@suse.com>
	 <20180725211509.13592-4-mwilck@suse.com> <20180730123715.GC6972@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-30 at 20:37 +0800, Ming Lei wrote:
> On Wed, Jul 25, 2018 at 11:15:09PM +0200, Martin Wilck wrote:
> > 
> > +/**
> > + * bio_iov_iter_get_pages - pin user or kernel pages and add them
> > to a bio
> > + * @bio: bio to add pages to
> > + * @iter: iov iterator describing the region to be mapped
> > + *
> > + * Pins pages from *iter and appends them to @bio's bvec array.
> > The
> > + * pages will have to be released using put_page() when done.
> > + * The function tries, but does not guarantee, to pin as many
> > pages as
> > + * fit into the bio, or are requested in *iter, whatever is
> > smaller.
> > + * If MM encounters an error pinning the requested pages, it
> > stops.
> > + * Error is returned only if 0 pages could be pinned.
> > + */
> > +int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> > +{
> > +	unsigned short orig_vcnt = bio->bi_vcnt;
> > +
> > +	do {
> > +		int ret = __bio_iov_iter_get_pages(bio, iter);
> > +
> > +		if (unlikely(ret))
> > +			return bio->bi_vcnt > orig_vcnt ? 0 : ret;
> > +
> > +	} while (iov_iter_count(iter) && !bio_full(bio));
> 
> When 'ret' isn't zero, and some partial progress has been made, seems
> less pages
> might be obtained than requested too. Is that something we need to
> worry about?

This would be the case when VM isn't willing or able to fulfill the
page-pinning request. Previously, we came to the conclusion that VM has
the right to do so. This is the reason why callers have to check the
number of pages allocated, and either loop over
bio_iov_iter_get_pages(), or fall back to buffered I/O, until all pages
have been obtained. All callers except the blockdev fast path do the
former. 

We could add looping in __blkdev_direct_IO_simple() on top of the
current patch set, to avoid fallback to buffered IO in this corner
case. Should we? If yes, only for WRITEs, or for READs as well?

I haven't encountered this situation in my tests, and I'm unsure how to
provoke it - run a direct IO test under high memory pressure?

Regards,
Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
