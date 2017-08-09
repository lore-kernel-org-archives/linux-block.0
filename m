Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <dada2f16-1c86-e474-a71b-b6d51be9e77a@redhat.com>
References: <20170807193818.GA22737@rage> <CACVXFVPqY-Sz65uUtWAWu2wSS=Z0nU0NQnTaGmfOdfxcMVnwzQ@mail.gmail.com>
 <dada2f16-1c86-e474-a71b-b6d51be9e77a@redhat.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 9 Aug 2017 09:44:12 +0800
Message-ID: <CACVXFVPe8qDdmHapUzeU_AGeVpMAge4LTKb5dU5bmjuxh5Echw@mail.gmail.com>
Subject: Re: [PATCH] block: Fix warning when I/O elevator is changed as
 request_queue is being removed
To: David Jeffery <djeffery@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi David,

On Wed, Aug 9, 2017 at 2:13 AM, David Jeffery <djeffery@redhat.com> wrote:
> On 08/07/2017 07:53 PM, Ming Lei wrote:
>> On Tue, Aug 8, 2017 at 3:38 AM, David Jeffery <djeffery@redhat.com> wrote:
>
>>>
>>> Signed-off-by: David Jeffery <djeffery@redhat.com>
>>> ---
>>>  block/blk-sysfs.c |    2 ++
>>>  block/elevator.c  |    4 ++++
>>>  2 files changed, 6 insertions(+)
>>>
>>>
>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>> index 27aceab..b8362c0 100644
>>> --- a/block/blk-sysfs.c
>>> +++ b/block/blk-sysfs.c
>>> @@ -931,7 +931,9 @@ void blk_unregister_queue(struct gendisk *disk)
>>>         if (WARN_ON(!q))
>>>                 return;
>>>
>>> +       mutex_lock(&q->sysfs_lock);
>>>         queue_flag_clear_unlocked(QUEUE_FLAG_REGISTERED, q);
>>> +       mutex_unlock(&q->sysfs_lock);
>>
>> Could you share why the lock of 'q->sysfs_lock' is needed here?
>
> As the elevator change is initiated through a sysfs attr file in the
> queue directory, the task doing the elevator change already acquires the
> q->sysfs_lock before it can try and change the elevator.  Adding the

It is e->sysfs_lock which is held in elv_attr_store(), instead of q->sysfs_lock.

> lock around clearing QUEUE_FLAG_REGISTERED ensures that the queue state
> will be stable while the elevator is being changed.  It prevents a race
> condition where the bit is checked but then cleared and queue removed
> from sysfs before the elevator change completes.
>
>>
>>>
>>>         wbt_exit(q);
>>>
>>> diff --git a/block/elevator.c b/block/elevator.c
>>> index 4bb2f0c..51da592 100644
>>> --- a/block/elevator.c
>>> +++ b/block/elevator.c
>>> @@ -1055,6 +1055,10 @@ static int __elevator_change(struct request_queue *q, const char *name)
>>>         char elevator_name[ELV_NAME_MAX];
>>>         struct elevator_type *e;
>>>
>>> +       /* Make sure queue is not in the middle of being removed */
>>> +       if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
>>> +               return -ENOENT;
>>> +
>>
>> I suggest to check 'e->registered' here, which should be more
>> reasonable or straightforward.
>>
>
> e->registered is not the state needing to be checked.  We need to know
> the state of the associated request queue.
>
> Before changing the elevator, we need to ensure the request queue is
> still connected to sysfs.  i.e. We need to know that kobject_del has not
> been called on the request queue.  When QUEUE_FLAG_REGISTERED is not set
> it means the request queue either has had kobject_del called or will
> have it called soon, so we should fail the elevator change attempt.

elv_unregister_queue() is called in blk_unregister_queue() too, that is why
I suggest to check e->registered.


-- 
Ming Lei
