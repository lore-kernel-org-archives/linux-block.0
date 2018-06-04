Return-Path: <ming.lei@redhat.com>
Date: Mon, 4 Jun 2018 18:43:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: return when BLK_MQ_S_STOPPED in
 blk_mq_run_work_fn
Message-ID: <20180604104327.GA23074@ming.t460p>
References: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 04, 2018 at 05:03:55PM +0800, Jianchao Wang wrote:
> if hctx is stopped, don't run the queue in blk_mq_run_work_fn.
> 
> Fixes: 15fe8a9 (blk-mq: remove blk_mq_delay_queue())
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9ce9cac..d0ee928 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1578,7 +1578,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
>  	 * If we are stopped, don't run the queue.
>  	 */
>  	if (test_bit(BLK_MQ_S_STOPPED, &hctx->state))
> -		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
> +		return;
>  
>  	__blk_mq_run_hw_queue(hctx);
>  }
> -- 
> 2.7.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
