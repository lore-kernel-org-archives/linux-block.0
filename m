Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <21ff7888-ec08-0dab-a997-872ad0027fe2@fb.com>
Date: Thu, 2 Feb 2017 10:19:02 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 osandov@fb.com
Message-Id: <4C7AD847-C02D-47FF-83B7-F0BB8FBED5F5@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <1481933536-12844-8-git-send-email-axboe@fb.com> <84DA10A3-5055-4D48-A990-6CB5A5D34F0C@linaro.org> <21ff7888-ec08-0dab-a997-872ad0027fe2@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 02 feb 2017, alle ore 06:19, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> On 02/01/2017 04:11 AM, Paolo Valente wrote:
>>> +static bool dd_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio =
*bio)
>>> +{
>>> +	struct request_queue *q =3D hctx->queue;
>>> +	struct deadline_data *dd =3D q->elevator->elevator_data;
>>> +	int ret;
>>> +
>>> +	spin_lock(&dd->lock);
>>> +	ret =3D blk_mq_sched_try_merge(q, bio);
>>> +	spin_unlock(&dd->lock);
>>> +
>>=20
>> Hi Jens,
>> first, good news, bfq is passing my first sanity checks.  Still, I
>> need a little more help for the following issue.  There is a case =
that
>> would be impossible to handle without modifying code outside bfq.  =
But
>> so far such a case never occurred, and I hope that it can never =
occur.
>> I'll try to briefly list all relevant details on this concern of =
mine,
>> so that you can quickly confirm my hope, or highlight where or what I
>> am missing.
>=20
> Remember my earlier advice - it's not a problem to change anything in
> the core, in fact I would be surprised if you did not need to. My
> foresight isn't THAT good! It's much better to fix up an inconsistency
> there, rather than work around it in the consumer of that API.
>=20
>> First, as done above for mq-deadline, invoking blk_mq_sched_try_merge
>> with the scheduler lock held is of course necessary (for example, to
>> protect q->last_merge).  This may lead to put_rq_private invoked
>> with the lock held, in case of successful merge.
>=20
> Right, or some other lock with the same scope, as per my other email.
>=20
>> As a consequence, put_rq_private may be invoked:
>> (1) in IRQ context, no scheduler lock held, because of a completion:
>> can be handled by deferring work and lock grabbing, because the
>> completed request is not queued in the scheduler any more;
>> (2) in process context, scheduler lock held, because of the above
>> successful merge: must be handled immediately, for consistency,
>> because the request is still queued in the scheduler;
>> (3) in process context, no scheduler lock held, for some other =
reason:
>> some path apparently may lead to this case, although I've never seen
>> it to happen.  Immediate handling, and hence locking, may be needed,
>> depending on whether the request is still queued in the scheduler.
>>=20
>> So, my main question is: is case (3) actually impossible?  Should it
>> be possible, I guess we would have a problem, because of the
>> different lock state with respect to (2).
>=20
> I agree, there's some inconsistency there, if you potentially need to
> grab the lock in your put_rq_private handler. The problem case is #2,
> when we have the merge. I would probably suggest that the best way to
> handle that is to pass back the dropped request so we can put it =
outside
> of holding the lock.
>=20
> Let me see if I can come up with a good solution for this. We have to =
be
> consistent in how we invoke the scheduler functions, we can't have =
hooks
> that are called in unknown lock states. I also don't want you to have =
to
> add defer work handling in that kind of path, that will impact your
> performance and overhead.
>=20

I'll try to learn from your solution, because, as of now, I don't see
how to avoid deferred work for the case where put_rq_private is
invoked in interrupt context.  In fact, for this case, we cannot grab
the lock, unless we turn all spin_lock into spin_lock_irq*.

>> Finally, I hope that it is certainly impossible to have a case (4): =
in
>> IRQ context, no lock held, but with the request in the scheduler.
>=20
> That should not be possible.
>=20
> Edit: since I'm on a flight and email won't send, I had a few minutes =
to
> hack this up. Totally untested, but something like the below should do
> it. Not super pretty... I'll play with this a bit more tomorrow.
>=20
>=20

The scheme is clear.  One comment, in case it could make sense and
avoid more complexity: since put_rq_priv is invoked in two different
contexts, process or interrupt, I didn't feel so confusing that, when
put_rq_priv is invoked in the context where the lock cannot be held
(unless one is willing to pay with irq disabling all the times), the
lock is not held, while, when invoked in the context where the lock
can be held, the lock is actually held, or must be taken.

Thanks,
Paolo

> diff --git a/block/blk-core.c b/block/blk-core.c
> index c142de090c41..530a9a3f60c9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1609,7 +1609,7 @@ static blk_qc_t blk_queue_bio(struct =
request_queue *q, struct bio *bio)
> {
> 	struct blk_plug *plug;
> 	int el_ret, where =3D ELEVATOR_INSERT_SORT;
> -	struct request *req;
> +	struct request *req, *free;
> 	unsigned int request_count =3D 0;
> 	unsigned int wb_acct;
>=20
> @@ -1650,15 +1650,21 @@ static blk_qc_t blk_queue_bio(struct =
request_queue *q, struct bio *bio)
> 	if (el_ret =3D=3D ELEVATOR_BACK_MERGE) {
> 		if (bio_attempt_back_merge(q, req, bio)) {
> 			elv_bio_merged(q, req, bio);
> -			if (!attempt_back_merge(q, req))
> +			free =3D attempt_back_merge(q, req);
> +			if (!free)
> 				elv_merged_request(q, req, el_ret);
> +			else
> +				__blk_put_request(q, free);
> 			goto out_unlock;
> 		}
> 	} else if (el_ret =3D=3D ELEVATOR_FRONT_MERGE) {
> 		if (bio_attempt_front_merge(q, req, bio)) {
> 			elv_bio_merged(q, req, bio);
> -			if (!attempt_front_merge(q, req))
> +			free =3D attempt_front_merge(q, req);
> +			if (!free)
> 				elv_merged_request(q, req, el_ret);
> +			else
> +				__blk_put_request(q, free);
> 			goto out_unlock;
> 		}
> 	}
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 6aa43dec5af4..011b1c6e3cb4 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -661,29 +661,29 @@ static void blk_account_io_merge(struct request =
*req)
> /*
>  * Has to be called with the request spinlock acquired
>  */
> -static int attempt_merge(struct request_queue *q, struct request =
*req,
> -			  struct request *next)
> +static struct request *attempt_merge(struct request_queue *q,
> +				     struct request *req, struct request =
*next)
> {
> 	if (!rq_mergeable(req) || !rq_mergeable(next))
> -		return 0;
> +		return NULL;
>=20
> 	if (req_op(req) !=3D req_op(next))
> -		return 0;
> +		return NULL;
>=20
> 	/*
> 	 * not contiguous
> 	 */
> 	if (blk_rq_pos(req) + blk_rq_sectors(req) !=3D blk_rq_pos(next))
> -		return 0;
> +		return NULL;
>=20
> 	if (rq_data_dir(req) !=3D rq_data_dir(next)
> 	    || req->rq_disk !=3D next->rq_disk
> 	    || req_no_special_merge(next))
> -		return 0;
> +		return NULL;
>=20
> 	if (req_op(req) =3D=3D REQ_OP_WRITE_SAME &&
> 	    !blk_write_same_mergeable(req->bio, next->bio))
> -		return 0;
> +		return NULL;
>=20
> 	/*
> 	 * If we are allowed to merge, then append bio list
> @@ -692,7 +692,7 @@ static int attempt_merge(struct request_queue *q, =
struct request *req,
> 	 * counts here.
> 	 */
> 	if (!ll_merge_requests_fn(q, req, next))
> -		return 0;
> +		return NULL;
>=20
> 	/*
> 	 * If failfast settings disagree or any of the two is already
> @@ -732,30 +732,32 @@ static int attempt_merge(struct request_queue =
*q, struct request *req,
> 	if (blk_rq_cpu_valid(next))
> 		req->cpu =3D next->cpu;
>=20
> -	/* owner-ship of bio passed from next to req */
> +	/*
> +	 * owner-ship of bio passed from next to req, return 'next' for
> +	 * the caller to free
> +	 */
> 	next->bio =3D NULL;
> -	__blk_put_request(q, next);
> -	return 1;
> +	return next;
> }
>=20
> -int attempt_back_merge(struct request_queue *q, struct request *rq)
> +struct request *attempt_back_merge(struct request_queue *q, struct =
request *rq)
> {
> 	struct request *next =3D elv_latter_request(q, rq);
>=20
> 	if (next)
> 		return attempt_merge(q, rq, next);
>=20
> -	return 0;
> +	return NULL;
> }
>=20
> -int attempt_front_merge(struct request_queue *q, struct request *rq)
> +struct request *attempt_front_merge(struct request_queue *q, struct =
request *rq)
> {
> 	struct request *prev =3D elv_former_request(q, rq);
>=20
> 	if (prev)
> 		return attempt_merge(q, prev, rq);
>=20
> -	return 0;
> +	return NULL;
> }
>=20
> int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
> @@ -767,7 +769,12 @@ int blk_attempt_req_merge(struct request_queue =
*q, struct request *rq,
> 		if (!e->type->ops.sq.elevator_allow_rq_merge_fn(q, rq, =
next))
> 			return 0;
>=20
> -	return attempt_merge(q, rq, next);
> +	if (attempt_merge(q, rq, next)) {
> +		__blk_put_request(q, next);
> +		return 1;
> +	}
> +
> +	return 0;
> }
>=20
> bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 114814ec3d49..d93b56d53c4e 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -234,7 +234,8 @@ void blk_mq_sched_move_to_dispatch(struct =
blk_mq_hw_ctx *hctx,
> }
> EXPORT_SYMBOL_GPL(blk_mq_sched_move_to_dispatch);
>=20
> -bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio)
> +bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> +			    struct request **merged_request)
> {
> 	struct request *rq;
> 	int ret;
> @@ -244,7 +245,8 @@ bool blk_mq_sched_try_merge(struct request_queue =
*q, struct bio *bio)
> 		if (!blk_mq_sched_allow_merge(q, rq, bio))
> 			return false;
> 		if (bio_attempt_back_merge(q, rq, bio)) {
> -			if (!attempt_back_merge(q, rq))
> +			*merged_request =3D attempt_back_merge(q, rq);
> +			if (!*merged_request)
> 				elv_merged_request(q, rq, ret);
> 			return true;
> 		}
> @@ -252,7 +254,8 @@ bool blk_mq_sched_try_merge(struct request_queue =
*q, struct bio *bio)
> 		if (!blk_mq_sched_allow_merge(q, rq, bio))
> 			return false;
> 		if (bio_attempt_front_merge(q, rq, bio)) {
> -			if (!attempt_front_merge(q, rq))
> +			*merged_request =3D attempt_front_merge(q, rq);
> +			if (!*merged_request)
> 				elv_merged_request(q, rq, ret);
> 			return true;
> 		}
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 9478aaeb48c5..3643686a54b8 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -16,7 +16,8 @@ void blk_mq_sched_put_request(struct request *rq);
>=20
> void blk_mq_sched_request_inserted(struct request *rq);
> bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx, struct =
request *rq);
> -bool blk_mq_sched_try_merge(struct request_queue *q, struct bio =
*bio);
> +bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
> +				struct request **merged_request);
> bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio =
*bio);
> bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct =
request *rq);
> void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx);
> diff --git a/block/blk.h b/block/blk.h
> index c1bd4bf9e645..918cea38d51e 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -204,8 +204,8 @@ int ll_back_merge_fn(struct request_queue *q, =
struct request *req,
> 		     struct bio *bio);
> int ll_front_merge_fn(struct request_queue *q, struct request *req,=20
> 		      struct bio *bio);
> -int attempt_back_merge(struct request_queue *q, struct request *rq);
> -int attempt_front_merge(struct request_queue *q, struct request *rq);
> +struct request *attempt_back_merge(struct request_queue *q, struct =
request *rq);
> +struct request *attempt_front_merge(struct request_queue *q, struct =
request *rq);
> int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
> 				struct request *next);
> void blk_recalc_rq_segments(struct request *rq);
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 49583536698c..682fa64f55ff 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -371,12 +371,16 @@ static bool dd_bio_merge(struct blk_mq_hw_ctx =
*hctx, struct bio *bio)
> {
> 	struct request_queue *q =3D hctx->queue;
> 	struct deadline_data *dd =3D q->elevator->elevator_data;
> -	int ret;
> +	struct request *free =3D NULL;
> +	bool ret;
>=20
> 	spin_lock(&dd->lock);
> -	ret =3D blk_mq_sched_try_merge(q, bio);
> +	ret =3D blk_mq_sched_try_merge(q, bio, &free);
> 	spin_unlock(&dd->lock);
>=20
> +	if (free)
> +		blk_mq_free_request(free);
> +
> 	return ret;
> }
>=20
>=20
> --=20
> Jens Axboe
>=20
