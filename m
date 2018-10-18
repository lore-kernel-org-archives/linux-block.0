Return-Path: <hch@lst.de>
Date: Thu, 18 Oct 2018 16:42:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 4/5] block: introduce helpers for allocating IO buffers
 from slab
Message-ID: <20181018144207.GD26828@lst.de>
References: <20181018131817.11813-1-ming.lei@redhat.com> <20181018131817.11813-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018131817.11813-5-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This all seems quite complicated.

I think the interface we'd want is more one that has a little
cache of a single page in the queue, and a little bitmap which
sub-page size blocks of it are used.

Something like (pseudo code minus locking):

void *blk_alloc_sector_buffer(struct block_device *bdev, gfp_t gfp)
{
	unsigned block_size = block_size(bdev);

	if (blocksize >= PAGE_SIZE)
		return (void *)__get_free_pages(gfp, get_order(blocksize));

	if (bdev->fragment_cache_page) {
		[ <find fragment in bdev->fragment_cache_page using
		  e.g. bitmap and return if found]
	}

	bdev->fragment_cache_page = (void *)__get_free_page(gfp);
	goto find_again;
}

note that the locking also is important, preferably we'd be able to do
something lockless.
