Return-Path: <logang@deltatee.com>
To: Stephen Bates <sbates@raithlin.com>, Keith Busch <keith.busch@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>,
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
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301234930.GG14799@localhost.localdomain>
 <CE2A5D93-E735-4414-8DC1-B308B74A1C5B@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9de7d9d1-3469-c315-ce47-0faa67a4e4c4@deltatee.com>
Date: Thu, 1 Mar 2018 17:03:09 -0700
MIME-Version: 1.0
In-Reply-To: <CE2A5D93-E735-4414-8DC1-B308B74A1C5B@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 04:57 PM, Stephen  Bates wrote:
>> We don't want to lump these all together without knowing which region you're allocating from, right?
> 
> In all seriousness I do agree with you on these Keith in the long term. We would consider adding property flags for the memory as it is added to the p2p core and then the allocator could evolve to intelligently dish it out. Attributes like endurance, latency and special write commit requirements could all become attributes in time. Perhaps one more reason for a central entity for p2p memory allocation so this code does not end up having to go into many different drivers?

Ugh, I don't know... An allocator for PMR is going to be quite a 
different animal. It would probably need to look more like a filesystem 
given you'd need to access the same regions across reboots. I don't 
think it fits the p2pmem paradigm at all. I think it's something 
entirely new all together and who knows exactly what it will look like.

Logan
