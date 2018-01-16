Return-Path: <msnitzer@redhat.com>
Date: Tue, 16 Jan 2018 17:32:08 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] block: Protect less code with sysfs_lock in
 blk_{un,}register_queue()
Message-ID: <20180116223207.GA32637@redhat.com>
References: <20180116181752.25847-1-bart.vanassche@wdc.com>
 <20180116181752.25847-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180116181752.25847-4-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 16 2018 at  1:17pm -0500,
Bart Van Assche <bart.vanassche@wdc.com> wrote:

> The __blk_mq_register_dev(), blk_mq_unregister_dev(),
> elv_register_queue() and elv_unregister_queue() calls need to be
> protected with sysfs_lock but other code in these functions not.
> Hence protect only this code with sysfs_lock. This patch fixes a
> locking inversion issue in blk_unregister_queue() and also in an
> error path of blk_register_queue(): it is not allowed to hold
> sysfs_lock around the kobject_del(&q->kobj) call.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> ---
>  block/blk-sysfs.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 4a6a40ffd78e..e9ce45ff0ef2 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -909,11 +909,12 @@ int blk_register_queue(struct gendisk *disk)
>  	if (q->request_fn || (q->mq_ops && q->elevator)) {
>  		ret = elv_register_queue(q);
>  		if (ret) {
> +			mutex_unlock(&q->sysfs_lock);
>  			kobject_uevent(&q->kobj, KOBJ_REMOVE);
>  			kobject_del(&q->kobj);
>  			blk_trace_remove_sysfs(dev);
>  			kobject_put(&dev->kobj);
> -			goto unlock;
> +			return ret;
>  		}
>  	}
>  	ret = 0;
> @@ -934,28 +935,22 @@ void blk_unregister_queue(struct gendisk *disk)
>  	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
>  		return;
>  
> -	/*
> -	 * Protect against the 'queue' kobj being accessed
> -	 * while/after it is removed.
> -	 */
> -	mutex_lock(&q->sysfs_lock);
> -
>  	spin_lock_irq(q->queue_lock);
>  	queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
>  	spin_unlock_irq(q->queue_lock);
>  
>  	wbt_exit(q);
>  
> +	mutex_lock(&q->sysfs_lock);
>  	if (q->mq_ops)
>  		blk_mq_unregister_dev(disk_to_dev(disk), q);
>  
>  	if (q->request_fn || (q->mq_ops && q->elevator))
>  		elv_unregister_queue(q);

My concern with this change is detailed in the following portion of
the header for commit 667257e8b2988c0183ba23e2bcd6900e87961606:

    2) Conversely, __elevator_change() is testing for QUEUE_FLAG_REGISTERED
    in case elv_iosched_store() loses the race with blk_unregister_queue(),
    it needs a way to know the 'queue' kobj isn't there.

I don't think moving mutex_lock(&q->sysfs_lock); after the clearing of
QUEUE_FLAG_REGISTERED is a step in the right direction.

Current code shows:

blk_cleanup_queue() calls blk_set_queue_dying() while holding
the sysfs_lock.

queue_attr_{show,store} both test if blk_queue_dying(q) while holding
the sysfs_lock.

BUT drivers can/do call del_gendisk() _before_ blk_cleanup_queue().
(if your proposed change above were to go in all of the block drivers
would first need to be audited for the need to call blk_cleanup_queue()
before del_gendisk() -- seems awful).

Therefore it seems to me that all queue_attr_{show,store} are racey vs
blk_unregister_queue() removing the 'queue' kobject.

And it was just that __elevator_change() was myopicly fixed to address
the race whereas a more generic solution was/is needed.  But short of
that more generic fix your change will reintroduce the potential for
hitting the issue that commit e9a823fb34a8b fixed.

In that light, think it best to leave blk_unregister_queue()'s
mutex_lock() above the QUEUE_FLAG_REGISTERED clearing _and_ update
queue_attr_{show,store} to test for QUEUE_FLAG_REGISTERED while holding
sysfs_lock.

Then remove the unicorn test_bit for QUEUE_FLAG_REGISTERED from
__elevator_change().

But it could be I'm wrong for some reason.. as you know that happens ;)

Mike
