Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH 13/14] block: simplify runtime PM support
To: Ming Lei <ming.lei@redhat.com>, Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
 <20180807174433.8374-14-ming.lei@redhat.com>
 <a1b7afb7e912c84b908342922b2fba12a364fd76.camel@wdc.com>
 <20180808035040.GC9523@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0c3eab06-8e10-f24a-06df-8ff2d3560f38@oracle.com>
Date: Wed, 8 Aug 2018 15:57:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180808035040.GC9523@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming and Bart

Would you mind to combine your solution together ? ;)

It could be like this:

blk_pre_runtime_suspend


	if (q->mq_ops) {
		if (!blk_mq_pm_queue_idle(q)) {
 		    ret = -EBUSY;
  		    pm_runtime_mark_last_busy(q->dev);
                } else {
                    blk_set_preempt_only(q);
                    synchronize_rcu()
                    if (!blk_mq_pm_queue_idle(q)) {
                        blk_clear_preempt_only(q);
                        ret = -EBUSY;
                    } else {
                    q->rpm_status = RPM_SUSPENDING;
                    }
                }
        } else {
            spin_lock_irq(q->queue_lock);
            if (q->nr_pending) {
                ret = -EBUSY;
                pm_runtime_mark_last_busy(q->dev);
            } else {
                q->rpm_status = RPM_SUSPENDING;
            }
            spin_unlock_irq(q->queue_lock);
        }

blk_queue_enter
 
    blk_resume_queue(q);
    wait_event(q->mq_freeze_wq,
 	  atomic_read(&q->mq_freeze_depth) == 0 ||
 	  blk_queue_dying(q));


Thanks
Jianchao

On 08/08/2018 11:50 AM, Ming Lei wrote:
> iff --git a/block/blk-core.c b/block/blk-core.c
> index 26f9ceb85318..d1a5cd1da861 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3730,6 +3730,24 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
>  }
>  EXPORT_SYMBOL(blk_pm_runtime_init);
>  
> +static void blk_mq_pm_check_idle(struct blk_mq_hw_ctx *hctx,
> +		struct request *rq, void *priv, bool reserved)
> +{
> +	unsigned long *cnt = priv;
> +
> +	(*cnt)++;
> +}
> +
> +static bool blk_mq_pm_queue_idle(struct request_queue *q)
> +{
> +	unsigned long idle_cnt;
> +
> +	idle_cnt = 0;
> +	blk_mq_queue_tag_busy_iter(q, blk_mq_pm_check_idle, &idle_cnt);
> +
> +	return idle_cnt == 0;
> +}
> +
>  /**
>   * blk_pre_runtime_suspend - Pre runtime suspend check
>   * @q: the queue of the device
> @@ -3754,13 +3772,18 @@ EXPORT_SYMBOL(blk_pm_runtime_init);
>  int blk_pre_runtime_suspend(struct request_queue *q)
>  {
>  	int ret = 0;
> +	bool mq_idle = false;
>  
>  	if (!q->dev)
>  		return ret;
>  
>  	mutex_lock(&q->pm_lock);
> +
> +	if (q->mq_ops)
> +		mq_idle = blk_mq_pm_queue_idle(q);
> +
>  	spin_lock_irq(q->queue_lock);
> -	if (q->nr_pending) {
> +	if (q->nr_pending || !mq_idle) {
>  		ret = -EBUSY;
>  		pm_runtime_mark_last_busy(q->dev);
>  	} else {
