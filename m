Return-Path: <mwilck@suse.com>
Message-ID: <b4df5b894a41a977442a606e901a156d90a396cc.camel@suse.com>
Subject: Re: Silent data corruption in blkdev_direct_IO()
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>
Date: Thu, 12 Jul 2018 18:11:56 +0200
In-Reply-To: <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
	 <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-12 at 09:08 -0600, Jens Axboe wrote:
> On 7/12/18 8:36 AM, Hannes Reinecke wrote:
> > Hi Jens, Christoph,
> > 
> > we're currently hunting down a silent data corruption occurring due
> > to
> > commit 72ecad22d9f1 ("block: support a full bio worth of IO for
> > simplified bdev direct-io").
> > 
> > While the whole thing is still hazy on the details, the one thing
> > we've
> > found is that reverting that patch fixes the data corruption.
> > 
> > And looking closer, I've found this:
> > 
> > static ssize_t
> > blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> > {
> > 	int nr_pages;
> > 
> > 	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
> > 	if (!nr_pages)
> > 		return 0;
> > 	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
> > 		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
> > 
> > 	return __blkdev_direct_IO(iocb, iter, min(nr_pages,
> > BIO_MAX_PAGES));
> > }
> > 
> > When checking the call path
> > __blkdev_direct_IO()->bio_alloc_bioset()->bvec_alloc()
> > I found that bvec_alloc() will fail if nr_pages > BIO_MAX_PAGES.
> > 
> > So why is there the check for 'nr_pages <= BIO_MAX_PAGES' ?
> > It's not that we can handle it in __blkdev_direct_IO() ...
> 
> The logic could be cleaned up like below, the sync part is really all
> we care about. What is the test case for this? async or sync?

It's sync, and the corruption is in the __blkdev_direct_IO_simple()
path. It starts to occur with your "block: support a full bio worth of
IO for simplified bdev direct-io" patch, which causes the "simple" path
to be taken for larger IO sizes.

Martin



> 
> I also don't remember why it's BIO_MAX_PAGES + 1...
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 0dd87aaeb39a..14ef3d71b55f 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -424,13 +424,13 @@ blkdev_direct_IO(struct kiocb *iocb, struct
> iov_iter *iter)
>  {
>  	int nr_pages;
>  
> -	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
> +	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
>  	if (!nr_pages)
>  		return 0;
> -	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
> +	if (is_sync_kiocb(iocb))
>  		return __blkdev_direct_IO_simple(iocb, iter,
> nr_pages);
>  
> -	return __blkdev_direct_IO(iocb, iter, min(nr_pages,
> BIO_MAX_PAGES));
> +	return __blkdev_direct_IO(iocb, iter, nr_pages);
>  }
>  
>  static __init int blkdev_init(void)
> 

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
