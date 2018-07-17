Return-Path: <hch@lst.de>
Date: Tue, 17 Jul 2018 15:23:12 +0200
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
Subject: Re: [PATCH RFC V2 2/3] blk-mq: prepare for supporting runtime PM
Message-ID: <20180717132312.GH13582@lst.de>
References: <20180713080602.31602-1-ming.lei@redhat.com> <20180713080602.31602-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180713080602.31602-3-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 13, 2018 at 04:06:01PM +0800, Ming Lei wrote:
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
>  block/blk-core.c       | 121 +++++++++++++++++++++++++++++++++++++++++--------
>  block/blk-mq.c         |  71 +++++++++++++++++++++++++++++
>  block/blk-mq.h         |  10 ++++
>  include/linux/blk-mq.h |   1 +
>  include/linux/blkdev.h |   1 +
>  5 files changed, 186 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 1087a58590f1..cd73db90d1e3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3775,7 +3775,10 @@ static void __blk_post_runtime_resume(struct request_queue *q, int err)
>  {
>  	if (!err) {
>  		q->rpm_status = RPM_ACTIVE;
> -		__blk_run_queue(q);
> +		if (!q->mq_ops)
> +			__blk_run_queue(q);
> +		else
> +			blk_mq_run_hw_queues(q, true);
>  		pm_runtime_mark_last_busy(q->dev);
>  		pm_request_autosuspend(q->dev);
>  	} else {
> @@ -3790,6 +3793,69 @@ static void __blk_set_runtime_active(struct request_queue *q)
>  	pm_request_autosuspend(q->dev);
>  }
>  
> +static bool blk_mq_support_runtime_pm(struct request_queue *q)
> +{
> +	if (!q->tag_set || !(q->tag_set->flags & BLK_MQ_F_SUPPORT_RPM))
> +		return false;
> +	return true;

	return q->tag_set && (q->tag_set->flags & BLK_MQ_F_SUPPORT_RPM);

?
