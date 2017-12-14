Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH V2] block, bfq: remove batches of confusing ifdefs
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20171204104205.3290-1-paolo.valente@linaro.org>
Date: Thu, 14 Dec 2017 07:10:30 +0100
Cc: linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 broonie@kernel.org,
 linus.walleij@linaro.org,
 lucmiccio@gmail.com
Message-Id: <2C37D091-F207-4E9E-B8A8-06BDCDF47A28@linaro.org>
References: <20171204104205.3290-1-paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,
do you think this version could be ok?

Thanks,
Paolo

> Il giorno 04 dic 2017, alle ore 11:42, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Commit a33801e8b473 ("block, bfq: move debug blkio stats behind
> CONFIG_DEBUG_BLK_CGROUP") introduced two batches of confusing ifdefs:
> one reported in [1], plus a similar one in another function. This
> commit removes both batches, in the way suggested in [1].
>=20
> [1] https://www.spinics.net/lists/linux-block/msg20043.html
>=20
> Fixes: a33801e8b473 ("block, bfq: move debug blkio stats behind =
CONFIG_DEBUG_BLK_CGROUP")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Luca Miccio <lucmiccio@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
> block/bfq-iosched.c | 127 =
+++++++++++++++++++++++++++++-----------------------
> 1 file changed, 72 insertions(+), 55 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index bcb6d21..3feed64 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -3689,35 +3689,16 @@ static struct request =
*__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> 	return rq;
> }
>=20
> -static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
> -{
> -	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
> -	struct request *rq;
> #if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> -	struct bfq_queue *in_serv_queue, *bfqq;
> -	bool waiting_rq, idle_timer_disabled;
> -#endif
> -
> -	spin_lock_irq(&bfqd->lock);
> -
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> -	in_serv_queue =3D bfqd->in_service_queue;
> -	waiting_rq =3D in_serv_queue && =
bfq_bfqq_wait_request(in_serv_queue);
> -
> -	rq =3D __bfq_dispatch_request(hctx);
> -
> -	idle_timer_disabled =3D
> -		waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
> -
> -#else
> -	rq =3D __bfq_dispatch_request(hctx);
> -#endif
> -	spin_unlock_irq(&bfqd->lock);
> +static void bfq_update_dispatch_stats(struct request_queue *q,
> +				      struct request *rq,
> +				      struct bfq_queue *in_serv_queue,
> +				      bool idle_timer_disabled)
> +{
> +	struct bfq_queue *bfqq =3D rq ? RQ_BFQQ(rq) : NULL;
>=20
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> -	bfqq =3D rq ? RQ_BFQQ(rq) : NULL;
> 	if (!idle_timer_disabled && !bfqq)
> -		return rq;
> +		return;
>=20
> 	/*
> 	 * rq and bfqq are guaranteed to exist until this function
> @@ -3732,7 +3713,7 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> 	 * In addition, the following queue lock guarantees that
> 	 * bfqq_group(bfqq) exists as well.
> 	 */
> -	spin_lock_irq(hctx->queue->queue_lock);
> +	spin_lock_irq(q->queue_lock);
> 	if (idle_timer_disabled)
> 		/*
> 		 * Since the idle timer has been disabled,
> @@ -3751,9 +3732,37 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> 		bfqg_stats_set_start_empty_time(bfqg);
> 		bfqg_stats_update_io_remove(bfqg, rq->cmd_flags);
> 	}
> -	spin_unlock_irq(hctx->queue->queue_lock);
> +	spin_unlock_irq(q->queue_lock);
> +}
> +#else
> +static inline void bfq_update_dispatch_stats(struct request_queue *q,
> +					     struct request *rq,
> +					     struct bfq_queue =
*in_serv_queue,
> +					     bool idle_timer_disabled) =
{}
> #endif
>=20
> +static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
> +{
> +	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
> +	struct request *rq;
> +	struct bfq_queue *in_serv_queue;
> +	bool waiting_rq, idle_timer_disabled;
> +
> +	spin_lock_irq(&bfqd->lock);
> +
> +	in_serv_queue =3D bfqd->in_service_queue;
> +	waiting_rq =3D in_serv_queue && =
bfq_bfqq_wait_request(in_serv_queue);
> +
> +	rq =3D __bfq_dispatch_request(hctx);
> +
> +	idle_timer_disabled =3D
> +		waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
> +
> +	spin_unlock_irq(&bfqd->lock);
> +
> +	bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
> +				  idle_timer_disabled);
> +
> 	return rq;
> }
>=20
> @@ -4276,16 +4285,46 @@ static bool __bfq_insert_request(struct =
bfq_data *bfqd, struct request *rq)
> 	return idle_timer_disabled;
> }
>=20
> +#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> +static void bfq_update_insert_stats(struct request_queue *q,
> +				    struct bfq_queue *bfqq,
> +				    bool idle_timer_disabled,
> +				    unsigned int cmd_flags)
> +{
> +	if (!bfqq)
> +		return;
> +
> +	/*
> +	 * bfqq still exists, because it can disappear only after
> +	 * either it is merged with another queue, or the process it
> +	 * is associated with exits. But both actions must be taken by
> +	 * the same process currently executing this flow of
> +	 * instructions.
> +	 *
> +	 * In addition, the following queue lock guarantees that
> +	 * bfqq_group(bfqq) exists as well.
> +	 */
> +	spin_lock_irq(q->queue_lock);
> +	bfqg_stats_update_io_add(bfqq_group(bfqq), bfqq, cmd_flags);
> +	if (idle_timer_disabled)
> +		bfqg_stats_update_idle_time(bfqq_group(bfqq));
> +	spin_unlock_irq(q->queue_lock);
> +}
> +#else
> +static inline void bfq_update_insert_stats(struct request_queue *q,
> +					   struct bfq_queue *bfqq,
> +					   bool idle_timer_disabled,
> +					   unsigned int cmd_flags) {}
> +#endif
> +
> static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct =
request *rq,
> 			       bool at_head)
> {
> 	struct request_queue *q =3D hctx->queue;
> 	struct bfq_data *bfqd =3D q->elevator->elevator_data;
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> 	struct bfq_queue *bfqq =3D RQ_BFQQ(rq);
> 	bool idle_timer_disabled =3D false;
> 	unsigned int cmd_flags;
> -#endif
>=20
> 	spin_lock_irq(&bfqd->lock);
> 	if (blk_mq_sched_try_insert_merge(q, rq)) {
> @@ -4304,7 +4343,6 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
> 		else
> 			list_add_tail(&rq->queuelist, &bfqd->dispatch);
> 	} else {
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> 		idle_timer_disabled =3D __bfq_insert_request(bfqd, rq);
> 		/*
> 		 * Update bfqq, because, if a queue merge has occurred
> @@ -4312,9 +4350,6 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
> 		 * redirected into a new queue.
> 		 */
> 		bfqq =3D RQ_BFQQ(rq);
> -#else
> -		__bfq_insert_request(bfqd, rq);
> -#endif
>=20
> 		if (rq_mergeable(rq)) {
> 			elv_rqhash_add(q, rq);
> @@ -4323,35 +4358,17 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
> 		}
> 	}
>=20
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> 	/*
> 	 * Cache cmd_flags before releasing scheduler lock, because rq
> 	 * may disappear afterwards (for example, because of a request
> 	 * merge).
> 	 */
> 	cmd_flags =3D rq->cmd_flags;
> -#endif
> +
> 	spin_unlock_irq(&bfqd->lock);
>=20
> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> -	if (!bfqq)
> -		return;
> -	/*
> -	 * bfqq still exists, because it can disappear only after
> -	 * either it is merged with another queue, or the process it
> -	 * is associated with exits. But both actions must be taken by
> -	 * the same process currently executing this flow of
> -	 * instruction.
> -	 *
> -	 * In addition, the following queue lock guarantees that
> -	 * bfqq_group(bfqq) exists as well.
> -	 */
> -	spin_lock_irq(q->queue_lock);
> -	bfqg_stats_update_io_add(bfqq_group(bfqq), bfqq, cmd_flags);
> -	if (idle_timer_disabled)
> -		bfqg_stats_update_idle_time(bfqq_group(bfqq));
> -	spin_unlock_irq(q->queue_lock);
> -#endif
> +	bfq_update_insert_stats(q, bfqq, idle_timer_disabled,
> +				cmd_flags);
> }
>=20
> static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
> --=20
> 2.10.0
>=20
