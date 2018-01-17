Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1516147421.2844.70.camel@wdc.com>
References: <20180116181752.25847-1-bart.vanassche@wdc.com>
 <20180116181752.25847-4-bart.vanassche@wdc.com> <20180116223207.GA32637@redhat.com>
 <1516147421.2844.70.camel@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 17 Jan 2018 09:23:59 +0800
Message-ID: <CACVXFVMtUq8Mru8f7AD+6rQch+59=yRNL0-xOc4k7mmp4VanpA@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: Protect less code with sysfs_lock in blk_{un,}register_queue()
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "snitzer@redhat.com" <snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 17, 2018 at 8:03 AM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Tue, 2018-01-16 at 17:32 -0500, Mike Snitzer wrote:
>> Therefore it seems to me that all queue_attr_{show,store} are racey vs
>> blk_unregister_queue() removing the 'queue' kobject.
>>
>> And it was just that __elevator_change() was myopicly fixed to address
>> the race whereas a more generic solution was/is needed.  But short of
>> that more generic fix your change will reintroduce the potential for
>> hitting the issue that commit e9a823fb34a8b fixed.
>>
>> In that light, think it best to leave blk_unregister_queue()'s
>> mutex_lock() above the QUEUE_FLAG_REGISTERED clearing _and_ update
>> queue_attr_{show,store} to test for QUEUE_FLAG_REGISTERED while holding
>> sysfs_lock.
>>
>> Then remove the unicorn test_bit for QUEUE_FLAG_REGISTERED from
>> __elevator_change().
>
> Thanks Mike for the feedback. However, I think a simpler approach exists than
> what has been described above, namely by unregistering the sysfs attributes
> earlier. How about the patch below?
>
> [PATCH] block: Protect less code with sysfs_lock in blk_{un,}register_queue()
> ---
>  block/blk-sysfs.c | 39 ++++++++++++++++++++++++++-------------
>  block/elevator.c  |  4 ----
>  2 files changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 4a6a40ffd78e..ce32366c6db7 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -853,6 +853,10 @@ struct kobj_type blk_queue_ktype = {
>         .release        = blk_release_queue,
>  };
>
> +/**
> + * blk_register_queue - register a block layer queue with sysfs
> + * @disk: Disk of which the request queue should be registered with sysfs.
> + */
>  int blk_register_queue(struct gendisk *disk)
>  {
>         int ret;
> @@ -909,11 +913,12 @@ int blk_register_queue(struct gendisk *disk)
>         if (q->request_fn || (q->mq_ops && q->elevator)) {
>                 ret = elv_register_queue(q);
>                 if (ret) {
> +                       mutex_unlock(&q->sysfs_lock);
>                         kobject_uevent(&q->kobj, KOBJ_REMOVE);
>                         kobject_del(&q->kobj);
>                         blk_trace_remove_sysfs(dev);
>                         kobject_put(&dev->kobj);
> -                       goto unlock;
> +                       return ret;
>                 }
>         }
>         ret = 0;
> @@ -923,6 +928,13 @@ int blk_register_queue(struct gendisk *disk)
>  }
>  EXPORT_SYMBOL_GPL(blk_register_queue);
>
> +/**
> + * blk_unregister_queue - counterpart of blk_register_queue()
> + * @disk: Disk of which the request queue should be unregistered from sysfs.
> + *
> + * Note: the caller is responsible for guaranteeing that this function is called
> + * after blk_register_queue() has finished.
> + */
>  void blk_unregister_queue(struct gendisk *disk)
>  {
>         struct request_queue *q = disk->queue;
> @@ -934,28 +946,29 @@ void blk_unregister_queue(struct gendisk *disk)
>         if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
>                 return;
>
> -       /*
> -        * Protect against the 'queue' kobj being accessed
> -        * while/after it is removed.
> -        */
> -       mutex_lock(&q->sysfs_lock);
> -
>         spin_lock_irq(q->queue_lock);
>         queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
>         spin_unlock_irq(q->queue_lock);
>
> -       wbt_exit(q);
> -
> +       /*
> +        * Remove the sysfs attributes before unregistering the queue data
> +        * structures that can be modified through sysfs.
> +        */
> +       mutex_lock(&q->sysfs_lock);
>         if (q->mq_ops)
>                 blk_mq_unregister_dev(disk_to_dev(disk), q);
> -
> -       if (q->request_fn || (q->mq_ops && q->elevator))
> -               elv_unregister_queue(q);
> +       mutex_unlock(&q->sysfs_lock);
>
>         kobject_uevent(&q->kobj, KOBJ_REMOVE);
>         kobject_del(&q->kobj);

elevator switch still can come just after the above line code is completed,
so the previous warning addressed in e9a823fb34a8b can be triggered
again.

>         blk_trace_remove_sysfs(disk_to_dev(disk));
> -       kobject_put(&disk_to_dev(disk)->kobj);
>
> +       wbt_exit(q);
> +
> +       mutex_lock(&q->sysfs_lock);
> +       if (q->request_fn || (q->mq_ops && q->elevator))
> +               elv_unregister_queue(q);
>         mutex_unlock(&q->sysfs_lock);
> +
> +       kobject_put(&disk_to_dev(disk)->kobj);
>  }
> diff --git a/block/elevator.c b/block/elevator.c
> index e87e9b43aba0..4b7957b28a99 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -1080,10 +1080,6 @@ static int __elevator_change(struct request_queue *q, const char *name)
>         char elevator_name[ELV_NAME_MAX];
>         struct elevator_type *e;
>
> -       /* Make sure queue is not in the middle of being removed */
> -       if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
> -               return -ENOENT;
> -

The above check shouldn't be removed, as I explained above.



-- 
Ming Lei
