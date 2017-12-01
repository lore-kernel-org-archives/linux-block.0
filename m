Return-Path: <ming.lei@redhat.com>
Date: Fri, 1 Dec 2017 10:58:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/7] blk-mq: Avoid that request processing stalls when
 sharing tags
Message-ID: <20171201025803.GA29741@ming.t460p>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
 <20171201000848.2656-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171201000848.2656-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 30, 2017 at 04:08:45PM -0800, Bart Van Assche wrote:
> blk_mq_sched_mark_restart_hctx() must be called before

Could you please describe the theory on commit log? Like, why is it
a must? and what is the issue to be fixed? 

> blk_mq_dispatch_rq_list() is called. Make sure that
> BLK_MQ_S_SCHED_RESTART is set before any blk_mq_dispatch_rq_list()
> call occurs.
> 
> Fixes: commit b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")

We always mark RESTART state bit just before dispatching from ->dispatch_list,
this way has been there before b347689ffbca, which doesn't change this
RESTART mechanism, so please explain a bit why it is a fix on commit
b347689ffbca.

> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-mq-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index d8e3533d3218..c4e0cb5f6f1f 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -208,8 +208,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	 * on the dispatch list or we were able to dispatch from the
>  	 * dispatch list.
>  	 */
> +	blk_mq_sched_mark_restart_hctx(hctx);

This looks over-kill.

It means RESTART has to be done from request's completion after each new dispatch.

>  	if (!list_empty(&rq_list)) {
> -		blk_mq_sched_mark_restart_hctx(hctx);
>  		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
>  			if (has_sched_dispatch)
>  				blk_mq_do_dispatch_sched(hctx);
> -- 
> 2.15.0
> 

-- 
Ming
