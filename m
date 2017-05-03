Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35323 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdECQzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 12:55:32 -0400
Received: by mail-pg0-f51.google.com with SMTP id o3so76002102pgn.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 09:55:32 -0700 (PDT)
Date: Wed, 3 May 2017 09:55:30 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 2/4] blk-mq: introduce blk_mq_get_queue_depth()
Message-ID: <20170503165530.GB10775@vader>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170428151539.25514-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 11:15:37PM +0800, Ming Lei wrote:
> The hardware queue depth can be resized via blk_mq_update_nr_requests(),
> so introduce this helper for retrieving queue's depth easily.

One nit below. If the per-hardware queue tag space situation changes, we
can revisit this and the similar thing in Kyber.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 12 ++++++++++++
>  block/blk-mq.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e530bc54f0d9..04761fb76ab4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2637,6 +2637,18 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>  }
>  EXPORT_SYMBOL(blk_mq_free_tag_set);
>  
> +/*
> + * Queue depth can be changed via blk_mq_update_nr_requests(),
> + * so use this helper to retrieve queue's depth.
> + */
> +int blk_mq_get_queue_depth(struct request_queue *q)
> +{
> +	/* All queues have same queue depth */
> +	struct blk_mq_tags	*tags = q->tag_set->tags[0];

Not sure what's going on with the spacing here. Tab instead of a space?

> +	return tags->bitmap_tags.sb.depth;
> +}
> +
>  int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 2814a14e529c..8085d5989cf5 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -166,6 +166,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
>  void blk_mq_finish_request(struct request *rq);
>  struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
>  					unsigned int op);
> +int blk_mq_get_queue_depth(struct request_queue *q);
>  
>  static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
>  {
> -- 
> 2.9.3
> 
