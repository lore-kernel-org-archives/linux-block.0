Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34474 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbdCXRis (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 13:38:48 -0400
Received: by mail-vk0-f66.google.com with SMTP id y16so1464964vky.1
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 10:38:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490376267.3312.1.camel@sandisk.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com> <20170324123621.5227-3-tom.leiming@gmail.com>
 <1490376267.3312.1.camel@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 25 Mar 2017 01:38:46 +0800
Message-ID: <CACVXFVN7_PovXhKFofqf7N99Fq6RHEtFojHzwc6AN1oEpFLYxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] block: add a read barrier in blk_queue_enter()
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hare@suse.de" <hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 25, 2017 at 1:24 AM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Fri, 2017-03-24 at 20:36 +0800, Ming Lei wrote:
>> Without the barrier, reading DEAD flag of .q_usage_counter
>> and reading .mq_freeze_depth may be reordered, then the
>> following wait_event_interruptible() may never return.
>>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> ---
>>  block/blk-core.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index ad388d5e309a..44eed17319c0 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -669,6 +669,14 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
>>               if (nowait)
>>                       return -EBUSY;
>>
>> +             /*
>> +              * read pair of barrier in blk_mq_freeze_queue_start(),
>> +              * we need to order reading DEAD flag of .q_usage_counter
>> +              * and reading .mq_freeze_depth, otherwise the following
>> +              * wait may never return if the two read are reordered.
>> +              */
>> +             smp_rmb();
>> +
>>               ret = wait_event_interruptible(q->mq_freeze_wq,
>>                               !atomic_read(&q->mq_freeze_depth) ||
>>                               blk_queue_dying(q));
>
> Hello Ming,
>
> The code looks fine to me but the comment not. You probably wanted to refer
> to the "dying" flag instead of the "dead" flag? The read order has to be

No, looks you misunderstand the issue.

I mean the order between reading __PERCPU_REF_DEAD of .q_usage_counter
and reading .mq_freeze_depth should be enhanced, especially it is in
blk_queue_enter() vs. blk_mq_freeze_queue_start().

In the last patch, you will find the dying flag is mentioned in above comment
after we call blk_freeze_queue_start() just after the dying flag is set.

> enforced for the "dying" flag and q_usage_counter because of the order in
> which these are set by blk_set_queue_dying().

As I explained, the dying flag should only be mentioned after we change
the code in blk_set_queue_dying().


Thanks,
Ming Lei
