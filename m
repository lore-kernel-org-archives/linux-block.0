Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH v2 2/3] nvme: avoid to use blk_mq_abort_requeue_list()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Zhang Yi <yizhan@redhat.com>, stable@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-3-ming.lei@redhat.com>
 <20170520053409.GA22317@ming.t460p>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <bc4609f3-3f0d-1f05-ebae-5a7be49882d3@suse.de>
Date: Mon, 22 May 2017 09:42:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170520053409.GA22317@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/20/2017 07:34 AM, Ming Lei wrote:
> On Sat, May 20, 2017 at 11:56:04AM +0800, Ming Lei wrote:
>> NVMe may add request into requeue list simply and not kick off the
>> requeue if hw queues are stopped. Then blk_mq_abort_requeue_list()
>> is called in both nvme_kill_queues() and nvme_ns_remove() for
>> dealing with this issue.
>>
>> Unfortunately blk_mq_abort_requeue_list() is absolutely a
>> race maker, for example, one request may be requeued during
>> the aborting. So this patch just calls blk_mq_kick_requeue_list() in
>> nvme_kill_queues() to handle this issue like what nvme_start_queues()
>> does. Now all requests in requeue list when queues are stopped will be
>> handled by blk_mq_kick_requeue_list() when queues are restarted, either
>> in nvme_start_queues() or in nvme_kill_queues().
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Zhang Yi <yizhan@redhat.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>  drivers/nvme/host/core.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index ce0d96913ee6..9ce0a0a16984 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2098,7 +2098,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>  		if (ns->ndev)
>>  			nvme_nvm_unregister_sysfs(ns);
>>  		del_gendisk(ns->disk);
>> -		blk_mq_abort_requeue_list(ns->queue);
>>  		blk_cleanup_queue(ns->queue);
>>  	}
>>  
>> @@ -2436,7 +2435,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>>  			continue;
>>  		revalidate_disk(ns->disk);
>>  		blk_set_queue_dying(ns->queue);
>> -		blk_mq_abort_requeue_list(ns->queue);
>>  
>>  		/*
>>  		 * We have to force to start queues for avoiding hang
>> @@ -2444,6 +2442,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>>  		 * be stopped forever from now on.
>>  		 */
>>  		blk_mq_start_hw_queues(ns->queue);
>> +
>> +		/* draining requests in requeue list */
>> +		blk_mq_kick_requeue_list(q);
> 
> oops, the above line causes build failure, please
> take the following one.
> 
> ---
> 
> From e70cfe2edacf278e3e6605f8c08e01ebf65bff01 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Wed, 17 May 2017 09:02:07 +0800
> Subject: [PATCH v2 2/3] nvme: avoid to use blk_mq_abort_requeue_list()
> 
> NVMe may add request into requeue list simply and not kick off the
> requeue if hw queues are stopped. Then blk_mq_abort_requeue_list()
> is called in both nvme_kill_queues() and nvme_ns_remove() for
> dealing with this issue.
> 
> Unfortunately blk_mq_abort_requeue_list() is absolutely a
> race maker, for example, one request may be requeued during
> the aborting. So this patch just calls blk_mq_kick_requeue_list() in
> nvme_kill_queues() to handle this issue like what nvme_start_queues()
> does. Now all requests in requeue list when queues are stopped will be
> handled by blk_mq_kick_requeue_list() when queues are restarted, either
> in nvme_start_queues() or in nvme_kill_queues().
> 
> Cc: stable@vger.kernel.org
> Reported-by: Zhang Yi <yizhan@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
