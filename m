Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] block, bfq: remove batches of confusing ifdefs
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5892a41d-4677-937a-a56e-5d4554724dd6@kernel.dk>
Date: Sat, 2 Dec 2017 11:04:37 +0100
Cc: linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 broonie@kernel.org,
 linus.walleij@linaro.org,
 lucmiccio@gmail.com,
 bfq-iosched@googlegroups.com
Message-Id: <5B4C446D-99EB-4698-B86A-5629AADA3D7B@linaro.org>
References: <20171128093734.1918-1-paolo.valente@linaro.org> <5892a41d-4677-937a-a56e-5d4554724dd6@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 30 nov 2017, alle ore 22:21, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 11/28/2017 02:37 AM, Paolo Valente wrote:
>> Commit a33801e8b473 ("block, bfq: move debug blkio stats behind
>> CONFIG_DEBUG_BLK_CGROUP") introduced two batches of confusing ifdefs:
>> one reported in [1], plus a similar one in another function. This
>> commit removes both batches, in the way suggested in [1].
>=20
> Some comments below.
>=20
>> +static inline void bfq_update_dispatch_stats(struct request *rq,
>> +					     spinlock_t *queue_lock,
>> +					     struct bfq_queue =
*in_serv_queue,
>> +					     bool idle_timer_disabled)
>> +{
>=20
> Don't pass in the queue lock. The normal convention is to pass in the
> queue, thus making this:
>=20
> static void bfq_update_dispatch_stats(struct request_queue *q,
> 				      struct request *rq,
> 				      struct bfq_queue *in_serv_queue,
> 				      bool idle_timer_disabled)
>=20

Ok, thanks.  One question, just to try to learn, if you have time and
patience for a brief explanation.  Was this convention originated by
some rationale?  My concern is that bfq_update_dispatch_stats works on
no field of q but the lock, and this fact would have been made
explicit by passing only that exact field.

> which also gets rid of the inline. In general, never inline anything.
> The compiler should figure it out for you. This function is way too =
big
> to inline, plus the cost of what it's doing completely dwarfes =
function
> call overhead.
>=20

Actually, I did so because of Linus' suggestion in [1]: "So for
example, the functions that can go away should obviously be inline
functions so that you don't end up having the compiler generate the
arguments and the call to an empty function body ..."

Maybe I misinterpreted his suggestion, and he meant that the function
should be designed in such a way to be (almost) certainly considered
inline by the compiler?

Thanks,
Paolo

[1] https://www.spinics.net/lists/linux-block/msg20043.html

>=20
>>=20
>> +	struct bfq_queue *bfqq =3D rq ? RQ_BFQQ(rq) : NULL;
>>=20
>> -#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
>> -	bfqq =3D rq ? RQ_BFQQ(rq) : NULL;
>> 	if (!idle_timer_disabled && !bfqq)
>> -		return rq;
>> +		return;
>>=20
>> 	/*
>> 	 * rq and bfqq are guaranteed to exist until this function
>> @@ -3732,7 +3713,7 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>> 	 * In addition, the following queue lock guarantees that
>> 	 * bfqq_group(bfqq) exists as well.
>> 	 */
>> -	spin_lock_irq(hctx->queue->queue_lock);
>> +	spin_lock_irq(queue_lock);
>> 	if (idle_timer_disabled)
>> 		/*
>> 		 * Since the idle timer has been disabled,
>> @@ -3751,9 +3732,37 @@ static struct request =
*bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>> 		bfqg_stats_set_start_empty_time(bfqg);
>> 		bfqg_stats_update_io_remove(bfqg, rq->cmd_flags);
>> 	}
>> -	spin_unlock_irq(hctx->queue->queue_lock);
>> +	spin_unlock_irq(queue_lock);
>> +}
>> +#else
>> +static inline void bfq_update_dispatch_stats(struct request *rq,
>> +					     spinlock_t *queue_lock,
>> +					     struct bfq_queue =
*in_serv_queue,
>> +					     bool idle_timer_disabled) =
{}
>> #endif
>>=20
>> +static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
>> +{
>> +	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
>> +	struct request *rq;
>> +	struct bfq_queue *in_serv_queue;
>> +	bool waiting_rq, idle_timer_disabled;
>> +
>> +	spin_lock_irq(&bfqd->lock);
>> +
>> +	in_serv_queue =3D bfqd->in_service_queue;
>> +	waiting_rq =3D in_serv_queue && =
bfq_bfqq_wait_request(in_serv_queue);
>> +
>> +	rq =3D __bfq_dispatch_request(hctx);
>> +
>> +	idle_timer_disabled =3D
>> +		waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
>> +
>> +	spin_unlock_irq(&bfqd->lock);
>> +
>> +	bfq_update_dispatch_stats(rq, hctx->queue->queue_lock, =
in_serv_queue,
>> +				  idle_timer_disabled);
>> +
>> 	return rq;
>> }
>>=20
>> @@ -4276,16 +4285,46 @@ static bool __bfq_insert_request(struct =
bfq_data *bfqd, struct request *rq)
>> 	return idle_timer_disabled;
>> }
>>=20
>> +#if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
>> +static inline void bfq_update_insert_stats(struct bfq_queue *bfqq,
>> +					   spinlock_t *queue_lock,
>> +					   bool idle_timer_disabled,
>> +					   unsigned int cmd_flags)
>> +{
>> +	if (!bfqq)
>> +		return;
>> +
>> +	/*
>> +	 * bfqq still exists, because it can disappear only after
>> +	 * either it is merged with another queue, or the process it
>> +	 * is associated with exits. But both actions must be taken by
>> +	 * the same process currently executing this flow of
>> +	 * instructions.
>> +	 *
>> +	 * In addition, the following queue lock guarantees that
>> +	 * bfqq_group(bfqq) exists as well.
>> +	 */
>> +	spin_lock_irq(queue_lock);
>> +	bfqg_stats_update_io_add(bfqq_group(bfqq), bfqq, cmd_flags);
>> +	if (idle_timer_disabled)
>> +		bfqg_stats_update_idle_time(bfqq_group(bfqq));
>> +	spin_unlock_irq(queue_lock);
>> +}
>> +#else
>> +static inline void bfq_update_insert_stats(struct bfq_queue *bfqq,
>> +					   spinlock_t *queue_lock,
>> +					   bool idle_timer_disabled,
>> +					   unsigned int cmd_flags) {}
>> +#endif
>=20
> Ditto here, kill the inlines.
>=20
> In general though, good improvement.
>=20
>=20
> --=20
> Jens Axboe
>=20
