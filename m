Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
 <20180725222607.8854-5-bart.vanassche@wdc.com>
 <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
 <b73752a1ea9356cce26e36bd8538391c5985f81a.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <aa8cbdb5-826d-1481-e60b-1c27b1c02682@oracle.com>
Date: Fri, 27 Jul 2018 09:57:57 +0800
MIME-Version: 1.0
In-Reply-To: <b73752a1ea9356cce26e36bd8538391c5985f81a.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>



On 07/27/2018 06:24 AM, Bart Van Assche wrote:
> On Thu, 2018-07-26 at 10:45 +0800, jianchao.wang wrote:
>> On 07/26/2018 06:26 AM, Bart Van Assche wrote:
>>> @@ -102,9 +109,11 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>>>  		return ret;
>>>  
>>>  	blk_pm_runtime_lock(q);
>>> +	blk_set_preempt_only(q);
>>
>> We only stop non-RQF_PM request entering when RPM_SUSPENDING and RPM_RESUMING.
>> blk_pre_runtime_suspend should only _check_ whether runtime suspend is allowed.
>> So we should not set preempt_only here.
>>
>>> +	percpu_ref_switch_to_atomic_sync(&q->q_usage_counter);
>>>  
>>>  	spin_lock_irq(q->queue_lock);
>>> -	if (q->nr_pending) {
>>> +	if (!percpu_ref_is_zero(&q->q_usage_counter)) {
>>>  		ret = -EBUSY;
>>>  		pm_runtime_mark_last_busy(q->dev);
>>>  	} else {
>>> @@ -112,6 +121,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>>>  	}
>>>  	spin_unlock_irq(q->queue_lock);
>>>  
>>> +	percpu_ref_switch_to_percpu(&q->q_usage_counter);
>>>  	blk_pm_runtime_unlock(q);
> 
> Hello Jianchao,
> 
> There is only one caller of blk_post_runtime_suspend(), namely
> sdev_runtime_suspend(). That function calls pm->runtime_suspend() before
> it calls blk_post_runtime_suspend(). I think it would be wrong to set the
> PREEMPT_ONLY flag from inside blk_post_runtime_suspend() because that could
> cause pm->runtime_suspend() while a request is in progress.
> 

Hi Bart

If q_usage_counter is not zero here, we will leave the request_queue in preempt only mode.
The request_queue should be set to preempt only mode only when we confirm we could set
rpm_status to RPM_SUSPENDING or RPM_RESUMING.

Maybe we could set the PREEMPT_ONLY after we confirm we could set the rpm_status
to RPM_SUSPENDING.
Something like:

	percpu_ref_switch_to_atomic_sync(&q->q_usage_counter);
	if (!percpu_ref_is_zero(&q->q_usage_counter)) {
		ret = -EBUSY;
		pm_runtime_mark_last_busy(q->dev);
     	} else {
		blk_set_preempt_only(q);
		if (!percpu_ref_is_zero(&q->q_usage_counter) {
			ret = -EBUSY;
			pm_runtime_mark_last_busy(q->dev);
			blk_clear_preempt_only(q);
		} else {
			q->rpm_status = RPM_SUSPENDIN;    
		}
        }


Thanks
Jianchao
