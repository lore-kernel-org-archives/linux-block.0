Return-Path: <logang@deltatee.com>
To: Stephen Bates <sbates@raithlin.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jerome Glisse <jglisse@redhat.com>
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8113cba8-62b9-1801-7a77-f82be223b183@deltatee.com>
Date: Thu, 10 May 2018 11:15:44 -0600
MIME-Version: 1.0
In-Reply-To: <868B49CE-4F0E-4A48-BE78-12149F85F1A4@raithlin.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>



On 10/05/18 11:11 AM, Stephen  Bates wrote:
>> Not to me. In the p2pdma code we specifically program DMA engines with
>> the PCI bus address. 
> 
> Ah yes of course. Brain fart on my part. We are not programming the P2PDMA initiator with an IOVA but with the PCI bus address...
> 
>> So regardless of whether we are using the IOMMU or
>> not, the packets will be forwarded directly to the peer. If the ACS
>>  Redir bits are on they will be forced back to the RC by the switch and
>>  the transaction will fail. If we clear the ACS bits, the TLPs will go
>>  where we want and everything will work (but we lose the isolation of ACS).
> 
> Agreed.
>     
>>    For EPs that support ATS, we should (but don't necessarily have to)
>>    program them with the IOVA address so they can go through the
>>    translation process which will allow P2P without disabling the ACS Redir
>>    bits -- provided the ACS direct translation bit is set. (And btw, if it
>>    is, then we lose the benefit of ACS protecting against malicious EPs).
>>    But, per above, the ATS transaction should involve only the IOVA address
>>    so the ACS bits not being set should not break ATS.
>     
> Well we would still have to clear some ACS bits but now we can clear only for translated addresses.

We don't have to clear the ACS Redir bits as we did in the first case.
We just have to make sure the ACS Direct Translated bit is set.

Logan
