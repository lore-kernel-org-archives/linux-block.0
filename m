Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 9 Aug 2018 10:30:54 +0800
Message-ID: <CACVXFVNLu+fDK3UKhVpWYe_+bZN9LQqcib5q=TkqcvgMZ9EQNw@mail.gmail.com>
Subject: Re: [PATCH V3] blk-mq: count the hctx as active before allocate tag
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 9, 2018 at 10:09 AM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, we count the hctx as active after allocate driver tag
> successfully. If a previously inactive hctx try to get tag first
> time, it may fails and need to wait. However, due to the stale tag
> ->active_queues, the other shared-tags users are still able to
> occupy all driver tags while there is someone waiting for tag.
> Consequently, even if the previously inactive hctx is waked up, it
> still may not be able to get a tag and could be starved.
>
> To fix it, we count the hctx as active before try to allocate driver
> tag, then when it is waiting the tag, the other shared-tag users
> will reserve budget for it.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>
> V3:
>   add more detailed comment
>
> V2:
>   only invoke blk_mq_tag_busy w/o io scheduler in blk_mq_get_request
>
>  block/blk-mq-tag.c | 3 +++
>  block/blk-mq.c     | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 09b2ee6..a8ebcbd 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -23,6 +23,9 @@ bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
>
>  /*
>   * If a previously inactive queue goes active, bump the active user count.
> + * We need to do this before try to allocate driver tag, then even if fail
> + * to get tag when first time, the other shared-tag users could reserve
> + * budget for it.
>   */
>  bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae44e85..75ac3fbd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -285,7 +285,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>                 rq->tag = -1;
>                 rq->internal_tag = tag;
>         } else {
> -               if (blk_mq_tag_busy(data->hctx)) {
> +               if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
>                         rq_flags = RQF_MQ_INFLIGHT;
>                         atomic_inc(&data->hctx->nr_active);
>                 }
> @@ -367,6 +367,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>                 if (!op_is_flush(op) && e->type->ops.mq.limit_depth &&
>                     !(data->flags & BLK_MQ_REQ_RESERVED))
>                         e->type->ops.mq.limit_depth(op, data);
> +       } else {
> +               blk_mq_tag_busy(data->hctx);
>         }
>
>         tag = blk_mq_get_tag(data);
> @@ -972,6 +974,7 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>                 .hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu),
>                 .flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
>         };
> +       bool shared;
>
>         might_sleep_if(wait);
>
> @@ -981,9 +984,10 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>         if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
>                 data.flags |= BLK_MQ_REQ_RESERVED;
>
> +       shared = blk_mq_tag_busy(data.hctx);
>         rq->tag = blk_mq_get_tag(&data);
>         if (rq->tag >= 0) {
> -               if (blk_mq_tag_busy(data.hctx)) {
> +               if (shared) {
>                         rq->rq_flags |= RQF_MQ_INFLIGHT;
>                         atomic_inc(&data.hctx->nr_active);
>                 }
> --
> 2.7.4
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming Lei
