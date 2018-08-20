Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hare@suse.com" <hare@suse.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
 <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
 <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
 <20180817070013.GD11170@lst.de>
 <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57d23cf3-b408-434c-9a20-dfa4eb309677@suse.de>
Date: Mon, 20 Aug 2018 08:34:29 +0200
MIME-Version: 1.0
In-Reply-To: <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 08/17/2018 10:04 PM, Bart Van Assche wrote:
> On Fri, 2018-08-17 at 09:00 +0200, hch@lst.de wrote:
>> On Tue, Aug 14, 2018 at 03:44:57PM +0000, Bart Van Assche wrote:
>>> On Tue, 2018-08-14 at 17:39 +0200, Hannes Reinecke wrote:
>>>> While I have considered having nvme_nvm_register_sysfs() returning a
>>>> pointer I would then have to remove the 'static' declaration from the
>>>> nvm_dev_attr_group_12/20.
>>>> Which I didn't really like, either.
>>>
>>> Hmm ... I don't see why the static declaration would have to be removed from
>>> nvm_dev_attr_group_12/20 if nvme_nvm_register_sysfs() would return a pointer?
>>> Am I perhaps missing something?
>>
>> No, I think that would be the preferable approach IFF patching the global
>> table of groups would be viable.  I don't think it is, though - we can
>> have both normal NVMe and LightNVM devices in the same system, so we
>> can't just patch it over.
>>
>> So we'll need three different attribut group arrays:
>>
>> const struct attribute_group *nvme_ns_id_attr_groups[] = {
>> 	&nvme_ns_id_attr_group,
>> 	NULL,
>> };
>>
>> const struct attribute_group *lightnvm12_ns_id_attr_groups[] = {
>> 	&nvme_ns_id_attr_group,
>> 	&nvm_dev_attr_group_12,
>> 	NULL,
>> };
>>
>> const struct attribute_group *lightnvm20_ns_id_attr_groups[] = {
>> 	&nvme_ns_id_attr_group,
>> 	&nvm_dev_attr_group_20,
>> 	NULL,
>> };
>>
>> and a function to select which one to use.
> 
> Hello Christoph,
> 
> How about applying the patch below on top of Hannes' patch? The patch below
> has the advantage that it completely separates the open channel sysfs
> attributes from the NVMe core sysfs attributes - the open channel code
> doesn't have to know anything about the NVMe core sysfs attributes and the
> NVMe core does not have to know anything about the open channel sysfs
> attributes.
> 
Yes, this looks like the best approach.
I'll fold it into my patchset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
