Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <b8dd2c24-a011-7e66-feca-502b0a6b10c0@oracle.com>
 <20180426155722.GA3597@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <325688af-3ae2-49db-3a59-ef3903adcdf6@oracle.com>
Date: Fri, 27 Apr 2018 09:37:06 +0800
MIME-Version: 1.0
In-Reply-To: <20180426155722.GA3597@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 04/26/2018 11:57 PM, Ming Lei wrote:
> Hi Jianchao,
> 
> On Thu, Apr 26, 2018 at 11:07:56PM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> Thanks for your wonderful solution. :)
>>
>> On 04/26/2018 08:39 PM, Ming Lei wrote:
>>> +/*
>>> + * This one is called after queues are quiesced, and no in-fligh timeout
>>> + * and nvme interrupt handling.
>>> + */
>>> +static void nvme_pci_cancel_request(struct request *req, void *data,
>>> +		bool reserved)
>>> +{
>>> +	/* make sure timed-out requests are covered too */
>>> +	if (req->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) {
>>> +		req->aborted_gstate = 0;
>>> +		req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
>>> +	}
>>> +
>>> +	nvme_cancel_request(req, data, reserved);
>>> +}
>>> +
>>>  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>>  {
>>>  	int i;
>>> @@ -2223,10 +2316,17 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>>>  	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
>>>  		nvme_suspend_queue(&dev->queues[i]);
>>>  
>>> +	/*
>>> +	 * safe to sync timeout after queues are quiesced, then all
>>> +	 * requests(include the time-out ones) will be canceled.
>>> +	 */
>>> +	nvme_sync_queues(&dev->ctrl);
>>> +	blk_sync_queue(dev->ctrl.admin_q);
>>> +
>> Looks like blk_sync_queue cannot drain all the timeout work.
>>
>> blk_sync_queue
>>   -> del_timer_sync          
>>                           blk_mq_timeout_work
>>                             -> mod_timer
>>   -> cancel_work_sync
>> the timeout work may come back again.
>> we may need to force all the in-flight requests to be timed out with blk_abort_request
>>
> 
> blk_abort_request() seems over-kill, we could avoid this race simply by
> returning EH_NOT_HANDLED if the controller is in-recovery.
return EH_NOT_HANDLED maybe not enough.
please consider the following scenario.

                                      nvme_error_handler
                                        -> nvme_dev_disable
                                          -> blk_sync_queue
//timeout comes again due to the
//scenario above
blk_mq_timeout_work                    
  -> blk_mq_check_expired               
    -> set aborted_gstate
                                          -> nvme_pci_cancel_request
                                            -> RQF_MQ_TIMEOUT_EXPIRED has not been set
                                            -> nvme_cancel_request
                                              -> blk_mq_complete_request
                                                -> do nothing
  -> blk_mq_ternimate_expired
    -> blk_mq_rq_timed_out
      -> set RQF_MQ_TIMEOUT_EXPIRED
      -> .timeout return BLK_EH_NOT_HANDLED

Then the timeout request is leaked.

> 
>>>  	nvme_pci_disable(dev);
>>
>> the interrupt will not come, but there maybe running one.
>> a synchronize_sched() here ?
> 
> We may cover this case by moving nvme_suspend_queue() before
> nvme_stop_queues().
> 
> Both two are very good catch, thanks!
> 
