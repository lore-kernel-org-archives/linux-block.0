Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 03/12] block: Introduce
 request_queue.initialize_rq_fn()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
 <20170619220801.12557-4-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <86346ded-5496-89df-6204-30a945ba40bd@kernel.dk>
Date: Mon, 19 Jun 2017 16:22:11 -0600
MIME-Version: 1.0
In-Reply-To: <20170619220801.12557-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 04:07 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Several block drivers need to initialize the driver-private request
> data after having called blk_get_request() and before .prep_rq_fn()
> is called, e.g. when submitting a REQ_OP_SCSI_* request. Avoid that
> that initialization code has to be repeated after every
> blk_get_request() call by adding new callback functions to struct
> request_queue and to struct blk_mq_ops.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-core.c       | 17 +++++++++++++++--
>  include/linux/blk-mq.h |  2 ++
>  include/linux/blkdev.h |  4 ++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 93edf22009fe..0c08cf3559c9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1366,12 +1366,25 @@ static struct request *blk_old_get_request(struct request_queue *q,
>  struct request *blk_get_request(struct request_queue *q, unsigned int op,
>  				gfp_t gfp_mask)
>  {
> +	struct request *req;
> +
>  	if (q->mq_ops)
> -		return blk_mq_alloc_request(q, op,
> +		req = blk_mq_alloc_request(q, op,
>  			(gfp_mask & __GFP_DIRECT_RECLAIM) ?
>  				0 : BLK_MQ_REQ_NOWAIT);
>  	else
> -		return blk_old_get_request(q, op, gfp_mask);
> +		req = blk_old_get_request(q, op, gfp_mask);
> +
> +	if (IS_ERR(req))
> +		goto out;
> +
> +	if (q->mq_ops && q->mq_ops->initialize_rq_fn)
> +		q->mq_ops->initialize_rq_fn(req);
> +	else if (!q->mq_ops && q->initialize_rq_fn)
> +		q->initialize_rq_fn(req);

Why not fold these into the previous mq_ops-or-not check? Or put them in
blk_mq_alloc_request() and blk_old_get_request() instead?

-- 
Jens Axboe
