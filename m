Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 6/8] blk-mq-sched: add framework for MQ capable IO schedulers
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1481933536-12844-7-git-send-email-axboe@fb.com>
Date: Tue, 20 Dec 2016 12:55:04 +0100
Cc: axboe@kernel.dk,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 osandov@fb.com
Message-Id: <4A1753A0-121C-4A01-8821-6CDD99C98896@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <1481933536-12844-7-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> This adds a set of hooks that intercepts the blk-mq path of
> allocating/inserting/issuing/completing requests, allowing
> us to develop a scheduler within that framework.
>=20
> We reuse the existing elevator scheduler API on the registration
> side, but augment that with the scheduler flagging support for
> the blk-mq interfce, and with a separate set of ops hooks for MQ
> devices.
>=20
> Schedulers can opt in to using shadow requests. Shadow requests
> are internal requests that the scheduler uses for for the allocate
> and insert part, which are then mapped to a real driver request
> at dispatch time. This is needed to separate the device queue depth
> from the pool of requests that the scheduler has to work with.
>=20
> Signed-off-by: Jens Axboe <axboe@fb.com>

> ...
>=20
> +struct request *blk_mq_sched_get_request(struct request_queue *q,
> +					 struct bio *bio,
> +					 unsigned int op,
> +					 struct blk_mq_alloc_data *data)
> +{
> +	struct elevator_queue *e =3D q->elevator;
> +	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_ctx *ctx;
> +	struct request *rq;
> +
> +	blk_queue_enter_live(q);
> +	ctx =3D blk_mq_get_ctx(q);
> +	hctx =3D blk_mq_map_queue(q, ctx->cpu);
> +
> +	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
> +
> +	if (e && e->type->ops.mq.get_request)
> +		rq =3D e->type->ops.mq.get_request(q, op, data);

bio is not passed to the scheduler here.  Yet bfq uses bio to get the
blkcg (invoking bio_blkcg).  I'm not finding any workaround.

> +	else
> +		rq =3D __blk_mq_alloc_request(data, op);
> +
> +	if (rq) {
> +		rq->elv.icq =3D NULL;
> +		if (e && e->type->icq_cache)
> +			blk_mq_sched_assign_ioc(q, rq, bio);

bfq needs rq->elv.icq to be consistent in bfq_get_request, but the
needed initialization seems to occur only after mq.get_request is
invoked.

Note: to minimize latency, I'm reporting immediately each problem that
apparently cannot be solved by just modifying bfq.  But, if the
resulting higher number of micro-emails is annoying for you, I can
buffer my questions, and send you cumulative emails less frequently.

Thanks,
Paolo

> +		data->hctx->queued++;
> +		return rq;
> +	}
> +
> +	blk_queue_exit(q);
> +	return NULL;
> +}
> +
> +void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct elevator_queue *e =3D hctx->queue->elevator;
> +	LIST_HEAD(rq_list);
> +
> +	if (unlikely(blk_mq_hctx_stopped(hctx)))
> +		return;
> +
> +	hctx->run++;
> +
> +	/*
> +	 * If we have previous entries on our dispatch list, grab them =
first for
> +	 * more fair dispatch.
> +	 */
> +	if (!list_empty_careful(&hctx->dispatch)) {
> +		spin_lock(&hctx->lock);
> +		if (!list_empty(&hctx->dispatch))
> +			list_splice_init(&hctx->dispatch, &rq_list);
> +		spin_unlock(&hctx->lock);
> +	}
> +
> +	/*
> +	 * Only ask the scheduler for requests, if we didn't have =
residual
> +	 * requests from the dispatch list. This is to avoid the case =
where
> +	 * we only ever dispatch a fraction of the requests available =
because
> +	 * of low device queue depth. Once we pull requests out of the =
IO
> +	 * scheduler, we can no longer merge or sort them. So it's best =
to
> +	 * leave them there for as long as we can. Mark the hw queue as
> +	 * needing a restart in that case.
> +	 */
> +	if (list_empty(&rq_list)) {
> +		if (e && e->type->ops.mq.dispatch_requests)
> +			e->type->ops.mq.dispatch_requests(hctx, =
&rq_list);
> +		else
> +			blk_mq_flush_busy_ctxs(hctx, &rq_list);
> +	} else if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
> +		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
> +
> +	blk_mq_dispatch_rq_list(hctx, &rq_list);
> +}
> +
> +bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio)
> +{
> +	struct request *rq;
> +	int ret;
> +
> +	ret =3D elv_merge(q, &rq, bio);
> +	if (ret =3D=3D ELEVATOR_BACK_MERGE) {
> +		if (bio_attempt_back_merge(q, rq, bio)) {
> +			if (!attempt_back_merge(q, rq))
> +				elv_merged_request(q, rq, ret);
> +			return true;
> +		}
> +	} else if (ret =3D=3D ELEVATOR_FRONT_MERGE) {
> +		if (bio_attempt_front_merge(q, rq, bio)) {
> +			if (!attempt_front_merge(q, rq))
> +				elv_merged_request(q, rq, ret);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
> +
> +bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio =
*bio)
> +{
> +	struct elevator_queue *e =3D q->elevator;
> +
> +	if (e->type->ops.mq.bio_merge) {
> +		struct blk_mq_ctx *ctx =3D blk_mq_get_ctx(q);
> +		struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, =
ctx->cpu);
> +
> +		blk_mq_put_ctx(ctx);
> +		return e->type->ops.mq.bio_merge(hctx, bio);
> +	}
> +
> +	return false;
> +}
> +
> +bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct =
request *rq)
> +{
> +	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
> +
> +void blk_mq_sched_request_inserted(struct request *rq)
> +{
> +	trace_block_rq_insert(rq->q, rq);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> new file mode 100644
> index 000000000000..1d1a4e9ce6ca
> --- /dev/null
> +++ b/block/blk-mq-sched.h
> @@ -0,0 +1,209 @@
> +#ifndef BLK_MQ_SCHED_H
> +#define BLK_MQ_SCHED_H
> +
> +#include "blk-mq.h"
> +#include "blk-wbt.h"
> +
> +struct blk_mq_tags *blk_mq_sched_alloc_requests(unsigned int depth, =
unsigned int numa_node);
> +void blk_mq_sched_free_requests(struct blk_mq_tags *tags);
> +
> +int blk_mq_sched_init_hctx_data(struct request_queue *q, size_t size,
> +				int (*init)(struct blk_mq_hw_ctx *),
> +				void (*exit)(struct blk_mq_hw_ctx *));
> +
> +void blk_mq_sched_free_hctx_data(struct request_queue *q,
> +				 void (*exit)(struct blk_mq_hw_ctx *));
> +
> +void blk_mq_sched_free_shadow_request(struct blk_mq_tags *tags,
> +				      struct request *rq);
> +struct request *blk_mq_sched_alloc_shadow_request(struct =
request_queue *q,
> +						  struct =
blk_mq_alloc_data *data,
> +						  struct blk_mq_tags =
*tags,
> +						  atomic_t *wait_index);
> +struct request *
> +blk_mq_sched_request_from_shadow(struct blk_mq_hw_ctx *hctx,
> +				 struct request *(*get_sched_rq)(struct =
blk_mq_hw_ctx *));
> +struct request *
> +__blk_mq_sched_request_from_shadow(struct blk_mq_hw_ctx *hctx,
> +				   struct request *sched_rq);
> +
> +struct request *blk_mq_sched_get_request(struct request_queue *q, =
struct bio *bio, unsigned int op, struct blk_mq_alloc_data *data);
> +
> +void __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
> +void blk_mq_sched_request_inserted(struct request *rq);
> +bool blk_mq_sched_try_merge(struct request_queue *q, struct bio =
*bio);
> +bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio =
*bio);
> +bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct =
request *rq);
> +
> +void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
> +
> +static inline bool
> +blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
> +{
> +	struct elevator_queue *e =3D q->elevator;
> +
> +	if (!e || blk_queue_nomerges(q) || !bio_mergeable(bio))
> +		return false;
> +
> +	return __blk_mq_sched_bio_merge(q, bio);
> +}
> +
> +static inline int blk_mq_sched_get_rq_priv(struct request_queue *q,
> +					   struct request *rq)
> +{
> +	struct elevator_queue *e =3D q->elevator;
> +
> +	if (e && e->type->ops.mq.get_rq_priv)
> +		return e->type->ops.mq.get_rq_priv(q, rq);
> +
> +	return 0;
> +}
> +
> +static inline void blk_mq_sched_put_rq_priv(struct request_queue *q,
> +					    struct request *rq)
> +{
> +	struct elevator_queue *e =3D q->elevator;
> +
> +	if (e && e->type->ops.mq.put_rq_priv)
> +		e->type->ops.mq.put_rq_priv(q, rq);
> +}
> +
> +static inline void blk_mq_sched_put_request(struct request *rq)
> +{
> +	struct request_queue *q =3D rq->q;
> +	struct elevator_queue *e =3D q->elevator;
> +	bool do_free =3D true;
> +
> +	wbt_done(q->rq_wb, &rq->issue_stat);
> +
> +	if (rq->rq_flags & RQF_ELVPRIV) {
> +		blk_mq_sched_put_rq_priv(rq->q, rq);
> +		if (rq->elv.icq) {
> +			put_io_context(rq->elv.icq->ioc);
> +			rq->elv.icq =3D NULL;
> +		}
> +	}
> +
> +	if (e && e->type->ops.mq.put_request)
> +		do_free =3D !e->type->ops.mq.put_request(rq);
> +	if (do_free)
> +		blk_mq_finish_request(rq);
> +}
> +
> +static inline void
> +blk_mq_sched_insert_request(struct request *rq, bool at_head, bool =
run_queue,
> +			    bool async)
> +{
> +	struct request_queue *q =3D rq->q;
> +	struct elevator_queue *e =3D q->elevator;
> +	struct blk_mq_ctx *ctx =3D rq->mq_ctx;
> +	struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, ctx->cpu);
> +
> +	if (e && e->type->ops.mq.insert_requests) {
> +		LIST_HEAD(list);
> +
> +		list_add(&rq->queuelist, &list);
> +		e->type->ops.mq.insert_requests(hctx, &list, at_head);
> +	} else {
> +		spin_lock(&ctx->lock);
> +		__blk_mq_insert_request(hctx, rq, at_head);
> +		spin_unlock(&ctx->lock);
> +	}
> +
> +	if (run_queue)
> +		blk_mq_run_hw_queue(hctx, async);
> +}
> +
> +static inline void
> +blk_mq_sched_insert_requests(struct request_queue *q, struct =
blk_mq_ctx *ctx,
> +			     struct list_head *list, bool =
run_queue_async)
> +{
> +	struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, ctx->cpu);
> +	struct elevator_queue *e =3D hctx->queue->elevator;
> +
> +	if (e && e->type->ops.mq.insert_requests)
> +		e->type->ops.mq.insert_requests(hctx, list, false);
> +	else
> +		blk_mq_insert_requests(hctx, ctx, list);
> +
> +	blk_mq_run_hw_queue(hctx, run_queue_async);
> +}
> +
> +static inline void
> +blk_mq_sched_dispatch_shadow_requests(struct blk_mq_hw_ctx *hctx,
> +				      struct list_head *rq_list,
> +				      struct request =
*(*get_sched_rq)(struct blk_mq_hw_ctx *))
> +{
> +	do {
> +		struct request *rq;
> +
> +		rq =3D blk_mq_sched_request_from_shadow(hctx, =
get_sched_rq);
> +		if (!rq)
> +			break;
> +
> +		list_add_tail(&rq->queuelist, rq_list);
> +	} while (1);
> +}
> +
> +static inline bool
> +blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
> +			 struct bio *bio)
> +{
> +	struct elevator_queue *e =3D q->elevator;
> +
> +	if (e && e->type->ops.mq.allow_merge)
> +		return e->type->ops.mq.allow_merge(q, rq, bio);
> +
> +	return true;
> +}
> +
> +static inline void
> +blk_mq_sched_completed_request(struct blk_mq_hw_ctx *hctx, struct =
request *rq)
> +{
> +	struct elevator_queue *e =3D hctx->queue->elevator;
> +
> +	if (e && e->type->ops.mq.completed_request)
> +		e->type->ops.mq.completed_request(hctx, rq);
> +
> +	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
> +		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
> +		blk_mq_run_hw_queue(hctx, true);
> +	}
> +}
> +
> +static inline void blk_mq_sched_started_request(struct request *rq)
> +{
> +	struct request_queue *q =3D rq->q;
> +	struct elevator_queue *e =3D q->elevator;
> +
> +	if (e && e->type->ops.mq.started_request)
> +		e->type->ops.mq.started_request(rq);
> +}
> +
> +static inline void blk_mq_sched_requeue_request(struct request *rq)
> +{
> +	struct request_queue *q =3D rq->q;
> +	struct elevator_queue *e =3D q->elevator;
> +
> +	if (e && e->type->ops.mq.requeue_request)
> +		e->type->ops.mq.requeue_request(rq);
> +}
> +
> +static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct elevator_queue *e =3D hctx->queue->elevator;
> +
> +	if (e && e->type->ops.mq.has_work)
> +		return e->type->ops.mq.has_work(hctx);
> +
> +	return false;
> +}
> +
> +/*
> + * Returns true if this is an internal shadow request
> + */
> +static inline bool blk_mq_sched_rq_is_shadow(struct request *rq)
> +{
> +	return (rq->rq_flags & RQF_ALLOCED) !=3D 0;
> +}
> +#endif
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c3119f527bc1..032dca4a27bf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -32,6 +32,7 @@
> #include "blk-mq-tag.h"
> #include "blk-stat.h"
> #include "blk-wbt.h"
> +#include "blk-mq-sched.h"
>=20
> static DEFINE_MUTEX(all_q_mutex);
> static LIST_HEAD(all_q_list);
> @@ -41,7 +42,8 @@ static LIST_HEAD(all_q_list);
>  */
> static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
> {
> -	return sbitmap_any_bit_set(&hctx->ctx_map);
> +	return sbitmap_any_bit_set(&hctx->ctx_map) ||
> +		blk_mq_sched_has_work(hctx);
> }
>=20
> /*
> @@ -242,26 +244,21 @@ EXPORT_SYMBOL_GPL(__blk_mq_alloc_request);
> struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
> 		unsigned int flags)
> {
> -	struct blk_mq_ctx *ctx;
> -	struct blk_mq_hw_ctx *hctx;
> -	struct request *rq;
> 	struct blk_mq_alloc_data alloc_data;
> +	struct request *rq;
> 	int ret;
>=20
> 	ret =3D blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
> 	if (ret)
> 		return ERR_PTR(ret);
>=20
> -	ctx =3D blk_mq_get_ctx(q);
> -	hctx =3D blk_mq_map_queue(q, ctx->cpu);
> -	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
> -	rq =3D __blk_mq_alloc_request(&alloc_data, rw);
> -	blk_mq_put_ctx(ctx);
> +	rq =3D blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
>=20
> -	if (!rq) {
> -		blk_queue_exit(q);
> +	blk_mq_put_ctx(alloc_data.ctx);
> +	blk_queue_exit(q);
> +
> +	if (!rq)
> 		return ERR_PTR(-EWOULDBLOCK);
> -	}
>=20
> 	rq->__data_len =3D 0;
> 	rq->__sector =3D (sector_t) -1;
> @@ -321,12 +318,14 @@ struct request *blk_mq_alloc_request_hctx(struct =
request_queue *q, int rw,
> }
> EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
>=20
> -void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx, struct =
blk_mq_ctx *ctx,
> -			   struct request *rq)
> +void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct =
blk_mq_ctx *ctx,
> +			     struct request *rq)
> {
> 	const int tag =3D rq->tag;
> 	struct request_queue *q =3D rq->q;
>=20
> +	blk_mq_sched_completed_request(hctx, rq);
> +
> 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
> 		atomic_dec(&hctx->nr_active);
>=20
> @@ -339,18 +338,23 @@ void __blk_mq_free_request(struct blk_mq_hw_ctx =
*hctx, struct blk_mq_ctx *ctx,
> 	blk_queue_exit(q);
> }
>=20
> -static void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *hctx,
> +static void blk_mq_finish_hctx_request(struct blk_mq_hw_ctx *hctx,
> 				     struct request *rq)
> {
> 	struct blk_mq_ctx *ctx =3D rq->mq_ctx;
>=20
> 	ctx->rq_completed[rq_is_sync(rq)]++;
> -	__blk_mq_free_request(hctx, ctx, rq);
> +	__blk_mq_finish_request(hctx, ctx, rq);
> +}
> +
> +void blk_mq_finish_request(struct request *rq)
> +{
> +	blk_mq_finish_hctx_request(blk_mq_map_queue(rq->q, =
rq->mq_ctx->cpu), rq);
> }
>=20
> void blk_mq_free_request(struct request *rq)
> {
> -	blk_mq_free_hctx_request(blk_mq_map_queue(rq->q, =
rq->mq_ctx->cpu), rq);
> +	blk_mq_sched_put_request(rq);
> }
> EXPORT_SYMBOL_GPL(blk_mq_free_request);
>=20
> @@ -468,6 +472,8 @@ void blk_mq_start_request(struct request *rq)
> {
> 	struct request_queue *q =3D rq->q;
>=20
> +	blk_mq_sched_started_request(rq);
> +
> 	trace_block_rq_issue(q, rq);
>=20
> 	rq->resid_len =3D blk_rq_bytes(rq);
> @@ -516,6 +522,7 @@ static void __blk_mq_requeue_request(struct =
request *rq)
>=20
> 	trace_block_rq_requeue(q, rq);
> 	wbt_requeue(q->rq_wb, &rq->issue_stat);
> +	blk_mq_sched_requeue_request(rq);
>=20
> 	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
> 		if (q->dma_drain_size && blk_rq_bytes(rq))
> @@ -550,13 +557,13 @@ static void blk_mq_requeue_work(struct =
work_struct *work)
>=20
> 		rq->rq_flags &=3D ~RQF_SOFTBARRIER;
> 		list_del_init(&rq->queuelist);
> -		blk_mq_insert_request(rq, true, false, false);
> +		blk_mq_sched_insert_request(rq, true, false, false);
> 	}
>=20
> 	while (!list_empty(&rq_list)) {
> 		rq =3D list_entry(rq_list.next, struct request, =
queuelist);
> 		list_del_init(&rq->queuelist);
> -		blk_mq_insert_request(rq, false, false, false);
> +		blk_mq_sched_insert_request(rq, false, false, false);
> 	}
>=20
> 	blk_mq_run_hw_queues(q, false);
> @@ -762,8 +769,16 @@ static bool blk_mq_attempt_merge(struct =
request_queue *q,
>=20
> 		if (!blk_rq_merge_ok(rq, bio))
> 			continue;
> +		if (!blk_mq_sched_allow_merge(q, rq, bio))
> +			break;
>=20
> 		el_ret =3D blk_try_merge(rq, bio);
> +		if (el_ret =3D=3D ELEVATOR_NO_MERGE)
> +			continue;
> +
> +		if (!blk_mq_sched_allow_merge(q, rq, bio))
> +			break;
> +
> 		if (el_ret =3D=3D ELEVATOR_BACK_MERGE) {
> 			if (bio_attempt_back_merge(q, rq, bio)) {
> 				ctx->rq_merged++;
> @@ -905,41 +920,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx =
*hctx, struct list_head *list)
> 	return ret !=3D BLK_MQ_RQ_QUEUE_BUSY;
> }
>=20
> -/*
> - * Run this hardware queue, pulling any software queues mapped to it =
in.
> - * Note that this function currently has various problems around =
ordering
> - * of IO. In particular, we'd like FIFO behaviour on handling =
existing
> - * items on the hctx->dispatch list. Ignore that for now.
> - */
> -static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
> -{
> -	LIST_HEAD(rq_list);
> -	LIST_HEAD(driver_list);
> -
> -	if (unlikely(blk_mq_hctx_stopped(hctx)))
> -		return;
> -
> -	hctx->run++;
> -
> -	/*
> -	 * Touch any software queue that has pending entries.
> -	 */
> -	blk_mq_flush_busy_ctxs(hctx, &rq_list);
> -
> -	/*
> -	 * If we have previous entries on our dispatch list, grab them
> -	 * and stuff them at the front for more fair dispatch.
> -	 */
> -	if (!list_empty_careful(&hctx->dispatch)) {
> -		spin_lock(&hctx->lock);
> -		if (!list_empty(&hctx->dispatch))
> -			list_splice_init(&hctx->dispatch, &rq_list);
> -		spin_unlock(&hctx->lock);
> -	}
> -
> -	blk_mq_dispatch_rq_list(hctx, &rq_list);
> -}
> -
> static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> {
> 	int srcu_idx;
> @@ -949,11 +929,11 @@ static void __blk_mq_run_hw_queue(struct =
blk_mq_hw_ctx *hctx)
>=20
> 	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> 		rcu_read_lock();
> -		blk_mq_process_rq_list(hctx);
> +		blk_mq_sched_dispatch_requests(hctx);
> 		rcu_read_unlock();
> 	} else {
> 		srcu_idx =3D srcu_read_lock(&hctx->queue_rq_srcu);
> -		blk_mq_process_rq_list(hctx);
> +		blk_mq_sched_dispatch_requests(hctx);
> 		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
> 	}
> }
> @@ -1147,32 +1127,10 @@ void __blk_mq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
> 	blk_mq_hctx_mark_pending(hctx, ctx);
> }
>=20
> -void blk_mq_insert_request(struct request *rq, bool at_head, bool =
run_queue,
> -			   bool async)
> -{
> -	struct blk_mq_ctx *ctx =3D rq->mq_ctx;
> -	struct request_queue *q =3D rq->q;
> -	struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, ctx->cpu);
> -
> -	spin_lock(&ctx->lock);
> -	__blk_mq_insert_request(hctx, rq, at_head);
> -	spin_unlock(&ctx->lock);
> -
> -	if (run_queue)
> -		blk_mq_run_hw_queue(hctx, async);
> -}
> -
> -static void blk_mq_insert_requests(struct request_queue *q,
> -				     struct blk_mq_ctx *ctx,
> -				     struct list_head *list,
> -				     int depth,
> -				     bool from_schedule)
> +void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct =
blk_mq_ctx *ctx,
> +			    struct list_head *list)
>=20
> {
> -	struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, ctx->cpu);
> -
> -	trace_block_unplug(q, depth, !from_schedule);
> -
> 	/*
> 	 * preemption doesn't flush plug list, so it's possible ctx->cpu =
is
> 	 * offline now
> @@ -1188,8 +1146,6 @@ static void blk_mq_insert_requests(struct =
request_queue *q,
> 	}
> 	blk_mq_hctx_mark_pending(hctx, ctx);
> 	spin_unlock(&ctx->lock);
> -
> -	blk_mq_run_hw_queue(hctx, from_schedule);
> }
>=20
> static int plug_ctx_cmp(void *priv, struct list_head *a, struct =
list_head *b)
> @@ -1225,9 +1181,10 @@ void blk_mq_flush_plug_list(struct blk_plug =
*plug, bool from_schedule)
> 		BUG_ON(!rq->q);
> 		if (rq->mq_ctx !=3D this_ctx) {
> 			if (this_ctx) {
> -				blk_mq_insert_requests(this_q, this_ctx,
> -							&ctx_list, =
depth,
> -							from_schedule);
> +				trace_block_unplug(this_q, depth, =
from_schedule);
> +				blk_mq_sched_insert_requests(this_q, =
this_ctx,
> +								=
&ctx_list,
> +								=
from_schedule);
> 			}
>=20
> 			this_ctx =3D rq->mq_ctx;
> @@ -1244,8 +1201,9 @@ void blk_mq_flush_plug_list(struct blk_plug =
*plug, bool from_schedule)
> 	 * on 'ctx_list'. Do those.
> 	 */
> 	if (this_ctx) {
> -		blk_mq_insert_requests(this_q, this_ctx, &ctx_list, =
depth,
> -				       from_schedule);
> +		trace_block_unplug(this_q, depth, from_schedule);
> +		blk_mq_sched_insert_requests(this_q, this_ctx, =
&ctx_list,
> +						from_schedule);
> 	}
> }
>=20
> @@ -1283,46 +1241,32 @@ static inline bool =
blk_mq_merge_queue_io(struct blk_mq_hw_ctx *hctx,
> 		}
>=20
> 		spin_unlock(&ctx->lock);
> -		__blk_mq_free_request(hctx, ctx, rq);
> +		__blk_mq_finish_request(hctx, ctx, rq);
> 		return true;
> 	}
> }
>=20
> -static struct request *blk_mq_map_request(struct request_queue *q,
> -					  struct bio *bio,
> -					  struct blk_mq_alloc_data =
*data)
> -{
> -	struct blk_mq_hw_ctx *hctx;
> -	struct blk_mq_ctx *ctx;
> -	struct request *rq;
> -
> -	blk_queue_enter_live(q);
> -	ctx =3D blk_mq_get_ctx(q);
> -	hctx =3D blk_mq_map_queue(q, ctx->cpu);
> -
> -	trace_block_getrq(q, bio, bio->bi_opf);
> -	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
> -	rq =3D __blk_mq_alloc_request(data, bio->bi_opf);
> -
> -	data->hctx->queued++;
> -	return rq;
> -}
> -
> static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t =
*cookie)
> {
> -	int ret;
> 	struct request_queue *q =3D rq->q;
> -	struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, =
rq->mq_ctx->cpu);
> 	struct blk_mq_queue_data bd =3D {
> 		.rq =3D rq,
> 		.list =3D NULL,
> 		.last =3D 1
> 	};
> -	blk_qc_t new_cookie =3D blk_tag_to_qc_t(rq->tag, =
hctx->queue_num);
> +	struct blk_mq_hw_ctx *hctx;
> +	blk_qc_t new_cookie;
> +	int ret;
> +
> +	if (q->elevator)
> +		goto insert;
>=20
> +	hctx =3D blk_mq_map_queue(q, rq->mq_ctx->cpu);
> 	if (blk_mq_hctx_stopped(hctx))
> 		goto insert;
>=20
> +	new_cookie =3D blk_tag_to_qc_t(rq->tag, hctx->queue_num);
> +
> 	/*
> 	 * For OK queue, we are done. For error, kill it. Any other
> 	 * error (busy), just add it to our list as we previously
> @@ -1344,7 +1288,7 @@ static void blk_mq_try_issue_directly(struct =
request *rq, blk_qc_t *cookie)
> 	}
>=20
> insert:
> -	blk_mq_insert_request(rq, false, true, true);
> +	blk_mq_sched_insert_request(rq, false, true, true);
> }
>=20
> /*
> @@ -1377,9 +1321,14 @@ static blk_qc_t blk_mq_make_request(struct =
request_queue *q, struct bio *bio)
> 	    blk_attempt_plug_merge(q, bio, &request_count, =
&same_queue_rq))
> 		return BLK_QC_T_NONE;
>=20
> +	if (blk_mq_sched_bio_merge(q, bio))
> +		return BLK_QC_T_NONE;
> +
> 	wb_acct =3D wbt_wait(q->rq_wb, bio, NULL);
>=20
> -	rq =3D blk_mq_map_request(q, bio, &data);
> +	trace_block_getrq(q, bio, bio->bi_opf);
> +
> +	rq =3D blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
> 	if (unlikely(!rq)) {
> 		__wbt_done(q->rq_wb, wb_acct);
> 		return BLK_QC_T_NONE;
> @@ -1441,6 +1390,12 @@ static blk_qc_t blk_mq_make_request(struct =
request_queue *q, struct bio *bio)
> 		goto done;
> 	}
>=20
> +	if (q->elevator) {
> +		blk_mq_put_ctx(data.ctx);
> +		blk_mq_bio_to_request(rq, bio);
> +		blk_mq_sched_insert_request(rq, false, true, true);
> +		goto done;
> +	}
> 	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
> 		/*
> 		 * For a SYNC request, send it to the hardware =
immediately. For
> @@ -1486,9 +1441,14 @@ static blk_qc_t blk_sq_make_request(struct =
request_queue *q, struct bio *bio)
> 	} else
> 		request_count =3D blk_plug_queued_count(q);
>=20
> +	if (blk_mq_sched_bio_merge(q, bio))
> +		return BLK_QC_T_NONE;
> +
> 	wb_acct =3D wbt_wait(q->rq_wb, bio, NULL);
>=20
> -	rq =3D blk_mq_map_request(q, bio, &data);
> +	trace_block_getrq(q, bio, bio->bi_opf);
> +
> +	rq =3D blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
> 	if (unlikely(!rq)) {
> 		__wbt_done(q->rq_wb, wb_acct);
> 		return BLK_QC_T_NONE;
> @@ -1538,6 +1498,12 @@ static blk_qc_t blk_sq_make_request(struct =
request_queue *q, struct bio *bio)
> 		return cookie;
> 	}
>=20
> +	if (q->elevator) {
> +		blk_mq_put_ctx(data.ctx);
> +		blk_mq_bio_to_request(rq, bio);
> +		blk_mq_sched_insert_request(rq, false, true, true);
> +		goto done;
> +	}
> 	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
> 		/*
> 		 * For a SYNC request, send it to the hardware =
immediately. For
> @@ -1550,6 +1516,7 @@ static blk_qc_t blk_sq_make_request(struct =
request_queue *q, struct bio *bio)
> 	}
>=20
> 	blk_mq_put_ctx(data.ctx);
> +done:
> 	return cookie;
> }
>=20
> @@ -1558,7 +1525,7 @@ void blk_mq_free_rq_map(struct blk_mq_tag_set =
*set, struct blk_mq_tags *tags,
> {
> 	struct page *page;
>=20
> -	if (tags->rqs && set->ops->exit_request) {
> +	if (tags->rqs && set && set->ops->exit_request) {
> 		int i;
>=20
> 		for (i =3D 0; i < tags->nr_tags; i++) {
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index e59f5ca520a2..898c3c9a60ec 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -47,7 +47,8 @@ struct blk_mq_tags *blk_mq_init_rq_map(struct =
blk_mq_tag_set *set,
>  */
> void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct =
request *rq,
> 				bool at_head);
> -
> +void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct =
blk_mq_ctx *ctx,
> +				struct list_head *list);
> /*
>  * CPU hotplug helpers
>  */
> @@ -123,8 +124,9 @@ static inline void blk_mq_set_alloc_data(struct =
blk_mq_alloc_data *data,
>  */
> void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx =
*ctx,
> 			struct request *rq, unsigned int op);
> -void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx, struct =
blk_mq_ctx *ctx,
> +void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct =
blk_mq_ctx *ctx,
> 				struct request *rq);
> +void blk_mq_finish_request(struct request *rq);
> struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
> 					unsigned int op);
>=20
> diff --git a/block/elevator.c b/block/elevator.c
> index 022a26830297..e6b523360231 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -40,6 +40,7 @@
> #include <trace/events/block.h>
>=20
> #include "blk.h"
> +#include "blk-mq-sched.h"
>=20
> static DEFINE_SPINLOCK(elv_list_lock);
> static LIST_HEAD(elv_list);
> @@ -58,7 +59,9 @@ static int elv_iosched_allow_bio_merge(struct =
request *rq, struct bio *bio)
> 	struct request_queue *q =3D rq->q;
> 	struct elevator_queue *e =3D q->elevator;
>=20
> -	if (e->type->ops.sq.elevator_allow_bio_merge_fn)
> +	if (e->uses_mq && e->type->ops.mq.allow_merge)
> +		return e->type->ops.mq.allow_merge(q, rq, bio);
> +	else if (!e->uses_mq && =
e->type->ops.sq.elevator_allow_bio_merge_fn)
> 		return e->type->ops.sq.elevator_allow_bio_merge_fn(q, =
rq, bio);
>=20
> 	return 1;
> @@ -163,6 +166,7 @@ struct elevator_queue *elevator_alloc(struct =
request_queue *q,
> 	kobject_init(&eq->kobj, &elv_ktype);
> 	mutex_init(&eq->sysfs_lock);
> 	hash_init(eq->hash);
> +	eq->uses_mq =3D e->uses_mq;
>=20
> 	return eq;
> }
> @@ -219,12 +223,19 @@ int elevator_init(struct request_queue *q, char =
*name)
> 		if (!e) {
> 			printk(KERN_ERR
> 				"Default I/O scheduler not found. " \
> -				"Using noop.\n");
> +				"Using noop/none.\n");
> +			if (q->mq_ops) {
> +				elevator_put(e);
> +				return 0;
> +			}
> 			e =3D elevator_get("noop", false);
> 		}
> 	}
>=20
> -	err =3D e->ops.sq.elevator_init_fn(q, e);
> +	if (e->uses_mq)
> +		err =3D e->ops.mq.init_sched(q, e);
> +	else
> +		err =3D e->ops.sq.elevator_init_fn(q, e);
> 	if (err)
> 		elevator_put(e);
> 	return err;
> @@ -234,7 +245,9 @@ EXPORT_SYMBOL(elevator_init);
> void elevator_exit(struct elevator_queue *e)
> {
> 	mutex_lock(&e->sysfs_lock);
> -	if (e->type->ops.sq.elevator_exit_fn)
> +	if (e->uses_mq && e->type->ops.mq.exit_sched)
> +		e->type->ops.mq.exit_sched(e);
> +	else if (!e->uses_mq && e->type->ops.sq.elevator_exit_fn)
> 		e->type->ops.sq.elevator_exit_fn(e);
> 	mutex_unlock(&e->sysfs_lock);
>=20
> @@ -253,6 +266,7 @@ void elv_rqhash_del(struct request_queue *q, =
struct request *rq)
> 	if (ELV_ON_HASH(rq))
> 		__elv_rqhash_del(rq);
> }
> +EXPORT_SYMBOL_GPL(elv_rqhash_del);
>=20
> void elv_rqhash_add(struct request_queue *q, struct request *rq)
> {
> @@ -262,6 +276,7 @@ void elv_rqhash_add(struct request_queue *q, =
struct request *rq)
> 	hash_add(e->hash, &rq->hash, rq_hash_key(rq));
> 	rq->rq_flags |=3D RQF_HASHED;
> }
> +EXPORT_SYMBOL_GPL(elv_rqhash_add);
>=20
> void elv_rqhash_reposition(struct request_queue *q, struct request =
*rq)
> {
> @@ -443,7 +458,9 @@ int elv_merge(struct request_queue *q, struct =
request **req, struct bio *bio)
> 		return ELEVATOR_BACK_MERGE;
> 	}
>=20
> -	if (e->type->ops.sq.elevator_merge_fn)
> +	if (e->uses_mq && e->type->ops.mq.request_merge)
> +		return e->type->ops.mq.request_merge(q, req, bio);
> +	else if (!e->uses_mq && e->type->ops.sq.elevator_merge_fn)
> 		return e->type->ops.sq.elevator_merge_fn(q, req, bio);
>=20
> 	return ELEVATOR_NO_MERGE;
> @@ -456,8 +473,7 @@ int elv_merge(struct request_queue *q, struct =
request **req, struct bio *bio)
>  *
>  * Returns true if we merged, false otherwise
>  */
> -static bool elv_attempt_insert_merge(struct request_queue *q,
> -				     struct request *rq)
> +bool elv_attempt_insert_merge(struct request_queue *q, struct request =
*rq)
> {
> 	struct request *__rq;
> 	bool ret;
> @@ -495,7 +511,9 @@ void elv_merged_request(struct request_queue *q, =
struct request *rq, int type)
> {
> 	struct elevator_queue *e =3D q->elevator;
>=20
> -	if (e->type->ops.sq.elevator_merged_fn)
> +	if (e->uses_mq && e->type->ops.mq.request_merged)
> +		e->type->ops.mq.request_merged(q, rq, type);
> +	else if (!e->uses_mq && e->type->ops.sq.elevator_merged_fn)
> 		e->type->ops.sq.elevator_merged_fn(q, rq, type);
>=20
> 	if (type =3D=3D ELEVATOR_BACK_MERGE)
> @@ -508,10 +526,15 @@ void elv_merge_requests(struct request_queue *q, =
struct request *rq,
> 			     struct request *next)
> {
> 	struct elevator_queue *e =3D q->elevator;
> -	const int next_sorted =3D next->rq_flags & RQF_SORTED;
> -
> -	if (next_sorted && e->type->ops.sq.elevator_merge_req_fn)
> -		e->type->ops.sq.elevator_merge_req_fn(q, rq, next);
> +	bool next_sorted =3D false;
> +
> +	if (e->uses_mq && e->type->ops.mq.requests_merged)
> +		e->type->ops.mq.requests_merged(q, rq, next);
> +	else if (e->type->ops.sq.elevator_merge_req_fn) {
> +		next_sorted =3D next->rq_flags & RQF_SORTED;
> +		if (next_sorted)
> +			e->type->ops.sq.elevator_merge_req_fn(q, rq, =
next);
> +	}
>=20
> 	elv_rqhash_reposition(q, rq);
>=20
> @@ -528,6 +551,9 @@ void elv_bio_merged(struct request_queue *q, =
struct request *rq,
> {
> 	struct elevator_queue *e =3D q->elevator;
>=20
> +	if (WARN_ON_ONCE(e->uses_mq))
> +		return;
> +
> 	if (e->type->ops.sq.elevator_bio_merged_fn)
> 		e->type->ops.sq.elevator_bio_merged_fn(q, rq, bio);
> }
> @@ -682,8 +708,11 @@ struct request *elv_latter_request(struct =
request_queue *q, struct request *rq)
> {
> 	struct elevator_queue *e =3D q->elevator;
>=20
> -	if (e->type->ops.sq.elevator_latter_req_fn)
> +	if (e->uses_mq && e->type->ops.mq.next_request)
> +		return e->type->ops.mq.next_request(q, rq);
> +	else if (!e->uses_mq && e->type->ops.sq.elevator_latter_req_fn)
> 		return e->type->ops.sq.elevator_latter_req_fn(q, rq);
> +
> 	return NULL;
> }
>=20
> @@ -691,7 +720,9 @@ struct request *elv_former_request(struct =
request_queue *q, struct request *rq)
> {
> 	struct elevator_queue *e =3D q->elevator;
>=20
> -	if (e->type->ops.sq.elevator_former_req_fn)
> +	if (e->uses_mq && e->type->ops.mq.former_request)
> +		return e->type->ops.mq.former_request(q, rq);
> +	if (!e->uses_mq && e->type->ops.sq.elevator_former_req_fn)
> 		return e->type->ops.sq.elevator_former_req_fn(q, rq);
> 	return NULL;
> }
> @@ -701,6 +732,9 @@ int elv_set_request(struct request_queue *q, =
struct request *rq,
> {
> 	struct elevator_queue *e =3D q->elevator;
>=20
> +	if (WARN_ON_ONCE(e->uses_mq))
> +		return 0;
> +
> 	if (e->type->ops.sq.elevator_set_req_fn)
> 		return e->type->ops.sq.elevator_set_req_fn(q, rq, bio, =
gfp_mask);
> 	return 0;
> @@ -710,6 +744,9 @@ void elv_put_request(struct request_queue *q, =
struct request *rq)
> {
> 	struct elevator_queue *e =3D q->elevator;
>=20
> +	if (WARN_ON_ONCE(e->uses_mq))
> +		return;
> +
> 	if (e->type->ops.sq.elevator_put_req_fn)
> 		e->type->ops.sq.elevator_put_req_fn(rq);
> }
> @@ -718,6 +755,9 @@ int elv_may_queue(struct request_queue *q, =
unsigned int op)
> {
> 	struct elevator_queue *e =3D q->elevator;
>=20
> +	if (WARN_ON_ONCE(e->uses_mq))
> +		return 0;
> +
> 	if (e->type->ops.sq.elevator_may_queue_fn)
> 		return e->type->ops.sq.elevator_may_queue_fn(q, op);
>=20
> @@ -728,6 +768,9 @@ void elv_completed_request(struct request_queue =
*q, struct request *rq)
> {
> 	struct elevator_queue *e =3D q->elevator;
>=20
> +	if (WARN_ON_ONCE(e->uses_mq))
> +		return;
> +
> 	/*
> 	 * request is released from the driver, io must be done
> 	 */
> @@ -803,7 +846,7 @@ int elv_register_queue(struct request_queue *q)
> 		}
> 		kobject_uevent(&e->kobj, KOBJ_ADD);
> 		e->registered =3D 1;
> -		if (e->type->ops.sq.elevator_registered_fn)
> +		if (!e->uses_mq && =
e->type->ops.sq.elevator_registered_fn)
> 			e->type->ops.sq.elevator_registered_fn(q);
> 	}
> 	return error;
> @@ -891,9 +934,14 @@ EXPORT_SYMBOL_GPL(elv_unregister);
> static int elevator_switch(struct request_queue *q, struct =
elevator_type *new_e)
> {
> 	struct elevator_queue *old =3D q->elevator;
> -	bool registered =3D old->registered;
> +	bool old_registered =3D false;
> 	int err;
>=20
> +	if (q->mq_ops) {
> +		blk_mq_freeze_queue(q);
> +		blk_mq_quiesce_queue(q);
> +	}
> +
> 	/*
> 	 * Turn on BYPASS and drain all requests w/ elevator private =
data.
> 	 * Block layer doesn't call into a quiesced elevator - all =
requests
> @@ -901,32 +949,52 @@ static int elevator_switch(struct request_queue =
*q, struct elevator_type *new_e)
> 	 * using INSERT_BACK.  All requests have SOFTBARRIER set and no
> 	 * merge happens either.
> 	 */
> -	blk_queue_bypass_start(q);
> +	if (old) {
> +		old_registered =3D old->registered;
>=20
> -	/* unregister and clear all auxiliary data of the old elevator =
*/
> -	if (registered)
> -		elv_unregister_queue(q);
> +		if (!q->mq_ops)
> +			blk_queue_bypass_start(q);
>=20
> -	spin_lock_irq(q->queue_lock);
> -	ioc_clear_queue(q);
> -	spin_unlock_irq(q->queue_lock);
> +		/* unregister and clear all auxiliary data of the old =
elevator */
> +		if (old_registered)
> +			elv_unregister_queue(q);
> +
> +		spin_lock_irq(q->queue_lock);
> +		ioc_clear_queue(q);
> +		spin_unlock_irq(q->queue_lock);
> +	}
>=20
> 	/* allocate, init and register new elevator */
> -	err =3D new_e->ops.sq.elevator_init_fn(q, new_e);
> -	if (err)
> -		goto fail_init;
> +	if (new_e) {
> +		if (new_e->uses_mq)
> +			err =3D new_e->ops.mq.init_sched(q, new_e);
> +		else
> +			err =3D new_e->ops.sq.elevator_init_fn(q, =
new_e);
> +		if (err)
> +			goto fail_init;
>=20
> -	if (registered) {
> 		err =3D elv_register_queue(q);
> 		if (err)
> 			goto fail_register;
> -	}
> +	} else
> +		q->elevator =3D NULL;
>=20
> 	/* done, kill the old one and finish */
> -	elevator_exit(old);
> -	blk_queue_bypass_end(q);
> +	if (old) {
> +		elevator_exit(old);
> +		if (!q->mq_ops)
> +			blk_queue_bypass_end(q);
> +	}
> +
> +	if (q->mq_ops) {
> +		blk_mq_unfreeze_queue(q);
> +		blk_mq_start_stopped_hw_queues(q, true);
> +	}
>=20
> -	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
> +	if (new_e)
> +		blk_add_trace_msg(q, "elv switch: %s", =
new_e->elevator_name);
> +	else
> +		blk_add_trace_msg(q, "elv switch: none");
>=20
> 	return 0;
>=20
> @@ -934,9 +1002,16 @@ static int elevator_switch(struct request_queue =
*q, struct elevator_type *new_e)
> 	elevator_exit(q->elevator);
> fail_init:
> 	/* switch failed, restore and re-register old elevator */
> -	q->elevator =3D old;
> -	elv_register_queue(q);
> -	blk_queue_bypass_end(q);
> +	if (old) {
> +		q->elevator =3D old;
> +		elv_register_queue(q);
> +		if (!q->mq_ops)
> +			blk_queue_bypass_end(q);
> +	}
> +	if (q->mq_ops) {
> +		blk_mq_unfreeze_queue(q);
> +		blk_mq_start_stopped_hw_queues(q, true);
> +	}
>=20
> 	return err;
> }
> @@ -949,8 +1024,11 @@ static int __elevator_change(struct =
request_queue *q, const char *name)
> 	char elevator_name[ELV_NAME_MAX];
> 	struct elevator_type *e;
>=20
> -	if (!q->elevator)
> -		return -ENXIO;
> +	/*
> +	 * Special case for mq, turn off scheduling
> +	 */
> +	if (q->mq_ops && !strncmp(name, "none", 4))
> +		return elevator_switch(q, NULL);
>=20
> 	strlcpy(elevator_name, name, sizeof(elevator_name));
> 	e =3D elevator_get(strstrip(elevator_name), true);
> @@ -959,11 +1037,23 @@ static int __elevator_change(struct =
request_queue *q, const char *name)
> 		return -EINVAL;
> 	}
>=20
> -	if (!strcmp(elevator_name, q->elevator->type->elevator_name)) {
> +	if (q->elevator &&
> +	    !strcmp(elevator_name, q->elevator->type->elevator_name)) {
> 		elevator_put(e);
> 		return 0;
> 	}
>=20
> +	if (!e->uses_mq && q->mq_ops) {
> +		printk(KERN_ERR "blk-mq-sched: elv %s does not support =
mq\n", elevator_name);
> +		elevator_put(e);
> +		return -EINVAL;
> +	}
> +	if (e->uses_mq && !q->mq_ops) {
> +		printk(KERN_ERR "blk-mq-sched: elv %s is for mq\n", =
elevator_name);
> +		elevator_put(e);
> +		return -EINVAL;
> +	}
> +
> 	return elevator_switch(q, e);
> }
>=20
> @@ -985,7 +1075,7 @@ ssize_t elv_iosched_store(struct request_queue =
*q, const char *name,
> {
> 	int ret;
>=20
> -	if (!q->elevator)
> +	if (!q->mq_ops || q->request_fn)
> 		return count;
>=20
> 	ret =3D __elevator_change(q, name);
> @@ -999,24 +1089,34 @@ ssize_t elv_iosched_store(struct request_queue =
*q, const char *name,
> ssize_t elv_iosched_show(struct request_queue *q, char *name)
> {
> 	struct elevator_queue *e =3D q->elevator;
> -	struct elevator_type *elv;
> +	struct elevator_type *elv =3D NULL;
> 	struct elevator_type *__e;
> 	int len =3D 0;
>=20
> -	if (!q->elevator || !blk_queue_stackable(q))
> +	if (!blk_queue_stackable(q))
> 		return sprintf(name, "none\n");
>=20
> -	elv =3D e->type;
> +	if (!q->elevator)
> +		len +=3D sprintf(name+len, "[none] ");
> +	else
> +		elv =3D e->type;
>=20
> 	spin_lock(&elv_list_lock);
> 	list_for_each_entry(__e, &elv_list, list) {
> -		if (!strcmp(elv->elevator_name, __e->elevator_name))
> +		if (elv && !strcmp(elv->elevator_name, =
__e->elevator_name)) {
> 			len +=3D sprintf(name+len, "[%s] ", =
elv->elevator_name);
> -		else
> +			continue;
> +		}
> +		if (__e->uses_mq && q->mq_ops)
> +			len +=3D sprintf(name+len, "%s ", =
__e->elevator_name);
> +		else if (!__e->uses_mq && !q->mq_ops)
> 			len +=3D sprintf(name+len, "%s ", =
__e->elevator_name);
> 	}
> 	spin_unlock(&elv_list_lock);
>=20
> +	if (q->mq_ops && q->elevator)
> +		len +=3D sprintf(name+len, "none");
> +
> 	len +=3D sprintf(len+name, "\n");
> 	return len;
> }
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2686f9e7302a..e3159be841ff 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -22,6 +22,7 @@ struct blk_mq_hw_ctx {
>=20
> 	unsigned long		flags;		/* BLK_MQ_F_* flags */
>=20
> +	void			*sched_data;
> 	struct request_queue	*queue;
> 	struct blk_flush_queue	*fq;
>=20
> @@ -156,6 +157,7 @@ enum {
>=20
> 	BLK_MQ_S_STOPPED	=3D 0,
> 	BLK_MQ_S_TAG_ACTIVE	=3D 1,
> +	BLK_MQ_S_SCHED_RESTART	=3D 2,
>=20
> 	BLK_MQ_MAX_DEPTH	=3D 10240,
>=20
> @@ -179,7 +181,6 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set =
*set);
>=20
> void blk_mq_flush_plug_list(struct blk_plug *plug, bool =
from_schedule);
>=20
> -void blk_mq_insert_request(struct request *, bool, bool, bool);
> void blk_mq_free_request(struct request *rq);
> bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
>=20
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 2a9e966eed03..417810b2d2f5 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -77,6 +77,32 @@ struct elevator_ops
> 	elevator_registered_fn *elevator_registered_fn;
> };
>=20
> +struct blk_mq_alloc_data;
> +struct blk_mq_hw_ctx;
> +
> +struct elevator_mq_ops {
> +	int (*init_sched)(struct request_queue *, struct elevator_type =
*);
> +	void (*exit_sched)(struct elevator_queue *);
> +
> +	bool (*allow_merge)(struct request_queue *, struct request *, =
struct bio *);
> +	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);
> +	int (*request_merge)(struct request_queue *q, struct request **, =
struct bio *);
> +	void (*request_merged)(struct request_queue *, struct request *, =
int);
> +	void (*requests_merged)(struct request_queue *, struct request =
*, struct request *);
> +	struct request *(*get_request)(struct request_queue *, unsigned =
int, struct blk_mq_alloc_data *);
> +	bool (*put_request)(struct request *);
> +	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head =
*, bool);
> +	void (*dispatch_requests)(struct blk_mq_hw_ctx *, struct =
list_head *);
> +	bool (*has_work)(struct blk_mq_hw_ctx *);
> +	void (*completed_request)(struct blk_mq_hw_ctx *, struct request =
*);
> +	void (*started_request)(struct request *);
> +	void (*requeue_request)(struct request *);
> +	struct request *(*former_request)(struct request_queue *, struct =
request *);
> +	struct request *(*next_request)(struct request_queue *, struct =
request *);
> +	int (*get_rq_priv)(struct request_queue *, struct request *);
> +	void (*put_rq_priv)(struct request_queue *, struct request *);
> +};
> +
> #define ELV_NAME_MAX	(16)
>=20
> struct elv_fs_entry {
> @@ -96,12 +122,14 @@ struct elevator_type
> 	/* fields provided by elevator implementation */
> 	union {
> 		struct elevator_ops sq;
> +		struct elevator_mq_ops mq;
> 	} ops;
> 	size_t icq_size;	/* see iocontext.h */
> 	size_t icq_align;	/* ditto */
> 	struct elv_fs_entry *elevator_attrs;
> 	char elevator_name[ELV_NAME_MAX];
> 	struct module *elevator_owner;
> +	bool uses_mq;
>=20
> 	/* managed by elevator core */
> 	char icq_cache_name[ELV_NAME_MAX + 5];	/* elvname + "_io_cq" */
> @@ -125,6 +153,7 @@ struct elevator_queue
> 	struct kobject kobj;
> 	struct mutex sysfs_lock;
> 	unsigned int registered:1;
> +	unsigned int uses_mq:1;
> 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
> };
>=20
> @@ -141,6 +170,7 @@ extern void elv_merge_requests(struct =
request_queue *, struct request *,
> extern void elv_merged_request(struct request_queue *, struct request =
*, int);
> extern void elv_bio_merged(struct request_queue *q, struct request *,
> 				struct bio *);
> +extern bool elv_attempt_insert_merge(struct request_queue *, struct =
request *);
> extern void elv_requeue_request(struct request_queue *, struct request =
*);
> extern struct request *elv_former_request(struct request_queue *, =
struct request *);
> extern struct request *elv_latter_request(struct request_queue *, =
struct request *);
> --=20
> 2.7.4
>=20
