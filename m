Return-Path: <logang@deltatee.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
Date: Tue, 8 May 2018 13:13:40 -0600
MIME-Version: 1.0
In-Reply-To: <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>



On 08/05/18 10:50 AM, Christian König wrote:
> E.g. transactions are initially send to the root complex for 
> translation, that's for sure. But at least for AMD GPUs the root complex 
> answers with the translated address which is then cached in the device.
> 
> So further transactions for the same address range then go directly to 
> the destination.

Sounds like you are referring to Address Translation Services (ATS).
This is quite separate from ACS and, to my knowledge, isn't widely
supported by switch hardware.

Logan
