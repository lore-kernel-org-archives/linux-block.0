Return-Path: <ming.lei@redhat.com>
Date: Tue, 3 Jul 2018 22:11:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4] blk-mq: dequeue request one by one from sw queue iff
 hctx is busy
Message-ID: <20180703141106.GA7755@ming.t460p>
References: <20180703083452.4909-1-ming.lei@redhat.com>
 <45df84ca-e201-a9e1-543c-ebbf15185d40@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45df84ca-e201-a9e1-543c-ebbf15185d40@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 03, 2018 at 08:03:23AM -0600, Jens Axboe wrote:
> On 7/3/18 2:34 AM, Ming Lei wrote:
> > It won't be efficient to dequeue request one by one from sw queue,
> > but we have to do that when queue is busy for better merge performance.
> > 
> > This patch takes the Exponential Weighted Moving Average(EWMA) to figure
> > out if queue is busy, then only dequeue request one by one from sw queue
> > when queue is busy.
> 
> I've started to come around to the approach, but can we add something
> that only triggers this busy tracking if we've even seen a BUSY
> condition? Basically, this:
> 
> blk_mq_update_dispatch_busy(hctx, false);
> 
> should be a no-op, if we've never called:
> 
> blk_mq_update_dispatch_busy(hctx, true);
> 
> Something ala the below, with the BLK_MQ_S_EWMA bit added, of course.
> 
> static void __blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
> {
> 	unsigned int ewma = READ_ONCE(hctx->dispatch_busy);
> 
> 	ewma *= BLK_MQ_DISPATCH_BUSY_EWMA_WEIGHT - 1;
> 	if (busy)
> 		ewma += 1 << BLK_MQ_DISPATCH_BUSY_EWMA_FACTOR;
> 	ewma /= BLK_MQ_DISPATCH_BUSY_EWMA_WEIGHT;
> 
> 	WRITE_ONCE(hctx->dispatch_busy, ewma);
> }

How about doing it in the following(simpler) way? By adding the check
at the entry of __blk_mq_update_dispatch_busy().

	if (!ewma && !busy)
		return;

Thanks,
Ming
