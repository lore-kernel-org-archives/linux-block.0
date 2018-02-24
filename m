Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/2] blk-mq: don't call io sched's .requeue_request when
 requeueing rq to ->dispatch
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20180223153657.17376-2-ming.lei@redhat.com>
Date: Sat, 24 Feb 2018 17:17:05 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>,
 linux-block@vger.kernel.org,
 Omar Sandoval <osandov@fb.com>,
 oleksandr@natalenko.name,
 holger@applied-asynchrony.com
Message-Id: <0EE812FD-DA1D-49AB-97FE-EF48BDAE8452@linaro.org>
References: <20180223153657.17376-1-ming.lei@redhat.com>
 <20180223153657.17376-2-ming.lei@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 23 feb 2018, alle ore 16:36, Ming Lei <ming.lei@redhat.com> =
ha scritto:
>=20
> __blk_mq_requeue_request() covers two cases:
>=20
> - one is that the requeued request is added to hctx->dispatch, such as
> blk_mq_dispatch_rq_list()
>=20
> - another case is that the request is requeued to io scheduler, such =
as
> blk_mq_requeue_request().
>=20
> We should call io sched's .requeue_request callback only for the 2nd
> case.
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Cc: Paolo Valente <paolo.valente@linaro.org>
> Cc: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> block/blk-mq.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 357492712b0e..16e83e6df404 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -712,7 +712,6 @@ static void __blk_mq_requeue_request(struct =
request *rq)
>=20
> 	trace_block_rq_requeue(q, rq);
> 	wbt_requeue(q->rq_wb, &rq->issue_stat);
> -	blk_mq_sched_requeue_request(rq);
>=20
> 	if (blk_mq_rq_state(rq) !=3D MQ_RQ_IDLE) {
> 		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
> @@ -725,6 +724,9 @@ void blk_mq_requeue_request(struct request *rq, =
bool kick_requeue_list)
> {
> 	__blk_mq_requeue_request(rq);
>=20
> +	/* this request will be re-inserted to io scheduler queue */
> +	blk_mq_sched_requeue_request(rq);
> +
> 	BUG_ON(blk_queued_rq(rq));
> 	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
> }
> --=20
> 2.9.5
>=20
