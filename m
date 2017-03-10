Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33526 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbdCJCQL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2017 21:16:11 -0500
MIME-Version: 1.0
In-Reply-To: <1489078694.2597.5.camel@sandisk.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
 <1489064578-17305-4-git-send-email-tom.leiming@gmail.com> <1489078694.2597.5.camel@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 10 Mar 2017 10:16:09 +0800
Message-ID: <CACVXFVP0e6jdVTtQYWP+Wksycn9wNZ=ehRuVT7bLeDpF_wKEnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] blk-mq: start to freeze queue just after setting dying
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

On Fri, Mar 10, 2017 at 12:58 AM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Thu, 2017-03-09 at 21:02 +0800, Ming Lei wrote:
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
>> need to worry about undo of the counter.
>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> ---
>>  block/blk-core.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 0eeb99ef654f..559487e58296 100644
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
> The comment above blk_mq_freeze_queue_start() should explain more clearly
> why that call is needed. Additionally, I think this patch makes the

The comment of "block new I/O coming" has been added, and let me know what
others are needed, :-)

> blk_freeze_queue() call in blk_cleanup_queue() superfluous. How about the
> (entirely untested) patch below?

I don't think we need to wait in blk_set_queue_dying(), and the purpose
of this patch is to block new I/O coming once dying iset as pointed in the
comment, and the change in blk_cleanup_queue() isn't necessary too, since
that is exactly where we should drain the queue.


Thanks,
Ming Lei
