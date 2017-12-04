Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:48912 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbdLDQ3f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Dec 2017 11:29:35 -0500
Date: Mon, 4 Dec 2017 17:29:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, axboe@fb.com,
        anton.ivanov@cambridgegreys.com, hch@lst.de,
        linux-block@vger.kernel.org, david@sigma-star.at
Subject: Re: [PATCH] um: Convert ubd driver to blk-mq
Message-ID: <20171204162933.GA12565@lst.de>
References: <20171203214923.29541-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171203214923.29541-1-richard@nod.at>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Dec 03, 2017 at 10:49:23PM +0100, Richard Weinberger wrote:
> Convert the driver to the modern blk-mq framework.
> As byproduct we get rid of our open coded restart logic and let
> blk-mq handle it.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/um/drivers/ubd_kern.c | 178 +++++++++++++++++++++++----------------------
>  1 file changed, 93 insertions(+), 85 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index b55fe9bf5d3e..deceb8022a28 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/ata.h>
>  #include <linux/hdreg.h>
>  #include <linux/cdrom.h>
> @@ -142,7 +143,6 @@ struct cow {
>  #define MAX_SG 64
>  
>  struct ubd {
> -	struct list_head restart;
>  	/* name (and fd, below) of the file opened for writing, either the
>  	 * backing or the cow file. */
>  	char *file;
> @@ -156,9 +156,12 @@ struct ubd {
>  	struct cow cow;
>  	struct platform_device pdev;
>  	struct request_queue *queue;
> +	struct blk_mq_tag_set tag_set;
>  	spinlock_t lock;
> +};
> +
> +struct ubd_pdu {
>  	struct scatterlist sg[MAX_SG];
> -	struct request *request;
>  	int start_sg, end_sg;
>  	sector_t rq_pos;
>  };
> @@ -182,10 +185,6 @@ struct ubd {
>  	.shared =		0, \
>  	.cow =			DEFAULT_COW, \
>  	.lock =			__SPIN_LOCK_UNLOCKED(ubd_devs.lock), \
> -	.request =		NULL, \
> -	.start_sg =		0, \
> -	.end_sg =		0, \
> -	.rq_pos =		0, \
>  }
>  
>  /* Protected by ubd_lock */
> @@ -196,6 +195,12 @@ static int fake_ide = 0;
>  static struct proc_dir_entry *proc_ide_root = NULL;
>  static struct proc_dir_entry *proc_ide = NULL;
>  
> +static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
> +				 const struct blk_mq_queue_data *bd);
> +static int ubd_init_request(struct blk_mq_tag_set *set,
> +			    struct request *req, unsigned int hctx_idx,
> +			    unsigned int numa_node);
> +
>  static void make_proc_ide(void)
>  {
>  	proc_ide_root = proc_mkdir("ide", NULL);
> @@ -448,11 +453,8 @@ __uml_help(udb_setup,
>  "    in the boot output.\n\n"
>  );
>  
> -static void do_ubd_request(struct request_queue * q);
> -
>  /* Only changed by ubd_init, which is an initcall. */
>  static int thread_fd = -1;
> -static LIST_HEAD(restart);
>  
>  /* Function to read several request pointers at a time
>  * handling fractional reads if (and as) needed
> @@ -510,9 +512,6 @@ static int bulk_req_safe_read(
>  /* Called without dev->lock held, and only in interrupt context. */
>  static void ubd_handler(void)
>  {
> -	struct ubd *ubd;
> -	struct list_head *list, *next_ele;
> -	unsigned long flags;
>  	int n;
>  	int count;
>  
> @@ -532,23 +531,17 @@ static void ubd_handler(void)
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
> +			int err = io_req->error ? BLK_STS_IOERR : BLK_STS_OK;
> +
> +			if (!blk_update_request(io_req->req, err, io_req->length))
> +				__blk_mq_end_request(io_req->req, err);
> +
> +			kfree(io_req);
>  		}
>  	}
> -	reactivate_fd(thread_fd, UBD_IRQ);
>  
> -	list_for_each_safe(list, next_ele, &restart){
> -		ubd = container_of(list, struct ubd, restart);
> -		list_del_init(&ubd->restart);
> -		spin_lock_irqsave(&ubd->lock, flags);
> -		do_ubd_request(ubd->queue);
> -		spin_unlock_irqrestore(&ubd->lock, flags);
> -	}
> +	reactivate_fd(thread_fd, UBD_IRQ);
>  }
>  
>  static irqreturn_t ubd_intr(int irq, void *dev)
> @@ -869,6 +862,7 @@ static void ubd_device_release(struct device *dev)
>  	struct ubd *ubd_dev = dev_get_drvdata(dev);
>  
>  	blk_cleanup_queue(ubd_dev->queue);
> +	blk_mq_free_tag_set(&ubd_dev->tag_set);
>  	*ubd_dev = ((struct ubd) DEFAULT_UBD);
>  }
>  
> @@ -911,6 +905,11 @@ static int ubd_disk_register(int major, u64 size, int unit,
>  
>  #define ROUND_BLOCK(n) ((n + ((1 << 9) - 1)) & (-1 << 9))
>  
> +static const struct blk_mq_ops ubd_mq_ops = {
> +	.queue_rq = ubd_queue_rq,
> +	.init_request = ubd_init_request,
> +};

Use tables to align the "=" signs?

> +	blk_mq_start_request(req);
> +
> +	pdu->rq_pos = blk_rq_pos(req);
> +	pdu->start_sg = 0;
> +	pdu->end_sg = blk_rq_map_sg(req->q, req, pdu->sg);
>  
> +	if (req_op(req) == REQ_OP_FLUSH) {
> +		io_req = kmalloc(sizeof(struct io_thread_req), GFP_ATOMIC);

GFP_ATOMIC in the I/O path looks scary, but it seems the existing code
already does this.  Any reason not to embdedd the first one into
struct request and then use a mempool for the rest?

> +		if (io_req == NULL) {
> +			blk_mq_requeue_request(req, true);
> +			goto done;
>  		}
> +		prepare_flush_request(req, io_req);
> +		submit_request(io_req, dev);
>  
> -		req = dev->request;
> +		goto done;
> +	}

If you only call blk_mq_start_request once everything is set up you
can just return a BLK_STS_ code from ->queue_rq.
