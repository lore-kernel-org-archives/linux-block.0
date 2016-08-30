Return-Path: <jinpuwang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJrWOzCUzPiFUOS5HbToB1AdsMKFGG=UQHAr5=ZL5KYGyf2GLg@mail.gmail.com>
References: <20160808113908.5445-1-roman.penyaev@profitbricks.com>
 <20160810035542.GE25053@mtj.duckdns.org> <CAJrWOzCWfMN7qKipgWn2P0dfycu4y5DQysD+7Q1UANgXBgw0+g@mail.gmail.com>
 <CAJrWOzCUzPiFUOS5HbToB1AdsMKFGG=UQHAr5=ZL5KYGyf2GLg@mail.gmail.com>
From: =?UTF-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Date: Tue, 30 Aug 2016 11:37:10 +0200
Message-ID: <CAD9gYJJfvKeNU=QeQPm-mCqc3O9sfMQoTgVFnAqKLpcac+P5xQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] blk-mq: fix hang caused by freeze/unfreeze sequence
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
	Roman Penyaev <roman.penyaev@profitbricks.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

2016-08-10 13:36 GMT+02:00 Roman Penyaev <roman.penyaev@profitbricks.com>:
> On Wed, Aug 10, 2016 at 10:42 AM, Roman Penyaev
> <roman.penyaev@profitbricks.com> wrote:
>> Hi,
>>
>> On Wed, Aug 10, 2016 at 5:55 AM, Tejun Heo <tj@kernel.org> wrote:
>>> Hello,
>>>
>>> On Mon, Aug 08, 2016 at 01:39:08PM +0200, Roman Pen wrote:
>>>> Long time ago there was a similar fix proposed by Akinobu Mita[1],
>>>> but it seems that time everyone decided to fix this subtle race in
>>>> percpu-refcount and Tejun Heo[2] did an attempt (as I can see that
>>>> patchset was not applied).
>>>
>>> So, I probably forgot about it while waiting for confirmation of fix.
>>> Can you please verify that the patchset fixes the issue?  I can apply
>>> the patchset right away.
>>
>> I have not checked your patchset but according to my understanding
>> it should not fix *this* issue.
>
> So, your patchset does not help (but for sure it helps for keeping
> internal percpu-refcount members consistent, but that is not related
> to this issue).  That's the backtrace which I observe:
>
> Call Trace:
>  [<ffffffff810ba8df>] ? vprintk_default+0x1f/0x30
>  [<ffffffff816a47f5>] schedule+0x35/0x80
>  [<ffffffff81336154>] blk_mq_freeze_queue_wait+0x124/0x1a0
>  [<ffffffff810a3f70>] ? wake_atomic_t_function+0x60/0x60
>  [<ffffffff8133821a>] blk_mq_freeze_queue+0x1a/0x20
>  [<ffffffff8133822e>] blk_freeze_queue+0xe/0x10
>  [<ffffffff81329cc2>] blk_cleanup_queue+0xe2/0x280
>
> To ease reproduction I do the following:
>
> -------------------------------------------
> static int thread_fn(void *data)
> {
>     struct blk_mq_tag_set *tags = data;
>     struct request_queue *q;
>
>     while (!kthread_should_stop()) {
>         q = blk_mq_init_queue(tags);
>         BUG_ON(q == NULL);
>         /*
>          * That is done by blk_register_queue(), but here
>          * we are reproducing blk-mq bug and do not require
>          * gendisk and friends.  Just silently switch to percpu.
>          */
>         percpu_ref_switch_to_percpu(&q->q_usage_counter);
>
>         msleep(prandom_u32_max(10));
>         blk_cleanup_queue(q);
>     }
>
>     return 0;
> }
> -------------------------------------------
>
> o Start 2 threads (exactly 2, we need 2 queues for 1 shared tags)
> o Pass same shared tags pointer for each thread
> o Wait
> o PROFIT
>
> To make immediate reproduction this hunk can be applied:
>
> @@ -129,6 +142,7 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
>         freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
>         WARN_ON_ONCE(freeze_depth < 0);
>         if (!freeze_depth) {
> +               msleep(1000);
>                 percpu_ref_reinit(&q->q_usage_counter);
>                 wake_up_all(&q->mq_freeze_wq);
>         }
>
> --
> Roman

Hi Jens,

I didn't see this patch in you tree, what's the blocker?

Thanks,
Jinpu
