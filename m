Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34518 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdCQSkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 14:40:06 -0400
MIME-Version: 1.0
In-Reply-To: <1489771915.2826.4.camel@sandisk.com>
References: <20170317095711.5819-1-tom.leiming@gmail.com> <20170317095711.5819-4-tom.leiming@gmail.com>
 <1489771915.2826.4.camel@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 18 Mar 2017 02:32:37 +0800
Message-ID: <CACVXFVPF0Sx5HyU+xw0MyghYMWifZ0SDH0YCtM-jrhieOJOJGg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] blk-mq: start to freeze queue just after setting dying
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 18, 2017 at 1:32 AM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Fri, 2017-03-17 at 17:57 +0800, Ming Lei wrote:
>> Before commit 780db2071a(blk-mq: decouble blk-mq freezing
>> from generic bypassing), the dying flag is checked before
>> entering queue, and Tejun converts the checking into .mq_freeze_depth,
>> and assumes the counter is increased just after dying flag
>> is set. Unfortunately we doesn't do that in blk_set_queue_dying().
>>
>> This patch calls blk_mq_freeze_queue_start() for blk-mq in
>> blk_set_queue_dying(), so that we can block new I/O coming
>> once the queue is set as dying.
>>
>> Given blk_set_queue_dying() is always called in remove path
>> of block device, and queue will be cleaned up later, we don't
>> need to worry about undoing the counter.
>>
>> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> ---
>>  block/blk-core.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index d772c221cc17..62d4967c369f 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -500,9 +500,12 @@ void blk_set_queue_dying(struct request_queue *q)
>>       queue_flag_set(QUEUE_FLAG_DYING, q);
>>       spin_unlock_irq(q->queue_lock);
>>
>> -     if (q->mq_ops)
>> +     if (q->mq_ops) {
>>               blk_mq_wake_waiters(q);
>> -     else {
>> +
>> +             /* block new I/O coming */
>> +             blk_mq_freeze_queue_start(q);
>> +     } else {
>>               struct request_list *rl;
>>
>>               spin_lock_irq(q->queue_lock);
>
> Hello Ming,
>
> I think we need the queue freezing not only for blk-mq but also for blk-sq.

Yes, we can, but it may not be a big deal for blk-sq, since get_request() does
check the dying flag.

> Since the queue flags and the mq_freeze_depth are stored in different
> variables we need to prevent that the CPU reorders the stores to these

Not needed, see below.

> variables. The comment about blk_mq_freeze_queue_start() should be more
> clear. How about something like the patch below?
>
>
> [PATCH] blk-mq: Force block layer users to check the "dying" flag after it has been set
>
> Commit 780db2071ac4 removed the blk_queue_dying() check from the
> hot path of blk_mq_queue_enter() although that check is necessary
> when cleaning up a queue. Hence make sure that blk_queue_enter()
> and blk_mq_queue_enter() check the dying flag after it has been set.
>
> Because blk_set_queue_dying() is only called from the remove path
> of a block device we don't need to worry about unfreezing the queue.
>
> Fixes: commit 780db2071ac4 ("blk-mq: decouble blk-mq freezing from generic bypassing")
> ---
>  block/blk-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d772c221cc17..730f715b72ff 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -500,6 +500,19 @@ void blk_set_queue_dying(struct request_queue *q)
>         queue_flag_set(QUEUE_FLAG_DYING, q);
>         spin_unlock_irq(q->queue_lock);
>
> +       /*
> +        * Avoid that the updates of the queue flags and q_usage_counter
> +        * are reordered.
> +        */
> +       smp_wmb();

atomic_inc_return() in blk_mq_freeze_queue_start() does imply a
barrier(smp_mb()).

> +
> +       /*
> +        * Force blk_queue_enter() and blk_mq_queue_enter() to check the
> +        * "dying" flag. Despite its name, blk_mq_freeze_queue_start()
> +        * affects blk-sq and blk-mq queues.
> +        */
> +       blk_mq_freeze_queue_start(q);

We need to change the name into blk_freeze_queue_start(), since it is quite
confusing to call a _mq function for both mq and legacy.

I will make it for both in v2, if no one objects.


Thanks,
Ming Lei
