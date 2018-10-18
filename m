Return-Path: <hch@lst.de>
Date: Thu, 18 Oct 2018 17:22:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 4/5] block: introduce helpers for allocating IO buffers
 from slab
Message-ID: <20181018152219.GB28300@lst.de>
References: <20181018131817.11813-1-ming.lei@redhat.com> <20181018131817.11813-5-ming.lei@redhat.com> <20181018144207.GD26828@lst.de> <20181018151123.GD32429@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018151123.GD32429@bombadil.infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 08:11:23AM -0700, Matthew Wilcox wrote:
> On Thu, Oct 18, 2018 at 04:42:07PM +0200, Christoph Hellwig wrote:
> > This all seems quite complicated.
> > 
> > I think the interface we'd want is more one that has a little
> > cache of a single page in the queue, and a little bitmap which
> > sub-page size blocks of it are used.
> > 
> > Something like (pseudo code minus locking):
> > 
> > void *blk_alloc_sector_buffer(struct block_device *bdev, gfp_t gfp)
> > {
> > 	unsigned block_size = block_size(bdev);
> > 
> > 	if (blocksize >= PAGE_SIZE)
> > 		return (void *)__get_free_pages(gfp, get_order(blocksize));
> > 
> > 	if (bdev->fragment_cache_page) {
> > 		[ <find fragment in bdev->fragment_cache_page using
> > 		  e.g. bitmap and return if found]
> > 	}
> > 
> > 	bdev->fragment_cache_page = (void *)__get_free_page(gfp);
> > 	goto find_again;
> > }
> 
> This looks a lot like page_frag_alloc() except I think page_frag_alloc()
> may be more efficient.

Oh, nice. Sounds like XFS should just use page_frag_alloc.  I'll give
it a spin.
