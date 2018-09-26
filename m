Return-Path: <hch@lst.de>
Date: Wed, 26 Sep 2018 16:23:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v10 3/8] block: Split blk_pm_add_request() and
 blk_pm_put_request()
Message-ID: <20180926142357.GB8604@lst.de>
References: <20180921203122.49743-1-bvanassche@acm.org> <20180921203122.49743-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180921203122.49743-4-bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

But one very minor nitpick below:

>  #ifdef CONFIG_PM
> +static inline void blk_pm_request_resume(struct request_queue *q)
> +{
> +	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
> +		       q->rpm_status == RPM_SUSPENDING))

I usually try to break lines around related conditions, so more something
like:

	if (q->dev &&
	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
