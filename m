Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACVXFVMMPWJVa6HYPWUziF25J5-MgVCNR+LiOYLUebY5TMEQcg@mail.gmail.com>
References: <20170807193818.GA22737@rage> <CACVXFVPqY-Sz65uUtWAWu2wSS=Z0nU0NQnTaGmfOdfxcMVnwzQ@mail.gmail.com>
 <dada2f16-1c86-e474-a71b-b6d51be9e77a@redhat.com> <CACVXFVPe8qDdmHapUzeU_AGeVpMAge4LTKb5dU5bmjuxh5Echw@mail.gmail.com>
 <CACVXFVMMPWJVa6HYPWUziF25J5-MgVCNR+LiOYLUebY5TMEQcg@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 28 Aug 2017 09:36:16 +0800
Message-ID: <CACVXFVNuOvfjNu-0MxtEAGH3854vTkTk86ZEWhWB1w-MJx_7jA@mail.gmail.com>
Subject: Re: [PATCH] block: Fix warning when I/O elevator is changed as
 request_queue is being removed
To: David Jeffery <djeffery@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 23, 2017 at 11:34 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Wed, Aug 9, 2017 at 9:44 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>> Hi David,
>>
>> On Wed, Aug 9, 2017 at 2:13 AM, David Jeffery <djeffery@redhat.com> wrote:
>>> On 08/07/2017 07:53 PM, Ming Lei wrote:
>>>> On Tue, Aug 8, 2017 at 3:38 AM, David Jeffery <djeffery@redhat.com> wrote:
>>>
>>>>>
>>>>> Signed-off-by: David Jeffery <djeffery@redhat.com>
>>>>> ---
>>>>>  block/blk-sysfs.c |    2 ++
>>>>>  block/elevator.c  |    4 ++++
>>>>>  2 files changed, 6 insertions(+)
>>>>>
>>>>>
>>>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>>>> index 27aceab..b8362c0 100644
>>>>> --- a/block/blk-sysfs.c
>>>>> +++ b/block/blk-sysfs.c
>>>>> @@ -931,7 +931,9 @@ void blk_unregister_queue(struct gendisk *disk)
>>>>>         if (WARN_ON(!q))
>>>>>                 return;
>>>>>
>>>>> +       mutex_lock(&q->sysfs_lock);
>>>>>         queue_flag_clear_unlocked(QUEUE_FLAG_REGISTERED, q);
>>>>> +       mutex_unlock(&q->sysfs_lock);
>>>>
>>>> Could you share why the lock of 'q->sysfs_lock' is needed here?
>>>
>>> As the elevator change is initiated through a sysfs attr file in the
>>> queue directory, the task doing the elevator change already acquires the
>>> q->sysfs_lock before it can try and change the elevator.  Adding the
>>
>> It is e->sysfs_lock which is held in elv_attr_store(), instead of q->sysfs_lock.
>
> Looks I was wrong, and the store is from queue_attr_store() instead of
> elv_attr_store().
>
> I can reproduce the issue and this patch can fix the issue in my test
> on scsi_debug,
> so:
>
>         Tested-by: Ming Lei <ming.lei@redhat.com>
>
> And it is a typical race between removing queue kobj and adding children of
> this queue kobj, we can't acquire q->sysfs_lock in blk_unregister_queue()
> because of sysfs's limit(may cause deadlock), so one state has to be used
> for this purpose, just like what register/unregister hctx kobjs does,
> and it should
> be fine to use QUEUE_FLAG_REGISTERED here. More changes are required if
> we use e->registered, so this patch looks fine:
>
>        Reviewed-by: Ming Lei <ming.lei@redhat.com>


Hi Jens,

Could you consider this patch for v4.13 or v4.14?


Thanks,
Ming Lei
