Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1481933536-12844-8-git-send-email-axboe@fb.com>
Date: Thu, 16 Feb 2017 11:46:38 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 osandov@fb.com
Message-Id: <FC3DABDF-FA97-4E45-84C0-D9554669FF15@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <1481933536-12844-8-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> This is basically identical to deadline-iosched, except it registers
> as a MQ capable scheduler. This is still a single queue design.
>=20
> Signed-off-by: Jens Axboe <axboe@fb.com>
...
> +
> +static void dd_merged_requests(struct request_queue *q, struct =
request *req,
> +			       struct request *next)
> +{
> +	/*
> +	 * if next expires before rq, assign its expire time to rq
> +	 * and move into next position (next will be deleted) in fifo
> +	 */
> +	if (!list_empty(&req->queuelist) && =
!list_empty(&next->queuelist)) {
> +		if (time_before((unsigned long)next->fifo_time,
> +				(unsigned long)req->fifo_time)) {
> +			list_move(&req->queuelist, &next->queuelist);
> +			req->fifo_time =3D next->fifo_time;
> +		}
> +	}
> +

Jens,
while trying to imagine the possible causes of Bart's hang with
bfq-mq, I've bumped into the following doubt: in the above function
(in my case, in bfq-mq-'s equivalent of the above function), are
we sure that neither req or next could EVER be in dd->dispatch instead
of dd->fifo_list?  I've tried to verify it, but, although I think it has =
never
happened in my tests, I was not able to make sure that no unlucky
combination may ever happen (considering also the use of
blk_rq_is_passthrough too, to decide where to put a new request).

I'm making a blunder, right?

Thanks,
Paolo
