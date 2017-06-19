Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 09/10] blk-mq-sched: unify request prepare methods
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170616161527.17649-10-hch@lst.de>
Date: Mon, 19 Jun 2017 15:32:09 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Omar Sandoval <osandov@fb.com>,
 linux-block@vger.kernel.org
Message-Id: <462C0809-EDD7-4FBB-A6F9-B8C8155A4335@linaro.org>
References: <20170616161527.17649-1-hch@lst.de> <20170616161527.17649-10-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 16 giu 2017, alle ore 18:15, Christoph Hellwig <hch@lst.de> =
ha scritto:
>=20
> This patch makes sure we always allocate requests in the core blk-mq
> code and use a common prepare_request method to initialize them for
> both mq I/O schedulers.  For Kyber and additional limit_depth method
> is added that is called before allocating the request.
>=20
> Also because none of the intializations can really fail the new method
> does not return an error - instead the bfq finish method is hardened
> to deal with the no-IOC case.
>=20
> Last but not least this removes the abuse of RQF_QUEUE by the blk-mq
> scheduling code as RQF_ELFPRIV is all that is needed now.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/bfq-iosched.c      | 19 ++++++++++++-------
> block/blk-mq.c           | 22 ++++++----------------
> block/kyber-iosched.c    | 23 +++++++++++------------
> include/linux/elevator.h |  4 ++--
> 4 files changed, 31 insertions(+), 37 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index f037b005faa1..60d32700f104 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4292,8 +4292,14 @@ static void bfq_put_rq_priv_body(struct =
bfq_queue *bfqq)
>=20
> static void bfq_finish_request(struct request *rq)
> {
> -	struct bfq_queue *bfqq =3D RQ_BFQQ(rq);
> -	struct bfq_data *bfqd =3D bfqq->bfqd;
> +	struct bfq_queue *bfqq;
> +	struct bfq_data *bfqd;
> +
> +	if (!rq->elv.icq)
> +		return;
> +

If this is a rq dispatched from a bfqq (or even a request still in the
scheduler), then just exiting here will break bfq state seriously.
However, I guess that this case can never occur.

If this is a rq dispatched from the bfqd->dispatch list, then exiting
here should only unbalance the bfqd->rq_in_driver counter.

I guess that in both cases there wouldn't be problems for the missing
reset of the content of rq->elv.priv (if the function terminates
here).

If I can be of further help in some way, I'm willing to help.

Thanks,
Paolo

> +	bfqq =3D RQ_BFQQ(rq);
> +	bfqd =3D bfqq->bfqd;
>=20
> 	if (rq->rq_flags & RQF_STARTED)
> 		bfqg_stats_update_completion(bfqq_group(bfqq),
> @@ -4394,9 +4400,9 @@ static struct bfq_queue =
*bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
> /*
>  * Allocate bfq data structures associated with this request.
>  */
> -static int bfq_get_rq_private(struct request_queue *q, struct request =
*rq,
> -			      struct bio *bio)
> +static void bfq_prepare_request(struct request *rq, struct bio *bio)
> {
> +	struct request_queue *q =3D rq->q;
> 	struct bfq_data *bfqd =3D q->elevator->elevator_data;
> 	struct bfq_io_cq *bic;
> 	const int is_sync =3D rq_is_sync(rq);
> @@ -4405,7 +4411,7 @@ static int bfq_get_rq_private(struct =
request_queue *q, struct request *rq,
> 	bool split =3D false;
>=20
> 	if (!rq->elv.icq)
> -		return 1;
> +		return;
> 	bic =3D icq_to_bic(rq->elv.icq);
>=20
> 	spin_lock_irq(&bfqd->lock);
> @@ -4466,7 +4472,6 @@ static int bfq_get_rq_private(struct =
request_queue *q, struct request *rq,
> 		bfq_handle_burst(bfqd, bfqq);
>=20
> 	spin_unlock_irq(&bfqd->lock);
> -	return 0;
> }
>=20
> static void bfq_idle_slice_timer_body(struct bfq_queue *bfqq)
> @@ -4945,7 +4950,7 @@ static struct elv_fs_entry bfq_attrs[] =3D {
>=20
> static struct elevator_type iosched_bfq_mq =3D {
> 	.ops.mq =3D {
> -		.get_rq_priv		=3D bfq_get_rq_private,
> +		.prepare_request	=3D bfq_prepare_request,
> 		.finish_request		=3D bfq_finish_request,
> 		.exit_icq		=3D bfq_exit_icq,
> 		.insert_requests	=3D bfq_insert_requests,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2f380ab7a603..81d05c19d4b3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -298,16 +298,11 @@ static struct request *blk_mq_get_request(struct =
request_queue *q,
> 		 * Flush requests are special and go directly to the
> 		 * dispatch list.
> 		 */
> -		if (!op_is_flush(op) && e->type->ops.mq.get_request) {
> -			rq =3D e->type->ops.mq.get_request(q, op, data);
> -			if (rq)
> -				rq->rq_flags |=3D RQF_QUEUED;
> -			goto allocated;
> -		}
> +		if (!op_is_flush(op) && e->type->ops.mq.limit_depth)
> +			e->type->ops.mq.limit_depth(op, data);
> 	}
>=20
> 	rq =3D __blk_mq_alloc_request(data, op);
> -allocated:
> 	if (!rq) {
> 		blk_queue_exit(q);
> 		return NULL;
> @@ -315,17 +310,12 @@ static struct request *blk_mq_get_request(struct =
request_queue *q,
>=20
> 	if (!op_is_flush(op)) {
> 		rq->elv.icq =3D NULL;
> -		if (e && e->type->ops.mq.get_rq_priv) {
> +		if (e && e->type->ops.mq.prepare_request) {
> 			if (e->type->icq_cache && rq_ioc(bio))
> 				blk_mq_sched_assign_ioc(rq, bio);
>=20
> -			if (e->type->ops.mq.get_rq_priv(q, rq, bio)) {
> -				if (rq->elv.icq)
> -					=
put_io_context(rq->elv.icq->ioc);
> -				rq->elv.icq =3D NULL;
> -			} else {
> -				rq->rq_flags |=3D RQF_ELVPRIV;
> -			}
> +			e->type->ops.mq.prepare_request(rq, bio);
> +			rq->rq_flags |=3D RQF_ELVPRIV;
> 		}
> 	}
> 	data->hctx->queued++;
> @@ -413,7 +403,7 @@ void blk_mq_free_request(struct request *rq)
> 	struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, ctx->cpu);
> 	const int sched_tag =3D rq->internal_tag;
>=20
> -	if (rq->rq_flags & (RQF_ELVPRIV | RQF_QUEUED)) {
> +	if (rq->rq_flags & RQF_ELVPRIV) {
> 		if (e && e->type->ops.mq.finish_request)
> 			e->type->ops.mq.finish_request(rq);
> 		if (rq->elv.icq) {
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index 2557b399f0a8..a9f6fd3fab8e 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -426,24 +426,22 @@ static void rq_clear_domain_token(struct =
kyber_queue_data *kqd,
> 	}
> }
>=20
> -static struct request *kyber_get_request(struct request_queue *q,
> -					 unsigned int op,
> -					 struct blk_mq_alloc_data *data)
> +static void kyber_limit_depth(unsigned int op, struct =
blk_mq_alloc_data *data)
> {
> -	struct kyber_queue_data *kqd =3D q->elevator->elevator_data;
> -	struct request *rq;
> -
> 	/*
> 	 * We use the scheduler tags as per-hardware queue queueing =
tokens.
> 	 * Async requests can be limited at this stage.
> 	 */
> -	if (!op_is_sync(op))
> +	if (!op_is_sync(op)) {
> +		struct kyber_queue_data *kqd =3D =
data->q->elevator->elevator_data;
> +
> 		data->shallow_depth =3D kqd->async_depth;
> +	}
> +}
>=20
> -	rq =3D __blk_mq_alloc_request(data, op);
> -	if (rq)
> -		rq_set_domain_token(rq, -1);
> -	return rq;
> +static void kyber_prepare_request(struct request *rq, struct bio =
*bio)
> +{
> +	rq_set_domain_token(rq, -1);
> }
>=20
> static void kyber_finish_request(struct request *rq)
> @@ -813,7 +811,8 @@ static struct elevator_type kyber_sched =3D {
> 		.exit_sched =3D kyber_exit_sched,
> 		.init_hctx =3D kyber_init_hctx,
> 		.exit_hctx =3D kyber_exit_hctx,
> -		.get_request =3D kyber_get_request,
> +		.limit_depth =3D kyber_limit_depth,
> +		.prepare_request =3D kyber_prepare_request,
> 		.finish_request =3D kyber_finish_request,
> 		.completed_request =3D kyber_completed_request,
> 		.dispatch_request =3D kyber_dispatch_request,
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 4acea351d43f..5bc8f8682a3e 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -104,7 +104,8 @@ struct elevator_mq_ops {
> 	int (*request_merge)(struct request_queue *q, struct request **, =
struct bio *);
> 	void (*request_merged)(struct request_queue *, struct request *, =
enum elv_merge);
> 	void (*requests_merged)(struct request_queue *, struct request =
*, struct request *);
> -	struct request *(*get_request)(struct request_queue *, unsigned =
int, struct blk_mq_alloc_data *);
> +	void (*limit_depth)(unsigned int, struct blk_mq_alloc_data *);
> +	void (*prepare_request)(struct request *, struct bio *bio);
> 	void (*finish_request)(struct request *);
> 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head =
*, bool);
> 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
> @@ -114,7 +115,6 @@ struct elevator_mq_ops {
> 	void (*requeue_request)(struct request *);
> 	struct request *(*former_request)(struct request_queue *, struct =
request *);
> 	struct request *(*next_request)(struct request_queue *, struct =
request *);
> -	int (*get_rq_priv)(struct request_queue *, struct request *, =
struct bio *);
> 	void (*init_icq)(struct io_cq *);
> 	void (*exit_icq)(struct io_cq *);
> };
> --=20
> 2.11.0
>=20
