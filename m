Return-Path: <ming.lei@redhat.com>
Date: Mon, 16 Apr 2018 16:15:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: mark hctx RESTART when get budget fails
Message-ID: <20180416081503.GB23664@ming.t460p>
References: <1523865336-17326-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523865336-17326-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 16, 2018 at 03:55:36PM +0800, Jianchao Wang wrote:
> When get budget fails, blk_mq_sched_dispatch_requests does not do
> anything to ensure the hctx to be restarted. We can survive from
> this, because only the scsi implements .get_budget and it always
> runs the hctx queues when request is completed.

Exactly, that is why we don't handle the failure before dequeuing
request.

I suggest to just document this usage now.

> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq-sched.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 25c14c5..49e7cd9 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -102,8 +102,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  				!e->type->ops.mq.has_work(hctx))
>  			break;
>  
> -		if (!blk_mq_get_dispatch_budget(hctx))
> +		if (!blk_mq_get_dispatch_budget(hctx)) {
> +			blk_mq_sched_mark_restart_hctx(hctx);

The RESTART flag still may not take into effect if all requests are
completed before calling blk_mq_sched_mark_restart_hctx().

>  			break;
> +		}
>  
>  		rq = e->type->ops.mq.dispatch_request(hctx);
>  		if (!rq) {
> @@ -148,8 +150,10 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
>  		if (!sbitmap_any_bit_set(&hctx->ctx_map))
>  			break;
>  
> -		if (!blk_mq_get_dispatch_budget(hctx))
> +		if (!blk_mq_get_dispatch_budget(hctx)) {
> +			blk_mq_sched_mark_restart_hctx(hctx);

Same with above.

Thanks,
Ming
