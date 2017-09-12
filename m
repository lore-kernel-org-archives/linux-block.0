Return-Path: <ming.lei@redhat.com>
Date: Tue, 12 Sep 2017 18:23:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: put the driver tag of nxt rq before first one is
 requeued
Message-ID: <20170912102302.GC15792@ming.t460p>
References: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 13, 2017 at 01:14:35AM +0800, Jianchao Wang wrote:
> When free the driver tag of the next rq with I/O scheduler
> configured, it get the first entry of the list, however, at the
> moment, the failed rq has been requeued at the head of the list.
> The rq it gets is the failed rq not the next rq.
> Free the driver tag of next rq before the failed one is requeued
> in the failure branch of queue_rq callback and it is just needed
> there.

Looks a good catch.

> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4603b11..19f848e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -983,7 +983,7 @@ static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
>  bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
>  {
>  	struct blk_mq_hw_ctx *hctx;
> -	struct request *rq;
> +	struct request *rq, *nxt;
>  	int errors, queued;
>  
>  	if (list_empty(list))
> @@ -1029,14 +1029,20 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
>  		if (list_empty(list))
>  			bd.last = true;
>  		else {
> -			struct request *nxt;
> -
>  			nxt = list_first_entry(list, struct request, queuelist);
>  			bd.last = !blk_mq_get_driver_tag(nxt, NULL, false);
>  		}
>  
>  		ret = q->mq_ops->queue_rq(hctx, &bd);
>  		if (ret == BLK_STS_RESOURCE) {
> +			/*
> +			 * If an I/O scheduler has been configured and we got a
> +			 * driver tag for the next request already, free it again.
> +			 */
> +			if (!list_empty(list)) {
> +				nxt = list_first_entry(list, struct request, queuelist);
> +				blk_mq_put_driver_tag(nxt);
> +			}

The following way might be more simple and clean:

			if (nxt)
				blk_mq_put_driver_tag(nxt);

meantime 'nxt' need to be cleared inside the 'if (list_empty(list))'
before .queue_rq().

-- 
Ming
