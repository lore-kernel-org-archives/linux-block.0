Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38382 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbdBGRfj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2017 12:35:39 -0500
Received: by mail-wm0-f45.google.com with SMTP id r141so161314597wmg.1
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2017 09:35:38 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] block: free merged request in the caller
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1486051573-13445-3-git-send-email-axboe@fb.com>
Date: Tue, 7 Feb 2017 18:35:34 +0100
Cc: linux-block@vger.kernel.org, osandov@osandov.com
Message-Id: <DACBA1F6-5FD9-4762-AF19-5907303790D8@linaro.org>
References: <1486051573-13445-1-git-send-email-axboe@fb.com> <1486051573-13445-3-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 02 feb 2017, alle ore 17:06, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> If we end up doing a request-to-request merge when we have completed
> a bio-to-request merge, we free the request from deep down in that
> path. For blk-mq-sched, the merge path has to hold the appropriate
> lock, but we don't need it for freeing the request. And in fact
> holding the lock is problematic, since we are now calling the
> mq sched put_rq_private() hook with the lock held. Other call paths
> do not hold this lock.
>=20
> Fix this inconsistency by ensuring that the caller frees a merged
> request. Then we can do it outside of the lock, making it both more
> efficient and fixing the blk-mq-sched problem of invoking parts of
> the scheduler with an unknown lock state.
>=20
> Reported-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
> block/blk-core.c     | 12 +++++++++---
> block/blk-merge.c    | 15 ++++++++++++---
> block/blk-mq-sched.c |  9 ++++++---
> block/blk-mq-sched.h |  3 ++-
> block/mq-deadline.c  |  8 ++++++--
> 5 files changed, 35 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a5726e01f839..00c90f8cd682 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1591,7 +1591,7 @@ static blk_qc_t blk_queue_bio(struct =
request_queue *q, struct bio *bio)
> {
> 	struct blk_plug *plug;
> 	int el_ret, where =3D ELEVATOR_INSERT_SORT;
> -	struct request *req;
> +	struct request *req, *free;
> 	unsigned int request_count =3D 0;
> 	unsigned int wb_acct;
>=20
> @@ -1632,15 +1632,21 @@ static blk_qc_t blk_queue_bio(struct =
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
> index 3826fc32b72c..a373416dbc9a 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -733,9 +733,11 @@ static struct request *attempt_merge(struct =
request_queue *q,
> 	if (blk_rq_cpu_valid(next))
> 		req->cpu =3D next->cpu;
>=20
> -	/* owner-ship of bio passed from next to req */
> +	/*
> +	 * ownership of bio passed from next to req, return 'next' for
> +	 * the caller to free
> +	 */
> 	next->bio =3D NULL;
> -	__blk_put_request(q, next);
> 	return next;
> }
>=20
> @@ -763,12 +765,19 @@ int blk_attempt_req_merge(struct request_queue =
*q, struct request *rq,
> 			  struct request *next)
> {
> 	struct elevator_queue *e =3D q->elevator;
> +	struct request *free;
>=20
> 	if (!e->uses_mq && e->type->ops.sq.elevator_allow_rq_merge_fn)
> 		if (!e->type->ops.sq.elevator_allow_rq_merge_fn(q, rq, =
next))
> 			return 0;
>=20
> -	return attempt_merge(q, rq, next) !=3D NULL;
> +	free =3D attempt_merge(q, rq, next);
> +	if (free) {
> +		__blk_put_request(q, free);
> +		return 1;
> +	}
> +
> +	return 0;
> }
>=20

Hi Jens,
blk_attempt_req_merge is reached also from
blk_mq_sched_try_insert_merge, which is invoked in mq-deadline.
According to the current usage of the scheduler lock in mq-deadline,
that lock should be taken before invoking
blk_mq_sched_try_insert_merge too, as I pointed out in a previous
reply of mine.  But, if it is taken, then we have again the
double-lock-state problem in put_rq_private.

Unfortunately, from your general explanation on how to best protect
shared data structures, I did not understand (sorry) whether the
scheduler lock must or must not be taken around
blk_mq_sched_try_insert_merge in the current implementation of
mq-deadline.  Could you patiently provide a thickheaded-proof, yes/no
answer, if possible?

Thanks,
Paolo


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
> --=20
> 2.7.4
>=20
