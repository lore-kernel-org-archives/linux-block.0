Return-Path: <jack@suse.cz>
Date: Sat, 5 Nov 2016 23:37:44 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH 5/8] block: add code to track actual device queue depth
Message-ID: <20161105223744.GF32353@quack2.suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-6-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034531-28559-6-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue 01-11-16 15:08:48, Jens Axboe wrote:
> For blk-mq, ->nr_requests does track queue depth, at least at init
> time. But for the older queue paths, it's simply a soft setting.
> On top of that, it's generally larger than the hardware setting
> on purpose, to allow backup of requests for merging.
> 
> Fill a hole in struct request with a 'queue_depth' member, that
> drivers can call to more closely inform the block layer of the
> real queue depth.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  block/blk-settings.c   | 12 ++++++++++++
>  drivers/scsi/scsi.c    |  3 +++
>  include/linux/blkdev.h | 11 +++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 55369a65dea2..9cf053759363 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -837,6 +837,18 @@ void blk_queue_flush_queueable(struct request_queue *q, bool queueable)
>  EXPORT_SYMBOL_GPL(blk_queue_flush_queueable);
>  
>  /**
> + * blk_set_queue_depth - tell the block layer about the device queue depth
> + * @q:		the request queue for the device
> + * @depth:		queue depth
> + *
> + */
> +void blk_set_queue_depth(struct request_queue *q, unsigned int depth)
> +{
> +	q->queue_depth = depth;
> +}
> +EXPORT_SYMBOL(blk_set_queue_depth);
> +
> +/**
>   * blk_queue_write_cache - configure queue's write cache
>   * @q:		the request queue for the device
>   * @wc:		write back cache on or off
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 1deb6adc411f..75455d4dab68 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -621,6 +621,9 @@ int scsi_change_queue_depth(struct scsi_device *sdev, int depth)
>  		wmb();
>  	}
>  
> +	if (sdev->request_queue)
> +		blk_set_queue_depth(sdev->request_queue, depth);
> +
>  	return sdev->queue_depth;
>  }
>  EXPORT_SYMBOL(scsi_change_queue_depth);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8396da2bb698..0c677fb35ce4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -405,6 +405,8 @@ struct request_queue {
>  	struct blk_mq_ctx __percpu	*queue_ctx;
>  	unsigned int		nr_queues;
>  
> +	unsigned int		queue_depth;
> +
>  	/* hw dispatch queues */
>  	struct blk_mq_hw_ctx	**queue_hw_ctx;
>  	unsigned int		nr_hw_queues;
> @@ -777,6 +779,14 @@ static inline bool blk_write_same_mergeable(struct bio *a, struct bio *b)
>  	return false;
>  }
>  
> +static inline unsigned int blk_queue_depth(struct request_queue *q)
> +{
> +	if (q->queue_depth)
> +		return q->queue_depth;
> +
> +	return q->nr_requests;
> +}
> +
>  /*
>   * q->prep_rq_fn return values
>   */
> @@ -1093,6 +1103,7 @@ extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
>  extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
>  extern void blk_limits_io_opt(struct queue_limits *limits, unsigned int opt);
>  extern void blk_queue_io_opt(struct request_queue *q, unsigned int opt);
> +extern void blk_set_queue_depth(struct request_queue *q, unsigned int depth);
>  extern void blk_set_default_limits(struct queue_limits *lim);
>  extern void blk_set_stacking_limits(struct queue_limits *lim);
>  extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
