Return-Path: <prvs=7490ff4ab=roger.pau@citrix.com>
Date: Mon, 6 Aug 2018 18:16:38 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Juergen Gross <jgross@suse.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>, <axboe@kernel.dk>,
	<boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 2/4] xen/blkfront: cleanup stale persistent grants
Message-ID: <20180806161638.nmjamflckekeuyzb@mac>
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20180806113403.24728-4-jgross@suse.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 06, 2018 at 01:34:01PM +0200, Juergen Gross wrote:
> Add a periodic cleanup function to remove old persistent grants which
> are no longer in use on the backend side. This avoids starvation in
> case there are lots of persistent grants for a device which no longer
> is involved in I/O business.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/block/xen-blkfront.c | 99 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index b5cedccb5d7d..19feb8835fc4 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -46,6 +46,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/bitmap.h>
>  #include <linux/list.h>
> +#include <linux/workqueue.h>
>  
>  #include <xen/xen.h>
>  #include <xen/xenbus.h>
> @@ -121,6 +122,9 @@ static inline struct blkif_req *blkif_req(struct request *rq)
>  
>  static DEFINE_MUTEX(blkfront_mutex);
>  static const struct block_device_operations xlvbd_block_fops;
> +static struct delayed_work blkfront_work;
> +static LIST_HEAD(info_list);
> +static bool blkfront_work_active;
>  
>  /*
>   * Maximum number of segments in indirect requests, the actual value used by
> @@ -216,6 +220,7 @@ struct blkfront_info
>  	/* Save uncomplete reqs and bios for migration. */
>  	struct list_head requests;
>  	struct bio_list bio_list;
> +	struct list_head info_list;
>  };
>  
>  static unsigned int nr_minors;
> @@ -1764,6 +1769,12 @@ static int write_per_ring_nodes(struct xenbus_transaction xbt,
>  	return err;
>  }
>  
> +static void free_info(struct blkfront_info *info)
> +{
> +	list_del(&info->info_list);
> +	kfree(info);
> +}
> +
>  /* Common code used when first setting up, and when resuming. */
>  static int talk_to_blkback(struct xenbus_device *dev,
>  			   struct blkfront_info *info)
> @@ -1885,7 +1896,10 @@ static int talk_to_blkback(struct xenbus_device *dev,
>   destroy_blkring:
>  	blkif_free(info, 0);
>  
> -	kfree(info);
> +	mutex_lock(&blkfront_mutex);
> +	free_info(info);
> +	mutex_unlock(&blkfront_mutex);
> +
>  	dev_set_drvdata(&dev->dev, NULL);
>  
>  	return err;
> @@ -1996,6 +2010,10 @@ static int blkfront_probe(struct xenbus_device *dev,
>  	info->handle = simple_strtoul(strrchr(dev->nodename, '/')+1, NULL, 0);
>  	dev_set_drvdata(&dev->dev, info);
>  
> +	mutex_lock(&blkfront_mutex);
> +	list_add(&info->info_list, &info_list);
> +	mutex_unlock(&blkfront_mutex);
> +
>  	return 0;
>  }
>  
> @@ -2306,6 +2324,15 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
>  	if (indirect_segments <= BLKIF_MAX_SEGMENTS_PER_REQUEST)
>  		indirect_segments = 0;
>  	info->max_indirect_segments = indirect_segments;
> +
> +	if (info->feature_persistent) {
> +		mutex_lock(&blkfront_mutex);
> +		if (!blkfront_work_active) {
> +			blkfront_work_active = true;
> +			schedule_delayed_work(&blkfront_work, HZ * 10);

Does it make sense to provide a module parameter to rune the schedule
of the cleanup routine?

> +		}
> +		mutex_unlock(&blkfront_mutex);

Is it really necessary to have the blkfront_work_active boolean? What
happens if you queue the same delayed work more than once?

Thanks, Roger.
