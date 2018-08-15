Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH V2 16/17] block: simplify runtime PM support
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20180811071220.357-1-ming.lei@redhat.com>
 <20180811071220.357-17-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <6baaef0e-6845-d3d5-6d78-85ce89bc0a2a@oracle.com>
Date: Wed, 15 Aug 2018 14:39:05 +0800
MIME-Version: 1.0
In-Reply-To: <20180811071220.357-17-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 08/11/2018 03:12 PM, Ming Lei wrote:
> @@ -3786,6 +3800,10 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>  		q->rpm_status = RPM_SUSPENDING;
>  	}
>  	spin_unlock_irq(q->queue_lock);
> +
> +	if (!ret)
> +		blk_freeze_queue_lock(q);
> +
>  	return ret;

Requests seem to be able enter the request_queue while the rpm_status is RPM_SUSPENDING
and miss the rpm_resume.

Even though blk_freeze_queue_lock will drain them before the real suspend start, but looks
like we should stop the suspend at the moment.

Thanks
Jianchao
