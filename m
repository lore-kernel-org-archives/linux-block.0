Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 3/8] nvme-loop: quiesce admin_q instead of stopping hw
 queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-4-git-send-email-sagi@grimberg.me>
 <20170704082232.GE29053@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <67c17f61-e225-74ce-5803-8452c987a6a0@grimberg.me>
Date: Tue, 4 Jul 2017 12:24:20 +0300
MIME-Version: 1.0
In-Reply-To: <20170704082232.GE29053@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

>> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
>> index 3d51341e62ee..891002ee005f 100644
>> --- a/drivers/nvme/target/loop.c
>> +++ b/drivers/nvme/target/loop.c
>> @@ -434,7 +434,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
>>   	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
>>   		nvme_shutdown_ctrl(&ctrl->ctrl);
>>   
>> -	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
>> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>>   	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>>   				nvme_cancel_request, &ctrl->ctrl);
>>   	nvme_loop_destroy_admin_queue(ctrl);
> 
> Is the queue killed before calling nvme_loop_destroy_admin_queue()?

No, its not.

> If not, simply quiescing and not unquiescing will hang in
> blk_cleanup_queue().

Why should it? blk_cleanup_queue does not hang, even under IO load...

> So I suggest to put blk_mq_unquiesce_queue() after blk_mq_tagset_busy_iter().

I can do that, but I don't understand why...
