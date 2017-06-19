Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33496 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdFSQY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 12:24:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id f90so17392623wmh.0
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2017 09:24:29 -0700 (PDT)
Subject: Re: [PATCH rfc 25/30] nvme: move control plane handling to nvme core
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-26-git-send-email-sagi@grimberg.me>
 <20170619125505.GS29061@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ff56bb79-1d57-b565-72a3-cd1e72b468b3@grimberg.me>
Date: Mon, 19 Jun 2017 19:24:25 +0300
MIME-Version: 1.0
In-Reply-To: <20170619125505.GS29061@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>> +static void nvme_free_io_queues(struct nvme_ctrl *ctrl)
>> +{
>> +	int i;
>> +
>> +	for (i = 1; i < ctrl->queue_count; i++)
>> +		ctrl->ops->free_hw_queue(ctrl, i);
>> +}
>> +
>> +void nvme_stop_io_queues(struct nvme_ctrl *ctrl)
>> +{
>> +	int i;
>> +
>> +	for (i = 1; i < ctrl->queue_count; i++)
>> +		ctrl->ops->stop_hw_queue(ctrl, i);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_stop_io_queues);
> 
> At leasr for PCIe this is going to work very differently, so I'm not
> sure this part make so much sense in the core.  Maybe in Fabrics?
> Or at least make the callouts operate on all I/O queues, which would
> suite PCIe a lot more.

Yea, I spent some time thinking on the async nature of queue
removal for pci... I started from ->stop/free_io_queues callouts
but hated the fact that we need to iterate exactly the same way
in every driver...

We could have an optional stop/free_io_queues that the core
will call instead if implemented?

>> +	error = ctrl->ops->start_hw_queue(ctrl, 0);
>> +	if (error)
>> +		goto out_cleanup_connect_queue;
>> +
>> +	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
>> +	if (error) {
>> +		dev_err(ctrl->device,
>> +			"prop_get NVME_REG_CAP failed\n");
>> +		goto out_cleanup_connect_queue;
>> +	}
>> +
>> +	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
>> +
>> +	error = nvme_enable_ctrl(ctrl, ctrl->cap);
>> +	if (error)
>> +		goto out_cleanup_connect_queue;
> 
> I'm not sure this ordering is going to work for PCIe..

This one is easy to reverse...
