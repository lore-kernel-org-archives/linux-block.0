Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 6/8] blk-mq-sched: add framework for MQ capable IO schedulers
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1481933536-12844-7-git-send-email-axboe@fb.com>
Date: Thu, 22 Dec 2016 10:59:27 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 osandov@fb.com
Message-Id: <9936D33B-AE98-46DF-B1DA-D54142A338FD@linaro.org>
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
>=20
...

> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> new file mode 100644
> index 000000000000..b7e1839d4785
> --- /dev/null
> +++ b/block/blk-mq-sched.c

> ...
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

Something does not seem to add up here:
e->type->ops.mq.allow_merge may be called only in
blk_mq_sched_allow_merge, which, in its turn, may be called only in
blk_mq_attempt_merge, which, finally, may be called only in
blk_mq_merge_queue_io.  Yet the latter may be called only if there is
no elevator (line 1399 and 1507 in blk-mq.c).

Therefore, e->type->ops.mq.allow_merge can never be called, both if
there is and if there is not an elevator.  Be patient if I'm missing
something huge, but I thought it was worth reporting this.

Paolo
