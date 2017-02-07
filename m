Return-Path: <hch@lst.de>
Date: Tue, 7 Feb 2017 20:34:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: support ranged discard requests
Message-ID: <20170207193439.GA26834@lst.de>
References: <20170207164658.32449-1-hch@lst.de> <20170207164658.32449-5-hch@lst.de> <20170207183453.GC10133@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170207183453.GC10133@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 07, 2017 at 01:34:54PM -0500, Keith Busch wrote:
> On Tue, Feb 07, 2017 at 05:46:58PM +0100, Christoph Hellwig wrote:
> > @@ -1233,6 +1243,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
> >  	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
> >  		vwc = true;
> >  	blk_queue_write_cache(q, vwc, vwc);
> > +	blk_queue_max_discard_segments(q,
> > +			PAGE_SIZE / sizeof(struct nvme_dsm_range));
> 
> We need to use ctrl->page_size rather than PAGE_SIZE.

We need the PAGE_SIZE upper bound because the "special" bvec only
allows a single page payload.  I can't find any indication that
the DSM command is limited to a single PRP, so not sure where a
ctrl->page_size would come from.  But now that I looked again there
is a hard limit of 256 entries due to NR being a 8-bit field, so
I need to cap on that at least.
