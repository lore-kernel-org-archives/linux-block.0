Return-Path: <viro@ftp.linux.org.uk>
Date: Sun, 24 Sep 2017 15:27:39 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: Re: [PATCH] fix unbalanced page refcounting in bio_map_user_iov
Message-ID: <20170924142739.GS32076@ZenIV.linux.org.uk>
References: <87bmm3xqds.wl-v.mayatskih@gmail.com>
 <20170923163928.GO32076@ZenIV.linux.org.uk>
 <20170923165537.GP32076@ZenIV.linux.org.uk>
 <20170923171925.GQ32076@ZenIV.linux.org.uk>
 <20170923203323.GR32076@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170923203323.GR32076@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 23, 2017 at 09:33:23PM +0100, Al Viro wrote:
> On Sat, Sep 23, 2017 at 06:19:26PM +0100, Al Viro wrote:
> > On Sat, Sep 23, 2017 at 05:55:37PM +0100, Al Viro wrote:
> > 
> > > IOW, the loop on failure exit should go through the bio, like __bio_unmap_user()
> > > does.  We *also* need to put everything left unused in pages[], but only from the
> > > last iteration through iov_for_each().
> > > 
> > > Frankly, I would prefer to reuse the pages[], rather than append to it on each
> > > iteration.  Used iov_iter_get_pages_alloc(), actually.
> > 
> > Something like completely untested diff below, perhaps...
> 
> > +				unsigned n = PAGE_SIZE - offs;
> > +				unsigned prev_bi_vcnt = bio->bi_vcnt;
> 
> Sorry, that should've been followed by
> 				if (n > bytes)
> 					n = bytes;
> 
> Anyway, a carved-up variant is in vfs.git#work.iov_iter.  It still needs
> review and testing; the patch Vitaly has posted in this thread plus 6
> followups, hopefully more readable than aggregate diff.
> 
> Comments?

BTW, there's something fishy in bio_copy_user_iov().  If the area we'd asked for
had been too large for a single bio, we are going to create a bio and have
 bio_add_pc_page() eventually fill it up to limit.  Then we return into
__blk_rq_map_user_iov(), advance iter and call bio_copy_user_iov() again.
Fine, but... now we might have non-zero iter->iov_offset.  And this
        bmd->is_our_pages = map_data ? 0 : 1;
        memcpy(bmd->iov, iter->iov, sizeof(struct iovec) * iter->nr_segs);
        iov_iter_init(&bmd->iter, iter->type, bmd->iov,
                        iter->nr_segs, iter->count);
does not even look at iter->iov_offset.  As the result, when it gets to
bio_uncopy_user(), we copy the data from each bio into the *beginning* of
the user area, overwriting that from the other bio.

At the very least, we need bmd->iter = *iter; bmd->iter.iov = bmd->iov;
instead of that iov_iter_init() in there.  I'm not sure how far back does
it go; looks like "block: support large requests in blk_rq_map_user_iov"
is the earliest possible point, but it might need more digging to make
sure.  v4.5+, if that's when the problems began...

Anyway, I'd added the obvious fix to #work.iov_iter, reordered it and
force-pushed the result.
