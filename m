Return-Path: <logang@deltatee.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Stephen Bates <sbates@raithlin.com>, Jerome Glisse <jglisse@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
 <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
 <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
 <f0101988-cf82-7ffb-2aca-d3b8d2f4b504@deltatee.com>
 <868B49CE-4F0E-4A48-BE78-12149F85F1A4@raithlin.com>
 <8113cba8-62b9-1801-7a77-f82be223b183@deltatee.com>
 <cf2b92c9-7c5b-f19c-b5b1-2f2d435296d1@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <53fa38ce-40dd-6bc1-9b83-c6ccf228b755@deltatee.com>
Date: Fri, 11 May 2018 09:48:27 -0600
MIME-Version: 1.0
In-Reply-To: <cf2b92c9-7c5b-f19c-b5b1-2f2d435296d1@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>

On 5/11/2018 2:52 AM, Christian König wrote:
> This only works when the IOVA and the PCI bus addresses never overlap. 
> I'm not sure how the IOVA allocation works but I don't think we 
> guarantee that on Linux.

I find this hard to believe. There's always the possibility that some 
part of the system doesn't support ACS so if the PCI bus addresses and 
IOVA overlap there's a good chance that P2P and ATS won't work at all on 
some hardware.


> If we really want to enable P2P without ATS and IOMMU enabled I think we 
> should probably approach it like this:
> 
> a) Make double sure that IOVA in an IOMMU group never overlap with PCI 
> BARs in that group.
> 
> b) Add configuration options to put a whole PCI branch of devices (e.g. 
> a bridge) into a single IOMMU group.
> 
> c) Add a configuration option to disable the ACS bit on bridges in the 
> same IOMMU group.

I think a configuration option to manage IOMMU groups as you suggest 
would be a very complex interface and difficult to implement. I prefer 
the option to disable the ACS bit on boot and let the existing code put 
the devices into their own IOMMU group (as it should already do to 
support hardware that doesn't have ACS support).

Logan
