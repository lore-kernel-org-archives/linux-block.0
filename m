Return-Path: <logang@deltatee.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <b8acf835-df94-9967-2327-8f0e39d88511@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <805645c1-ea40-2e57-88eb-5dd34e579b2e@deltatee.com>
Date: Wed, 2 May 2018 09:56:09 -0600
MIME-Version: 1.0
In-Reply-To: <b8acf835-df94-9967-2327-8f0e39d88511@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>

Hi Christian,

On 5/2/2018 5:51 AM, Christian König wrote:
> it would be rather nice to have if you could separate out the functions 
> to detect if peer2peer is possible between two devices.

This would essentially be pci_p2pdma_distance() in the existing 
patchset. It returns the sum of the distance between a list of clients 
and a P2PDMA provider. It returns -1 if peer2peer is not possible 
between the devices (presently this means they are not behind the same 
root port).

Logan
