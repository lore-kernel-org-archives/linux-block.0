Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:46400
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753346AbeBVK4O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 05:56:14 -0500
Subject: Re: how can one drain MQ request queue ?
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, <linux-nvme@lists.infradead.org>
References: <a8d50fdf-1ed9-1f10-1ac9-4cbbf223cb8b@mellanox.com>
 <20180222025943.GB1150@ming.t460p>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a18346ff-e323-dd38-bcd9-77b3dfebf7ef@mellanox.com>
Date: Thu, 22 Feb 2018 12:56:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180222025943.GB1150@ming.t460p>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2/22/2018 4:59 AM, Ming Lei wrote:
> Hi Max,

Hi Ming,

> 
> On Tue, Feb 20, 2018 at 11:56:07AM +0200, Max Gurtovoy wrote:
>> hi all,
>> is there a way to drain a blk-mq based request queue (similar to
>> blk_drain_queue for non MQ) ?
> 
> Generally speaking, blk_mq_freeze_queue() should be fine to drain blk-mq
> based request queue, but it may not work well when the hardware is broken.

I tried that, but the path failover takes ~cmd_timeout seconds and this 
is not good enough...

> 
>>
>> I try to fix the following situation:
>> Running DM-multipath over NVMEoF/RDMA block devices, toggling the switch
>> ports during traffic using fio and making sure the traffic never fails.
>>
>> when the switch port goes down the initiator driver start an error recovery
> 
> What is the code you are referring to?

from nvme_rdma driver:

static void nvme_rdma_error_recovery_work(struct work_struct *work)
{
         struct nvme_rdma_ctrl *ctrl = container_of(work,
                         struct nvme_rdma_ctrl, err_work);

         nvme_stop_keep_alive(&ctrl->ctrl);

         if (ctrl->ctrl.queue_count > 1) {
                 nvme_stop_queues(&ctrl->ctrl);
                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
                                         nvme_cancel_request, &ctrl->ctrl);
                 nvme_rdma_destroy_io_queues(ctrl, false);
         }

         blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
                                 nvme_cancel_request, &ctrl->ctrl);
         nvme_rdma_destroy_admin_queue(ctrl, false);

         /*
          * queues are not a live anymore, so restart the queues to fail 
fast
          * new IO
          */
         blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
         nvme_start_queues(&ctrl->ctrl);

         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
                 /* state change failure should never happen */
                 WARN_ON_ONCE(1);
                 return;
         }

         nvme_rdma_reconnect_or_remove(ctrl);
}


> 
>> process
>> - blk_mq_quiesce_queue for each namespace request queue
> 
> blk_mq_quiesce_queue() only guarantees that no requests can be dispatched to
> low level driver, and new requests still can be allocated, but can't be
> dispatched until the queue becomes unquiesced.
> 
>> - cancel all requests of the tagset using blk_mq_tagset_busy_iter
> 
> Generally blk_mq_tagset_busy_iter() is used to cancel all in-flight
> requests, and it depends on implementation of the busy_tag_iter_fn, and
> timed-out request can't be covered by blk_mq_tagset_busy_iter().

How can we deal with timed-out commands ?


> 
> So blk_mq_tagset_busy_iter() is often used in error recovery path, such
> as nvme_dev_disable(), which is usually used in resetting PCIe NVMe controller.
> 
>> - destroy the QPs/RDMA connections and MR pools
>> - blk_mq_unquiesce_queue for each namespace request queue
>> - reconnect to the target (after creating RDMA resources again)
>>
>> During the QP destruction, I see a warning that not all the memory regions
>> were back to the mr_pool. For every request we get from the block layer
>> (well, almost every request) we get a MR from the MR pool.
>> So what I see is that, depends on the timing, some requests are
>> dispatched/completed after we blk_mq_unquiesce_queue and after we destroy
>> the QP and the MR pool. Probably these request were inserted during
>> quiescing,
> 
> Yes.

maybe we need to update the nvmf_check_init_req to check that the ctrl 
is in NVME_CTRL_LIVE state (otherwise return IOERR), but I need to think 
about it and test it.

> 
>> and I want to flush/drain them before I destroy the QP.
> 
> As mentioned above, you can't do that by blk_mq_quiesce_queue() &
> blk_mq_tagset_busy_iter().
> 
> The PCIe NVMe driver takes two steps for the error recovery: nvme_dev_disable() &
> nvme_reset_work(), and you may consider the similar approach, but the in-flight
> requests won't be drained in this case because they can be requeued.
> 
> Could you explain a bit what your exact problem is?

The problem is that I assign an MR from QP mr_pool for each call to 
nvme_rdma_queue_rq. During the error recovery I destroy the QP and the 
mr_pool *but* some MR's are missing and not returned to the pool.


> 
> Thanks,
> Ming
> 

Thanks,
Max.
