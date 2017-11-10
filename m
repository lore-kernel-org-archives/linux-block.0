Return-Path: <BATV+b9f22be6cf688ae68bc2+5192+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 10 Nov 2017 09:29:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: only run the hardware queue if IO is pending
Message-ID: <20171110172957.GA29446@infradead.org>
References: <b1c29434-929d-a8aa-7181-b0b90607ede1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b1c29434-929d-a8aa-7181-b0b90607ede1@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 10, 2017 at 09:12:18AM -0700, Jens Axboe wrote:
> Currently we are inconsistent in when we decide to run the queue. Using
> blk_mq_run_hw_queues() we check if the hctx has pending IO before
> running it, but we don't do that from the individual queue run function,
> blk_mq_run_hw_queue(). This results in a lot of extra and pointless
> queue runs, potentially, on flush requests and (much worse) on tag
> starvation situations. This is observable just looking at the top
> output, with lots of kworkers active. For the !async runs, it just adds
> to the CPU overhead of blk-mq.
> 
> Move the has-pending check into the run function instead of having
> callers do it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Do we even still need the blk_mq_hctx_has_pending helper at all?

Except for that this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
