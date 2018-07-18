Return-Path: <mwilck@suse.com>
Message-ID: <54436062eee1e10644b536ae3c8c40f94da3ccbd.camel@suse.com>
Subject: Re: Silent data corruption in blkdev_direct_IO()
From: Martin Wilck <mwilck@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, Hannes
 Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, jack@suse.com,
 kent.overstreet@gmail.com
Date: Wed, 18 Jul 2018 09:32:12 +0200
In-Reply-To: <20180718024758.GB11151@ming.t460p>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
	 <CACVXFVPVb_8pUkGXPt5joDE4JRu0b4kgTQy7Pd0sL+kXDwys+A@mail.gmail.com>
	 <c5073ab4-6b06-16bd-f358-d4c18e18b3e0@kernel.dk>
	 <f6f3f16b66622a9b16acd0d8be7ef311e4da807a.camel@suse.com>
	 <CACVXFVPV1ckFvvh3m61QSPCtEY19ussRsMtKoptUbY3LLHKz8A@mail.gmail.com>
	 <ff0fc8c44f205453a203e88676942507339f6829.camel@suse.com>
	 <20180718024758.GB11151@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-07-18 at 10:48 +0800, Ming Lei wrote:
> On Wed, Jul 18, 2018 at 02:07:28AM +0200, Martin Wilck wrote:
> > 
> > From b75adc856119346e02126cf8975755300f2d9b7f Mon Sep 17 00:00:00
> > 2001
> > From: Martin Wilck <mwilck@suse.com>
> > Date: Wed, 18 Jul 2018 01:56:37 +0200
> > Subject: [PATCH] block: bio_iov_iter_get_pages: fix size of last
> > iovec
> > 
> > If the last page of the bio is not "full", the length of the last
> > vector bin needs to be corrected. This bin has the index
> > (bio->bi_vcnt - 1), but in bio->bi_io_vec, not in the "bv" helper
> > array which
> > is shifted by the value of bio->bi_vcnt at function invocation.
> > 
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> >  block/bio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 53e0f0a..c22e76f 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -913,7 +913,7 @@ int bio_iov_iter_get_pages(struct bio *bio,
> > struct iov_iter *iter)
> >  	bv[0].bv_offset += offset;
> >  	bv[0].bv_len -= offset;
> >  	if (diff)
> > -		bv[bio->bi_vcnt - 1].bv_len -= diff;
> > +		bio->bi_io_vec[bio->bi_vcnt - 1].bv_len -= diff;
> >  
> >  	iov_iter_advance(iter, size);
> >  	return 0;
> 
> Right, that is the issue, we need this fix for -stable, but maybe the
> following fix is more readable:
> 
> diff --git a/block/bio.c b/block/bio.c
> index f3536bfc8298..6e37b803755b 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -914,16 +914,16 @@ EXPORT_SYMBOL(bio_add_page);
>   */
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
> -	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> +	unsigned short idx, nr_pages = bio->bi_max_vecs - bio-
> >bi_vcnt;
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
> -	size_t offset, diff;
> +	size_t offset;
>  	ssize_t size;
>  
>  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages,
> &offset);
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
> -	nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
> +	idx = nr_pages = (size + offset + PAGE_SIZE - 1) /
> PAGE_SIZE;
>  
>  	/*
>  	 * Deep magic below:  We need to walk the pinned pages
> backwards
> @@ -936,17 +936,15 @@ int bio_iov_iter_get_pages(struct bio *bio,
> struct iov_iter *iter)
>  	bio->bi_iter.bi_size += size;
>  	bio->bi_vcnt += nr_pages;
>  
> -	diff = (nr_pages * PAGE_SIZE - offset) - size;
> -	while (nr_pages--) {
> -		bv[nr_pages].bv_page = pages[nr_pages];
> -		bv[nr_pages].bv_len = PAGE_SIZE;
> -		bv[nr_pages].bv_offset = 0;
> +	while (idx--) {
> +		bv[idx].bv_page = pages[idx];
> +		bv[idx].bv_len = PAGE_SIZE;
> +		bv[idx].bv_offset = 0;
>  	}
>  
>  	bv[0].bv_offset += offset;
>  	bv[0].bv_len -= offset;
> -	if (diff)
> -		bv[bio->bi_vcnt - 1].bv_len -= diff;
> +	bv[nr_pages - 1].bv_len -= (nr_pages * PAGE_SIZE - offset) -
> size;
>  
>  	iov_iter_advance(iter, size);
>  	return 0;
> 
> And for mainline, I suggest to make Christoph's new code in, that is
> easy to prove its correctness, and seems simpler.

Fine with me. Will you take care of a submission, or should I?
Btw, this is not the full fix for our data corruption issue yet.
Another patch is needed which still needs testing.

Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
