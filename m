Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 07/10] bfq-iosched: fix NULL ioc check in bfq_get_rq_private
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170616161527.17649-8-hch@lst.de>
Date: Mon, 19 Jun 2017 15:14:11 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Omar Sandoval <osandov@fb.com>,
 linux-block@vger.kernel.org
Message-Id: <C0AC0C7F-B9BE-4A02-9289-3AA811A3C169@linaro.org>
References: <20170616161527.17649-1-hch@lst.de> <20170616161527.17649-8-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 16 giu 2017, alle ore 18:15, Christoph Hellwig <hch@lst.de> =
ha scritto:
>=20
> icq_to_bic is a container_of operation, so we need to check for NULL
> before it.  Also move the check outside the spinlock while we're at
> it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/bfq-iosched.c | 15 +++++----------
> 1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 4f69e39c2f89..f037b005faa1 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4398,16 +4398,17 @@ static int bfq_get_rq_private(struct =
request_queue *q, struct request *rq,
> 			      struct bio *bio)
> {
> 	struct bfq_data *bfqd =3D q->elevator->elevator_data;
> -	struct bfq_io_cq *bic =3D icq_to_bic(rq->elv.icq);
> +	struct bfq_io_cq *bic;
> 	const int is_sync =3D rq_is_sync(rq);
> 	struct bfq_queue *bfqq;
> 	bool new_queue =3D false;
> 	bool split =3D false;
>=20
> -	spin_lock_irq(&bfqd->lock);

Thanks for taking a step I feared here (basically for cowardice) ...

> +	if (!rq->elv.icq)
> +		return 1;
> +	bic =3D icq_to_bic(rq->elv.icq);
>=20
> -	if (!bic)
> -		goto queue_fail;
> +	spin_lock_irq(&bfqd->lock);
>=20
> 	bfq_check_ioprio_change(bic, bio);
>=20
> @@ -4465,13 +4466,7 @@ static int bfq_get_rq_private(struct =
request_queue *q, struct request *rq,
> 		bfq_handle_burst(bfqd, bfqq);
>=20
> 	spin_unlock_irq(&bfqd->lock);
> -
> 	return 0;
> -
> -queue_fail:
> -	spin_unlock_irq(&bfqd->lock);
> -
> -	return 1;
> }
>=20
> static void bfq_idle_slice_timer_body(struct bfq_queue *bfqq)
> --=20
> 2.11.0
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>
