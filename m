Return-Path: <hch@lst.de>
Date: Wed, 18 Oct 2017 12:12:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 5/9] nvme: track subsystems
Message-ID: <20171018101230.GA14859@lst.de>
References: <20170925134031.10548-1-hch@lst.de> <20170925134031.10548-6-hch@lst.de> <1535c6f9-8ddf-ab30-2bbd-5d9ce626b913@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535c6f9-8ddf-ab30-2bbd-5d9ce626b913@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

>>   static void nvme_free_ctrl(struct kref *kref)
>>   {
>>   	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
>> +	struct nvme_subsystem *subsys = ctrl->subsys;
>>     	put_device(ctrl->device);
>>   	nvme_release_instance(ctrl);
>>   	ida_destroy(&ctrl->ns_ida);
>>   +	if (subsys) {
>> +		mutex_lock(&subsys->lock);
>> +		list_del(&ctrl->subsys_entry);
>> +		mutex_unlock(&subsys->lock);
>> +	}
>> +
>
> When can this happen? can a controller not have a subsys?

When we fail early enough to not have set up the subsystem yet.
