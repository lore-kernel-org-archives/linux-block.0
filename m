Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
References: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com> <1534749606-7311-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1534749606-7311-3-git-send-email-jianchao.w.wang@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 20 Aug 2018 16:16:55 +0800
Message-ID: <CACVXFVMxMf4Ag8CODJ_FPNrNTY-DhUZXV5JGLX-J4zexKF+qzg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@linux.intel.com>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 20, 2018 at 3:18 PM Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
>
> For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
> account the inflight requests. It will access the queue_hw_ctx and
> nr_hw_queues w/o any protection. When updating nr_hw_queues and
> blk_mq_in_flight/rw occur concurrently, panic comes up.
>
> Before update nr_hw_queues, the q will be frozen. So we could use
> q_usage_counter to avoid the race. percpu_ref_is_zero is used here
> so that we will not miss any in-flight request. The access to
> nr_hw_queues and queue_hw_ctx in blk_mq_queue_tag_busy_iter are
> under rcu critical section, __blk_mq_update_nr_hw_queues could use
> synchronize_rcu to ensure the zeroed q_usage_counter to be globally
> visible.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq-tag.c | 14 +++++++++++++-
>  block/blk-mq.c     |  5 ++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index c0c4e63..8c5cc11 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -320,6 +320,18 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>         struct blk_mq_hw_ctx *hctx;
>         int i;
>
> +       /*
> +        * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
> +        * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
> +        * to avoid race with it. __blk_mq_update_nr_hw_queues will users
> +        * synchronize_rcu to ensure all of the users go out of the critical
> +        * section below and see zeroed q_usage_counter.
> +        */
> +       rcu_read_lock();
> +       if (percpu_ref_is_zero(&q->q_usage_counter)) {
> +               rcu_read_unlock();
> +               return;
> +       }
>
>         queue_for_each_hw_ctx(q, hctx, i) {
>                 struct blk_mq_tags *tags = hctx->tags;
> @@ -335,7 +347,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>                         bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
>                 bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
>         }
> -
> +       rcu_read_unlock();
>  }
>
>  static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7b99477..fb56bae 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2905,7 +2905,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);
> -
> +       /*
> +        * Sync with blk_mq_in_flight and blk_mq_queue_tag_busy_iter.
> +        */
> +       synchronize_rcu();
>         /*
>          * switch io scheduler to NULL to clean up the data in it.
>          * will get it back after update mapping between cpu and hw queues.
> --
> 2.7.4
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
