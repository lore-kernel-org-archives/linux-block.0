Return-Path: <ming.lei@redhat.com>
Date: Wed, 15 Aug 2018 16:28:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH V2 16/17] block: simplify runtime PM support
Message-ID: <20180815082803.GA26016@ming.t460p>
References: <20180811071220.357-1-ming.lei@redhat.com>
 <20180811071220.357-17-ming.lei@redhat.com>
 <6baaef0e-6845-d3d5-6d78-85ce89bc0a2a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6baaef0e-6845-d3d5-6d78-85ce89bc0a2a@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 15, 2018 at 02:39:05PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 08/11/2018 03:12 PM, Ming Lei wrote:
> > @@ -3786,6 +3800,10 @@ int blk_pre_runtime_suspend(struct request_queue *q)
> >  		q->rpm_status = RPM_SUSPENDING;
> >  	}
> >  	spin_unlock_irq(q->queue_lock);
> > +
> > +	if (!ret)
> > +		blk_freeze_queue_lock(q);
> > +
> >  	return ret;
> 
> Requests seem to be able enter the request_queue while the rpm_status is RPM_SUSPENDING
> and miss the rpm_resume.

Any requests which enters queue during RPM_SUSPENDING will be drained by
blk_freeze_queue_lock().

> 
> Even though blk_freeze_queue_lock will drain them before the real suspend start, but looks
> like we should stop the suspend at the moment.

Good point, even though it doesn't affect the correctness of this runtime PM
implementation.

We may improve this situation by the following way, what do you think of
it?

diff --git a/block/blk-core.c b/block/blk-core.c
index f42197c9f7af..84e1e6c7db87 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3803,10 +3803,13 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 {
 	int ret = 0;
 	bool busy = true;
+	unsigned long last_busy;
 
 	if (!q->dev)
 		return ret;
 
+	last_busy = READ_ONCE(dev->power.last_busy);
+
 	if (q->mq_ops)
 		busy = blk_mq_pm_queue_busy(q);
 
@@ -3823,6 +3826,13 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!ret)
 		blk_freeze_queue_lock(q);
 
+	/*
+	 * Any new IO during this window will prevent the current suspend
+	 * from going on
+	 */
+	if (unlikely(last_busy != READ_ONCE(dev->power.last_busy)))
+		ret = -EBUSY;
+
 	return ret;
 }
 EXPORT_SYMBOL(blk_pre_runtime_suspend);

Thanks,
Ming
