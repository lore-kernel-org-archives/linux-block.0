Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36067 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdCQSXr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 14:23:47 -0400
MIME-Version: 1.0
In-Reply-To: <1489772332.2826.6.camel@sandisk.com>
References: <20170317095711.5819-1-tom.leiming@gmail.com> <20170317095711.5819-3-tom.leiming@gmail.com>
 <1489772332.2826.6.camel@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 18 Mar 2017 02:23:25 +0800
Message-ID: <CACVXFVP1QvkcD81MvCpQLz993g=jaPgMNFAFa2hvnPjjGcVkzg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] blk-mq: comment on races related with timeout handler
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "yizhan@redhat.com" <yizhan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 18, 2017 at 1:39 AM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Fri, 2017-03-17 at 17:57 +0800, Ming Lei wrote:
>> +/*
>> + * When we reach here because queue is busy, REQ_ATOM_COMPLETE
>> + * flag isn't set yet, so there may be race with timeout hanlder,
>> + * but given rq->deadline is just set in .queue_rq() under
>> + * this sitation, the race won't be possible in reality because
>> + * rq->timeout should be set as big enough to cover the window
>> + * between blk_mq_start_request() called from .queue_rq() and
>> + * clearing REQ_ATOM_STARTED here.
>> + */
>>  static void __blk_mq_requeue_request(struct request *rq)
>>  {
>>       struct request_queue *q = rq->q;
>> @@ -700,6 +709,19 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>>       if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
>>               return;
>>
>> +     /*
>> +      * The rq being checked may have been freed and reallocated
>> +      * out already here, we avoid this race by checking rq->deadline
>> +      * and REQ_ATOM_COMPLETE flag together:
>> +      *
>> +      * - if rq->deadline is observed as new value because of
>> +      *   reusing, the rq won't be timed out because of timing.
>> +      * - if rq->deadline is observed as previous value,
>> +      *   REQ_ATOM_COMPLETE flag won't be cleared in reuse path
>> +      *   because we put a barrier between setting rq->deadline
>> +      *   and clearing the flag in blk_mq_start_request(), so
>> +      *   this rq won't be timed out too.
>> +      */
>>       if (time_after_eq(jiffies, rq->deadline)) {
>>               if (!blk_mark_rq_complete(rq))
>>                       blk_mq_rq_timed_out(rq, reserved);
>
> Since this explanation applies to the same race addressed by patch 1/3,

First, this explains how we deal with the race of reuse vs. timeout, and 1/3
fixes another race or rq corruption. Did you see anywhere I mentioned STARTED
flag in above comment?

In case of 1/3, the rq to be dispatched can be destroyed simply by the
blk_mq_end_request() from timeout. Or even it can survive, the same rq
can be allocated into another I/O path, and this situation is different with
reuse vs. timeout. And I can't see any help from the comment for explaining
1/3's issue, can you? Maybe I need to mention rq corruption in 1/3 explicitly.

Secondly introducing this comment to 1/3 just causes unnecessary
backporting burden, as we have to make it into -stable.

> please consider squashing this patch into patch 1/3.

So please do not consider that.

Thanks,
Ming Lei
