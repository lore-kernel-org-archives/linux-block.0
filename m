Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1481933536-12844-8-git-send-email-axboe@fb.com>
Date: Thu, 22 Dec 2016 17:07:07 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 osandov@fb.com
Message-Id: <A59E28FD-C451-45C0-814C-560A8CA758E3@linaro.org>
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
> ---

...

> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> new file mode 100644
> index 000000000000..3cb9de21ab21
> --- /dev/null
> +++ b/block/mq-deadline.c
> ...
> +/*
> + * remove rq from rbtree and fifo.
> + */
> +static void deadline_remove_request(struct request_queue *q, struct =
request *rq)
> +{
> +	struct deadline_data *dd =3D q->elevator->elevator_data;
> +
> +	list_del_init(&rq->queuelist);
> +
> +	/*
> +	 * We might not be on the rbtree, if we are doing an insert =
merge
> +	 */
> +	if (!RB_EMPTY_NODE(&rq->rb_node))
> +		deadline_del_rq_rb(dd, rq);
> +

I've been scratching my head on the last three instructions, but at no
avail.  If I understand correctly, the
list_del_init(&rq->queue list);
removes rq from the fifo list.  But, if so, I don't understand how it
could be possible that rq has not been added to the rb_tree too.

Another interpretation that I tried is that the above three lines
handle correctly the following case where rq has not been inserted at
all into deadline fifo queue and rb tree: when dd_insert_request was
executed for rq, blk_mq_sched_try_insert_merge succeeded.  Yet, the
list_del_init(&rq->queue list);
does not seem to make sense.

Could you please shed some light on this for me?

Thanks,
Paolo
