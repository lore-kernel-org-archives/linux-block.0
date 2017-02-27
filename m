Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 27 Feb 2017 07:49:39 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq-sched: Allocate sched reserved tags as
 specified in the original queue tagset
Message-ID: <20170227154939.GA10715@vader>
References: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 27, 2017 at 05:36:20PM +0200, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq-sched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 98c7b061781e..46ca965fff5c 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -454,7 +454,8 @@ int blk_mq_sched_setup(struct request_queue *q)
>  	 */
>  	ret = 0;
>  	queue_for_each_hw_ctx(q, hctx, i) {
> -		hctx->sched_tags = blk_mq_alloc_rq_map(set, i, q->nr_requests, 0);
> +		hctx->sched_tags = blk_mq_alloc_rq_map(set, i,
> +				q->nr_requests, set->reserved_tags);
>  		if (!hctx->sched_tags) {
>  			ret = -ENOMEM;
>  			break;
> -- 
> 2.7.4

Hm, this may fix the crash, but I'm not sure it'll work as intended.
When we allocate the request, we'll get a reserved scheduler tag, but
then when we go to dispatch the request and call
blk_mq_get_driver_tag(), we'll be competing with all of the normal
requests for a regular driver tag. So maybe on top of this we should add
the BLK_MQ_REQ_RESERVED flag to the allocation attempt in
blk_mq_get_driver_tag() if the scheduler tag is reserved? I'm hazy on
what we expect from reserved tags, so feel free to call me crazy.
