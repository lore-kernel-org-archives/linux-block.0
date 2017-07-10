Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34780 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754009AbdGJSu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2017 14:50:57 -0400
Received: by mail-qk0-f176.google.com with SMTP id d78so81670926qkb.1
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2017 11:50:57 -0700 (PDT)
Subject: Re: [PATCH rfc 02/30] nvme-rdma: Don't alloc/free the tagset on reset
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-3-git-send-email-sagi@grimberg.me>
 <20170619071851.GB13168@lst.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <47506edd-7e91-0367-1a5c-92d5c1b64621@broadcom.com>
Date: Mon, 10 Jul 2017 11:50:54 -0700
MIME-Version: 1.0
In-Reply-To: <20170619071851.GB13168@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 6/19/2017 12:18 AM, Christoph Hellwig wrote:
>> +static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remove)
>>   {
>> +	nvme_rdma_stop_queue(&ctrl->queues[0]);
>> +	if (remove) {
>> +		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
>> +		blk_cleanup_queue(ctrl->ctrl.admin_q);
>> +		blk_mq_free_tag_set(&ctrl->admin_tag_set);
>> +		nvme_rdma_dev_put(ctrl->device);
>> +	}
>> +
>>   	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
>>   			sizeof(struct nvme_command), DMA_TO_DEVICE);
>> +	nvme_rdma_free_queue(&ctrl->queues[0]);
> I don't like the calling convention.  We only have have two callers
> anyway.  So I'd much rather only keep the code inside the if above
> in the new nvme_rdma_destroy_admin_queue that is only called at shutdown
> time, and opencode the calls to nvme_rdma_stop_queue, nvme_rdma_free_qe
> and nvme_rdma_free_queue in the callers.
>

Any chance you can make the organization like what I did with FC and 
avoid all the "new" and "remove" flags ?

e.g. code blocks for:
- allocation/initialization for the controller and the tag sets. 
Basically initial allocation/creation of everything that would be the 
os-facing side of the controller.
- an association (or call it a session) create. Basically everything 
that makes the link-side ties to the subsystem and creates the 
controller and its connections. Does admin queue creation, controller 
init, and io queue creation, and enablement of the blk-mq queues as it 
does so.
- an association teardown. Basically everything that stops the blk-mq 
queues and tears down the link-side ties to the controller.
- a final controller teardown, which removes it from the system. 
Everything that terminates the os-facing side of the controller.

-- james
