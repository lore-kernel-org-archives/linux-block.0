Return-Path: <ddutile@redhat.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Stephen Bates <sbates@raithlin.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508144341.0441b676@w520.home>
 <a524127a-3557-3dff-971c-dfe94ba5a01c@deltatee.com>
 <20180508152631.50fd583c@w520.home>
 <354F7407-0DC7-470C-B9AA-74FDF9C46B08@raithlin.com>
 <20180508160336.0935ddde@w520.home>
 <11819753-af26-4632-8580-d4a47127a3b2@redhat.com>
 <C6D0BD3A-FA82-425A-899C-C2DBDCBC7EEC@raithlin.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <09b4088a-838a-48f5-4395-f261de483dbf@redhat.com>
Date: Wed, 9 May 2018 11:58:46 -0400
MIME-Version: 1.0
In-Reply-To: <C6D0BD3A-FA82-425A-899C-C2DBDCBC7EEC@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/09/2018 08:44 AM, Stephen  Bates wrote:
> Hi Don
> 
>>     RDMA VFs lend themselves to NVMEoF w/device-assignment.... need a way to
>>     put NVME 'resources' into an assignable/manageable object for 'IOMMU-grouping',
>>     which is really a 'DMA security domain' and less an 'IOMMU grouping domain'.
>      
> Ha, I like your term "DMA Security Domain" which sounds about right for what we are discussing with p2pdma and ACS disablement ;-). The problem is that ACS is, in some ways, too big of hammer for what we want here in the sense that it is either on or off for the bridge or MF EP we enable/disable it for. ACS can't filter the TLPs by address or ID though PCI-SIG are having some discussions on extending ACS. That's a long term solution and won't be applicable to us for some time.
> 
> NVMe SSDs that support SR-IOV are coming to market but we can't assume all NVMe SSDs with support SR-IOV. That will probably be a pretty high end-feature...
> 
> Stephen
>      
>      
> 
Sure, we could provide unsecure enablement for development and kick-the-tires deployment ..
device-assignment started that way (no ACS, no intr-remapping, etc.), but for secure setups,
VF's for both p2p EPs is the best security model.
So, we should have a design goal for the secure configuration.
workarounds/unsecure modes to deal with near-term what-we-have-to-work-with can be employed, but they shoudn't be
the only/defacto/final-solution.
