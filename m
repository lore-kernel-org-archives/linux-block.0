Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 21 Apr 2017 15:05:18 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v3 1/8] blk-mq: Register <dev>/queue/mq after having
 registered <dev>/queue
Message-ID: <20170421220518.GA17177@vader.DHCP.thefacebook.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
 <20170418232949.5228-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418232949.5228-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 04:29:42PM -0700, Bart Van Assche wrote:
> A later patch in this series will modify blk_mq_debugfs_register()
> such that it uses q->kobj.parent to determine the name of a
> request queue. Hence make sure that that pointer is initialized
> before blk_mq_debugfs_register() is called. To avoid lock inversion,
> protect sysfs / debugfs registration with the queue sysfs_lock
> instead of the global mutex all_q_mutex.

I think this is sane, I don't see why we would need all_q_mutex for
this. One comment below, however.

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-sysfs.c | 43 +++++++++++++++++++++++++++++++++++--------
>  block/blk-mq.h       |  1 +
>  block/blk-sysfs.c    |  6 +++---
>  3 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index d745ab81033a..54ef9402914c 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -253,6 +253,8 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
>  	struct blk_mq_hw_ctx *hctx;
>  	int i;
>  
> +	lockdep_assert_held(&q->sysfs_lock);
> +
>  	queue_for_each_hw_ctx(q, hctx, i)
>  		blk_mq_unregister_hctx(hctx);
>  
> @@ -267,9 +269,9 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
>  
>  void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
>  {
> -	blk_mq_disable_hotplug();
> +	mutex_lock(&q->sysfs_lock);
>  	__blk_mq_unregister_dev(dev, q);
> -	blk_mq_enable_hotplug();
> +	mutex_unlock(&q->sysfs_lock);
>  }
>  
>  void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
> @@ -302,12 +304,13 @@ void blk_mq_sysfs_init(struct request_queue *q)
>  	}
>  }
>  
> -int blk_mq_register_dev(struct device *dev, struct request_queue *q)
> +int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
>  {
>  	struct blk_mq_hw_ctx *hctx;
>  	int ret, i;
>  
> -	blk_mq_disable_hotplug();
> +	WARN_ON_ONCE(!q->kobj.parent);
> +	lockdep_assert_held(&q->sysfs_lock);
>  
>  	ret = kobject_add(&q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
>  	if (ret < 0)
> @@ -327,8 +330,20 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
>  		__blk_mq_unregister_dev(dev, q);
>  	else
>  		q->mq_sysfs_init_done = true;
> +
>  out:
> -	blk_mq_enable_hotplug();
> +	return ret;
> +}
> +
> +int blk_mq_register_dev(struct device *dev, struct request_queue *q)
> +{
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&q->sysfs_lock);

Why did you make this interruptible? blk_mq_disable_hotplug() wasn't
interruptible before, so now dm_mq_init_request_queue() can fail
silently if it is interrupted.
