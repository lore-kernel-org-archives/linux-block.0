Return-Path: <ming.lei@redhat.com>
Date: Mon, 15 Oct 2018 18:38:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/17] sunvdc: convert to blk-mq
Message-ID: <20181015103728.GC31722@ming.t460p>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181011165909.32615-2-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 11, 2018 at 10:58:53AM -0600, Jens Axboe wrote:
> Convert from the old request_fn style driver to blk-mq.
> 
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/sunvdc.c | 161 ++++++++++++++++++++++++++++-------------
>  1 file changed, 110 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> index f68e9baffad7..bf51a2307ce1 100644
> --- a/drivers/block/sunvdc.c
> +++ b/drivers/block/sunvdc.c
> @@ -6,7 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
> -#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/hdreg.h>
>  #include <linux/genhd.h>
>  #include <linux/cdrom.h>
> @@ -66,9 +66,10 @@ struct vdc_port {
>  
>  	u64			max_xfer_size;
>  	u32			vdisk_block_size;
> +	u32			drain;
>  
>  	u64			ldc_timeout;
> -	struct timer_list	ldc_reset_timer;
> +	struct delayed_work	ldc_reset_timer_work;
>  	struct work_struct	ldc_reset_work;
>  
>  	/* The server fills these in for us in the disk attribute
> @@ -80,12 +81,14 @@ struct vdc_port {
>  	u8			vdisk_mtype;
>  	u32			vdisk_phys_blksz;
>  
> +	struct blk_mq_tag_set	tag_set;
> +
>  	char			disk_name[32];
>  };
>  
>  static void vdc_ldc_reset(struct vdc_port *port);
>  static void vdc_ldc_reset_work(struct work_struct *work);
> -static void vdc_ldc_reset_timer(struct timer_list *t);
> +static void vdc_ldc_reset_timer_work(struct work_struct *work);
>  
>  static inline struct vdc_port *to_vdc_port(struct vio_driver_state *vio)
>  {
> @@ -175,11 +178,8 @@ static void vdc_blk_queue_start(struct vdc_port *port)
>  	 * handshake completes, so check for initial handshake before we've
>  	 * allocated a disk.
>  	 */
> -	if (port->disk && blk_queue_stopped(port->disk->queue) &&
> -	    vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50) {
> -		blk_start_queue(port->disk->queue);
> -	}
> -
> +	if (port->disk && vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
> +		blk_mq_start_hw_queues(port->disk->queue);
>  }
>  
>  static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)
> @@ -197,7 +197,7 @@ static void vdc_handshake_complete(struct vio_driver_state *vio)
>  {
>  	struct vdc_port *port = to_vdc_port(vio);
>  
> -	del_timer(&port->ldc_reset_timer);
> +	cancel_delayed_work(&port->ldc_reset_timer_work);
>  	vdc_finish(vio, 0, WAITING_FOR_LINK_UP);
>  	vdc_blk_queue_start(port);
>  }
> @@ -320,7 +320,7 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
>  
>  	rqe->req = NULL;
>  
> -	__blk_end_request(req, (desc->status ? BLK_STS_IOERR : 0), desc->size);
> +	blk_mq_end_request(req, desc->status ? BLK_STS_IOERR : 0);

blk_mq_end_request() may trigger BUG in case of partial completion,
however looks it is fine for __blk_end_request().

>  
>  	vdc_blk_queue_start(port);
>  }
> @@ -525,29 +525,40 @@ static int __send_request(struct request *req)
>  	return err;
>  }
>  
> -static void do_vdc_request(struct request_queue *rq)
> +static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
> +				 const struct blk_mq_queue_data *bd)
>  {
> -	struct request *req;
> +	struct vdc_port *port = hctx->queue->queuedata;
> +	struct vio_dring_state *dr;
> +	unsigned long flags;
>  
> -	while ((req = blk_peek_request(rq)) != NULL) {
> -		struct vdc_port *port;
> -		struct vio_dring_state *dr;
> +	dr = &port->vio.drings[VIO_DRIVER_TX_RING];
>  
> -		port = req->rq_disk->private_data;
> -		dr = &port->vio.drings[VIO_DRIVER_TX_RING];
> -		if (unlikely(vdc_tx_dring_avail(dr) < 1))
> -			goto wait;
> +	blk_mq_start_request(bd->rq);
>  
> -		blk_start_request(req);
> +	spin_lock_irqsave(&port->vio.lock, flags);
>  
> -		if (__send_request(req) < 0) {
> -			blk_requeue_request(rq, req);
> -wait:
> -			/* Avoid pointless unplugs. */
> -			blk_stop_queue(rq);
> -			break;
> -		}
> +	/*
> +	 * Doing drain, just end the request in error
> +	 */
> +	if (unlikely(port->drain)) {
> +		spin_unlock_irqrestore(&port->vio.lock, flags);
> +		return BLK_STS_IOERR;
>  	}
> +
> +	if (unlikely(vdc_tx_dring_avail(dr) < 1)) {
> +		spin_unlock_irqrestore(&port->vio.lock, flags);
> +		blk_mq_stop_hw_queue(hctx);
> +		return BLK_STS_DEV_RESOURCE;
> +	}
> +
> +	if (__send_request(bd->rq) < 0) {
> +		spin_unlock_irqrestore(&port->vio.lock, flags);
> +		return BLK_STS_IOERR;
> +	}
> +
> +	spin_unlock_irqrestore(&port->vio.lock, flags);
> +	return BLK_STS_OK;
>  }
>  
>  static int generic_request(struct vdc_port *port, u8 op, void *buf, int len)
> @@ -759,6 +770,44 @@ static void vdc_port_down(struct vdc_port *port)
>  	vio_ldc_free(&port->vio);
>  }
>  
> +static const struct blk_mq_ops vdc_mq_ops = {
> +	.queue_rq	= vdc_queue_rq,
> +};
> +
> +static void cleanup_queue(struct request_queue *q)
> +{
> +	struct vdc_port *port = q->queuedata;
> +
> +	blk_mq_free_tag_set(&port->tag_set);
> +	blk_cleanup_queue(q);

blk_mq_free_tag_set() need to be put after blk_cleanup_queue().

> +}
> +
> +static struct request_queue *init_queue(struct vdc_port *port)
> +{
> +	struct blk_mq_tag_set *set = &port->tag_set;
> +	struct request_queue *q;
> +	int ret;
> +
> +	set->ops = &vdc_mq_ops;
> +	set->nr_hw_queues = 1;
> +	set->queue_depth = VDC_TX_RING_SIZE;
> +	set->numa_node = NUMA_NO_NODE;
> +	set->flags = BLK_MQ_F_SHOULD_MERGE;
> +
> +	ret = blk_mq_alloc_tag_set(set);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	q = blk_mq_init_queue(set);
> +	if (IS_ERR(q)) {
> +		blk_mq_free_tag_set(set);
> +		return q;
> +	}

Most of conversions have the above pattern, maybe it is easier to
introduce the following block API:

	struct reuqest_queue *blk_mq_alloc_and_init_sq(set, ops, queue_depth)


-- 
Ming
