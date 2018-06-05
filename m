Return-Path: <ming.lei@redhat.com>
Date: Tue, 5 Jun 2018 11:42:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: use bio_add_page in bio_iov_iter_get_pages
Message-ID: <20180605034234.GG28826@ming.t460p>
References: <20180604135853.30972-1-hch@lst.de>
 <20180604135853.30972-4-hch@lst.de>
 <20180605034117.GF28826@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180605034117.GF28826@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 05, 2018 at 11:41:19AM +0800, Ming Lei wrote:
> On Mon, Jun 04, 2018 at 03:58:53PM +0200, Christoph Hellwig wrote:
> > Replace a nasty hack with a different nasty hack to prepare for multipage
> > bio_vecs.  By moving the temporary page array as far up as possible in
> > the space allocated for the bio_vec array we can iterate forward over it
> > and thus use bio_add_page.  Using bio_add_page means we'll be able to
> > merge physically contiguous pages once support for multipath bio_vecs is
> > merged.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/bio.c | 45 +++++++++++++++++++++------------------------
> >  1 file changed, 21 insertions(+), 24 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index d95fab72acb5..b09c133a1e24 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -871,6 +871,8 @@ int bio_add_page(struct bio *bio, struct page *page,
> >  }
> >  EXPORT_SYMBOL(bio_add_page);
> >  
> > +#define PAGE_PTRS_PER_BVEC	(sizeof(struct bio_vec) / sizeof(struct page *))
> > +
> >  /**
> >   * bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
> >   * @bio: bio to add pages to
> > @@ -882,38 +884,33 @@ EXPORT_SYMBOL(bio_add_page);
> >  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  {
> >  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> > +	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> >  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> >  	struct page **pages = (struct page **)bv;
> > -	size_t offset, diff;
> > -	ssize_t size;
> > +	ssize_t size, left;
> > +	unsigned len, i;
> > +	size_t offset;
> > +
> > +	/*
> > +	 * Move page array up in the allocated memory for the bio vecs as
> > +	 * far as possible so that we can start filling biovecs from the
> > +	 * beginning without overwriting the temporary page array.
> > +	 */
> > +	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
> > +	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> >  
> >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> >  	if (unlikely(size <= 0))
> >  		return size ? size : -EFAULT;
> > -	nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
> >  
> > -	/*
> > -	 * Deep magic below:  We need to walk the pinned pages backwards
> > -	 * because we are abusing the space allocated for the bio_vecs
> > -	 * for the page array.  Because the bio_vecs are larger than the
> > -	 * page pointers by definition this will always work.  But it also
> > -	 * means we can't use bio_add_page, so any changes to it's semantics
> > -	 * need to be reflected here as well.
> > -	 */
> > -	bio->bi_iter.bi_size += size;
> > -	bio->bi_vcnt += nr_pages;
> > -
> > -	diff = (nr_pages * PAGE_SIZE - offset) - size;
> > -	while (nr_pages--) {
> > -		bv[nr_pages].bv_page = pages[nr_pages];
> > -		bv[nr_pages].bv_len = PAGE_SIZE;
> > -		bv[nr_pages].bv_offset = 0;
> > -	}
> > +	for (left = size, i = 0; left > 0; left -= len, i++) {
> > +		struct page *page = pages[i];
> >  
> > -	bv[0].bv_offset += offset;
> > -	bv[0].bv_len -= offset;
> > -	if (diff)
> > -		bv[bio->bi_vcnt - 1].bv_len -= diff;
> > +		len = min_t(size_t, PAGE_SIZE - offset, left);
> > +		if (WARN_ON_ONCE(bio_add_page(bio, page, len, offset) != len))
> > +			return -EINVAL;
> > +		offset = 0;
> > +	}
> 
> One invariant is that the page index 'i' is always <= bvec index

oops, the above "<=" should have been ">=".

Thanks,
Ming
