Return-Path: <hch@lst.de>
Date: Thu, 18 Oct 2018 16:31:51 +0200
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
Subject: Re: [PATCH 3/5] block: make dma_alignment as stacked limit
Message-ID: <20181018143151.GC26828@lst.de>
References: <20181018131817.11813-1-ming.lei@redhat.com> <20181018131817.11813-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018131817.11813-4-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 09:18:15PM +0800, Ming Lei wrote:
> This patch converts .dma_alignment into stacked limit, so the stack
> driver may get updated with underlying dma alignment, and allocate
> IO buffer as queue DMA aligned.
> 
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: xfs@vger.kernel.org
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-settings.c | 89 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 50 insertions(+), 39 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index cf9cd241dc16..aef4510a99b6 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -525,6 +525,54 @@ void blk_queue_stack_limits(struct request_queue *t, struct request_queue *b)
>  EXPORT_SYMBOL(blk_queue_stack_limits);
>  
>  /**
> + * blk_queue_dma_alignment - set dma length and memory alignment
> + * @q:     the request queue for the device
> + * @mask:  alignment mask
> + *
> + * description:
> + *    set required memory and length alignment for direct dma transactions.
> + *    this is used when building direct io requests for the queue.
> + *
> + **/
> +void blk_queue_dma_alignment(struct request_queue *q, int mask)
> +{
> +	q->limits.dma_alignment = mask;
> +}
> +EXPORT_SYMBOL(blk_queue_dma_alignment);

Any good reason not to keep these functions where they were before?

> +
> +static int __blk_queue_update_dma_alignment(struct queue_limits *t, int mask)
> +{
> +	BUG_ON(mask >= PAGE_SIZE);
> +
> +	if (mask > t->dma_alignment)
> +		return mask;
> +	else
> +		return t->dma_alignment;

I think this function could just be replaced with a:

	max(t->dma_alignment, mask);
