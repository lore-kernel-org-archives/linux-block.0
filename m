Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <AA646409-BB63-4757-A250-CE7118D4D3B8@raithlin.com>
References: <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org> <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org> <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com> <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <8de5d3dd-a78f-02d5-0eea-4365364143b6@deltatee.com> <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
 <112493af-ccd0-455b-6600-b50764f7ab7e@deltatee.com> <20180314185159.GD179719@bhelgaas-glaptop.roam.corp.google.com>
 <b75e83ad-bb83-1f8d-1751-0989cc2493f1@deltatee.com> <CAPcyv4g-A6fqdTahxX=aONSCgp1eEvBb=ZVMzbZUWUDmqBbj7Q@mail.gmail.com>
 <AA646409-BB63-4757-A250-CE7118D4D3B8@raithlin.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 14 Mar 2018 21:30:41 -0700
Message-ID: <CAPcyv4j4JOXYvf7e1x591oNPzk7b+pEDkzpFj3aBs+dXe5SqbQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
To: Stephen Bates <sbates@raithlin.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Sinan Kaya <okaya@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 14, 2018 at 12:34 PM, Stephen  Bates <sbates@raithlin.com> wrote:
>> P2P over PCI/PCI-X is quite common in devices like raid controllers.
>
> Hi Dan
>
> Do you mean between PCIe devices below the RAID controller? Isn't it pretty novel to be able to support PCIe EPs below a RAID controller (as opposed to SCSI based devices)?

I'm thinking of the classic I/O offload card where there's an NTB to
an internal PCI bus that has a storage controller and raid offload
engines.
