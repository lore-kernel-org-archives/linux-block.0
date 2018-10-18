Return-Path: <hch@lst.de>
Date: Thu, 18 Oct 2018 16:28:26 +0200
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
Subject: Re: [PATCH 1/5] block: warn on un-aligned DMA IO buffer
Message-ID: <20181018142826.GA26828@lst.de>
References: <20181018131817.11813-1-ming.lei@redhat.com> <20181018131817.11813-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018131817.11813-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a46744c11b..d2dbd508cb6d 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -174,6 +174,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	const unsigned max_sectors = get_max_io_size(q, bio);
>  
>  	bio_for_each_segment(bv, bio, iter) {
> +		WARN_ON_ONCE(queue_dma_alignment(q) & bv.bv_offset);

I'd write this the other way around, although I have no good argument
for that.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
