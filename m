Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8549 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdJSHCS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2017 03:02:18 -0400
Subject: Re: [bug report] A race between blk_cleanup_queue and
 blk_timeout_work
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <d96fa515-32cb-8064-93e3-ff405b1923f5@hisilicon.com>
 <1508344743.2540.11.camel@wdc.com> <1508350170.2540.18.camel@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <bce7466e-402b-1550-e4a6-1803fe56ee20@hisilicon.com>
Date: Thu, 19 Oct 2017 15:01:17 +0800
MIME-Version: 1.0
In-Reply-To: <1508350170.2540.18.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

在 2017/10/19 2:09, Bart Van Assche 写道:
> On Wed, 2017-10-18 at 09:39 -0700, Bart Van Assche wrote:
>> On Tue, 2017-10-17 at 09:55 +0800, chenxiang (M) wrote:
>>> I find there is a race between blk_cleanup_queue and blk_timeout_work
>> Thanks for the detailed report. Would it be possible to test the patch below
>> (applies on top of https://github.com/bvanassche/linux/tree/blk-mq-pm-2017-10-18-v10)?

Hi Bart,
I have tested this patch, and it solves the issue i reported.

regards,
shawn

> Here is a better version of the patch included in the previous e-mail:
>
>
> Subject: [PATCH] block: Fix race between blk_cleanup_queue() and timeout
>   handling
>
> Make sure that if the timeout timer fires after a queue has been
> marked "dying" that the affected requests are finished.
>
> ---
>   block/blk-core.c    | 2 ++
>   block/blk-timeout.c | 3 ---
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4fc9d6d44edd..0a0fdaa474e3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -333,6 +333,7 @@ EXPORT_SYMBOL(blk_stop_queue);
>   void blk_sync_queue(struct request_queue *q)
>   {
>   	del_timer_sync(&q->timeout);
> +	cancel_work_sync(&q->timeout_work);
>   
>   	if (q->mq_ops) {
>   		struct blk_mq_hw_ctx *hctx;
> @@ -905,6 +906,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
>   	setup_timer(&q->backing_dev_info->laptop_mode_wb_timer,
>   		    laptop_mode_timer_fn, (unsigned long) q);
>   	setup_timer(&q->timeout, blk_rq_timed_out_timer, (unsigned long) q);
> +	INIT_WORK(&q->timeout_work, NULL);
>   	INIT_LIST_HEAD(&q->queue_head);
>   	INIT_LIST_HEAD(&q->timeout_list);
>   	INIT_LIST_HEAD(&q->icq_list);
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index 1eba71486716..764ecf9aeb30 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -134,8 +134,6 @@ void blk_timeout_work(struct work_struct *work)
>   	struct request *rq, *tmp;
>   	int next_set = 0;
>   
> -	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT))
> -		return;
>   	spin_lock_irqsave(q->queue_lock, flags);
>   
>   	list_for_each_entry_safe(rq, tmp, &q->timeout_list, timeout_list)
> @@ -145,7 +143,6 @@ void blk_timeout_work(struct work_struct *work)
>   		mod_timer(&q->timeout, round_jiffies_up(next));
>   
>   	spin_unlock_irqrestore(q->queue_lock, flags);
> -	blk_queue_exit(q);
>   }
>   
>   /**
