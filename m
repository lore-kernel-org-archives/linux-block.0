Return-Path: <logang@deltatee.com>
To: Jerome Glisse <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com> <20180301205548.GA6742@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
Date: Thu, 1 Mar 2018 14:03:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180301205548.GA6742@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 01:55 PM, Jerome Glisse wrote:
> Well this again a new user of struct page for device memory just for
> one usecase. I wanted HMM to be more versatile so that it could be use
> for this kind of thing too. I guess the message didn't go through. I
> will take some cycles tomorrow to look into this patchset to ascertain
> how struct page is use in this context.

We looked at it but didn't see how any of it was applicable to our needs.

Logan
