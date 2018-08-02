Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Aug 2018 07:50:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 5/9] block, scsi: Rework runtime power management
Message-ID: <20180802235027.GA16047@ming.t460p>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
 <20180802182944.14442-6-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180802182944.14442-6-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 02, 2018 at 11:29:40AM -0700, Bart Van Assche wrote:
> Instead of allowing requests that are not power management requests
> to enter the queue in runtime suspended status (RPM_SUSPENDED), make
> the blk_get_request() caller block. This change fixes a starvation
> issue: it is now guaranteed that power management requests will be
> executed no matter how many blk_get_request() callers are waiting.
> Instead of maintaining the q->nr_pending counter, rely on
> q->q_usage_counter. Call pm_runtime_mark_last_busy() every time a
> request finishes instead of only if the queue depth drops to zero.
> Use RQF_PREEMPT to mark power management requests instead of RQF_PM.
> This is safe because the power management core serializes system-wide
> suspend/resume and runtime power management state changes.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-core.c          | 47 +++++++++++++++------------------------
>  block/blk-mq-debugfs.c    |  1 -
>  block/blk-pm.c            | 37 +++++++++++++++++++++++++-----
>  block/blk-pm.h            |  6 ++---
>  drivers/scsi/sd.c         |  4 ++--
>  drivers/scsi/ufs/ufshcd.c | 10 ++++-----
>  include/linux/blkdev.h    |  7 ++----
>  7 files changed, 61 insertions(+), 51 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7ca76cf26870..9ba6e42a4b18 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -690,6 +690,16 @@ void blk_set_queue_dying(struct request_queue *q)
>  {
>  	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
>  
> +#ifdef CONFIG_PM
> +	/*
> +	 * Avoid that runtime power management tries to modify the state of
> +	 * q->q_usage_counter after that counter has been transitioned to the
> +	 * "dead" state.
> +	 */
> +	if (q->dev)
> +		pm_runtime_disable(q->dev);
> +#endif
> +
>  	/*
>  	 * When queue DYING flag is set, we need to block new req
>  	 * entering queue, so we call blk_freeze_queue_start() to
> @@ -2737,30 +2747,6 @@ void blk_account_io_done(struct request *req, u64 now)
>  	}
>  }
>  
> -#ifdef CONFIG_PM
> -/*
> - * Don't process normal requests when queue is suspended
> - * or in the process of suspending/resuming
> - */
> -static bool blk_pm_allow_request(struct request *rq)
> -{
> -	switch (rq->q->rpm_status) {
> -	case RPM_RESUMING:
> -	case RPM_SUSPENDING:
> -		return rq->rq_flags & RQF_PM;
> -	case RPM_SUSPENDED:
> -		return false;
> -	default:
> -		return true;
> -	}
> -}
> -#else
> -static bool blk_pm_allow_request(struct request *rq)
> -{
> -	return true;
> -}
> -#endif
> -
>  void blk_account_io_start(struct request *rq, bool new_io)
>  {
>  	struct hd_struct *part;
> @@ -2806,11 +2792,14 @@ static struct request *elv_next_request(struct request_queue *q)
>  
>  	while (1) {
>  		list_for_each_entry(rq, &q->queue_head, queuelist) {
> -			if (blk_pm_allow_request(rq))
> -				return rq;
> -
> -			if (rq->rq_flags & RQF_SOFTBARRIER)
> -				break;
> +#ifdef CONFIG_PM
> +			/*
> +			 * If a request gets queued in state RPM_SUSPENDED
> +			 * then that's a kernel bug.
> +			 */
> +			WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);
> +#endif
> +			return rq;
>  		}
>  
>  		/*
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index cb1e6cf7ac48..994bdd41feb2 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -324,7 +324,6 @@ static const char *const rqf_name[] = {
>  	RQF_NAME(ELVPRIV),
>  	RQF_NAME(IO_STAT),
>  	RQF_NAME(ALLOCED),
> -	RQF_NAME(PM),
>  	RQF_NAME(HASHED),
>  	RQF_NAME(STATS),
>  	RQF_NAME(SPECIAL_PAYLOAD),
> diff --git a/block/blk-pm.c b/block/blk-pm.c
> index 524e19b67380..c33c881f64df 100644
> --- a/block/blk-pm.c
> +++ b/block/blk-pm.c
> @@ -77,6 +77,13 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
>  }
>  EXPORT_SYMBOL(blk_pm_runtime_init);
>  
> +static void blk_unprepare_runtime_suspend(struct request_queue *q)
> +{
> +	blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
> +	/* Because QUEUE_FLAG_PREEMPT_ONLY has been cleared. */
> +	wake_up_all(&q->mq_freeze_wq);
> +}
> +
>  /**
>   * blk_pre_runtime_suspend - Pre runtime suspend check
>   * @q: the queue of the device
> @@ -105,17 +112,32 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>  	if (!q->dev)
>  		return ret;
>  
> +	WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
> +
>  	blk_pm_runtime_lock(q);
> +	/*
> +	 * Set the PREEMPT_ONLY flag before switching the queue usage counter
> +	 * to atomic mode such that blk_queue_enter() sees the two writes in
> +	 * the right order. See also http://lwn.net/Articles/573497/.
> +	 */
> +	blk_set_preempt_only(q);
> +	ret = -EBUSY;
> +	if (percpu_ref_read(&q->q_usage_counter) == 1) {
> +		percpu_ref_switch_to_atomic_sync(&q->q_usage_counter);
> +		if (percpu_ref_read(&q->q_usage_counter) == 1)
> +			ret = 0;
> +	}

I am not sure if using PREEMPT_ONLY can work well for runtime PM, there
are lots of users which depends on blk_freeze_queue() for making sure
there isn't any in-flight requests.

But now PREEMPT_ONLY opens one door for preempt-req during the big
window, so this way may break current uses of blk_freeze_queue().


Thanks,
Ming
