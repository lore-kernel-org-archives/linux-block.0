Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170411235848.8686-1-bart.vanassche@sandisk.com>
References: <20170411235848.8686-1-bart.vanassche@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 12 Apr 2017 13:01:42 +0800
Message-ID: <CACVXFVOg3C-H14z5Qt1qz79qQeeg1zg6Xs2noHTHApwJ6+zwaw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Fix blk_execute_rq_nowait() handling of dying queues
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Mike Snitzer <snitzer@redhat.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 12, 2017 at 7:58 AM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> Although blk_execute_rq_nowait() asks blk_mq_sched_insert_request()
> to run the queue, the function that should run the queue
> (__blk_mq_delay_run_hw_queue()) skips hardware queues for which
> .tags =3D=3D NULL. Since blk_mq_free_tag_set() clears .tags this means
> if blk_execute_rq_nowait() is called after the tag set has been

Just wondering how that can happen, because we usually call
blk_mq_free_tag_set()
after blk_cleanup_queue() is completed.

> freed that the request that has been queued will never be executed.
> In my tests I noticed that every now and then an SG_IO request that
> got queued by multipathd on a dm device did not get executed. This
> resulted in either a memory leak complaint about the SG_IO code or
> the dm device becoming unremovable with e.g. the following state:
>
> $ grep busy=3D /sys/kernel/debug/block/dm*/mq/*
> /sys/kernel/debug/block/dm-0/mq/state:SAME_COMP STACKABLE IO_STAT INIT_DO=
NE POLL REGISTERED, pg_init_in_progress=3D0, nr_valid_paths=3D4, flags=3D R=
ETAIN_ATTACHED_HW_HANDLER, paths: [0:0] active=3D1 busy=3D0 dying dead [1:0=
] active=3D1 busy=3D0 dying dead [2:0] active=3D1 busy=3D0 dying dead [3:0]=
 active=3D1 busy=3D0 dying dead
> $ multipath -ll
> mpathu (3600140572616d6469736b32000000000) dm-0 ##,##
> size=3D984M features=3D'3 retain_attached_hw_handler queue_mode mq' hwhan=
dler=3D'1 alua' wp=3Drw
> |-+- policy=3D'service-time 0' prio=3D0 status=3Dactive
> |-+- policy=3D'service-time 0' prio=3D0 status=3Dundef
> |-+- policy=3D'service-time 0' prio=3D0 status=3Dundef
> `-+- policy=3D'service-time 0' prio=3D0 status=3Dundef
>
> Avoid that blk_execute_rq_nowait() is called to queue a request
> onto a dying queue by changing the blk_freeze_queue_start() call
> in blk_set_queue_dying() into a blk_freeze_queue() call.

blk_mq_freeze_queue_wait() is only for waiting for completion of pending IO=
, so
could you explain it a bit why _wait() is required?

In this case, either blk_freeze_queue_start() or blk_freeze_queue() can't
prevent the rq coming into queue, because we only hold/check q_usage_counte=
r
before allocating a request, but blk_execute_rq_nowait() has got the reques=
t
already.

>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Ming Lei <tom.leiming@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
>  block/blk-core.c | 9 +++++----
>  block/blk-exec.c | 7 +++++--
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 8654aa0cef6d..21314b995887 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -501,11 +501,12 @@ void blk_set_queue_dying(struct request_queue *q)
>         spin_unlock_irq(q->queue_lock);
>
>         /*
> -        * When queue DYING flag is set, we need to block new req
> -        * entering queue, so we call blk_freeze_queue_start() to
> -        * prevent I/O from crossing blk_queue_enter().
> +        * When queue DYING flag is set, we need to block new requests
> +        * from being queued. Hence call blk_freeze_queue() to make
> +        * new blk_queue_enter() calls fail and to wait until all pending
> +        * I/O has finished.
>          */
> -       blk_freeze_queue_start(q);
> +       blk_freeze_queue(q);
>
>         if (q->mq_ops)
>                 blk_mq_wake_waiters(q);
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index 8cd0e9bc8dc8..f7d9bed2cb15 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -57,10 +57,13 @@ void blk_execute_rq_nowait(struct request_queue *q, s=
truct gendisk *bd_disk,
>         rq->end_io =3D done;
>
>         /*
> -        * don't check dying flag for MQ because the request won't
> -        * be reused after dying flag is set
> +        * The blk_freeze_queue() call in blk_set_queue_dying() and the
> +        * test of the "dying" flag in blk_queue_enter() guarantee that
> +        * blk_execute_rq_nowait() won't be called anymore after the "dyi=
ng"
> +        * flag has been set.

That never be guaranteed, see the following case:

1) blk_get_request() is called just before queue is set as dying in another=
 path

2) the request is allocated successfully and passed to
blk_execute_rq_nowait() even
though queue has been set as dying


Thanks,
Ming Lei
