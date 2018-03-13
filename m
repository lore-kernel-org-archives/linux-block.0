Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
Date: Mon, 12 Mar 2018 23:28:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180312193525.2855-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/12/2018 3:35 PM, Logan Gunthorpe wrote:
> +int pci_p2pdma_add_client(struct list_head *head, struct device *dev)

It feels like code tried to be a generic p2pdma provider first. Then got
converted to PCI, yet all dev parameters are still struct device.

Maybe, dev parameter should also be struct pci_dev so that you can get rid of
all to_pci_dev() calls in this code including find_parent_pci_dev() function.

Regarding the switch business, It is amazing how much trouble you went into
limit this functionality into very specific hardware.

I thought that we reached to an agreement that code would not impose
any limits on what user wants.

What happened to all the emails we exchanged?

I understand you are coming from what you tested. Considering that you
are singing up for providing a generic PCI functionality into the kernel,
why don't you just blacklist the products that you had problems with and
yet still allow other architectures to use your code with their root ports?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
