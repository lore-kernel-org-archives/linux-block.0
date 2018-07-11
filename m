Return-Path: <hch@lst.de>
Date: Wed, 11 Jul 2018 19:19:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] blk-mq: prepare for supporting runtime PM
Message-ID: <20180711171908.GD3500@lst.de>
References: <20180711162906.14271-1-ming.lei@redhat.com> <20180711162906.14271-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180711162906.14271-4-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> index c4b57d8806fe..bf66d561980d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3804,12 +3804,17 @@ EXPORT_SYMBOL(blk_pm_runtime_init);
>  int blk_pre_runtime_suspend(struct request_queue *q)
>  {
>  	int ret = 0;
> +	bool active;
>  
>  	if (!q->dev)
>  		return ret;
>  
>  	spin_lock_irq(q->queue_lock);
> -	if (q->nr_pending) {
> +	if (!q->mq_ops)
> +		active = !!q->nr_pending;
> +	else
> +		active = !blk_mq_pm_queue_idle(q);
> +	if (active) {

We shouldn't really need queue_lock for blk-mq.  Also the !! is not
really needed when assigning to a bool.

> +static void blk_mq_pm_add_request(struct request_queue *q, struct request *rq)
> +{
> +	if (!blk_mq_support_runtime_pm(q))
> +		return;
> +
> +	if (q->dev && !(rq->rq_flags & RQF_PM) &&
> +	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
> +		pm_request_resume(q->dev);

blk_mq_support_runtime_pm already checks for q->dev.   Also to mee
it sems just opencoding blk_mq_pm_add_request / blk_mq_pm_put_request
in the callers would seems more obvious.

> @@ -1841,6 +1863,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	rq_qos_track(q, rq, bio);
>  
> +	blk_mq_pm_add_request(q, rq);

This doesn't seem to handle passthrough requests and not actually
pair with blk_mq_free_request, is that intentional?
