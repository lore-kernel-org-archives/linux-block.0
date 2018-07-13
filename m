Return-Path: <mwilck@suse.com>
Message-ID: <140560b16e2982104c306c0943a57909f4748730.camel@suse.com>
Subject: Re: Silent data corruption in blkdev_direct_IO()
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>
Date: Fri, 13 Jul 2018 08:47:29 +0200
In-Reply-To: <a0b0e59b-60cd-9933-6752-4c21a7a975fe@kernel.dk>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
	 <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
	 <a1679897-ed41-1ceb-f94f-bd1be537ce4e@suse.de>
	 <57a2b121-9805-8337-fb97-67943670f250@kernel.dk>
	 <a0b0e59b-60cd-9933-6752-4c21a7a975fe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-12 at 10:42 -0600, Jens Axboe wrote:
> On 7/12/18 10:20 AM, Jens Axboe wrote:
> > On 7/12/18 10:14 AM, Hannes Reinecke wrote:
> > > On 07/12/2018 05:08 PM, Jens Axboe wrote:
> > > > On 7/12/18 8:36 AM, Hannes Reinecke wrote:
> > > > > Hi Jens, Christoph,
> > > > > 
> > > > > we're currently hunting down a silent data corruption
> > > > > occurring due to
> > > > > commit 72ecad22d9f1 ("block: support a full bio worth of IO
> > > > > for
> > > > > simplified bdev direct-io").
> > > > > 
> > > > > While the whole thing is still hazy on the details, the one
> > > > > thing we've
> > > > > found is that reverting that patch fixes the data corruption.
> > > > > 
> > > > > And looking closer, I've found this:
> > > > > 
> > > > > static ssize_t
> > > > > blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> > > > > {
> > > > > 	int nr_pages;
> > > > > 
> > > > > 	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
> > > > > 	if (!nr_pages)
> > > > > 		return 0;
> > > > > 	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
> > > > > 		return __blkdev_direct_IO_simple(iocb, iter,
> > > > > nr_pages);
> > > > > 
> > > > > 	return __blkdev_direct_IO(iocb, iter, min(nr_pages,
> > > > > BIO_MAX_PAGES));
> > > > > }
> > > > > 
> > > > > When checking the call path
> > > > > __blkdev_direct_IO()->bio_alloc_bioset()->bvec_alloc()
> > > > > I found that bvec_alloc() will fail if nr_pages >
> > > > > BIO_MAX_PAGES.
> > > > > 
> > > > > So why is there the check for 'nr_pages <= BIO_MAX_PAGES' ?
> > > > > It's not that we can handle it in __blkdev_direct_IO() ...
> > > > 
> > > > The logic could be cleaned up like below, the sync part is
> > > > really all
> > > > we care about. What is the test case for this? async or sync?
> > > > 
> > > > I also don't remember why it's BIO_MAX_PAGES + 1...
> > > > 
> > > > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > > > index 0dd87aaeb39a..14ef3d71b55f 100644
> > > > --- a/fs/block_dev.c
> > > > +++ b/fs/block_dev.c
> > > > @@ -424,13 +424,13 @@ blkdev_direct_IO(struct kiocb *iocb,
> > > > struct iov_iter *iter)
> > > >   {
> > > >   	int nr_pages;
> > > >   
> > > > -	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
> > > > +	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
> > > >   	if (!nr_pages)
> > > >   		return 0;
> > > > -	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
> > > > +	if (is_sync_kiocb(iocb))
> > > >   		return __blkdev_direct_IO_simple(iocb, iter,
> > > > nr_pages);
> > > >   
> > > > -	return __blkdev_direct_IO(iocb, iter, min(nr_pages,
> > > > BIO_MAX_PAGES));
> > > > +	return __blkdev_direct_IO(iocb, iter, nr_pages);
> > > >   }
> > > >   
> > > >   static __init int blkdev_init(void)
> > > > 
> > > 
> > > Hmm. We'll give it a go, but somehow I feel this won't solve our
> > > problem.
> > 
> > It probably won't, the only joker here is the BIO_MAX_PAGES + 1.
> > But it
> > does simplify that part...
> 
> OK, now I remember. The +1 is just to check if there are actually
> more
> pages. __blkdev_direct_IO_simple() only does one bio, so it has to
> fit
> within that one bio. __blkdev_direct_IO() will loop just fine and
> will finish any size, BIO_MAX_PAGES at the time.

Right. Hannes, I think we (at least myself) have been irritated by
looking at outdated code. The key point which I missed is that
__blkdev_direct_IO() is called with min(nr_pages, BIO_MAX_PAGES), and
advances beyond that later in the loop.

> Hence the patch I sent is wrong, the code actually looks fine. Which
> means we're back to trying to figure out what is going on here. It'd
> be great with a test case...

Unfortunately we have no reproducer just yet. Only the customer can
reproduce it. The scenario is a data base running on a KVM virtual
machine on top of a virtio-scsi volume backed by a multipath map, with
cache='none' in qemu.

My late thinking is that if, for whatever reason I don't yet
understand, blkdev_direct_IO() resulted in a short write,
__generic_file_write_iter() would fall back to buffered writing, which
might be a possible explanation for the data corruption we observe.
That's just speculation at the current stage.

Regards
Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
