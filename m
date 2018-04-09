Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 19:20:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, Bart.VanAssche@wdc.com,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/7] block: consistently use GFP_NOIO instead of
	__GFP_NORECLAIM
Message-ID: <20180409172054.GA5697@lst.de>
References: <20180409153916.23901-1-hch@lst.de> <20180409153916.23901-7-hch@lst.de> <20180409160354.GD11756@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409160354.GD11756@bombadil.infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 09, 2018 at 09:03:54AM -0700, Matthew Wilcox wrote:
> > @@ -499,7 +499,7 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
> >  		break;
> >  	}
> >  
> > -	if (bytes && blk_rq_map_kern(q, rq, buffer, bytes, __GFP_RECLAIM)) {
> > +	if (bytes && blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO)) {
> 
> We don't seem to have grabbed any locks between the line which allocates
> memory using GFP_USER (line 446) and here, so I don't see why we should
> prohibit I/O?

No change of behavior for this patch.  If you care deeply about using
GFP_KERNEL here send an incremental patch that I can add to the end of
the series.
