Return-Path: <Christian.Koenig@amd.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Stephen Bates <sbates@raithlin.com>, Jerome Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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
References: <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
 <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
 <20180509174952.GC4140@redhat.com>
 <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <73b6a454-bf84-1640-0b5e-137d03c0ad8c@amd.com>
Date: Thu, 10 May 2018 16:29:44 +0200
MIME-Version: 1.0
In-Reply-To: <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: christian.koenig@amd.com
List-ID: <linux-block@vger.kernel.org>

Am 10.05.2018 um 16:20 schrieb Stephen Bates:
> Hi Jerome
>
>> As it is tie to PASID this is done using IOMMU so looks for caller
>> of amd_iommu_bind_pasid() or intel_svm_bind_mm() in GPU the existing
>>   user is the AMD GPU driver see:
>      
> Ah thanks. This cleared things up for me. A quick search shows there are still no users of intel_svm_bind_mm() but I see the AMD version used in that GPU driver.

Just FYI: There is also another effort ongoing to give both the AMD, 
Intel as well as ARM IOMMUs a common interface so that drivers can use 
whatever the platform offers fro SVM support.

> One thing I could not grok from the code how the GPU driver indicates which DMA events require ATS translations and which do not. I am assuming the driver implements someway of indicating that and its not just a global ON or OFF for all DMAs? The reason I ask is that I looking at if NVMe was to support ATS what would need to be added in the NVMe spec above and beyond what we have in PCI ATS to support efficient use of ATS (for example would we need a flag in the submission queue entries to indicate a particular IO's SGL/PRP should undergo ATS).

Oh, well that is complicated at best.

On very old hardware it wasn't a window, but instead you had to use 
special commands in your shader which indicated that you want to use an 
ATS transaction instead of a normal PCIe transaction for your 
read/write/atomic.

As Jerome explained on most hardware we have a window inside the 
internal GPU address space which when accessed issues a ATS transaction 
with a configurable PASID.

But on very newer hardware that window became a bit in the GPUVM page 
tables, so in theory we now can control it on a 4K granularity basis for 
the internal 48bit GPU address space.

Christian.

>
> Cheers
>
> Stephen
>
