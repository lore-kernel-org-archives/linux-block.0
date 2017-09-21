Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/2] blk-mq: fix nr_requests wrong value when modify it
 from sysfs
To: weiping zhang <zhangweiping@didichuxing.com>
References: <cover.1506006064.git.zhangweiping@didichuxing.com>
 <0dcb22e96bf2c3064c88dd554d6ac9eb95991a54.1506006064.git.zhangweiping@didichuxing.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ec64c9c3-fbdf-53c3-358d-370272f4baa6@kernel.dk>
Date: Thu, 21 Sep 2017 10:37:48 -0600
MIME-Version: 1.0
In-Reply-To: <0dcb22e96bf2c3064c88dd554d6ac9eb95991a54.1506006064.git.zhangweiping@didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/21/2017 09:17 AM, weiping zhang wrote:
> if blk-mq use "none" io scheduler, nr_request get a wrong value when
> input a number > tag_set->queue_depth. blk_mq_tag_update_depth will get
> the smaller one min(nr, set->queue_depth), and then q->nr_request get a
> wrong value.
> 
> Reproduce:
> 
> echo none > /sys/block/nvme0n1/queue/ioscheduler
> echo 1000000 > /sys/block/nvme0n1/queue/nr_requests
> cat /sys/block/nvme0n1/queue/nr_requests
> 1000000
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  block/blk-mq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 98a1860..479c35a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2642,8 +2642,12 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  		 * queue depth. This is similar to what the old code would do.
>  		 */
>  		if (!hctx->sched_tags) {
> -			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
> -							min(nr, set->queue_depth),
> +			if (nr > set->queue_depth) {
> +				ret = -EINVAL;
> +				break;
> +			}
> +
> +			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
>  							false);

What am I missing here? blk_mq_tag_update_depth() should already return
-EINVAL for the case where we can't grow the tags. Looks like this patch
should simply remove the min(nr, set->queue_depth) and just pass in 'nr'.
Should not need the duplicated check for depth.

-- 
Jens Axboe
