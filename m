Return-Path: <ming.lei@redhat.com>
Date: Thu, 1 Mar 2018 09:36:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] mq-deadline: Make sure to always unlock zones
Message-ID: <20180301013629.GB30449@ming.t460p>
References: <20180228173529.24941-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228173529.24941-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 28, 2018 at 09:35:29AM -0800, Bart Van Assche wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> In case of a failed write request (all retries failed) and when using
> libata, the SCSI error handler calls scsi_finish_command(). In the
> case of blk-mq this means that scsi_mq_done() does not get called,
> that blk_mq_complete_request() does not get called and also that the
> mq-deadline .completed_request() method is not called. This results in
> the target zone of the failed write request being left in a locked
> state, preventing that any new write requests are issued to the same
> zone.
> 
> Fix this by replacing the .completed_request() method with the
> .finish_request() method as this method is always called whether or
> not a request completes successfully. Since the .finish_request()
> method is only called by the blk-mq core if a .prepare_request()
> method exists, add a dummy .prepare_request() method.
> 
> Fixes: 5700f69178e9 ("mq-deadline: Introduce zone locking support")
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> [ bvanassche: edited patch description ]
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/mq-deadline.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index c56f211c8440..8ec0ba9f5386 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -535,13 +535,22 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>  	spin_unlock(&dd->lock);
>  }
>  
> +/*
> + * Nothing to do here. This is defined only to ensure that .finish_request
> + * method is called upon request completion.
> + */
> +static void dd_prepare_request(struct request *rq, struct bio *bio)
> +{
> +}
> +
>  /*
>   * For zoned block devices, write unlock the target zone of
>   * completed write requests. Do this while holding the zone lock
>   * spinlock so that the zone is never unlocked while deadline_fifo_request()
> - * while deadline_next_request() are executing.
> + * or deadline_next_request() are executing. This function is called for
> + * all requests, whether or not these requests complete successfully.
>   */
> -static void dd_completed_request(struct request *rq)
> +static void dd_finish_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
>  
> @@ -756,7 +765,8 @@ static struct elevator_type mq_deadline = {
>  	.ops.mq = {
>  		.insert_requests	= dd_insert_requests,
>  		.dispatch_request	= dd_dispatch_request,
> -		.completed_request	= dd_completed_request,
> +		.prepare_request	= dd_prepare_request,
> +		.finish_request		= dd_finish_request,
>  		.next_request		= elv_rb_latter_request,
>  		.former_request		= elv_rb_former_request,
>  		.bio_merge		= dd_bio_merge,
> -- 
> 2.16.2
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
