Return-Path: <david@fromorbit.com>
Date: Fri, 19 Oct 2018 16:43:19 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	linux-xfs@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 4/5] block: introduce helpers for allocating IO buffers
 from slab
Message-ID: <20181019054319.GL6311@dastard>
References: <20181018131817.11813-1-ming.lei@redhat.com>
 <20181018131817.11813-5-ming.lei@redhat.com>
 <20181018144207.GD26828@lst.de>
 <20181018151123.GD32429@bombadil.infradead.org>
 <20181018152219.GB28300@lst.de>
 <20181019025348.GB14531@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181019025348.GB14531@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 19, 2018 at 10:53:49AM +0800, Ming Lei wrote:
> On Thu, Oct 18, 2018 at 05:22:19PM +0200, Christoph Hellwig wrote:
> > On Thu, Oct 18, 2018 at 08:11:23AM -0700, Matthew Wilcox wrote:
> > > On Thu, Oct 18, 2018 at 04:42:07PM +0200, Christoph Hellwig wrote:
> > > > This all seems quite complicated.
> > > > 
> > > > I think the interface we'd want is more one that has a little
> > > > cache of a single page in the queue, and a little bitmap which
> > > > sub-page size blocks of it are used.
> > > > 
> > > > Something like (pseudo code minus locking):
> > > > 
> > > > void *blk_alloc_sector_buffer(struct block_device *bdev, gfp_t gfp)
> > > > {
> > > > 	unsigned block_size = block_size(bdev);
> > > > 
> > > > 	if (blocksize >= PAGE_SIZE)
> > > > 		return (void *)__get_free_pages(gfp, get_order(blocksize));
> > > > 
> > > > 	if (bdev->fragment_cache_page) {
> > > > 		[ <find fragment in bdev->fragment_cache_page using
> > > > 		  e.g. bitmap and return if found]
> > > > 	}
> > > > 
> > > > 	bdev->fragment_cache_page = (void *)__get_free_page(gfp);
> > > > 	goto find_again;
> > > > }
> > > 
> > > This looks a lot like page_frag_alloc() except I think page_frag_alloc()
> > > may be more efficient.
> > 
> > Oh, nice. Sounds like XFS should just use page_frag_alloc.  I'll give
> > it a spin.
> 
> XFS or other fs can use page_frag_alloc() directly, seems not necessary to
> introduce this change in block layer any more given 512-aligned buffer
> should be fine everywhere.
> 
> The only benefit to make it as block helper is that the offset or size
> can be checked with q->dma_alignment.
> 
> Dave/Jens, do you think which way is better? Put allocation as block
> helper or fs uses page_frag_alloc() directly for allocating 512*N-byte 
> buffer(total size is less than PAGE_SIZE)?

Cristoph has already said he's looking at using page_frag_alloc()
directly in XFS....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
