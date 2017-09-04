Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170903134634.GA27411@localhost.didichuxing.com>
References: <20170903134634.GA27411@localhost.didichuxing.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 4 Sep 2017 18:02:36 +0800
Message-ID: <CACVXFVM43v40OOjCCdVk42=bsszXWcyEidScnmFDZ0OHVmn59A@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix nr_requests wrong value when modify it from sysfs
To: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sun, Sep 3, 2017 at 9:46 PM, weiping zhang
<zhangweiping@didichuxing.com> wrote:
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
>  block/blk-mq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f84d145..8303e5e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2622,8 +2622,11 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>                  * queue depth. This is similar to what the old code would do.
>                  */
>                 if (!hctx->sched_tags) {
> -                       ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
> -                                                       min(nr, set->queue_depth),
> +                       if (nr > set->queue_depth) {
> +                               nr = set->queue_depth;
> +                               pr_warn("reduce nr_request to %u\n", nr);
> +                       }
> +                       ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
>                                                         false);
>                 } else {
>                         ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,

Not sure if the pr_warn() is useful, but the idea is correct:

          Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
