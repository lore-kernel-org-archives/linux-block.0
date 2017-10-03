Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46125 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbdJCJLa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 05:11:30 -0400
Date: Tue, 3 Oct 2017 02:11:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Tom Nguyen <tom81094@gmail.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V5 7/7] blk-mq-sched: don't dequeue request until all in
 ->dispatch are flushed
Message-ID: <20171003091128.GD21184@infradead.org>
References: <20170930102720.30219-1-ming.lei@redhat.com>
 <20170930102720.30219-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930102720.30219-8-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This looks good in general:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Minor nitpicks below:

>  	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;

This is now only tested once, so you can remove the local variable
for it.

> +		/*
> +		 * We may clear DISPATCH_BUSY just after it
> +		 * is set from another context, the only cost
> +		 * is that one request is dequeued a bit early,
> +		 * we can survive that. Given the window is
> +		 * small enough, no need to worry about performance
> +		 * effect.
> +		 */

Use your 80 line real estate for comments please.

>  	if (!has_sched_dispatch)
> +		if (!q->queue_depth) {
> +			blk_mq_flush_busy_ctxs(hctx, &rq_list);
> +			blk_mq_dispatch_rq_list(q, &rq_list);
> +		} else {
> +			blk_mq_do_dispatch_ctx(q, hctx);
> +		}
> +	} else {
>  		blk_mq_do_dispatch_sched(q, e, hctx);
> +	}

Maybe flatten this out to:

	if (e && e->type->ops.mq.dispatch_request) {
		blk_mq_do_dispatch_sched(q, e, hctx);
	} else if (q->queue_depth) {
		blk_mq_do_dispatch_ctx(q, hctx);
	} else {
		blk_mq_flush_busy_ctxs(hctx, &rq_list);
		blk_mq_dispatch_rq_list(q, &rq_list);
	}
