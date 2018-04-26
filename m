Return-Path: <hch@lst.de>
Date: Thu, 26 Apr 2018 09:20:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
	linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ide: kill ide_toggle_bounce
Message-ID: <20180426072033.GA14700@lst.de>
References: <20180424181625.22410-1-hch@lst.de> <20180424181625.22410-3-hch@lst.de> <5aaca0d3-417f-57f3-969f-b4c777c3fd48@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5aaca0d3-417f-57f3-969f-b4c777c3fd48@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 24, 2018 at 08:02:56PM -0600, Jens Axboe wrote:
> On 4/24/18 12:16 PM, Christoph Hellwig wrote:
> > ide_toggle_bounce did select various strange block bounce limits, including
> > not bouncing at all as soon as an iommu is present in the system.  Given
> > that the dma_map routines now handle any required bounce buffering except
> > for ISA DMA, and the ide code already must handle either ISA DMA or highmem
> > at least for iommu equipped systems we can get rid of the block layer
> > bounce limit setting entirely.
> 
> Pretty sure I was the one to add this code, when highmem page IO was
> enabled about two decades ago...
> 
> Outside of DMA, the issue was that the PIO code could not handle
> highmem. That's not the case anymore, so this should be fine.

Yes, that is the rationale.  Any chance to you could look over the
other patches as well?  Except for the networking one for which I'd
really like to see a review from Dave all the users of the interface
are block related.
