Return-Path: <ming.lei@redhat.com>
Date: Wed, 8 Aug 2018 16:50:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 6/9] block: Change the runtime power management
 approach (2/2)
Message-ID: <20180808085012.GB13518@ming.t460p>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
 <20180807225133.27221-7-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180807225133.27221-7-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 07, 2018 at 03:51:30PM -0700, Bart Van Assche wrote:
> Instead of allowing requests that are not power management requests
> to enter the queue in runtime suspended status (RPM_SUSPENDED), make
> the blk_get_request() caller block. This change fixes a starvation

Looks not see the related change which blocks blk_get_request() in
this patchset.

BTW, blk_pm_add_request() won't block since it uses the async version
of runtime resume.

> issue: it is now guaranteed that power management requests will be
> executed no matter how many blk_get_request() callers are waiting.
> Instead of maintaining the q->nr_pending counter, rely on
> q->q_usage_counter. Call pm_runtime_mark_last_busy() every time a
> request finishes instead of only if the queue depth drops to zero.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
>  block/blk-core.c       | 37 ++++++++-----------------------------
>  block/blk-mq-debugfs.c |  1 -
>  block/blk-pm.c         | 40 +++++++++++++++++++++++++++++++++++-----
>  block/blk-pm.h         |  6 ++----
>  include/linux/blkdev.h |  1 -
>  5 files changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 179a13be0fca..a2ef253edfbd 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2737,30 +2737,6 @@ void blk_account_io_done(struct request *req, u64 now)
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
> @@ -2806,11 +2782,14 @@ static struct request *elv_next_request(struct request_queue *q)
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
> index a5ea86835fcb..7d74d53dc098 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -332,7 +332,6 @@ static const char *const rqf_name[] = {
>  	RQF_NAME(ELVPRIV),
>  	RQF_NAME(IO_STAT),
>  	RQF_NAME(ALLOCED),
> -	RQF_NAME(PM),
>  	RQF_NAME(HASHED),
>  	RQF_NAME(STATS),
>  	RQF_NAME(SPECIAL_PAYLOAD),
> diff --git a/block/blk-pm.c b/block/blk-pm.c
> index bf8532da952d..d6b65cef9764 100644
> --- a/block/blk-pm.c
> +++ b/block/blk-pm.c
> @@ -86,14 +86,39 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>  	if (!q->dev)
>  		return ret;
>  
> +	WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
> +
> +	blk_set_pm_only(q);
> +	/*
> +	 * This function only gets called if the most recent
> +	 * pm_request_resume() call occurred at least autosuspend_delay_ms
> +	 * ago. Since blk_queue_enter() is called by the request allocation
> +	 * code before pm_request_resume(), if q_usage_counter indicates that
> +	 * no requests are in flight it is safe to suspend the device.
> +	 */
> +	ret = -EBUSY;
> +	if (!percpu_ref_is_in_use(&q->q_usage_counter)) {
> +		/*
> +		 * Switch to preempt-only mode before calling
> +		 * synchronize_rcu() such that later blk_queue_enter() calls
> +		 * see the preempt-only state. See also
> +		 * http://lwn.net/Articles/573497/.
> +		 */
> +		synchronize_rcu();
> +		if (!percpu_ref_is_in_use(&q->q_usage_counter))
> +			ret = 0;
> +	}
> +

In blk_queue_enter(), V5 starts to allow all RQF_PREEMPT requests
to enter queue even though pm_only is set. That means any scsi_execute()
may issue a new command to host just after the above percpu_ref_is_in_use()
returns 0, meantime the suspend is in-progress.

This case is illegal given RQF_PM is the only kind of request which can be
issued to hardware during suspend.

Thanks,
Ming
