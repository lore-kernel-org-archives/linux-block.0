Return-Path: <logang@deltatee.com>
To: Jerome Glisse <jglisse@redhat.com>, Stephen Bates <sbates@raithlin.com>
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
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
 <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
 <20180301142155.5966c4c0@w520.home>
 <EE1B4EB7-D3C0-4916-81CE-E647222D03E4@raithlin.com>
 <20180301213533.GE6742@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0f33b4ec-6d1c-779a-c2cd-82d6ceb4991b@deltatee.com>
Date: Thu, 1 Mar 2018 14:37:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180301213533.GE6742@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 02:35 PM, Jerome Glisse wrote:
> Note that they are usecase for P2P where IOMMU isolation matter and
> the traffic through root complex isn't see as an issue. 

Well, we can worry about that once we have a solution to the problem of 
knowing whether a root complex supports P2P at all. I'm not sure how 
people are going to solve that one.

For the time being, this work is for cards behind a switch only.

Logan
