Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/6] blk-mq: protect completion path with RCU
To: Tejun Heo <tj@kernel.org>, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org,
        kernel-team@fb.com, osandov@fb.com, linux-block@vger.kernel.org,
        hch@lst.de
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-2-tj@kernel.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <402aea05-8d04-99e2-5e31-803d2423283d@oracle.com>
Date: Wed, 13 Dec 2017 11:30:48 +0800
MIME-Version: 1.0
In-Reply-To: <20171212190134.535941-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hello tejun
Sorry for missing the V2, same comment again.
 
On 12/13/2017 03:01 AM, Tejun Heo wrote:
> Currently, blk-mq protects only the issue path with RCU.  This patch
> puts the completion path under the same RCU protection.  This will be
> used to synchronize issue/completion against timeout by later patches,
> which will also add the comments.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  block/blk-mq.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1109747..acf4fbb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -568,11 +568,23 @@ static void __blk_mq_complete_request(struct request *rq)
>  void blk_mq_complete_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> +	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
> +	int srcu_idx;
>  
>  	if (unlikely(blk_should_fake_timeout(q)))
>  		return;
> -	if (!blk_mark_rq_complete(rq))
> -		__blk_mq_complete_request(rq);
> +
> +	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> +		rcu_read_lock();
> +		if (!blk_mark_rq_complete(rq))
> +			__blk_mq_complete_request(rq);
> +		rcu_read_unlock();
> +	} else {
> +		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
> +		if (!blk_mark_rq_complete(rq))
> +			__blk_mq_complete_request(rq);
> +		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);

The __blk_mq_complete_request() could be executed in irq context. There should not be any 
sleeping operations in it. If just synchronize with the timeout path to ensure the aborted_gstate
to be seen, only rcu is needed here ,as well as the blk_mq_timeout_work.
> +	}
>  }
>  EXPORT_SYMBOL(blk_mq_complete_request);
>  
> 
