Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 1/8] nvme-rdma: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-2-git-send-email-sagi@grimberg.me>
 <20170704081541.GC29053@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <43b6e445-d83e-dda0-51a5-a680a2b2623d@grimberg.me>
Date: Tue, 4 Jul 2017 11:59:43 +0300
MIME-Version: 1.0
In-Reply-To: <20170704081541.GC29053@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> @@ -791,7 +791,8 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>>   	 * queues are not a live anymore, so restart the queues to fail fast
>>   	 * new IO
>>   	 */
>> -	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
>> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>> +	blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);
> 
> Now the queue won't be stopped via blk_mq_quiesce_queue(), so why do
> you add blk_mq_kick_requeue_list() here?

I think you're right.

We now quiesce the queue and fast fail inflight io, in
nvme_complete_rq we call blk_mq_requeue_request with
!blk_mq_queue_stopped(req->q) which is now true.

So the requeue_work is triggered and requeue the request,
and when we unquiesce we simply run the hw queues again.

If we were to call it with !blk_queue_quiesced(req->q)
I think it would be needed though...
