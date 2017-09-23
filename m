Return-Path: <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2017 17:55:37 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fix unbalanced page refcounting in bio_map_user_iov
Message-ID: <20170923165537.GP32076@ZenIV.linux.org.uk>
References: <87bmm3xqds.wl-v.mayatskih@gmail.com>
 <20170923163928.GO32076@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170923163928.GO32076@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 23, 2017 at 05:39:28PM +0100, Al Viro wrote:
> On Fri, Sep 22, 2017 at 01:18:39AM -0400, Vitaly Mayatskikh wrote:
> > bio_map_user_iov and bio_unmap_user do unbalanced pages refcounting if
> > IO vector has small consecutive buffers belonging to the same page.
> > bio_add_pc_page merges them into one, but the page reference is never
> > dropped.
> > 
> > Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index b38e962fa83e..10cd3b6bed27 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1383,6 +1383,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
> >  		offset = offset_in_page(uaddr);
> >  		for (j = cur_page; j < page_limit; j++) {
> >  			unsigned int bytes = PAGE_SIZE - offset;
> > +			unsigned short prev_bi_vcnt = bio->bi_vcnt;
> >  
> >  			if (len <= 0)
> >  				break;
> > @@ -1397,6 +1398,13 @@ struct bio *bio_map_user_iov(struct request_queue *q,
> >  					    bytes)
> >  				break;
> >  
> > +			/*
> > +			 * check if vector was merged with previous
> > +			 * drop page reference if needed
> > +			 */
> > +			if (bio->bi_vcnt == prev_bi_vcnt)
> > +				put_page(pages[j]);
> > +
> 
> Except that now you've got double-puts on failure exits ;-/

IOW, the loop on failure exit should go through the bio, like __bio_unmap_user()
does.  We *also* need to put everything left unused in pages[], but only from the
last iteration through iov_for_each().

Frankly, I would prefer to reuse the pages[], rather than append to it on each
iteration.  Used iov_iter_get_pages_alloc(), actually.
