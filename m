Return-Path: <stern+5b5b8f2e@rowland.harvard.edu>
Date: Fri, 13 Jul 2018 16:16:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>,  <linux-block@vger.kernel.org>,
    "Rafael J. Wysocki" <rjw@rjwysocki.net>,  <linux-pm@vger.kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Christoph Hellwig <hch@lst.de>, Bart Van Assche <bart.vanassche@wdc.com>,
    Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
    Adrian Hunter <adrian.hunter@intel.com>,
    "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
    "Martin K. Petersen" <martin.petersen@oracle.com>,
     <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH RFC V2 2/3] blk-mq: prepare for supporting runtime PM
In-Reply-To: <20180713080602.31602-3-ming.lei@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1807131614440.10216-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 13 Jul 2018, Ming Lei wrote:

> This patch introduces blk_mq_pm_add_request() which is called after
> allocating one request. Also blk_mq_pm_put_request() is introduced
> and called after one request is freed.
> 
> For blk-mq, it can be quite expensive to accounting in-flight IOs,
> so this patch calls pm_runtime_mark_last_busy() simply after each IO
> is done, instead of doing that only after the last in-flight IO is done.
> This way is still workable, since the active non-PM IO will be checked
> in blk_pre_runtime_suspend(), and runtime suspend will be prevented
> if there is any active non-PM IO.
> 
> Turns out that sync between runtime PM and IO path has to be done
> for avoiding race, this patch applies one seqlock for this purpose.
> So the cost introduced in fast IO path can be minimized given seqlock
> is often used in fast path, such as reading jiffies &tick, or d_walk(),
> ...
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---


> +static void blk_mq_post_runtime_suspend(struct request_queue *q, int err)
> +{
> +	if (!blk_mq_support_runtime_pm(q))
> +		return;
> +
> +	write_seqlock_irq(&q->rpm_lock);
> +	__blk_post_runtime_suspend(q, err);
> +	write_sequnlock_irq(&q->rpm_lock);
> +}
> +
> +static void blk_mq_pre_runtime_resume(struct request_queue *q)
> +{
> +	if (!blk_mq_support_runtime_pm(q))
> +		return;
> +
> +	write_seqlock_irq(&q->rpm_lock);
> +	q->rpm_status = RPM_RESUMING;
> +	write_sequnlock_irq(&q->rpm_lock);
> +}
> +
> +static void blk_mq_post_runtime_resume(struct request_queue *q, int err)
> +{
> +	if (!blk_mq_support_runtime_pm(q))
> +		return;
> +
> +	write_seqlock_irq(&q->rpm_lock);
> +	__blk_post_runtime_resume(q, err);
> +	write_sequnlock_irq(&q->rpm_lock);
> +}
> +
> +static void blk_mq_set_runtime_active(struct request_queue *q)
> +{
> +	if (!blk_mq_support_runtime_pm(q))
> +		return;
> +
> +	write_seqlock_irq(&q->rpm_lock);
> +	__blk_set_runtime_active(q);
> +	write_sequnlock_irq(&q->rpm_lock);
> +}

Would the code be cleaner if these routines were written inline,
like their non-mq counterparts?

Alan Stern
