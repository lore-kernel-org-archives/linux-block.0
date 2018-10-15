Return-Path: <ming.lei@redhat.com>
Date: Mon, 15 Oct 2018 18:27:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 07/17] uml: convert ubd to blk-mq
Message-ID: <20181015102717.GB31722@ming.t460p>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181011165909.32615-8-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 11, 2018 at 10:58:59AM -0600, Jens Axboe wrote:
> Just a straight forward conversion. The retry handling could
> potentially be done by blk-mq as well, but that's for another
> day.
> 
> Cc: Jeff Dike <jdike@addtoit.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  arch/um/drivers/ubd_kern.c | 154 ++++++++++++++++++++++---------------
>  1 file changed, 94 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 83c470364dfb..a302962a441d 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -22,7 +22,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/ata.h>
>  #include <linux/hdreg.h>
>  #include <linux/cdrom.h>
> @@ -156,6 +156,7 @@ struct ubd {
>  	struct cow cow;
>  	struct platform_device pdev;
>  	struct request_queue *queue;
> +	struct blk_mq_tag_set tag_set;
>  	spinlock_t lock;
>  	struct scatterlist sg[MAX_SG];
>  	struct request *request;
> @@ -436,7 +437,9 @@ __uml_help(udb_setup,
>  "    in the boot output.\n\n"
>  );
>  
> -static void do_ubd_request(struct request_queue * q);
> +static void ubd_handle_request(struct ubd *dev);
> +static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
> +				 const struct blk_mq_queue_data *bd);
>  
>  /* Only changed by ubd_init, which is an initcall. */
>  static int thread_fd = -1;
> @@ -520,12 +523,12 @@ static void ubd_handler(void)
>  			return;
>  		}
>  		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
> -			blk_end_request(
> -				(*irq_req_buffer)[count]->req,
> -				BLK_STS_OK,
> -				(*irq_req_buffer)[count]->length
> -			);
> -			kfree((*irq_req_buffer)[count]);
> +			struct io_thread_req *io_req = (*irq_req_buffer)[count];
> +
> +			if (!blk_update_request(io_req->req, BLK_STS_OK, io_req->length))
> +				__blk_mq_end_request(io_req->req, BLK_STS_OK);
> +
> +			kfree(io_req);
>  		}
>  	}
>  	reactivate_fd(thread_fd, UBD_IRQ);
> @@ -534,7 +537,7 @@ static void ubd_handler(void)
>  		ubd = container_of(list, struct ubd, restart);
>  		list_del_init(&ubd->restart);
>  		spin_lock_irqsave(&ubd->lock, flags);
> -		do_ubd_request(ubd->queue);
> +		ubd_handle_request(ubd);
>  		spin_unlock_irqrestore(&ubd->lock, flags);
>  	}
>  }
> @@ -856,6 +859,7 @@ static void ubd_device_release(struct device *dev)
>  {
>  	struct ubd *ubd_dev = dev_get_drvdata(dev);
>  
> +	blk_mq_free_tag_set(&ubd_dev->tag_set);
>  	blk_cleanup_queue(ubd_dev->queue);
>  	*ubd_dev = ((struct ubd) DEFAULT_UBD);
>  }
> @@ -897,20 +901,25 @@ static int ubd_disk_register(int major, u64 size, int unit,
>  	return 0;
>  }
>  
> +static const struct blk_mq_ops ubd_mq_ops = {
> +	.queue_rq	= ubd_queue_rq,
> +};
> +
>  #define ROUND_BLOCK(n) ((n + ((1 << 9) - 1)) & (-1 << 9))
>  
>  static int ubd_add(int n, char **error_out)
>  {
>  	struct ubd *ubd_dev = &ubd_devs[n];
> +	struct blk_mq_tag_set *set;
>  	int err = 0;
>  
>  	if(ubd_dev->file == NULL)
> -		goto out;
> +		goto out1;
>  
>  	err = ubd_file_size(ubd_dev, &ubd_dev->size);
>  	if(err < 0){
>  		*error_out = "Couldn't determine size of device's file";
> -		goto out;
> +		goto out1;
>  	}
>  
>  	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
> @@ -918,12 +927,26 @@ static int ubd_add(int n, char **error_out)
>  	INIT_LIST_HEAD(&ubd_dev->restart);
>  	sg_init_table(ubd_dev->sg, MAX_SG);
>  
> -	err = -ENOMEM;
> -	ubd_dev->queue = blk_init_queue(do_ubd_request, &ubd_dev->lock);
> -	if (ubd_dev->queue == NULL) {
> +	set = &ubd_dev->tag_set;
> +	set->ops = &ubd_mq_ops;
> +	set->nr_hw_queues = 1;
> +	set->queue_depth = 2;
> +	set->numa_node = NUMA_NO_NODE;
> +	set->flags = BLK_MQ_F_SHOULD_MERGE;
> +	err = blk_mq_alloc_tag_set(set);
> +	if (err) {
> +		*error_out = "Failed to initialize device tag set";
> +		goto out1;
> +	}
> +
> +	ubd_dev->queue = blk_mq_init_queue(set);
> +	if (IS_ERR(ubd_dev->queue)) {
> +		err = PTR_ERR(ubd_dev->queue);
> +		ubd_dev->queue = NULL;
>  		*error_out = "Failed to initialize device queue";
>  		goto out;
>  	}
> +
>  	ubd_dev->queue->queuedata = ubd_dev;
>  	blk_queue_write_cache(ubd_dev->queue, true, false);
>  
> @@ -947,9 +970,12 @@ static int ubd_add(int n, char **error_out)
>  
>  	err = 0;
>  out:
> +	blk_mq_free_tag_set(&ubd_dev->tag_set);
> +out1:
>  	return err;
>  
>  out_cleanup:
> +	blk_mq_free_tag_set(&ubd_dev->tag_set);
>  	blk_cleanup_queue(ubd_dev->queue);

blk_mq_free_tag_set() should have been put after blk_cleanup_queue().

-- 
Ming
