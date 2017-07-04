Return-Path: <ming.lei@redhat.com>
Date: Wed, 5 Jul 2017 06:32:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 6/8] mtip32xx: quiesce request queues to make sure no
 submissions are inflight
Message-ID: <20170704223251.GB3732@ming.t460p>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-7-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499154912-10420-7-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 04, 2017 at 10:55:10AM +0300, Sagi Grimberg wrote:
> Unlike blk_mq_stop_hw_queues, blk_mq_quiesce_queue respects the
> submission path rcu grace. quiesce the queue before iterating
> on live tags, or performing device io quiescing.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/block/mtip32xx/mtip32xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
> index 61b046f256ca..69a62aeace2a 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -950,7 +950,7 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
>  	unsigned long to;
>  	bool active = true;
>  
> -	blk_mq_stop_hw_queues(port->dd->queue);
> +	blk_mq_quiesce_queue(port->dd->queue);
>  
>  	to = jiffies + msecs_to_jiffies(timeout);
>  	do {
> @@ -970,10 +970,10 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
>  			break;
>  	} while (time_before(jiffies, to));
>  
> -	blk_mq_start_stopped_hw_queues(port->dd->queue, true);
> +	blk_mq_unquiesce_queue(port->dd->queue);
>  	return active ? -EBUSY : 0;
>  err_fault:
> -	blk_mq_start_stopped_hw_queues(port->dd->queue, true);
> +	blk_mq_unquiesce_queue(port->dd->queue);
>  	return -EFAULT;
>  }

The above change looks correct.

>  
> @@ -3995,7 +3995,7 @@ static int mtip_block_remove(struct driver_data *dd)
>  						dd->disk->disk_name);
>  
>  	blk_freeze_queue_start(dd->queue);
> -	blk_mq_stop_hw_queues(dd->queue);
> +	blk_mq_quiesce_queue(dd->queue);
>  	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);

We still need to unquiesce queue for avoiding hanging blk_freeze_queue()
in blk_cleanup_queue() since any new request queued during quiescing
can't be dispatched to driver/device.

There are other blk_mq_tagset_busy_iter() in mtip_service_thread(),
which looks need quiesce too. This case is even worse, because both
mtip_abort_cmd() and mtip_queue_cmd() do not check if the req is
started.


-- 
Ming
