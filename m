Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@intel.com>, Bart van Assche
 <bart.vanassche@wdc.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.com>
References: <20180905070053.26239-1-hare@suse.de>
 <20180905070053.26239-3-hare@suse.de> <20180905131821.GA26956@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c752052a-28ac-588f-0e1b-c784c5065136@suse.de>
Date: Wed, 5 Sep 2018 15:32:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180905131821.GA26956@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/05/2018 03:18 PM, Christoph Hellwig wrote:
> On Wed, Sep 05, 2018 at 09:00:50AM +0200, Hannes Reinecke wrote:
>> We should be registering the ns_id attribute as default sysfs
>> attribute groups, otherwise we have a race condition between
>> the uevent and the attributes appearing in sysfs.
> 
> Please give Bart credit for his work, as the lightnvm bits are almost
> bigger than the rest.
> 
Okay, will be doing so.

>> +static umode_t nvm_dev_attrs_visible(struct kobject *kobj,
>> +				     struct attribute *attr, int index)
>>  {
>> +	struct device *dev = container_of(kobj, struct device, kobj);
>> +	struct gendisk *disk = dev_to_disk(dev);
>> +	struct nvme_ns *ns = disk->private_data;
>>  	struct nvm_dev *ndev = ns->ndev;
>> +	struct device_attribute *dev_attr =
>> +		container_of(attr, typeof(*dev_attr), attr);
>>  
>> +	if (dev_attr->show == nvm_dev_attr_show)
>> +		return attr->mode;
>>  
>> +	switch (ndev ? ndev->geo.major_ver_id : 0) {
> 
> How could ndev be zero here?
> 
For 'normal' NVMe devices (ie non-lightnvm). As we now register all
sysfs attributes (including the lightnvm ones) per default we'll need to
blank them out for non-lightnvm devices.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
