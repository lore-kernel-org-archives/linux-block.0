Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:53848 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdISTVu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 15:21:50 -0400
Received: by mail-pf0-f176.google.com with SMTP id x78so303786pff.10
        for <linux-block@vger.kernel.org>; Tue, 19 Sep 2017 12:21:50 -0700 (PDT)
Date: Tue, 19 Sep 2017 12:21:48 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 04/14] blk-mq-sched: move actual dispatching into one
 helper
Message-ID: <20170919192148.GB31219@vader.DHCP.thefacebook.com>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170902151729.6162-5-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 02, 2017 at 11:17:19PM +0800, Ming Lei wrote:
> So that it becomes easy to support to dispatch from
> sw queue in the following patch.
> 
> No functional change.
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sched.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 845e5baf8af1..f69752961a34 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -89,6 +89,22 @@ static bool blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
>  	return false;
>  }
>  
> +static void blk_mq_do_dispatch(struct request_queue *q,
> +			       struct elevator_queue *e,
> +			       struct blk_mq_hw_ctx *hctx)

You rename this to blk_mq_do_dispatch_sched() in the next patch, might
as well name it that way in the first place. Besides that,

Reviewed-by: Omar Sandoval <osandov@fb.com>

> +{
> +	LIST_HEAD(rq_list);
> +
> +	do {
> +		struct request *rq;
> +
> +		rq = e->type->ops.mq.dispatch_request(hctx);
> +		if (!rq)
> +			break;
> +		list_add(&rq->queuelist, &rq_list);
> +	} while (blk_mq_dispatch_rq_list(q, &rq_list));
> +}
> +
>  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct request_queue *q = hctx->queue;
> @@ -136,16 +152,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	 * on the dispatch list, OR if we did have work but weren't able
>  	 * to make progress.
>  	 */
> -	if (do_sched_dispatch && has_sched_dispatch) {
> -		do {
> -			struct request *rq;
> -
> -			rq = e->type->ops.mq.dispatch_request(hctx);
> -			if (!rq)
> -				break;
> -			list_add(&rq->queuelist, &rq_list);
> -		} while (blk_mq_dispatch_rq_list(q, &rq_list));
> -	}
> +	if (do_sched_dispatch && has_sched_dispatch)
> +		blk_mq_do_dispatch(q, e, hctx);
>  }
>  
>  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> -- 
> 2.9.5
> 
