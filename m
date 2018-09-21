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
Message-ID: <736867f3-8b3e-2e8f-1929-60e5e3cba2b5@deltatee.com>
Date: Fri, 21 Sep 2018 15:12:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180921161858.GH224714@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 04/13] PCI/P2PDMA: Introduce configfs/sysfs enable
 attribute helpers
List-ID: <linux-block@vger.kernel.org>



On 2018-09-21 10:18 a.m., Bjorn Helgaas wrote:
> It'd be sort of nice if the contents of the sysfs file were valid
> things you could put *back* into it.  But it looks like the contents
> might be "none", which isn't valid for the store.  And the contents
> are never "on" or "off".

In fact, "none" would be accepted by strtobool() as a false (seeing it
starts with 'n' and strtobool() only looks at the first character).
However, per the rest of your feedback I've changed show() to report
"0", "1" or  pci_name() and dropped "auto". This matches what the other
strtobool configfs attributes are doing in NVMe target.

Logan
