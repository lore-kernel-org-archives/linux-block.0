Return-Path: <hch@lst.de>
Date: Tue, 17 Jul 2018 15:21:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC V2 1/3] block: put runtime PM code into common
	helpers
Message-ID: <20180717132117.GG13582@lst.de>
References: <20180713080602.31602-1-ming.lei@redhat.com> <20180713080602.31602-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180713080602.31602-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

>  #ifdef CONFIG_PM
> +static int __blk_pre_runtime_suspend(struct request_queue *q, bool active)
> +{
> +	int ret;
> +
> +	if (active) {
> +		ret = -EBUSY;
> +		pm_runtime_mark_last_busy(q->dev);
> +	} else {
> +		ret = 0;
> +		q->rpm_status = RPM_SUSPENDING;
> +	}
> +
> +	return ret;
> +}

Why not:

	if (active) {
		pm_runtime_mark_last_busy(q->dev);
		return -EBUSY;
	}

	q->rpm_status = RPM_SUSPENDING;
	return 0;
		
