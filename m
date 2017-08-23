Return-Path: <axboe@kernel.dk>
Date: Wed, 23 Aug 2017 13:56:50 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V2 06/20] blk-mq-sched: don't dequeue request until all
 in ->dispatch are flushed
Message-ID: <20170823195648.GA15083@kernel.dk>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170805065705.12989-7-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Aug 05 2017, Ming Lei wrote:
> During dispatching, we moved all requests from hctx->dispatch to
> one temporary list, then dispatch them one by one from this list.
> Unfortunately duirng this period, run queue from other contexts
> may think the queue is idle, then start to dequeue from sw/scheduler
> queue and still try to dispatch because ->dispatch is empty. This way
> hurts sequential I/O performance because requests are dequeued when
> lld queue is busy.
> 
> This patch introduces the state of BLK_MQ_S_DISPATCH_BUSY to
> make sure that request isn't dequeued until ->dispatch is
> flushed.

I don't like how this patch introduces a bunch of locked setting of a
flag under the hctx lock. Especially since I think we can easily avoid
it.

> -	} else if (!has_sched_dispatch & !q->queue_depth) {
> +		blk_mq_dispatch_rq_list(q, &rq_list);
> +
> +		/*
> +		 * We may clear DISPATCH_BUSY just after it
> +		 * is set from another context, the only cost
> +		 * is that one request is dequeued a bit early,
> +		 * we can survive that. Given the window is
> +		 * too small, no need to worry about performance
> +		 * effect.
> +		 */
> +		if (list_empty_careful(&hctx->dispatch))
> +			clear_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);

This is basically the only place where we modify it without holding the
hctx lock. Can we move it into blk_mq_dispatch_rq_list()? The list is
generally empty, unless for the case where we splice residuals back. If
we splice them back, we grab the lock anyway.

The other places it's set under the hctx lock, yet we end up using an
atomic operation to do it.

-- 
Jens Axboe
