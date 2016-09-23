Return-Path: <prvs=8074f4b59d=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: Ming Lei <ming.lei@canonical.com>
CC: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        "Jens
 Axboe" <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: add flag for drivers wanting blocking
 ->queue_rq()
Date: Fri, 23 Sep 2016 02:44:03 +0000
Message-ID: <2FC6BB17-F15F-4EE8-8280-3BE20B527827@fb.com>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-3-git-send-email-axboe@fb.com>
 <20160922145922.GB1800@infradead.org>
 <a4162d4e-dc64-0e76-6f0c-3ff12eb0231c@fb.com>
 <20160922151222.GA515@infradead.org>
 <ef600cc3-f8cc-bacf-5538-9eb8d7e2c95a@fb.com>,<CACVXFVOE9XU0ubtBPaSZdZnfFHi6ce+A=UhpJ+acbx=x5EJEug@mail.gmail.com>
In-Reply-To: <CACVXFVOE9XU0ubtBPaSZdZnfFHi6ce+A=UhpJ+acbx=x5EJEug@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


> On Sep 22, 2016, at 9:44 PM, Ming Lei <ming.lei@canonical.com> wrote:
>=20
>> On Thu, Sep 22, 2016 at 11:17 PM, Jens Axboe <axboe@fb.com> wrote:
>>> On 09/22/2016 09:12 AM, Christoph Hellwig wrote:
>>>=20
>>>> On Thu, Sep 22, 2016 at 09:03:56AM -0600, Jens Axboe wrote:
>>>>=20
>>>> Having to grab a mutex, for instance. We invoke ->queue_rq() with
>>>> preemption disabled, so I'd hope that would not be the case... What
>>>> drivers block in ->queue_rq?
>>>=20
>>>=20
>>> I though I had converted a lot of them to GFP_NOIO instead of GFP_ATOMI=
C
>>> allocations, but I can't find any evidence of that.  Maybe it was just
>>> my imagination, or an unsubmitted patch series.  Sorry for the
>>> confusion.
>>=20
>>=20
>> OK, that makes more sense. Pretty sure we would have had complaints!
>>=20
>>>> Loop was another case that was on my radar to get rid of the queue_wor=
k
>>>> it currently has to do. Josef is currently testing the nbd driver usin=
g
>>>> this approach, so we should get some numbers there too. If we have to,
>>>> we can always bump up the concurrency to mimic more of the behavior of
>>>> having multiple workers running on the hardware queue. I'd prefer to
>>>> still do that in blk-mq, instead of having drivers reinventing their o=
wn
>>>> work offload functionality.
>>>=20
>>>=20
>>> There should be a lot of numbers in the list archives from the time
>>> that Ming did the loop conversion, as I've been trying to steer him
>>> that way, and he actually implemented and benchmarked it.
>>>=20
>>> We can't just increase the concurrency as a single work_struct item
>>> can't be queued multiple times even on a high concurreny workqueue.
>>=20
>>=20
>> But we could have more work items, if we had to. Even if loop isn't a
>> drop-in replacement for this simpler approach, I think it'll work well
>> enough for nbd. The 5% number from Josef is comparing to not having any
>> offload at all, I suspect the number from just converting to queue_work
>> in the driver would be similar.
>=20
> 5% might be a noise.
>=20
> From nbd's .queue_rq(), kthread_work should match its case because
> one per-nbd mutex is required and all cmds sent to the nbd are serialized=
,
> so using common work items may hurt performance caused by
> unnecessary context switch.

This is with my multi connection patch with 4 connections per device (so 4 =
hw queues).  The 5% is real but I don't think it'll get better by punting t=
o a worker per command, so this approach is fine for NBD.  Thanks,

Josef=
