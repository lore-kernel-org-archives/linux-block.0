Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35241 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbdECQWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 12:22:02 -0400
Received: by mail-pg0-f51.google.com with SMTP id o3so75565834pgn.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 09:22:02 -0700 (PDT)
Date: Wed, 3 May 2017 09:21:59 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/4] blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
Message-ID: <20170503162159.GA10343@vader>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170428151539.25514-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 11:15:36PM +0800, Ming Lei wrote:
> When blk-mq I/O scheduler is used, we need two tags for
> submitting one request. One is called scheduler tag for
> allocating request and scheduling I/O, another one is called
> driver tag, which is used for dispatching IO to hardware/driver.
> This way introduces one extra per-queue allocation for both tags
> and request pool, and may not be as efficient as case of none
> scheduler.
> 
> Also currently we put a default per-hctx limit on schedulable
> requests, and this limit may be a bottleneck for some devices,
> especialy when these devices have a quite big tag space.
> 
> This patch introduces BLK_MQ_F_SCHED_USE_HW_TAG so that we can
> allow to use hardware/driver tags directly for IO scheduling if
> devices's hardware tag space is big enough. Then we can avoid
> the extra resource allocation and make IO submission more
> efficient.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sched.c   | 10 +++++++++-
>  block/blk-mq.c         | 35 +++++++++++++++++++++++++++++------
>  include/linux/blk-mq.h |  1 +
>  3 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 27c67465f856..45a675f07b8b 100644
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0168b27469cb..e530bc54f0d9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -263,9 +263,19 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
>  				rq->rq_flags = RQF_MQ_INFLIGHT;
>  				atomic_inc(&data->hctx->nr_active);
>  			}
> -			rq->tag = tag;
> -			rq->internal_tag = -1;
> -			data->hctx->tags->rqs[rq->tag] = rq;
> +			data->hctx->tags->rqs[tag] = rq;
> +
> +			/*
> +			 * If we use hw tag for scheduling, postpone setting
> +			 * rq->tag in blk_mq_get_driver_tag().
> +			 */
> +			if (data->hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG) {
> +				rq->tag = -1;
> +				rq->internal_tag = tag;
> +			} else {
> +				rq->tag = tag;
> +				rq->internal_tag = -1;
> +			}

I'm guessing you did it this way because we currently check rq->tag to
decided whether this is a flush that needs to be bypassed? Makes sense,
but I'm adding it to my list of reasons why the flush stuff sucks.

> @@ -893,9 +909,15 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>  static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>  				    struct request *rq)
>  {
> -	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
> +	unsigned tag = rq->tag;

The pickiest of all nits, but we mostly spell out `unsigned int` in this
file, it'd be nice to stay consistent.
