Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:12941 "EHLO
        BJEXCAS008.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756087AbdKCSGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Nov 2017 14:06:51 -0400
Date: Sat, 4 Nov 2017 02:06:42 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH v4] blk-mq: fix nr_requests wrong value when modify it
 from sysfs
Message-ID: <20171103180642.GA13051@localhost.didichuxing.com>
References: <20170922153624.GA15873@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170922153624.GA15873@localhost.didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 22, 2017 at 11:36:28PM +0800, weiping zhang wrote:
> if blk-mq use "none" io scheduler, nr_request get a wrong value when
> input a number > tag_set->queue_depth. blk_mq_tag_update_depth will get
> the smaller one min(nr, set->queue_depth), and then q->nr_request get a
> wrong value.
> 
> Reproduce:
> 
> echo none > /sys/block/nvme0n1/queue/scheduler
> echo 1000000 > /sys/block/nvme0n1/queue/nr_requests
> cat /sys/block/nvme0n1/queue/nr_requests
> 1000000
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
> 
> Changes since v4:
>  * fix typo in commit message(queue/ioscheduler => queue/scheduler)
> 
> Changes since v3:
>  * remove compare nr with tags->qdepth, pass nr to blk_mq_tag_update_depth
> directly
> 
>  * remove return EINVAL when user modify nr_request less than BLKDEV_MIN_RQ
> 
> Changes since v2:
>  * add return EINVAL when user modify nr_request less than BLKDEV_MIN_RQ
>  * remove pr_warn, and return EINVAL, if input number is too large
> 
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 98a1860..491e336 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2642,8 +2642,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  		 * queue depth. This is similar to what the old code would do.
>  		 */
>  		if (!hctx->sched_tags) {
> -			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
> -							min(nr, set->queue_depth),
> +			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
>  							false);
>  		} else {
>  			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> -- 
> 2.9.4
> 
Hello Jens,

ping
