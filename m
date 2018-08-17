Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
To: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
 <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
 <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
 <20180817070013.GD11170@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1efe41bd-41f7-127f-994e-da51b02ead41@suse.de>
Date: Fri, 17 Aug 2018 09:53:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180817070013.GD11170@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/17/2018 09:00 AM, hch@lst.de wrote:
> On Tue, Aug 14, 2018 at 03:44:57PM +0000, Bart Van Assche wrote:
>> On Tue, 2018-08-14 at 17:39 +0200, Hannes Reinecke wrote:
>>> While I have considered having nvme_nvm_register_sysfs() returning a
>>> pointer I would then have to remove the 'static' declaration from the
>>> nvm_dev_attr_group_12/20.
>>> Which I didn't really like, either.
>>
>> Hmm ... I don't see why the static declaration would have to be removed from
>> nvm_dev_attr_group_12/20 if nvme_nvm_register_sysfs() would return a pointer?
>> Am I perhaps missing something?
> 
> No, I think that would be the preferable approach IFF patching the global
> table of groups would be viable.  I don't think it is, though - we can
> have both normal NVMe and LightNVM devices in the same system, so we
> can't just patch it over.
> 
> So we'll need three different attribut group arrays:
> 
> const struct attribute_group *nvme_ns_id_attr_groups[] = {
> 	&nvme_ns_id_attr_group,
> 	NULL,
> };
> 
> const struct attribute_group *lightnvm12_ns_id_attr_groups[] = {
> 	&nvme_ns_id_attr_group,
> 	&nvm_dev_attr_group_12,
> 	NULL,
> };
> 
> const struct attribute_group *lightnvm20_ns_id_attr_groups[] = {
> 	&nvme_ns_id_attr_group,
> 	&nvm_dev_attr_group_20,
> 	NULL,
> };
> 
> and a function to select which one to use.
> 
Yeah, I figured the same thing.
I'll be redoing the patchset.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
