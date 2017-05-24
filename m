Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:60267 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754962AbdEXJ6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 05:58:48 -0400
Date: Wed, 24 May 2017 02:58:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] blk-mq: make per-sw-queue bio merge as default
 .bio_merge
Message-ID: <20170524095843.GB30474@infradead.org>
References: <20170523114736.12026-1-ming.lei@redhat.com>
 <20170523114736.12026-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170523114736.12026-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 23, 2017 at 07:47:36PM +0800, Ming Lei wrote:
> Because what the per-sw-queue bio merge does is basically same with
> scheduler's .bio_merge(), this patch makes per-sw-queue bio merge
> as the default .bio_merge if no scheduler is used or io scheduler
> doesn't provide .bio_merge().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sched.c | 62 +++++++++++++++++++++++++++++++++++++++++++++----
>  block/blk-mq-sched.h |  4 +---
>  block/blk-mq.c       | 65 ----------------------------------------------------
>  3 files changed, 58 insertions(+), 73 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 1f5b692526ae..c4e2afb9d12d 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -221,19 +221,71 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
>  
> +/*
> + * Reverse check our software queue for entries that we could potentially
> + * merge with. Currently includes a hand-wavy stop count of 8, to not spend
> + * too much time checking for merges.
> + */
> +static bool blk_mq_attempt_merge(struct request_queue *q,
> +				 struct blk_mq_ctx *ctx, struct bio *bio)
> +{
> +	struct request *rq;
> +	int checked = 8;
> +
> +	list_for_each_entry_reverse(rq, &ctx->rq_list, queuelist) {
> +		bool merged = false;
> +
> +		if (!checked--)
> +			break;
> +
> +		if (!blk_rq_merge_ok(rq, bio))
> +			continue;
> +
> +		switch (blk_try_merge(rq, bio)) {
> +		case ELEVATOR_BACK_MERGE:
> +			if (blk_mq_sched_allow_merge(q, rq, bio))
> +				merged = bio_attempt_back_merge(q, rq, bio);
> +			break;
> +		case ELEVATOR_FRONT_MERGE:
> +			if (blk_mq_sched_allow_merge(q, rq, bio))
> +				merged = bio_attempt_front_merge(q, rq, bio);
> +			break;
> +		case ELEVATOR_DISCARD_MERGE:
> +			merged = bio_attempt_discard_merge(q, rq, bio);
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		if (merged)
> +			ctx->rq_merged++;
> +		return merged;
> +	}
> +
> +	return false;
> +}
> +
>  bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
>  {
>  	struct elevator_queue *e = q->elevator;
> +	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
> +	bool ret = false;
>  
> +	if (e && e->type->ops.mq.bio_merge) {
>  		blk_mq_put_ctx(ctx);
>  		return e->type->ops.mq.bio_merge(hctx, bio);
>  	}
>  
> +	if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
> +		/* default per sw-queue merge */
> +		spin_lock(&ctx->lock);
> +		ret = blk_mq_attempt_merge(q, ctx, bio);
> +		spin_unlock(&ctx->lock);
> +	}
> +
> +	blk_mq_put_ctx(ctx);
> +	return ret;

I'd rather move __blk_mq_sched_bio_merge/blk_mq_sched_bio_merge into
blk-mq.c (and dropping the sched in the name) rather than moving
blk_mq_attempt_merge out.

But except that this looks fine to me.
