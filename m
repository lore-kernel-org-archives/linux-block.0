Return-Path: <hch@lst.de>
Date: Thu, 18 Oct 2018 16:29:00 +0200
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
Subject: Re: [PATCH 2/5] block: move .dma_alignment into q->limits
Message-ID: <20181018142900.GB26828@lst.de>
References: <20181018131817.11813-1-ming.lei@redhat.com> <20181018131817.11813-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018131817.11813-3-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 09:18:14PM +0800, Ming Lei wrote:
> Turns out q->dma_alignement should be stack limit because now bvec table
> is immutalbe, the underlying queue's dma alignment has to be perceptible
> by stack driver, so IO buffer can be allocated as dma aligned before
> adding to bio.
> 
> So this patch moves .dma_alignment into q->limits and prepares for
> making it as one stacked limit.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
