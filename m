Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] blk-mq: avoid to starve tag allocation after
 allocation process migrates
To: Ming Lei <tom.leiming@gmail.com>, Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@fb.com>
References: <20180519074406.6045-1-ming.lei@redhat.com>
 <7a4499e8-60bb-892a-91cf-f2d2c4be74b7@kernel.dk>
 <20180523093225.GA32067@ming.t460p> <20180523174823.GC12533@vader>
 <CACVXFVPm_ds=b9ZGwfdfnwErdAPEVfoct65neRXt5pV1E9fjew@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <48643bc2-cff9-717a-73b1-7ce068529a39@kernel.dk>
Date: Wed, 23 May 2018 16:19:40 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVPm_ds=b9ZGwfdfnwErdAPEVfoct65neRXt5pV1E9fjew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/23/18 4:09 PM, Ming Lei wrote:
> On Thu, May 24, 2018 at 1:48 AM, Omar Sandoval <osandov@osandov.com> wrote:
>> On Wed, May 23, 2018 at 05:32:31PM +0800, Ming Lei wrote:
>>> On Tue, May 22, 2018 at 09:59:17PM -0600, Jens Axboe wrote:
>>>> On 5/19/18 1:44 AM, Ming Lei wrote:
>>>>> When the allocation process is scheduled back and the mapped hw queue is
>>>>> changed, do one extra wake up on orignal queue for compensating wake up
>>>>> miss, so other allocations on the orignal queue won't be starved.
>>>>>
>>>>> This patch fixes one request allocation hang issue, which can be
>>>>> triggered easily in case of very low nr_request.
>>>>
>>>> Trying to think of better ways we can fix this, but I don't see
>>>> any right now. Getting rid of the wake_up_nr() kills us on tons
>>>> of tasks waiting.
>>>
>>> I am not sure if I understand your point, but this issue isn't related
>>> with wake_up_nr() actually, and it can be reproduced after reverting
>>> 4e5dff41be7b5201c1c47c (blk-mq: improve heavily contended tag case).
>>>
>>> All tasks in current sbq_wait_state may be scheduled to other CPUs, and
>>> there may still be tasks waiting for allocation from this sbitmap_queue,
>>> and the root cause is about cross-queue allocation, as you said,
>>> there are too many queues, :-)
>>
>> I don't follow. Your description of the problem was that we have two
>> waiters and only wake up one, which doesn't in turn allocate and free a
>> tag and wake up the second waiter. Changing it back to wake_up_nr()
>> eliminates that problem. And if waking up everything doesn't fix it, how
>> does your fix of waking up a few extra tasks fix it?
> 
> What matters is that this patch wakes up the previous sbq, let's see if
> from another view:
> 
> 1) still 2 hw queues, nr_requests are 2, and wake_batch is one
> 
> 2) there are 3 waiters on hw queue 0
> 
> 3) two in-flight requests in hw queue 0 are completed, and only two waiters
> of 3 are waken up because of wake_batch, but both the two waiters can be
> scheduled to another CPU and cause to switch to hw queue 1
> 
> 4) then the 3rd waiter will wait for ever, since no in-flight request
> is in hw queue
> 0 any more.
> 
> 5) this patch fixes it by the fake wakeup when waiter is scheduled to another
> hw queue
> 
> The issue can be understood a bit easier if we just forget sbq_wait_state and
> focus on sbq, :-)

It makes sense to me, and also explains why wake_up() vs wake_up_nr() doesn't
matter. Which is actually a relief. And the condition of moving AND having
a waiter should be rare enough that it'll work out fine in practice, I don't
see any performance implications from this. You're right that we already
abort early if we don't have pending waiters, so it's all good.

Can you respin with the comments from Omar and myself covered?

-- 
Jens Axboe
