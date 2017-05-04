Subject: Re: [PATCH 1/4] blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
To: Ming Lei <tom.leiming@gmail.com>, Omar Sandoval <osandov@osandov.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <20170428151539.25514-2-ming.lei@redhat.com> <20170503164631.GA10775@vader>
 <CACVXFVNXeq6S9GZZ=DnY7iSziyBav0XXvY0kRnUCuddqVe-MgA@mail.gmail.com>
 <20170503214029.GA27440@vader>
 <CACVXFVMLuGioTLCJt3AF6NBkpb=7T48mEm0b1q-ATJs2PFYjYg@mail.gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block
 <linux-block@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Omar Sandoval <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <b7f4f8cf-30d1-8995-4256-c96184522992@fb.com>
Date: Wed, 3 May 2017 20:13:03 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVMLuGioTLCJt3AF6NBkpb=7T48mEm0b1q-ATJs2PFYjYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/03/2017 08:01 PM, Ming Lei wrote:
> On Thu, May 4, 2017 at 5:40 AM, Omar Sandoval <osandov@osandov.com> wrote:
>> On Thu, May 04, 2017 at 04:13:51AM +0800, Ming Lei wrote:
>>> On Thu, May 4, 2017 at 12:46 AM, Omar Sandoval <osandov@osandov.com> wrote:
>>>> On Fri, Apr 28, 2017 at 11:15:36PM +0800, Ming Lei wrote:
>>>>> When blk-mq I/O scheduler is used, we need two tags for
>>>>> submitting one request. One is called scheduler tag for
>>>>> allocating request and scheduling I/O, another one is called
>>>>> driver tag, which is used for dispatching IO to hardware/driver.
>>>>> This way introduces one extra per-queue allocation for both tags
>>>>> and request pool, and may not be as efficient as case of none
>>>>> scheduler.
>>>>>
>>>>> Also currently we put a default per-hctx limit on schedulable
>>>>> requests, and this limit may be a bottleneck for some devices,
>>>>> especialy when these devices have a quite big tag space.
>>>>>
>>>>> This patch introduces BLK_MQ_F_SCHED_USE_HW_TAG so that we can
>>>>> allow to use hardware/driver tags directly for IO scheduling if
>>>>> devices's hardware tag space is big enough. Then we can avoid
>>>>> the extra resource allocation and make IO submission more
>>>>> efficient.
>>>>>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>  block/blk-mq-sched.c   | 10 +++++++++-
>>>>>  block/blk-mq.c         | 35 +++++++++++++++++++++++++++++------
>>>>>  include/linux/blk-mq.h |  1 +
>>>>>  3 files changed, 39 insertions(+), 7 deletions(-)
>>>>
>>>> One more note on this: if we're using the hardware tags directly, then
>>>> we are no longer limited to q->nr_requests requests in-flight. Instead,
>>>> we're limited to the hw queue depth. We probably want to maintain the
>>>> original behavior,
>>>
>>> That need further investigation, and generally scheduler should be happy with
>>> more requests which can be scheduled.
>>>
>>> We can make it as one follow-up.
>>
>> If we say nr_requests is 256, then we should honor that. So either
>> update nr_requests to reflect the actual depth we're using or resize the
>> hardware tags.
> 
> Firstly nr_requests is set as 256 from blk-mq inside instead of user
> space, it won't be a big deal to violate that.

The legacy scheduling layer used 2*128 by default, that's why I used the
"magic" 256 internally. FWIW, I agree with Omar here. If it's set to
256, we must honor that. Users will tweak this value down to trade peak
performance for latency, it's important that it does what it advertises.

> Secondly, when there is enough tags available, it might hurt
> performance if we don't use them all.

That's mostly bogus. Crazy large tag depths have only one use case -
synthetic peak performance benchmarks from manufacturers. We don't want
to allow really deep queues. Nothing good comes from that, just a lot of
pain and latency issues.

The most important part is actually that the scheduler has a higher
depth than the device, as mentioned in an email from a few days ago. We
need to be able to actually schedule IO to the device, we can't do that
if we always deplete the scheduler queue by letting the device drain it.

-- 
Jens Axboe
