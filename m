Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com> <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 17 Aug 2018 17:33:51 +0800
Message-ID: <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx mapping
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@linux.intel.com>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 17, 2018 at 11:54 AM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, when update nr_hw_queues, io scheduler's init_hctx will
> be invoked before the mapping between ctx and hctx is adapted
> correctly by blk_mq_map_swqueue. The io scheduler init_hctx (kyber)
> may depend on this mapping and get wrong result and panic finally.
> A simply way to fix this is switch the io scheduler to none before
> update the nr_hw_queues, and then get it back after update nr_hw_queues.
> To achieve this, we add a new member elv_type in request_queue to
> save the original elevator and adapt and export elevator_switch_mq.
> And also blk_mq_sched_init_/exit_hctx are removed due to nobody use
> them any more.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq-sched.c   | 44 --------------------------------------------
>  block/blk-mq-sched.h   |  5 -----
>  block/blk-mq.c         | 36 ++++++++++++++++++++++++++++--------
>  block/blk.h            |  2 ++
>  block/elevator.c       | 20 ++++++++++++--------
>  include/linux/blkdev.h |  3 +++
>  6 files changed, 45 insertions(+), 65 deletions(-)
>
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index cf9c66c..29bfe80 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -462,50 +462,6 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q)
>                 blk_mq_sched_free_tags(set, hctx, i);
>  }
>
> -int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> -                          unsigned int hctx_idx)
> -{
> -       struct elevator_queue *e = q->elevator;
> -       int ret;
> -
> -       if (!e)
> -               return 0;
> -
> -       ret = blk_mq_sched_alloc_tags(q, hctx, hctx_idx);
> -       if (ret)
> -               return ret;
> -
> -       if (e->type->ops.mq.init_hctx) {
> -               ret = e->type->ops.mq.init_hctx(hctx, hctx_idx);
> -               if (ret) {
> -                       blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
> -                       return ret;
> -               }
> -       }
> -
> -       blk_mq_debugfs_register_sched_hctx(q, hctx);
> -
> -       return 0;
> -}
> -
> -void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> -                           unsigned int hctx_idx)
> -{
> -       struct elevator_queue *e = q->elevator;
> -
> -       if (!e)
> -               return;
> -
> -       blk_mq_debugfs_unregister_sched_hctx(hctx);
> -
> -       if (e->type->ops.mq.exit_hctx && hctx->sched_data) {
> -               e->type->ops.mq.exit_hctx(hctx, hctx_idx);
> -               hctx->sched_data = NULL;
> -       }
> -
> -       blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
> -}
> -
>  int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>  {
>         struct blk_mq_hw_ctx *hctx;
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 0cb8f93..4e028ee 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -28,11 +28,6 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
>  int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
>  void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
>
> -int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> -                          unsigned int hctx_idx);
> -void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> -                           unsigned int hctx_idx);
> -
>  static inline bool
>  blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
>  {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5efd789..de7027f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2147,8 +2147,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>         if (set->ops->exit_request)
>                 set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
>
> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
> -
>         if (set->ops->exit_hctx)
>                 set->ops->exit_hctx(hctx, hctx_idx);
>
> @@ -2216,12 +2214,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
>             set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
>                 goto free_bitmap;
>
> -       if (blk_mq_sched_init_hctx(q, hctx, hctx_idx))
> -               goto exit_hctx;
> -
>         hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
>         if (!hctx->fq)
> -               goto sched_exit_hctx;
> +               goto exit_hctx;
>
>         if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
>                 goto free_fq;
> @@ -2235,8 +2230,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
>
>   free_fq:
>         kfree(hctx->fq);
> - sched_exit_hctx:
> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
>   exit_hctx:
>         if (set->ops->exit_hctx)
>                 set->ops->exit_hctx(hctx, hctx_idx);
> @@ -2913,6 +2906,25 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);
>
> +       /*
> +        * switch io scheduler to NULL to clean up the data in it.
> +        * will get it back after update mapping between cpu and hw queues.
> +        */
> +       list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +               if (!q->elevator) {
> +                       q->elv_type = NULL;
> +                       continue;
> +               }
> +               q->elv_type = q->elevator->type;
> +               mutex_lock(&q->sysfs_lock);
> +               /*
> +                * elevator_release will put it.
> +                */
> +               __module_get(q->elv_type->elevator_owner);

I understand what elevator_release() frees is the 'ref-counter' got in
elevator_get(), but who will be the counter-pair of the above  __module_get()?

Thanks,
Ming Lei
