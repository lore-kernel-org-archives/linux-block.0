Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 18 Jun 2017 23:35:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
Message-ID: <20170619063529.GF2311@infradead.org>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-12-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497729594-4707-12-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Can you add linux-nvme for the next repost?

As said before I think we should rely on implicit streams allocation,
as that will make the whole patch a lot simpler, and it solves the issue
that your current patch will take away your 4 streams from the general
pool on every controller that supports streams, which isn't optimal.

> +	streamid = (req->cmd_flags & REQ_WRITE_LIFE_MASK)
> +			>> __REQ_WRITE_HINT_SHIFT;

Can we add a helper to convert the REQ_* flags back to the hint next
to where we have the helper to do the reverse one?

> +	if (streamid == WRITE_LIFE_NONE)
> +		return;
> +
> +	/* for now just round-robin, do something more clever later */
> +	if (streamid > ctrl->nr_streams)
> +		streamid = (streamid % ctrl->nr_streams) + 1;

I thought you were going to fix that to do more intelligent collapsing?

> -	ns->queue->limits.discard_granularity = logical_block_size;
> +	if (ctrl->nr_streams && ns->sws && ns->sgs) {
> +		unsigned int sz = logical_block_size * ns->sws * ns->sgs;
> +
> +		ns->queue->limits.discard_alignment = sz;

I don't think this is correct:

"Data that is aligned to and in multiples of the Stream Write Size (SWS)
 provides optimal performance of the write commands to the controller.
 The Stream Granularity Size indicates the size of the media that is prepared
 as a unit for future allocation for write commands and is a multiple of the
 Stream Write Size. The controller may allocate and group together a stream
 in Stream Granularity Size (SGS) units. Refer to Figure 293."

So I think the ns->sws should go away.

> +		ns->queue->limits.discard_granularity = sz;
> +	} else {
> +		u32 logical_block_size = queue_logical_block_size(ns->queue);

I think we already have a logical_block_size with the same value in
scope here.

> +
> +	ns->sws = le32_to_cpu(s.sws);
> +	ns->sgs = le16_to_cpu(s.sgs);
> +
> +	if (ns->sws) {
> +		unsigned int bs = 1 << ns->lba_shift;
> +
> +		blk_queue_io_min(ns->queue, bs * ns->sws);
> +		if (ns->sgs)
> +			blk_queue_io_opt(ns->queue, bs * ns->sws * ns->sgs);

drop the multiplication with ns->sws here as well.
