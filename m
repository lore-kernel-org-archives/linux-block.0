Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_alloc_request_hctx
To: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com
References: <1465248119-17875-1-git-send-email-hch@lst.de>
 <1465248119-17875-2-git-send-email-hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ming Lin <ming.l@ssi.samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5757A3D2.1030003@kernel.dk>
Date: Tue, 7 Jun 2016 22:49:22 -0600
MIME-Version: 1.0
In-Reply-To: <1465248119-17875-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/06/2016 03:21 PM, Christoph Hellwig wrote:
> From: Ming Lin <ming.l@ssi.samsung.com>
>
> For some protocols like NVMe over Fabrics we need to be able to send
> initialization commands to a specific queue.
>
> Based on an earlier patch from Christoph Hellwig <hch@lst.de>.
>
> Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c         | 33 +++++++++++++++++++++++++++++++++
>   include/linux/blk-mq.h |  2 ++
>   2 files changed, 35 insertions(+)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 29cbc1b..7bb45ed 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -266,6 +266,39 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
>   }
>   EXPORT_SYMBOL(blk_mq_alloc_request);
>
> +struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
> +		unsigned int flags, unsigned int hctx_idx)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_ctx *ctx;
> +	struct request *rq;
> +	struct blk_mq_alloc_data alloc_data;
> +	int ret;
> +
> +	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	hctx = q->queue_hw_ctx[hctx_idx];
> +	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
> +
> +	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
> +
> +	rq = __blk_mq_alloc_request(&alloc_data, rw);
> +	if (!rq && !(flags & BLK_MQ_REQ_NOWAIT)) {
> +		__blk_mq_run_hw_queue(hctx);
> +
> +		rq =  __blk_mq_alloc_request(&alloc_data, rw);
> +	}

Why are we duplicating this code here? If NOWAIT isn't set, then we'll
always return a request. bt_get() will run the queue for us, if it needs
to. blk_mq_alloc_request() does this too, and I'm guessing that code was
just copied. I'll fix that up. Looks like this should just be:

	rq = __blk_mq_alloc_request(&alloc_data, rw);
	if (rq)
		return rq;

	blk_queue_exit(q);
	return ERR_PTR(-EWOULDBLOCK);

for this case.

-- 
Jens Axboe
