Return-Path: <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Subject: Silent data corruption in blkdev_direct_IO()
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Martin Wilck <mwilck@suse.com>
Message-ID: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
Date: Thu, 12 Jul 2018 16:36:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens, Christoph,

we're currently hunting down a silent data corruption occurring due to
commit 72ecad22d9f1 ("block: support a full bio worth of IO for
simplified bdev direct-io").

While the whole thing is still hazy on the details, the one thing we've
found is that reverting that patch fixes the data corruption.

And looking closer, I've found this:

static ssize_t
blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
{
	int nr_pages;

	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
	if (!nr_pages)
		return 0;
	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);

	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
}

When checking the call path
__blkdev_direct_IO()->bio_alloc_bioset()->bvec_alloc()
I found that bvec_alloc() will fail if nr_pages > BIO_MAX_PAGES.

So why is there the check for 'nr_pages <= BIO_MAX_PAGES' ?
It's not that we can handle it in __blkdev_direct_IO() ...

Thanks for any clarification.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
