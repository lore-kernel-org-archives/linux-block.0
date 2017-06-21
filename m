Return-Path: <ming.lei@redhat.com>
Date: Wed, 21 Jun 2017 09:42:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] blk-mq: Make it safe to call
 blk_mq_quiesce_queue_nowait() from an interrupt handler
Message-ID: <20170621014231.GA8382@ming.t460p>
References: <20170620164020.18260-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170620164020.18260-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 20, 2017 at 09:40:20AM -0700, Bart Van Assche wrote:
> Since blk_mq_quiesce_queue_nowait() can be called from interrupt
> context, make this safe. Since this function is not in the hot
> path, uninline it. Untested.
> 
> Fixes: commit f4560ffe8cec ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  block/blk-mq.c         | 14 ++++++++++++++
>  include/linux/blk-mq.h | 10 +---------
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1c4f1f4978c6..92faf340dc92 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -153,6 +153,20 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
>  
> +/*
> + * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
> + * mpt3sas driver such that this function can be removed.
> + */
> +void blk_mq_quiesce_queue_nowait(struct request_queue *q)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> +	spin_unlock_irqrestore(q->queue_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
> +
>  /**
>   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>   * @q: request queue.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 366b83cee955..23d32ff0b462 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -266,15 +266,7 @@ int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
>  int blk_mq_map_queues(struct blk_mq_tag_set *set);
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
>  
> -/*
> - * FIXME: this helper is just for working around mpt3sas.
> - */
> -static inline void blk_mq_quiesce_queue_nowait(struct request_queue *q)
> -{
> -	spin_lock_irq(q->queue_lock);
> -	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> -	spin_unlock_irq(q->queue_lock);
> -}
> +void blk_mq_quiesce_queue_nowait(struct request_queue *q);
>  
>  /*
>   * Driver command data is immediately after the request. So subtract request
> -- 
> 2.13.1
> 

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
