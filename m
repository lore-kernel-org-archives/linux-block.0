Return-Path: <logang@deltatee.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Stephen Bates <sbates@raithlin.com>, Sinan Kaya <okaya@codeaurora.org>,
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
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <8de5d3dd-a78f-02d5-0eea-4365364143b6@deltatee.com>
 <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
 <112493af-ccd0-455b-6600-b50764f7ab7e@deltatee.com>
 <20180314185159.GD179719@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b75e83ad-bb83-1f8d-1751-0989cc2493f1@deltatee.com>
Date: Wed, 14 Mar 2018 13:03:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180314185159.GD179719@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
List-ID: <linux-block@vger.kernel.org>



On 14/03/18 12:51 PM, Bjorn Helgaas wrote:
> You are focused on PCIe systems, and in those systems, most topologies
> do have an upstream switch, which means two upstream bridges.  I'm
> trying to remove that assumption because I don't think there's a
> requirement for it in the spec.  Enforcing this assumption complicates
> the code and makes it harder to understand because the reader says
> "huh, I know peer-to-peer DMA should work inside any PCI hierarchy*,
> so why do we need these two bridges?"

Yes, as I've said, we focused on being behind a single PCIe Switch
because it's easier and vaguely safer (we *know* switches will work but
other types of topology we have to assume will work based on the spec).
Also, I have my doubts that anyone will ever have a use for this with
non-PCIe devices.

A switch shows up as two or more virtual bridges (per the PCIe v4 Spec
1.3.3) which explains the existing get_upstream_bridge_port() function.

In any case, we'll look at generalizing this by looking for a common
upstream port in the next revision of the patch set.

Logan
