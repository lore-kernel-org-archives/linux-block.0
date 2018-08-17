Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1534478043-7170-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com> <1534478043-7170-3-git-send-email-jianchao.w.wang@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 17 Aug 2018 17:36:19 +0800
Message-ID: <CACVXFVMBFwGngLWjf=oT+2=57xWgF38ozf0D3hc_RKOTXbRWVA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] blk-mq: sync the update nr_hw_queues with part_in_flight
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@linux.intel.com>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 17, 2018 at 11:54 AM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
> account the inflight requests. It will access the queue_hw_ctx and
> nr_hw_queues w/o any protection. When updating nr_hw_queues and
> blk_mq_in_flight/rw occur concurrently, panic comes up.
>
> Before update nr_hw_queues, the q will be frozen. So we could use
> q_usage_counter to avoid the race. percpu_ref_is_zero is used here
> so that we will not miss any in-flight request. And also both the
> check and blk_mq_queue_tag_busy_iter are under rcu critical section,
> then __blk_mq_update_nr_hw_queues could ensure the zeroed q_usage_counter
> to be globally visible.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index de7027f..9ec98bd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -112,7 +112,22 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
>         struct mq_inflight mi = { .part = part, .inflight = inflight, };
>
>         inflight[0] = inflight[1] = 0;
> +
> +       /*
> +        * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
> +        * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
> +        * to avoid race with it. __blk_mq_update_nr_hw_queues will use
> +        * synchronize_rcu to ensure all of the users of blk_mq_in_flight
> +        * go out of the critical section and see zeroed q_usage_counter.
> +        */
> +       rcu_read_lock();
> +       if (percpu_ref_is_zero(&q->q_usage_counter)) {
> +               rcu_read_unlock();
> +               return;
> +       }
> +
>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> +       rcu_read_unlock();
>  }
>
>  static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
> @@ -131,7 +146,18 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
>         struct mq_inflight mi = { .part = part, .inflight = inflight, };
>
>         inflight[0] = inflight[1] = 0;
> +
> +       /*
> +        * See comment of blk_mq_in_flight.
> +        */
> +       rcu_read_lock();
> +       if (percpu_ref_is_zero(&q->q_usage_counter)) {
> +               rcu_read_unlock();
> +               return;
> +       }
> +
>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
> +       rcu_read_unlock();

I'd suggest to put the rcu_* and percpu_ref_is_zero() into
blk_mq_queue_tag_busy_iter().


Thanks,
Ming Lei
