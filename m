Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 21 Apr 2017 15:16:28 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v3 3/8] blk-mq: Unregister debugfs attributes earlier
Message-ID: <20170421221628.GD17177@vader.DHCP.thefacebook.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
 <20170418232949.5228-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418232949.5228-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 04:29:44PM -0700, Bart Van Assche wrote:
> One of the debugfs attributes allows to run a queue. Since running
> a queue after a queue has entered the "dead" state is not allowed
> and even can cause a kernel crash, unregister the debugfs attributes
> before a queue reaches the "dead" state.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-sysfs.c | 31 ++++++-------------------------
>  block/blk-sysfs.c    |  3 +--
>  2 files changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 727e3b675130..1b2107f229ee 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -258,7 +258,7 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
>  	queue_for_each_hw_ctx(q, hctx, i)
>  		blk_mq_unregister_hctx(hctx);
>  
> -	blk_mq_debugfs_unregister_hctxs(q);
> +	blk_mq_debugfs_unregister(q);

This isn't what we want to do. First of all, we can't get remove the
/sys/kernel/debug/block/$dev directory until after we shutdown blktrace.
You unregister the top-level directory in other places, too. That should
only be done in the blk_release_queue() like it was originally.

More importantly, this doesn't actually fix the issue at hand. The
blk_mq_debugfs_unregister_hctxs() call needs to be moved earlier.
Actually, can you please rename blk_mq_debugfs_unregister_mq() to make
it more obvious that it removes the /sys/kernel/debug/block/$dev/mq
directory.

>  	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
>  	kobject_del(&q->mq_kobj);
> @@ -306,8 +306,7 @@ void blk_mq_sysfs_init(struct request_queue *q)
>  
>  int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
>  {
> -	struct blk_mq_hw_ctx *hctx;
> -	int ret, i;
> +	int ret;
>  
>  	WARN_ON_ONCE(!q->kobj.parent);
>  	lockdep_assert_held(&q->sysfs_lock);
> @@ -318,14 +317,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
>  
>  	kobject_uevent(&q->mq_kobj, KOBJ_ADD);
>  
> -	blk_mq_debugfs_register(q);
> -
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		ret = blk_mq_register_hctx(hctx);
> -		if (ret)
> -			break;
> -	}
> -

This gets rid of the /sys/block/$dev/mq/* entries in sysfs?
