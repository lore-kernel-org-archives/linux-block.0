Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX V2] block, bfq: update wr_busy_queues if needed on a queue split
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170619114316.2587-1-paolo.valente@linaro.org>
Date: Tue, 27 Jun 2017 08:09:34 +0200
Cc: linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 broonie@kernel.org
Message-Id: <8520D3AF-C161-439F-A7E8-A6B7202DA2D9@linaro.org>
References: <20170619114316.2587-1-paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 19 giu 2017, alle ore 13:43, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> This commit fixes a bug triggered by a non-trivial sequence of
> events. These events are briefly described in the next two
> paragraphs. The impatiens, or those who are familiar with queue
> merging and splitting, can jump directly to the last paragraph.
>=20
> On each I/O-request arrival for a shared bfq_queue, i.e., for a
> bfq_queue that is the result of the merge of two or more bfq_queues,
> BFQ checks whether the shared bfq_queue has become seeky (i.e., if too
> many random I/O requests have arrived for the bfq_queue; if the device
> is non rotational, then random requests must be also small for the
> bfq_queue to be tagged as seeky). If the shared bfq_queue is actually
> detected as seeky, then a split occurs: the bfq I/O context of the
> process that has issued the request is redirected from the shared
> bfq_queue to a new non-shared bfq_queue. As a degenerate case, if the
> shared bfq_queue actually happens to be shared only by one process
> (because of previous splits), then no new bfq_queue is created: the
> state of the shared bfq_queue is just changed from shared to non
> shared.
>=20
> Regardless of whether a brand new non-shared bfq_queue is created, or
> the pre-existing shared bfq_queue is just turned into a non-shared
> bfq_queue, several parameters of the non-shared bfq_queue are set
> (restored) to the original values they had when the bfq_queue
> associated with the bfq I/O context of the process (that has just
> issued an I/O request) was merged with the shared bfq_queue. One of
> these parameters is the weight-raising state.
>=20
> If, on the split of a shared bfq_queue,
> 1) a pre-existing shared bfq_queue is turned into a non-shared
> bfq_queue;
> 2) the previously shared bfq_queue happens to be busy;
> 3) the weight-raising state of the previously shared bfq_queue happens
> to change;
> the number of weight-raised busy queues changes. The field
> wr_busy_queues must then be updated accordingly, but such an update
> was missing. This commit adds the missing update.
>=20

Hi Jens,
any idea of the possible fate of this fix?

Thanks,
Paolo

> Reported-by: Luca Miccio <lucmiccio@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
> block/bfq-iosched.c | 21 ++++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ed93da2..bbeaf52 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -725,8 +725,12 @@ static void bfq_updated_next_req(struct bfq_data =
*bfqd,
> }
>=20
> static void
> -bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
> +bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
> +		      struct bfq_io_cq *bic, bool bfq_already_existing)
> {
> +	unsigned int old_wr_coeff =3D bfqq->wr_coeff;
> +	bool busy =3D bfq_already_existing && bfq_bfqq_busy(bfqq);
> +
> 	if (bic->saved_idle_window)
> 		bfq_mark_bfqq_idle_window(bfqq);
> 	else
> @@ -754,6 +758,14 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, =
struct bfq_io_cq *bic)
>=20
> 	/* make sure weight will be updated, however we got here */
> 	bfqq->entity.prio_changed =3D 1;
> +
> +	if (likely(!busy))
> +		return;
> +
> +	if (old_wr_coeff =3D=3D 1 && bfqq->wr_coeff > 1)
> +		bfqd->wr_busy_queues++;
> +	else if (old_wr_coeff > 1 && bfqq->wr_coeff =3D=3D 1)
> +		bfqd->wr_busy_queues--;
> }
>=20
> static int bfqq_process_refs(struct bfq_queue *bfqq)
> @@ -4402,7 +4414,7 @@ static int bfq_get_rq_private(struct =
request_queue *q, struct request *rq,
> 	const int is_sync =3D rq_is_sync(rq);
> 	struct bfq_queue *bfqq;
> 	bool new_queue =3D false;
> -	bool split =3D false;
> +	bool bfqq_already_existing =3D false, split =3D false;
>=20
> 	spin_lock_irq(&bfqd->lock);
>=20
> @@ -4432,6 +4444,8 @@ static int bfq_get_rq_private(struct =
request_queue *q, struct request *rq,
> 				bfqq =3D bfq_get_bfqq_handle_split(bfqd, =
bic, bio,
> 								 true, =
is_sync,
> 								 NULL);
> +			else
> +				bfqq_already_existing =3D true;
> 		}
> 	}
>=20
> @@ -4457,7 +4471,8 @@ static int bfq_get_rq_private(struct =
request_queue *q, struct request *rq,
> 			 * queue: restore the idle window and the
> 			 * possible weight raising period.
> 			 */
> -			bfq_bfqq_resume_state(bfqq, bic);
> +			bfq_bfqq_resume_state(bfqq, bfqd, bic,
> +					      bfqq_already_existing);
> 		}
> 	}
>=20
> --=20
> 2.10.0
>=20
