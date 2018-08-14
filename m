Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/6] nvme: register ns_id attributes as default sysfs
 groups
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, "keith.busch@intel.com"
 <keith.busch@intel.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20180730071227.22887-1-hare@suse.de>
 <20180730071227.22887-4-hare@suse.de>
 <a15ed0c9327ffd79615e2b9f0d1f2cec8e5d330a.camel@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6ca6fee5-c519-0bc7-f1fe-e093683695a4@suse.de>
Date: Tue, 14 Aug 2018 08:19:53 +0200
MIME-Version: 1.0
In-Reply-To: <a15ed0c9327ffd79615e2b9f0d1f2cec8e5d330a.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 08/13/2018 09:51 PM, Bart Van Assche wrote:
> On Mon, 2018-07-30 at 09:12 +0200, Hannes Reinecke wrote:
>> @@ -3061,11 +3066,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>  
>>  	nvme_get_ctrl(ctrl);
>>  
>> -	device_add_disk(ctrl->device, ns->disk, NULL);
>> -	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
>> -					&nvme_ns_id_attr_group))
>> -		pr_warn("%s: failed to create sysfs group for identification\n",
>> -			ns->disk->disk_name);
>> +	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
>>  	if (ns->ndev && nvme_nvm_register_sysfs(ns))
>>  		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
>>  			ns->disk->disk_name);
> 
> Hello Hannes,
> 
> Have you noticed that nvme_nvm_register_sysfs() also registers sysfs attributes
> and hence that the attributes registered by that function should be merged into
> the nvme_ns_id_attr_groups array?
> 
Actually, no :-)
I'll be looking into it and reposting the series.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
