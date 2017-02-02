Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <84DA10A3-5055-4D48-A990-6CB5A5D34F0C@linaro.org>
 <21ff7888-ec08-0dab-a997-872ad0027fe2@fb.com>
 <4C7AD847-C02D-47FF-83B7-F0BB8FBED5F5@linaro.org>
 <f26b60aa-b047-d7a3-550d-5270c696e2a1@fb.com>
 <6958F4D4-84EF-413B-9C40-E16E0A711B87@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <6effcdf0-ca5e-0ab9-6866-f144f1c1a635@fb.com>
Date: Thu, 2 Feb 2017 14:32:28 -0700
MIME-Version: 1.0
In-Reply-To: <6958F4D4-84EF-413B-9C40-E16E0A711B87@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/02/2017 02:15 PM, Paolo Valente wrote:
> 
>> Il giorno 02 feb 2017, alle ore 16:30, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> On 02/02/2017 02:19 AM, Paolo Valente wrote:
>>> The scheme is clear.  One comment, in case it could make sense and
>>> avoid more complexity: since put_rq_priv is invoked in two different
>>> contexts, process or interrupt, I didn't feel so confusing that, when
>>> put_rq_priv is invoked in the context where the lock cannot be held
>>> (unless one is willing to pay with irq disabling all the times), the
>>> lock is not held, while, when invoked in the context where the lock
>>> can be held, the lock is actually held, or must be taken.
>>
>> If you grab the same lock from put_rq_priv, yes, you must make it IRQ
>> disabling in all contexts, and use _irqsave() from put_rq_priv. If it's
>> just freeing resources, you could potentially wait and do that when
>> someone else needs them, since that part will come from proces context.
>> That would need two locks, though.
>>
>> As I said above, I would not worry about the IRQ disabling lock.
>>
> 
> I'm sorry, I focused only on the IRQ-disabling consequence of grabbing
> a scheduler lock also in IRQ context.  I thought it was a serious
> enough issue to avoid this option.  Yet there is also a deadlock
> problem related to this option.  In fact, the IRQ handler may preempt
> some process-context code that already holds some other locks, and, if
> some of these locks are already held by another process, which is
> executing on another CPU and which then tries to take the scheduler
> lock, or which happens to be preempted by an IRQ handler trying to
> grab the scheduler lock, then a deadlock occurs.  This is not just a
> speculation, but a problem that did occur before I moved to a
> deferred-work solution, and that can be readily reproduced.  Before
> moving to a deferred work solution, I tried various code manipulations
> to avoid these deadlocks without resorting to deferred work, but at no
> avail.

There are two important rules here:

1) If a lock is ever used in interrupt context, anyone acquiring it must
   ensure that interrupts gets disabled.

2) If multiple locks are needed, they need to be acquired in the right
   order.

Instead of talking in hypotheticals, be more specific. With the latest
code, the scheduler lock should now be fine, there should be no cases
where you are being invoked with it held. I'm assuming you are running
with lockdep enabled on your kernel? Post the stack traces from your
problem (and your code...), then we can take a look.

Don't punt to deferring work from your put_rq_private() function, that's
a suboptimal work around. It needs to be fixed for real.

> At any rate, bfq seems now to work, so I can finally move from just
> asking questions endlessly, to proposing actual code to discuss on.
> I'm about to: port this version of bfq to your improved/fixed
> blk-mq-sched version in for-4.11 (port postponed, to avoid introducing
> further changes in code that did not yet wok), run more extensive
> tests, polish commits a little bit, and finally share a branch.

Post the code sooner rather than later. There are bound to be things
that need to be improved or fixed up, let's start this process now. The
framework is pretty much buttoned up at this point, so there's time to
shift the attention a bit to a consumer of it.

-- 
Jens Axboe
