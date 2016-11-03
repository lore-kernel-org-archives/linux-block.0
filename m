Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1478034325-28232-4-git-send-email-axboe@fb.com>
References: <1478034325-28232-1-git-send-email-axboe@fb.com> <1478034325-28232-4-git-send-email-axboe@fb.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 3 Nov 2016 20:27:43 +0800
Message-ID: <CACVXFVOoUz7dZ9y=-jqLQFWaekYHnoEQk-ao1s8ydsdh5PJbOw@mail.gmail.com>
Subject: Re: [PATCH 3/4] blk-mq: implement hybrid poll mode for sync O_DIRECT
To: Jens Axboe <axboe@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 2, 2016 at 5:05 AM, Jens Axboe <axboe@fb.com> wrote:
> This patch enables a hybrid polling mode. Instead of polling after IO
> submission, we can induce an artificial delay, and then poll after that.
> For example, if the IO is presumed to complete in 8 usecs from now, we
> can sleep for 4 usecs, wake up, and then do our polling. This still puts

I guess in reality it isn't easy to figure a perfect poll time:

- for one driver, different CPU and different drive/disk may cause different
completion time

- for requests with different size, the completion time can be different too

Is there one way to figure out the poll time automatically?

> a sleep/wakeup cycle in the IO path, but instead of the wakeup happening
> after the IO has completed, it'll happen before. With this hybrid
> scheme, we can achieve big latency reductions while still using the same
> (or less) amount of CPU.
>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq.c         | 38 ++++++++++++++++++++++++++++++++++++++
>  block/blk-sysfs.c      | 29 +++++++++++++++++++++++++++++
>  block/blk.h            |  1 +
>  include/linux/blkdev.h |  1 +
>  4 files changed, 69 insertions(+)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4ef35588c299..caa55bec9411 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -302,6 +302,7 @@ static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
>         rq->rq_flags = 0;
>
>         clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
> +       clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
>         blk_mq_put_tag(hctx, ctx, tag);
>         blk_queue_exit(q);
>  }
> @@ -2352,11 +2353,48 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
>
> +static void blk_mq_poll_hybrid_sleep(struct request_queue *q,
> +                                    struct request *rq)
> +{
> +       struct hrtimer_sleeper hs;
> +       ktime_t kt;
> +
> +       if (!q->poll_nsec || test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
> +               return;
> +
> +       set_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
> +
> +       /*
> +        * This will be replaced with the stats tracking code, using
> +        * 'avg_completion_time / 2' as the pre-sleep target.
> +        */
> +       kt = ktime_set(0, q->poll_nsec);
> +
> +       hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +       hrtimer_set_expires(&hs.timer, kt);
> +
> +       hrtimer_init_sleeper(&hs, current);
> +       do {
> +               if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
> +                       break;
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               hrtimer_start_expires(&hs.timer, HRTIMER_MODE_REL);
> +               if (hs.task)
> +                       io_schedule();
> +               hrtimer_cancel(&hs.timer);
> +       } while (hs.task && !signal_pending(current));
> +
> +       __set_current_state(TASK_RUNNING);
> +       destroy_hrtimer_on_stack(&hs.timer);
> +}
> +
>  bool blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
>  {
>         struct request_queue *q = hctx->queue;
>         long state;
>
> +       blk_mq_poll_hybrid_sleep(q, rq);
> +
>         hctx->poll_considered++;
>
>         state = current->state;
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 5bb4648f434a..467b81c6713c 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -336,6 +336,28 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
>         return ret;
>  }
>
> +static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
> +{
> +       return queue_var_show(q->poll_nsec / 1000, page);
> +}
> +
> +static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
> +                               size_t count)
> +{
> +       unsigned long poll_usec;
> +       ssize_t ret;
> +
> +       if (!q->mq_ops || !q->mq_ops->poll)
> +               return -EINVAL;
> +
> +       ret = queue_var_store(&poll_usec, page, count);
> +       if (ret < 0)
> +               return ret;
> +
> +       q->poll_nsec = poll_usec * 1000;
> +       return ret;
> +}
> +
>  static ssize_t queue_poll_show(struct request_queue *q, char *page)
>  {
>         return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), page);
> @@ -562,6 +584,12 @@ static struct queue_sysfs_entry queue_poll_entry = {
>         .store = queue_poll_store,
>  };
>
> +static struct queue_sysfs_entry queue_poll_delay_entry = {
> +       .attr = {.name = "io_poll_delay", .mode = S_IRUGO | S_IWUSR },
> +       .show = queue_poll_delay_show,
> +       .store = queue_poll_delay_store,
> +};
> +
>  static struct queue_sysfs_entry queue_wc_entry = {
>         .attr = {.name = "write_cache", .mode = S_IRUGO | S_IWUSR },
>         .show = queue_wc_show,
> @@ -608,6 +636,7 @@ static struct attribute *default_attrs[] = {
>         &queue_wc_entry.attr,
>         &queue_dax_entry.attr,
>         &queue_stats_entry.attr,
> +       &queue_poll_delay_entry.attr,
>         NULL,
>  };
>
> diff --git a/block/blk.h b/block/blk.h
> index aa132dea598c..041185e5f129 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -111,6 +111,7 @@ void blk_account_io_done(struct request *req);
>  enum rq_atomic_flags {
>         REQ_ATOM_COMPLETE = 0,
>         REQ_ATOM_STARTED,
> +       REQ_ATOM_POLL_SLEPT,
>  };
>
>  /*
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index dcd8d6e8801f..6acd220dc3f3 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -502,6 +502,7 @@ struct request_queue {
>         unsigned int            request_fn_active;
>
>         unsigned int            rq_timeout;
> +       unsigned int            poll_nsec;
>         struct timer_list       timeout;
>         struct work_struct      timeout_work;
>         struct list_head        timeout_list;
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ming Lei
