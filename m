Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
Date: Tue, 13 Mar 2018 17:22:53 -0400
MIME-Version: 1.0
In-Reply-To: <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/13/2018 4:46 PM, Logan Gunthorpe wrote:
> 
> 
> On 13/03/18 01:53 PM, Sinan Kaya wrote:
>> I agree disabling globally would be bad. Somebody can always say I have
>> ten switches on my system. I want to do peer-to-peer on one switch only. Now,
>> this change weakened security for the other switches that I had no intention
>> with doing P2P.
>>
>> Isn't this a problem?
> 
> Well, if it's a problem for someone they'll have to solve it. We're
> targeting JBOFs that have no use for ACS / IOMMU groups at all.
> 
>> Can we specify the BDF of the downstream device we want P2P with during boot via
>> kernel command line?
> 
> That's a painful configuration burden. And then things might stop
> working if you change your topology at all and now have to change boot
> parameters.
> 

It sounds like you have very tight hardware expectations for this to work
at this moment. You also don't want to generalize this code for others and
address the shortcomings.

To get you going, you should limit this change to the switch products that you have
validated via white-listing PCI vendor/device ids. Please do not enable this feature
for all other PCI devices or by default.

I think your code qualifies as a virus until this issue is resolved (so NAK). 

Another option is for your CONFIG to depend on BROKEN/EXPERT.

You are delivering a general purpose P2P code with a lot of holes in it and
expecting people to jump through it.

Turning security off by default is also not acceptable. Linux requires ACS support
even though you don't care about it for your particular application.

I'd hate ACS to be broken due to some operating system enabling your CONFIG option.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
