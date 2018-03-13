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
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
Date: Tue, 13 Mar 2018 15:10:48 -0400
MIME-Version: 1.0
In-Reply-To: <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/13/2018 2:44 PM, Logan Gunthorpe wrote:
>> Do you think you can keep a pointer to the parent bridge instead of querying it
>> via get_upstream_bridge_port() here so that we can reuse your
>> pci_p2pdma_disable_acs() in the future.
> 
> Keep a pointer where? pci_p2pdma_disable_acs() and pci_p2pdma_add_client() are used in completely different cases on completely different devices. There really is no overlap and no obvious place to store the port pointer (except in the struct pci_dev itself, in which case why not just call the function again).

I was thinking of this for the pci_p2pdma_add_client() case for the
parent pointer.

+struct pci_p2pdma_client {
+	struct list_head list;
+	struct pci_dev *client;
+	struct pci_dev *provider;
+};

You are right second code seems to be there to disable ACS altogether
when this kernel configuration is selected.

It doesn't have any relationship to the client code.

But then, Why bother searching for the switch at all?

Even if the switch is there, there is no guarantee that it is currently
being used for P2P.

It seems that we are going with the assumption that enabling this config
option implies you want P2P, then we can simplify this code as well.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
