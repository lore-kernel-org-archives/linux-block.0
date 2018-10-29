Return-Path: <hare@suse.de>
Subject: Re: [PATCH 10/28] dasd: remove dead code
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-11-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <62abe687-cbcc-e15a-6702-79b44d4f3cc0@suse.de>
Date: Mon, 29 Oct 2018 07:54:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-11-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Since e443343e509a we haven't had a request_fn attached to
> this driver, hence any code inside an if (q->request_fn) is
> unreachable.
> 
> Fixes: e443343e509a ("s390/dasd: blk-mq conversion")
> [sth: Keep and fix the dasd_info->chanq_len counter.]
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/s390/block/dasd_ioctl.c | 22 +++++-----------------
>   1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 2016e0ed5865..8e26001dc11c 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -412,6 +412,7 @@ static int dasd_ioctl_information(struct dasd_block *block,
>   	struct ccw_dev_id dev_id;
>   	struct dasd_device *base;
>   	struct ccw_device *cdev;
> +	struct list_head *l;
>   	unsigned long flags;
>   	int rc;
>   
> @@ -462,23 +463,10 @@ static int dasd_ioctl_information(struct dasd_block *block,
>   
>   	memcpy(dasd_info->type, base->discipline->name, 4);
>   
> -	if (block->request_queue->request_fn) {
> -		struct list_head *l;
> -#ifdef DASD_EXTENDED_PROFILING
> -		{
> -			struct list_head *l;
> -			spin_lock_irqsave(&block->lock, flags);
> -			list_for_each(l, &block->request_queue->queue_head)
> -				dasd_info->req_queue_len++;
> -			spin_unlock_irqrestore(&block->lock, flags);
> -		}
> -#endif				/* DASD_EXTENDED_PROFILING */
> -		spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
> -		list_for_each(l, &base->ccw_queue)
> -			dasd_info->chanq_len++;
> -		spin_unlock_irqrestore(get_ccwdev_lock(base->cdev),
> -				       flags);
> -	}
> +	spin_lock_irqsave(&block->queue_lock, flags);
> +	list_for_each(l, &base->ccw_queue)
> +		dasd_info->chanq_len++;
> +	spin_unlock_irqrestore(&block->queue_lock, flags);
>   
>   	rc = 0;
>   	if (copy_to_user(argp, dasd_info,
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
