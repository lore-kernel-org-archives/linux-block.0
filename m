Return-Path: <logang@deltatee.com>
To: Stephen Bates <sbates@raithlin.com>, Jerome Glisse <jglisse@redhat.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
 <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
 <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
 <20180510144137.GA3652@redhat.com>
 <B525870A-B25E-46BB-B501-DAA39F1741DC@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3e2269ca-126e-ec13-5133-6591c45ccbf4@deltatee.com>
Date: Thu, 10 May 2018 12:59:47 -0600
MIME-Version: 1.0
In-Reply-To: <B525870A-B25E-46BB-B501-DAA39F1741DC@raithlin.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>



On 10/05/18 12:41 PM, Stephen  Bates wrote:
> Hi Jerome
> 
>>    Note on GPU we do would not rely on ATS for peer to peer. Some part
>>    of the GPU (DMA engines) do not necessarily support ATS. Yet those
>>    are the part likely to be use in peer to peer.
> 
> OK this is good to know. I agree the DMA engine is probably one of the GPU components most applicable to p2pdma.
>     
>>    We (ake GPU people aka the good guys ;)) do no want to do peer to peer
>>    for performance reasons ie we do not care having our transaction going
>>    to the root complex and back down the destination. At least in use case
>>    i am working on this is fine.
> 
> If the GPU people are the good guys does that make the NVMe people the bad guys ;-). If so, what are the RDMA people??? Again good to know.

The NVMe people are the Nice Neighbors, the RDMA people are the
Righteous Romantics and the PCI people are the Pleasant Protagonists...

Obviously.

Logan
