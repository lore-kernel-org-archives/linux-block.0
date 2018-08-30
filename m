Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727200AbeH3XX7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Aug 2018 19:23:59 -0400
Date: Thu, 30 Aug 2018 15:20:12 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v5 00/13] Copy Offload in NVMe Fabrics with P2P PCI Memory
Message-ID: <20180830192012.GG3529@redhat.com>
References: <20180830185352.3369-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180830185352.3369-1-logang@deltatee.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 30, 2018 at 12:53:39PM -0600, Logan Gunthorpe wrote:

[...]

> 
> When the PCI P2PDMA config option is selected the ACS bits in every
> bridge port in the system are turned off to allow traffic to
> pass freely behind the root port. At this time, the bit must be disabled
> at boot so the IOMMU subsystem can correctly create the groups, though
> this could be addressed in the future. There is no way to dynamically
> disable the bit and alter the groups.

Can you provide an example on how to test this ? Like kernel command
line option, the doc patch does not have any such example. It would be
nice to add.

Maybe i have miss it in some of the patch. I just skimmed over for
now.

Cheers,
J�r�me
