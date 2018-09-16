Return-Path: <ming.lei@redhat.com>
Date: Sun, 16 Sep 2018 21:09:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH V3 00/17] SCSI: introduce per-host admin queue & enable
 runtime PM
Message-ID: <20180916130918.GA9947@ming.t460p>
References: <20180913121546.5710-1-ming.lei@redhat.com>
 <f9ba3c11-21ac-d963-3f24-cb83744014e1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f9ba3c11-21ac-d963-3f24-cb83744014e1@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 14, 2018 at 03:27:44PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/13/2018 08:15 PM, Ming Lei wrote:
> > This patchset introduces per-host admin request queue for submitting
> > admin request only, and uses this approach to implement both SCSI
> > quiesce and runtime PM in one very simply way. Also runtime PM deadlock
> > can be avoided in case that request pool is used up, such as when too
> > many IO requests are allocated before resuming device
> 
> To be honest, after look in to the SCSI part of this patchset, I really
> suspect whether it is worth to introduce this per scsi-host adminq.
> Too much complexity is introduced into SCSI. Compared with this, the current

Can you comment on individual patch about which part is complicated?
I will explain them to you only by one.

> preempt-only feature look much simpler.
> 
> If you just don't like the preempt-only checking in the hot path, we may introduce
> a new interface similar with blk_queue_enter for the non hot path.
> 
> With your patch percpu-refcount: relax limit on percpu_ref_reinit()

Seems this way may be one improvement on Bart's V6.

> 
> (totally no test)
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4dbc93f..dd7f007 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -427,14 +427,24 @@ EXPORT_SYMBOL(blk_sync_queue);
>   * Returns the previous value of the PREEMPT_ONLY flag - 0 if the flag was not
>   * set and 1 if the flag was already set.
>   */
> -int blk_set_preempt_only(struct request_queue *q)
> +int blk_set_preempt_only(struct request_queue *q, bool drain)
>  {
> -    return blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
> +    if (blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q))
> +        return 1;
> +    percpu_ref_kill(&q->q_usage_counter);
> +    synchronize_sched();
> +
> +    if (drain)
> +        wait_event(q->mq_freeze_wq,
> +                percpu_ref_is_zero(&q->q_usage_counter));
> +
> +    return 0;
>  }
>  EXPORT_SYMBOL_GPL(blk_set_preempt_only);

It is easy to cause race between the normal freeze interface and the
above one. That may be one new complexity of the preempt only approach,
because there can be more than one path to kill/reinit .q_usage_counter.

>  
>  void blk_clear_preempt_only(struct request_queue *q)
>  {
> +    percpu_ref_reinit(&q->q_usage_counter);
>      blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
>      wake_up_all(&q->mq_freeze_wq);
>  }
> @@ -913,31 +923,13 @@ EXPORT_SYMBOL(blk_alloc_queue);
>  /**
>   * blk_queue_enter() - try to increase q->q_usage_counter
>   * @q: request queue pointer
> - * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PREEMPT
> + * @flags: BLK_MQ_REQ_NOWAIT
>   */
>  int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  {
> -    const bool preempt = flags & BLK_MQ_REQ_PREEMPT;
> -
>      while (true) {
> -        bool success = false;
> -
> -        rcu_read_lock();
> -        if (percpu_ref_tryget_live(&q->q_usage_counter)) {
> -            /*
> -             * The code that sets the PREEMPT_ONLY flag is
> -             * responsible for ensuring that that flag is globally
> -             * visible before the queue is unfrozen.
> -             */
> -            if (preempt || !blk_queue_preempt_only(q)) {
> -                success = true;
> -            } else {
> -                percpu_ref_put(&q->q_usage_counter);
> -            }
> -        }
> -        rcu_read_unlock();
>  
> -        if (success)
> +        if (percpu_ref_tryget_live(&q->q_usage_counter))
>              return 0;
>  
>          if (flags & BLK_MQ_REQ_NOWAIT)
> @@ -954,7 +946,44 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  
>          wait_event(q->mq_freeze_wq,
>                 (atomic_read(&q->mq_freeze_depth) == 0 &&
> -                (preempt || !blk_queue_preempt_only(q))) ||
> +               !blk_queue_preempt_only(q)) ||
> +               blk_queue_dying(q));
> +        if (blk_queue_dying(q))
> +            return -ENODEV;
> +    }
> +}

The big question is how you will implement runtime suspend with this
approach? New IO has to terminate the runtime suspend.

> +
> +/*
> + * When set PREEMPT_ONLY mode, q->q_usage_counter is killed.
> + * If only PREEMPT_ONLY mode, go on.
> + * If queue frozen, wait.
> + */
> +int blk_queue_preempt_enter(struct request_queue *q,
> +    blk_mq_req_flags_t flags)
> +{
> +    while (true) {
> +
> +        if (percpu_ref_tryget_live(&q->q_usage_counter))
> +            return 0;
> +
> +        smp_rmb();
> +
> +        /*
> +         * If queue is only in PREEMPT_ONLY mode, get the ref
> +         * directly. The one who set PREEMPT_ONLY mode is responsible
> +         * to wake up the waiters on mq_freeze_wq.
> +         */
> +        if (!atomic_read(&q->mq_freeze_depth) &&
> +                blk_queue_preempt_only(q)) {
> +            percpu_ref_get_many(&q->q_usage_counter, 1);
> +            return 0;
> +        }

This way will delay runtime pm or system suspend until the queue is unfrozen,
but it isn't reasonable.

Thanks,
Ming
