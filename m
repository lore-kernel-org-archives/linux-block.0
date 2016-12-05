Return-Path: <ming.lei@canonical.com>
MIME-Version: 1.0
In-Reply-To: <1480734921-23701-2-git-send-email-axboe@fb.com>
References: <1480734921-23701-1-git-send-email-axboe@fb.com> <1480734921-23701-2-git-send-email-axboe@fb.com>
From: Ming Lei <ming.lei@canonical.com>
Date: Tue, 6 Dec 2016 01:00:45 +0800
Message-ID: <CACVXFVOeEmcNGcw8-==2FEOx5r8D90aqj24op+fNfwLr6uR_aw@mail.gmail.com>
Subject: Re: [PATCH 1/7] block: use legacy path for flush requests for MQ with
 a scheduler
To: Jens Axboe <axboe@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	paolo.valente@linaro.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Sat, Dec 3, 2016 at 11:15 AM, Jens Axboe <axboe@fb.com> wrote:
> No functional changes with this patch, it's just in preparation for
> supporting legacy schedulers on blk-mq.
>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-core.c  |  2 +-
>  block/blk-exec.c  |  2 +-
>  block/blk-flush.c | 26 ++++++++++++++------------
>  block/blk.h       | 12 +++++++++++-
>  4 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 3f2eb8d80189..0e23589ab3bf 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1310,7 +1310,7 @@ static struct request *blk_old_get_request(struct request_queue *q, int rw,
>
>  struct request *blk_get_request(struct request_queue *q, int rw, gfp_t gfp_mask)
>  {
> -       if (q->mq_ops)
> +       if (blk_use_mq_path(q))
>                 return blk_mq_alloc_request(q, rw,
>                         (gfp_mask & __GFP_DIRECT_RECLAIM) ?
>                                 0 : BLK_MQ_REQ_NOWAIT);

Another way might be to use mq allocator to allocate rq in case of mq_sched,
such as: just replace mempool_alloc in __get_request() with
blk_mq_alloc_request(), in this way, it should be possible to
avoid one extra rq allocation in blk_mq_sched_dispatch(), and keep mq's benefit
of rq preallocation, which can avoid to hold queue_lock during the
allocation too.

> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index 3ecb00a6cf45..73b8a701ae6d 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -64,7 +64,7 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
>          * don't check dying flag for MQ because the request won't
>          * be reused after dying flag is set
>          */
> -       if (q->mq_ops) {
> +       if (blk_use_mq_path(q)) {
>                 blk_mq_insert_request(rq, at_head, true, false);
>                 return;
>         }
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 1bdbb3d3e5f5..0b68a1258bdd 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -133,14 +133,16 @@ static void blk_flush_restore_request(struct request *rq)
>
>  static bool blk_flush_queue_rq(struct request *rq, bool add_front)
>  {
> -       if (rq->q->mq_ops) {
> +       struct request_queue *q = rq->q;
> +
> +       if (blk_use_mq_path(q)) {
>                 blk_mq_add_to_requeue_list(rq, add_front, true);
>                 return false;
>         } else {
>                 if (add_front)
> -                       list_add(&rq->queuelist, &rq->q->queue_head);
> +                       list_add(&rq->queuelist, &q->queue_head);
>                 else
> -                       list_add_tail(&rq->queuelist, &rq->q->queue_head);
> +                       list_add_tail(&rq->queuelist, &q->queue_head);
>                 return true;
>         }
>  }
> @@ -201,7 +203,7 @@ static bool blk_flush_complete_seq(struct request *rq,
>                 BUG_ON(!list_empty(&rq->queuelist));
>                 list_del_init(&rq->flush.list);
>                 blk_flush_restore_request(rq);
> -               if (q->mq_ops)
> +               if (blk_use_mq_path(q))
>                         blk_mq_end_request(rq, error);
>                 else
>                         __blk_end_request_all(rq, error);
> @@ -224,7 +226,7 @@ static void flush_end_io(struct request *flush_rq, int error)
>         unsigned long flags = 0;
>         struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
>
> -       if (q->mq_ops) {
> +       if (blk_use_mq_path(q)) {
>                 struct blk_mq_hw_ctx *hctx;
>
>                 /* release the tag's ownership to the req cloned from */
> @@ -240,7 +242,7 @@ static void flush_end_io(struct request *flush_rq, int error)
>         /* account completion of the flush request */
>         fq->flush_running_idx ^= 1;
>
> -       if (!q->mq_ops)
> +       if (!blk_use_mq_path(q))
>                 elv_completed_request(q, flush_rq);
>
>         /* and push the waiting requests to the next stage */
> @@ -267,7 +269,7 @@ static void flush_end_io(struct request *flush_rq, int error)
>                 blk_run_queue_async(q);
>         }
>         fq->flush_queue_delayed = 0;
> -       if (q->mq_ops)
> +       if (blk_use_mq_path(q))
>                 spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>  }
>
> @@ -315,7 +317,7 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
>          * be in flight at the same time. And acquire the tag's
>          * ownership for flush req.
>          */
> -       if (q->mq_ops) {
> +       if (blk_use_mq_path(q)) {
>                 struct blk_mq_hw_ctx *hctx;
>
>                 flush_rq->mq_ctx = first_rq->mq_ctx;
> @@ -409,7 +411,7 @@ void blk_insert_flush(struct request *rq)
>          * complete the request.
>          */
>         if (!policy) {
> -               if (q->mq_ops)
> +               if (blk_use_mq_path(q))
>                         blk_mq_end_request(rq, 0);
>                 else
>                         __blk_end_bidi_request(rq, 0, 0, 0);
> @@ -425,9 +427,9 @@ void blk_insert_flush(struct request *rq)
>          */
>         if ((policy & REQ_FSEQ_DATA) &&
>             !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
> -               if (q->mq_ops) {
> +               if (blk_use_mq_path(q))
>                         blk_mq_insert_request(rq, false, false, true);
> -               } else
> +               else
>                         list_add_tail(&rq->queuelist, &q->queue_head);
>                 return;
>         }
> @@ -440,7 +442,7 @@ void blk_insert_flush(struct request *rq)
>         INIT_LIST_HEAD(&rq->flush.list);
>         rq->rq_flags |= RQF_FLUSH_SEQ;
>         rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
> -       if (q->mq_ops) {
> +       if (blk_use_mq_path(q)) {
>                 rq->end_io = mq_flush_data_end_io;
>
>                 spin_lock_irq(&fq->mq_flush_lock);
> diff --git a/block/blk.h b/block/blk.h
> index 041185e5f129..094fc10429c3 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -36,10 +36,20 @@ extern struct kmem_cache *request_cachep;
>  extern struct kobj_type blk_queue_ktype;
>  extern struct ida blk_queue_ida;
>
> +/*
> + * Use the MQ path if we have mq_ops, but not if we are using an IO
> + * scheduler. For the scheduler, we should use the legacy path. Only
> + * for internal use in the block layer.
> + */
> +static inline bool blk_use_mq_path(struct request_queue *q)
> +{
> +       return q->mq_ops && !q->elevator;
> +}
> +
>  static inline struct blk_flush_queue *blk_get_flush_queue(
>                 struct request_queue *q, struct blk_mq_ctx *ctx)
>  {
> -       if (q->mq_ops)
> +       if (blk_use_mq_path(q))
>                 return blk_mq_map_queue(q, ctx->cpu)->fq;
>         return q->fq;
>  }
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
