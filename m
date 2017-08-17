Return-Path: <longman@redhat.com>
Subject: Re: [PATCH v2] blktrace: Fix potentail deadlock between delete &
 sysfs ops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <1502916040-18067-1-git-send-email-longman@redhat.com>
 <20170817093444.3276f7ab@gandalf.local.home>
From: Waiman Long <longman@redhat.com>
Message-ID: <b0719c60-5c07-d121-1c84-d5993d36afb0@redhat.com>
Date: Thu, 17 Aug 2017 12:24:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170817093444.3276f7ab@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/17/2017 09:34 AM, Steven Rostedt wrote:
> On Wed, 16 Aug 2017 16:40:40 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>> The lockdep code had reported the following unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(s_active#228);
>>                                lock(&bdev->bd_mutex/1);
>>                                lock(s_active#228);
>>   lock(&bdev->bd_mutex);
> Can you show the exact locations of these locks. I have no idea where
> this "s_active" is.
The s_active isn't an actual lock. It is a reference count (kn->count)
on the sysfs (kernfs) file. Removal of a sysfs file, however, require
a wait until all the references are gone. The reference count is
treated like a rwsem using lockdep instrumentation code.

>>  *** DEADLOCK ***
>>
>> The deadlock may happen when one task (CPU1) is trying to delete
>> a partition in a block device and another task (CPU0) is accessing
>> tracing sysfs file in that partition.
>>
>> To avoid that, accessing tracing sysfs file will now use a mutex
>> trylock loop and the operation will fail if a delete operation is
>> in progress.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>
>>  v2:
>>    - Use READ_ONCE() and smp_store_mb() to read and write bd_deleting.=

>>    - Check for signal in the mutex_trylock loops.
>>    - Use usleep() instead of schedule() for RT tasks.
> I'm sorry but I really do hate this patch.

Any suggestion on how to make it better?

>>  block/ioctl.c           |  3 +++
>>  include/linux/fs.h      |  1 +
>>  kernel/trace/blktrace.c | 39 +++++++++++++++++++++++++++++++++++++--
>>  3 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 0de02ee..b920329 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -86,12 +86,15 @@ static int blkpg_ioctl(struct block_device *bdev, =
struct blkpg_ioctl_arg __user
>>  				return -EBUSY;
>>  			}
>>  			/* all seems OK */
>> +			smp_store_mb(bdev->bd_deleting, 1);
> No comment to explain what is happening here, and why.

I am going to add a comment block here.

>>  			fsync_bdev(bdevp);
>>  			invalidate_bdev(bdevp);
>> =20
>>  			mutex_lock_nested(&bdev->bd_mutex, 1);
>>  			delete_partition(disk, partno);
>>  			mutex_unlock(&bdev->bd_mutex);
>> +			smp_store_mb(bdev->bd_deleting, 0);
>> +
> ditto.
>
>>  			mutex_unlock(&bdevp->bd_mutex);
>>  			bdput(bdevp);
>> =20
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 6e1fd5d..c2ba35e 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -427,6 +427,7 @@ struct block_device {
>>  #endif
>>  	struct block_device *	bd_contains;
>>  	unsigned		bd_block_size;
>> +	int			bd_deleting;
>>  	struct hd_struct *	bd_part;
>>  	/* number of times partitions within this device have been opened. *=
/
>>  	unsigned		bd_part_count;
>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
>> index bc364f8..b2dffa9 100644
>> --- a/kernel/trace/blktrace.c
>> +++ b/kernel/trace/blktrace.c
>> @@ -27,6 +27,8 @@
>>  #include <linux/time.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/list.h>
>> +#include <linux/delay.h>
>> +#include <linux/sched/rt.h>
>> =20
>>  #include "../../block/blk.h"
>> =20
>> @@ -1605,6 +1607,23 @@ static struct request_queue *blk_trace_get_queu=
e(struct block_device *bdev)
>>  	return bdev_get_queue(bdev);
>>  }
>> =20
>> +/*
>> + * Read/write to the tracing sysfs file requires taking references to=
 the
> What's the "tracing sysfs" file? tracefs?

I am referring to blk_trace sysfs files which are used for enable
tracing of block operations.

>> + * sysfs file and then acquiring the bd_mutex. Deleting a block devic=
e
>> + * requires acquiring the bd_mutex and then waiting for all the sysfs=

>> + * references to be gone. This can lead to deadlock if both operation=
s
>> + * happen simultaneously. To avoid this problem, read/write to the
>> + * the tracing sysfs files can now fail if the bd_mutex cannot be
>> + * acquired while a deletion operation is in progress.
>> + *
>> + * A mutex trylock loop is used assuming that tracing sysfs operation=
s
> A mutex trylock loop is not enough to stop a deadlock. But I'm guessing=

> the undocumented bd_deleting may prevent that.

Yes, that is what the bd_deleting flag is for.

I was thinking about failing the sysfs operation after a certain number
of trylock attempts, but then it will require changes to user space code
to handle the occasional failures. Finally I decided to fail it only
when a delete operation is in progress as all hopes are lost in this case=
=2E

>> + * aren't frequently enough to cause any contention problem.
>> + *
>> + * For RT tasks, a running high priority task will prevent any lower
>> + * priority RT tasks from being run. So they do need to actually slee=
p
>> + * when the trylock fails to allow lower priority tasks to make forwa=
rd
>> + * progress.
>> + */
>>  static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
>>  					 struct device_attribute *attr,
>>  					 char *buf)
>> @@ -1622,7 +1641,15 @@ static ssize_t sysfs_blk_trace_attr_show(struct=
 device *dev,
>>  	if (q =3D=3D NULL)
>>  		goto out_bdput;
>> =20
>> -	mutex_lock(&bdev->bd_mutex);
>> +	while (!mutex_trylock(&bdev->bd_mutex)) {
>> +		if (READ_ONCE(bdev->bd_deleting))
>> +			goto out_bdput;
>> +		if (signal_pending(current)) {
>> +			ret =3D -EINTR;
>> +			goto out_bdput;
>> +		}
>> +		rt_task(current) ? usleep_range(10, 10) : schedule();
> We need to come up with a better solution. This is just a hack that
> circumvents a lot of the lockdep infrastructure.
>
> -- Steve

The root cause is the lock inversion under this circumstance. I think
modifying the blk_trace code has the least impact overall. I agree that
the code is ugly. If you have a better suggestion, I will certainly like
to hear it.

Cheers,
Longman
