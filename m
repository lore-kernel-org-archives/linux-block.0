Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
References: <20181024131809.23070-1-ming.lei@redhat.com>
In-Reply-To: <20181024131809.23070-1-ming.lei@redhat.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 31 Oct 2018 10:04:56 +0800
Message-ID: <CACVXFVMArYjAMMfqXKULF8pCrPSSWi88g9RwxLg_8_p+B0D-SQ@mail.gmail.com>
Subject: Re: [PATCH] block: call rq_qos_exit() after queue is frozen
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 24, 2018 at 9:18 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> rq_qos_exit() removes the current q->rq_qos, this action has to be
> done after queue is frozen, otherwise the IO queue path may never
> be waken up, then IO hang is caused.
>
> So fixes this issue by moving rq_qos_exit() after queue is frozen.
>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c  | 3 +++
>  block/blk-sysfs.c | 2 --
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 3ed60723e242..0a5a6cf5add7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -785,6 +785,9 @@ void blk_cleanup_queue(struct request_queue *q)
>          * prevent that q->request_fn() gets invoked after draining finished.
>          */
>         blk_freeze_queue(q);
> +
> +       rq_qos_exit(q);
> +
>         spin_lock_irq(lock);
>         queue_flag_set(QUEUE_FLAG_DEAD, q);
>         spin_unlock_irq(lock);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 3772671cf2bc..d4f1280965b6 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -994,8 +994,6 @@ void blk_unregister_queue(struct gendisk *disk)
>         kobject_del(&q->kobj);
>         blk_trace_remove_sysfs(disk_to_dev(disk));
>
> -       rq_qos_exit(q);
> -
>         mutex_lock(&q->sysfs_lock);
>         if (q->request_fn || (q->mq_ops && q->elevator))
>                 elv_unregister_queue(q);
> --
> 2.9.5
>

Ping...

-- 
Ming Lei
