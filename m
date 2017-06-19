Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 04/10] blk-mq-sched: unify request finished methods
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170616161527.17649-5-hch@lst.de>
Date: Mon, 19 Jun 2017 15:01:30 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Omar Sandoval <osandov@fb.com>,
 linux-block@vger.kernel.org
Message-Id: <1FBA3CC4-A7C3-4461-84DF-73F0D400C810@linaro.org>
References: <20170616161527.17649-1-hch@lst.de> <20170616161527.17649-5-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 16 giu 2017, alle ore 18:15, Christoph Hellwig <hch@lst.de> =
ha scritto:
>=20
> No need to have two different callouts of bfq vs kyber.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/bfq-iosched.c      |  6 +++---
> block/blk-mq.c           | 11 ++++-------
> block/kyber-iosched.c    |  8 +++-----
> include/linux/elevator.h |  3 +--
> 4 files changed, 11 insertions(+), 17 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ed93da2462ab..4f69e39c2f89 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4290,7 +4290,7 @@ static void bfq_put_rq_priv_body(struct =
bfq_queue *bfqq)
> 	bfq_put_queue(bfqq);
> }
>=20
> -static void bfq_put_rq_private(struct request_queue *q, struct =
request *rq)
> +static void bfq_finish_request(struct request *rq)
> {
> 	struct bfq_queue *bfqq =3D RQ_BFQQ(rq);
> 	struct bfq_data *bfqd =3D bfqq->bfqd;
> @@ -4324,7 +4324,7 @@ static void bfq_put_rq_private(struct =
request_queue *q, struct request *rq)
> 		 */
>=20
> 		if (!RB_EMPTY_NODE(&rq->rb_node))
> -			bfq_remove_request(q, rq);
> +			bfq_remove_request(rq->q, rq);
> 		bfq_put_rq_priv_body(bfqq);
> 	}
>=20
> @@ -4951,7 +4951,7 @@ static struct elv_fs_entry bfq_attrs[] =3D {
> static struct elevator_type iosched_bfq_mq =3D {
> 	.ops.mq =3D {
> 		.get_rq_priv		=3D bfq_get_rq_private,
> -		.put_rq_priv		=3D bfq_put_rq_private,
> +		.finish_request		=3D bfq_finish_request,
> 		.exit_icq		=3D bfq_exit_icq,
> 		.insert_requests	=3D bfq_insert_requests,
> 		.dispatch_request	=3D bfq_dispatch_request,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1a45c287db64..9df7e0394a48 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -437,19 +437,16 @@ void blk_mq_free_request(struct request *rq)
> 	struct request_queue *q =3D rq->q;
> 	struct elevator_queue *e =3D q->elevator;
>=20
> -	if (rq->rq_flags & RQF_ELVPRIV) {
> -		if (e && e->type->ops.mq.put_rq_priv)
> -			e->type->ops.mq.put_rq_priv(q, rq);
> +	if (rq->rq_flags & (RQF_ELVPRIV | RQF_QUEUED)) {
> +		if (e && e->type->ops.mq.finish_request)
> +			e->type->ops.mq.finish_request(rq);
> 		if (rq->elv.icq) {
> 			put_io_context(rq->elv.icq->ioc);
> 			rq->elv.icq =3D NULL;
> 		}
> 	}
>=20
> -	if ((rq->rq_flags & RQF_QUEUED) && e && =
e->type->ops.mq.put_request)
> -		e->type->ops.mq.put_request(rq);
> -	else
> -		blk_mq_finish_request(rq);
> +	blk_mq_finish_request(rq);
> }

My only concern is that this last change is, and will remain,
functionally equivalent to the previous version of the code (choice
between put_request and finish_request).  In fact, bfq doesn't use
put_request at all, and, in former bfq_put_rq_private assumes that
rq->elv.priv is still properly set.  If this change enjoys, as it
seems to me, this invariance, then, for the part related to bfq,

Acked-by: Paolo Valente <paolo.valente@linaro.org>


> EXPORT_SYMBOL_GPL(blk_mq_free_request);
>=20
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index b9faabc75fdb..2557b399f0a8 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -446,13 +446,11 @@ static struct request *kyber_get_request(struct =
request_queue *q,
> 	return rq;
> }
>=20
> -static void kyber_put_request(struct request *rq)
> +static void kyber_finish_request(struct request *rq)
> {
> -	struct request_queue *q =3D rq->q;
> -	struct kyber_queue_data *kqd =3D q->elevator->elevator_data;
> +	struct kyber_queue_data *kqd =3D rq->q->elevator->elevator_data;
>=20
> 	rq_clear_domain_token(kqd, rq);
> -	blk_mq_finish_request(rq);
> }
>=20
> static void kyber_completed_request(struct request *rq)
> @@ -816,7 +814,7 @@ static struct elevator_type kyber_sched =3D {
> 		.init_hctx =3D kyber_init_hctx,
> 		.exit_hctx =3D kyber_exit_hctx,
> 		.get_request =3D kyber_get_request,
> -		.put_request =3D kyber_put_request,
> +		.finish_request =3D kyber_finish_request,
> 		.completed_request =3D kyber_completed_request,
> 		.dispatch_request =3D kyber_dispatch_request,
> 		.has_work =3D kyber_has_work,
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 0e306c5a86d6..4acea351d43f 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -105,7 +105,7 @@ struct elevator_mq_ops {
> 	void (*request_merged)(struct request_queue *, struct request *, =
enum elv_merge);
> 	void (*requests_merged)(struct request_queue *, struct request =
*, struct request *);
> 	struct request *(*get_request)(struct request_queue *, unsigned =
int, struct blk_mq_alloc_data *);
> -	void (*put_request)(struct request *);
> +	void (*finish_request)(struct request *);
> 	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head =
*, bool);
> 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
> 	bool (*has_work)(struct blk_mq_hw_ctx *);
> @@ -115,7 +115,6 @@ struct elevator_mq_ops {
> 	struct request *(*former_request)(struct request_queue *, struct =
request *);
> 	struct request *(*next_request)(struct request_queue *, struct =
request *);
> 	int (*get_rq_priv)(struct request_queue *, struct request *, =
struct bio *);
> -	void (*put_rq_priv)(struct request_queue *, struct request *);
> 	void (*init_icq)(struct io_cq *);
> 	void (*exit_icq)(struct io_cq *);
> };
> --=20
> 2.11.0
>=20
