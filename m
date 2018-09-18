Return-Path: <bvanassche@acm.org>
Subject: Re: [PATCH v7 5/6] block: Make blk_get_request() block for non-PM
 requests while suspended
To: "jianchao.wang" <jianchao.w.wang@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Alan Stern <stern@rowland.harvard.edu>
References: <20180917201525.26570-1-bvanassche@acm.org>
 <20180917201525.26570-6-bvanassche@acm.org>
 <be1de777-357c-ef19-1de0-7b352b3cee96@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <bf97c289-0786-230c-5b81-4e5b9ae17026@acm.org>
Date: Tue, 18 Sep 2018 10:44:29 -0700
MIME-Version: 1.0
In-Reply-To: <be1de777-357c-ef19-1de0-7b352b3cee96@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 9/17/18 7:39 PM, jianchao.wang wrote:
> On 09/18/2018 04:15 AM, Bart Van Assche wrote:
>> Instead of allowing requests that are not power management requests
>> to enter the queue in runtime suspended status (RPM_SUSPENDED), make
>> the blk_get_request() caller block. This change fixes a starvation
>> issue: it is now guaranteed that power management requests will be
>> executed no matter how many blk_get_request() callers are waiting.
>> Instead of maintaining the q->nr_pending counter, rely on
>> q->q_usage_counter.
> 
> Looks like we still depend on this nr_pending for blk-legacy.

That's right. I will update the commit message.

> blk_mq_queue_tag_busy_iter only accounts the driver tags. This will only work w/o io scheduler
> 
>> +
>>   /**
>>    * blk_pre_runtime_suspend - Pre runtime suspend check
>>    * @q: the queue of the device
>> @@ -68,14 +101,38 @@ int blk_pre_runtime_suspend(struct request_queue *q)
>>   	if (!q->dev)
>>   		return ret;
>>   
>> +	WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
>> +
>> +	blk_set_pm_only(q);
>> +	/*
>> +	 * This function only gets called if the most recent
>> +	 * pm_request_resume() call occurred at least autosuspend_delay_ms
>             ^^^^^^^^^^^^^^^^^^^
> pm_runtime_mark_last_busy ?

Since every pm_request_resume() call from the block layer is followed by 
a pm_runtime_mark_last_busy() call and since the latter is called later 
I think you are right. I will update the comment.

>> +	 * ago. Since blk_queue_enter() is called by the request allocation
>> +	 * code before pm_request_resume(), if no requests have a tag assigned
>> +	 * it is safe to suspend the device.
>> +	 */
>> +	ret = -EBUSY;
>> +	if (blk_requests_in_flight(q) == 0) {
>> +		/*
>> +		 * Call synchronize_rcu() such that later blk_queue_enter()
>> +		 * calls see the pm-only state. See also
>> +		 * https://urldefense.proofpoint.com/v2/url?u=http-3A__lwn.net_Articles_573497_&d=DwIDAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=o3yai95U5Ge5APoSiMJX64Z8wlI7gf3x0mFnfHpuA4E&s=VPnOWAeo4J4VB944La0uBcynCgVHE-qp52b_9pV8NH4&e=.
>> +		 */
>> +		synchronize_rcu();
>> +		if (blk_requests_in_flight(q) == 0)
> 
> Seems not safe here.
> 
> For blk-mq path:
> Someone may have escaped from the preempt checking, missed the blk_pm_request_resume there,
> entered into generic_make_request, but have not allocated request and occupied any tag.
> 
> There could be a similar scenario for blk-legacy path, the q->nr_pending is increased when
> request is queued.
> 
> So I guess the q_usage_counter checking is still needed here.

There is only one blk_pm_request_resume() call and that call is inside 
blk_queue_enter() after the pm_only counter has been checked.

For the legacy block layer, nr_pending is increased after the 
blk_queue_enter() call from inside blk_old_get_request() succeeded.

So I don't see how blk_pm_request_resume() or q->nr_pending++ could 
escape from the preempt checking?

Thanks,

Bart.
