Return-Path: <hch@lst.de>
Date: Fri, 29 Jun 2018 10:35:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH V2 2/3] blk-mq: only attempt to merge bio if there is
	rq in sw queue
Message-ID: <20180629083502.GD15870@lst.de>
References: <20180629081252.13836-1-ming.lei@redhat.com> <20180629081252.13836-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629081252.13836-3-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 29, 2018 at 04:12:51PM +0800, Ming Lei wrote:
> Only attempt to merge bio iff the ctx->rq_list isn't empty, because:
> 
> 1) for high-performance SSD, most of times dispatch may succeed, then
> there may be nothing left in ctx->rq_list, so don't try to merge over
> sw queue if it is empty, then we can save one acquiring of ctx->lock
> 
> 2) we can't expect good merge performance on per-cpu sw queue, and missing
> one merge on sw queue won't be a big deal since tasks can be scheduled from
> one CPU to another.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
