Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V4 1/3] blk-mq: move actual issue into one helper
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@infradead.org>
References: <20180115165810.2515-1-ming.lei@redhat.com>
 <20180115165810.2515-2-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2b698c6c-9d9d-8555-7fe8-272bcdd65086@kernel.dk>
Date: Mon, 15 Jan 2018 10:29:46 -0700
MIME-Version: 1.0
In-Reply-To: <20180115165810.2515-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/15/18 9:58 AM, Ming Lei wrote:
> No functional change, just to clean up code a bit, so that the following
> change of using direct issue for blk_mq_request_bypass_insert() which is
> needed by DM can be easier to do.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index edb1291a42c5..bf8d6651f40e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1696,15 +1696,37 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
>  	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
>  }
>  
> -static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> -					struct request *rq,
> -					blk_qc_t *cookie)
> +static blk_status_t __blk_mq_issue_req(struct blk_mq_hw_ctx *hctx,
> +				       struct request *rq,
> +				       blk_qc_t *new_cookie)
>  {
> +	blk_status_t ret;
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_queue_data bd = {
>  		.rq = rq,
>  		.last = true,
>  	};
> +
> +	if (!blk_mq_get_driver_tag(rq, NULL, false))
> +		return BLK_STS_AGAIN;
> +
> +	if (!blk_mq_get_dispatch_budget(hctx)) {
> +		blk_mq_put_driver_tag(rq);
> +		return BLK_STS_AGAIN;
> +	}
> +
> +	*new_cookie = request_to_qc_t(hctx, rq);
> +
> +	ret = q->mq_ops->queue_rq(hctx, &bd);
> +
> +	return ret;

	return q->mq_ops->queue_rq(hctx, &bd);

and kill 'ret', it's not used. But more importantly, who puts the
driver tag and the budget if we get != OK for ->queue_rq()?

-- 
Jens Axboe
