Return-Path: <hch@lst.de>
Date: Thu, 18 Oct 2018 16:43:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/5] block: warn on un-aligned DMA IO buffer
Message-ID: <20181018144306.GA27353@lst.de>
References: <20181018131817.11813-1-ming.lei@redhat.com> <20181018131817.11813-2-ming.lei@redhat.com> <cdc2f78a-4c97-0b71-e4d3-08bfcca6b42e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cdc2f78a-4c97-0b71-e4d3-08bfcca6b42e@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 08:27:28AM -0600, Jens Axboe wrote:
> On 10/18/18 7:18 AM, Ming Lei wrote:
> > Now we only check if DMA IO buffer is aligned to queue_dma_alignment()
> > for pass-through request, and it isn't done for normal IO request.
> > 
> > Given the check has to be done on each bvec, it isn't efficient to add the
> > check in generic_make_request_checks().
> > 
> > This patch addes one WARN in blk_queue_split() for capturing this issue.
> 
> I don't want to do this, because then we are forever doomed to
> have something that fully loops a bio at submission time. I
> absolutely hate the splitting we have and the need for it,
> hopefully it can go away for a subset of IOs at some point.

It is just a WARN_ON - no one should rely on it, but it is a good
debug aid.
