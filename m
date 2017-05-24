Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdEXJsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 05:48:18 -0400
Date: Wed, 24 May 2017 02:48:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] blk-mq: merge bio into sw queue before plugging
Message-ID: <20170524094816.GA30474@infradead.org>
References: <20170523114736.12026-1-ming.lei@redhat.com>
 <20170523114736.12026-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170523114736.12026-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 23, 2017 at 07:47:35PM +0800, Ming Lei wrote:
> Before blk-mq is introduced, I/O is merged to elevator
> before being putted into plug queue, but blk-mq changed the
> order and makes merging to sw queue basically impossible.
> Then it is observed that throughput of sequential I/O is degraded
> about 10%~20% on virtio-blk in the test[1] if mq-deadline isn't used.
> 
> This patch moves the bio merging per sw queue before plugging,
> like what blk_queue_bio() does, and the performance regression is
> fixed under this situation.
> 
> [1]. test script:
> sudo fio --direct=1 --size=128G --bsrange=4k-4k --runtime=40 --numjobs=16 --ioengine=libaio --iodepth=64 --group_reporting=1 --filename=/dev/vdb --name=virtio_blk-test-$RW --rw=$RW --output-format=json
> 
> RW=read or write
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 53 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a69ad122ed66..b7ca64ef15e8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1446,30 +1446,31 @@ static inline bool hctx_allow_merges(struct blk_mq_hw_ctx *hctx)
>  		!blk_queue_nomerges(hctx->queue);
>  }
> +/* attempt to merge bio into current sw queue */
> +static inline bool blk_mq_merge_bio(struct request_queue *q, struct bio *bio)
>  {
> +	bool ret = false;
> +	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
>  
> +	if (!hctx_allow_merges(hctx) || !bio_mergeable(bio))
> +		goto exit;
>  
> +	spin_lock(&ctx->lock);
> +	ret = blk_mq_attempt_merge(q, ctx, bio);
> +	spin_unlock(&ctx->lock);
> +exit:
> +	blk_mq_put_ctx(ctx);
> +	return ret;

If I'd want to nitpick I'd say that this would probably be a bit
cleaner without the goto..

But otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
