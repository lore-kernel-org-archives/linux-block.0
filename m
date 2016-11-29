Return-Path: <ming.lei@canonical.com>
MIME-Version: 1.0
In-Reply-To: <1480352508-5810-1-git-send-email-krisman@linux.vnet.ibm.com>
References: <1480352508-5810-1-git-send-email-krisman@linux.vnet.ibm.com>
From: Ming Lei <ming.lei@canonical.com>
Date: Tue, 29 Nov 2016 15:33:29 +0800
Message-ID: <CACVXFVN8hbDLQp0kKRWppuxr2=sR_acVHt_ifrMYRm8bXhnpBA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Drop explicit timeout sync in hotplug
To: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 29, 2016 at 1:01 AM, Gabriel Krisman Bertazi
<krisman@linux.vnet.ibm.com> wrote:
> Sorry for the dup.  Missed linux-block address.
>
>>8
>
> After commit 287922eb0b18 ("block: defer timeouts to a workqueue"),
> deleting the timeout work after freezing the queue shouldn't be
> necessary, since the synchronization is already enforced by the
> acquisition of a q_usage_counter reference in blk_mq_timeout_work.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> ---
>  block/blk-mq.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9d4a1d630d0b..bac12caece06 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2220,16 +2220,9 @@ static void blk_mq_queue_reinit_work(void)
>          */
>         list_for_each_entry(q, &all_q_list, all_q_node)
>                 blk_mq_freeze_queue_start(q);
> -       list_for_each_entry(q, &all_q_list, all_q_node) {
> +       list_for_each_entry(q, &all_q_list, all_q_node)
>                 blk_mq_freeze_queue_wait(q);
>
> -               /*
> -                * timeout handler can't touch hw queue during the
> -                * reinitialization
> -                */
> -               del_timer_sync(&q->timeout);
> -       }
> -
>         list_for_each_entry(q, &all_q_list, all_q_node)
>                 blk_mq_queue_reinit(q, &cpuhp_online_new);

Reviewed-by: Ming Lei <ming.lei@canonical.com>

Thanks,
Ming
