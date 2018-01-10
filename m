Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 10 Jan 2018 10:43:33 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, bart.vanassche@wdc.com
Subject: Re: [PATCH 4/4] block: rearrange a few request fields for better
 cache layout
Message-ID: <20180110184333.GC30831@vader.DHCP.thefacebook.com>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
 <1515544167-10751-5-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515544167-10751-5-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 09, 2018 at 05:29:27PM -0700, Jens Axboe wrote:
> Move completion related items (like the call single data) near the
> end of the struct, instead of mixing them in with the initial
> queueing related fields.
> 
> Move queuelist below the bio structures. Then we have all
> queueing related bits in the first cache line.
> 
> This yields a 1.5-2% increase in IOPS for a null_blk test, both for
> sync and for high thread count access. Sync test goes form 975K to
> 992K, 32-thread case from 20.8M to 21.2M IOPS.

One nit below, otherwise

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c         | 19 ++++++++++---------
>  include/linux/blkdev.h | 28 +++++++++++++++-------------
>  2 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7248ee043651..ec128001ea8b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -270,8 +270,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
>  	struct request *rq = tags->static_rqs[tag];
>  
> -	rq->rq_flags = 0;
> -
>  	if (data->flags & BLK_MQ_REQ_INTERNAL) {
>  		rq->tag = -1;
>  		rq->internal_tag = tag;
> @@ -285,26 +283,23 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  		data->hctx->tags->rqs[rq->tag] = rq;
>  	}
>  
> -	INIT_LIST_HEAD(&rq->queuelist);
>  	/* csd/requeue_work/fifo_time is initialized before use */
>  	rq->q = data->q;
>  	rq->mq_ctx = data->ctx;
> +	rq->rq_flags = 0;
> +	rq->cpu = -1;
>  	rq->cmd_flags = op;
>  	if (data->flags & BLK_MQ_REQ_PREEMPT)
>  		rq->rq_flags |= RQF_PREEMPT;
>  	if (blk_queue_io_stat(data->q))
>  		rq->rq_flags |= RQF_IO_STAT;
> -	rq->cpu = -1;
> +	/* do not touch atomic flags, it needs atomic ops against the timer */

This comment was just removed in a previous patch but it snuck back in.
