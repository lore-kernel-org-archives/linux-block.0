Return-Path: <logang@deltatee.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-5-logang@deltatee.com>
 <20180921161858.GH224714@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <db325d7a-f3c7-a287-b2b7-3530ef75cd9f@deltatee.com>
Date: Fri, 21 Sep 2018 13:44:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180921161858.GH224714@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 04/13] PCI/P2PDMA: Introduce configfs/sysfs enable
 attribute helpers
List-ID: <linux-block@vger.kernel.org>

On 2018-09-21 10:18 AM, Bjorn Helgaas wrote:
> Where do these store/show functions get connected to sysfs?  I know
> there's a lot of magic there, so apologies if I'm missing it.

Well in this patch set they are used in configfs not sysfs. It's not
magic, they are just helpers for other drivers. They are called in Patch
13 by NVMe target's configfs functions.

Logan
