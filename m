Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v7 5/6] block: Make blk_get_request() block for non-PM
 requests while suspended
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180917201525.26570-1-bvanassche@acm.org>
 <20180917201525.26570-6-bvanassche@acm.org>
 <be1de777-357c-ef19-1de0-7b352b3cee96@oracle.com>
 <bf97c289-0786-230c-5b81-4e5b9ae17026@acm.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <faa2e932-8557-37b7-3283-8de551d54482@oracle.com>
Date: Wed, 19 Sep 2018 10:21:17 +0800
MIME-Version: 1.0
In-Reply-To: <bf97c289-0786-230c-5b81-4e5b9ae17026@acm.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 09/19/2018 01:44 AM, Bart Van Assche wrote:
>>> +     * ago. Since blk_queue_enter() is called by the request allocation
>>> +     * code before pm_request_resume(), if no requests have a tag assigned
>>> +     * it is safe to suspend the device.
>>> +     */
>>> +    ret = -EBUSY;
>>> +    if (blk_requests_in_flight(q) == 0) {
>>> +        /*
>>> +         * Call synchronize_rcu() such that later blk_queue_enter()
>>> +         * calls see the pm-only state. See also
>>> +         * https://urldefense.proofpoint.com/v2/url?u=http-3A__lwn.net_Articles_573497_&d=DwIDAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=o3yai95U5Ge5APoSiMJX64Z8wlI7gf3x0mFnfHpuA4E&s=VPnOWAeo4J4VB944La0uBcynCgVHE-qp52b_9pV8NH4&e=.
>>> +         */
>>> +        synchronize_rcu();
>>> +        if (blk_requests_in_flight(q) == 0)
>>
>> Seems not safe here.
>>
>> For blk-mq path:
>> Someone may have escaped from the preempt checking, missed the blk_pm_request_resume there,
>> entered into generic_make_request, but have not allocated request and occupied any tag.
>>
>> There could be a similar scenario for blk-legacy path, the q->nr_pending is increased when
>> request is queued.
>>
>> So I guess the q_usage_counter checking is still needed here.
> 
> There is only one blk_pm_request_resume() call and that call is inside blk_queue_enter() after the pm_only counter has been checked.
> 
> For the legacy block layer, nr_pending is increased after the blk_queue_enter() call from inside blk_old_get_request() succeeded.
> 
> So I don't see how blk_pm_request_resume() or q->nr_pending++ could escape from the preempt checking?

For example:


blk_pre_runtime_suspend                    generic_make_request
                                             blk_queue_enter  // success here, no blk_pm_request_resume here
                                             blk_mq_make_requset
blk_set_pm_only

if (blk_requests_in_flight(q) == 0) {
  synchronize_rcu();
  if (blk_requests_in_flight(q) == 0)
    ret = 0;
  }
                                             blk_mq_get_request

Thanks
Jianchao
