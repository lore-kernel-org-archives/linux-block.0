Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180804000325.3610-6-bart.vanassche@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com> <20180804000325.3610-6-bart.vanassche@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 4 Aug 2018 18:23:09 +0800
Message-ID: <CACVXFVPdK3VDW2sj3ozqO0H2-Kr3bDjLpbZ+BY8ZrzudUDgeiQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] block: Serialize queue freezing and blk_pre_runtime_suspend()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jianchao Wang <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <jthumshirn@suse.de>, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Aug 4, 2018 at 8:03 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> Serialize these operations because a later patch will add code into
> blk_pre_runtime_suspend() that should not run concurrently with queue
> freezing nor unfreezing.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
>  block/blk-core.c       |  5 +++++
>  block/blk-mq.c         |  3 +++
>  block/blk-pm.c         | 44 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-pm.h |  6 ++++++
>  include/linux/blkdev.h |  5 +++++
>  5 files changed, 63 insertions(+)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 03cff7445dee..59382c758155 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -17,6 +17,7 @@
>  #include <linux/bio.h>
>  #include <linux/blkdev.h>
>  #include <linux/blk-mq.h>
> +#include <linux/blk-pm.h>
>  #include <linux/highmem.h>
>  #include <linux/mm.h>
>  #include <linux/kernel_stat.h>
> @@ -696,6 +697,7 @@ void blk_set_queue_dying(struct request_queue *q)
>          * prevent I/O from crossing blk_queue_enter().
>          */
>         blk_freeze_queue_start(q);
> +       blk_pm_runtime_unlock(q);
>
>         if (q->mq_ops)
>                 blk_mq_wake_waiters(q);
> @@ -756,6 +758,7 @@ void blk_cleanup_queue(struct request_queue *q)
>          * prevent that q->request_fn() gets invoked after draining finished.
>          */
>         blk_freeze_queue(q);
> +       blk_pm_runtime_unlock(q);
>         spin_lock_irq(lock);
>         queue_flag_set(QUEUE_FLAG_DEAD, q);
>         spin_unlock_irq(lock);
> @@ -1045,6 +1048,8 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
>  #ifdef CONFIG_BLK_DEV_IO_TRACE
>         mutex_init(&q->blk_trace_mutex);
>  #endif
> +       blk_pm_init(q);
> +
>         mutex_init(&q->sysfs_lock);
>         spin_lock_init(&q->__queue_lock);
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8b23ae34d949..b1882a3a5216 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -9,6 +9,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/bio.h>
>  #include <linux/blkdev.h>
> +#include <linux/blk-pm.h>
>  #include <linux/kmemleak.h>
>  #include <linux/mm.h>
>  #include <linux/init.h>
> @@ -138,6 +139,7 @@ void blk_freeze_queue_start(struct request_queue *q)
>  {
>         int freeze_depth;
>
> +       blk_pm_runtime_lock(q);
>         freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
>         if (freeze_depth == 1) {
>                 percpu_ref_kill(&q->q_usage_counter);
> @@ -201,6 +203,7 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
>                 percpu_ref_reinit(&q->q_usage_counter);
>                 wake_up_all(&q->mq_freeze_wq);
>         }
> +       blk_pm_runtime_unlock(q);
>  }

>From user view, it isn't reasonable to prevent runtime suspend from happening
during queue freeze. The period can be a bit long, and it should be one perfect
opportunity to suspend device during the period since no any IO is possible.


Thanks,
Ming Lei
