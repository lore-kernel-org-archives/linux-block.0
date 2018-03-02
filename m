Return-Path: <logang@deltatee.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Stephen Bates <sbates@raithlin.com>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Wise <swise@opengridcomputing.com>
References: <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301234930.GG14799@localhost.localdomain>
 <CE2A5D93-E735-4414-8DC1-B308B74A1C5B@raithlin.com>
 <20180302161842.GB14861@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a9e2eb46-50ff-e8c6-3b00-a297876c190b@deltatee.com>
Date: Fri, 2 Mar 2018 10:10:31 -0700
MIME-Version: 1.0
In-Reply-To: <20180302161842.GB14861@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
List-ID: <linux-block@vger.kernel.org>



On 02/03/18 09:18 AM, Jason Gunthorpe wrote:

> This allocator is already seems not useful for the P2P target memory
> on a Mellanox NIC due to the way it has a special allocation flow
> (windowing) and special usage requirements..
> 
> Nor can it be usefull for the doorbell memory in the NIC.

No one says every P2P use has to use P2P memory. Doorbells are obviously 
not P2P memory. But it's the p2mem interface that's important and the 
interface absolutely does not belong in the NVMe driver. Once you have 
the P2P memory interface you need an allocator behind it and the obvious 
place is in the P2P code to handle the common case where you're just 
mapping a BAR. We don't need to implement a genalloc in every driver 
that has P2P memory attached with it. If some hardware wants to expose 
memory that requires complicated allocation it's up to them to solve 
that problem but that isn't enough justification, to me, to push common 
code into every driver.

> Both of these are existing use cases for P2P with out of tree patches..

And we have out of tree code that uses the generic allocator part of 
p2pmem.

> The allocator seems to only be able to solve the CMB problem, and I
> think due to that it is better to put this allocator in the NVMe
> driver and not the core code.. At least until we find a 2nd user that
> needs the same allocation scheme...

See the first P2PMEM RFC. We used Chelsio's NIC instead of the CMB with 
a very similar allocation scheme. We'd still be enabling that NIC in the 
same way if we didn't run into hardware issues with it. A simple BAR 
with memory behind it is always going to be the most common case.

Logan
