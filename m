Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
 <20180725222607.8854-5-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
Date: Thu, 26 Jul 2018 10:45:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180725222607.8854-5-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 07/26/2018 06:26 AM, Bart Van Assche wrote:
> @@ -102,9 +109,11 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>  		return ret;
>  
>  	blk_pm_runtime_lock(q);
> +	blk_set_preempt_only(q);

We only stop non-RQF_PM request entering when RPM_SUSPENDING and RPM_RESUMING.
blk_pre_runtime_suspend should only _check_ whether runtime suspend is allowed.
So we should not set preempt_only here.


> +	percpu_ref_switch_to_atomic_sync(&q->q_usage_counter);
>  
>  	spin_lock_irq(q->queue_lock);
> -	if (q->nr_pending) {
> +	if (!percpu_ref_is_zero(&q->q_usage_counter)) {
>  		ret = -EBUSY;
>  		pm_runtime_mark_last_busy(q->dev);
>  	} else {
> @@ -112,6 +121,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>  	}
>  	spin_unlock_irq(q->queue_lock);
>  
> +	percpu_ref_switch_to_percpu(&q->q_usage_counter);
>  	blk_pm_runtime_unlock(q);
