Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:54448 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdIOAEQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 20:04:16 -0400
Received: by mail-pf0-f178.google.com with SMTP id d187so506776pfg.11
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2017 17:04:16 -0700 (PDT)
Date: Thu, 14 Sep 2017 17:04:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 03/14] blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
Message-ID: <20170915000413.GA15772@vader>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170902151729.6162-4-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 02, 2017 at 11:17:18PM +0800, Ming Lei wrote:
> This function is introduced for dequeuing request
> from sw queue so that we can dispatch it in
> scheduler's way.
> 
> More importantly, some SCSI devices may set
> q->queue_depth, which is a per-request_queue limit,
> and applied on pending I/O from all hctxs. This
> function is introduced for avoiding to dequeue too
> many requests from sw queue when ->dispatch isn't
> flushed completely.

blk_mq_dispatch_rq_from_ctx() doesn't actually dispatch the request. Can
you please rename it blk_mq_dequeue_from_ctx() or something like that?
(Same for the dispatch_rq_from_ctx helper.)

> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 38 ++++++++++++++++++++++++++++++++++++++
>  block/blk-mq.h |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3f18cff80050..f063dd0f197f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -880,6 +880,44 @@ void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_flush_busy_ctxs);
>  
> +struct dispatch_rq_data {
> +	struct blk_mq_hw_ctx *hctx;
> +	struct request *rq;
> +};
> +
> +static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
> +{
> +	struct dispatch_rq_data *dispatch_data = data;
> +	struct blk_mq_hw_ctx *hctx = dispatch_data->hctx;
> +	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
> +
> +	spin_lock(&ctx->lock);
> +	if (unlikely(!list_empty(&ctx->rq_list))) {
> +		dispatch_data->rq = list_entry_rq(ctx->rq_list.next);
> +		list_del_init(&dispatch_data->rq->queuelist);
> +		if (list_empty(&ctx->rq_list))
> +			sbitmap_clear_bit(sb, bitnr);
> +	}
> +	spin_unlock(&ctx->lock);
> +
> +	return !dispatch_data->rq;
> +}
> +
> +struct request *blk_mq_dispatch_rq_from_ctx(struct blk_mq_hw_ctx *hctx,
> +					    struct blk_mq_ctx *start)
> +{
> +	unsigned off = start ? start->index_hw : 0;
> +	struct dispatch_rq_data data = {
> +		.hctx = hctx,
> +		.rq   = NULL,
> +	};
> +
> +	__sbitmap_for_each_set(&hctx->ctx_map, off,
> +			       dispatch_rq_from_ctx, &data);
> +
> +	return data.rq;
> +}
> +
>  static inline unsigned int queued_to_index(unsigned int queued)
>  {
>  	if (!queued)
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 98252b79b80b..e42748bfb959 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -35,6 +35,8 @@ void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
>  bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
>  bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>  				bool wait);
> +struct request *blk_mq_dispatch_rq_from_ctx(struct blk_mq_hw_ctx *hctx,
> +					    struct blk_mq_ctx *start);
>  
>  /*
>   * Internal helpers for allocating/freeing the request map
> -- 
> 2.9.5
> 
