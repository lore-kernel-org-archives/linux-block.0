Return-Path: <hare@suse.de>
Subject: Re: [PATCH 23/28] block: kill lld busy
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-24-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c9310098-e59c-da81-e59f-5b5870962438@suse.de>
Date: Mon, 29 Oct 2018 08:10:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-24-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Nobody sets the helper, so we always return 0. Kill it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-core.c       | 28 ----------------------------
>   block/blk-settings.c   |  6 ------
>   drivers/md/dm-mpath.c  |  4 +---
>   include/linux/blkdev.h |  4 ----
>   4 files changed, 1 insertion(+), 41 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4c39c7865f9c..dd1328f4dc31 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1795,34 +1795,6 @@ void rq_flush_dcache_pages(struct request *rq)
>   EXPORT_SYMBOL_GPL(rq_flush_dcache_pages);
>   #endif
>   
> -/**
> - * blk_lld_busy - Check if underlying low-level drivers of a device are busy
> - * @q : the queue of the device being checked
> - *
> - * Description:
> - *    Check if underlying low-level drivers of a device are busy.
> - *    If the drivers want to export their busy state, they must set own
> - *    exporting function using blk_queue_lld_busy() first.
> - *
> - *    Basically, this function is used only by request stacking drivers
> - *    to stop dispatching requests to underlying devices when underlying
> - *    devices are busy.  This behavior helps more I/O merging on the queue
> - *    of the request stacking driver and prevents I/O throughput regression
> - *    on burst I/O load.
> - *
> - * Return:
> - *    0 - Not busy (The request stacking driver should dispatch request)
> - *    1 - Busy (The request stacking driver should stop dispatching request)
> - */
> -int blk_lld_busy(struct request_queue *q)
> -{
> -	if (q->lld_busy_fn)
> -		return q->lld_busy_fn(q);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(blk_lld_busy);
> -
>   /**
>    * blk_rq_unprep_clone - Helper function to free all bios in a cloned request
>    * @rq: the clone request to be cleaned up
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 3c5da75c2def..1895f499bbe5 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -32,12 +32,6 @@ void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
>   }
>   EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
>   
> -void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn)
> -{
> -	q->lld_busy_fn = fn;
> -}
> -EXPORT_SYMBOL_GPL(blk_queue_lld_busy);
> -
>   /**
>    * blk_set_default_limits - reset limits to default values
>    * @lim:  the queue_limits structure to reset
> diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
> index a24ed3973e7c..4d736e0fd67f 100644
> --- a/drivers/md/dm-mpath.c
> +++ b/drivers/md/dm-mpath.c
> @@ -1936,9 +1936,7 @@ static int multipath_iterate_devices(struct dm_target *ti,
>   
>   static int pgpath_busy(struct pgpath *pgpath)
>   {
> -	struct request_queue *q = bdev_get_queue(pgpath->path.dev->bdev);
> -
> -	return blk_lld_busy(q);
> +	return 0;
>   }
>   
>   /*
Actually, I'm not quite sure this is correct; dm-mpath needs to return a 
busy status (via the '->busy' callback) to allow for back-pressure on 
the upper layers.
Just disabling the callback will disable this.
Shouldn't we check if the tagmap is busy here?

Cheers,

Hannes
