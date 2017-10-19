Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 10/17] nvme: switch controller refcounting to use struct
 device
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-11-hch@lst.de>
 <b4e85bf7-f0ae-4ea9-2caa-3ba3645f88ea@grimberg.me>
 <20171019072053.GA12168@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <05edcff6-4c56-39d9-83c8-e3eae03b824d@grimberg.me>
Date: Thu, 19 Oct 2017 10:31:20 +0300
MIME-Version: 1.0
In-Reply-To: <20171019072053.GA12168@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> -	if (!kref_get_unless_zero(&ctrl->ctrl.kref))
>>> -		return -EBUSY;
>>> +	nvme_get_ctrl(&ctrl->ctrl);
>>
>> Given that we take this reference before we are protected with
>> the state change I think this should still be get_unless_zero.
> 
> Because we now refcount the device we must have a reference on it
> when we call the sysfs file for it, and for the fabrics file
> we have an explicit reference already.  So there should not be
> any need to do the unless_zero.

I don't think the fabrics device does not help us to keep the ctrl
allocated until we finish removal.

I do agree that the kobj reference in nvme_dev_open keeps it alive.
