Return-Path: <michals@xilinx.com>
Return-Path: michal.simek@xilinx.com
Subject: Re: [PATCH 15/17] xsysace: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: Michal Simek <michal.simek@xilinx.com>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-16-axboe@kernel.dk>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <0f7caa33-46d4-c727-7bbf-59d27cd7d373@xilinx.com>
Date: Fri, 12 Oct 2018 07:46:16 +0200
MIME-Version: 1.0
In-Reply-To: <20181011165909.32615-16-axboe@kernel.dk>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

On 11.10.2018 18:59, Jens Axboe wrote:
> Straight forward conversion, using an internal list to enable the
> driver to pull requests at will.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/xsysace.c | 91 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
> index c24589414c75..ddaa362ffe82 100644
> --- a/drivers/block/xsysace.c
> +++ b/drivers/block/xsysace.c
> @@ -88,7 +88,7 @@
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> -#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/mutex.h>
>  #include <linux/ata.h>
>  #include <linux/hdreg.h>
> @@ -209,6 +209,8 @@ struct ace_device {
>  	struct device *dev;
>  	struct request_queue *queue;
>  	struct gendisk *gd;
> +	struct blk_mq_tag_set tag_set;
> +	struct list_head rq_list;
>  
>  	/* Inserted CF card parameters */
>  	u16 cf_id[ATA_ID_WORDS];
> @@ -462,18 +464,26 @@ static inline void ace_fsm_yieldirq(struct ace_device *ace)
>  	ace->fsm_continue_flag = 0;
>  }
>  
> +static bool ace_has_next_request(struct request_queue *q)
> +{
> +	struct ace_device *ace = q->queuedata;
> +
> +	return !list_empty(&ace->rq_list);
> +}
> +
>  /* Get the next read/write request; ending requests that we don't handle */
>  static struct request *ace_get_next_request(struct request_queue *q)
>  {
> -	struct request *req;
> +	struct ace_device *ace = q->queuedata;
> +	struct request *rq;
>  
> -	while ((req = blk_peek_request(q)) != NULL) {
> -		if (!blk_rq_is_passthrough(req))
> -			break;
> -		blk_start_request(req);
> -		__blk_end_request_all(req, BLK_STS_IOERR);
> +	rq = list_first_entry_or_null(&ace->rq_list, struct request, queuelist);
> +	if (rq) {
> +		list_del_init(&rq->queuelist);
> +		blk_mq_start_request(rq);
>  	}
> -	return req;
> +
> +	return NULL;
>  }
>  
>  static void ace_fsm_dostate(struct ace_device *ace)
> @@ -499,11 +509,11 @@ static void ace_fsm_dostate(struct ace_device *ace)
>  
>  		/* Drop all in-flight and pending requests */
>  		if (ace->req) {
> -			__blk_end_request_all(ace->req, BLK_STS_IOERR);
> +			blk_mq_end_request(ace->req, BLK_STS_IOERR);
>  			ace->req = NULL;
>  		}
> -		while ((req = blk_fetch_request(ace->queue)) != NULL)
> -			__blk_end_request_all(req, BLK_STS_IOERR);
> +		while ((req = ace_get_next_request(ace->queue)) != NULL)
> +			blk_mq_end_request(req, BLK_STS_IOERR);
>  
>  		/* Drop back to IDLE state and notify waiters */
>  		ace->fsm_state = ACE_FSM_STATE_IDLE;
> @@ -517,7 +527,7 @@ static void ace_fsm_dostate(struct ace_device *ace)
>  	switch (ace->fsm_state) {
>  	case ACE_FSM_STATE_IDLE:
>  		/* See if there is anything to do */
> -		if (ace->id_req_count || ace_get_next_request(ace->queue)) {
> +		if (ace->id_req_count || ace_has_next_request(ace->queue)) {
>  			ace->fsm_iter_num++;
>  			ace->fsm_state = ACE_FSM_STATE_REQ_LOCK;
>  			mod_timer(&ace->stall_timer, jiffies + HZ);
> @@ -651,7 +661,6 @@ static void ace_fsm_dostate(struct ace_device *ace)
>  			ace->fsm_state = ACE_FSM_STATE_IDLE;
>  			break;
>  		}
> -		blk_start_request(req);
>  
>  		/* Okay, it's a data request, set it up for transfer */
>  		dev_dbg(ace->dev,
> @@ -728,7 +737,8 @@ static void ace_fsm_dostate(struct ace_device *ace)
>  		}
>  
>  		/* bio finished; is there another one? */
> -		if (__blk_end_request_cur(ace->req, BLK_STS_OK)) {
> +		if (blk_update_request(ace->req, BLK_STS_OK,
> +		    blk_rq_cur_bytes(ace->req))) {
>  			/* dev_dbg(ace->dev, "next block; h=%u c=%u\n",
>  			 *      blk_rq_sectors(ace->req),
>  			 *      blk_rq_cur_sectors(ace->req));
> @@ -854,17 +864,23 @@ static irqreturn_t ace_interrupt(int irq, void *dev_id)
>  /* ---------------------------------------------------------------------
>   * Block ops
>   */
> -static void ace_request(struct request_queue * q)
> +static blk_status_t ace_queue_rq(struct blk_mq_hw_ctx *hctx,
> +				 const struct blk_mq_queue_data *bd)
>  {
> -	struct request *req;
> -	struct ace_device *ace;
> +	struct ace_device *ace = hctx->queue->queuedata;
> +	struct request *req = bd->rq;
>  
> -	req = ace_get_next_request(q);
> -
> -	if (req) {
> -		ace = req->rq_disk->private_data;
> -		tasklet_schedule(&ace->fsm_tasklet);
> +	if (blk_rq_is_passthrough(req)) {
> +		blk_mq_start_request(req);
> +		return BLK_STS_IOERR;
>  	}
> +
> +	spin_lock_irq(&ace->lock);
> +	list_add_tail(&req->queuelist, &ace->rq_list);
> +	spin_unlock_irq(&ace->lock);
> +
> +	tasklet_schedule(&ace->fsm_tasklet);
> +	return BLK_STS_OK;
>  }
>  
>  static unsigned int ace_check_events(struct gendisk *gd, unsigned int clearing)
> @@ -957,11 +973,16 @@ static const struct block_device_operations ace_fops = {
>  	.getgeo = ace_getgeo,
>  };
>  
> +static const struct blk_mq_ops ace_mq_ops = {
> +	.queue_rq	= ace_queue_rq,
> +};
> +
>  /* --------------------------------------------------------------------
>   * SystemACE device setup/teardown code
>   */
>  static int ace_setup(struct ace_device *ace)
>  {
> +	struct blk_mq_tag_set *set;
>  	u16 version;
>  	u16 val;
>  	int rc;
> @@ -972,6 +993,7 @@ static int ace_setup(struct ace_device *ace)
>  
>  	spin_lock_init(&ace->lock);
>  	init_completion(&ace->id_completion);
> +	INIT_LIST_HEAD(&ace->rq_list);
>  
>  	/*
>  	 * Map the device
> @@ -989,9 +1011,25 @@ static int ace_setup(struct ace_device *ace)
>  	/*
>  	 * Initialize the request queue
>  	 */
> -	ace->queue = blk_init_queue(ace_request, &ace->lock);
> -	if (ace->queue == NULL)
> +	set = &ace->tag_set;
> +	set->ops = &ace_mq_ops;
> +	set->nr_hw_queues = 1;
> +	set->queue_depth = 2;
> +	set->numa_node = NUMA_NO_NODE;
> +	set->flags = BLK_MQ_F_SHOULD_MERGE;
> +	rc = blk_mq_alloc_tag_set(set);
> +	if (rc)
>  		goto err_blk_initq;
> +
> +	ace->queue = blk_mq_init_queue(set);
> +	if (IS_ERR(ace->queue)) {
> +		rc = PTR_ERR(ace->queue);
> +		ace->queue = NULL;
> +		blk_mq_free_tag_set(&ace->tag_set);
> +		goto err_blk_initq;
> +	}
> +	ace->queue->queuedata = ace;
> +
>  	blk_queue_logical_block_size(ace->queue, 512);
>  	blk_queue_bounce_limit(ace->queue, BLK_BOUNCE_HIGH);
>  
> @@ -1065,6 +1103,7 @@ static int ace_setup(struct ace_device *ace)
>  err_read:
>  	put_disk(ace->gd);
>  err_alloc_disk:
> +	blk_mq_free_tag_set(&ace->tag_set);
>  	blk_cleanup_queue(ace->queue);
>  err_blk_initq:
>  	iounmap(ace->baseaddr);
> @@ -1081,8 +1120,10 @@ static void ace_teardown(struct ace_device *ace)
>  		put_disk(ace->gd);
>  	}
>  
> -	if (ace->queue)
> +	if (ace->queue) {
> +		blk_mq_free_tag_set(&ace->tag_set);
>  		blk_cleanup_queue(ace->queue);
> +	}
>  
>  	tasklet_kill(&ace->fsm_tasklet);
>  
> 

None is testing this driver anymore that's why feel free to do this
change and if there is any issue this patch can be reverted back.

That's why
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
