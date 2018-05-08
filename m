Return-Path: <Christian.Koenig@amd.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Stephen Bates <sbates@raithlin.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <479F2F93-903B-4A8A-8989-A4BD0E5E1471@raithlin.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <44488fb8-8105-b6f8-3438-720ee39d8520@amd.com>
Date: Tue, 8 May 2018 18:37:51 +0200
MIME-Version: 1.0
In-Reply-To: <479F2F93-903B-4A8A-8989-A4BD0E5E1471@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: christian.koenig@amd.com
List-ID: <linux-block@vger.kernel.org>

Am 08.05.2018 um 16:25 schrieb Stephen Bates:
>      
> Hi Christian
>
>> AMD APUs mandatory need the ACS flag set for the GPU integrated in the
>> CPU when IOMMU is enabled or otherwise you will break SVM.
> OK but in this case aren't you losing (many of) the benefits of P2P since all DMAs will now get routed up to the IOMMU before being passed down to the destination PCIe EP?

Well I'm not an expert on this, but I think that is an incorrect 
assumption you guys use here.

At least in the default configuration even with IOMMU enabled P2P 
transactions does NOT necessary travel up to the root complex for 
translation.

It's already late here, but if nobody beats me I'm going to dig up the 
necessary documentation tomorrow.

Regards,
Christian.

>
>> Similar problems arise when you do this for dedicated GPU, but we
>> haven't upstreamed the support for this yet.
> Hmm, as above. With ACS enabled on all downstream ports any P2P enabled DMA will be routed to the IOMMU which removes a lot of the benefit.
>      
>> So that is a clear NAK from my side for the approach.
> Do you have an alternative? This is the approach we arrived it after a reasonably lengthy discussion on the mailing lists. Alex, are you still comfortable with this approach?
>      
>> And what exactly is the problem here?
>   
> We had a pretty lengthy discussion on this topic on one of the previous revisions. The issue is that currently there is no mechanism in the IOMMU code to inform VMs if IOMMU groupings change. Since p2pdma can dynamically change its topology (due to PCI hotplug) we had to be cognizant of the fact that ACS settings could change. Since there is no way to currently handle changing ACS settings and hence IOMMU groupings the consensus was to simply disable ACS on all ports in a p2pdma domain. This effectively makes all the devices in the p2pdma domain part of the same IOMMU grouping. The plan will be to address this in time and add a mechanism for IOMMU grouping changes and notification to VMs but that's not part of this series. Note you are still allowed to have ACS functioning on other PCI domains so if you do not a plurality of IOMMU groupings you can still achieve it (but you can't do p2pdma across IOMMU groupings, which is safe).
>
>> I'm currently testing P2P with  GPUs in different IOMMU domains and at least with AMD IOMMUs that works perfectly fine.
> Yup that should work though again I have to ask are you disabling ACS on the ports between the two peer devices to get the p2p benefit? If not you are not getting all the performance benefit (due to IOMMU routing), if you are then there are obviously security implications between those IOMMU domains if they are assigned to different VMs. And now the issue is if new devices are added and the p2p topology needed to change there would be no way to inform the VMs of any IOMMU group change.
>
> Cheers
>
> Stephen
>      
>
