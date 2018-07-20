Return-Path: <ming.lei@redhat.com>
Date: Sat, 21 Jul 2018 07:48:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v4 3/4] block: add bio_iov_iter_get_all_pages() helper
Message-ID: <20180720234822.GA9105@ming.t460p>
References: <20180720130552.21432-1-mwilck@suse.com>
 <20180720130552.21432-4-mwilck@suse.com>
 <20180720161656.GC7438@ming.t460p>
 <0966ba4de782bf6e1af19311f0aa67f0e29fa43b.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0966ba4de782bf6e1af19311f0aa67f0e29fa43b.camel@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 20, 2018 at 06:54:48PM +0200, Martin Wilck wrote:
> On Sat, 2018-07-21 at 00:16 +0800, Ming Lei wrote:
> > On Fri, Jul 20, 2018 at 03:05:51PM +0200, Martin Wilck wrote:
> > > bio_iov_iter_get_pages() only adds pages for the next non-zero
> > > segment from the iov_iter to the bio. Some callers prefer to
> > > obtain as many pages as would fit into the bio, with proper
> > > rollback in case of failure. Add bio_iov_iter_get_all_pages()
> > > for this purpose.
> > > 
> > > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > > ---
> > >  block/bio.c         | 43
> > > ++++++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/bio.h |  1 +
> > >  2 files changed, 43 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/block/bio.c b/block/bio.c
> > > index 489a430..693eb3b 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -907,8 +907,10 @@ EXPORT_SYMBOL(bio_add_page);
> > >   * @bio: bio to add pages to
> > >   * @iter: iov iterator describing the region to be mapped
> > >   *
> > > - * Pins as many pages from *iter and appends them to @bio's bvec
> > > array. The
> > > + * Pins pages from *iter and appends them to @bio's bvec array.
> > > The
> > >   * pages will have to be released using put_page() when done.
> > > + * For multi-segment *iter, this function only adds pages from the
> > > + * the next non-empty segment of the iov iterator.
> > >   */
> > >  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> > >  {
> > > @@ -949,6 +951,45 @@ int bio_iov_iter_get_pages(struct bio *bio,
> > > struct iov_iter *iter)
> > >  }
> > >  EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
> > >  
> > > +/**
> > > + * bio_iov_iter_get_all_pages - pin user or kernel pages and add
> > > them to a bio
> > > + * @bio: bio to add pages to
> > > + * @iter: iov iterator describing the region to be mapped
> > > + *
> > > + * Pins pages from *iter and appends them to @bio's bvec array.
> > > The
> > > + * pages will have to be released using put_page() when done.
> > > + * This function adds as many pages as possible to a bio.
> > > + * If this function encounters an error, it unpins the pages it
> > > has
> > > + * pinned before, leaving previously pinned pages untouched.
> > > + */
> > > +int bio_iov_iter_get_all_pages(struct bio *bio, struct iov_iter
> > > *iter)
> > > +{
> > > +	unsigned short orig_vcnt = bio->bi_vcnt;
> > > +
> > > +	do {
> > > +		int ret = bio_iov_iter_get_pages(bio, iter);
> > > +
> > > +		if (unlikely(ret)) {
> > > +			struct bio_vec *bvec;
> > > +			unsigned short i;
> > > +
> > > +			bio_for_each_segment_all(bvec, bio, i) {
> > > +				if (i >= orig_vcnt) {
> > > +					put_page(bvec->bv_page);
> > > +					bvec->bv_page = NULL;
> > > +					bvec->bv_len = 0;
> > > +					bvec->bv_offset = 0;
> > > +				}
> > > +			}
> > > +			bio->bi_vcnt = orig_vcnt;
> > > +			return ret;
> > > +		}
> > > +	} while (iov_iter_count(iter) && !bio_full(bio));
> > 
> > The failure handling part(release pages) may be moved out of this
> > helper, so usage of this helper can be aligned with
> > bio_iov_iter_get_pages().
> 
> I wrote the failure handling precisely for being compatible with
> bio_iov_iter_get_pages(), which requires no rollback if it returns an
> error. If we don't do this, we have to add extra error handling code to
> every caller. It was the issue you raised with my v3 submission...
> apparently I misunderstood you.
> 
> What should happen if the new handler encounters an error from
> bio_iov_iter_get_pages() in the 2nd or later iteration?
> 
>  1 return success, so that the caller doesn't realize there was a
> problem,
>  2 return error and roll back bio changes, as I implemented it here,
>  3 return error and keep the already allocated pages.
> 
> You seem to support option 3. But that leaves it to the caller to 
> differentiate this from a failure with zero allocated pages, and clean
> up appropriately. I not sure if that's wise, and it's for sure
> different from bio_iov_iter_get_pages()' behavior. Or what am I
> missing?
> > BTW, I agree with Christoph, we may just fix/improve
> > bio_iov_iter_get_pages()
> > for all users.
> 
> Ok, thanks for confirming.

OK, if you follow this suggestion, the pinned pages may be released
in bio_iov_iter_get_pages() like what this patch does, but the bio_endio(bio)
in failure handler of __blkdev_direct_IO() has to be handled in the
following way for avoiding double release:

1) if this bio is allocated from &blkdev_dio_pool, the bio_endio() need
to be removed

2) otherwise, the bio_endio() need to be replaced with bio_put().

Frankly speaking, after your patch is in, seems it is fine to allocate
single bio for doing the dio in __blkdev_direct_IO(), given the passed
'max_pages' is <= BIO_MAX_PAGES. Then __blkdev_direct_IO() can be
simplified much.

But, both current __blkdev_direct_IO() and iomap_dio_actor() supports
short dio, do you think there is same issue in the two with yours? Or
do we need to support it in the new bio_iov_iter_get_pages()?


Thanks,
Ming
