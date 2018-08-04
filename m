Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180804000325.3610-8-bart.vanassche@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com> <20180804000325.3610-8-bart.vanassche@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 4 Aug 2018 18:01:21 +0800
Message-ID: <CACVXFVOSB-r9OYJ+R7a-PfFuie3LCjUxhs2E7igh9vWp2VONkg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] block, scsi: Rework runtime power management
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>, Johannes Thumshirn <jthumshirn@suse.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Aug 4, 2018 at 8:03 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> Instead of allowing requests that are not power management requests
> to enter the queue in runtime suspended status (RPM_SUSPENDED), make
> the blk_get_request() caller block. This change fixes a starvation
> issue: it is now guaranteed that power management requests will be
> executed no matter how many blk_get_request() callers are waiting.
> Instead of maintaining the q->nr_pending counter, rely on
> q->q_usage_counter. Call pm_runtime_mark_last_busy() every time a
> request finishes instead of only if the queue depth drops to zero.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-core.c       | 37 ++++++++-----------------------------
>  block/blk-mq-debugfs.c |  1 -
>  block/blk-pm.c         | 29 ++++++++++++++++++++++++-----
>  block/blk-pm.h         | 14 ++++++++------
>  include/linux/blkdev.h |  1 -
>  5 files changed, 40 insertions(+), 42 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 59382c758155..1e208e134ca9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2736,30 +2736,6 @@ void blk_account_io_done(struct request *req, u64 now)
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
> -       default:
> -               return true;
> -       }
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
> @@ -2805,11 +2781,14 @@ static struct request *elv_next_request(struct request_queue *q)
>
>         while (1) {
>                 list_for_each_entry(rq, &q->queue_head, queuelist) {
> -                       if (blk_pm_allow_request(rq))
> -                               return rq;
> -
> -                       if (rq->rq_flags & RQF_SOFTBARRIER)
> -                               break;
> +#ifdef CONFIG_PM
> +                       /*
> +                        * If a request gets queued in state RPM_SUSPENDED
> +                        * then that's a kernel bug.
> +                        */
> +                       WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);
> +#endif
> +                       return rq;
>                 }
>
>                 /*
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index a5ea86835fcb..7d74d53dc098 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -332,7 +332,6 @@ static const char *const rqf_name[] = {
>         RQF_NAME(ELVPRIV),
>         RQF_NAME(IO_STAT),
>         RQF_NAME(ALLOCED),
> -       RQF_NAME(PM),
>         RQF_NAME(HASHED),
>         RQF_NAME(STATS),
>         RQF_NAME(SPECIAL_PAYLOAD),
> diff --git a/block/blk-pm.c b/block/blk-pm.c
> index 2a4632d0be4b..0708185ead61 100644
> --- a/block/blk-pm.c
> +++ b/block/blk-pm.c
> @@ -107,17 +107,31 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>         if (!q->dev)
>                 return ret;
>
> +       WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
> +
>         blk_pm_runtime_lock(q);
> +       /*
> +        * Switch to preempt-only mode before calling synchronize_rcu() such
> +        * that later blk_queue_enter() calls see the preempt-only state. See
> +        * also http://lwn.net/Articles/573497/.
> +        */
> +       blk_set_pm_only(q);
> +       ret = -EBUSY;
> +       if (percpu_ref_read(&q->q_usage_counter) == 1) {
> +               synchronize_rcu();
> +               if (percpu_ref_read(&q->q_usage_counter) == 1)
> +                       ret = 0;
> +       }

The above code looks too tricky, and the following issue might exist in case
of potential WRITEs re-order from blk_queue_enter().

1) suppose there are one in-flight request not completed yet

2) observer is the percpu_ref_read() following synchronize_rcu().

3) inside blk_queue_enter(), WRITE in percpu_ref_tryget_live()/percpu_ref_put()
can be re-ordered from view of the observer in 2)

4) then percpu_ref_read() may return 1 even though the only in-flight
request isn't completed

5) suspend still moves on, and data loss may be triggered

Cc Paul, and Alan have been CCed already, so we have several memory
model experts here, :-), hope they may help to clarify if this reorder case
may exist.

Thanks,
Ming
