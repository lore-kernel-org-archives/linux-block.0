Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180717234940.11231-3-bart.vanassche@wdc.com>
References: <20180717234940.11231-1-bart.vanassche@wdc.com> <20180717234940.11231-3-bart.vanassche@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 18 Jul 2018 20:16:59 +0800
Message-ID: <CACVXFVPP6bY9YijDSyQg9OOR4ge9LyR+naWNDeLGOS=WFL_7CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] block, scsi: Rework runtime power management
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 7:49 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> Instead of allowing requests that are not power management requests
> to enter the queue in runtime suspended status (RPM_SUSPENDED), make
> the blk_get_request() caller block. This change fixes a starvation
> issue: it is now guaranteed that power management requests will be
> executed no matter how many blk_get_request() callers are waiting.
> Instead of maintaining the q->nr_pending counter, rely on
> q->q_usage_counter. Call pm_runtime_mark_last_busy() every time a
> request finishes instead of only if the queue depth drops to zero.
> Use RQF_PREEMPT to mark power management requests instead of RQF_PM.
> This is safe because the power management core serializes system-wide
> suspend/resume and runtime power management state changes.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-core.c          | 56 +++++++++++++++++----------------------
>  block/blk-mq-debugfs.c    |  1 -
>  block/blk-mq.c            | 12 ++++-----
>  block/elevator.c          | 11 +-------
>  drivers/scsi/sd.c         |  4 +--
>  drivers/scsi/ufs/ufshcd.c | 10 +++----
>  include/linux/blk-mq.h    |  1 +
>  include/linux/blkdev.h    |  7 ++---
>  8 files changed, 41 insertions(+), 61 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index f84a9b7b6f5a..65d7f27c8c22 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1719,7 +1719,7 @@ EXPORT_SYMBOL_GPL(part_round_stats);
>  #ifdef CONFIG_PM
>  static void blk_pm_put_request(struct request *rq)
>  {
> -       if (rq->q->dev && !(rq->rq_flags & RQF_PM) && !--rq->q->nr_pending)
> +       if (rq->q->dev && !(rq->rq_flags & RQF_PREEMPT))
>                 pm_runtime_mark_last_busy(rq->q->dev);
>  }
>  #else
> @@ -2737,30 +2737,6 @@ void blk_account_io_done(struct request *req, u64 now)
>         }
>  }
>
> -#ifdef CONFIG_PM
> -/*
> - * Don't process normal requests when queue is suspended
> - * or in the process of suspending/resuming
> - */
> -static bool blk_pm_allow_request(struct request *rq)
> -{
> -       switch (rq->q->rpm_status) {
> -       case RPM_RESUMING:
> -       case RPM_SUSPENDING:
> -               return rq->rq_flags & RQF_PM;
> -       case RPM_SUSPENDED:
> -               return false;
> -       }
> -
> -       return true;
> -}
> -#else
> -static bool blk_pm_allow_request(struct request *rq)
> -{
> -       return true;
> -}
> -#endif
> -
>  void blk_account_io_start(struct request *rq, bool new_io)
>  {
>         struct hd_struct *part;
> @@ -2806,11 +2782,12 @@ static struct request *elv_next_request(struct request_queue *q)
>
>         while (1) {
>                 list_for_each_entry(rq, &q->queue_head, queuelist) {
> -                       if (blk_pm_allow_request(rq))
> -                               return rq;
> -
> -                       if (rq->rq_flags & RQF_SOFTBARRIER)
> -                               break;
> +                       /*
> +                        * If a request gets queued in state RPM_SUSPENDED
> +                        * then that's a kernel bug.
> +                        */
> +                       WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);
> +                       return rq;
>                 }
>
>                 /*
> @@ -3801,8 +3778,11 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>         if (!q->dev)
>                 return ret;
>
> +       blk_set_preempt_only(q);
> +       blk_freeze_queue_start(q);
> +
>         spin_lock_irq(q->queue_lock);
> -       if (q->nr_pending) {
> +       if (!percpu_ref_is_zero(&q->q_usage_counter)) {

This way can't work reliably because the percpu ref isn't in atomic mode
yet after blk_freeze_queue_start() returns, then percpu_ref_is_zero() won't
see accurate value of the counter, finally the device may be put down before
in-flight requests are completed by hardware.

Thanks,
Ming Lei
