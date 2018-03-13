Return-Path: <logang@deltatee.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org,
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
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
Date: Tue, 13 Mar 2018 13:19:32 -0600
MIME-Version: 1.0
In-Reply-To: <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
List-ID: <linux-block@vger.kernel.org>



On 13/03/18 01:10 PM, Sinan Kaya wrote:
> I was thinking of this for the pci_p2pdma_add_client() case for the
> parent pointer.
> 
> +struct pci_p2pdma_client {
> +	struct list_head list;
> +	struct pci_dev *client;
> +	struct pci_dev *provider;
> +};

Yeah, that structure only exists in a list owned by the client and we
only check the upstream bridge once per entry so I don't see the point.

> But then, Why bother searching for the switch at all?

Huh? We have to make sure all the client and provider devices are behind
the same switch. How can we do that without "searching" for the switch?

In the ACS case, we only disable ACS on downstream ports of switches. No
sense disabling it globally as that's worse from an isolation point of
view and not worth it given we require all P2P transactions to be behind
a switch.

> Even if the switch is there, there is no guarantee that it is currently
> being used for P2P.

IOMMU groups are set at boot time and, at present, there's no way to
dynamically change ACS bits without messing up the groups. So switches
not used for P2P will not have ACS enabled when CONFIG_PCI_P2PDMA is set
and I don't know of any good solution to that. Please see the ACS
discussions in v1 and v2.

> It seems that we are going with the assumption that enabling this config
> option implies you want P2P, then we can simplify this code as well.

How so?

Logan
